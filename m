Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56472C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38EB520772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgFWGMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:12:45 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39166 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbgFWGMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:12:41 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D437B1A0E20;
        Tue, 23 Jun 2020 08:12:39 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A238C1A0090;
        Tue, 23 Jun 2020 08:12:35 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2C7D9402DB;
        Tue, 23 Jun 2020 14:12:30 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ASoC: fsl_mqs: Fix unchecked return value for clk_prepare_enable
Date:   Tue, 23 Jun 2020 14:01:12 +0800
Message-Id: <5edd68d03def367d96268f1a9a00bd528ea5aaf2.1592888591.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1592888591.git.shengjiu.wang@nxp.com>
References: <cover.1592888591.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1592888591.git.shengjiu.wang@nxp.com>
References: <cover.1592888591.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix unchecked return value for clk_prepare_enable, add error
handler in fsl_mqs_runtime_resume.

Fixes: 9e28f6532c61 ("ASoC: fsl_mqs: Add MQS component driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_mqs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index b44b134390a3..69aeb0e71844 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -265,10 +265,20 @@ static int fsl_mqs_remove(struct platform_device *pdev)
 static int fsl_mqs_runtime_resume(struct device *dev)
 {
 	struct fsl_mqs *mqs_priv = dev_get_drvdata(dev);
+	int ret;
 
-	clk_prepare_enable(mqs_priv->ipg);
+	ret = clk_prepare_enable(mqs_priv->ipg);
+	if (ret) {
+		dev_err(dev, "failed to enable ipg clock\n");
+		return ret;
+	}
 
-	clk_prepare_enable(mqs_priv->mclk);
+	ret = clk_prepare_enable(mqs_priv->mclk);
+	if (ret) {
+		dev_err(dev, "failed to enable mclk clock\n");
+		clk_disable_unprepare(mqs_priv->ipg);
+		return ret;
+	}
 
 	if (mqs_priv->use_gpr)
 		regmap_write(mqs_priv->regmap, IOMUXC_GPR2,
-- 
2.21.0

