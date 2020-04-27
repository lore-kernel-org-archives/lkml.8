Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29789C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A62C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgD0JPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:15:21 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10916 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgD0JPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:15:20 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95ea6a292add-78c64; Mon, 27 Apr 2020 17:14:58 +0800 (CST)
X-RM-TRANSID: 2ee95ea6a292add-78c64
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5ea6a28c769-78073;
        Mon, 27 Apr 2020 17:14:55 +0800 (CST)
X-RM-TRANSID: 2eea5ea6a28c769-78073
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: hisilicon: Use the defined variable to clean code
Date:   Mon, 27 Apr 2020 17:15:20 +0800
Message-Id: <20200427091520.12412-1-tangbin@cmss.chinamobile.com>
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
 sound/soc/hisilicon/hi6210-i2s.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index f14ce0253..fd5dcd6b9 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -547,7 +547,7 @@ static int hi6210_i2s_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret;
 
-	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
+	i2s = devm_kzalloc(dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
 		return -ENOMEM;
 
@@ -562,28 +562,28 @@ static int hi6210_i2s_probe(struct platform_device *pdev)
 	i2s->base_phys = (phys_addr_t)res->start;
 	i2s->dai = hi6210_i2s_dai_init;
 
-	dev_set_drvdata(&pdev->dev, i2s);
+	dev_set_drvdata(dev, i2s);
 
 	i2s->sysctrl = syscon_regmap_lookup_by_phandle(node,
 						"hisilicon,sysctrl-syscon");
 	if (IS_ERR(i2s->sysctrl))
 		return PTR_ERR(i2s->sysctrl);
 
-	i2s->clk[CLK_DACODEC] = devm_clk_get(&pdev->dev, "dacodec");
+	i2s->clk[CLK_DACODEC] = devm_clk_get(dev, "dacodec");
 	if (IS_ERR(i2s->clk[CLK_DACODEC]))
 		return PTR_ERR(i2s->clk[CLK_DACODEC]);
 	i2s->clocks++;
 
-	i2s->clk[CLK_I2S_BASE] = devm_clk_get(&pdev->dev, "i2s-base");
+	i2s->clk[CLK_I2S_BASE] = devm_clk_get(dev, "i2s-base");
 	if (IS_ERR(i2s->clk[CLK_I2S_BASE]))
 		return PTR_ERR(i2s->clk[CLK_I2S_BASE]);
 	i2s->clocks++;
 
-	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	ret = devm_snd_dmaengine_pcm_register(dev, NULL, 0);
 	if (ret)
 		return ret;
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &hi6210_i2s_i2s_comp,
+	ret = devm_snd_soc_register_component(dev, &hi6210_i2s_i2s_comp,
 					 &i2s->dai, 1);
 	return ret;
 }
-- 
2.20.1.windows.1



