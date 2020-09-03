Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47744C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128F320767
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="c+s/IEs8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jINBPKGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgICIFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:05:15 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:41843 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728232AbgICICz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 703F3B44;
        Thu,  3 Sep 2020 04:02:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=t6YKz0s4uqL7c
        rKb1yiXPGovELO7Uq6rm4zeG9kzD20=; b=c+s/IEs8krpgBfHGFbYYJLGMaA4Im
        CdvNd2WipuAMs1gypWIyRoGXAXr5PasZCyBWQ1TdRcVhQpQuT3drlTE33XtnWwl0
        tGzL16sakjyGR39ObTm7meTHmz49NoooIGEuvlGVDycRdeRpsGf3QqSDEGo7+QUo
        S4EjOh8/Y/3WyV1tnPOElTMTFsNe9PojZq9rMP0KmXPcE0AN5339fVGJQojcgh//
        DAS/PEdCSwll4yv8KQsyLaH/62z4ppkXihhTKeuAtJK/rvKJvYX+hQw5bYMGtxzS
        Yl84S2DlLKlbwgTbbjHyfiqx6mt2dwoGS89zA+mWVbhpAlftByGWoniAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=t6YKz0s4uqL7crKb1yiXPGovELO7Uq6rm4zeG9kzD20=; b=jINBPKGT
        dMoqVCd/MGxLm5z2pi7LJA7KrWDL2B8vzuJEOu+8r+x64hMFZqWwpRKBdfWYuMDu
        8oGuDqgb3u8qeojB6w0TJJY3auTe9fbpZeSNLpo2EgoMDCNi/9A0sblGCaqsrPXw
        1/zveDi9ksR0YpAhcwOw+PDd7yG0c7B5A3n397L4IAmMtJEgUJ65MhkYf6jwtav5
        CdkkepKoEIYDVs3oKkelIQsRDIz2H6kLxcvk8INb7TckXR+N63kfqqkHMb54A8yR
        R/uwLPfUN90d6lElwgoMlKRrCNjzNhAWJG3YtQL5h8ROHcLNXxkw1OPnvLU9tddR
        SjSLYrJ8cN4ifA==
X-ME-Sender: <xms:KqNQXxwH-0osK_d4BM1_KeJ4E9S8kU6plFRFt_jXc9bX9h_lVrPFyw>
    <xme:KqNQXxRLC5P6MTBJzrqgD0CwjCR_gZZTcUdzPpkx1TeMV9VnpDDHVMyf4X-MGVmmQ
    fmZZflMg94TDtukJ8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeefie
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:KqNQX7VHE0cBTQ12Mh3opKYroCCnh6PVazXgsa2QlYTpKJ60_rePPQ>
    <xmx:KqNQXziSYetknAVlt_lGclPhdme_ZUQmVffrBo2tBpM9kcV0Nfl4kg>
    <xmx:KqNQXzBWzXkSIcmpe685oaoV48ParPoaOlsi4AS0uM2soNuCyr19dQ>
    <xmx:K6NQXwK2OmOMRHSk04raWS-PXWgt7-NSoHIqbUmbJKOZq-oiU6Z7IDZOs0U>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A91C2306005F;
        Thu,  3 Sep 2020 04:02:50 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 41/80] drm/vc4: hdmi: Remove DDC argument to connector_init
Date:   Thu,  3 Sep 2020 10:01:13 +0200
Message-Id: <4fe1b45fe45e4ba57d40154da010807d4e5db86c.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we are passing the vc4_hdmi structure to the connector init
function, we can simply use the pointer in that structure instead of
having the pointer as an argument.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 9a0612a87fb8..1f350b068fcd 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -192,8 +192,7 @@ static const struct drm_connector_helper_funcs vc4_hdmi_connector_helper_funcs =
 };
 
 static int vc4_hdmi_connector_init(struct drm_device *dev,
-				   struct vc4_hdmi *vc4_hdmi,
-				   struct i2c_adapter *ddc)
+				   struct vc4_hdmi *vc4_hdmi)
 {
 	struct vc4_hdmi_connector *hdmi_connector = &vc4_hdmi->connector;
 	struct drm_connector *connector = &hdmi_connector->base;
@@ -205,7 +204,7 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
 	drm_connector_init_with_ddc(dev, connector,
 				    &vc4_hdmi_connector_funcs,
 				    DRM_MODE_CONNECTOR_HDMIA,
-				    ddc);
+				    vc4_hdmi->ddc);
 	drm_connector_helper_add(connector, &vc4_hdmi_connector_helper_funcs);
 
 	/* Create and attach TV margin props to this connector. */
@@ -1322,7 +1321,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
 	drm_encoder_helper_add(encoder, &vc4_hdmi_encoder_helper_funcs);
 
-	ret = vc4_hdmi_connector_init(drm, hdmi, hdmi->ddc);
+	ret = vc4_hdmi_connector_init(drm, hdmi);
 	if (ret)
 		goto err_destroy_encoder;
 
-- 
git-series 0.9.1
