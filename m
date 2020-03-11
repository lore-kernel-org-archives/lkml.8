Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2897C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E7C206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgCKOqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:46:33 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3357 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgCKOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:46:33 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25e68f99b2cf-7f039; Wed, 11 Mar 2020 22:45:50 +0800 (CST)
X-RM-TRANSID: 2ee25e68f99b2cf-7f039
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.104.148.111])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55e68f999482-ecb2c;
        Wed, 11 Mar 2020 22:45:50 +0800 (CST)
X-RM-TRANSID: 2ee55e68f999482-ecb2c
From:   tangbin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, jun.nie@linaro.org, shawnguo@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC:zte:zx-tdm:remove redundant variables dev
Date:   Wed, 11 Mar 2020 22:46:46 +0800
Message-Id: <20200311144646.11292-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this function, the variable 'dev' is assigned to '&pdev->dev',
but in the following code, all the assignments to 'struce device'
are used '&pdev->dev' instead of 'dev',except 'zx_tdm->dev'.
So,the variable 'dev' in this function is redundant and can be
replaced by '&pdev->dev' as elsewhere.

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 sound/soc/zte/zx-tdm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/zte/zx-tdm.c b/sound/soc/zte/zx-tdm.c
index 0e5a05b25..4f787185d 100644
--- a/sound/soc/zte/zx-tdm.c
+++ b/sound/soc/zte/zx-tdm.c
@@ -371,7 +371,6 @@ static struct snd_soc_dai_driver zx_tdm_dai = {
 
 static int zx_tdm_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct of_phandle_args out_args;
 	unsigned int dma_reg_offset;
 	struct zx_tdm_info *zx_tdm;
@@ -384,7 +383,7 @@ static int zx_tdm_probe(struct platform_device *pdev)
 	if (!zx_tdm)
 		return -ENOMEM;
 
-	zx_tdm->dev = dev;
+	zx_tdm->dev = &pdev->dev;
 
 	zx_tdm->dai_wclk = devm_clk_get(&pdev->dev, "wclk");
 	if (IS_ERR(zx_tdm->dai_wclk)) {
-- 
2.20.1.windows.1



