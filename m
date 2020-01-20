Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E27C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812392073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgATIB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:01:58 -0500
Received: from mout.perfora.net ([74.208.4.197]:36105 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgATIB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:01:57 -0500
Received: from marcel-nb-toradex-int.toradex.int ([31.10.206.124]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0Ma46L-1jCLDy1EsB-00Lp2H; Mon, 20 Jan 2020 09:01:13 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, info@logictechno.com,
        j.bauer@endrich.com, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v4 3/3] drm/panel: simple: add display timings for logic technologies displays
Date:   Mon, 20 Jan 2020 09:01:00 +0100
Message-Id: <20200120080100.170294-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120080100.170294-1-marcel@ziswiler.com>
References: <20200120080100.170294-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:anI6rwLomoZdt5T5jBL59aV9NQScit0zPIbdt/SagbVH1Gala22
 j+W2jRkUjmcptZDJwQ57IQS6Z6wWSGXjVbvOtb/XqVE23fdMiywzHNUxaDQh43ZGRxZ3NIW
 ZV2ryo/9Ln3um+V+FXj+jpePnDWkrJ7cZMYez+UmxDt6i3nRfp8JooFqbfc9URLUaY5qsBG
 TGPnZdWfOqvnQIqoUfiUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wsN8s4dxJzk=:nTvDYien5G49OQ8P021V0L
 wtbCUrqEbUU3GoqHgMr1pa49CaIDT26aWsFKQCQo9N/qTczcOUDBEhtxHIpNrqO3TNe5Sj6qS
 A31cnoHf7ohYuBntgUeBmY1pftnRP/vhbIaXBzXUvQRTGkRuhxfjSP6ZNlYccBk7Eh1L0XoQC
 zZ7H5UWcH+8UoOpnwq3A2GUbOzHp1Ui0HrS1Tu3se1BByv/Z8rr4U2g+fiQZrGlFdNYOn3kK7
 OOFS2lMRMI3/PycO+Hl74lYs9ECctDWtA7YwHpSBac65KSnv61zo7DF+uiagjz69PhTuGcFX0
 +cRlxLrTVGppqLbyeofx1CQWO5NHum0oz6Amijka63a/egATDzivKmkfR0Y7OHfFerty7unDk
 Qkyk58VoRTX2ZRzw+K/KVTbsF5nB5ZT4Ey3lbdgxouhPPn+ofx7ah9FyQ/+n4SAJkuauyBrGX
 HLcX/cSB03vZIJ4dWhEibILqwdXInfCMOBcx/JTXuF84LNf/0TeEEHDvwTarnoATQIlnn25s3
 c+f0FXxMhmCl2lCEIfZwK6LR+sQ3o4enjQrigMZNcAhFVR+qYTUB0q++bGqor3r0ygQ8VY6AV
 +ac/CvAnMpOus/BBw5NhrSwJvKpA3m5z9rjpVtlqxrFegfT/U5ZHVdeiwww3IsvPBj/noXfhN
 DohfL19afL7LuMA6/Vq8gWICP3M8cBBF014He4W6P2DWv4xHKiTaBQ94dQ3RP+BSS+9JLkDlv
 d5KiNDesnB/18CwwSLmiMBjR/OtigoW05HoNIJ4twAnaaLdFD66T7Fli9q1XOkM05PHL3F65k
 nT679afWJxp4sjNsQO+dCypv0sGROKF+KusQjl80O8Vo65Bv2trtSGqxoVw4Rtq+htn9tEudV
 hsTSpvbnh+lGmzaKcP1g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add display timings for the following 3 display panels manufactured by
Logic Technologies Limited:

- LT161010-2NHC e.g. as found in the Toradex Capacitive Touch Display
  7" Parallel [1]
- LT161010-2NHR e.g. as found in the Toradex Resistive Touch Display 7"
  Parallel [2]
- LT170410-2WHC e.g. as found in the Toradex Capacitive Touch Display
  10.1" LVDS [3]

Those panels may also be distributed by Endrich Bauelemente Vertriebs
GmbH [4].

[1] https://docs.toradex.com/104497-7-inch-parallel-capacitive-touch-display-800x480-datasheet.pdf
[2] https://docs.toradex.com/104498-7-inch-parallel-resistive-touch-display-800x480.pdf
[3] https://docs.toradex.com/105952-10-1-inch-lvds-capacitive-touch-display-1280x800-datasheet.pdf
[4] https://www.endrich.com/isi50_isi30_tft-displays/lt170410-1whc_isi30

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v4:
- Added recently made mandatory connector_type information as pointed
  out by Sam.

Changes in v3:
- Fix typo in pixelclock frequency for lt170410_2whc as recently
  discovered by Philippe.

Changes in v2:
- Added Philippe's reviewed-by.

 drivers/gpu/drm/panel/panel-simple.c | 67 ++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index d6f77bc494c7..a0dd84e11db7 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2107,6 +2107,64 @@ static const struct panel_desc lg_lp129qe = {
 	},
 };
 
+static const struct display_timing logictechno_lt161010_2nh_timing = {
+	.pixelclock = { 26400000, 33300000, 46800000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 16, 210, 354 },
+	.hback_porch = { 46, 46, 46 },
+	.hsync_len = { 1, 20, 40 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 7, 22, 147 },
+	.vback_porch = { 23, 23, 23 },
+	.vsync_len = { 1, 10, 20 },
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
+		 DISPLAY_FLAGS_SYNC_POSEDGE,
+};
+
+static const struct panel_desc logictechno_lt161010_2nh = {
+	.timings = &logictechno_lt161010_2nh_timing,
+	.num_timings = 1,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
+		     DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
+static const struct display_timing logictechno_lt170410_2whc_timing = {
+	.pixelclock = { 68900000, 71100000, 73400000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 23, 60, 71 },
+	.hback_porch = { 23, 60, 71 },
+	.hsync_len = { 15, 40, 47 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 5, 7, 10 },
+	.vback_porch = { 5, 7, 10 },
+	.vsync_len = { 6, 9, 12 },
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
+		 DISPLAY_FLAGS_SYNC_POSEDGE,
+};
+
+static const struct panel_desc logictechno_lt170410_2whc = {
+	.timings = &logictechno_lt170410_2whc_timing,
+	.num_timings = 1,
+	.size = {
+		.width = 217,
+		.height = 136,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
+		     DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode mitsubishi_aa070mc01_mode = {
 	.clock = 30400,
 	.hdisplay = 800,
@@ -3417,6 +3475,15 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "logicpd,type28",
 		.data = &logicpd_type_28,
+	}, {
+		.compatible = "logictechno,lt161010-2nhc",
+		.data = &logictechno_lt161010_2nh,
+	}, {
+		.compatible = "logictechno,lt161010-2nhr",
+		.data = &logictechno_lt161010_2nh,
+	}, {
+		.compatible = "logictechno,lt170410-2whc",
+		.data = &logictechno_lt170410_2whc,
 	}, {
 		.compatible = "mitsubishi,aa070mc01-ca1",
 		.data = &mitsubishi_aa070mc01,
-- 
2.24.1

