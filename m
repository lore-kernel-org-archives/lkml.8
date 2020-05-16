Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B229CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 21:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D146206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 21:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ZQVrMyXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgEPVwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 17:52:21 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47514 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgEPVwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 17:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1589665878; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=moh7L+tXahMvSeqwa+PqHe9UfRg6MjJ0Bt7xlZA4y9U=;
        b=ZQVrMyXrtWTnjWN9LO+fOR6y/FafXOuANo4VfVU5xfOOJIVdAtfUiGnds8JX4KgM7PLRrS
        SpR8Lr9sqr9/6T2G2Y6C80bQxOoxSYxTLvqVwqyrJ4KSNOMWsuNFclzQA/qcOBxvnb6cc7
        6R5BkmGj3ZJJoUJ0TFSEHSpmSWDZ0TQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 10/12] gpu/drm: Ingenic: Register driver as component master
Date:   Sat, 16 May 2020 23:50:55 +0200
Message-Id: <20200516215057.392609-10-paul@crapouillou.net>
In-Reply-To: <20200516215057.392609-1-paul@crapouillou.net>
References: <20200516215057.392609-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the ingenic-drm driver as a component master.

This will later allow to plug optional components to the driver, for
instance to add support for the IPU, or the SLCD module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 61 +++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index f139af5b7a40..b53db3ee001f 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -6,6 +6,7 @@
 
 #include "ingenic-drm.h"
 
+#include <linux/component.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
@@ -613,10 +614,17 @@ static void ingenic_drm_free_dma_hwdesc(void *d)
 			  priv->dma_hwdesc[1], priv->dma_hwdesc_phys[1]);
 }
 
-static int ingenic_drm_probe(struct platform_device *pdev)
+static void ingenic_drm_unbind_all(void *d)
 {
+	struct ingenic_drm *priv = d;
+
+	component_unbind_all(priv->dev, &priv->drm);
+}
+
+static int ingenic_drm_bind(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
 	const struct jz_soc_info *soc_info;
-	struct device *dev = &pdev->dev;
 	struct ingenic_drm *priv;
 	struct clk *parent_clk;
 	struct drm_bridge *bridge;
@@ -653,6 +661,17 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	drm->mode_config.max_height = 4095;
 	drm->mode_config.funcs = &ingenic_drm_mode_config_funcs;
 
+	ret = component_bind_all(dev, drm);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to bind components: %i", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, ingenic_drm_unbind_all, priv);
+	if (ret)
+		return ret;
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
 		dev_err(dev, "Failed to get memory resource");
@@ -843,9 +862,14 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ingenic_drm_remove(struct platform_device *pdev)
+static int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static void ingenic_drm_unbind(struct device *dev)
 {
-	struct ingenic_drm *priv = platform_get_drvdata(pdev);
+	struct ingenic_drm *priv = dev_get_drvdata(dev);
 
 	if (priv->lcd_clk)
 		clk_disable_unprepare(priv->lcd_clk);
@@ -853,6 +877,35 @@ static int ingenic_drm_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(&priv->drm);
 	drm_atomic_helper_shutdown(&priv->drm);
+}
+
+static const struct component_master_ops ingenic_master_ops = {
+	.bind = ingenic_drm_bind,
+	.unbind = ingenic_drm_unbind,
+};
+
+static int ingenic_drm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct component_match *match = NULL;
+	struct device_node *np;
+	unsigned int i;
+
+	/* Probe components at port address 8 and upwards */
+	for (i = 8; ; i++) {
+		np = of_graph_get_remote_node(dev->of_node, i, 0);
+		if (!np)
+			break;
+
+		drm_of_component_match_add(dev, &match, compare_of, np);
+	}
+
+	return component_master_add_with_match(dev, &ingenic_master_ops, match);
+}
+
+static int ingenic_drm_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &ingenic_master_ops);
 
 	return 0;
 }
-- 
2.26.2

