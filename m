Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1077EC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7FE206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="jkQ9wt5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbgG0Q2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:28:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56261 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgG0Q2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:28:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595867310; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=AoGAWEheOFvz7olAYO+bhSgat67n1NnWWCqmG2/Tx6w=; b=jkQ9wt5hB33WkhZrB/5ckjRrscoer1pUdo+XPAq+CT91L0AayjvIzc3mXKb8oES0XpU1Qeab
 c2nkNJj5XGACeGXWOQEMG7vSV377rZT4OHmpHiHTHlwD6S+CSjjNgjEizRNoOcpm6MftUbQu
 GqO6OosvVfiun0ThCys0Zd7siAg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f1f00a8845c4d05a33e8173 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Jul 2020 16:28:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AB658C433C9; Mon, 27 Jul 2020 16:28:24 +0000 (UTC)
Received: from kathirav-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27020C433CA;
        Mon, 27 Jul 2020 16:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27020C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kathirav@codeaurora.org
From:   Kathiravan T <kathirav@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kathirav@codeaurora.org
Subject: [PATCH] soc: qcom: socinfo: add soc id for IPQ6018
Date:   Mon, 27 Jul 2020 21:58:10 +0530
Message-Id: <1595867290-22318-1-git-send-email-kathirav@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SoC ID for IPQ6018 variant.

Signed-off-by: Kathiravan T <kathirav@codeaurora.org>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index d9c64a78e49c..b7972bdff027 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -223,6 +223,7 @@ static const struct soc_id soc_id[] = {
 	{ 321, "SDM845" },
 	{ 341, "SDA845" },
 	{ 356, "SM8250" },
+	{ 402, "IPQ6018" },
 };
 
 static const char *socinfo_machine(struct device *dev, unsigned int id)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

