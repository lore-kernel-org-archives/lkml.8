Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DFDC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE8420857
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mKQSaVKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgDKIEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 04:04:13 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:54469 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbgDKIEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 04:04:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586592252; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=zdeX1LsnbO4SjlCpOn7ig/JLc8buLB24sK6pqyrCNGI=; b=mKQSaVKfkozhMt+Lu0RNVOZ33i1W3dsCqLd9Y155KG26mVh+/3WHXycTwCuiV2eVmCeRwevT
 DYgvj1R4dXivSbsqu9BfL2dIVzqQNLk1mDG/hKuUK/lzwEXTLAs8QGPuZLJJ7E0qk9eopNNV
 i/R6GVnDLUVu3OZCM7C0m8c8yk8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9179f8.7fbec2a0e6f8-smtp-out-n04;
 Sat, 11 Apr 2020 08:04:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DEF41C44788; Sat, 11 Apr 2020 08:04:07 +0000 (UTC)
Received: from c-ajitp-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ajitp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CAA7C433F2;
        Sat, 11 Apr 2020 08:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CAA7C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ajitp@codeaurora.org
From:   Ajit Pandey <ajitp@codeaurora.org>
To:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: [PATCH 04/11] ASoC: qcom: lpass-cpu: Make "ahbix-clk" an optional clock.
Date:   Sat, 11 Apr 2020 13:32:44 +0530
Message-Id: <1586592171-31644-5-git-send-email-ajitp@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AHB-I/X bus clocks inside LPASS coreis not a mandatory clocks for
newer lpass variants, hence make it an optional one.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 492f27b..f177932 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -504,26 +504,31 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	drvdata->ahbix_clk = devm_clk_get(&pdev->dev, "ahbix-clk");
+	drvdata->ahbix_clk = devm_clk_get_optional(&pdev->dev, "ahbix-clk");
 	if (IS_ERR(drvdata->ahbix_clk)) {
 		dev_err(&pdev->dev, "error getting ahbix-clk: %ld\n",
 			PTR_ERR(drvdata->ahbix_clk));
 		return PTR_ERR(drvdata->ahbix_clk);
 	}
 
-	ret = clk_set_rate(drvdata->ahbix_clk, LPASS_AHBIX_CLOCK_FREQUENCY);
-	if (ret) {
-		dev_err(&pdev->dev, "error setting rate on ahbix_clk: %d\n",
-			ret);
-		return ret;
-	}
-	dev_dbg(&pdev->dev, "set ahbix_clk rate to %lu\n",
-		clk_get_rate(drvdata->ahbix_clk));
+	if (drvdata->ahbix_clk != NULL) {
+		ret = clk_set_rate(drvdata->ahbix_clk,
+				   LPASS_AHBIX_CLOCK_FREQUENCY);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"error setting rate on ahbix_clk: %d\n", ret);
+			return ret;
+		}
 
-	ret = clk_prepare_enable(drvdata->ahbix_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "error enabling ahbix_clk: %d\n", ret);
-		return ret;
+		dev_dbg(&pdev->dev, "set ahbix_clk rate to %lu\n",
+			clk_get_rate(drvdata->ahbix_clk));
+
+		ret = clk_prepare_enable(drvdata->ahbix_clk);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"error enabling ahbix_clk: %d\n", ret);
+			return ret;
+		}
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
-- 
1.9.1
