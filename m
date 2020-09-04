Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C56C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1ECE2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nq7Yq52d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIDP4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgIDPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:55:26 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F10C06125C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:55:21 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b3so4911996qtg.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2fCr1AJs9wuitAEKSrgAGHFGKqH8nNlJ97BjXbXmjcA=;
        b=nq7Yq52dWK2MdT4FH7gxEZp0TjsJOGIfGdo6BK1+4OqJeoDIhKTf2aDFJDTv6cwKiL
         AAfJNraihxLVh8bWslR94j/0QKdKlYNtwIv3yMrxjDSCQOWEIxYc6ZiE65lUItOWUTtY
         BqFB1frX+GcyJ5SqFnJy0mLNzYc7wuu3R+iYFenJhV6MSs9oxnxjXrbEGZ1RDpM5GY+T
         y8WqyyGYcT8oYzHDGnZ8tQ7tfYTprXqknoa5mg/+T0r8ub6dJ9lD13U53ryGD9+UKow6
         LAJ62Z/mLSjcPYmkMHcOGBIr5g7C3xlrml3u8u7TkDz6TWwCAA8+9cceeXtB6w+uWVVB
         vqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2fCr1AJs9wuitAEKSrgAGHFGKqH8nNlJ97BjXbXmjcA=;
        b=ezdYrloh42cb6wm/SuArUJ25tlTGRpdLAp+dDCQjk7cK1i+jsIqn7wQDH0IoMlPk0S
         NoORRFhd2Rv0iS7g74etiGHV3WImibKTAJ/D1LzBhJXNPZvxdVr805fj/jLP21kHYwAV
         INrpmYA0t9S7KD0gL3pzIlVcdTwLsVlrHzcSd6bMHI+sFWf2jmRe11hW7MoebmVN+KQc
         DKYvHqE0a7COQgMHqsZfoMyk/5xVELkSmTVgMlPv9T65EZ5SceYQkhvaCGFeOSRCIHkf
         8zon0XgTbardnj/qnufzRUWH4cqjXoaPhMil5mql8RDgRz7CDN8a4lsE65OW0liyuYXt
         4UPw==
X-Gm-Message-State: AOAM532WqXy15O2ftrwBLv8yj+Tq8aW6sNiRz9O0K9S4m6Jxy2RduEXg
        GhSCJCd1MfMoujsR2Us1DN0vIA==
X-Google-Smtp-Source: ABdhPJx6yG/QL52OZ4xkujRCTRW3+fj5Lott15EzPUVbvzCJ+ggkUIXMR0Jjrj7i70Ud68y/ORLM9w==
X-Received: by 2002:ac8:66d3:: with SMTP id m19mr9426297qtp.276.1599234920832;
        Fri, 04 Sep 2020 08:55:20 -0700 (PDT)
Received: from localhost.localdomain (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:55:20 -0700 (PDT)
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
Subject: [PATCH v3 5/8] iommu/arm-smmu-qcom: Consistently initialize stream mappings
Date:   Fri,  4 Sep 2020 15:55:10 +0000
Message-Id: <20200904155513.282067-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904155513.282067-1-bjorn.andersson@linaro.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
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

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 284761a1cd8e..70a1eaa52e14 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -195,6 +195,7 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
 	u32 reg;
+	int i;
 
 	/*
 	 * With some firmware writes to S2CR of type FAULT are ignored, and
@@ -206,9 +207,24 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT);
 	arm_smmu_gr0_write(smmu, last_s2cr, reg);
 	reg = arm_smmu_gr0_read(smmu, last_s2cr);
-	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS)
+	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS) {
 		qsmmu->bypass_broken = true;
 
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
2.28.0

