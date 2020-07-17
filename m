Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342DAC433F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7B3207CB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFN+J5la"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgGQAQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 20:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgGQAQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 20:16:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF50C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 17:16:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k27so5783122pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWqUMnqB20Yorh5LQCiLslCOOm0+DCqawJ+UCE1bquU=;
        b=HFN+J5lasdtEzt8WaDQDidUq/66N+NwxdcjPVhWpvCd+d0hZ5zNSLuBzBCKO+fjAOK
         C8nKyAjwFqxuDObJnah2wuyJoJ2ffpvR5fWK8OkvnlSYCccjKz9rrM/TXwPfAQzddKXp
         JegnspuFxDCFrVLUsvFTDz2sEWZMKfmsZDCWl7v+E+v74347FvLqBFFcl354G2qMbekZ
         CZw7OAC26K6gtekJV0WnxnzqtDWPvg3aZFxlc3AFEfFeKAnJnR8VesnoH5Ln6MN1a6LP
         94BkbVX/W5v3NeO0S5E4tZtZFQDXPnct1E0y/1HPGl1JKar2q9ypxL2cnAewiG2S6oco
         2I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWqUMnqB20Yorh5LQCiLslCOOm0+DCqawJ+UCE1bquU=;
        b=ebf31g1/3hCNU+cgTLwaRdEohQjgaS6Oo9EVn7wIdmmU9272v04JyEyMjAg8ShX/AE
         UFA/uqgzDKn8P12bcJoTaJkR1XtPubX/+28W3j9fCP7j2iP6jMaL4WNL3+JJ4agP+rbK
         1kdQcaRqfuAfh1WeXM1E0Ef+PCTWg0qEeUUway/6avTWgnuIEFWVkiCq9xY40+8Qhx7P
         NnEX7SkPl3pBKdSV/tNC+onqma0sE5wg5AHLZbm/0um+hJTNEsuN5X1lz5nbJmSGY+RT
         zbzdzr0Sf9cpskUzIpfEU2xpzr9pq/SqOcx37QgsPnJ5lCi59G53IMI4X8ZzUIb3PO5e
         s8TQ==
X-Gm-Message-State: AOAM531cgS/8zCqdAERQ74UX08www7ksbhcInOPpLuTYkzx8vVCsJRJW
        7lZyF4gJcJdzJopmrmJkEB0f0Q==
X-Google-Smtp-Source: ABdhPJzhp8wrF9EsgCUoqrojoUNB4BkSM3/fWxyDMIkhZTNNrxXnc9QP6rLIKqr2mcsWBO8ZpScFnA==
X-Received: by 2002:a63:140f:: with SMTP id u15mr6116836pgl.94.1594944986245;
        Thu, 16 Jul 2020 17:16:26 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r7sm6211950pgu.51.2020.07.16.17.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 17:16:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 3/5] iommu/arm-smmu: Move SMR and S2CR definitions to header file
Date:   Thu, 16 Jul 2020 17:16:17 -0700
Message-Id: <20200717001619.325317-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717001619.325317-1-bjorn.andersson@linaro.org>
References: <20200717001619.325317-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the SMR and S2CR structs in the header file, to allow platform
specific implementations to populate/initialize the smrs and s2cr
arrays.

Tested-by: John Stultz <john.stultz@linaro.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Picked up tested-by

 drivers/iommu/arm-smmu.c | 14 --------------
 drivers/iommu/arm-smmu.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5d5fe6741ed4..08a650fe02e3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -68,24 +68,10 @@ module_param(disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
 
-struct arm_smmu_s2cr {
-	struct iommu_group		*group;
-	int				count;
-	enum arm_smmu_s2cr_type		type;
-	enum arm_smmu_s2cr_privcfg	privcfg;
-	u8				cbndx;
-};
-
 #define s2cr_init_val (struct arm_smmu_s2cr){				\
 	.type = disable_bypass ? S2CR_TYPE_FAULT : S2CR_TYPE_BYPASS,	\
 }
 
-struct arm_smmu_smr {
-	u16				mask;
-	u16				id;
-	bool				valid;
-};
-
 struct arm_smmu_cb {
 	u64				ttbr[2];
 	u32				tcr[2];
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index a71d193073e4..bcd160d01c53 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -251,6 +251,21 @@ enum arm_smmu_implementation {
 	QCOM_SMMUV2,
 };
 
+struct arm_smmu_s2cr {
+	struct iommu_group		*group;
+	int				count;
+	enum arm_smmu_s2cr_type		type;
+	enum arm_smmu_s2cr_privcfg	privcfg;
+	u8				cbndx;
+};
+
+struct arm_smmu_smr {
+	u16				mask;
+	u16				id;
+	bool				valid;
+	bool				pinned;
+};
+
 struct arm_smmu_device {
 	struct device			*dev;
 
-- 
2.26.2

