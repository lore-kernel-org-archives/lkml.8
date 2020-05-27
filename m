Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB850C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29D820873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="rcQNup5j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FGZHADj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390708AbgE0P4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:56:33 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:36569 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390223AbgE0PuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D6B79582063;
        Wed, 27 May 2020 11:50:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=5LdLUQabqGwWb
        iAk4R0m424dN93YdWZ308LsyWjEzJ4=; b=rcQNup5j+9gf+s2I8Zo4FY5IAxew3
        WtyIYJgDAOHFpPj6shWMDxMiGWHlplDGUPbZ3Z0lBCb+7FkMXa+75hK4T1hk0c1U
        PJhP2LDXQ6wdH/95oro0kjUhpDE2+t3g8TcunMqESLowDqOVc38/b+u06VIzsX52
        DPfnUZ9clFtj2choArX6P1cACe8k0yO0U56to21g98eSPGKe511bNyKMNhlHUsEH
        UOhn0IZFujc9nJsKc/oAa1y5GJzv1JuSWccCz58OGJBOnGi3g+Jqu7vYU2CP9cIk
        DuT0V5f9BoO9v5mj2QDRhhGun9T30lSjPrMqPbp/QC1CwmpDtApwohW4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=5LdLUQabqGwWbiAk4R0m424dN93YdWZ308LsyWjEzJ4=; b=FGZHADj/
        YaCs+l0nB69zXfgZypqcEWcI0VQg9K44ELWQkelB2dYAIRhMWcH/wrzJKZXQUzAl
        QE1LMyE75gmwADZCr/4yofwklF05S01NOuYAwgiW19e8TmfeBsNMnc5xVqYF5pu3
        0WdxteK1OT71o4FVOP2fu4mRf2uxocTDoNldK+mcXR3LdLwjGxWc2xM9YlZ4Gx7H
        IZXEPux9m5KuMDjte6vSSji1qNsfmx7e5jC/4TnNyCboITE9QSbR9aiDh0CQKrdQ
        nvuPbmjrNf6eiOZsGnJ+E4romHVG4AzioTFesvDrlCO/8N1LRudcct/CVsQNArq7
        aqy1BUlELabAXQ==
X-ME-Sender: <xms:M4zOXmKEksacRhu0T2f_-atKZJfNZY4SWjdiTRXxcRDdeX0KcWBL_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:M4zOXuKFoH0YWf74QoYg5Wpo7kaPwa9UuV2KJwQV44ZNwdHwOLXaqw>
    <xmx:M4zOXmtlWhUV8-3BssCgObReUHpoTkmsC1iNe0OTCl3ZSuntsjC1qA>
    <xmx:M4zOXra8Ity52vDLDgOq5OmMAw1kGaDHjeWJ3Xl_ZSiJdfG2nEIVYg>
    <xmx:M4zOXp5Mn4OfxWXjvVwvlj4ZPWUD0WcioFiMjxxEbssnXPx-lFT6TQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 783F93280064;
        Wed, 27 May 2020 11:50:11 -0400 (EDT)
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
Subject: [PATCH v3 034/105] drm/vc4: crtc: Add FIFO depth to vc4_crtc_data
Date:   Wed, 27 May 2020 17:48:04 +0200
Message-Id: <a213ce2bc6a4147506ce61f70dc2e388db54021c.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all pixelvalve FIFOs in vc5 have the same depth, so we need to add that
to our vc4_crtc_data structure to be able to compute the fill level
properly later on.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 19 ++++++++++++++++---
 drivers/gpu/drm/vc4/vc4_drv.h  |  3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index a6c3f2f907bd..e25e81bf64e7 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -248,10 +248,20 @@ vc4_crtc_update_gamma_lut(struct drm_crtc *crtc)
 	vc4_crtc_lut_load(crtc);
 }
 
-static u32 vc4_get_fifo_full_level(u32 format)
+static u32 vc4_get_fifo_full_level(struct vc4_crtc *vc4_crtc, u32 format)
 {
-	static const u32 fifo_len_bytes = 64;
+	u32 fifo_len_bytes = vc4_crtc->data->fifo_depth;
 
+	/*
+	 * Pixels are pulled from the HVS if the number of bytes is
+	 * lower than the FIFO full level.
+	 *
+	 * The latency of the pixel fetch mechanism is 6 pixels, so we
+	 * need to convert those 6 pixels in bytes, depending on the
+	 * format, and then subtract that from the length of the FIFO
+	 * to make sure we never end up in a situation where the FIFO
+	 * is full.
+	 */
 	switch (format) {
 	case PV_CONTROL_FORMAT_DSIV_16:
 	case PV_CONTROL_FORMAT_DSIC_16:
@@ -367,7 +377,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 
 	CRTC_WRITE(PV_CONTROL,
 		   VC4_SET_FIELD(format, PV_CONTROL_FORMAT) |
-		   VC4_SET_FIELD(vc4_get_fifo_full_level(format),
+		   VC4_SET_FIELD(vc4_get_fifo_full_level(vc4_crtc, format),
 				 PV_CONTROL_FIFO_LEVEL) |
 		   VC4_SET_FIELD(pixel_rep - 1, PV_CONTROL_PIXEL_REP) |
 		   PV_CONTROL_CLR_AT_START |
@@ -1066,6 +1076,7 @@ static const struct vc4_crtc_data bcm2835_pv0_data = {
 	.hvs_available_channels = BIT(0),
 	.hvs_output = 0,
 	.debugfs_name = "crtc0_regs",
+	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI0,
@@ -1077,6 +1088,7 @@ static const struct vc4_crtc_data bcm2835_pv1_data = {
 	.hvs_available_channels = BIT(2),
 	.hvs_output = 2,
 	.debugfs_name = "crtc1_regs",
+	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI1,
@@ -1088,6 +1100,7 @@ static const struct vc4_crtc_data bcm2835_pv2_data = {
 	.hvs_available_channels = BIT(1),
 	.hvs_output = 1,
 	.debugfs_name = "crtc2_regs",
+	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_HDMI,
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 73156a53822f..1f62dffd6676 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -450,6 +450,9 @@ to_vc4_encoder(struct drm_encoder *encoder)
 }
 
 struct vc4_crtc_data {
+	/* Depth of the PixelValve FIFO in bytes */
+	unsigned int fifo_depth;
+
 	/* Which channels of the HVS can the output source from */
 	unsigned int hvs_available_channels;
 
-- 
git-series 0.9.1
