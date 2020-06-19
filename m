Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44528C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2475C2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qLOns37r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbgFSHGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:06:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:17245 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730312AbgFSHF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:05:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592550355; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=qQpRoi8I5lL80EJJsNftfx0IFdSlZOG8s1Q2NR1FHEw=; b=qLOns37rHtW42i6lK75a2cQX92OIIhXMbLLLrjlZA0CG/yMmd4CN5RZHH1FAQDRMfOLS2nu2
 uRN2QDvGX5iB1IC0iPJjShdIfQ1i41xshVD+xFp4znpHsIQCHOCsXvanOD7tZo9T/R1bjJqn
 8nNXgTUY5P7mV/XHnO9tSurT6uo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5eec63bf6bebe35deb5408f5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Jun 2020 07:05:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7CF0FC433C9; Fri, 19 Jun 2020 07:05:35 +0000 (UTC)
Received: from kathirav-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40BB0C43387;
        Fri, 19 Jun 2020 07:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40BB0C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kathirav@codeaurora.org
From:   Kathiravan T <kathirav@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, kathirav@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     sivaprak@codeaurora.org
Subject: [PATCH 3/6] soc: qcom: smd-rpm: Add IPQ6018 compatible
Date:   Fri, 19 Jun 2020 12:35:04 +0530
Message-Id: <1592550307-11040-4-git-send-email-kathirav@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592550307-11040-1-git-send-email-kathirav@codeaurora.org>
References: <1592550307-11040-1-git-send-email-kathirav@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a compatible for the rpm on the Qualcomm IPQ6018 platform.

Signed-off-by: Kathiravan T <kathirav@codeaurora.org>
---
 drivers/soc/qcom/smd-rpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 005dd30..1a5226a 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -230,6 +230,7 @@ static void qcom_smd_rpm_remove(struct rpmsg_device *rpdev)
 
 static const struct of_device_id qcom_smd_rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-apq8084" },
+	{ .compatible = "qcom,rpm-ipq6018" },
 	{ .compatible = "qcom,rpm-msm8916" },
 	{ .compatible = "qcom,rpm-msm8974" },
 	{ .compatible = "qcom,rpm-msm8976" },
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

