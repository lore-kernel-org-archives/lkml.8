Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CEDC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38CF20700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="tCDQbkVv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjvNQeCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgDXPij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:38:39 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:48511 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728738AbgDXPhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:37:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 9DCB51455;
        Fri, 24 Apr 2020 11:37:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=yGqBIXprQnj9i
        9FIGriRfKU/8rhSDW2zuECeNGxhW5Y=; b=tCDQbkVvRlXhKgzHG27Fi2yZMjpCu
        iUL6yzLaVI8hs4aNhMraS6T0KEFr/7lqxecsMd1hSVkWxhQW+4B0y30sGntv75Vx
        NLBIjWPlLtbBHDA8uAAeYZIRP6kHT8TS5ABH7sX6qs2cRTujGnVhT6McFLzWevYX
        yfJ7kbD2rfHYT7m4r/mmrbyABcYkSrvVGPcLmPcOXtwDcXTS5Crh70HPqQgT4EFO
        urxLLDiGxz12ctVBAuYvWHxucSNkkpU4RwN+Ccy8i9bTHv24DrQIXSwyJ4r0BJvI
        YPmQIPo2T8xb/EIFViMAf0Nmczio4c4WHtRp7NxCoU0YRwHxeTyVb9QCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=yGqBIXprQnj9i9FIGriRfKU/8rhSDW2zuECeNGxhW5Y=; b=hjvNQeCE
        J0sUOrCfv7/H4jD9cyiM24TbkolY27fwdNQ7T3RY+qKAPaUYNvXmqNVUrO2OgbSS
        zigcGS3y+eLUY3gPag50zAHVJnuYo5HIHaMvXrVsAKpZ1t2r/3oOlKMBNQ1kYBXP
        FZC+G8wskSqh8nThbv1UJLSojeHKJWtwWG3yKPo/N8wjF1Ar6YNRoVAYtPGKW3z4
        oIvtVGUCdxzWJYBE8FataBem0rKrd0f94eqKk1PJaM4ajRTKOyXCjsqUVPzp4i2m
        SwgcAzqWj6RNKDUyJ4zVHJRmrHM1G6fItKm3KfjQZRJVRWFzafa8kZB2u2RALxze
        /YZrztvPVySHhQ==
X-ME-Sender: <xms:nAejXoeNDYscxDKVN93I0qhUdEOcxmSxfjn4wRE5cD7cSNzFfeGj9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeeivdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:nAejXsMTzetJnmmDBqvLrllnt59pwmcogqIULXSYncm136IsoqeGVg>
    <xmx:nAejXt1QEaofDKDOZcQwt6FJ-ioOLqxQtGdTTnz1ViOi59n11IXPig>
    <xmx:nAejXmIYpkvO-DwvSh6RpFnTjRhxNpLXJzhgObGuwI-dvbR4SQc6Vw>
    <xmx:nAejXpCLNFpXUa4zt_q-QTu17I5h3TV3YSXo51dnlItHaSZQ61gSv8Lxl7k>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D9A72328006C;
        Fri, 24 Apr 2020 11:36:59 -0400 (EDT)
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
Subject: [PATCH v2 70/91] drm/vc4: hdmi: Remove vc4_dev hdmi pointer
Date:   Fri, 24 Apr 2020 17:34:51 +0200
Message-Id: <d8de82714b7370db4e7c064ab4d57f3d5f16041b.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we don't have any users anymore, we can kill that pointer.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h  |  1 -
 drivers/gpu/drm/vc4/vc4_hdmi.c | 14 ++++++--------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 39b0d5ee1eba..d70421aab2d0 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -73,7 +73,6 @@ struct vc4_perfmon {
 struct vc4_dev {
 	struct drm_device *dev;
 
-	struct vc4_hdmi *hdmi;
 	struct vc4_hvs *hvs;
 	struct vc4_v3d *v3d;
 	struct vc4_dpi *dpi;
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index c3f97e833555..93c9ed7c16cf 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1196,7 +1196,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 #endif
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = dev_get_drvdata(master);
-	struct vc4_dev *vc4 = drm->dev_private;
 	struct vc4_hdmi *vc4_hdmi;
 	struct drm_encoder *encoder;
 	struct device_node *ddc_node;
@@ -1284,8 +1283,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 		vc4_hdmi->hpd_active_low = hpd_gpio_flags & OF_GPIO_ACTIVE_LOW;
 	}
 
-	vc4->hdmi = vc4_hdmi;
-
 	/* HDMI core must be enabled. */
 	if (!(HD_READ(VC4_HD_M_CTL) & VC4_HD_M_ENABLE)) {
 		HD_WRITE(VC4_HD_M_CTL, VC4_HD_M_SW_RST);
@@ -1366,9 +1363,12 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 static void vc4_hdmi_unbind(struct device *dev, struct device *master,
 			    void *data)
 {
-	struct drm_device *drm = dev_get_drvdata(master);
-	struct vc4_dev *vc4 = drm->dev_private;
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
+	/*
+	 * snd_soc_register_card will set the device drvdata pointer
+	 * to the card being registered.
+	 */
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+	struct vc4_hdmi *vc4_hdmi = snd_soc_card_get_drvdata(card);
 
 	cec_unregister_adapter(vc4_hdmi->cec_adap);
 	vc4_hdmi_connector_destroy(&vc4_hdmi->connector.base);
@@ -1378,8 +1378,6 @@ static void vc4_hdmi_unbind(struct device *dev, struct device *master,
 	pm_runtime_disable(dev);
 
 	put_device(&vc4_hdmi->ddc->dev);
-
-	vc4->hdmi = NULL;
 }
 
 static const struct component_ops vc4_hdmi_ops = {
-- 
git-series 0.9.1
