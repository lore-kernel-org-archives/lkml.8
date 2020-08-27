Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9206AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BD522B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="n2YHnww1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgH0MEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:04:47 -0400
Received: from crapouillou.net ([89.234.176.41]:53434 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgH0LpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598528653; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CaXO/FHoFYfgXhxVRq9pV9SMEDuKES3g1VebrWz0buI=;
        b=n2YHnww1LEhzxT1imiV3w0YTWRTyD1v56Sum2sZyzWs4tiwlhplZsosAq+Kd8elGfdOXD6
        /zva/HE8BKHUu9FhJylGX7G78PxmwcFxbFv4k3BGHSGCAIcSmPJEZFPeWrdGTR/nymnzqh
        zaqwvZgFDmPcDI4hBpvic0KVkiVL8cM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/2] drm/ingenic: Fix driver not probing when IPU port is missing
Date:   Thu, 27 Aug 2020 13:44:04 +0200
Message-Id: <20200827114404.36748-2-paul@crapouillou.net>
In-Reply-To: <20200827114404.36748-1-paul@crapouillou.net>
References: <20200827114404.36748-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if support for the IPU was compiled in, we may run on a device
(e.g. the Qi LB60) where the IPU is not available, or simply with an old
devicetree without the IPU node. In that case the ingenic-drm refused to
probe.

Fix the driver so that it will probe even if the IPU node is not present
in devicetree (but then IPU support is disabled of course).

v2: Take a different approach

Fixes: fc1acf317b01 ("drm/ingenic: Add support for the IPU")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index c1bcb93aed2d..b7074161ccf0 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -673,7 +673,7 @@ static void ingenic_drm_unbind_all(void *d)
 	component_unbind_all(priv->dev, &priv->drm);
 }
 
-static int ingenic_drm_bind(struct device *dev)
+static int ingenic_drm_bind(struct device *dev, bool has_components)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	const struct jz_soc_info *soc_info;
@@ -808,7 +808,7 @@ static int ingenic_drm_bind(struct device *dev)
 			return ret;
 		}
 
-		if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU)) {
+		if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU) && has_components) {
 			ret = component_bind_all(dev, drm);
 			if (ret) {
 				if (ret != -EPROBE_DEFER)
@@ -939,6 +939,11 @@ static int ingenic_drm_bind(struct device *dev)
 	return ret;
 }
 
+static int ingenic_drm_bind_with_components(struct device *dev)
+{
+	return ingenic_drm_bind(dev, true);
+}
+
 static int compare_of(struct device *dev, void *data)
 {
 	return dev->of_node == data;
@@ -957,7 +962,7 @@ static void ingenic_drm_unbind(struct device *dev)
 }
 
 static const struct component_master_ops ingenic_master_ops = {
-	.bind = ingenic_drm_bind,
+	.bind = ingenic_drm_bind_with_components,
 	.unbind = ingenic_drm_unbind,
 };
 
@@ -968,14 +973,12 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	struct device_node *np;
 
 	if (!IS_ENABLED(CONFIG_DRM_INGENIC_IPU))
-		return ingenic_drm_bind(dev);
+		return ingenic_drm_bind(dev, false);
 
 	/* IPU is at port address 8 */
 	np = of_graph_get_remote_node(dev->of_node, 8, 0);
-	if (!np) {
-		dev_err(dev, "Unable to get IPU node\n");
-		return -EINVAL;
-	}
+	if (!np)
+		return ingenic_drm_bind(dev, false);
 
 	drm_of_component_match_add(dev, &match, compare_of, np);
 	of_node_put(np);
-- 
2.28.0

