Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9D5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBA22088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ykc/dTT2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vrUPWg4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgE0P4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:56:37 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:36569 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390211AbgE0PuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:09 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C72CE58205A;
        Wed, 27 May 2020 11:50:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=o8UH7HzUq+ZuB
        7eeWpTyi1/5ijSzp/Ve3XF+alFUSno=; b=ykc/dTT25h7h/eP9V+5ggPXGVmC5x
        6lhfqyDmTakBlsHr5JaoT/rhmLsVZ7UvuG9TxemYd+o3qeTqwoWjHaWr/NKBoKD7
        KvHfH4cAxZDixcR+Ocr2jGMFzOzrvJ42ZM800UezDJoz75mf7qTEaKSDbaxZPGto
        UucHudoXslnbAzpUnf0aWsoq+6rOPZKmx5veW1GbiJhCZmBfmtKInRXMTITLzjEJ
        mTmNn0aqy6PLTu7sPus6lL1ippVrd7HOJuCf1GgZZDYleGAoIFLX0tnpjx/OQi4c
        aXCZHDz0ZrMoxUMV/br7r32q9DsF0qyfEmyUwuGW53nJZNPIZWjB8mdkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=o8UH7HzUq+ZuB7eeWpTyi1/5ijSzp/Ve3XF+alFUSno=; b=vrUPWg4U
        AMSXAwJCK1VtZckICLRMMJD5S6Z32YF6B/HJvK7T/P5oVjyODVvJHX96Yvyo/U/h
        0VF31+SDissv+2OHmkPcUGzp10DiCmw3vxjGQyEcvuxKt0huU/qDZrFfVuCxUAY1
        botNWHEmCz70vIbg7iFumlk620a24Y3GjrHcR5HBAX6f50/e+l5l8mZguJblhOoZ
        zR4aE00SFwzeaNhiN1d9HnD2nUM1icj/MtVkwG9Da+T1ZYWD2aYSSRrjhKhoxNSV
        MO7f319nI4x81daMhWKMg9V2+1/WNCVdpAdQe3AC1J6YObg7VI8z2Y1+XC1vDQpr
        cjRfE66cljsXRA==
X-ME-Sender: <xms:MIzOXvUG3egGiiXZlNpuoGmwjmYKVWzHKF8o63QV_PzA-nzJtB5JiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:MIzOXnkwLuLQhGFUD2O4znoupvYEPB6kSQSRS5lVMbZAipFsUIbpEQ>
    <xmx:MIzOXraxI2LrSMENMoLe54JvvJtWAK-I0grLlV05-GTlLK4xHvV8QA>
    <xmx:MIzOXqWah8dCI5B_GqMeXSpLitonqTtqhxTsnUnQSG_Uzq2JICUG2Q>
    <xmx:MIzOXvXKWBMQ4T-p20Ob07R5FiZrbU-poEKyD_KrRx8OYmMTcDyv6g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5FD703280064;
        Wed, 27 May 2020 11:50:08 -0400 (EDT)
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
Subject: [PATCH v3 032/105] drm/vc4: crtc: Enable and disable the PV in atomic_enable / disable
Date:   Wed, 27 May 2020 17:48:02 +0200
Message-Id: <d2c1850e38e14f3def4c0307240e6826e296c14b.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VIDEN bit in the pixelvalve currently being used to enable or disable
the pixelvalve seems to not be enough in some situations, which whill end
up with the pixelvalve stalling.

In such a case, even re-enabling VIDEN doesn't bring it back and we need to
clear the FIFO. This can only be done if the pixelvalve is disabled though.

In order to overcome this, we can configure the pixelvalve during
mode_set_no_fb, but only enable it in atomic_enable and flush the FIFO
there, and in atomic_disable disable the pixelvalve again.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 15c72afb226f..580b37ad514d 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -372,9 +372,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 		   PV_CONTROL_TRIGGER_UNDERFLOW |
 		   PV_CONTROL_WAIT_HSTART |
 		   VC4_SET_FIELD(vc4_encoder->clock_select,
-				 PV_CONTROL_CLK_SELECT) |
-		   PV_CONTROL_FIFO_CLR |
-		   PV_CONTROL_EN);
+				 PV_CONTROL_CLK_SELECT));
 }
 
 static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
@@ -465,6 +463,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
 	WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
 
+	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
+
 	if (HVS_READ(SCALER_DISPCTRLX(chan)) &
 	    SCALER_DISPCTRLX_ENABLE) {
 		HVS_WRITE(SCALER_DISPCTRLX(chan),
@@ -552,6 +552,10 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	require_hvs_enabled(dev);
 
+	/* Reset the PV fifo. */
+	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) |
+		   PV_CONTROL_FIFO_CLR | PV_CONTROL_EN);
+
 	/* Enable vblank irq handling before crtc is started otherwise
 	 * drm_crtc_get_vblank() fails in vc4_crtc_update_dlist().
 	 */
-- 
git-series 0.9.1
