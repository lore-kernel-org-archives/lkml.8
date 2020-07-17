Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF48C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC15D20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X90Ag/Zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGQLES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGQLEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:04:15 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F09DC061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:04:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k4so5291635pld.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8q3qeFMAWbIYQ7xRyH7Euf8991pkoYLmr2o7k6CVxR8=;
        b=X90Ag/ZrG6HB2jVtCllueYeYFJg5VyhTJRIKR15eiGjw/VrhhxCwJvejfPCrL+nofE
         wryixuQTRXd+Ty0yyoo9PppLBWgautiGgISHQPlzPrpWJf6RmOMlVypdZDosw+pqDBt2
         3HDVLA4I/aCVLMh5MoCkQZoIakVwov4/8u9FemOGHPfJTHCq4k9XfUJv55jeuppCI+PR
         1jvLfVQl+vOXHC+gAwYUdVdlabAoR5O2qsKmJRHZTVYlx9PHkyeHJcN2F3s5tUA6itBb
         RYipxtMbvJsPR4WJWnpoeXXW6IYxZjBOoAEK1gMjOoxaQT1EhWKFm3tPFRfTkSHqr+5v
         O2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8q3qeFMAWbIYQ7xRyH7Euf8991pkoYLmr2o7k6CVxR8=;
        b=Lv0lNJSTBMjATalV+jKoqIB4BLq4/nd218KOlbf/xNEhcr0inL1H87iV7kiRYm0QW6
         Ko6AbO5vCmGQa0rd1t7o4Q/ir2a7BnkfGnzJHOVOmssyCImwiqBHM92ICO0+WqloztBU
         LTXjYxuy96euXQnFn+ZQGQ5+/zXdSBWZjNUuUAPJHEZH1qRLb2j0QD7wAw9hgQu6FHto
         cnwLRkBt9NGvDKt5pa82dg/CUR0n778ctjbBOesplP9GmnhErwoPaablBF6iXwr6sqp4
         INXOToj/Pf0c+y35ypiQD+1E7kf+DmbWDmsz3A+WDd1PNRhhBpsKtj6asnO8Mc12sji1
         9kmA==
X-Gm-Message-State: AOAM533KRWBNAZeUIXqXnmuyb4+xrFLyGvIIuSXSUxFESFf9HRcifex+
        u0yeAogykh2TDYOzqbQjwHaBW7yR
X-Google-Smtp-Source: ABdhPJyNPNBFaM262FKdU40DHClkOBfbeAFTcMhPqYWWPdXyPn1lPVFUq9sqgcX4jI9CiyXW6YkfsA==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr7198807plm.72.1594983855217;
        Fri, 17 Jul 2020 04:04:15 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:ae36:984e:c073:9d0b:7c09])
        by smtp.gmail.com with ESMTPSA id o26sm7619183pfp.219.2020.07.17.04.04.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 04:04:14 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v2 7/9] mfd: mt6360: Remove handle_post_irq callback function
Date:   Fri, 17 Jul 2020 19:03:29 +0800
Message-Id: <1594983811-25908-8-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Remove handle_post_irq which is used to retrigger irq.
Set irq level low trigger in dtsi to keep irq always be handled.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c  | 16 +++-------------
 include/linux/mfd/mt6360.h |  2 +-
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 5dfc13e..5a68228 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -208,15 +208,8 @@ static const struct regmap_irq mt6360_irqs[] =  {
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
 	.num_regs = MT6360_PMU_IRQ_REGNUM,
@@ -225,7 +218,6 @@ static struct regmap_irq_chip mt6360_irq_chip = {
 	.ack_base = MT6360_PMU_CHG_IRQ1,
 	.init_ack_masked = true,
 	.use_ack = true,
-	.handle_post_irq = mt6360_pmu_handle_post_irq,
 };
 
 static const struct regmap_config mt6360_pmu_regmap_config = {
@@ -339,10 +331,8 @@ static int mt6360_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	mt6360_irq_chip.irq_drv_data = data;
 	ret = devm_regmap_add_irq_chip(&client->dev, data->regmap, client->irq,
-				       IRQF_TRIGGER_FALLING, 0,
-				       &mt6360_irq_chip, &data->irq_data);
+				       0, 0, &mt6360_irq_chip, &data->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
 		return ret;
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
index fbe106c..da0fb5c 100644
--- a/include/linux/mfd/mt6360.h
+++ b/include/linux/mfd/mt6360.h
@@ -230,7 +230,7 @@ struct mt6360_data {
 #define MT6360_PMU_MAXREG			MT6360_PMU_LDO_MASK2
 
 /* MT6360_PMU_IRQ_SET */
-#define MT6360_PMU_IRQ_REGNUM	(MT6360_PMU_LDO_IRQ2 - MT6360_PMU_CHG_IRQ1 + 1)
+#define MT6360_PMU_IRQ_REGNUM	16
 #define MT6360_IRQ_RETRIG	BIT(2)
 
 #define CHIP_VEN_MASK				0xF0
-- 
2.7.4

