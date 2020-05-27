Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F1FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26D22088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="vsMIPqHk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IOrnHTla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390370AbgE0PwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:52:00 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50915 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390267AbgE0PvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C8B955820EF;
        Wed, 27 May 2020 11:51:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=a92ye8CT9BQpX
        TwkDsbitHAvM3sVybGIU67y/bytg0o=; b=vsMIPqHk8gloYkblOEfj+UnqSGxxq
        Ff80+kMhIYAvc61uQmJNFeBLXufQG2ue4blxFdLxHUD1suEJ4EvBzf2r/LTBG0CK
        ll0ifLvzGWyMD8nONyzlWJ3pM/NTWhNCK8m0TQLzjx/1Xgz0u8aa+M6hbk4/PI4Z
        9M/1dkRV1LIjw/WcyUPRniR+kNpNE0eL2lhhrWc2e813yiuKWivhUYX8Q5yuOcT2
        cCKzx+1TD3YHCDH3D7XaE1zWmOK4Bv3Sfd4TX1WsBKDqHeenVSgxNQYux0qYz+P5
        cGtbMfBva1BFCAa9vkc9xwcGBzyePZZY+cZtxVu5zv1QLpeWwxHwT1EYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=a92ye8CT9BQpXTwkDsbitHAvM3sVybGIU67y/bytg0o=; b=IOrnHTla
        15u5ko3UssWvooDHsgQaeyiZWX43NnMuekfDQLvMQBxEMFKyKsl7hQqofpywWZCL
        q0u//CElssDKJxrL2FV04Db5YQmqQiIuSGU/0R1mkCpvEWbmtG4FbLs52tw1xNmK
        +86w7E4FEGV3pdPKEtLoAX9hqy+mutJCEgoox03sYSE9RqBEyY1JqWka2+3+lnOR
        U5H4DaEZbM5qtdLLicQcII8yzmHzMUpB3HiBGFdtyyZyQBMEzI+OSiBJP++W4k1F
        71juG1WNtuSiDKFwOEhzGwxarQ9/Uf/SWK7JwEF79iPD48PrphhkXETYgUmlBqcw
        JcoZxul4G0FSiw==
X-ME-Sender: <xms:bYzOXp6U7KwkBA-5l9WQMCjxEO2Ix0A59_K0eHxD1G8K9h7OyxtcFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgephedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:bYzOXm5X33sz3FJN81X6yS538TmuNzGeThOfO8HxAh9nJzaqz_PCvg>
    <xmx:bYzOXgdmbVvgCnPYVk3VMPHLiDsM3Yye7usDENC53jBJdqwLbD-SKA>
    <xmx:bYzOXiInlpwFXRusx37lCnvSXv13zLQQOkKYZTk4e8pi6laKb01LUw>
    <xmx:bYzOXiqZpQLS7ZQpFkVCVeJXaBGWL-Zl_o1c6DRcciJAJ2Di7XMAAg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6CE51306218B;
        Wed, 27 May 2020 11:51:09 -0400 (EDT)
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
Subject: [PATCH v3 071/105] drm/vc4: hdmi: Remove DDC argument to connector_init
Date:   Wed, 27 May 2020 17:48:41 +0200
Message-Id: <2d84b0d8b6cac6207d4e75c6341d127499001670.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
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
index c1cb8790b552..a2f848632e8d 100644
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
@@ -1320,7 +1319,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
 	drm_encoder_helper_add(encoder, &vc4_hdmi_encoder_helper_funcs);
 
-	ret = vc4_hdmi_connector_init(drm, hdmi, hdmi->ddc);
+	ret = vc4_hdmi_connector_init(drm, hdmi);
 	if (ret)
 		goto err_destroy_encoder;
 
-- 
git-series 0.9.1
