Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14A1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB62C20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmVT48my"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgHQKtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgHQKtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:49:01 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D344C061346
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:49:01 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q19so7324523pll.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=grYjB3bY1LamRvNCUCtAo+X888pdbkIk5YYwGBwcowM=;
        b=bmVT48myI/uGhC3gktcfp8c3XLHZeGBOwhUqpVaP7XOfrW+VaA5IafFfxxnlCg8a6m
         mFIrkJO/2dPlzoxuyVxRZQ5wU7owQPrQBM2qqX9ulS2NAyxeITOxMXpCquAOMJEafeuZ
         ZL3thqXuGMNmnAAJ64STCuaVZJ71I/7v5UNM4emhQZDD0Qn6Cb9tmSQTcxwdvd0CDwRk
         cTUg6qFmja2hPVA1hBP9GsRl5GBrmVJOrGm9MdY89Tnbu1kGaFtTVZ26ROZax+f5n8G6
         w0v6qlClRbsEGmXjvboR3EzCvcfeaT+yFAa9PpaK9CfPyTBVYrkQPDj156BLcj7TENwO
         auaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=grYjB3bY1LamRvNCUCtAo+X888pdbkIk5YYwGBwcowM=;
        b=O9WCu2fTLOQK/0Lak628ldGcNpqnf/vjtpjxgJcRQRls81f1Uo6e/b0OcS5MVlT63l
         9Ha9MnWm4ghSnBBNuFPsz4S5/PkUOncGfRaxwj9hKX9YrOwsXNwyjXH2FUxJ2PNy7gUQ
         dxueNZe//4m3fB7e2AQk1FnFVdPJC7fP7os9QwC9NByhh3twFJwzbNQTnld9wxR/NvSi
         rQzfN0Cmv5RYbCnfgGZN9NqRI3yAdtiRVSXfgwN+C7eBL9gobZr2F9GxNSGSukxysKCW
         I6/LVchhfWU3x/gv3Hr7O626f7lXqBgQ07RqpGUSBlPIuFU/BCMjEdRfj8Yha/0eDnXb
         a2Bw==
X-Gm-Message-State: AOAM533fawzKO/R7G+cqLxSMsj+PA3y42Goto//QABdj2ELvqLmlTe2n
        hCUVApeTQDzbXB2D+LAiwOU=
X-Google-Smtp-Source: ABdhPJyAWYdBqhYobjrmUBOPSDqBRSjjFV633+0fDxoUXeF+8aaJ/sxschQFaS7osarzkz5QIZ6OOA==
X-Received: by 2002:a17:90b:2083:: with SMTP id hb3mr11850188pjb.234.1597661340941;
        Mon, 17 Aug 2020 03:49:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:c217:67e6:a40c:a3bf:1945])
        by smtp.gmail.com with ESMTPSA id k12sm16976528pjp.38.2020.08.17.03.48.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 03:49:00 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v4 7/9] mfd: mt6360: Remove handle_post_irq callback function
Date:   Mon, 17 Aug 2020 18:47:55 +0800
Message-Id: <1597661277-27862-8-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
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

