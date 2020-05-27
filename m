Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501F2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205AF20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="it9smjAs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A2PFer2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390340AbgE0Pvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:39 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:35885 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730625AbgE0Pu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 805035820D0;
        Wed, 27 May 2020 11:50:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=AG0imKdXpvDEW
        /+ayBKOV07PF9mA9MrdFuKD2KRY2u4=; b=it9smjAseS5XPbspsDOk7iM0JZWak
        hwAjlQOtzAtOhH4BNgfPW680JQu1htMrJgWoh364RrT+Htg7qEMFWGjZrt0nTcw/
        +EtbwXtzwfjhKonzBHt4uF7JLo2WpHnMYPCwofWVzxZq77BULZq64zQEOf+DQplo
        +jWi2PCaLs8kjzKsHw3RSXbMyC0MSwS3J6vgcVQZujm+fAitSV1ZTrErTUKoPugx
        jaAcPVn1SJgf5DMsGX31ruML9eAWj5TBHNaZ5lbD0XnpyZu+DfwYnfUb4/z7zZG2
        Waq2rUU6tKp4GD3ysTSY/YMU4ILkDMiCpaelKQDnoeLeHokQNjprwqwSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=AG0imKdXpvDEW/+ayBKOV07PF9mA9MrdFuKD2KRY2u4=; b=A2PFer2g
        k0nDBpFpXquJT4+1eMJeZxfWjPLN90GetcdgFiPso0bAN80OXjDG6zhFq9kl5SvT
        H3LS2NLUq7P/QpJNAk/J7M/VulrC6GW4gl+rLvceL/5n3t8GxmdDI0g98MHBZ0QF
        yB5OGpGp+jEHMALW010cwDSjcg9AIIiX1yJ9kl6pqAa7VPQZJWAprBd7h5IcKcsg
        SSSwvcLw+WgW5T3Y/UJlR3vIbHZDf28t5ZHgVuPZd2NAWIUbZLmQBEfrGQQ9xzul
        KnkFqHJDi3vMJbzL4xeAzTJoFb282C3OS8zaxdhlMxd60ORkXScb9PE0zt6T+f0v
        f4D5Ws5bf0Cmyw==
X-ME-Sender: <xms:XozOXoq6OvZikPevf48CY7XTaFgMKh58ecQBCZ9hD9wC8_PxcI3FKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepgedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:XozOXuqEx4WJxoL0BRljFyqTWqUGfea9QZhRjsM3vx0uT9QjKgNxCQ>
    <xmx:XozOXtMrdqIvXlJn6XrEOugsqTYACSnf3fx0NxDUeEScRypCff9h1Q>
    <xmx:XozOXv6mF_2vfE0QSGJtQAxfkB1b5LvC-maemTJ3G3cvy9EESsYvtw>
    <xmx:XozOXqYdJHN_SuTq9AoN2ncuLqJr947ws3bnT5SA5piLbfhG0Bf4TA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2205630624E4;
        Wed, 27 May 2020 11:50:54 -0400 (EDT)
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
Subject: [PATCH v3 061/105] drm/vc4: crtc: Split CRTC data in two
Date:   Wed, 27 May 2020 17:48:31 +0200
Message-Id: <dec7e872442f5752cb4f8e274c45f47b5a9e3ae7.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vc4_crtc_data structure is currently storing data related to both the
general CRTC information needed by the rest of the vc4 driver (like HVS
output and available FIFOs) and some related to the pixelvalve attached to
that CRTC. Let's split this into two structures so that we can reuse the
CRTC part into the TXP later on.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 84 +++++++++++++++++++++--------------
 drivers/gpu/drm/vc4/vc4_drv.h  | 25 ++++++++--
 2 files changed, 74 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 4df8cc5387a0..f82e3b0e11bd 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -208,7 +208,9 @@ void vc4_crtc_destroy(struct drm_crtc *crtc)
 
 static u32 vc4_get_fifo_full_level(struct vc4_crtc *vc4_crtc, u32 format)
 {
-	u32 fifo_len_bytes = vc4_crtc->data->fifo_depth;
+	const struct vc4_crtc_data *crtc_data = vc4_crtc_to_vc4_crtc_data(vc4_crtc);
+	const struct vc4_pv_data *pv_data = vc4_crtc_to_vc4_pv_data(vc4_crtc);
+	u32 fifo_len_bytes = pv_data->fifo_depth;
 
 	/*
 	 * Pixels are pulled from the HVS if the number of bytes is
@@ -233,7 +235,7 @@ static u32 vc4_get_fifo_full_level(struct vc4_crtc *vc4_crtc, u32 format)
 		 * For some reason, the pixelvalve4 doesn't work with
 		 * the usual formula and will only work with 32.
 		 */
-		if (vc4_crtc->data->hvs_output == 5)
+		if (crtc_data->hvs_output == 5)
 			return 32;
 
 		return fifo_len_bytes - 3 * HVS_FIFO_LATENCY_PIX;
@@ -294,6 +296,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
 	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	const struct vc4_pv_data *pv_data = vc4_crtc_to_vc4_pv_data(vc4_crtc);
 	struct drm_crtc_state *state = crtc->state;
 	struct drm_display_mode *mode = &state->adjusted_mode;
 	bool interlace = mode->flags & DRM_MODE_FLAG_INTERLACE;
@@ -301,7 +304,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 	bool is_dsi = (vc4_encoder->type == VC4_ENCODER_TYPE_DSI0 ||
 		       vc4_encoder->type == VC4_ENCODER_TYPE_DSI1);
 	u32 format = is_dsi ? PV_CONTROL_FORMAT_DSIV_24 : PV_CONTROL_FORMAT_24;
-	u8 ppc = vc4_crtc->data->pixels_per_clock;
+	u8 ppc = pv_data->pixels_per_clock;
 	bool debug_dump_regs = false;
 
 	if (debug_dump_regs) {
@@ -885,9 +888,11 @@ static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
 	.get_scanout_position = vc4_crtc_get_scanout_position,
 };
 
-static const struct vc4_crtc_data bcm2835_pv0_data = {
-	.hvs_available_channels = BIT(0),
-	.hvs_output = 0,
+static const struct vc4_pv_data bcm2835_pv0_data = {
+	.base = {
+		.hvs_available_channels = BIT(0),
+		.hvs_output = 0,
+	},
 	.debugfs_name = "crtc0_regs",
 	.fifo_depth = 64,
 	.pixels_per_clock = 1,
@@ -897,9 +902,11 @@ static const struct vc4_crtc_data bcm2835_pv0_data = {
 	},
 };
 
-static const struct vc4_crtc_data bcm2835_pv1_data = {
-	.hvs_available_channels = BIT(2),
-	.hvs_output = 2,
+static const struct vc4_pv_data bcm2835_pv1_data = {
+	.base = {
+		.hvs_available_channels = BIT(2),
+		.hvs_output = 2,
+	},
 	.debugfs_name = "crtc1_regs",
 	.fifo_depth = 64,
 	.pixels_per_clock = 1,
@@ -909,9 +916,11 @@ static const struct vc4_crtc_data bcm2835_pv1_data = {
 	},
 };
 
-static const struct vc4_crtc_data bcm2835_pv2_data = {
-	.hvs_available_channels = BIT(1),
-	.hvs_output = 1,
+static const struct vc4_pv_data bcm2835_pv2_data = {
+	.base = {
+		.hvs_available_channels = BIT(1),
+		.hvs_output = 1,
+	},
 	.debugfs_name = "crtc2_regs",
 	.fifo_depth = 64,
 	.pixels_per_clock = 1,
@@ -921,10 +930,12 @@ static const struct vc4_crtc_data bcm2835_pv2_data = {
 	},
 };
 
-static const struct vc4_crtc_data bcm2711_pv0_data = {
+static const struct vc4_pv_data bcm2711_pv0_data = {
+	.base = {
+		.hvs_available_channels = BIT(0),
+		.hvs_output = 0,
+	},
 	.debugfs_name = "crtc0_regs",
-	.hvs_available_channels = BIT(0),
-	.hvs_output = 0,
 	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
@@ -933,10 +944,12 @@ static const struct vc4_crtc_data bcm2711_pv0_data = {
 	},
 };
 
-static const struct vc4_crtc_data bcm2711_pv1_data = {
+static const struct vc4_pv_data bcm2711_pv1_data = {
+	.base = {
+		.hvs_available_channels = BIT(0) | BIT(1) | BIT(2),
+		.hvs_output = 3,
+	},
 	.debugfs_name = "crtc1_regs",
-	.hvs_available_channels = BIT(0) | BIT(1) | BIT(2),
-	.hvs_output = 3,
 	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
@@ -945,10 +958,12 @@ static const struct vc4_crtc_data bcm2711_pv1_data = {
 	},
 };
 
-static const struct vc4_crtc_data bcm2711_pv2_data = {
+static const struct vc4_pv_data bcm2711_pv2_data = {
+	.base = {
+		.hvs_available_channels = BIT(0) | BIT(1) | BIT(2),
+		.hvs_output = 4,
+	},
 	.debugfs_name = "crtc2_regs",
-	.hvs_available_channels = BIT(0) | BIT(1) | BIT(2),
-	.hvs_output = 4,
 	.fifo_depth = 256,
 	.pixels_per_clock = 2,
 	.encoder_types = {
@@ -956,10 +971,12 @@ static const struct vc4_crtc_data bcm2711_pv2_data = {
 	},
 };
 
-static const struct vc4_crtc_data bcm2711_pv3_data = {
+static const struct vc4_pv_data bcm2711_pv3_data = {
+	.base = {
+		.hvs_available_channels = BIT(1),
+		.hvs_output = 1,
+	},
 	.debugfs_name = "crtc3_regs",
-	.hvs_available_channels = BIT(1),
-	.hvs_output = 1,
 	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
@@ -967,10 +984,12 @@ static const struct vc4_crtc_data bcm2711_pv3_data = {
 	},
 };
 
-static const struct vc4_crtc_data bcm2711_pv4_data = {
+static const struct vc4_pv_data bcm2711_pv4_data = {
+	.base = {
+		.hvs_available_channels = BIT(0) | BIT(1) | BIT(2),
+		.hvs_output = 5,
+	},
 	.debugfs_name = "crtc4_regs",
-	.hvs_available_channels = BIT(0) | BIT(1) | BIT(2),
-	.hvs_output = 5,
 	.fifo_depth = 64,
 	.pixels_per_clock = 2,
 	.encoder_types = {
@@ -994,8 +1013,9 @@ static void vc4_set_crtc_possible_masks(struct drm_device *drm,
 					struct drm_crtc *crtc)
 {
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
-	const struct vc4_crtc_data *crtc_data = vc4_crtc->data;
-	const enum vc4_encoder_type *encoder_types = crtc_data->encoder_types;
+	const struct vc4_crtc_data *crtc_data = vc4_crtc_to_vc4_crtc_data(vc4_crtc);
+	const struct vc4_pv_data *pv_data = vc4_crtc_to_vc4_pv_data(vc4_crtc);
+	const enum vc4_encoder_type *encoder_types = pv_data->encoder_types;
 	struct drm_encoder *encoder;
 
 	drm_for_each_encoder(encoder, drm) {
@@ -1010,7 +1030,7 @@ static void vc4_set_crtc_possible_masks(struct drm_device *drm,
 		}
 
 		vc4_encoder = to_vc4_encoder(encoder);
-		for (i = 0; i < ARRAY_SIZE(crtc_data->encoder_types); i++) {
+		for (i = 0; i < ARRAY_SIZE(pv_data->encoder_types); i++) {
 			if (vc4_encoder->type == encoder_types[i]) {
 				vc4_encoder->clock_select = i;
 				encoder->possible_crtcs |= drm_crtc_mask(crtc);
@@ -1025,7 +1045,7 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = dev_get_drvdata(master);
 	struct vc4_dev *vc4 = to_vc4_dev(drm);
-	const struct vc4_crtc_data *pv_data;
+	const struct vc4_pv_data *pv_data;
 	struct vc4_crtc *vc4_crtc;
 	struct drm_crtc *crtc;
 	struct drm_plane *primary_plane, *destroy_plane, *temp;
@@ -1039,7 +1059,7 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	pv_data = of_device_get_match_data(dev);
 	if (!pv_data)
 		return -ENODEV;
-	vc4_crtc->data = pv_data;
+	vc4_crtc->data = &pv_data->base;
 	vc4_crtc->pdev = pdev;
 
 	vc4_crtc->regs = vc4_ioremap_regs(pdev, 0);
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index da4d2391a4ba..ed09acbc5660 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -458,20 +458,25 @@ to_vc4_encoder(struct drm_encoder *encoder)
 }
 
 struct vc4_crtc_data {
-	/* Depth of the PixelValve FIFO in bytes */
-	unsigned int fifo_depth;
-
 	/* Which channels of the HVS can the output source from */
 	unsigned int hvs_available_channels;
 
 	/* Which output of the HVS this pixelvalve sources from. */
 	int hvs_output;
+};
+
+struct vc4_pv_data {
+	struct vc4_crtc_data	base;
+
+	/* Depth of the PixelValve FIFO in bytes */
+	unsigned int fifo_depth;
 
 	/* Number of pixels output per clock period */
 	u8 pixels_per_clock;
 
 	enum vc4_encoder_type encoder_types[4];
 	const char *debugfs_name;
+
 };
 
 struct vc4_crtc {
@@ -498,6 +503,20 @@ to_vc4_crtc(struct drm_crtc *crtc)
 	return (struct vc4_crtc *)crtc;
 }
 
+static inline const struct vc4_crtc_data *
+vc4_crtc_to_vc4_crtc_data(const struct vc4_crtc *crtc)
+{
+	return crtc->data;
+}
+
+static inline const struct vc4_pv_data *
+vc4_crtc_to_vc4_pv_data(const struct vc4_crtc *crtc)
+{
+	const struct vc4_crtc_data *data = vc4_crtc_to_vc4_crtc_data(crtc);
+
+	return container_of(data, struct vc4_pv_data, base);
+}
+
 struct vc4_crtc_state {
 	struct drm_crtc_state base;
 	/* Dlist area for this CRTC configuration. */
-- 
git-series 0.9.1
