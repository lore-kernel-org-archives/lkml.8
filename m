Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F98C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC22206D3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgEJPsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:48:47 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:27005 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgEJPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:48:46 -0400
Received: from localhost.localdomain ([92.148.185.155])
        by mwinf5d69 with ME
        id d3oc220073MbWjg033ocWy; Sun, 10 May 2020 17:48:44 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 May 2020 17:48:44 +0200
X-ME-IP: 92.148.185.155
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     inki.dae@samsung.com, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        airlied@linux.ie, daniel@ffwll.ch, kgene@kernel.org,
        krzk@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/exynos: dsi: Remove bridge node reference in error handling path in probe function
Date:   Sun, 10 May 2020 17:48:33 +0200
Message-Id: <20200510154833.238320-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'exynos_dsi_parse_dt()' takes a reference to 'dsi->in_bridge_node'.
This must be released in the error handling path.

This patch is similar to commit 70505c2ef94b ("drm/exynos: dsi: Remove bridge node reference in removal")
which fixed the issue in the remove function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
A Fixes tag could be required, but I've not been able to figure out which
one to use.

I think that moving 'exynos_dsi_parse_dt()' in the probe could simplify
the error handling in the probe function. However, I don't know this code
well enough to play this game. So better safe than sorry.
So I've kept the logic in place and added goto everywhere. :(
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 28 ++++++++++++++++++-------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 902938d2568f..2aa74c3dc733 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1770,14 +1770,17 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
 			dev_info(dev, "failed to get regulators: %d\n", ret);
-		return ret;
+		goto err_put_in_bridge_node;
 	}
 
 	dsi->clks = devm_kcalloc(dev,
 			dsi->driver_data->num_clks, sizeof(*dsi->clks),
 			GFP_KERNEL);
-	if (!dsi->clks)
-		return -ENOMEM;
+	if (!dsi->clks) {
+		ret = -ENOMEM;
+		goto err_put_in_bridge_node;
+	}
+
 
 	for (i = 0; i < dsi->driver_data->num_clks; i++) {
 		dsi->clks[i] = devm_clk_get(dev, clk_names[i]);
@@ -1791,7 +1794,8 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 
 			dev_info(dev, "failed to get the clock: %s\n",
 					clk_names[i]);
-			return PTR_ERR(dsi->clks[i]);
+			ret = PTR_ERR(dsi->clks[i]);
+			goto err_put_in_bridge_node;
 		}
 	}
 
@@ -1799,19 +1803,22 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 	dsi->reg_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(dsi->reg_base)) {
 		dev_err(dev, "failed to remap io region\n");
-		return PTR_ERR(dsi->reg_base);
+		ret = PTR_ERR(dsi->reg_base);
+		goto err_put_in_bridge_node;
 	}
 
 	dsi->phy = devm_phy_get(dev, "dsim");
 	if (IS_ERR(dsi->phy)) {
 		dev_info(dev, "failed to get dsim phy\n");
-		return PTR_ERR(dsi->phy);
+		ret = PTR_ERR(dsi->phy);
+		goto err_put_in_bridge_node;
 	}
 
 	dsi->irq = platform_get_irq(pdev, 0);
 	if (dsi->irq < 0) {
 		dev_err(dev, "failed to request dsi irq resource\n");
-		return dsi->irq;
+		ret = dsi->irq;
+		goto err_put_in_bridge_node;
 	}
 
 	irq_set_status_flags(dsi->irq, IRQ_NOAUTOEN);
@@ -1820,7 +1827,7 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 					dev_name(dev), dsi);
 	if (ret) {
 		dev_err(dev, "failed to request dsi irq\n");
-		return ret;
+		goto err_put_in_bridge_node;
 	}
 
 	platform_set_drvdata(pdev, &dsi->encoder);
@@ -1828,6 +1835,11 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 
 	return component_add(dev, &exynos_dsi_component_ops);
+
+err_put_in_bridge_node:
+	of_node_put(dsi->in_bridge_node);
+
+	return ret;
 }
 
 static int exynos_dsi_remove(struct platform_device *pdev)
-- 
2.25.1

