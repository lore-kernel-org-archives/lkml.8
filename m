Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EC8C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C45B320775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgD2JkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:40:19 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:13147 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD2JkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:40:18 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75ea94b759d5-addd0; Wed, 29 Apr 2020 17:40:05 +0800 (CST)
X-RM-TRANSID: 2ee75ea94b759d5-addd0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.104.146.39])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35ea94b714a2-d9f76;
        Wed, 29 Apr 2020 17:40:04 +0800 (CST)
X-RM-TRANSID: 2ee35ea94b714a2-d9f76
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: mxs-saif: Add variable dev to simplify code
Date:   Wed, 29 Apr 2020 17:40:23 +0800
Message-Id: <20200429094023.12856-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add variable 'dev' to make the code cleaner in the function
mxs_saif_probe(). And now that the function mxs_saif_mclk_init()
have defined the variables 'ret' as the error returned value,
then it should be used instead in this place.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/mxs/mxs-saif.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index dc197883e..f4e441183 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -719,7 +719,7 @@ static int mxs_saif_mclk_init(struct platform_device *pdev)
 		if (ret == -EEXIST)
 			return 0;
 		dev_err(&pdev->dev, "failed to register mclk: %d\n", ret);
-		return PTR_ERR(clk);
+		return ret;
 	}
 
 	ret = of_clk_add_provider(np, of_clk_src_simple_get, clk);
@@ -732,6 +732,7 @@ static int mxs_saif_mclk_init(struct platform_device *pdev)
 static int mxs_saif_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	struct mxs_saif *saif;
 	int irq, ret;
 	struct device_node *master;
@@ -739,7 +740,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	if (!np)
 		return -EINVAL;
 
-	saif = devm_kzalloc(&pdev->dev, sizeof(*saif), GFP_KERNEL);
+	saif = devm_kzalloc(dev, sizeof(*saif), GFP_KERNEL);
 	if (!saif)
 		return -ENOMEM;
 
@@ -750,7 +751,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		saif->id = ret;
 
 	if (saif->id >= ARRAY_SIZE(mxs_saif)) {
-		dev_err(&pdev->dev, "get wrong saif id\n");
+		dev_err(dev, "get wrong saif id\n");
 		return -EINVAL;
 	}
 
@@ -770,18 +771,17 @@ static int mxs_saif_probe(struct platform_device *pdev)
 			saif->master_id = ret;
 
 		if (saif->master_id >= ARRAY_SIZE(mxs_saif)) {
-			dev_err(&pdev->dev, "get wrong master id\n");
+			dev_err(dev, "get wrong master id\n");
 			return -EINVAL;
 		}
 	}
 
 	mxs_saif[saif->id] = saif;
 
-	saif->clk = devm_clk_get(&pdev->dev, NULL);
+	saif->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(saif->clk)) {
 		ret = PTR_ERR(saif->clk);
-		dev_err(&pdev->dev, "Cannot get the clock: %d\n",
-			ret);
+		dev_err(dev, "Cannot get the clock: %d\n", ret);
 		return ret;
 	}
 
@@ -793,11 +793,11 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	saif->dev = &pdev->dev;
-	ret = devm_request_irq(&pdev->dev, irq, mxs_saif_irq, 0,
-			       dev_name(&pdev->dev), saif);
+	saif->dev = dev;
+	ret = devm_request_irq(dev, irq, mxs_saif_irq, 0,
+			       dev_name(dev), saif);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to request irq\n");
+		dev_err(dev, "failed to request irq\n");
 		return ret;
 	}
 
@@ -807,19 +807,19 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	if (saif->id == 0) {
 		ret = mxs_saif_mclk_init(pdev);
 		if (ret)
-			dev_warn(&pdev->dev, "failed to init clocks\n");
+			dev_warn(dev, "failed to init clocks\n");
 	}
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &mxs_saif_component,
+	ret = devm_snd_soc_register_component(dev, &mxs_saif_component,
 					      &mxs_saif_dai, 1);
 	if (ret) {
-		dev_err(&pdev->dev, "register DAI failed\n");
+		dev_err(dev, "register DAI failed\n");
 		return ret;
 	}
 
-	ret = mxs_pcm_platform_register(&pdev->dev);
+	ret = mxs_pcm_platform_register(dev);
 	if (ret) {
-		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
+		dev_err(dev, "register PCM failed: %d\n", ret);
 		return ret;
 	}
 
-- 
2.20.1.windows.1



