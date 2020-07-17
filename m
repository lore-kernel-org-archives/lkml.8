Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F7DC433F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AD0207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH10izZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGQLEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgGQLEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:04:13 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18045C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:04:13 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so5237185pfh.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZC8CEf+EoFs0JuZ28beB4kGU25SlgcLSyiI/XkWI7vI=;
        b=fH10izZg3UjDvv/gNh2pT+vpiH779ojMfu/U44y84PK6/bi82epZHVivyZjkh4ycO2
         ygTIa0sbnsLHJ9qnE/vBzS6GoPFCWqR9+QGej5EROc08BDcm2XOBljbBqMk8P0QD62+3
         rN1+XaapSLi7IZoyMXL3zN5fXwXrzH49x3pgv6OAa20vLg5OIlHTBv8bvJcj1z7d+aDC
         AcUtHNPJIPR6ugObvmhepBaL7z0D0PzUzS+Yqg0PWm3A406KHGqXsx0+y4+1bXQwEvbX
         Brlb3ajgSDMkhFidc2Nc68ImqawZ8RZBUSpVW2E2HJTO4S6nP21kykxURYwdueeHPJUd
         fxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZC8CEf+EoFs0JuZ28beB4kGU25SlgcLSyiI/XkWI7vI=;
        b=ZTebomkeIkK5eZieL+KizYCdND/5dEBjLSN/RlayDDdLwj8bGO1KxeN/Eb3vqr2Of5
         LaRb1u/Wc5/58INcDTbHMxDUNqaHo/7fUUs4PHbQ21xpg6VLRqye/2X8T/wqVfdn++uH
         Z/XY99apZcP6rJVJU/N1l2oQ8bdWenb0C+OHxK3AckjHKDOMHEWamqMBtsAGTCtbKOpQ
         vUYnMGG9hBi/Zr6t/2sYk6n3rvFqABCpUiuLuA4Gw8oyWbHL4MhV75wB+vt0dF5SjQmn
         RkGMJp1NZNFAbZPHvKzGyt+CUNPXsgG+nIMd6a0LaubGS3ucyXpvYAMMEKt6TSkK8zJ5
         0k0A==
X-Gm-Message-State: AOAM531rYSRnSMAx9UsDoyrSFlmG6yYt2xsPSlufK0wVuRFHQfoNy5YJ
        J5D65LDkfx/vAfMz4eSWu+FYF1xZ
X-Google-Smtp-Source: ABdhPJz9NU6fjpXPM0iOXDH11noDSJVravEXE/247fNVBM3MwNWhnXafc6nHM2mnOWG0wUM7a0hC1w==
X-Received: by 2002:a63:6d48:: with SMTP id i69mr8195450pgc.354.1594983852703;
        Fri, 17 Jul 2020 04:04:12 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:ae36:984e:c073:9d0b:7c09])
        by smtp.gmail.com with ESMTPSA id o26sm7619183pfp.219.2020.07.17.04.04.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 04:04:12 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v2 6/9] mfd: mt6360: Rename mt6360_pmu by mt6360
Date:   Fri, 17 Jul 2020 19:03:28 +0800
Message-Id: <1594983811-25908-7-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Rename mt6360_pmu by mt6360, because of including
not only PMU part, but also entire MT6360 IC

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 62bae1a..5dfc13e 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -119,7 +119,7 @@
 #define MT6360_LDO6_PGB_EVT		126
 #define MT6360_LDO7_PGB_EVT		127
 
-static const struct regmap_irq mt6360_pmu_irqs[] =  {
+static const struct regmap_irq mt6360_irqs[] =  {
 	REGMAP_IRQ_REG_LINE(MT6360_CHG_TREG_EVT, 8),
 	REGMAP_IRQ_REG_LINE(MT6360_CHG_AICR_EVT, 8),
 	REGMAP_IRQ_REG_LINE(MT6360_CHG_MIVR_EVT, 8),
@@ -216,9 +216,9 @@ static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
 		MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
 }
 
-static struct regmap_irq_chip mt6360_pmu_irq_chip = {
-	.irqs = mt6360_pmu_irqs,
-	.num_irqs = ARRAY_SIZE(mt6360_pmu_irqs),
+static struct regmap_irq_chip mt6360_irq_chip = {
+	.irqs = mt6360_irqs,
+	.num_irqs = ARRAY_SIZE(mt6360_irqs),
 	.num_regs = MT6360_PMU_IRQ_REGNUM,
 	.mask_base = MT6360_PMU_CHG_MASK1,
 	.status_base = MT6360_PMU_CHG_IRQ1,
@@ -308,7 +308,7 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 	MT6360_TCPC_SLAVEID,
 };
 
-static int mt6360_pmu_probe(struct i2c_client *client)
+static int mt6360_probe(struct i2c_client *client)
 {
 	struct mt6360_data *data;
 	unsigned int reg_data;
@@ -339,10 +339,10 @@ static int mt6360_pmu_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	mt6360_pmu_irq_chip.irq_drv_data = data;
+	mt6360_irq_chip.irq_drv_data = data;
 	ret = devm_regmap_add_irq_chip(&client->dev, data->regmap, client->irq,
 				       IRQF_TRIGGER_FALLING, 0,
-				       &mt6360_pmu_irq_chip, &data->irq_data);
+				       &mt6360_irq_chip, &data->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
 		return ret;
@@ -374,7 +374,7 @@ static int mt6360_pmu_probe(struct i2c_client *client)
 	return 0;
 }
 
-static int __maybe_unused mt6360_pmu_suspend(struct device *dev)
+static int __maybe_unused mt6360_suspend(struct device *dev)
 {
 	struct i2c_client *i2c = to_i2c_client(dev);
 
@@ -384,7 +384,7 @@ static int __maybe_unused mt6360_pmu_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mt6360_pmu_resume(struct device *dev)
+static int __maybe_unused mt6360_resume(struct device *dev)
 {
 
 	struct i2c_client *i2c = to_i2c_client(dev);
@@ -395,25 +395,24 @@ static int __maybe_unused mt6360_pmu_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(mt6360_pmu_pm_ops,
-			 mt6360_pmu_suspend, mt6360_pmu_resume);
+static SIMPLE_DEV_PM_OPS(mt6360_pm_ops, mt6360_suspend, mt6360_resume);
 
-static const struct of_device_id __maybe_unused mt6360_pmu_of_id[] = {
-	{ .compatible = "mediatek,mt6360_pmu", },
+static const struct of_device_id __maybe_unused mt6360_of_id[] = {
+	{ .compatible = "mediatek,mt6360", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, mt6360_pmu_of_id);
+MODULE_DEVICE_TABLE(of, mt6360_of_id);
 
-static struct i2c_driver mt6360_pmu_driver = {
+static struct i2c_driver mt6360_driver = {
 	.driver = {
-		.name = "mt6360_pmu",
-		.pm = &mt6360_pmu_pm_ops,
-		.of_match_table = of_match_ptr(mt6360_pmu_of_id),
+		.name = "mt6360",
+		.pm = &mt6360_pm_ops,
+		.of_match_table = of_match_ptr(mt6360_of_id),
 	},
-	.probe_new = mt6360_pmu_probe,
+	.probe_new = mt6360_probe,
 };
-module_i2c_driver(mt6360_pmu_driver);
+module_i2c_driver(mt6360_driver);
 
 MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
-MODULE_DESCRIPTION("MT6360 PMU I2C Driver");
+MODULE_DESCRIPTION("MT6360 I2C Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

