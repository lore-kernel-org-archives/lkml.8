Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from hermes.aosc.io ([199.195.250.187]:58112 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbgCKQef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:34:35 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Ondrej Jirman <megous@megous.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 4/5] drm/sun4i: sun6i_mipi_dsi: fix horizontal timing calculation
Date: Thu, 12 Mar 2020 00:33:28 +0800
Message-Id: <20200311163329.221840-5-icenowy@aosc.io>
In-Reply-To: <20200311163329.221840-1-icenowy@aosc.io>
References: <20200311163329.221840-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The max() function call in horizontal timing calculation shouldn't pad a
length already subtracted with overhead to overhead, instead it should
only prevent the set timing to underflow.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 059939789730..5f2313c40328 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -555,7 +555,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 		 */
 #define HSA_PACKET_OVERHEAD	10
 		hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
-			  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
+			  (mode->hsync_end - mode->hsync_start) * Bpp) - HSA_PACKET_OVERHEAD;
 
 		/*
 		 * The backporch is set using a blanking packet (4
@@ -564,7 +564,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 		 */
 #define HBP_PACKET_OVERHEAD	6
 		hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
-			  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
+			  (mode->htotal - mode->hsync_end) * Bpp) - HBP_PACKET_OVERHEAD;
 
 		/*
 		 * The frontporch is set using a sync event (4 bytes)
@@ -574,7 +574,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 		 */
 #define HFP_PACKET_OVERHEAD	16
 		hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
-			  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
+			  (mode->hsync_start - mode->hdisplay) * Bpp) - HFP_PACKET_OVERHEAD;
 
 		/*
 		 * The blanking is set using a sync event (4 bytes)
@@ -583,8 +583,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 		 */
 #define HBLK_PACKET_OVERHEAD	10
 		hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
-			   (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp -
-			   HBLK_PACKET_OVERHEAD);
+			   (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp) -
+			   HBLK_PACKET_OVERHEAD;
 
 		/*
 		 * And I'm not entirely sure what vblk is about. The driver in
-- 
2.24.1

