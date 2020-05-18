Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AFFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E56207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgERHo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:44:26 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3529 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgERHo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:44:26 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15ec23ca1a69-30e3d; Mon, 18 May 2020 15:43:29 +0800 (CST)
X-RM-TRANSID: 2ee15ec23ca1a69-30e3d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35ec23c9ef8a-3723f;
        Mon, 18 May 2020 15:43:29 +0800 (CST)
X-RM-TRANSID: 2ee35ec23c9ef8a-3723f
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: fsl_micfil: Fix format and unused assignment
Date:   Mon, 18 May 2020 15:44:05 +0800
Message-Id: <20200518074405.14880-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function fsl_micfil_startup(), the two lines of dev_err()
can be shortened to one line. And delete unused initialized value
of 'ret', because it will be assigned by the function
fsl_micfil_set_mclk_rate().

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_micfil.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index f7f2d29f1..a7a6118be 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -217,8 +217,7 @@ static int fsl_micfil_startup(struct snd_pcm_substream *substream,
 	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
 
 	if (!micfil) {
-		dev_err(dai->dev,
-			"micfil dai priv_data not set\n");
+		dev_err(dai->dev, "micfil dai priv_data not set\n");
 		return -EINVAL;
 	}
 
@@ -296,7 +295,7 @@ static int fsl_set_clock_params(struct device *dev, unsigned int rate)
 {
 	struct fsl_micfil *micfil = dev_get_drvdata(dev);
 	int clk_div;
-	int ret = 0;
+	int ret;
 
 	ret = fsl_micfil_set_mclk_rate(micfil, rate);
 	if (ret < 0)
-- 
2.20.1.windows.1



