Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587ACC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321222075D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPhYRScc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgGDM2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 08:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgGDM2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 08:28:23 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CB8C061794;
        Sat,  4 Jul 2020 05:28:23 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so23557969edz.12;
        Sat, 04 Jul 2020 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+PMOq5Al6StIBzFo1wcc3naFIWV4JdGXcD4ZNngMYA=;
        b=hPhYRSccHjEE/ShMqbPzxgOdCzDHXjA4b8SawVRhXNUUP+zf2Zwez4er/xTE1Ca5uj
         mcfmRVtdHXqBvDsIXbwijSfi+FBiunNeXv8qhhPAbCPrXliUSZiDksu6/uj8i+7X9A9k
         Qs0zcFPfSbKd9Te0JqUwW0M6A7p4KzfnrZjLnIalinkY2YDklLZst1m31vG+rxMTeuV4
         Wj3yTiwBtFzM15NLWPa7JB0yeiAwRefq0LCBA8K9fDP3oiFoDW99RCzwMQ0kGw8rI+fe
         kHsdHKBlGScRmD4f9yRo3O9gGuVemAbp1MrOdMKgtoWmxRKUDkLycxUZ4BSwznkz/Fbk
         zuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+PMOq5Al6StIBzFo1wcc3naFIWV4JdGXcD4ZNngMYA=;
        b=TsvdVxlyeFfv0JKv/bIZWAgvma4mNZsvcmXIz67jW+uMXaovX22uqZ9quhDsH9RYC9
         K9RnJgKZQZTBRZ4Se0uKGqRteUb+agHFRRN4KDOp/uVjmJIymCvZhsXNccycHkGdRFF9
         yJ3fccRfK/2CBIbyARO9ihgaoo3FFZzZyKjWLIYI1nBq7/aUphvOTTWaKrqGraAomyWX
         D5wXFQPr8NONGGvLeeOLOA08poTAkYX9pajV2qKd0g6vRX+VUvepiHABuM32ar+skJrJ
         0jJmI4LRjDCVNrQuLT5GwT8dACkmLDbE5F0xLjkguJUxVlEYuHoPCtGyb5nO4kZgHTjx
         en7w==
X-Gm-Message-State: AOAM5302QN/9OrKhngkUXG3eG/Eqx9v1UvHYEvcp9o9Q/9Rd8nhJ4uBv
        B8J31R+oNQkHLbbWMRPLuX6VLsWPi3I=
X-Google-Smtp-Source: ABdhPJxNoGpPWfHtk5GtUWgId+YmOEKnhvbIaHUdtxzXA+oC0iIVpg7GUe70uTMDbAHPmrfK5PCATw==
X-Received: by 2002:a05:6402:1778:: with SMTP id da24mr33863987edb.126.1593865701817;
        Sat, 04 Jul 2020 05:28:21 -0700 (PDT)
Received: from localhost.localdomain (abab73.neoplus.adsl.tpnet.pl. [83.6.165.73])
        by smtp.googlemail.com with ESMTPSA id be2sm15861831edb.92.2020.07.04.05.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 05:28:21 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
Date:   Sat,  4 Jul 2020 14:28:09 +0200
Message-Id: <20200704122809.73794-1-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the downstream property required to support
SMMUs on SDM630 and other platforms (the need for it
most likely depends on firmware configuration).

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml       | 10 ++++++++++
 drivers/iommu/arm-smmu.c                          | 15 +++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index d7ceb4c34423..9abd6d41a32c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -102,6 +102,16 @@ properties:
       access to SMMU configuration registers. In this case non-secure aliases of
       secure registers have to be used during SMMU configuration.
 
+  qcom,skip-init:
+    description: |
+      Disable resetting configuration for all context banks
+      during device reset.  This is useful for targets where
+      some context banks are dedicated to other execution
+      environments outside of Linux and those other EEs are
+      programming their own stream match tables, SCTLR, etc.
+      Without setting this option we will trample on their
+      configuration.
+
   stream-match-mask:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 243bc4cb2705..a5c623d4caf9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1655,13 +1655,16 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	 * Reset stream mapping groups: Initial values mark all SMRn as
 	 * invalid and all S2CRn as bypass unless overridden.
 	 */
-	for (i = 0; i < smmu->num_mapping_groups; ++i)
-		arm_smmu_write_sme(smmu, i);
 
-	/* Make sure all context banks are disabled and clear CB_FSR  */
-	for (i = 0; i < smmu->num_context_banks; ++i) {
-		arm_smmu_write_context_bank(smmu, i);
-		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
+	if (!of_find_property(smmu->dev->of_node, "qcom,skip-init", NULL)) {
+		for (i = 0; i < smmu->num_mapping_groups; ++i)
+			arm_smmu_write_sme(smmu, i);
+
+		/* Make sure all context banks are disabled and clear CB_FSR  */
+		for (i = 0; i < smmu->num_context_banks; ++i) {
+			arm_smmu_write_context_bank(smmu, i);
+			arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
+		}
 	}
 
 	/* Invalidate the TLB, just in case */
-- 
2.27.0

