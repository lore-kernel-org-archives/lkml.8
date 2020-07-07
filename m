Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5F0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945EC20702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gicuxWAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgGGKb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGKb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:31:26 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD1EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:31:26 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s26so4620637pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R8Mecnd/N5RuV2ASVo7CBIbtDgnsjAuRaGhB+0HFu8w=;
        b=gicuxWAwMntPjwvQjl5kbsli4aSZ/UEZS/VhbdBin5eXpEFMtlRPyiHz9qKxsmEl3K
         OECXuzxQ5AN0vpilIe7xH7y4bJ9D5IFlH3n+kgbTWwmdp5naLT+q1aOu822gUMbVflKH
         rKSfPDxrLWYtWQfUCz8QsraOzoqaV35SK84MqBcXxGW8ChtV3ww8x4DIwsab1tv8EysB
         Bt47LSGAYIe0gG25HuOOSgSLPFKodBsDRZrybcKDPmofugx4yNTJpXMIc3/U0a0Ptgr7
         3QwXxe0Gc8xSq89Z17H6G1unNtAu4ad4M+PRqE+DNRqhTDmCTglHm1bMO3fB98u1JzXT
         s1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R8Mecnd/N5RuV2ASVo7CBIbtDgnsjAuRaGhB+0HFu8w=;
        b=PP4E7+5+t/+hASM897g9YiLFpQPgvd9TZXaehMPeDM4UWSv+WZpHlFD8mxCgCiS/XZ
         hiwxS5PF+OR7uHAo/63vxZw/Ru+S3fVABtGVPsAQ29Iuycds436pF6Tgp5YXBq16UkOy
         NJzldUlSFABQ35x6C0rEXX3x/KBrZPFDtJ1Pe0o1+AgojQre1NKX3sreHdoJLLdjxX9/
         Yl9zu0EacCuKEMIWmD9GZe7z4a04SmORzrz/1k8+ZDGIKmyBRdP2IsqsXfBUchJwiLH/
         TnikKjxoYorxt+CcG4FZD24Y8MO/UdSdhMEAEBaJ+E3D4WbkE9EvYVKYn+p+1zAvjmqy
         akbg==
X-Gm-Message-State: AOAM532nfmedELNVcCYAYiigCoz6e+5Ejkr59Vmles5GPMDs18JY2Ve5
        TIaHx7NQr2lwbVS1Y6DDzfI=
X-Google-Smtp-Source: ABdhPJz2GVdbrVjCYP3z9DeeKDe3WKe4/MXhL33doMCWw6ZlpeVbTH9zSfOauEll/8pOx+0Ci4LmNA==
X-Received: by 2002:a62:8482:: with SMTP id k124mr39271134pfd.285.1594117885763;
        Tue, 07 Jul 2020 03:31:25 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:549:1a30:cc80:8285:be58:d37a])
        by smtp.gmail.com with ESMTPSA id io3sm2159014pjb.22.2020.07.07.03.31.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 03:31:25 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: [PATCH 2/4] mfd: mt6360: Remove handle_post_irq callback function
Date:   Tue,  7 Jul 2020 18:30:54 +0800
Message-Id: <1594117856-14343-3-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Remove handle_post_irq which is used to retrigger irq.
Set irq level low trigger to keep irq always be handled.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c  | 25 ++++++++-----------------
 include/linux/mfd/mt6360.h |  6 +++---
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 5dfc13e..2dd5918 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -208,24 +208,16 @@ static const struct regmap_irq mt6360_irqs[] =  {
 	REGMAP_IRQ_REG_LINE(MT6360_LDO7_PGB_EVT, 8),
 };
 
-static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
-{
-	struct mt6360_data *data = irq_drv_data;
-
-	return regmap_update_bits(data->regmap,
-		MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
-}
-
-static struct regmap_irq_chip mt6360_irq_chip = {
+static const struct regmap_irq_chip mt6360_irq_chip = {
+	.name = "mt6360_irqs",
 	.irqs = mt6360_irqs,
 	.num_irqs = ARRAY_SIZE(mt6360_irqs),
-	.num_regs = MT6360_PMU_IRQ_REGNUM,
-	.mask_base = MT6360_PMU_CHG_MASK1,
-	.status_base = MT6360_PMU_CHG_IRQ1,
-	.ack_base = MT6360_PMU_CHG_IRQ1,
+	.num_regs = MT6360_IRQ_REGNUM,
+	.mask_base = MT6360_REG_PMU_CHGMASK1,
+	.status_base = MT6360_REG_PMU_CHGIRQ1,
+	.ack_base = MT6360_REG_PMU_CHGIRQ1,
 	.init_ack_masked = true,
 	.use_ack = true,
-	.handle_post_irq = mt6360_pmu_handle_post_irq,
 };
 
 static const struct regmap_config mt6360_pmu_regmap_config = {
@@ -339,10 +331,9 @@ static int mt6360_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	mt6360_irq_chip.irq_drv_data = data;
 	ret = devm_regmap_add_irq_chip(&client->dev, data->regmap, client->irq,
-				       IRQF_TRIGGER_FALLING, 0,
-				       &mt6360_irq_chip, &data->irq_data);
+				       IRQF_ONESHOT, 0, &mt6360_irq_chip,
+				       &data->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
 		return ret;
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
index 76077e4..9fc6718 100644
--- a/include/linux/mfd/mt6360.h
+++ b/include/linux/mfd/mt6360.h
@@ -179,7 +179,7 @@ struct mt6360_data {
 #define MT6360_PMU_SPARE2			(0xA0)
 #define MT6360_PMU_SPARE3			(0xB0)
 #define MT6360_PMU_SPARE4			(0xC0)
-#define MT6360_PMU_CHG_IRQ1			(0xD0)
+#define MT6360_REG_PMU_CHGIRQ1			(0xD0)
 #define MT6360_PMU_CHG_IRQ2			(0xD1)
 #define MT6360_PMU_CHG_IRQ3			(0xD2)
 #define MT6360_PMU_CHG_IRQ4			(0xD3)
@@ -211,7 +211,7 @@ struct mt6360_data {
 #define MT6360_PMU_BUCK2_STAT			(0xED)
 #define MT6360_PMU_LDO_STAT1			(0xEE)
 #define MT6360_PMU_LDO_STAT2			(0xEF)
-#define MT6360_PMU_CHG_MASK1			(0xF0)
+#define MT6360_REG_PMU_CHGMASK1			(0xF0)
 #define MT6360_PMU_CHG_MASK2			(0xF1)
 #define MT6360_PMU_CHG_MASK3			(0xF2)
 #define MT6360_PMU_CHG_MASK4			(0xF3)
@@ -230,7 +230,7 @@ struct mt6360_data {
 #define MT6360_PMU_MAXREG			(MT6360_PMU_LDO_MASK2)
 
 /* MT6360_PMU_IRQ_SET */
-#define MT6360_PMU_IRQ_REGNUM	(MT6360_PMU_LDO_IRQ2 - MT6360_PMU_CHG_IRQ1 + 1)
+#define MT6360_IRQ_REGNUM	16
 #define MT6360_IRQ_RETRIG	BIT(2)
 
 #define CHIP_VEN_MASK				(0xF0)
-- 
2.7.4

