Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7A7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DF9206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Ey9Rt8Eh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UbNmBlig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgGHRpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:45:35 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:54855 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727793AbgGHRno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 88335102C;
        Wed,  8 Jul 2020 13:43:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=W8qUCbtVwEZWU
        QZyYrhk1fYDfNGFHsPY5aJEbSxHhR4=; b=Ey9Rt8EhPbdHLdos9+cIyKPdVcz/M
        qz2GudFJ1pVKq6TmCyF1GScV0V45mFxZdCXSmDdJNkTN16+XhSD+SrtNTp88YQPI
        S9XMRHe9JJ25OWMhpC272J1M7JCKO0OE1QxGcRoLa8UfuHZ13x3bRcOKFXqE+8GY
        UpmCFtXEDLO4yktuzgeLw9UgSpzTcEw6Rvlg+p93FQyoDr0JqT5WSx0Fs3/iTA9j
        R4rBuoWpMrqB3jJPhCJ3tkyzltFFxBjGyM0MJ0HpyaZPh0X1xzYlDxKSp7geHBfY
        vb9OR2xd74U5YMUEGZCkw9Uv6EnsMANreYqIiN+jiryupCNvXd+7I7NeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=W8qUCbtVwEZWUQZyYrhk1fYDfNGFHsPY5aJEbSxHhR4=; b=UbNmBlig
        CVY5LK1aBSkEsTk+VgftjcaZZo1/lbG5ngsvR6Wx3QKNKKHiP+TAvgOPOXgrGUp4
        /YCa9J9XEMuChpqnzvsnRYx9zZ4sDH/GzX+ZJcVd7CxqLxrr42XMoWsx7CGZuRzu
        vgW+30h+cudNMh/hv8un8hTqypYkEP9DuVtEXVyEsC1II+rezAGXLCNAUItgDTcP
        I81pMAvRRkIJzin1fe2MbDHXqK2yEgqtIyLLKSpNw4Y15fTorLxDFXTMVSuNKhRz
        5pEf5aheeDBJkpisoe/L5x7pxFA7j8wDUhDFiIXBp8jLd1Sqad+RKIc8Q/MKgKR1
        bEXg9mHrXMcJPQ==
X-ME-Sender: <xms:zwUGX9JHdnTOVCZC8_wDk7LO3t5nu6Dj-F8tbrOoYGz-MEzAC1LYzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepgeeine
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:zwUGX5JccXQElLlssNPfOPBCox86ilmjuoHU40aV1FNiovg8ob6CcA>
    <xmx:zwUGX1vuZ1czXaBBS5I0t2n4g1UdRbbmRXghTPhWnveb3zILOb-Ahg>
    <xmx:zwUGX-aqLYI7Pg2f4s9oV-7Au-WfJJla0PXE8Ah-y9H2JFrNzDULlw>
    <xmx:zwUGX04vExjSED2y8TWC51YKHZWqXrQ3QoWAijVEzcj2ki8j_HSYScouahY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C75C6328005D;
        Wed,  8 Jul 2020 13:43:42 -0400 (EDT)
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
Subject: [PATCH v4 50/78] drm/vc4: hdmi: Introduce resource init and variant
Date:   Wed,  8 Jul 2020 19:41:58 +0200
Message-Id: <ece0d45f529cce9fb64100ddee726b81f7aa247a.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI controllers found in the BCM2711 has a pretty different clock and
registers areas than found in the older BCM283x SoCs.

Let's create a variant structure to store the various adjustments we'll
need later on, and a function to get the resources needed for one
particular version.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 61 +++++++++++++++++++++++------------
 drivers/gpu/drm/vc4/vc4_hdmi.h | 10 ++++++-
 2 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index ec7710dfd04e..ac021e07a8cb 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1179,28 +1179,12 @@ static const struct cec_adap_ops vc4_hdmi_cec_adap_ops = {
 };
 #endif
 
-static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
+static int vc4_hdmi_init_resources(struct vc4_hdmi *vc4_hdmi)
 {
-#ifdef CONFIG_DRM_VC4_HDMI_CEC
-	struct cec_connector_info conn_info;
-#endif
-	struct platform_device *pdev = to_platform_device(dev);
-	struct drm_device *drm = dev_get_drvdata(master);
-	struct vc4_hdmi *vc4_hdmi;
-	struct drm_encoder *encoder;
-	struct device_node *ddc_node;
-	u32 value;
+	struct platform_device *pdev = vc4_hdmi->pdev;
+	struct device *dev = &pdev->dev;
 	int ret;
 
-	vc4_hdmi = devm_kzalloc(dev, sizeof(*vc4_hdmi), GFP_KERNEL);
-	if (!vc4_hdmi)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, vc4_hdmi);
-	encoder = &vc4_hdmi->encoder.base.base;
-	vc4_hdmi->encoder.base.type = VC4_ENCODER_TYPE_HDMI0;
-	vc4_hdmi->pdev = pdev;
-
 	vc4_hdmi->hdmicore_regs = vc4_ioremap_regs(pdev, 0);
 	if (IS_ERR(vc4_hdmi->hdmicore_regs))
 		return PTR_ERR(vc4_hdmi->hdmicore_regs);
@@ -1212,6 +1196,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	vc4_hdmi->hdmi_regset.base = vc4_hdmi->hdmicore_regs;
 	vc4_hdmi->hdmi_regset.regs = hdmi_regs;
 	vc4_hdmi->hdmi_regset.nregs = ARRAY_SIZE(hdmi_regs);
+
 	vc4_hdmi->hd_regset.base = vc4_hdmi->hd_regs;
 	vc4_hdmi->hd_regset.regs = hd_regs;
 	vc4_hdmi->hd_regset.nregs = ARRAY_SIZE(hd_regs);
@@ -1223,12 +1208,44 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 			DRM_ERROR("Failed to get pixel clock\n");
 		return ret;
 	}
+
 	vc4_hdmi->hsm_clock = devm_clk_get(dev, "hdmi");
 	if (IS_ERR(vc4_hdmi->hsm_clock)) {
 		DRM_ERROR("Failed to get HDMI state machine clock\n");
 		return PTR_ERR(vc4_hdmi->hsm_clock);
 	}
 
+	return 0;
+}
+
+static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
+{
+#ifdef CONFIG_DRM_VC4_HDMI_CEC
+	struct cec_connector_info conn_info;
+#endif
+	const struct vc4_hdmi_variant *variant = of_device_get_match_data(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm = dev_get_drvdata(master);
+	struct vc4_hdmi *vc4_hdmi;
+	struct drm_encoder *encoder;
+	struct device_node *ddc_node;
+	u32 value;
+	int ret;
+
+	vc4_hdmi = devm_kzalloc(dev, sizeof(*vc4_hdmi), GFP_KERNEL);
+	if (!vc4_hdmi)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, vc4_hdmi);
+	encoder = &vc4_hdmi->encoder.base.base;
+	vc4_hdmi->encoder.base.type = VC4_ENCODER_TYPE_HDMI0;
+	vc4_hdmi->pdev = pdev;
+	vc4_hdmi->variant = variant;
+
+	ret = variant->init_resources(vc4_hdmi);
+	if (ret)
+		return ret;
+
 	ddc_node = of_parse_phandle(dev->of_node, "ddc", 0);
 	if (!ddc_node) {
 		DRM_ERROR("Failed to find ddc node in device tree\n");
@@ -1404,8 +1421,12 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct vc4_hdmi_variant bcm2835_variant = {
+	.init_resources		= vc4_hdmi_init_resources,
+};
+
 static const struct of_device_id vc4_hdmi_dt_match[] = {
-	{ .compatible = "brcm,bcm2835-hdmi" },
+	{ .compatible = "brcm,bcm2835-hdmi", .data = &bcm2835_variant },
 	{}
 };
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 674541493909..0eaf979fe811 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -21,6 +21,15 @@ to_vc4_hdmi_encoder(struct drm_encoder *encoder)
 	return container_of(encoder, struct vc4_hdmi_encoder, base.base);
 }
 
+struct vc4_hdmi;
+
+struct vc4_hdmi_variant {
+	/* Callback to get the resources (memory region, interrupts,
+	 * clocks, etc) for that variant.
+	 */
+	int (*init_resources)(struct vc4_hdmi *vc4_hdmi);
+};
+
 /* HDMI audio information */
 struct vc4_hdmi_audio {
 	struct snd_soc_card card;
@@ -39,6 +48,7 @@ struct vc4_hdmi {
 	struct vc4_hdmi_audio audio;
 
 	struct platform_device *pdev;
+	const struct vc4_hdmi_variant *variant;
 
 	struct vc4_hdmi_encoder encoder;
 	struct drm_connector connector;
-- 
git-series 0.9.1
