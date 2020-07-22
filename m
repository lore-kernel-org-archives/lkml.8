Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0419AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FDE20729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OOIauaSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbgGVKeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:34:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60094 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732145AbgGVKeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:34:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595414061; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ICMWM9Fxu/GQTt5fXXp4xnnZWEWMOlvX0B4236TqhFo=; b=OOIauaSeZ+ZwF8JpzgyxpfWx68UU0zbdc/gBQld5+fh1mAO85kgR0i1eAieMKt69qGnKHmcF
 66kSJdl4ZoYpS48vtKqxYD2TAZUs0m0ZVMsA5BA0hoQgmOcr+saZewY/DGCf8vHkEnF/KYeZ
 mbrQkHJ0gxGnG0GJnzgxUPrWU7I=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f181616d3d650842256eab7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 22 Jul 2020 10:33:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7A1CDC433AD; Wed, 22 Jul 2020 10:33:57 +0000 (UTC)
Received: from rohkumar-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 658A8C433C9;
        Wed, 22 Jul 2020 10:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 658A8C433C9
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
Subject: [PATCH v4 10/12] ASoC: qcom: lpass-cpu: Use platform_get_resource
Date:   Wed, 22 Jul 2020 16:01:53 +0530
Message-Id: <1595413915-17867-11-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
References: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource_byname() is used when there
is list of reg entries. As lpass-cpu node has only
one reg entry, use platform_get_resource() instead.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 5d84f63..1ee6d8b 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -575,7 +575,7 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 
 	of_lpass_cpu_parse_dai_data(dev, drvdata);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-lpaif");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	drvdata->lpaif = devm_ioremap_resource(dev, res);
 	if (IS_ERR((void const __force *)drvdata->lpaif)) {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

