Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF70C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1B820746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgEDH2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:28:06 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:49983 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgEDH2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:28:06 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65eafc3f4f75-fd170; Mon, 04 May 2020 15:27:49 +0800 (CST)
X-RM-TRANSID: 2ee65eafc3f4f75-fd170
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.182.180])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35eafc3f2125-99285;
        Mon, 04 May 2020 15:27:49 +0800 (CST)
X-RM-TRANSID: 2ee35eafc3f2125-99285
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: qcom: Use devm_platform_ioremap_resource_byname() to simplify code
Date:   Mon,  4 May 2020 15:28:20 +0800
Message-Id: <20200504072820.5328-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource_byname() instead of
platform_get_resource_byname() + devm_ioremap_resource().

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/qcom/lpass-cpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index dbce7e92b..885c1f2e7 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -417,7 +417,6 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 {
 	struct lpass_data *drvdata;
 	struct device_node *dsp_of_node;
-	struct resource *res;
 	struct lpass_variant *variant;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
@@ -442,9 +441,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 	drvdata->variant = (struct lpass_variant *)match->data;
 	variant = drvdata->variant;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-lpaif");
-
-	drvdata->lpaif = devm_ioremap_resource(&pdev->dev, res);
+	drvdata->lpaif = devm_platform_ioremap_resource_byname(pdev,
+						"lpass-lpaif")
 	if (IS_ERR((void const __force *)drvdata->lpaif)) {
 		dev_err(&pdev->dev, "error mapping reg resource: %ld\n",
 				PTR_ERR((void const __force *)drvdata->lpaif));
-- 
2.20.1.windows.1



