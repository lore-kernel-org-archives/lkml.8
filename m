Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C305EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A11720776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Pbvw0UoR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2VtiFOrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgE0Pve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:34 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:55929 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730614AbgE0Puw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 741E15820C8;
        Wed, 27 May 2020 11:50:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ksCkcoqtG+oCd
        Ubj+unmHTAeCdvETkjzHPBLqbjKV1g=; b=Pbvw0UoRqqDe9p7oC7exVLK4S2A70
        4HTSj+mlhe3bya/ONzIui/ij5tOYpwav4MYrHYSVd8cdt4ZTYcCJY31KJje3SCQk
        /Ptw+zvbnEUzZjStfFnAN9JET6uqqyx88CKjeIKtrIMUX2VzCDywgv/glikygaTd
        0iUk8ga1iAh2vhWEErIdjIKfBP9uh4orWWrgBJT9MkA2PlOppZx5MC66jTmaJ/IA
        cwuWvrG3ywwomxFNPEHrZYytMmJxmPZpNydjZF24li74ECOEwhUR30BZeZF9dqSV
        WbaYc6FG1/5DwWyCFAYA/mMrqXsVBHnw1VzhKTNVvibii70Lm4A2G3QaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ksCkcoqtG+oCdUbj+unmHTAeCdvETkjzHPBLqbjKV1g=; b=2VtiFOrr
        Ze+BfW1y76Tk3Ujwih88enytziNf6jPlf4pRaSexHUYsmzDHtvipb92OKXXNufGT
        TGMHOCIJPZ4ItBNXSwbkS0EaiAOkOQftu9CQvic1/I3hWl4cguW49BrUsM8hmJ+x
        AGquZcd8jR5xCUTwZT4EX+KWWosQeodJcrjctBll8zUDqtREZQHsx5KKe8l+RR+Y
        n9bly0VWL1XePy6HPVMTh5iBbP++vC0gHE91VIR+X83fkP4KfQ6O027aHaFaBl/h
        Oc/48sg8CGd6xh/5Sh8JUjJZdC8gfRCuW+nVay3+CwtvUW3Xwyyx6cZcq8tzGLdu
        XykG72KoEh6ivQ==
X-ME-Sender: <xms:W4zOXihrvOmzd5GxXxlZWfex4VTgJVdPAKkE_PSGhu-eQ93H6n9FOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepgedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:W4zOXjCsVY6PKCr3qdDBYkvqiGagRMad0c1Vm2ARSPcBODqjpSWe-g>
    <xmx:W4zOXqHIzeZ-U-uXXvCYrNTbTpoGcXOIOoYugZL2k3xuvKG-Q9UnqA>
    <xmx:W4zOXrR-Lv_2Z8DDk0aK36ma2GvL2PrdwxK1sC_2_gwICN0YYivPrg>
    <xmx:W4zOXmyiQsfHG-1cfhOL4FaxiVlEzVPv7BFNO5BKRLMPAQhjkx7J7Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 12A4230614FA;
        Wed, 27 May 2020 11:50:50 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 059/105] drm/vc4: crtc: Add BCM2711 pixelvalves
Date:   Wed, 27 May 2020 17:48:29 +0200
Message-Id: <eb489952ba212a84dbe3d369371c0ee75b9a2d3e.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 has 5 pixelvalves, so now that our driver is ready, let's add
support for them.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 84 ++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/vc4/vc4_regs.h |  6 +++-
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 9efd7cb25590..a577ed8f929f 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -229,6 +229,13 @@ static u32 vc4_get_fifo_full_level(struct vc4_crtc *vc4_crtc, u32 format)
 	case PV_CONTROL_FORMAT_24:
 	case PV_CONTROL_FORMAT_DSIV_24:
 	default:
+		/*
+		 * For some reason, the pixelvalve4 doesn't work with
+		 * the usual formula and will only work with 32.
+		 */
+		if (vc4_crtc->data->hvs_output == 5)
+			return 32;
+
 		return fifo_len_bytes - 3 * HVS_FIFO_LATENCY_PIX;
 	}
 }
@@ -237,9 +244,14 @@ static u32 vc4_crtc_get_fifo_full_level_bits(struct vc4_crtc *vc4_crtc,
 					     u32 format)
 {
 	u32 level = vc4_get_fifo_full_level(vc4_crtc, format);
+	u32 ret = 0;
 
-	return VC4_SET_FIELD(level & 0x3f,
-			     PV_CONTROL_FIFO_LEVEL);
+	if (level > 0x3f)
+		ret |= VC4_SET_FIELD((level >> 6) & 0x3,
+				     PV5_CONTROL_FIFO_LEVEL_HIGH);
+
+	return ret | VC4_SET_FIELD(level & 0x3f,
+				   PV_CONTROL_FIFO_LEVEL);
 }
 
 /*
@@ -277,6 +289,8 @@ static void vc4_crtc_pixelvalve_reset(struct drm_crtc *crtc)
 
 static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 {
+	struct drm_device *dev = crtc->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
 	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
@@ -356,6 +370,10 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 	if (is_dsi)
 		CRTC_WRITE(PV_HACT_ACT, mode->hdisplay * pixel_rep);
 
+	if (vc4->hvs->hvs5)
+		CRTC_WRITE(PV_MUX_CFG,
+			   VC4_SET_FIELD(8, PV_MUX_CFG_RGB_PIXEL_MUX_MODE));
+
 	CRTC_WRITE(PV_CONTROL, PV_CONTROL_FIFO_CLR |
 		   vc4_crtc_get_fifo_full_level_bits(vc4_crtc, format) |
 		   VC4_SET_FIELD(format, PV_CONTROL_FORMAT) |
@@ -904,10 +922,72 @@ static const struct vc4_crtc_data bcm2835_pv2_data = {
 	},
 };
 
+static const struct vc4_crtc_data bcm2711_pv0_data = {
+	.debugfs_name = "crtc0_regs",
+	.hvs_available_channels = BIT(0),
+	.hvs_output = 0,
+	.fifo_depth = 64,
+	.pixels_per_clock = 1,
+	.encoder_types = {
+		[0] = VC4_ENCODER_TYPE_DSI0,
+		[1] = VC4_ENCODER_TYPE_DPI,
+	},
+};
+
+static const struct vc4_crtc_data bcm2711_pv1_data = {
+	.debugfs_name = "crtc1_regs",
+	.hvs_available_channels = BIT(0) | BIT(1) | BIT(2),
+	.hvs_output = 3,
+	.fifo_depth = 64,
+	.pixels_per_clock = 1,
+	.encoder_types = {
+		[0] = VC4_ENCODER_TYPE_DSI1,
+		[1] = VC4_ENCODER_TYPE_SMI,
+	},
+};
+
+static const struct vc4_crtc_data bcm2711_pv2_data = {
+	.debugfs_name = "crtc2_regs",
+	.hvs_available_channels = BIT(0) | BIT(1) | BIT(2),
+	.hvs_output = 4,
+	.fifo_depth = 256,
+	.pixels_per_clock = 2,
+	.encoder_types = {
+		[0] = VC4_ENCODER_TYPE_HDMI0,
+	},
+};
+
+static const struct vc4_crtc_data bcm2711_pv3_data = {
+	.debugfs_name = "crtc3_regs",
+	.hvs_available_channels = BIT(1),
+	.hvs_output = 1,
+	.fifo_depth = 64,
+	.pixels_per_clock = 1,
+	.encoder_types = {
+		[0] = VC4_ENCODER_TYPE_VEC,
+	},
+};
+
+static const struct vc4_crtc_data bcm2711_pv4_data = {
+	.debugfs_name = "crtc4_regs",
+	.hvs_available_channels = BIT(0) | BIT(1) | BIT(2),
+	.hvs_output = 5,
+	.fifo_depth = 64,
+	.pixels_per_clock = 2,
+	.encoder_types = {
+		[0] = VC4_ENCODER_TYPE_HDMI1,
+	},
+};
+
 static const struct of_device_id vc4_crtc_dt_match[] = {
 	{ .compatible = "brcm,bcm2835-pixelvalve0", .data = &bcm2835_pv0_data },
 	{ .compatible = "brcm,bcm2835-pixelvalve1", .data = &bcm2835_pv1_data },
 	{ .compatible = "brcm,bcm2835-pixelvalve2", .data = &bcm2835_pv2_data },
+	{ .compatible = "brcm,bcm2711-pixelvalve0", .data = &bcm2711_pv0_data },
+	{ .compatible = "brcm,bcm2711-pixelvalve1", .data = &bcm2711_pv1_data },
+	{ .compatible = "brcm,bcm2711-pixelvalve2", .data = &bcm2711_pv2_data },
+	{ .compatible = "brcm,bcm2711-pixelvalve3", .data = &bcm2711_pv3_data },
+	{ .compatible = "brcm,bcm2711-pixelvalve4", .data = &bcm2711_pv4_data },
 	{}
 };
 
diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index b96ebbb1354b..35279b118d41 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -130,6 +130,8 @@
 #define V3D_ERRSTAT  0x00f20
 
 #define PV_CONTROL				0x00
+# define PV5_CONTROL_FIFO_LEVEL_HIGH_MASK	VC4_MASK(26, 25)
+# define PV5_CONTROL_FIFO_LEVEL_HIGH_SHIFT	25
 # define PV_CONTROL_FORMAT_MASK			VC4_MASK(23, 21)
 # define PV_CONTROL_FORMAT_SHIFT		21
 # define PV_CONTROL_FORMAT_24			0
@@ -209,6 +211,10 @@
 
 #define PV_HACT_ACT				0x30
 
+#define PV_MUX_CFG				0x34
+# define PV_MUX_CFG_RGB_PIXEL_MUX_MODE_MASK	VC4_MASK(5, 2)
+# define PV_MUX_CFG_RGB_PIXEL_MUX_MODE_SHIFT	2
+
 #define SCALER_CHANNELS_COUNT			3
 
 #define SCALER_DISPCTRL                         0x00000000
-- 
git-series 0.9.1
