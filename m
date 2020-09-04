Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC21C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3D72074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tb1Sd+n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgIDPzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgIDPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:55:26 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD67DC061260
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:55:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p65so4993098qtd.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ls6xTeazp01VU5rx1tZcn8CZ6m3ZwOm0FhCvNs4H/UM=;
        b=tb1Sd+n9qybC0+ro/HdiC+RBRiJc3INwSffhtqG6iMH+37s6uZXFul1N9db1cLf0O+
         W0rjcAJiucucmVQfVxG2MUkMAVBzL72kxYXPDM94Y8Eog3yqNAhbIBZ0SvhdqCqHjDss
         eqJnjUevNWz0I2ajfvSEgBRETGT0byopb7rb3HjelVEJIa/NYG7qIZZfDuUsq9UT8H2o
         wmlglYCueMqRUyXl0caryl5xIGgDggZeBNuaZUM8AtvG0YPJM0pCBnwyWbzDQmzoIDUC
         8377oUebGf4yS6DRCQMoNRh9frdfOYrnjbWjR3K67Znyzlh8ybqe7mNP7I9znqOGTQSk
         sGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ls6xTeazp01VU5rx1tZcn8CZ6m3ZwOm0FhCvNs4H/UM=;
        b=avdtp5rxFBYRaB7X9SYSnbSlv8OnLCwMehEy3iQ2d0FYWGvpSDbqiX6vmWiRDgHqKw
         Kku1dY349z29CKKn84CB5jXayPShkiacS5N4jCcmQk7oqp0GqJeKiofAJ+nFvUaA8hUC
         p22FhVO6HPazVGd26jT0eBZsl5zKpLB3NrlGOPr66i1P86B0oLfXLMewppgtFPaB+ail
         fZB95wAA10zdXb6xBSDeT+sifurXY1BTyfphIp+ss9C3Jvda02i4Rhsegml7oSvLecSB
         j1sbe9yUCz3IWrFTYH7mQCgLZfPxxVBv8efLGngtLfwUCm6Rg9qkbxHiagBvb1GtBz4F
         xNsQ==
X-Gm-Message-State: AOAM532nx17VvO/bXat4ytFr8cr9SPMBsN3RxPYljkVqpXDNKwDjw0S3
        sSq6OOmQgq9bYbyht53QG2s8nA==
X-Google-Smtp-Source: ABdhPJyL88SwYtdr8vsyF/Q0nFNgzaGMkmnx++yP3wUNifIJQkEY1cF7fewzAafVU/vEqfUIMi+MHg==
X-Received: by 2002:ac8:17af:: with SMTP id o44mr9239269qtj.343.1599234921881;
        Fri, 04 Sep 2020 08:55:21 -0700 (PDT)
Received: from localhost.localdomain (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:55:21 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 6/8] iommu/arm-smmu: Add impl hook for inherit boot mappings
Date:   Fri,  4 Sep 2020 15:55:11 +0000
Message-Id: <20200904155513.282067-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904155513.282067-1-bjorn.andersson@linaro.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new operation to allow platform implementations to inherit any
stream mappings from the boot loader.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- New patch/interface

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 11 ++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index eb5c6ca5c138..4c4d302cd747 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -85,11 +85,6 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 		pm_runtime_put_autosuspend(smmu->dev);
 }
 
-static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct arm_smmu_domain, domain);
-}
-
 static struct platform_driver arm_smmu_driver;
 static struct iommu_ops arm_smmu_ops;
 
@@ -2188,6 +2183,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	if (smmu->impl->inherit_mappings) {
+		err = smmu->impl->inherit_mappings(smmu);
+		if (err)
+			return err;
+	}
+
 	if (smmu->version == ARM_SMMU_V2) {
 		if (smmu->num_context_banks > smmu->num_context_irqs) {
 			dev_err(dev,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 235d9a3a6ab6..f58164976e74 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -378,6 +378,11 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
+static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct arm_smmu_domain, domain);
+}
+
 struct arm_smmu_master_cfg {
 	struct arm_smmu_device		*smmu;
 	s16				smendx[];
@@ -442,6 +447,7 @@ struct arm_smmu_impl {
 	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
 				  struct arm_smmu_device *smmu,
 				  struct device *dev, int start);
+	int (*inherit_mappings)(struct arm_smmu_device *smmu);
 };
 
 #define INVALID_SMENDX			-1
-- 
2.28.0

