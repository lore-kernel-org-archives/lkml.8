Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DB0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0472088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="enWpqU5L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CkXK/ozQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgE0PvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:25 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:55211 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730592AbgE0Pur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D4E365820B3;
        Wed, 27 May 2020 11:50:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Bt8lRxl4j58Jf
        Ps2a5AygXRQeW3N7bjCgRjDpST9xfU=; b=enWpqU5LpSJ3fs2m07iFhnq3jv7ET
        +NE1Sd3+zRcTpaV3G+jgUNiZYtYNrBW0KqE9Bes6vkyxUY+6XiTP5DUJ3I0C0SjA
        d1hl1SQrFYtDZJCMEJSMs1PMhrlXQmoABpLkKpJm8gjdJFs1eTZEQ5NtGe/8DKLm
        L9BOdKYdykev6BWmVOLK4/SWMXoJz1otgyaVE8AzqbjcSeKfA18qFJfVXQzen6aF
        nadWz7rR04dfZdm56rIIb+JdvJJAGdQ87VnUkGokiBDDw5oEfg3sSy92fISnHrr5
        4t8r6eU6u5UUeSIoBtmfHWJG8/iwWdI+wnz2b7vd3cqai3Fwy2KJ3NIzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Bt8lRxl4j58JfPs2a5AygXRQeW3N7bjCgRjDpST9xfU=; b=CkXK/ozQ
        hRZYyq5lmmW4d01vg2QSonAM21yQ38fXu2mUdofKeT858otn3bbWlIxgWKCZ40dX
        Lta1xSeah/bzrLUangEn4YMmBe/syrt3BsOVZClgTIUoTBS7WTOpscWyDKD3wZYT
        H72rhke10CrhJIalA8a5qIPRDLOFpknqJRO3Sz2sCEkjOfLgR10uHJvZeUL1Qg1A
        TaitZong0i0HXxq6yl6kZnKw5gaVi0B4oIadTBLHkjoNYNqqGpc59M+FtL40Tqaf
        1vGaqn702P8yoZ0XpL/LUIpBO9I7R/jfAZh9TAIffqXvEmtQ/tn3R2DgbWq20lwK
        2WXipWmyihkrqg==
X-ME-Sender: <xms:VozOXu-49Xc_B7a8JJxYWnEa_9_6qLsTJGqJdbkSmHuhCkUn1rM-iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeeine
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:VozOXuuTEN7kF5TjtebZUHD6hxJIE7ZncjVNyVc65Enbh_BY3osvkw>
    <xmx:VozOXkB1-I_6Mf17CRlmJ-OdVyV2SPVAgMZjkgJwi2MdxLWJZPMniQ>
    <xmx:VozOXmfYBGLvbvt_M_ED9VCAPmC30ARXg4v2ZghfbfmiwUpj-T3vnw>
    <xmx:VozOXufuQpxWAYEo085XcXcPHWjCIcW1jfUupRWz1EHfpJt8vSLbyA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 759D83280059;
        Wed, 27 May 2020 11:50:46 -0400 (EDT)
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
Subject: [PATCH v3 056/105] drm/vc4: crtc: Move the CRTC disable out
Date:   Wed, 27 May 2020 17:48:26 +0200
Message-Id: <601527fea6bb226abd088a864e74b25368218e87.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll need to reuse the part that disables the HVS and PixelValve during
boot too, so let's create a separate function.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index ecb3431470dd..3d2a31cad7fa 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -382,20 +382,14 @@ static void require_hvs_enabled(struct drm_device *dev)
 		     SCALER_DISPCTRL_ENABLE);
 }
 
-static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
-				    struct drm_crtc_state *old_state)
+static int vc4_crtc_disable(struct drm_crtc *crtc, unsigned int channel)
 {
-	struct drm_device *dev = crtc->dev;
-	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
 	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
+	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
 	int ret;
 
-	require_hvs_enabled(dev);
-
-	/* Disable vblank irq handling before crtc is disabled. */
-	drm_crtc_vblank_off(crtc);
-
 	CRTC_WRITE(PV_V_CONTROL,
 		   CRTC_READ(PV_V_CONTROL) & ~PV_VCONTROL_VIDEN);
 	ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
@@ -403,15 +397,31 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	mdelay(20);
 
-	if (vc4_encoder->post_crtc_disable)
+	if (vc4_encoder && vc4_encoder->post_crtc_disable)
 		vc4_encoder->post_crtc_disable(encoder);
 
 	vc4_crtc_pixelvalve_reset(crtc);
-	vc4_hvs_atomic_disable(crtc, old_state);
+	vc4_hvs_stop_channel(dev, channel);
 
-	if (vc4_encoder->post_crtc_powerdown)
+	if (vc4_encoder && vc4_encoder->post_crtc_powerdown)
 		vc4_encoder->post_crtc_powerdown(encoder);
 
+	return 0;
+}
+
+static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
+				    struct drm_crtc_state *old_state)
+{
+	struct vc4_crtc_state *old_vc4_state = to_vc4_crtc_state(old_state);
+	struct drm_device *dev = crtc->dev;
+
+	require_hvs_enabled(dev);
+
+	/* Disable vblank irq handling before crtc is disabled. */
+	drm_crtc_vblank_off(crtc);
+
+	vc4_crtc_disable(crtc, old_vc4_state->assigned_channel);
+
 	/*
 	 * Make sure we issue a vblank event after disabling the CRTC if
 	 * someone was waiting it.
-- 
git-series 0.9.1
