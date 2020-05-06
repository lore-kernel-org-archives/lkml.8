Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8322C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5DF2076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgEFOeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:34:21 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3523 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbgEFOeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:34:21 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15eb2c9d076f-2798f; Wed, 06 May 2020 22:29:36 +0800 (CST)
X-RM-TRANSID: 2ee15eb2c9d076f-2798f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.146.193])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65eb2c9cc322-73c3f;
        Wed, 06 May 2020 22:29:36 +0800 (CST)
X-RM-TRANSID: 2ee65eb2c9cc322-73c3f
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: mediatek: Fix error handling
Date:   Wed,  6 May 2020 22:30:09 +0800
Message-Id: <20200506143009.13368-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the function platform_get_irq() failed, the negative value
returned will not be detected here. So fix error handling in
mt6797_afe_pcm_dev_probe(). And when get irq failed, the function
platform_get_irq() logs an error message, so remove redundant
message here.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index 378bfc16e..a621dcf91 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -807,10 +807,9 @@ static int mt6797_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* request irq */
 	irq_id = platform_get_irq(pdev, 0);
-	if (!irq_id) {
-		dev_err(dev, "%pOFn no irq found\n", dev->of_node);
-		return -ENXIO;
-	}
+	if (irq_id < 0)
+		return irq_id;
+
 	ret = devm_request_irq(dev, irq_id, mt6797_afe_irq_handler,
 			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
 	if (ret) {
-- 
2.20.1.windows.1



