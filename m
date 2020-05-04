Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7320EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5842E206EB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgEDHAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:00:14 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:3518 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgEDHAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:00:14 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55eafbd46cfd-fd0ef; Mon, 04 May 2020 14:59:18 +0800 (CST)
X-RM-TRANSID: 2ee55eafbd46cfd-fd0ef
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.182.180])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5eafbd4152c-0599b;
        Mon, 04 May 2020 14:59:17 +0800 (CST)
X-RM-TRANSID: 2eea5eafbd4152c-0599b
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, plai@codeaurora.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: qcom: Use the defined variable to simplify code
Date:   Mon,  4 May 2020 14:59:47 +0800
Message-Id: <20200504065947.12172-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the defined variable "dev" to make the code cleaner.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/qcom/lpass-apq8016.c |  9 ++++----
 sound/soc/qcom/lpass-cpu.c     | 39 ++++++++++++++++------------------
 2 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 6575da549..b3610d05b 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -166,28 +166,27 @@ static int apq8016_lpass_init(struct platform_device *pdev)
 
 	drvdata->pcnoc_mport_clk = devm_clk_get(dev, "pcnoc-mport-clk");
 	if (IS_ERR(drvdata->pcnoc_mport_clk)) {
-		dev_err(&pdev->dev, "error getting pcnoc-mport-clk: %ld\n",
+		dev_err(dev, "error getting pcnoc-mport-clk: %ld\n",
 			PTR_ERR(drvdata->pcnoc_mport_clk));
 		return PTR_ERR(drvdata->pcnoc_mport_clk);
 	}
 
 	ret = clk_prepare_enable(drvdata->pcnoc_mport_clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Error enabling pcnoc-mport-clk: %d\n",
-			ret);
+		dev_err(dev, "Error enabling pcnoc-mport-clk: %d\n", ret);
 		return ret;
 	}
 
 	drvdata->pcnoc_sway_clk = devm_clk_get(dev, "pcnoc-sway-clk");
 	if (IS_ERR(drvdata->pcnoc_sway_clk)) {
-		dev_err(&pdev->dev, "error getting pcnoc-sway-clk: %ld\n",
+		dev_err(dev, "error getting pcnoc-sway-clk: %ld\n",
 			PTR_ERR(drvdata->pcnoc_sway_clk));
 		return PTR_ERR(drvdata->pcnoc_sway_clk);
 	}
 
 	ret = clk_prepare_enable(drvdata->pcnoc_sway_clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Error enabling pcnoc_sway_clk: %d\n", ret);
+		dev_err(dev, "Error enabling pcnoc_sway_clk: %d\n", ret);
 		return ret;
 	}
 
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index dbce7e92b..c6d26395f 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -425,12 +425,11 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 
 	dsp_of_node = of_parse_phandle(pdev->dev.of_node, "qcom,adsp", 0);
 	if (dsp_of_node) {
-		dev_err(&pdev->dev, "DSP exists and holds audio resources\n");
+		dev_err(dev, "DSP exists and holds audio resources\n");
 		return -EBUSY;
 	}
 
-	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct lpass_data),
-			GFP_KERNEL);
+	drvdata = devm_kzalloc(dev, sizeof(struct lpass_data), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, drvdata);
@@ -444,9 +443,9 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-lpaif");
 
-	drvdata->lpaif = devm_ioremap_resource(&pdev->dev, res);
+	drvdata->lpaif = devm_ioremap_resource(dev, res);
 	if (IS_ERR((void const __force *)drvdata->lpaif)) {
-		dev_err(&pdev->dev, "error mapping reg resource: %ld\n",
+		dev_err(dev, "error mapping reg resource: %ld\n",
 				PTR_ERR((void const __force *)drvdata->lpaif));
 		return PTR_ERR((void const __force *)drvdata->lpaif);
 	}
@@ -455,10 +454,10 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 						variant->wrdma_channels +
 						variant->wrdma_channel_start);
 
-	drvdata->lpaif_map = devm_regmap_init_mmio(&pdev->dev, drvdata->lpaif,
+	drvdata->lpaif_map = devm_regmap_init_mmio(dev, drvdata->lpaif,
 			&lpass_cpu_regmap_config);
 	if (IS_ERR(drvdata->lpaif_map)) {
-		dev_err(&pdev->dev, "error initializing regmap: %ld\n",
+		dev_err(dev, "error initializing regmap: %ld\n",
 			PTR_ERR(drvdata->lpaif_map));
 		return PTR_ERR(drvdata->lpaif_map);
 	}
@@ -468,10 +467,10 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 
 	for (i = 0; i < variant->num_dai; i++) {
 		dai_id = variant->dai_driver[i].id;
-		drvdata->mi2s_osr_clk[dai_id] = devm_clk_get(&pdev->dev,
+		drvdata->mi2s_osr_clk[dai_id] = devm_clk_get(dev,
 					     variant->dai_osr_clk_names[i]);
 		if (IS_ERR(drvdata->mi2s_osr_clk[dai_id])) {
-			dev_warn(&pdev->dev,
+			dev_warn(dev,
 				"%s() error getting optional %s: %ld\n",
 				__func__,
 				variant->dai_osr_clk_names[i],
@@ -480,10 +479,10 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 			drvdata->mi2s_osr_clk[dai_id] = NULL;
 		}
 
-		drvdata->mi2s_bit_clk[dai_id] = devm_clk_get(&pdev->dev,
+		drvdata->mi2s_bit_clk[dai_id] = devm_clk_get(dev,
 						variant->dai_bit_clk_names[i]);
 		if (IS_ERR(drvdata->mi2s_bit_clk[dai_id])) {
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"error getting %s: %ld\n",
 				variant->dai_bit_clk_names[i],
 				PTR_ERR(drvdata->mi2s_bit_clk[dai_id]));
@@ -491,41 +490,39 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 		}
 	}
 
-	drvdata->ahbix_clk = devm_clk_get(&pdev->dev, "ahbix-clk");
+	drvdata->ahbix_clk = devm_clk_get(dev, "ahbix-clk");
 	if (IS_ERR(drvdata->ahbix_clk)) {
-		dev_err(&pdev->dev, "error getting ahbix-clk: %ld\n",
+		dev_err(dev, "error getting ahbix-clk: %ld\n",
 			PTR_ERR(drvdata->ahbix_clk));
 		return PTR_ERR(drvdata->ahbix_clk);
 	}
 
 	ret = clk_set_rate(drvdata->ahbix_clk, LPASS_AHBIX_CLOCK_FREQUENCY);
 	if (ret) {
-		dev_err(&pdev->dev, "error setting rate on ahbix_clk: %d\n",
-			ret);
+		dev_err(dev, "error setting rate on ahbix_clk: %d\n", ret);
 		return ret;
 	}
-	dev_dbg(&pdev->dev, "set ahbix_clk rate to %lu\n",
+	dev_dbg(dev, "set ahbix_clk rate to %lu\n",
 		clk_get_rate(drvdata->ahbix_clk));
 
 	ret = clk_prepare_enable(drvdata->ahbix_clk);
 	if (ret) {
-		dev_err(&pdev->dev, "error enabling ahbix_clk: %d\n", ret);
+		dev_err(dev, "error enabling ahbix_clk: %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
+	ret = devm_snd_soc_register_component(dev,
 					      &lpass_cpu_comp_driver,
 					      variant->dai_driver,
 					      variant->num_dai);
 	if (ret) {
-		dev_err(&pdev->dev, "error registering cpu driver: %d\n", ret);
+		dev_err(dev, "error registering cpu driver: %d\n", ret);
 		goto err_clk;
 	}
 
 	ret = asoc_qcom_lpass_platform_register(pdev);
 	if (ret) {
-		dev_err(&pdev->dev, "error registering platform driver: %d\n",
-			ret);
+		dev_err(dev, "error registering platform driver: %d\n", ret);
 		goto err_clk;
 	}
 
-- 
2.20.1.windows.1



