Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5366AC433F8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C8A8207CB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGrAw2FW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgGQAQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 20:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgGQAQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 20:16:28 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45711C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 17:16:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id t11so4484353pfq.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 17:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iuuJuMaKgUlLRcc6gFCZ7HFqvJc6qzprtp/8FUZq9U4=;
        b=oGrAw2FWu08q1/KU6m+pJhAwavDgdIcPCeC2VO0HBZ36u6jVuMdY/1nf8t3PfztDxd
         UrUWUVv0AnWLdoKgefsdSYVgpZ4NShv34c7RawVdolP1zjCL4B7AapAXY3oXguBRoRCk
         PF7+1abGWRfMifqD+JULmyLXmWqVVqxxGalfipSqKUxJKGVGQ7TKDI8yZKyevy5YgWxZ
         hSf2uxu+JjBVs9go3Z0QmwRI8M8NXaIWEXiYdzEZdGq9x0D7Fe6x5rpTci8Z2TXY5VGF
         jHPoBeSe8mZhLDOeSB3SGkZLm4ZnuqsBMDyArUSRqy5ww1GBBGt/gDcd4aeLhToTI/hF
         JDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iuuJuMaKgUlLRcc6gFCZ7HFqvJc6qzprtp/8FUZq9U4=;
        b=alGlveJf7NeBV3RCp/dGafF3RwYYoRX4mVaT9dwdSELOpm87b3c68ndIp8csgxJLif
         6j18ip/hSzDnMMA6X8/IiumBAGtPb0v+HceMps0/S+NEylPHRlM1Z430BOFrkvCrRxlo
         vSNXqKR6Zi+AQSN2yog6HlSKJU3ffRf9Htne2O1sz4r3ydJZu7QG5cDjxMO3nQSOq+P8
         0GRvhXWmaE5JHMna7azpAvj4XFnAaa0guFdfi6s5VRyq4owlaszSk2VA+KIvNW8/xm5w
         zvyGHR9HzVBRNcuPyGusRMqkEpSnzjlokECwbzb6QnbfGJaDDa22zTLQvOU0A9aW0bNn
         k3Bg==
X-Gm-Message-State: AOAM532y8F2ghXNaKLeAZzOLTm6wOIbnQSs6HAXxVb9j+rQ1ur0Vu1xx
        WDbEi/WHWf9bS3qcvnjKju6IKH6osJU=
X-Google-Smtp-Source: ABdhPJwSZZ9bKl9IV9ztWA8mR2McxctG8Dmv5bJM8VuXAimbsGQd1EoPEyeJ0iHJ6beRLFNWkuNlnA==
X-Received: by 2002:a63:1e4d:: with SMTP id p13mr6161160pgm.387.1594944987760;
        Thu, 16 Jul 2020 17:16:27 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r7sm6211950pgu.51.2020.07.16.17.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 17:16:27 -0700 (PDT)
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
Subject: [PATCH v2 4/5] iommu/arm-smmu-qcom: Consistently initialize stream mappings
Date:   Thu, 16 Jul 2020 17:16:18 -0700
Message-Id: <20200717001619.325317-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717001619.325317-1-bjorn.andersson@linaro.org>
References: <20200717001619.325317-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware that traps writes to S2CR to translate BYPASS into FAULT also
ignores writes of type FAULT. As such booting with "disable_bypass" set
will result in all S2CR registers left as configured by the bootloader.

This has been seen to result in indeterministic results, as these
mappings might linger and reference context banks that Linux is
reconfiguring.

Use the fact that BYPASS writes result in FAULT type to force all stream
mappings to FAULT.

Tested-by: John Stultz <john.stultz@linaro.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Fixed subject spelling mistake
- Picked up tested-by

 drivers/iommu/arm-smmu-qcom.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index d95a5ee8c83c..10eb024981d1 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -27,6 +27,7 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 {
 	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 	u32 reg;
+	int i;
 
 	/*
 	 * With some firmware writes to S2CR of type FAULT are ignored, and
@@ -37,9 +38,24 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 					    FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
 					    FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT));
 	reg = arm_smmu_gr0_read(smmu, last_s2cr);
-	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS)
+	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS) {
 		smmu->qcom_bypass_quirk = true;
 
+		/*
+		 * With firmware ignoring writes of type FAULT, booting the
+		 * Linux kernel with disable_bypass disabled (i.e. "enable
+		 * bypass") the initialization during probe will leave mappings
+		 * in an inconsistent state. Avoid this by configuring all
+		 * S2CRs to BYPASS.
+		 */
+		for (i = 0; i < smmu->num_mapping_groups; i++) {
+			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
+			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
+			smmu->s2crs[i].cbndx = 0xff;
+			smmu->s2crs[i].count = 0;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.26.2

