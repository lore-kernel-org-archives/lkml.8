Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835AAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6852420774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgFWGMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:12:42 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39580 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbgFWGMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:12:40 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BE480200BD4;
        Tue, 23 Jun 2020 08:12:38 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 94DE6200BDB;
        Tue, 23 Jun 2020 08:12:34 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2080A402B3;
        Tue, 23 Jun 2020 14:12:29 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: fsl_mqs: Don't check clock is NULL before calling clk API
Date:   Tue, 23 Jun 2020 14:01:11 +0800
Message-Id: <743be216bd504c26e8d45d5ce4a84561b67a122b.1592888591.git.shengjiu.wang@nxp.com>
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

Because clk_prepare_enable and clk_disable_unprepare should
check input clock parameter is NULL or not internally, then
we don't need to check them before calling the function.

Fixes: 9e28f6532c61 ("ASoC: fsl_mqs: Add MQS component driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_mqs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index 0c813a45bba7..b44b134390a3 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -266,11 +266,9 @@ static int fsl_mqs_runtime_resume(struct device *dev)
 {
 	struct fsl_mqs *mqs_priv = dev_get_drvdata(dev);
 
-	if (mqs_priv->ipg)
-		clk_prepare_enable(mqs_priv->ipg);
+	clk_prepare_enable(mqs_priv->ipg);
 
-	if (mqs_priv->mclk)
-		clk_prepare_enable(mqs_priv->mclk);
+	clk_prepare_enable(mqs_priv->mclk);
 
 	if (mqs_priv->use_gpr)
 		regmap_write(mqs_priv->regmap, IOMUXC_GPR2,
@@ -292,11 +290,8 @@ static int fsl_mqs_runtime_suspend(struct device *dev)
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

