Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24003C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14E5207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YmPFjye2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgFDUjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:39:21 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37097 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728721AbgFDUjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:39:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591303160; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=1lvc/rtJTGg1ms49oe99E5caOYOwoBK6dQq3fFKin0E=; b=YmPFjye2FWSpJiOd2ck6Ib7J9aq6Bqhw3EMTHTCKaYwxIELCCg0VxOkzQmiyDh/ls1WkXMf3
 KTG4FdDpBxMk7vzU7i9GkxP3xB1fH4GwlP8ulKrw8w3xSzr9s5TBcy2yhcNQ0NGJM3paqi/N
 JmhhPZ73LRGR7dVxRR8ytaSMDU8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5ed95bef76fccbb4c826e894 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Jun 2020 20:39:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0A0AC433A1; Thu,  4 Jun 2020 20:39:10 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1002FC433C6;
        Thu,  4 Jun 2020 20:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1002FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/arm-smmu: Mark qcom_smmu_client_of_match as possibly unused
Date:   Thu,  4 Jun 2020 14:39:04 -0600
Message-Id: <20200604203905.31964-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF=n of_match_device() gets pre-processed out of existence
leaving qcom-smmu_client_of_match unused. Mark it as possibly unused to
keep the compiler from warning in that case.

Fixes: 0e764a01015d ("iommu/arm-smmu: Allow client devices to select direct mapping")
Reported-by: kbuild test robot <lkp@intel.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index cf01d0215a39..be4318044f96 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -12,7 +12,7 @@ struct qcom_smmu {
 	struct arm_smmu_device smmu;
 };
 
-static const struct of_device_id qcom_smmu_client_of_match[] = {
+static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
-- 
2.17.1

