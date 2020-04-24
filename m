Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08120C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA00E20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="lr9KzQs/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/cZ5FqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgDXPgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:36:50 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:57687 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728623AbgDXPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id AC9581338;
        Fri, 24 Apr 2020 11:36:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=QAeVeBo6+3ux5
        I50mqwPBG2WScV4KSYmaFwSrmlI6vQ=; b=lr9KzQs/t704ccQpCkLSVJXu8QemU
        Zm2qTAj/3JO1vLzuMxMcI/VAGVdULa6q7HV3MtDDpgE9nMWNi1EdnttaYdtM+Aa5
        CgVPPiuqz7U9kTOWt/pxTzm1BIqtS5jmsoJm2cldvz+ymm1FcQ0M2yoSDmLNVS7b
        xzkGhLQTm9RTsZRC5dlXWU9LonCHGBZULUi8fE7IGyhN6VYOgvA+Ayxk8TaLAQ1b
        chApNJB1gWfkJbSNKtoJIP5poRbAQMDrVCGEsfTY3iqOVTzEnSUT8r2hppt8rXTd
        6mwzMJbpdXGq8x3qRH4GDh9uyKw0Q6hMa2RckX+UYtGSPpzm9iUAoyXBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=QAeVeBo6+3ux5I50mqwPBG2WScV4KSYmaFwSrmlI6vQ=; b=A/cZ5FqH
        /P0Y88syrxX9GvRqSvX6Q6c6hULqR1+hrRKeuxAa/C7T56WXYOJJGevlxivcg3ht
        LG8NamSDkw6PNmH4WYTEpV1Cgv1UDYrVYJSQObEFEnyECFAP9SOKUPHLxv4xbhIL
        jBNFeYejAoSuZL/FDbzC5uyob+gJ0eHJoLMrKS6PnZsaHFw19V6dNGNS8FmhIMjr
        qL2J1XBAWDfMpYUzul/Ik6902BiKgPxFOqzP8zcvhO7dz3csZltTrGoCbx75PxYc
        GJ8gm922gdCM4WFO89Uq40FKkeG1mQkc5z8u4xF9qzZ64JsaP47ACxRPmG3YUsg0
        AwrFajApdbkBIg==
X-ME-Sender: <xms:hwejXqk3AMIt_b6FzD6smnyYy3YSXQuL9M8F3_rK7BG8pxzaLU_KwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeegjeenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:hwejXhj3nUsyKH1IPlZmwd0gDjXqBlUmqnLMA4lgYM0vqLvMaprKhQ>
    <xmx:hwejXul3_6ZNAaf8YGf-pEz8fVeT72kROiGI_gl6s9bg_o_idLyhYQ>
    <xmx:hwejXo0g9XD0BziPZ5TgL2BhxYi44TMXMaKGgf8kQyWz9sRxjWVMRg>
    <xmx:hwejXjiKR5D0foAmePtGxSxgg5HCJS6ArApx346HIrAu1ud8olmn5WWyBLY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E80033065DA3;
        Fri, 24 Apr 2020 11:36:38 -0400 (EDT)
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
Subject: [PATCH v2 55/91] drm/vc4: crtc: Rename HDMI encoder type to HDMI0
Date:   Fri, 24 Apr 2020 17:34:36 +0200
Message-Id: <57afdd5800dd9aa247d41b73df71f34a2d6f06c3.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous generations were only supporting a single HDMI controller, but
that's about to change, so put an index as well to differentiate between
the two controllers.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 2 +-
 drivers/gpu/drm/vc4/vc4_drv.h  | 2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index d4b490e3f2b8..22c0cd0dfc46 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1113,7 +1113,7 @@ static const struct vc4_crtc_data bcm2835_pv2_data = {
 	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
-		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_HDMI,
+		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_HDMI0,
 		[PV_CONTROL_CLK_SELECT_VEC] = VC4_ENCODER_TYPE_VEC,
 	},
 };
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 1ac27f8ec725..e480839c1056 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -429,7 +429,7 @@ to_vc4_plane_state(struct drm_plane_state *state)
 
 enum vc4_encoder_type {
 	VC4_ENCODER_TYPE_NONE,
-	VC4_ENCODER_TYPE_HDMI,
+	VC4_ENCODER_TYPE_HDMI0,
 	VC4_ENCODER_TYPE_VEC,
 	VC4_ENCODER_TYPE_DSI0,
 	VC4_ENCODER_TYPE_DSI1,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 340719238753..7e2d3ec311e3 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1317,7 +1317,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 					GFP_KERNEL);
 	if (!vc4_hdmi_encoder)
 		return -ENOMEM;
-	vc4_hdmi_encoder->base.type = VC4_ENCODER_TYPE_HDMI;
+	vc4_hdmi_encoder->base.type = VC4_ENCODER_TYPE_HDMI0;
 	hdmi->encoder = &vc4_hdmi_encoder->base.base;
 
 	hdmi->pdev = pdev;
-- 
git-series 0.9.1
