Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAD9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E52420C56
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="p04hcC86";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F6rcJ/R5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390208AbgE0PuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:50:03 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:40009 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390180AbgE0Pt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E2483582037;
        Wed, 27 May 2020 11:49:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=GHAf0GBSggKB3
        r+PycYRr3qDNQS5GVSL5h32VX4ho1I=; b=p04hcC86BQ1iBLAhPJrhcsMjVPiNK
        Wa74afvIsSikdLKz0UgPXne38otChh6ZJCW/onv5L2PDvbjK3nolsZm1HGaaJ9IA
        Kuj/Yfkhe26PWZ3+lF/KUH7/GMdDnZl+ytoZUk3sjD7KEAm73K8A3bU+U9XE0tBM
        9YQBAbgSc1eUFsQWwVab3YiQ0nK+yBjMBMg2/LUUXq+8Inybaq7/y4mU0GXqNNii
        IFHDBnZNViEQs+lHn0CUWLYjwmbmYFfRmETQYqbANOCnfW9iwDcLRfJJ/u8Vb/5q
        lXebxb9JYS6MnCaDVjxOE423afpmWCsc0ez12K/KZXYsxFDx4grKcx/4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=GHAf0GBSggKB3r+PycYRr3qDNQS5GVSL5h32VX4ho1I=; b=F6rcJ/R5
        hspkGX06Fmq9s/nhea485+EYc6ViOrLUzGZIqnWuyK3I1gvQ93TCh5wBStUGXZzm
        ZG/RIxFe6+dQR/Gka42MpwFyxsY0XUQVfSrwhm+2Sp6TFG2byqQhYQvcyYdz8ed6
        0iyzC3u1uyiGro3o5DXLRmTTnFs5k+VE0LoDlSUBwM6jFG2+S3fS2bufC0S7Lqzh
        BIWUbTLtgCRw6lMiw42JWJ1V9cBEBFCRjDN6eQqtFC3kRKldfPSGfJywZWf4JmCs
        c8OOBiOgElAbTohwmwrqP86gcMGcR6LBm4NNlXCeRKZdvaSoPtOSyGAWrN9lK8Ky
        o0pmEJIrK775Wg==
X-ME-Sender: <xms:I4zOXqm6Zod18Gu9Hlvn-OK4skX7zY71Rj7BXnFWzK2cVyFSXMACbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:I4zOXh1sM9wrGy4WbVXdzGqFowm_yQXtgHTl3Zak5B0GCyg_5LJQPg>
    <xmx:I4zOXopuI70_jFFvZcenoJh7Hc1MJLBnMgXTFRqoxT4mplhkvyxpmg>
    <xmx:I4zOXul4gTVQSdSeV_rM3ddboefBEEmJmmSx8foa6JGACUqjy2eTmg>
    <xmx:I4zOXpk3dB-ueQgqmzPnz3pPuHJstELk5d0SyABaavz_z8ZQDAEKsQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 832743061CCB;
        Wed, 27 May 2020 11:49:55 -0400 (EDT)
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
Subject: [PATCH v3 025/105] drm/vc4: crtc: Deal with different number of pixel per clock
Date:   Wed, 27 May 2020 17:47:55 +0200
Message-Id: <69a64690a7a87bbd3fad59b7409baabcec40c8d7.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the HDMI pixelvalves in vc5 output two pixels per clock cycle.
Let's put the number of pixel output per clock cycle in the CRTC data and
update the various calculations to reflect that.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 17 ++++++++++-------
 drivers/gpu/drm/vc4/vc4_drv.h  |  3 +++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index db056dfe14df..a3fc7dd97446 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -282,6 +282,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 	bool is_dsi = (vc4_encoder->type == VC4_ENCODER_TYPE_DSI0 ||
 		       vc4_encoder->type == VC4_ENCODER_TYPE_DSI1);
 	u32 format = is_dsi ? PV_CONTROL_FORMAT_DSIV_24 : PV_CONTROL_FORMAT_24;
+	u8 ppc = vc4_crtc->data->pixels_per_clock;
 
 	/* Reset the PV fifo. */
 	CRTC_WRITE(PV_CONTROL, 0);
@@ -289,17 +290,16 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 	CRTC_WRITE(PV_CONTROL, 0);
 
 	CRTC_WRITE(PV_HORZA,
-		   VC4_SET_FIELD((mode->htotal -
-				  mode->hsync_end) * pixel_rep,
+		   VC4_SET_FIELD((mode->htotal - mode->hsync_end) * pixel_rep / ppc,
 				 PV_HORZA_HBP) |
-		   VC4_SET_FIELD((mode->hsync_end -
-				  mode->hsync_start) * pixel_rep,
+		   VC4_SET_FIELD((mode->hsync_end - mode->hsync_start) * pixel_rep / ppc,
 				 PV_HORZA_HSYNC));
+
 	CRTC_WRITE(PV_HORZB,
-		   VC4_SET_FIELD((mode->hsync_start -
-				  mode->hdisplay) * pixel_rep,
+		   VC4_SET_FIELD((mode->hsync_start - mode->hdisplay) * pixel_rep / ppc,
 				 PV_HORZB_HFP) |
-		   VC4_SET_FIELD(mode->hdisplay * pixel_rep, PV_HORZB_HACTIVE));
+		   VC4_SET_FIELD(mode->hdisplay * pixel_rep / ppc,
+				 PV_HORZB_HACTIVE));
 
 	CRTC_WRITE(PV_VERTA,
 		   VC4_SET_FIELD(mode->crtc_vtotal - mode->crtc_vsync_end,
@@ -1040,6 +1040,7 @@ static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
 static const struct vc4_crtc_data bcm2835_pv0_data = {
 	.hvs_channel = 0,
 	.debugfs_name = "crtc0_regs",
+	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI0,
 		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_DPI,
@@ -1049,6 +1050,7 @@ static const struct vc4_crtc_data bcm2835_pv0_data = {
 static const struct vc4_crtc_data bcm2835_pv1_data = {
 	.hvs_channel = 2,
 	.debugfs_name = "crtc1_regs",
+	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI1,
 		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_SMI,
@@ -1058,6 +1060,7 @@ static const struct vc4_crtc_data bcm2835_pv1_data = {
 static const struct vc4_crtc_data bcm2835_pv2_data = {
 	.hvs_channel = 1,
 	.debugfs_name = "crtc2_regs",
+	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_HDMI,
 		[PV_CONTROL_CLK_SELECT_VEC] = VC4_ENCODER_TYPE_VEC,
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 329185a53a79..8c0f714f557b 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -453,6 +453,9 @@ struct vc4_crtc_data {
 	/* Which channel of the HVS this pixelvalve sources from. */
 	int hvs_channel;
 
+	/* Number of pixels output per clock period */
+	u8 pixels_per_clock;
+
 	enum vc4_encoder_type encoder_types[4];
 	const char *debugfs_name;
 };
-- 
git-series 0.9.1
