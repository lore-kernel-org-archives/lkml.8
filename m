Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46040C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EE12080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="VUY2kQbA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xCn2oNaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgBXJLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:11:53 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:40555 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728244AbgBXJKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:32 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id B0D8960C;
        Mon, 24 Feb 2020 04:10:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=+XZflkMN+F3s2
        aHb7igSvjepl8jJm9YiHUTgsFfZFFY=; b=VUY2kQbAOjCNyQkKO2Zm5VzORmjA+
        jRLWp0LHCS37qoLYraz4yl34DmrY4Tfv1bnIcT4ThCuQLtCHVC9lTgvuRfC4sfHD
        8aYrqTnjWXNoWXTCCRuJ9zm/chZQysL8YI+Pirw8akm71PXiU83uRD1pOv63g6Dt
        iIsDtp3VomdNl0Zb1uXYohPO92+LXHtyT4txSolb1kld1sv43PiXr+x9DcswCylD
        BXvZjn+9wKPIAJWjFvRs5kKyWf5jjU/cN6rR5pbXmvfmLPh4F5d6QuYAe5yy01aA
        34F5zH/eumR+CddBBQ9JT0zyFbmK4Oj639qC3vDOrbyivkbLGqLcCSbIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=+XZflkMN+F3s2aHb7igSvjepl8jJm9YiHUTgsFfZFFY=; b=xCn2oNaa
        V9PLTlOA8wksqUCMvcvAc1oWKVaVzhDHMB7xy195Pk0ewb95xsO0nfa/O5uf+Hso
        DztbThska6ihSatVVUYqL/pefbPjqihPyCNP7iM+x+sreT8uNHOTa73IFLa/axUh
        nyyjGY27XWIRdFsBdaDHuQ+0uzDEKglS/LbWivtnhlazkA7OpreE0JoUX5ROLPgH
        1EY8yl8g14ZTVAGK69B3kV/0y2PoeTNJfacHtvpNJOkwEwXSp7ccgmrL0G2IZ9pY
        xKzcJ99toyjZ2QzeDak0duVnQNv9lpyLRZYX4aqlYmpdO7/wZecqAGDAycdhKzV2
        TPeRJmqNWPy8gw==
X-ME-Sender: <xms:BpNTXqKDmbO8CAW7kH6vfvEn7lOW_dDC6Of7i1brzRIOaXnDQF4sXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:BpNTXovYQOA8BPJ9exFzJS27jZ8JtrnedxyjUUEmgONYfUFoSLysLQ>
    <xmx:BpNTXn5B1lmv6rHlHshTjwV1BeeDxjwXTuuTEQPjdA9Hi0jf02TRbQ>
    <xmx:BpNTXhf4bXAHrMvucG7b8yWILIBgLC8Je2UNOcmyYsnSddkKc3WFgQ>
    <xmx:BpNTXvsz0v5upZY4Hs9bUwUn7khUzzviT9vNBIA2H-wZrqhkPUXM--SMscs>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 00C2C328005A;
        Mon, 24 Feb 2020 04:10:29 -0500 (EST)
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
Subject: [PATCH 70/89] drm/vc4: hdmi: Remove vc4_dev hdmi pointer
Date:   Mon, 24 Feb 2020 10:07:12 +0100
Message-Id: <6d37b2cff8ff9a2076cd6ae5a631a8830eedf89c.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
index 1e44a3a8c2b0..d5c832c99460 100644
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
index 9fec97a328a7..8049a5ba291f 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1184,7 +1184,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 #endif
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = dev_get_drvdata(master);
-	struct vc4_dev *vc4 = drm->dev_private;
 	struct vc4_hdmi *vc4_hdmi;
 	struct drm_encoder *encoder;
 	struct device_node *ddc_node;
@@ -1272,8 +1271,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 		vc4_hdmi->hpd_active_low = hpd_gpio_flags & OF_GPIO_ACTIVE_LOW;
 	}
 
-	vc4->hdmi = vc4_hdmi;
-
 	/* HDMI core must be enabled. */
 	if (!(HD_READ(VC4_HD_M_CTL) & VC4_HD_M_ENABLE)) {
 		HD_WRITE(VC4_HD_M_CTL, VC4_HD_M_SW_RST);
@@ -1354,9 +1351,12 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
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
@@ -1366,8 +1366,6 @@ static void vc4_hdmi_unbind(struct device *dev, struct device *master,
 	pm_runtime_disable(dev);
 
 	put_device(&vc4_hdmi->ddc->dev);
-
-	vc4->hdmi = NULL;
 }
 
 static const struct component_ops vc4_hdmi_ops = {
-- 
git-series 0.9.1
