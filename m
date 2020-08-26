Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B4BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D13207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="hY4vPD5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHZV6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:58:51 -0400
Received: from crapouillou.net ([89.234.176.41]:49520 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgHZV6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598479127; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=bRCp5vcWTky3iTd5PZ1Z6XLTrhMKj3XeGXpN/nxGfeI=;
        b=hY4vPD5GE+0PDSFtB4yHUAnRiuQli9jupWKrivpuPhvhOxGe+DkVuJabYstRjHvFTqmeDD
        k5Liu+qzUlm6IXouOMy+iWQhlQ5S+LKuzTfYGgoaY6E8ldC1VZ2QK9IbVXblUg4eL1k9xF
        6xk4L47EhZDgnJgHNEUTErkxREIDv5g=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        MIPS Creator CI20 Development 
        <mips-creator-ci20-dev@googlegroups.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] drm/ingenic: Fix driver not probing when IPU port is missing
Date:   Wed, 26 Aug 2020 23:58:41 +0200
Message-Id: <20200826215841.131707-1-paul@crapouillou.net>
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

Fixes: fc1acf317b01 ("drm/ingenic: Add support for the IPU")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index ada990a7f911..216b67f1672e 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -673,6 +673,18 @@ static void ingenic_drm_unbind_all(void *d)
 	component_unbind_all(priv->dev, &priv->drm);
 }
 
+static inline struct device_node *ingenic_drm_get_ipu_node(struct device *dev)
+{
+	/* IPU is at port address 8 */
+	return of_graph_get_remote_node(dev->of_node, 8, 0);
+}
+
+static inline bool ingenic_drm_has_ipu(struct device *dev)
+{
+	return IS_ENABLED(CONFIG_DRM_INGENIC_IPU) &&
+		!!ingenic_drm_get_ipu_node(dev);
+}
+
 static int ingenic_drm_bind(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -808,7 +820,7 @@ static int ingenic_drm_bind(struct device *dev)
 			return ret;
 		}
 
-		if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU)) {
+		if (ingenic_drm_has_ipu(dev)) {
 			ret = component_bind_all(dev, drm);
 			if (ret) {
 				if (ret != -EPROBE_DEFER)
@@ -970,12 +982,9 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	if (!IS_ENABLED(CONFIG_DRM_INGENIC_IPU))
 		return ingenic_drm_bind(dev);
 
-	/* IPU is at port address 8 */
-	np = of_graph_get_remote_node(dev->of_node, 8, 0);
-	if (!np) {
-		dev_err(dev, "Unable to get IPU node\n");
-		return -EINVAL;
-	}
+	np = ingenic_drm_get_ipu_node(dev);
+	if (!np)
+		return ingenic_drm_bind(dev);
 
 	drm_of_component_match_add(dev, &match, compare_of, np);
 
-- 
2.28.0

