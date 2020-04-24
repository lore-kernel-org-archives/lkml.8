Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D732C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9732084D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Rb88M8Lo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s9YK70OA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgDXPiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:38:52 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:46119 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728681AbgDXPgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 42E5E1448;
        Fri, 24 Apr 2020 11:36:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=asGQCYI8B0Fsa
        QYIYT8hwgAfkciP2fjwzTYJ5GfBnVw=; b=Rb88M8Lotjs13+oJgdw6Gf1TSZowv
        uM6uk3W/4iipyAr7sMD3PFytraD+DTed7TVl8/aRyWcu2A8TK5vDYg5ChTHucAXZ
        Y4+IJFCGZs1fRto9x7tT2a1TDyFoQtvH2yE8W4tv2UqclZ6s1Jlh611f+aw6F0EI
        5FfZFM9RoGMK1LibgHkZQzLtk5Ip9HjylFOey2WVHyt8CfDWJY05tMBUwL0FYXMP
        FDfu0qqEqfnXXnppHyj+oe/KinDkSx/Uf52QzR7Lm8wz9xejroysdfQmc8QyR3al
        6tml6oQWIC/9/os4W4deRixLoT+9Sy0jkOmMCQwrUuLvoe+HJlG8+dMUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=asGQCYI8B0FsaQYIYT8hwgAfkciP2fjwzTYJ5GfBnVw=; b=s9YK70OA
        Ee4Ea7u9ogsu3p61VwJ6giiS0bDFrwtalthvZIAB6YPMVP/0ranNUpfpOCFJ1gzL
        KxcnhJ7RXrVXmg3BHAP1RVh7L3TVRJQJ2XpVgEkRy30560HcGrWTZP8AlwTTx5pn
        CD+mMcf4xrEuVBhahMQxbjyrJUbhzEU3hxxobDv/QmvCeNgLbW2OWFsaF6+CQ+8Y
        FWlfxlkzEh/MfvD/l/xWsU96yIeAB8uIzvdDVKSqBMK7HWhcm3Yj1ySSQgcZCJz0
        wldDqUqpkny08Frjdq9rJh9shDb9ATpDlDcM4U7SunZzS5Eghou0uuqm7nPolfJA
        1Q0IoHlM1byKxw==
X-ME-Sender: <xms:kwejXkk9ACMhBJdSygTfJKyYYLxRicR9uTNgV_IT6TZXh8Mnwakc8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeehheenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:kwejXj8_MS5LxSauV8uoIBuBgGFJjckEjNWHWB-Il49xxRlt08gQgA>
    <xmx:kwejXqGcE2Hsj9VvtGTBpiY3gb1ftTbK8Ta1NSl_Oh5HKnVTVNQLGg>
    <xmx:kwejXnL2RKNC4kQOM1ruqCqYUMTosbrxVZad9skI7rqRPI-W6ddJCg>
    <xmx:kwejXuu7v93QKKY6U5sY-LK73q6LIE2mgeZHzZjZUp2w5LMvKvOo1GDZlGs>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 80D493280068;
        Fri, 24 Apr 2020 11:36:51 -0400 (EDT)
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
Subject: [PATCH v2 64/91] drm/vc4: hdmi: Remove DDC argument to connector_init
Date:   Fri, 24 Apr 2020 17:34:45 +0200
Message-Id: <3c5197d086da18a2b0d637b6ab10f3a05e63fd52.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we are passing the vc4_hdmi structure to the connector init
function, we can simply use the pointer in that structure instead of
having the pointer as an argument.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index ba3b589af30d..32de99d48a2a 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -191,8 +191,7 @@ static const struct drm_connector_helper_funcs vc4_hdmi_connector_helper_funcs =
 };
 
 static int vc4_hdmi_connector_init(struct drm_device *dev,
-				   struct vc4_hdmi *vc4_hdmi,
-				   struct i2c_adapter *ddc)
+				   struct vc4_hdmi *vc4_hdmi)
 {
 	struct vc4_hdmi_connector *hdmi_connector = &vc4_hdmi->connector;
 	struct drm_connector *connector = &hdmi_connector->base;
@@ -204,7 +203,7 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
 	drm_connector_init_with_ddc(dev, connector,
 				    &vc4_hdmi_connector_funcs,
 				    DRM_MODE_CONNECTOR_HDMIA,
-				    ddc);
+				    vc4_hdmi->ddc);
 	drm_connector_helper_add(connector, &vc4_hdmi_connector_helper_funcs);
 
 	/* Create and attach TV margin props to this connector. */
@@ -1329,7 +1328,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 			 DRM_MODE_ENCODER_TMDS, NULL);
 	drm_encoder_helper_add(encoder, &vc4_hdmi_encoder_helper_funcs);
 
-	ret = vc4_hdmi_connector_init(drm, hdmi, hdmi->ddc);
+	ret = vc4_hdmi_connector_init(drm, hdmi);
 	if (ret)
 		goto err_destroy_encoder;
 
-- 
git-series 0.9.1
