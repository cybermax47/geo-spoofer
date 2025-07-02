const puppeteer = require('puppeteer');
require('dotenv').config({ path: __dirname + '/.env' });

(async () => {
    const latitude = parseFloat(process.env.SPOOF_LAT || "40.7128");
    const longitude = parseFloat(process.env.SPOOF_LNG || "-74.0060");

    const browser = await puppeteer.launch({
        headless: true,
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
            '--disable-webrtc',
            '--force-webrtc-ip-handling-policy=disable_non_proxied_udp'
        ]
    });

    const page = await browser.newPage();
    await browser.defaultBrowserContext().overridePermissions('https://example.com', ['geolocation']);
    await page.setGeolocation({ latitude, longitude });

    console.log(`[+] Browser spoofing location to ${latitude}, ${longitude}`);
    await page.goto('https://example.com');
    await new Promise(() => {});  // Keep running
})();
