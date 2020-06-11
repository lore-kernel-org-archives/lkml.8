Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E6CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85AEE20760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="bJO88Mhk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FLUe7bXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgFKNik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:38:40 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:43879 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbgFKNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:38:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 04B7D5801C2;
        Thu, 11 Jun 2020 09:38:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 09:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=/x2R+hnKYf6lA
        uvOCeP3/oM56Wti4MpAKaZR+DOQ1QM=; b=bJO88MhkwanQKPmtDze1Crnrm3wrq
        ryJMGPU7Dmqz0ThqokOYWjjbP0K3JNx/afHmFDq2l0yzuZGD0pisW8dGNdh/vbbB
        F/tyDT2sZBKhUPTfbWCmUSOT+bN4fcfRyGHw2fhzLlOmp1lSIpfLytShKDCN+9hG
        dbK1ewFG1LOyclGNPb2zPKSX65RWBkySw8TMcnwuRJnJSUNKelZA4B1RjGK5I3Aj
        cFNYAnkslXbkfaIaST6Bf/omLjLHZADIKYtpFKfQ32OriAyklP7B4Yd+whHoCf5k
        Q6KOHPIyanaa5jtLD/EWx/lqdRrmBGNNrtFAWbiCIQxxafFLQ2t95ZHlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=/x2R+hnKYf6lAuvOCeP3/oM56Wti4MpAKaZR+DOQ1QM=; b=FLUe7bXF
        DiZLTRNvg3zqhbbGdHqkZC4bYU6N3rF+TxCtd3bGXWuh4jTVQ0oVMXAA7LujOrcR
        D91wTECueAGAQ/A+TjZNq3FPQCn22/5VXqjCalB1TOGfPGVEyjTXydxgc2T83P86
        pr3CvJIWypGM6rrXWKIMIRnb4Bm9USOH2Wm3Zj0/KvBRQFP5Fgyf79X4HxPHNJnQ
        3sxRseSsSMV6ySD3DVuc8rbW9pl2SkfouW0xsZ1M9FAQ8OlKKHFY6MhDFUmw0sqk
        3GU399uOWGLfWcf3DWltg6x7lExNeD+dqcFWzPWrMU7BGJzwWrOF6ZRSiGDVKOAw
        1pf2JkG5gwwU3A==
X-ME-Sender: <xms:3TPiXlBx4BR2bTAAcqqhMoQGEkLc-0ZmWiv0LWsnfmJqpKQHpow6SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:3TPiXjg7FKckM7V44tqhaW-vRU0VTf_LYEbvdaKUE3IWn86UJpvAqQ>
    <xmx:3TPiXgnf0W9q7zqglqhM33Zuur8TiXPlRUUUNZnLGVipAc8feGrhtg>
    <xmx:3TPiXvx47dkgbeYjmPZNxddVPnovLf3La7pPkn3D2LI3zAjBBDjYvg>
    <xmx:3jPiXnQDY1zbC4UTRgdx6CBKqRZTKPsw0f769vweX0zUKRMn9IWayA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E3A0C3066696;
        Thu, 11 Jun 2020 09:37:05 -0400 (EDT)
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
Subject: [PATCH v4 4/9] drm/vc4: crtc: Split CRTC data in two
Date:   Thu, 11 Jun 2020 15:36:49 +0200
Message-Id: <8eb317c91ac208d7f926d76ad421002fa0364c47.1591882579.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.c33f5fd8b1b2703081f25398eb879937c9f7ce0b.1591882579.git-series.maxime@cerno.tech>
References: <cover.c33f5fd8b1b2703081f25398eb879937c9f7ce0b.1591882579.git-series.maxime@cerno.tech>
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

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 29 ++++++++++++++++++-----------
 drivers/gpu/drm/vc4/vc4_drv.h  | 19 +++++++++++++++++++
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 6e71bc13e339..6f1a1062db8f 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -780,8 +780,10 @@ static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
 	.get_scanout_position = vc4_crtc_get_scanout_position,
 };
 
-static const struct vc4_crtc_data bcm2835_pv0_data = {
-	.hvs_channel = 0,
+static const struct vc4_pv_data bcm2835_pv0_data = {
+	.base = {
+		.hvs_channel = 0,
+	},
 	.debugfs_name = "crtc0_regs",
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI0,
@@ -789,8 +791,10 @@ static const struct vc4_crtc_data bcm2835_pv0_data = {
 	},
 };
 
-static const struct vc4_crtc_data bcm2835_pv1_data = {
-	.hvs_channel = 2,
+static const struct vc4_pv_data bcm2835_pv1_data = {
+	.base = {
+		.hvs_channel = 2,
+	},
 	.debugfs_name = "crtc1_regs",
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI1,
@@ -798,8 +802,10 @@ static const struct vc4_crtc_data bcm2835_pv1_data = {
 	},
 };
 
-static const struct vc4_crtc_data bcm2835_pv2_data = {
-	.hvs_channel = 1,
+static const struct vc4_pv_data bcm2835_pv2_data = {
+	.base = {
+		.hvs_channel = 1,
+	},
 	.debugfs_name = "crtc2_regs",
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_HDMI,
@@ -818,8 +824,9 @@ static void vc4_set_crtc_possible_masks(struct drm_device *drm,
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
@@ -834,7 +841,7 @@ static void vc4_set_crtc_possible_masks(struct drm_device *drm,
 		}
 
 		vc4_encoder = to_vc4_encoder(encoder);
-		for (i = 0; i < ARRAY_SIZE(crtc_data->encoder_types); i++) {
+		for (i = 0; i < ARRAY_SIZE(pv_data->encoder_types); i++) {
 			if (vc4_encoder->type == encoder_types[i]) {
 				vc4_encoder->clock_select = i;
 				encoder->possible_crtcs |= drm_crtc_mask(crtc);
@@ -864,7 +871,7 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = dev_get_drvdata(master);
-	const struct vc4_crtc_data *pv_data;
+	const struct vc4_pv_data *pv_data;
 	struct vc4_crtc *vc4_crtc;
 	struct drm_crtc *crtc;
 	struct drm_plane *primary_plane, *destroy_plane, *temp;
@@ -878,7 +885,7 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	pv_data = of_device_get_match_data(dev);
 	if (!pv_data)
 		return -ENODEV;
-	vc4_crtc->data = pv_data;
+	vc4_crtc->data = &pv_data->base;
 	vc4_crtc->pdev = pdev;
 
 	vc4_crtc->regs = vc4_ioremap_regs(pdev, 0);
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index c4873ae84231..6587bc09b2cd 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -443,9 +443,14 @@ to_vc4_encoder(struct drm_encoder *encoder)
 struct vc4_crtc_data {
 	/* Which channel of the HVS this pixelvalve sources from. */
 	int hvs_channel;
+};
+
+struct vc4_pv_data {
+	struct vc4_crtc_data	base;
 
 	enum vc4_encoder_type encoder_types[4];
 	const char *debugfs_name;
+
 };
 
 struct vc4_crtc {
@@ -477,6 +482,20 @@ to_vc4_crtc(struct drm_crtc *crtc)
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
