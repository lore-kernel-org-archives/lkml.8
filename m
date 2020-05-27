Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A5AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917022088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="VmBFaM76";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cghlw0OL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbgE0PvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:15 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47187 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730587AbgE0Puo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id B3FBC5820B3;
        Wed, 27 May 2020 11:50:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=P60EMhfBagvbN
        CYsash0laZNNpJmdalqtze5MocJiC8=; b=VmBFaM76vEge6Z0d+XLGWJbq05u6y
        nT3QKUCyo/p2UmRZ4A/I7yujmq3lj4IJvHIsXuQZ/ZJBk9CANQrlILyPXIUzDjEm
        pKmrfYdt91xFxzH5umMh64X6FfVAdxOCqVK079lqbAYt5cfgSxdOsQr6pSBg/ikw
        +BJFd7bxwpFuXq1f6Gs+8pNP9A5lXrDa4Cygv4TFX7hx3SThjd4jwKHXMttPFXHY
        Mbd9MtHzIDPg9OIOiRis8CAv0S7j84WuWQPkMma9qwfRGafBLinKD7yOjkQcNi8/
        4ERSVQiKCSnsQqsqZZtDrRZjcUH8Da9hyvA3GhHZ9chVnGStjj6UVEkTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=P60EMhfBagvbNCYsash0laZNNpJmdalqtze5MocJiC8=; b=Cghlw0OL
        YCDeBLvW+8F/luj+HI3Wa768qbFC3ek/HT9XPMraN+d5wXtavtE/MD95rkEfVF85
        RK2va8xxAlcJ0XhD0ctB7AqsfA0uTZ1QGE1NOKKp8QVrfcp1OrR7xzfMT4+k4TwG
        L2SpSlvf+w+UykdNeYrLswnDCgQoSfkTdjo3e6bqz7H/Qv7Ujp6ByqkK6JwuBW5B
        oHnk/Im77LVeJFbMIakR9rWtanMOBAQl9vykPpKO01d97K1dQFPTdu8jsIiPH2ip
        XgUIFriyWF96MmiBi91CUA1kytHBm1JkyX+bVd0diq/0Tc14+Jz8c7kbKxAoh2nc
        j9bfBcUuephtIg==
X-ME-Sender: <xms:U4zOXgFzBz6z5_9ldDZCALE2zp6bQ-dD52RT_v5J2nvWgtjReNQnyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeeine
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:U4zOXpX5YEXhimSsHOrXSqTe-RhpnEwghXvESkWMbGjvdLDAUJN7-g>
    <xmx:U4zOXqJ6Qu0_Gw0uZ-C32Pz4nnUgXuQRVDfO4qU3Me8mIJcFMEJInA>
    <xmx:U4zOXiEvt40mYFqEJ_Ovxdquj_SOqtIJGV3NyIc8lQcq2TV6ZXMV5Q>
    <xmx:U4zOXhETgEknnihzYaOUMqffcPGRph0zJ7Dp8U4B6Su0afnJYzN1xg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 69D953280066;
        Wed, 27 May 2020 11:50:43 -0400 (EDT)
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
Subject: [PATCH v3 054/105] drm/vc4: hvs: Make the stop_channel function public
Date:   Wed, 27 May 2020 17:48:24 +0200
Message-Id: <4e35aebe56e1bb32d3b64012cf0d455f1b32ef28.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the transition from the firmware to the KMS driver, we need to pay
particular attention to how we deal with the pixelvalves that have already
been enabled, otherwise either timeouts or stuck pixels can occur. We'll
thus need to call the function to stop an HVS channel at boot.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 1 +
 drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index ba24bad86905..d51b695732e0 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -879,6 +879,7 @@ void vc4_irq_reset(struct drm_device *dev);
 
 /* vc4_hvs.c */
 extern struct platform_driver vc4_hvs_driver;
+void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int output);
 int vc4_hvs_atomic_check(struct drm_crtc *crtc, struct drm_crtc_state *state);
 void vc4_hvs_atomic_enable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
 void vc4_hvs_atomic_disable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index ec58870acb7b..1785c49534cf 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -248,7 +248,7 @@ static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
 	return 0;
 }
 
-static void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int chan)
+void vc4_hvs_stop_channel(struct drm_device *dev, unsigned int chan)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
-- 
git-series 0.9.1
