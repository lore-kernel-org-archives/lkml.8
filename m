Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD978C433E3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B28F20708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMadG799"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgGIFBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 01:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgGIFBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 01:01:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8FAC08C5CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 22:01:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so329788plm.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 22:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=410aRxR/jUVzarYYA7FRja4VMLxxjmJi5LB1naX7CXw=;
        b=pMadG799IDnLhFVn72xi9qEswo6WriD7WzmvA0YSRVBHLDFdlJlXUWOhI85zGWE8FF
         BQpX3w8cQhZAmZfj5SzYtuZ734FjH2WvmZuKI3lZTJVr6CXkYaV7PrTLtqTZkMoa3lmq
         CxOcLRZwzcJUyfNbB93hH9X/KNrEazeClJ1ZzP8aaS/IUKWoyoiYyriWoQwwQ1Gl52ZT
         bJ6Cv247hS8zFF0YMuarBnAPXKnxQCnfyxx77xzqpbRxFJk4VeCGkPl+gaqr/Kl6U0XB
         62aQwYZwvjXo6u+BMOvoipMHZAafGfKkF15TIOrygpjRcjZIZV67V09shv5RSRulIOLZ
         QHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=410aRxR/jUVzarYYA7FRja4VMLxxjmJi5LB1naX7CXw=;
        b=ZSoOk9tEgvbbxIB01D0E9MxRhmIfPIFVAgNs0+6Kd3sb7w9zWWZxR4rVaIazXhyb2x
         HjZ2ZgLUm+vOO+q3qO8NNl5jvc2NTF0uEHlTxDsNqZCr3h0kzqUVoNvChQgYqQCImGdt
         Xnc7l+tUbEEf9JXql70rcyQd3R7N8nFnh9jWrSyvtw8MdenA+YOVosEtTiakzCYjV1aE
         Y+FyBSYkXPOl2M4phiKT0OZuu6pcQks08MbkFxg5i+D0fc48+T298tu6ufpJbQ058y/k
         B1CRwLIj5PAYBZq3EEgE8KJrHkXD1pXgotz6MBnWw+R8tCSKl1aEB6oWWl8R+SqRxo/M
         GtOQ==
X-Gm-Message-State: AOAM533x3iYKd6zXxa+Q6J/rTiwQ5Vsi38kx9+qDt5ubv0f0h7pI4EoJ
        zGU6avMnBKDKZ8VqovIr2KEYRA==
X-Google-Smtp-Source: ABdhPJzn/WLmoGZFSRbIxVw2BwDD4/FnLqo5Y/X/J/6ujt0hVGxCmLwin0PsGP8NMF1YQ2L16L9uEw==
X-Received: by 2002:a17:90b:30c4:: with SMTP id hi4mr12329792pjb.166.1594270906127;
        Wed, 08 Jul 2020 22:01:46 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h15sm999974pjc.14.2020.07.08.22.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 22:01:45 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/5] iommu/arm-smmu-qcom: Consstently initialize stream mappings
Date:   Wed,  8 Jul 2020 22:01:44 -0700
Message-Id: <20200709050145.3520931-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
References: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
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
 drivers/iommu/arm-smmu-qcom.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index e8a36054e912..86b1917459a4 100644
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

