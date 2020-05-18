Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26851C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050B3207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgERLAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:00:23 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:12202 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgERLAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:00:22 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5ec26ab0fe4-37700; Mon, 18 May 2020 19:00:00 +0800 (CST)
X-RM-TRANSID: 2eeb5ec26ab0fe4-37700
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95ec26aadd27-b87e8;
        Mon, 18 May 2020 19:00:00 +0800 (CST)
X-RM-TRANSID: 2ee95ec26aadd27-b87e8
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: fsl_micfil: Fix unused assignment in fsl_set_clock_params()
Date:   Mon, 18 May 2020 19:00:40 +0800
Message-Id: <20200518110040.18036-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete unused initialized value of 'ret', because it will
be assigned by the function fsl_micfil_set_mclk_rate().

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_micfil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 79cf488fa..a7a6118be 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -295,7 +295,7 @@ static int fsl_set_clock_params(struct device *dev, unsigned int rate)
 {
 	struct fsl_micfil *micfil = dev_get_drvdata(dev);
 	int clk_div;
-	int ret = 0;
+	int ret;
 
 	ret = fsl_micfil_set_mclk_rate(micfil, rate);
 	if (ret < 0)
-- 
2.20.1.windows.1



