Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F4FC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1840C207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="h1Yh1YGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbgGVKdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:33:21 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:41296 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732164AbgGVKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:33:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595413998; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=FnbOm2jqw8cOBeff5oky4tXaNraD8764cRfiH89/4tY=; b=h1Yh1YGjrA+amA8kLdEkeCXqLEgTga/Ir2CJ5rGH6/JHAPOwp1RW3/bP+owNxMkQqygpYLAH
 lmU/P+9b4rSHPLhAQEKIbMEH513+qtIcV2IkYXcfyyTcgTk9ylHOEIACk3NYkFi2oSv9O+q3
 ZEZLFzDoOJyQhvtyrIcSYEnKrvM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f1815e5f9ca681bd046b6b8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 22 Jul 2020 10:33:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8883EC433AF; Wed, 22 Jul 2020 10:33:08 +0000 (UTC)
Received: from rohkumar-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F553C433A0;
        Wed, 22 Jul 2020 10:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F553C433A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v4 06/12] ASoC: qcom: lpass-cpu: fix concurrency issue
Date:   Wed, 22 Jul 2020 16:01:49 +0530
Message-Id: <1595413915-17867-7-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
References: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i2sctl register value is set to 0 during hw_free(). This
impacts any ongoing concurrent session on the same i2s
port. As trigger() stop already resets enable bit to 0,
there is no need of explicit hw_free. Removing it to
fix the issue.

Fixes: 80beab8e1d86 ("ASoC: qcom: Add LPASS CPU DAI driver")
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 6b86f16..5d84f63 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -266,21 +266,6 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int lpass_cpu_daiops_hw_free(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
-	int ret;
-
-	ret = regmap_write(drvdata->lpaif_map,
-			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
-			   0);
-	if (ret)
-		dev_err(dai->dev, "error writing to i2sctl reg: %d\n", ret);
-
-	return ret;
-}
-
 static int lpass_cpu_daiops_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -350,7 +335,6 @@ const struct snd_soc_dai_ops asoc_qcom_lpass_cpu_dai_ops = {
 	.startup	= lpass_cpu_daiops_startup,
 	.shutdown	= lpass_cpu_daiops_shutdown,
 	.hw_params	= lpass_cpu_daiops_hw_params,
-	.hw_free	= lpass_cpu_daiops_hw_free,
 	.prepare	= lpass_cpu_daiops_prepare,
 	.trigger	= lpass_cpu_daiops_trigger,
 };
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

