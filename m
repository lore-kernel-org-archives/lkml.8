Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E36C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226B7207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hR7K/50Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgGQAQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 20:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgGQAQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 20:16:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7ADC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 17:16:23 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z3so4493097pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 17:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gz5Zo50XaaYCZ/NxMlikYXYKHZLd81NtOvGkTA8cH8o=;
        b=hR7K/50YBRAiYbzC5YEsIbA8rrB/9x+7sISP+RCiE+PEZ4V1DcU4bLgQSvldNsZ0c8
         DlWjm7LoKVY9Rz8e9IgppsSankyzITQqSY5b/cGexfVASMUQP3opQJ1PjW8bqK6geipV
         zSVYGSqXW0FVUmM3/qy2HG22nBoC6cvLoqstJ0bhcsawn5tbuBgigq9soHAc1TbbbrXI
         ygJEnHbepx4gjwD2rGloW4NabRJXyVxcmxqAPB5n1cfQloJRJi4jmiqmPJbLGPeOQVO1
         zKZqZBmmmRchgEeyycJ7FTZbWWgOm7MNjc4uGjYm6V4G7tYor5UqiYvFokYU6C0EjdDM
         C8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gz5Zo50XaaYCZ/NxMlikYXYKHZLd81NtOvGkTA8cH8o=;
        b=AugLjCGEMwzBJfWWM3JfqwvIidI2IBzI3fZhrLivibAnQKxlrfySISLU5DAL856vzf
         w6iDZ+j3M79te8N9ScLCwzcYMmPmkCcrESUhpPxSEmqoVbEz+yNwNVd9nJlnIz1JlfXE
         Kn4UEckOMN3pBLqdDWDamQIQAWSdMMgcb91iAgaHcyX6yRuqrAKMHZ+i0Q4NSEe6nRBT
         7VPxjWzY9SP4j1CtET1yxfqxXEmhSsCRaO8G2h8qQVIvtbuetyIlJhTF/S+D1FqD4d9M
         NUMej5CvJEUQy7ODsqvDdK89chugTi36+732nFyMyilVvnUW1htp05pRyxDPJ8J06yTi
         7kag==
X-Gm-Message-State: AOAM532zoMU922ZxxkgDFGZiaAbAzlbMZOljwE6O+TTcSV6S7NddpRjd
        fK1HJ2au1E11y6EvpZAHboX0Pg==
X-Google-Smtp-Source: ABdhPJy2pM1sb1dp82VBoREb9XieM3FFWojiWZR5vj1MXdZyzILDiZXH1IyjW0siveAEKiPXPp07Lw==
X-Received: by 2002:a63:e00c:: with SMTP id e12mr6451848pgh.413.1594944983134;
        Thu, 16 Jul 2020 17:16:23 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r7sm6211950pgu.51.2020.07.16.17.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 17:16:22 -0700 (PDT)
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
Subject: [PATCH v2 1/5] iommu/arm-smmu: Make all valid stream mappings BYPASS
Date:   Thu, 16 Jul 2020 17:16:15 -0700
Message-Id: <20200717001619.325317-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717001619.325317-1-bjorn.andersson@linaro.org>
References: <20200717001619.325317-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn all stream mappings marked as valid into BYPASS. This allows the
platform specific implementation to configure stream mappings to match
the boot loader's configuration for e.g. display to continue to function
through the reset of the SMMU.

Tested-by: John Stultz <john.stultz@linaro.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Mark arm_smmu_setup_identity() static
- Picked up tested-by tags

 drivers/iommu/arm-smmu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 243bc4cb2705..fb85e716ae9a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1924,6 +1924,22 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int arm_smmu_setup_identity(struct arm_smmu_device *smmu)
+{
+	int i;
+
+	for (i = 0; i < smmu->num_mapping_groups; i++) {
+		if (smmu->smrs[i].valid) {
+			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
+			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
+			smmu->s2crs[i].cbndx = 0xff;
+			smmu->s2crs[i].count++;
+		}
+	}
+
+	return 0;
+}
+
 struct arm_smmu_match_data {
 	enum arm_smmu_arch_version version;
 	enum arm_smmu_implementation model;
@@ -2181,6 +2197,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = arm_smmu_setup_identity(smmu);
+	if (err)
+		return err;
+
 	if (smmu->version == ARM_SMMU_V2) {
 		if (smmu->num_context_banks > smmu->num_context_irqs) {
 			dev_err(dev,
-- 
2.26.2

