Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DBBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29375206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgFVJAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:00:11 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46820 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgFVJAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:00:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 900BE1A0B85;
        Mon, 22 Jun 2020 11:00:09 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 66EB51A0B76;
        Mon, 22 Jun 2020 11:00:05 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 26CA8402CA;
        Mon, 22 Jun 2020 16:59:59 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_mqs: Fix unchecked return value for clk_prepare_enable
Date:   Mon, 22 Jun 2020 16:48:45 +0800
Message-Id: <1592815725-853-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix unchecked return value for clk_prepare_enable.

And because clk_prepare_enable and clk_disable_unprepare should
check input clock parameter is NULL or not, then we don't need
to check it before calling the function.

Fixes: 9e28f6532c61 ("ASoC: fsl_mqs: Add MQS component driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_mqs.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index 0c813a45bba7..69aeb0e71844 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -265,12 +265,20 @@ static int fsl_mqs_remove(struct platform_device *pdev)
 static int fsl_mqs_runtime_resume(struct device *dev)
 {
 	struct fsl_mqs *mqs_priv = dev_get_drvdata(dev);
+	int ret;
 
-	if (mqs_priv->ipg)
-		clk_prepare_enable(mqs_priv->ipg);
+	ret = clk_prepare_enable(mqs_priv->ipg);
+	if (ret) {
+		dev_err(dev, "failed to enable ipg clock\n");
+		return ret;
+	}
 
-	if (mqs_priv->mclk)
-		clk_prepare_enable(mqs_priv->mclk);
+	ret = clk_prepare_enable(mqs_priv->mclk);
+	if (ret) {
+		dev_err(dev, "failed to enable mclk clock\n");
+		clk_disable_unprepare(mqs_priv->ipg);
+		return ret;
+	}
 
 	if (mqs_priv->use_gpr)
 		regmap_write(mqs_priv->regmap, IOMUXC_GPR2,
@@ -292,11 +300,8 @@ static int fsl_mqs_runtime_suspend(struct device *dev)
 		regmap_read(mqs_priv->regmap, REG_MQS_CTRL,
 			    &mqs_priv->reg_mqs_ctrl);
 
-	if (mqs_priv->mclk)
-		clk_disable_unprepare(mqs_priv->mclk);
-
-	if (mqs_priv->ipg)
-		clk_disable_unprepare(mqs_priv->ipg);
+	clk_disable_unprepare(mqs_priv->mclk);
+	clk_disable_unprepare(mqs_priv->ipg);
 
 	return 0;
 }
-- 
2.21.0

