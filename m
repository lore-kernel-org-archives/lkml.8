Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5998C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A78F82177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="engxWD/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgHDQeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbgHDQd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:33:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04546C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 09:33:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f9so2440813pju.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f0rQmLd2gYqpAFiuJBl/hAMED12SSRFPW07wfVi8OZw=;
        b=engxWD/2i+V2t4tSV5/le1iMnbVOBbW/GxmxDrA2C2rs4CWpWnVAScr/gRsHxYe5Ql
         1XJSb0ubzDfpLGFa1UhUCUKjN7VsIA6WgAKjcWjNQhM/diQIGj/XB0nbu6+ath8kf4Um
         mqFSKoLK0bXOsqcZreIn6iwicMAj+JOWWF3bMks0HR6MioLICLqKk4JIGN5PlR62Pe6G
         JHZjdUpxEZOiA8uOtj3a7rV52qLdOPskqNseSItHRhT1l7NPxWAElZe7qyGCGJJ2RtNu
         FTXcOPmB8QobtYjCqw5PdXP2TwYF5QMpioXR259dPFWdaIID4eqV3sDFbT4aPJIEqBn8
         DmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f0rQmLd2gYqpAFiuJBl/hAMED12SSRFPW07wfVi8OZw=;
        b=dZzc7MiVXMcvFAVeaAmPLsuPpfugIwbazp3kmNI6D2cKP2WXo2eHfUbCMyxxzlV7vD
         yuaTyYjoUwVFVSwgCij4pGDDNliwHvfJCQnX/ppKrEorx33mmKDLHigJwYgiu2H8MgVg
         NUrZXED7NSwJSziQO4liGCnHbpOAXtnooBCNE+lbu6Tvz501nn28vc2QAfoHOUZz8kPh
         lSWrbzWgNAlAyTLMuxClAH0n3gizHzwBrrwf+nn4OM+98dBvOhmsU+qaiUF8fdTSjkdJ
         yYq3eoMGP/j81vLcTMMDLkl5LbC9Nmws7szucGgyx0hQat5f38TIQWsl+FbCNY2umaP4
         iUmg==
X-Gm-Message-State: AOAM5324qRpDv/x87YVOLD/II6/WJq+V+qGeO+SxvMCOh04Ogra5EdOm
        v8t5hjlPRMRH8Vp8YCQM0TEDSJFs
X-Google-Smtp-Source: ABdhPJxuZD1NzfjMM1v6tRfNya7PdTVy5RqF4iUWSDT2L02W91t+jOHzvw9orMH0p+VaLSF0t/YBjw==
X-Received: by 2002:a17:902:fe0d:: with SMTP id g13mr2954693plj.287.1596558806483;
        Tue, 04 Aug 2020 09:33:26 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id m16sm657253pjz.47.2020.08.04.09.33.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 09:33:26 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com, rafael@kernel.org
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH 5/9] mfd: mt6360: Rename mt6360_pmu_data by mt6360_ddata
Date:   Wed,  5 Aug 2020 00:32:58 +0800
Message-Id: <1596558782-3415-7-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Rename mt6360_pmu_data by mt6360_ddata because of including
not only PMU part, but also entire MT6360 IC.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c  | 44 ++++++++++++++++++++++----------------------
 include/linux/mfd/mt6360.h |  2 +-
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 5119e51..332eb5d 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -210,9 +210,9 @@ static const struct regmap_irq mt6360_pmu_irqs[] =  {
 
 static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
 {
-	struct mt6360_pmu_data *mpd = irq_drv_data;
+	struct mt6360_ddata *ddata = irq_drv_data;
 
-	return regmap_update_bits(mpd->regmap,
+	return regmap_update_bits(ddata->regmap,
 		MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
 }
 
@@ -310,61 +310,61 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 
 static int mt6360_pmu_probe(struct i2c_client *client)
 {
-	struct mt6360_pmu_data *mpd;
+	struct mt6360_ddata *ddata;
 	unsigned int reg_data;
 	int i, ret;
 
-	mpd = devm_kzalloc(&client->dev, sizeof(*mpd), GFP_KERNEL);
-	if (!mpd)
+	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
 		return -ENOMEM;
 
-	mpd->dev = &client->dev;
-	i2c_set_clientdata(client, mpd);
+	ddata->dev = &client->dev;
+	i2c_set_clientdata(client, ddata);
 
-	mpd->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
-	if (IS_ERR(mpd->regmap)) {
+	ddata->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
+	if (IS_ERR(ddata->regmap)) {
 		dev_err(&client->dev, "Failed to register regmap\n");
-		return PTR_ERR(mpd->regmap);
+		return PTR_ERR(ddata->regmap);
 	}
 
-	ret = regmap_read(mpd->regmap, MT6360_PMU_DEV_INFO, &reg_data);
+	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &reg_data);
 	if (ret) {
 		dev_err(&client->dev, "Device not found\n");
 		return ret;
 	}
 
-	mpd->chip_rev = reg_data & CHIP_REV_MASK;
-	if (mpd->chip_rev != CHIP_VEN_MT6360) {
+	ddata->chip_rev = reg_data & CHIP_REV_MASK;
+	if (ddata->chip_rev != CHIP_VEN_MT6360) {
 		dev_err(&client->dev, "Device not supported\n");
 		return -ENODEV;
 	}
 
-	mt6360_pmu_irq_chip.irq_drv_data = mpd;
-	ret = devm_regmap_add_irq_chip(&client->dev, mpd->regmap, client->irq,
+	mt6360_pmu_irq_chip.irq_drv_data = ddata;
+	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
 				       IRQF_TRIGGER_FALLING, 0,
-				       &mt6360_pmu_irq_chip, &mpd->irq_data);
+				       &mt6360_pmu_irq_chip, &ddata->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
 		return ret;
 	}
 
-	mpd->i2c[0] = client;
+	ddata->i2c[0] = client;
 	for (i = 1; i < MT6360_SLAVE_MAX; i++) {
-		mpd->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
+		ddata->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
 							client->adapter,
 							mt6360_slave_addr[i]);
-		if (IS_ERR(mpd->i2c[i])) {
+		if (IS_ERR(ddata->i2c[i])) {
 			dev_err(&client->dev,
 				"Failed to get new dummy I2C device for address 0x%x",
 				mt6360_slave_addr[i]);
-			return PTR_ERR(mpd->i2c[i]);
+			return PTR_ERR(ddata->i2c[i]);
 		}
-		i2c_set_clientdata(mpd->i2c[i], mpd);
+		i2c_set_clientdata(ddata->i2c[i], ddata);
 	}
 
 	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
 				   mt6360_devs, ARRAY_SIZE(mt6360_devs), NULL,
-				   0, regmap_irq_get_domain(mpd->irq_data));
+				   0, regmap_irq_get_domain(ddata->irq_data));
 	if (ret) {
 		dev_err(&client->dev,
 			"Failed to register subordinate devices\n");
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
index 72edf13..fbe106c 100644
--- a/include/linux/mfd/mt6360.h
+++ b/include/linux/mfd/mt6360.h
@@ -21,7 +21,7 @@ enum {
 #define MT6360_LDO_SLAVEID	0x64
 #define MT6360_TCPC_SLAVEID	0x4E
 
-struct mt6360_pmu_data {
+struct mt6360_data {
 	struct i2c_client *i2c[MT6360_SLAVE_MAX];
 	struct device *dev;
 	struct regmap *regmap;
-- 
2.7.4

