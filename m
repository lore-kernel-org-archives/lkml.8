Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4730C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7FF2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="NND3PmLy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TTN5b5M3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgBXJKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:10:11 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:57655 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgBXJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:07 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 5CF89611;
        Mon, 24 Feb 2020 04:10:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=GjaLHXA2AyvuQ
        l9vH9XfduJjJhVTIoPPBkoWpTa+ODU=; b=NND3PmLyi+1Hgo7avdo0vrIJixxdW
        LCfK/Pch2SiSfcyBwBkqPXBMNpBH8E62SCaESgQYsOloxueYqrTHzUQKqDpZeklm
        ZE/KNoCbjpu7utrSauM1zqo4HhFHFsT595xWV/V9G8uZEXoDhu7REydRy4XITXcq
        KTaXg4c5DL0WssQyJAkDxMmKTDyJ+B/VErR3Ku1UIj4Ag2+FT4hpwDpeWu+dm7Oa
        nPT+of17Tb9kUZFKHwUdCGILneCKw6VgBQOA7BtgCzXwbSyYoCVqK3iouBx9GrBz
        MD3yBqWhoLl2cuLvOlSYE6R9ybnW75hOVX7OR0OnUEKf7jKuSeBgjHjpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=GjaLHXA2AyvuQl9vH9XfduJjJhVTIoPPBkoWpTa+ODU=; b=TTN5b5M3
        Xb/KHx9jQnjXe7PL28EqcQmlyZR+fs/MLP2F50uYRFQ8JDZKmMzzCGM65nKZqijZ
        6leWPIJRW8RieTVg8BiYHkdfgiq1kEWAJyeeMKAzD1ilTWT4UmEhCHm63/1FmrS6
        1Gxgfy/okLXlVfyQ5e56zR0lemSdYe/rmu9jrTsfR8IPt4nk0oDWt7aQAwkYl/w+
        f+JslD5Cb22p5wCmqbHZkIVOPVkiUoFzGazH5P08zGJdGtHo8RzH+aoIw86EPNvE
        PyiZ0pKgKWZI32NBkgtoWKu34ctH1x2fBTZ0uqeQVUgOcf2/7tgOMPwc8A7BVxw+
        fVZGg6uqbkiW/Q==
X-ME-Sender: <xms:7ZJTXi7mAdzLneMJHNMGy5cWmN59t3VQpXL01DYz111ylbp0dqNRyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepgeegnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:7ZJTXi8ilvkaOWIoAV-WKpitxNYEr6NPfmIEraPLjeT0ZQDIlUTpIQ>
    <xmx:7ZJTXpcQLLxRfV2w9Q0io6LUFf440W_CaPPlt2Lgavq21deDULbXlw>
    <xmx:7ZJTXg3HPnPeR4_h0BZ9VK18Tc4N7RWVN3tHqoufLGRNyTjHLil0Kg>
    <xmx:7pJTXmOAC9A-ftyyk89vevB0_w57LTgpIaPwra7AJf_3etWOx9cge65e50o>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9DE6D3060FCB;
        Mon, 24 Feb 2020 04:10:05 -0500 (EST)
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
Subject: [PATCH 53/89] drm/vc4: crtc: Add FIFO depth to vc4_crtc_data
Date:   Mon, 24 Feb 2020 10:06:55 +0100
Message-Id: <dc149f88bffd4c51551b8bf4476828c6e2e0f3fe.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
 drivers/gpu/drm/vc4/vc4_crtc.c | 20 ++++++++++++++++----
 drivers/gpu/drm/vc4/vc4_drv.h  |  3 +++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index f8e4b2971510..129131a07edd 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -250,11 +250,20 @@ vc4_crtc_update_gamma_lut(struct drm_crtc *crtc)
 	vc4_crtc_lut_load(crtc);
 }
 
-
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
+	 * format, and then substract that from the length of the FIFO
+	 * to make sure we never end up in a situation where the FIFO
+	 * is full.
+	 */
 	switch (format) {
 	case PV_CONTROL_FORMAT_DSIV_16:
 	case PV_CONTROL_FORMAT_DSIC_16:
@@ -369,7 +378,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 
 	CRTC_WRITE(PV_CONTROL,
 		   VC4_SET_FIELD(format, PV_CONTROL_FORMAT) |
-		   VC4_SET_FIELD(vc4_get_fifo_full_level(format),
+		   VC4_SET_FIELD(vc4_get_fifo_full_level(vc4_crtc, format),
 				 PV_CONTROL_FIFO_LEVEL) |
 		   VC4_SET_FIELD(pixel_rep - 1, PV_CONTROL_PIXEL_REP) |
 		   PV_CONTROL_CLR_AT_START |
@@ -1066,6 +1075,7 @@ static const struct vc4_crtc_data bcm2835_pv0_data = {
 	.hvs_available_channels = BIT(0),
 	.hvs_output = 0,
 	.debugfs_name = "crtc0_regs",
+	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI0,
@@ -1077,6 +1087,7 @@ static const struct vc4_crtc_data bcm2835_pv1_data = {
 	.hvs_available_channels = BIT(2),
 	.hvs_output = 2,
 	.debugfs_name = "crtc1_regs",
+	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI1,
@@ -1088,6 +1099,7 @@ static const struct vc4_crtc_data bcm2835_pv2_data = {
 	.hvs_available_channels = BIT(1),
 	.hvs_output = 1,
 	.debugfs_name = "crtc2_regs",
+	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_HDMI,
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index f31a6593da8a..967d57d0ab08 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -448,6 +448,9 @@ to_vc4_encoder(struct drm_encoder *encoder)
 }
 
 struct vc4_crtc_data {
+	/* Depth of the PixelValve FIFO in bytes */
+	unsigned int fifo_depth;
+
 	/* Which channels of the HVS can the output source from */
 	unsigned int hvs_available_channels;
 
-- 
git-series 0.9.1
