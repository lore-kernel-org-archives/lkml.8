Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA7BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2197820776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="TwnzvMlZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Je62+51A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgE0PuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:50:23 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:48669 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390209AbgE0PuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7DA7058204A;
        Wed, 27 May 2020 11:50:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=kW7Ps2oNt5lvy
        Y7OIGFl8oRdikr/7SrdDhAW5AmKu+k=; b=TwnzvMlZ0TBGmflCytGhjo05+Use7
        Ypbik81BG0rOD8nStJ6uSq2ygD/BsFTE9vCRBr2vSLChYP8s4+JhIZbvO6bFdogJ
        BKN0LqQWD9heIbaRt9uC0/N8rrtVCUFwaMgeWGMi3vyD2kGWiegHf9ObCBoyzfLx
        4iUM/eOGAACSTUc7CPDwfCMQVMBV8sPUFBToxOaSkrGzCg6o8JCo3+yKs/LQSOYl
        cyiNM7oSV59bryOdN/N7KVEd9/EssWDVU/RdZkZxMIgFC+mG52VTsfF+5XJu/hcp
        Sb0ZXFvg9IFWOO2UbAP92/ML6hwZ0LHSNl1xA4sbW3Lbv9QL9gb8YdMqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=kW7Ps2oNt5lvyY7OIGFl8oRdikr/7SrdDhAW5AmKu+k=; b=Je62+51A
        IohyO1Mw8jMyhRMi3EUO4o3Y2/XO8ruUSufwaLHAYreEcj4jvhgWBzWsY47lBR2c
        fP9VvsjEVNsueKvvAzpWoESy3y1bWQ53beCqzTPYA8iPDraQ9ztabo3OFYlTM1Vf
        s771WamtAr6E9+fQAVoPavr8m3S2hBsmbCb8E1oZDV3mWQwfGQ20wc3/mHhRxFCx
        nredSEDz1hYnEuZDx+1n37Cw0KcSZvn8xLGBunAKk/0NcPV2av+PPgxeAdZrOVwb
        VOVefhesbPbL/qyYxns6vyy5/Tx3xcQxsS0H/uif105NPJrxXW2IFjOcpACfw05T
        Jj0Izec4iP/agw==
X-ME-Sender: <xms:LYzOXufM_HalT_PI_sj12695oY18J5NBmSOhsEl3Nqgyegb3o2VL8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepuddune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:LYzOXoPkpEifJeqS65REK-5zgsbSD2KtealEnQoe47DoVx3TZvSnMA>
    <xmx:LYzOXvhVp003e5Hr3k7wzBHXmxHfeEQhECsHFTw8311fDg0G5cpdEA>
    <xmx:LYzOXr_W__zSHxseuR10m6geUMqco-FjOU3-ZKciamPsPXvQniBjZQ>
    <xmx:LYzOXn-VbFlEWm-yr_e-fggsj8PMTWivRtBEgriW9bLubZUrLN9Krw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1BA86328005A;
        Wed, 27 May 2020 11:50:05 -0400 (EDT)
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
Subject: [PATCH v3 030/105] drm/vc4: crtc: Rename HVS channel to output
Date:   Wed, 27 May 2020 17:48:00 +0200
Message-Id: <fe71da94cd3311e4c2bb59a62cd5a49d349cc727.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vc5, the HVS has 6 outputs and 3 FIFOs (or channels), with
pixelvalves each being assigned to a given output, but each output can
then be muxed to feed from multiple FIFOs.

Since vc4 had that entirely static, both were probably equivalent, but
since that changes, let's rename hvs_channel to hvs_output in the
vc4_crtc_data, since a pixelvalve is really connected to an output, and
not to a FIFO.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 10 +++++-----
 drivers/gpu/drm/vc4/vc4_drv.h  |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index d58f881649d5..14e3a962d8a7 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1056,7 +1056,7 @@ static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
 };
 
 static const struct vc4_crtc_data bcm2835_pv0_data = {
-	.hvs_channel = 0,
+	.hvs_output = 0,
 	.debugfs_name = "crtc0_regs",
 	.pixels_per_clock = 1,
 	.encoder_types = {
@@ -1066,7 +1066,7 @@ static const struct vc4_crtc_data bcm2835_pv0_data = {
 };
 
 static const struct vc4_crtc_data bcm2835_pv1_data = {
-	.hvs_channel = 2,
+	.hvs_output = 2,
 	.debugfs_name = "crtc1_regs",
 	.pixels_per_clock = 1,
 	.encoder_types = {
@@ -1076,7 +1076,7 @@ static const struct vc4_crtc_data bcm2835_pv1_data = {
 };
 
 static const struct vc4_crtc_data bcm2835_pv2_data = {
-	.hvs_channel = 1,
+	.hvs_output = 1,
 	.debugfs_name = "crtc2_regs",
 	.pixels_per_clock = 1,
 	.encoder_types = {
@@ -1105,7 +1105,7 @@ static void vc4_set_crtc_possible_masks(struct drm_device *drm,
 		int i;
 
 		/* HVS FIFO2 can feed the TXP IP. */
-		if (crtc_data->hvs_channel == 2 &&
+		if (crtc_data->hvs_output == 2 &&
 		    encoder->encoder_type == DRM_MODE_ENCODER_VIRTUAL) {
 			encoder->possible_crtcs |= drm_crtc_mask(crtc);
 			continue;
@@ -1167,7 +1167,7 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	drm_crtc_init_with_planes(drm, crtc, primary_plane, NULL,
 				  &vc4_crtc_funcs, NULL);
 	drm_crtc_helper_add(crtc, &vc4_crtc_helper_funcs);
-	vc4_crtc->channel = vc4_crtc->data->hvs_channel;
+	vc4_crtc->channel = vc4_crtc->data->hvs_output;
 	drm_mode_crtc_set_gamma_size(crtc, ARRAY_SIZE(vc4_crtc->lut_r));
 	drm_crtc_enable_color_mgmt(crtc, 0, false, crtc->gamma_size);
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 6c4b78b71446..9d120aae4af9 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -450,8 +450,8 @@ to_vc4_encoder(struct drm_encoder *encoder)
 }
 
 struct vc4_crtc_data {
-	/* Which channel of the HVS this pixelvalve sources from. */
-	int hvs_channel;
+	/* Which output of the HVS this pixelvalve sources from. */
+	int hvs_output;
 
 	/* Number of pixels output per clock period */
 	u8 pixels_per_clock;
-- 
git-series 0.9.1
