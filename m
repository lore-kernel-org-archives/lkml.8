Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35856C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1696C20734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="KtMFLCgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbgFISFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:05:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61579 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388072AbgFISF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:05:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591725926; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=x01+HksEUfPnnuAjrfKal7kG0NEwAm/phbFVlSCT2kQ=; b=KtMFLCgBGJ7hGWyrlL8xG6fj+MUI7CYIW963Cv/7M9iFNUSf6J6L1VxcbfLDDEcQIM+1UwQM
 R5rv5Ljobacz+oPt0wrFbIdDz00Ozhog32UbsQDhqAq1dZ7aAxepSieU7ichlKodxqsFyRTL
 ePI87vXvKdamtFMPnV+9jONKJ/M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5edfcf61c4bb4f886d289709 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 18:05:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF512C4339C; Tue,  9 Jun 2020 18:05:20 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1AD1EC43387;
        Tue,  9 Jun 2020 18:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AD1EC43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Patrick Daly <pdaly@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu: Don't bypass pinned stream mappings
Date:   Tue,  9 Jun 2020 12:05:16 -0600
Message-Id: <20200609180516.14362-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to select
direct mapping") sets the initial domain type to SMMU_DOMAIN_IDENTITY
for devices that select direct mapping. This ends up setting the domain
as ARM_SMMU_DOMAIN_BYPASS which causes the stream ID mappings
for the device to be programmed to S2CR_TYPE_BYPASS.

This causes a problem for stream mappings that are inherited from
the bootloader since rewriting the stream to BYPASS will disrupt the
display controller access to DDR.

This is an extension to ("iommu/arm-smmu: Allow inheriting stream mapping
from bootloader") [1] that identifies streams that are already configured
 and marked them as pinned. This patch extends that to not re-write pinned
stream mappings for ARM_SMMU_DOMAIN_BYPASS domains.

[1] https://lore.kernel.org/r/20191226221709.3844244-4-bjorn.andersson@linaro.org

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c7add09f11c1..9c1e5ba948a7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1143,6 +1143,10 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 		if (type == s2cr[idx].type && cbndx == s2cr[idx].cbndx)
 			continue;
 
+		/* Don't bypasss pinned streams; leave them as they are */
+		if (type == S2CR_TYPE_BYPASS && s2cr[idx].pinned)
+			continue;
+
 		s2cr[idx].type = type;
 		s2cr[idx].privcfg = S2CR_PRIVCFG_DEFAULT;
 		s2cr[idx].cbndx = cbndx;
-- 
2.17.1

