Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D03C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C915E22B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmZcb0Am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgHDQeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbgHDQdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:33:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F38C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 09:33:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ep8so2447318pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 09:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=grYjB3bY1LamRvNCUCtAo+X888pdbkIk5YYwGBwcowM=;
        b=qmZcb0Ama9epFwO2zMvDdHAwnOQBNe6r9ylGehgzoogzAbqGVAoGNj7hCdtU8OEMYj
         qb7ZOvNqNaZ8dTWhVHzK/8CJEdvhhnw84e8+dHd9G1VlNCYPRu6eXMDpW0JEL/WQ8RQ+
         bUG+DF1l9xx7EcM68Sk6JdEg1RJxcHLeDqBBG21wqpgQGW8HgbSc+ZJgjtd7eeintcjs
         ybyRktCUSm4pvk4qbBYeWUMpx/N0Fje+GoqrUxiEHGhQ35f5z2iSSLoR8x0cbQd+BqnB
         ZfupiqD+Zmf60oFXnbD7UYdJDzFrk2z2+AYlD+x5dZeYHQzgD2dL3A9EWP1WPHXxFNEy
         UJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=grYjB3bY1LamRvNCUCtAo+X888pdbkIk5YYwGBwcowM=;
        b=PAD4eazFyv9lGyyGIAecils3VA/aQydz2aJrlPZPQgrVREpadfwlTA+okwc78cXsQ7
         KF9E/5TKETJjvquyzkWaTwDs8kPfMqn7GP69AZvOXM72zpg6gW8A4s30UCHvTkOFUsV9
         Q+h60k6N/FI3+9bFEb9rfxMQP+qD5nUgUoloq46FLUTgGk2OK8ll/mCkLSXKUAjl9zHr
         u9qLBXAFA813YL0eVRo/kUmth+xPbqXEYbBOFZEleCF3fyvKXm/04eBDHQUREd/jEQP2
         0InTFJiYlNC9bF89kIkhkv4j6hOVDNtkOdWHzcD4Xc/PbFsbPhWPGZxd0j+AyNWuuT+z
         Tb3A==
X-Gm-Message-State: AOAM530W2OXLzzy5Fr7X9iajB0kQDH2W2mm6nq1OJfxjfLLMyyh70qhv
        XGuCd1BYr+sRrPOBt/dwt9c=
X-Google-Smtp-Source: ABdhPJyV7sZ1cObVMUHEG1WB2iDkjjlTo02Be2rFobYUkhCGd4Ud2pEVsyBmeRV5CJyg1hWBid20WQ==
X-Received: by 2002:a17:90a:ba05:: with SMTP id s5mr4915328pjr.132.1596558811835;
        Tue, 04 Aug 2020 09:33:31 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id m16sm657253pjz.47.2020.08.04.09.33.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 09:33:31 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com, rafael@kernel.org
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH 7/9] mfd: mt6360: Remove handle_post_irq callback function
Date:   Wed,  5 Aug 2020 00:33:00 +0800
Message-Id: <1596558782-3415-9-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Remove handle_post_irq which is used to retrigger IRQ.
Set IRQ level low trigger in dtsi to keep IRQ always be handled.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c  | 17 ++++-------------
 include/linux/mfd/mt6360.h |  2 +-
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index f75122b..2356d99 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -208,15 +208,8 @@ static const struct regmap_irq mt6360_irqs[] =  {
 	REGMAP_IRQ_REG_LINE(MT6360_LDO7_PGB_EVT, 8),
 };
 
-static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
-{
-	struct mt6360_ddata *ddata = irq_drv_data;
-
-	return regmap_update_bits(ddata->regmap,
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
@@ -339,10 +331,9 @@ static int mt6360_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	mt6360_irq_chip.irq_drv_data = ddata;
 	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
-				       IRQF_TRIGGER_FALLING, 0,
-				       &mt6360_irq_chip, &ddata->irq_data);
+				       0, 0, &mt6360_irq_chip,
+				       &ddata->irq_data);
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

