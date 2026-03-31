export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const isHtmlRequest =
      request.method === "GET" &&
      (url.pathname === "/" || url.pathname.endsWith(".html"));

    if (!isHtmlRequest) {
      return env.ASSETS.fetch(request);
    }

    const assetRes = await env.ASSETS.fetch(request);
    const contentType = assetRes.headers.get("content-type") || "";
    if (!contentType.includes("text/html")) {
      return assetRes;
    }

    const html = await assetRes.text();
    const envScript = `<script>window.__ENV = {SUPABASE_URL: ${JSON.stringify(env.SUPABASE_URL || "")}, SUPABASE_KEY: ${JSON.stringify(env.SUPABASE_KEY || "")}};</script>`;
    const injected = html.includes("</head>")
      ? html.replace("</head>", `${envScript}\n</head>`)
      : `${envScript}\n${html}`;

    const headers = new Headers(assetRes.headers);
    headers.set("content-type", "text/html; charset=utf-8");
    headers.set("x-content-type-options", "nosniff");
    headers.set("x-frame-options", "DENY");
    headers.set("referrer-policy", "strict-origin-when-cross-origin");

    return new Response(injected, {
      status: assetRes.status,
      headers
    });
  }
};
