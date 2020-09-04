Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2D8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C50920770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e29uwL+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgIDPzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgIDPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:55:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E436C061264
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:55:25 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w186so6761831qkd.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D1yn3SCzU30h04jFGZXM8u3sA7NFVzSbPZqsPP+oWTg=;
        b=e29uwL+EpSoES/+z1K7U/GWcIt61CkRtvS0de6u87FjQ4LIGnpTSAeb20AmUaBcCZ8
         qtWzRwMAkZO+FFYyxWZgTURdUzTgq6bhfj60DTRKFmf9wWPT10+0oU/yOGpjFBtn9Yab
         oAuX8ffQuctwoR52w0eq8k+Qv0iHkXxsn4ZzCB7xDfRKFO6+vWmJc2uHQb5HuinMDXj0
         4x11oTIlnbY00jrQyfglYGC0moCfhrkmlrCmXpOejfircLaXWuz1uHJerPmGG6PAYKWP
         Bep1fwiC1Nn43wd0BDxFgDLF5fMFxZJxsemZJJfrYPg9oMu1dtnkwBanuwslteLyGari
         kW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1yn3SCzU30h04jFGZXM8u3sA7NFVzSbPZqsPP+oWTg=;
        b=ckkGddWghxbx56QAzG2zzYiK/ZXCxsHGOVl0R/0/DkfvkhRPDnscb0ACIpoXrd0Vdn
         UQwDXouc7DBKgMocz+X2+zKf03lthS8VKOMYkNgnP9OrFCb8UI4Fwkjvwrxqyhet09oT
         rh6bN1byUFns5HLI0awkT5c44XJEGiyiFSgSh7kBgvVTdmb5hjkMP0yAMo/Wr/YwkRts
         O9u1dvYFQX6yK0jBUAZDXnyIoWIFHub1fXMQsp2iGdzgR2nduovEUIXVahsX0VSizyWE
         uzPc+afnZ2G4qX/jz6uOZf4+jLIc3QZ4TrlbdbAVRrC908KqO6wJIrVNSaH/rjM2CPdZ
         1HSw==
X-Gm-Message-State: AOAM532Z9Ly0svvF21Oemd0JbbFk89KhZcacZj7VWiFF8nP+XgHvOx9t
        qc4msFb/AwZZr+TD+Rarr+9+vbQaQIDBMg==
X-Google-Smtp-Source: ABdhPJyFYlEUGi9gN4pbIp7iXdUMIwRXrisWYKCYwXf+631ilHcizfoLcG9kkcGDBzyGaKjC1Bz+iw==
X-Received: by 2002:a37:6108:: with SMTP id v8mr7108268qkb.264.1599234924005;
        Fri, 04 Sep 2020 08:55:24 -0700 (PDT)
Received: from localhost.localdomain (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:55:23 -0700 (PDT)
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
Subject: [PATCH v3 8/8] iommu/arm-smmu-qcom: Setup identity domain for boot mappings
Date:   Fri,  4 Sep 2020 15:55:13 +0000
Message-Id: <20200904155513.282067-9-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904155513.282067-1-bjorn.andersson@linaro.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With many Qualcomm platforms not having functional S2CR BYPASS a
temporary IOMMU domain, without translation, needs to be allocated in
order to allow these memory transactions.

Unfortunately the boot loader uses the first few context banks, so
rather than overwriting a active bank the last context bank is used and
streams are diverted here during initialization.

This also performs the readback of SMR registers for the Qualcomm
platform, to trigger the mechanism.

This is based on prior work by Thierry Reding and Laurentiu Tudor.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Combined from pieces spread between the Qualcomm impl and generic code in v2.
- Moved to use the newly introduced inherit_mapping op.

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 70a1eaa52e14..a54302190932 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -12,6 +12,7 @@
 struct qcom_smmu {
 	struct arm_smmu_device smmu;
 	bool bypass_broken;
+	struct iommu_domain *identity;
 };
 
 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
@@ -228,6 +229,37 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int qcom_smmu_inherit_mappings(struct arm_smmu_device *smmu)
+{
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	int cbndx;
+	u32 smr;
+	int i;
+
+	qsmmu->identity = arm_smmu_alloc_identity_domain(smmu);
+	if (IS_ERR(qsmmu->identity))
+		return PTR_ERR(qsmmu->identity);
+
+	cbndx = to_smmu_domain(qsmmu->identity)->cfg.cbndx;
+
+	for (i = 0; i < smmu->num_mapping_groups; i++) {
+		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
+
+		if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {
+			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
+			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
+			smmu->smrs[i].valid = true;
+
+			smmu->s2crs[i].type = S2CR_TYPE_TRANS;
+			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
+			smmu->s2crs[i].cbndx = cbndx;
+			smmu->s2crs[i].count++;
+		}
+	}
+
+	return 0;
+}
+
 static int qcom_smmu_def_domain_type(struct device *dev)
 {
 	const struct of_device_id *match =
@@ -270,6 +302,7 @@ static const struct arm_smmu_impl qcom_smmu_impl = {
 	.cfg_probe = qcom_smmu_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = qcom_smmu500_reset,
+	.inherit_mappings = qcom_smmu_inherit_mappings,
 };
 
 static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
-- 
2.28.0

