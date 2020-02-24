Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74395C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C4920658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="jjoFUWQu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2z0eHbLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgBXJKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:10:01 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:35719 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727986AbgBXJJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:56 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id B52B5640;
        Mon, 24 Feb 2020 04:09:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=XT9GwBwEX3tIf
        OPU4zIXb2LYt4kg2V7rA89WqZFXbf0=; b=jjoFUWQuOqpBMsoyCoOzzX8CHpU84
        c4qy5A55ARqAdrGr2IrIm6cGsYhYkryeFQABb0yi+IBzi+kP3ptHgPOWda8yexOH
        aTyV1/KJQfcNuQ832lF7VJylxgDCJ3/fni+axNm3LK9y/m8u6gfUfg6udgP1mYXi
        vFB1JPToVe4pMJzng89QfLP+FO2uy//jXnhMZXB6p3g4FY3/fT1NYWQhM1DNqtU4
        XYfj+vG2vhgpJkm5oumMcE4uGzvZk9KRHEC3hhoLtjixo+hze4eA1sQOCluo9lTl
        NRsGgBT0yLoRZogLZofNNFsNtbM/obV07diO72IY0o7EC6UXFkmRpjTqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=XT9GwBwEX3tIfOPU4zIXb2LYt4kg2V7rA89WqZFXbf0=; b=2z0eHbLj
        +ATfLJenmzd3fe1BLuyZBEBvpX0Wro6iBXrFh33HWYXLWU4MQHtdcTkAL3XSrhSm
        GmMMW0wgw8r/p4+5xYrzTLv0RT8wDysJUDyHthIKU8qGSIcqW4XEXEG3+ACP11gA
        +sg3k8pd73XMUv4LNjOAHwyYRBT20CksYe5FufsBaE3tBhp/ax44mTrNNKf4Ij3o
        +Rh3jSJZJwDvPAsCtqg4xkKHHgUXnaERMuTvN+lUPv6nOwemhVSgr3NU6iDbrhIH
        Yhfkt0pheHMjUmjcai5Itjy2m/XGg4JttPtmUGQkdWnLXL/6Y/S4+7wwibBM4tXD
        ToRHz3tsSezKnw==
X-ME-Sender: <xms:4pJTXshxwurSKvlm5Qv__hu81SlgysgKo8NA_GOU5ul78ItGGpqJLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepfeelnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:4pJTXnFlOEsf0VvayS-QHZIX1PdayVQadbifCStzagT-Oat8ikYrAg>
    <xmx:4pJTXiO9J63Rm6cWMj22Ts9daeDpQX8-aTpOMGTbOmwKa1G5-RRN9Q>
    <xmx:4pJTXiNu8s9EgB3mkbdWbHwQQTbaq21r8cYErXzR_PZ44UBS8q-eMA>
    <xmx:4pJTXgIM4xpG1VL2m57CpUk5BMKS5AGafYqTpog17kgKfpejzDf4elIC2UM>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 00D083060BD1;
        Mon, 24 Feb 2020 04:09:53 -0500 (EST)
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
Subject: [PATCH 45/89] drm/vc4: crtc: Deal with different number of pixel per clock
Date:   Mon, 24 Feb 2020 10:06:47 +0100
Message-Id: <ba234b8ae9812ca0060f4d055568aa47b23d4833.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
index 0f8446e4a397..236a14190ebd 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -281,6 +281,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 	bool is_dsi = (vc4_encoder->type == VC4_ENCODER_TYPE_DSI0 ||
 		       vc4_encoder->type == VC4_ENCODER_TYPE_DSI1);
 	u32 format = is_dsi ? PV_CONTROL_FORMAT_DSIV_24 : PV_CONTROL_FORMAT_24;
+	u8 ppc = vc4_crtc->data->pixels_per_clock;
 
 	/* Reset the PV fifo. */
 	CRTC_WRITE(PV_CONTROL, 0);
@@ -288,17 +289,16 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
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
@@ -1037,6 +1037,7 @@ static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
 static const struct vc4_crtc_data bcm2835_pv0_data = {
 	.hvs_channel = 0,
 	.debugfs_name = "crtc0_regs",
+	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI0,
 		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_DPI,
@@ -1046,6 +1047,7 @@ static const struct vc4_crtc_data bcm2835_pv0_data = {
 static const struct vc4_crtc_data bcm2835_pv1_data = {
 	.hvs_channel = 2,
 	.debugfs_name = "crtc1_regs",
+	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI1,
 		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_SMI,
@@ -1055,6 +1057,7 @@ static const struct vc4_crtc_data bcm2835_pv1_data = {
 static const struct vc4_crtc_data bcm2835_pv2_data = {
 	.hvs_channel = 1,
 	.debugfs_name = "crtc2_regs",
+	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_HDMI,
 		[PV_CONTROL_CLK_SELECT_VEC] = VC4_ENCODER_TYPE_VEC,
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 0aa3a9e64ea0..0bf14c1dfe39 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -451,6 +451,9 @@ struct vc4_crtc_data {
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
