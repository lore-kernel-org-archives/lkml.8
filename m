Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005AEC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D339C2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgASWCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 17:02:44 -0500
Received: from mout.perfora.net ([74.208.4.196]:41549 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgASWCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:02:43 -0500
Received: from marcel-nb-toradex-int.cardiotech.int ([81.221.128.11]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MGPxO-1iouvO0W2q-00DEly; Sun, 19 Jan 2020 23:02:14 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     info@logictechno.com, Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        j.bauer@endrich.com, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v3 2/3] drm/panel: simple: add display timings for logic technologies displays
Date:   Sun, 19 Jan 2020 23:02:03 +0100
Message-Id: <20200119220204.208751-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119220204.208751-1-marcel@ziswiler.com>
References: <20200119220204.208751-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SMhSpbvcz90BWaHBskqOXUIdjY5Ac7hasdlluofZjOmZ1CPrzmk
 R1tFS39mtOojKZSQhoKlSbqhdsnbf05frf140f+st3bHTkpt9wbu+f1UGNQz/VZmkqkSfd9
 KmmS2CBPTjlo6UK+HLLrZvcSmBFrBFAJoHPTBdWKl5Kj0rwCcYaKdwjZ5ClMkePcFLCnqGT
 63R4sEdrqXqaO9rKoIexA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yQE2A6H9RDs=:Tx1wmI1x7VwJC3xs/cqJHl
 E7yiXV2I6kT0kp/F6pBOCKSB7HRNTxZPa7h1WMqsRBzT4epFA1Sg6A5ZRFf3KcQo7B+kI9kjG
 9BBYCnrqfZcpldsRVTdoseiK0XIhlvADfWeJn6bwG3BR4ScK775dG460b7d44fSdRMVlXTrcz
 6O6b3W3a4qy0kGnjo1FXvutnCOmjl6o6aE3nBHgkyuvdM47WI+YpLP1BvDXzBDE8JN67MlLK1
 pcFfefRKYVSjPivG8cilsZMlBsc6JlOQUL2SYweuKF7bGHACBC2w2OfM5xAIsKFOSYEliI8aE
 r6MGDK3ublxqZd3gYgyqf22xpeJ+JHuARgmbbjz5kp6uqZcTqXJQaGaMCW/rO8ZYmXS0W8snX
 SFpbnb60L2Nv16qV75RYIUvmVQfZxhbdMKR0STlG1PjyB3cLETG1SyEyyeE10XuCqKTxR7uvU
 TV0n61HePOLo8GoPMGLJT3G+sPnxAbQmnlBD4cH1OWszpVtmtjBDoMigx/8zCDs+queSsEyHQ
 R35phdysVx2HBgcdpQZ5gGGZDurmJDSANky5YULf+hFJYHl3YuOonlTTOVkEuGjcrMh/a7h73
 K8an+MSz+lK0fMTVgDvzNhNpHUv2CmEXKWW7yG1zxG42590yo6QhVbHnfwTgPT3eXMcFQky2M
 BbkbHU8jp0NQz3zWXwEdwG/CLQU3wUx2ZIZ+YwuDy5W2PJhW0yFOebDtav8RRVrpOyuw/gTxy
 m12+8cYYo6vYSQ1zSgU9ebGgY0mQ90DkYaho93LDNGblLFPbKgu2dBAVM8pMD033iqcxTSCM3
 f8CzGw6vn3yck+GJv6j8nK1FCPEazPtZGsR8tON88APEQOyvEdfaDxxILi3ePFzde1UKLoYQl
 dHER0cDt3Zo1D9y6AC0g==
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

Changes in v3:
- Fix typo in pixelclock frequency for lt170410_2whc as recently
  discovered by Philippe.

Changes in v2:
- Added Philippe's reviewed-by.

 drivers/gpu/drm/panel/panel-simple.c | 65 ++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index d6f77bc494c7..4140e0faff06 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2107,6 +2107,62 @@ static const struct panel_desc lg_lp129qe = {
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
+};
+
 static const struct drm_display_mode mitsubishi_aa070mc01_mode = {
 	.clock = 30400,
 	.hdisplay = 800,
@@ -3417,6 +3473,15 @@ static const struct of_device_id platform_of_match[] = {
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

