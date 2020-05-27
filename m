Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A6EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C37620873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="q+Hehvy6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u5UoQH64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgE0Pux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:50:53 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:36327 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730547AbgE0Pu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E633A582022;
        Wed, 27 May 2020 11:50:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Ie6bw5e496oKh
        30HHiSrnFCTx8wMhjVRPsOojlgDgTU=; b=q+Hehvy6NLNMp8aWJ0yq2dU44Fubv
        sX2baMGT64XbQngMIoT9/IqXtbELxMWEzhZxOeBNAwTugsyWNGhHOlIzLTm0qgdy
        a2it/+5p50udYoeUT/FBYP2bZ+7+Nnh08CNGOOBhLuK2T/5lo9SsyhC5Qfe8hNKS
        8dWuqTE23WTNv8BiTef+gLGavweiKh3Diu5dl3o5+iQwOMG2ZZVHPmH+dJHjtNDk
        9sLlbHczVHwpYosVlWMfTqhKEz3dP3hhiisfl/q3qNBzOMvaqms9i9mmRNBWN5dA
        7pW6wCxJ+CJaTeRud8cuH7/gqjX5FjNCGUKhYmInq0osNiBzG/uZno5Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Ie6bw5e496oKh30HHiSrnFCTx8wMhjVRPsOojlgDgTU=; b=u5UoQH64
        3VtfuOOk+QUW3BlTF0pkBOcxuGBh6qIapOdWFIJdk1bfkyF7y/lYZqayRJUtEVmZ
        4hy3Hxixas0+5ktv2UcMXEsE7qCliZt648EKG6aGoVu6Pf6zWau82oqIL+ug/Zdw
        vB5ACFC63Ckns4LSeEV4slbMN5FtPVob7ANodq5q/K36bB+SoopWAjHnqjLQNMVP
        Fc8hio7JE3PAb78SJccr1WWXHVAGu0X1EgMbjgduyQaGCIIiFoBiLpPTo1XxLkMS
        MOpY33+09t11IkdylQGuCMFUVDgEXa9d5JhzDN0ELLxe8hSCpkIBMAR35vUFfCyd
        wa0LYdujRuznrw==
X-ME-Sender: <xms:QYzOXr1fLqLkyKPvbGCB_d_IZWY3PeHDFvZ9RB5Mp9r9UscTv90ikw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:QYzOXqGt9CcKIVsKhLHXHzNf0Gr2djupIejw09V7q10vb0cQv9bdLA>
    <xmx:QYzOXr7r-Hw5qwygt02huMDGw3gjqG6RYW1alLQ2sB0aWFuQ881HXQ>
    <xmx:QYzOXg2A1DUS9PP2SUiPY7leunVzBYonY4L0O-1CZKHtBtpUWF4dOg>
    <xmx:QYzOXh3i2A288vWirVXzbr4TIYH0TwFBEW_je02ryS47nadiBedMiw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 84F833280064;
        Wed, 27 May 2020 11:50:25 -0400 (EDT)
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
Subject: [PATCH v3 043/105] drm/vc4: crtc: Move HVS init and close to a function
Date:   Wed, 27 May 2020 17:48:13 +0200
Message-Id: <156d2301ee8d70b5ddd0eaf2d60cd1a12f8f4b65.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make further refactoring easier, let's move the HVS channel
setup / teardown to their own function.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 106 +++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 0cd63d817a7e..2352a63fd26b 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -196,6 +196,62 @@ static void vc4_hvs_update_gamma_lut(struct drm_crtc *crtc)
 	vc4_hvs_lut_load(crtc);
 }
 
+static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
+				struct drm_display_mode *mode, bool oneshot)
+{
+	struct vc4_crtc_state *vc4_crtc_state = to_vc4_crtc_state(crtc->state);
+	unsigned int chan = vc4_crtc_state->assigned_channel;
+	u32 dispctrl;
+
+	/* Turn on the scaler, which will wait for vstart to start
+	 * compositing.
+	 * When feeding the transposer, we should operate in oneshot
+	 * mode.
+	 */
+	dispctrl = SCALER_DISPCTRLX_ENABLE;
+
+	if (!vc4->hvs->hvs5)
+		dispctrl |= VC4_SET_FIELD(mode->hdisplay,
+					  SCALER_DISPCTRLX_WIDTH) |
+			    VC4_SET_FIELD(mode->vdisplay,
+					  SCALER_DISPCTRLX_HEIGHT) |
+			    (oneshot ? SCALER_DISPCTRLX_ONESHOT : 0);
+	else
+		dispctrl |= VC4_SET_FIELD(mode->hdisplay,
+					  SCALER5_DISPCTRLX_WIDTH) |
+			    VC4_SET_FIELD(mode->vdisplay,
+					  SCALER5_DISPCTRLX_HEIGHT) |
+			    (oneshot ? SCALER5_DISPCTRLX_ONESHOT : 0);
+
+	HVS_WRITE(SCALER_DISPCTRLX(chan), dispctrl);
+
+	return 0;
+}
+
+static void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int chan)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+
+	if (HVS_READ(SCALER_DISPCTRLX(chan)) & SCALER_DISPCTRLX_ENABLE)
+		return;
+
+	HVS_WRITE(SCALER_DISPCTRLX(chan),
+		  HVS_READ(SCALER_DISPCTRLX(chan)) | SCALER_DISPCTRLX_RESET);
+	HVS_WRITE(SCALER_DISPCTRLX(chan),
+		  HVS_READ(SCALER_DISPCTRLX(chan)) & ~SCALER_DISPCTRLX_ENABLE);
+
+	/* Once we leave, the scaler should be disabled and its fifo empty. */
+	WARN_ON_ONCE(HVS_READ(SCALER_DISPCTRLX(chan)) & SCALER_DISPCTRLX_RESET);
+
+	WARN_ON_ONCE(VC4_GET_FIELD(HVS_READ(SCALER_DISPSTATX(chan)),
+				   SCALER_DISPSTATX_MODE) !=
+		     SCALER_DISPSTATX_MODE_DISABLED);
+
+	WARN_ON_ONCE((HVS_READ(SCALER_DISPSTATX(chan)) &
+		      (SCALER_DISPSTATX_FULL | SCALER_DISPSTATX_EMPTY)) !=
+		     SCALER_DISPSTATX_EMPTY);
+}
+
 int vc4_hvs_atomic_check(struct drm_crtc *crtc,
 			 struct drm_crtc_state *state)
 {
@@ -268,63 +324,19 @@ void vc4_hvs_atomic_enable(struct drm_crtc *crtc,
 	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
 	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
 	bool oneshot = vc4_state->feed_txp;
-	u32 dispctrl;
 
 	vc4_hvs_update_dlist(crtc);
-
-	/* Turn on the scaler, which will wait for vstart to start
-	 * compositing.
-	 * When feeding the transposer, we should operate in oneshot
-	 * mode.
-	 */
-	dispctrl = SCALER_DISPCTRLX_ENABLE;
-
-	if (!vc4->hvs->hvs5)
-		dispctrl |= VC4_SET_FIELD(mode->hdisplay,
-					  SCALER_DISPCTRLX_WIDTH) |
-			    VC4_SET_FIELD(mode->vdisplay,
-					  SCALER_DISPCTRLX_HEIGHT) |
-			    (oneshot ? SCALER_DISPCTRLX_ONESHOT : 0);
-	else
-		dispctrl |= VC4_SET_FIELD(mode->hdisplay,
-					  SCALER5_DISPCTRLX_WIDTH) |
-			    VC4_SET_FIELD(mode->vdisplay,
-					  SCALER5_DISPCTRLX_HEIGHT) |
-			    (oneshot ? SCALER5_DISPCTRLX_ONESHOT : 0);
-
-	HVS_WRITE(SCALER_DISPCTRLX(vc4_state->assigned_channel), dispctrl);
+	vc4_hvs_init_channel(vc4, crtc, mode, oneshot);
 }
 
 void vc4_hvs_atomic_disable(struct drm_crtc *crtc,
 			    struct drm_crtc_state *old_state)
 {
 	struct drm_device *dev = crtc->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_crtc_state *vc4_crtc_state = to_vc4_crtc_state(old_state);
-	u32 chan = vc4_crtc_state->assigned_channel;
-
-	if (HVS_READ(SCALER_DISPCTRLX(chan)) &
-	    SCALER_DISPCTRLX_ENABLE) {
-		HVS_WRITE(SCALER_DISPCTRLX(chan),
-			  SCALER_DISPCTRLX_RESET);
-
-		/* While the docs say that reset is self-clearing, it
-		 * seems it doesn't actually.
-		 */
-		HVS_WRITE(SCALER_DISPCTRLX(chan), 0);
-	}
-
-	/* Once we leave, the scaler should be disabled and its fifo empty. */
-
-	WARN_ON_ONCE(HVS_READ(SCALER_DISPCTRLX(chan)) & SCALER_DISPCTRLX_RESET);
-
-	WARN_ON_ONCE(VC4_GET_FIELD(HVS_READ(SCALER_DISPSTATX(chan)),
-				   SCALER_DISPSTATX_MODE) !=
-		     SCALER_DISPSTATX_MODE_DISABLED);
+	unsigned int chan = vc4_crtc_state->assigned_channel;
 
-	WARN_ON_ONCE((HVS_READ(SCALER_DISPSTATX(chan)) &
-		      (SCALER_DISPSTATX_FULL | SCALER_DISPSTATX_EMPTY)) !=
-		     SCALER_DISPSTATX_EMPTY);
+	vc4_hvs_stop_channel(dev, chan);
 }
 
 void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
-- 
git-series 0.9.1
