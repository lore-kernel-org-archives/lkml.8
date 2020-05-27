Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACB5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237A9208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="IlyTPLBa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pVLSUIVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbgE0P4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:56:18 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53355 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728666AbgE0Pub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8421B582091;
        Wed, 27 May 2020 11:50:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=7mda2iOOQ39Qa
        oOXcPKflkPJpbuQfc7IIrE/YRJCbN0=; b=IlyTPLBaRi0xF7O/j/vtCVAY2D/3a
        28i2F5fStL+IJn+uJnG5UoRFk7bZ4ftModQrGL7tBfFoC9bQToepi30d2cFk/g+O
        K1WMKUkpeFW0U+duh9a27sf1/X6mH/JegPfdgoBpM493kuvNVPbJCmEpxVRcEht2
        3zLW91iKX/hnKPcx77+mNt16uZczGvWPwr0qZSNGV899yF9hItpFzy+/JlbO9NcI
        mmeb5PRN5dp2ZLulJi6Z9cppSsGnz35Y0HiD534ZztLzeif2DiN9W8++S4VtWcaS
        d2MpEurfdihFZtWjxaURCuNx9/1EIIUanReUgRUpg5MX61p2n6ebWD5cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=7mda2iOOQ39QaoOXcPKflkPJpbuQfc7IIrE/YRJCbN0=; b=pVLSUIVW
        Ry3lgNAwv5vRZg28F5X2gX4IkuaSBG930WlPJJQxTGYUqAJhZTXHcGxzSqsKvi5p
        SDkPeAkFRhTCBsn2msupyZvCT8VXLmopYIlOKObuZRrN6fNAmcfQJmqLMBvFiGLT
        BFStI5GOa9qWEM452wd/6s/GilLL9BVm9lEIuX/cCc1jeSdC7Yefqeqp8BKKnPZj
        UIFkV5XndR8ksoeFc9bpN8sjyQljIvg+R/HucueifmwisdbeNkMhGJAAtniYtq63
        nAwmRfwZtf20rsf1HySNS2TvMGKO4rzngoGPVJAWbPaZDa7ZRjqMk4wO57vxlSqO
        dEstq2A3xxXSEA==
X-ME-Sender: <xms:RozOXggV-tkWlE7YxheLItbRIYigL02lOAzuE9jfaKk8ol2QE0Isqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:RozOXpBAthlJy_-_9Bsex3Y9c7nrFOtU82tH7tLUgstQnFcSbm2HCA>
    <xmx:RozOXoE1uwzxei0c-uOPay-DSKPf4xoUMDnEZ86GqkNY7Td-ZeIeRQ>
    <xmx:RozOXhQalxOvkxWLJHJ_wYk0s2RQsCTO9ycqi7ULzlSarIU__D9e8g>
    <xmx:RozOXswOcSekfgFQ8KDc3IrxA1YEGCNqt3UfgAk-YaZVQlvhnLFdTw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 25BD53280060;
        Wed, 27 May 2020 11:50:30 -0400 (EDT)
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
Subject: [PATCH v3 046/105] drm/vc4: hvs: Remove mode_set_nofb
Date:   Wed, 27 May 2020 17:48:16 +0200
Message-Id: <0f7b26403123254c4d81b82c9b0e0ee61b4e71ac.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the only thing that remains in the mode_set_nofb callback for the
HVS is the TXP muxing, and since that part is already covered by the FIFO
channel allocation / muxing, the whole function is basically redundant and
we can just remove it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c |  2 --
 drivers/gpu/drm/vc4/vc4_drv.h  |  1 -
 drivers/gpu/drm/vc4/vc4_hvs.c  | 32 --------------------------------
 3 files changed, 35 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 0a67b27cec9b..a69e0d456b79 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -380,8 +380,6 @@ static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
 
 	if (!vc4_state->feed_txp)
 		vc4_crtc_config_pv(crtc);
-
-	vc4_hvs_mode_set_nofb(crtc);
 }
 
 static void require_hvs_enabled(struct drm_device *dev)
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 5520a22f8126..d86228e1e338 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -876,7 +876,6 @@ int vc4_hvs_atomic_check(struct drm_crtc *crtc, struct drm_crtc_state *state);
 void vc4_hvs_atomic_enable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
 void vc4_hvs_atomic_disable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
 void vc4_hvs_atomic_flush(struct drm_crtc *crtc, struct drm_crtc_state *state);
-void vc4_hvs_mode_set_nofb(struct drm_crtc *crtc);
 void vc4_hvs_dump_state(struct drm_device *dev);
 void vc4_hvs_unmask_underrun(struct drm_device *dev, int channel);
 void vc4_hvs_mask_underrun(struct drm_device *dev, int channel);
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 754aff3966bd..ec58870acb7b 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -441,38 +441,6 @@ void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
 	}
 }
 
-void vc4_hvs_mode_set_nofb(struct drm_crtc *crtc)
-{
-	struct drm_device *dev = crtc->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
-	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
-
-	if (vc4_crtc->data->hvs_output == 2) {
-		u32 dispctrl;
-		u32 dsp3_mux;
-
-		/*
-		 * SCALER_DISPCTRL_DSP3 = X, where X < 2 means 'connect DSP3 to
-		 * FIFO X'.
-		 * SCALER_DISPCTRL_DSP3 = 3 means 'disable DSP 3'.
-		 *
-		 * DSP3 is connected to FIFO2 unless the transposer is
-		 * enabled. In this case, FIFO 2 is directly accessed by the
-		 * TXP IP, and we need to disable the FIFO2 -> pixelvalve1
-		 * route.
-		 */
-		if (vc4_state->feed_txp)
-			dsp3_mux = VC4_SET_FIELD(3, SCALER_DISPCTRL_DSP3_MUX);
-		else
-			dsp3_mux = VC4_SET_FIELD(2, SCALER_DISPCTRL_DSP3_MUX);
-
-		dispctrl = HVS_READ(SCALER_DISPCTRL) &
-			   ~SCALER_DISPCTRL_DSP3_MUX_MASK;
-		HVS_WRITE(SCALER_DISPCTRL, dispctrl | dsp3_mux);
-	}
-}
-
 void vc4_hvs_mask_underrun(struct drm_device *dev, int channel)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
-- 
git-series 0.9.1
