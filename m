Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3627BC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098DF208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="aM/7CXpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgEGTWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:22:43 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52173 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgEGTWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:22:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588879360; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=iv2+rEkcFZZMHapobHQ0seNnq8crBV2GyQlsMOGPnhc=; b=aM/7CXpooU1It+u7iCU6C3V4OT1V3+jcsRUVwIP8IegV7wyQEhsg+GmFj+laPNqt5aPBZUFt
 ulI6ChLjZm2llEvqfwdrt1eZPyQnhVDThfG34lPNHbwUOFx8wLfc1zcp9cdwukSEvvALtlBh
 8qGO95CJt4FDsYeOljLlzGAUuJ8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb45ff8.7fdbc1cc4378-smtp-out-n03;
 Thu, 07 May 2020 19:22:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3AA54C44795; Thu,  7 May 2020 19:22:32 +0000 (UTC)
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38DF2C433BA;
        Thu,  7 May 2020 19:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38DF2C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc:     bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        evgreen@chromium.org, mka@chromium.org, swboyd@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH v5] iommu/arm-smmu-qcom: Request direct mapping for modem device
Date:   Fri,  8 May 2020 00:51:57 +0530
Message-Id: <20200507192157.6831-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The modem remote processor has two modes of access to the DDR, a direct
mode and through a SMMU which requires direct mapping. The configuration
of the modem SIDs is handled in TrustZone. On platforms where TrustZone
is absent this needs to be explicitly done from kernel. Add compatibles
for modem to opt in for direct mapping on such platforms.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

V5
 * Reword commit message and drop unnecessary details

 drivers/iommu/arm-smmu-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index 5bedf21587a56..cf01d0215a397 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -17,7 +17,9 @@ static const struct of_device_id qcom_smmu_client_of_match[] = {
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },
+	{ .compatible = "qcom,sc7180-mss-pil" },
 	{ .compatible = "qcom,sdm845-mdss" },
+	{ .compatible = "qcom,sdm845-mss-pil" },
 	{ }
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
