Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DFEC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7570C206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="SoBEiTSI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IqVGLAla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgICIIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:08:32 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:41581 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728470AbgICIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 9F2DC773;
        Thu,  3 Sep 2020 04:03:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=FIXItR2+rN6Po
        qIWzBkkm6w0zlCYXCeOuQ053+Wf3+s=; b=SoBEiTSIBqbTTt/d4NaWmgW5IfOfH
        g+fAxkGidHiS2fFz6VQCfGWa2N5yjoxlE2qtf6zuEOm69Ohl2u4yiHZyggxTSozP
        pSbLt6aNtCNWodyWcFT8kzW+9ZvMRhh2aWwa7HtFvHm2hbjtibXZWIfu4iAomhOi
        1uGSGE0tSY3Gq05Gy9ifyL4hUw1h73TipuavHHCMGcPw8Xzo7Ye4lUUBWwZzskXL
        is6pvLhkhuEvXWPzRVRJwpch8ggZFraJSay6XMgeIp4e1fUjyX4Xk19TnJAiK/Gn
        0jWMTC2pgl7/wmVHrYQdAHQhp0Pu5utpzXtHFb5OSJhmLTFhcQcxgwnwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=FIXItR2+rN6PoqIWzBkkm6w0zlCYXCeOuQ053+Wf3+s=; b=IqVGLAla
        Ys/6HjThFTpj2L7C3xt1D2dTrfvyPm4eSQnzTkK+VGkkl66ablFRm6S94cxikY+z
        jdyNv5kXtO2SKEERIpcuCvmf1o/Z1u5+6gH2Qmji+Ipi8u7skztsmCLifQYnnMq1
        cZp0koWpCm+/rFkOEZFYo0Rz4uxMr4/8X4EQc8RnXS0YFPgUqFCwd0HZAsOQHs2a
        xVchfFqZATOxH8F+0yL7PWwC4pbrKL7WCTTs7dD+DK/hcZ0btW4u0ETpzyCZX8CC
        L5wiYNqQJTdiCvqdJinpTOLvu7dCziFO59+mbL57yRogGoMI/dMiYWuhHWW85/md
        Ihslo8rMTRDJ2A==
X-ME-Sender: <xms:QaNQX7ZEEH4yvLUvLZRjH0ZzymHFI_6QIrORO1A8gaRRM4Xdqz8lJw>
    <xme:QaNQX6bhZr6weyX9e97rDYxb7KVo99spU2UKUkdfZctlJ1EtclCrAqI1ztN3lFbch
    8ibB83a6YOIsXTp0b0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeegle
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:QaNQX9-P8XAQyvbyPXEVRDc_0JZgdTWGAwhXBWrKMGdtKAkRWQFGFQ>
    <xmx:QaNQXxoIlGZbMtiJwGlka09e6mWs38JMGeqT-1Gh8weW_yZw5-_MJQ>
    <xmx:QaNQX2qTiuy_Ak1o4saPJoSr8B1FxC2zwrS2ex3Vnw6-DOk65hjT-w>
    <xmx:QaNQXzS0ltL3f6skPr-BdGej7OURR_qOGkoTwcIe3WEhBAIHOxGikVBemjg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EB57D328005E;
        Thu,  3 Sep 2020 04:03:12 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 56/80] drm/vc4: hdmi: Add a set_timings callback
Date:   Thu,  3 Sep 2020 10:01:28 +0200
Message-Id: <0cfcbb379212f90b4abc76c0ccf3b90d1d7c0268.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to the previous patches, the timings setup in the HDMI controller
of the BCM2711 is slightly different, mostly because it supports higher
resolutions and thus needed more spaces for the various timings, resulting
in the register layout changing.

Let's add a callback for that as well.

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 72 +++++++++++++++++++----------------
 drivers/gpu/drm/vc4/vc4_hdmi.h |  4 ++-
 2 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 532618e02399..9e2bc6cb690e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -369,12 +369,9 @@ static void vc4_hdmi_csc_setup(struct vc4_hdmi *vc4_hdmi, bool enable)
 	HDMI_WRITE(HDMI_CSC_CTL, csc_ctl);
 }
 
-static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
+static void vc4_hdmi_set_timings(struct vc4_hdmi *vc4_hdmi,
+				 struct drm_display_mode *mode)
 {
-	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
-	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
-	struct vc4_hdmi_encoder *vc4_encoder = &vc4_hdmi->encoder;
-	bool debug_dump_regs = false;
 	bool hsync_pos = mode->flags & DRM_MODE_FLAG_PHSYNC;
 	bool vsync_pos = mode->flags & DRM_MODE_FLAG_PVSYNC;
 	bool interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE;
@@ -392,6 +389,41 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 					mode->crtc_vsync_end -
 					interlaced,
 					VC4_HDMI_VERTB_VBP));
+
+	HDMI_WRITE(HDMI_HORZA,
+		   (vsync_pos ? VC4_HDMI_HORZA_VPOS : 0) |
+		   (hsync_pos ? VC4_HDMI_HORZA_HPOS : 0) |
+		   VC4_SET_FIELD(mode->hdisplay * pixel_rep,
+				 VC4_HDMI_HORZA_HAP));
+
+	HDMI_WRITE(HDMI_HORZB,
+		   VC4_SET_FIELD((mode->htotal -
+				  mode->hsync_end) * pixel_rep,
+				 VC4_HDMI_HORZB_HBP) |
+		   VC4_SET_FIELD((mode->hsync_end -
+				  mode->hsync_start) * pixel_rep,
+				 VC4_HDMI_HORZB_HSP) |
+		   VC4_SET_FIELD((mode->hsync_start -
+				  mode->hdisplay) * pixel_rep,
+				 VC4_HDMI_HORZB_HFP));
+
+	HDMI_WRITE(HDMI_VERTA0, verta);
+	HDMI_WRITE(HDMI_VERTA1, verta);
+
+	HDMI_WRITE(HDMI_VERTB0, vertb_even);
+	HDMI_WRITE(HDMI_VERTB1, vertb);
+
+	HDMI_WRITE(HDMI_VID_CTL,
+		   (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
+		   (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
+}
+
+static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
+{
+	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
+	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
+	struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
+	bool debug_dump_regs = false;
 	int ret;
 
 	ret = pm_runtime_get_sync(&vc4_hdmi->pdev->dev);
@@ -435,33 +467,8 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 		   VC4_HDMI_SCHEDULER_CONTROL_MANUAL_FORMAT |
 		   VC4_HDMI_SCHEDULER_CONTROL_IGNORE_VSYNC_PREDICTS);
 
-	HDMI_WRITE(HDMI_HORZA,
-		   (vsync_pos ? VC4_HDMI_HORZA_VPOS : 0) |
-		   (hsync_pos ? VC4_HDMI_HORZA_HPOS : 0) |
-		   VC4_SET_FIELD(mode->hdisplay * pixel_rep,
-				 VC4_HDMI_HORZA_HAP));
-
-	HDMI_WRITE(HDMI_HORZB,
-		   VC4_SET_FIELD((mode->htotal -
-				  mode->hsync_end) * pixel_rep,
-				 VC4_HDMI_HORZB_HBP) |
-		   VC4_SET_FIELD((mode->hsync_end -
-				  mode->hsync_start) * pixel_rep,
-				 VC4_HDMI_HORZB_HSP) |
-		   VC4_SET_FIELD((mode->hsync_start -
-				  mode->hdisplay) * pixel_rep,
-				 VC4_HDMI_HORZB_HFP));
-
-	HDMI_WRITE(HDMI_VERTA0, verta);
-	HDMI_WRITE(HDMI_VERTA1, verta);
-
-	HDMI_WRITE(HDMI_VERTB0, vertb_even);
-	HDMI_WRITE(HDMI_VERTB1, vertb);
-
-	HDMI_WRITE(HDMI_VID_CTL,
-		   (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
-		   (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
-
+	if (vc4_hdmi->variant->set_timings)
+		vc4_hdmi->variant->set_timings(vc4_hdmi, mode);
 
 	if (vc4_encoder->hdmi_monitor &&
 	    drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED) {
@@ -1445,6 +1452,7 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
 	.init_resources		= vc4_hdmi_init_resources,
 	.csc_setup		= vc4_hdmi_csc_setup,
 	.reset			= vc4_hdmi_reset,
+	.set_timings		= vc4_hdmi_set_timings,
 	.phy_init		= vc4_hdmi_phy_init,
 	.phy_disable		= vc4_hdmi_phy_disable,
 	.phy_rng_enable		= vc4_hdmi_phy_rng_enable,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index c8fd58548ea2..0c32dc46d289 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -44,6 +44,10 @@ struct vc4_hdmi_variant {
 	/* Callback to enable / disable the CSC */
 	void (*csc_setup)(struct vc4_hdmi *vc4_hdmi, bool enable);
 
+	/* Callback to configure the video timings in the HDMI block */
+	void (*set_timings)(struct vc4_hdmi *vc4_hdmi,
+			    struct drm_display_mode *mode);
+
 	/* Callback to initialize the PHY according to the mode */
 	void (*phy_init)(struct vc4_hdmi *vc4_hdmi,
 			 struct drm_display_mode *mode);
-- 
git-series 0.9.1
