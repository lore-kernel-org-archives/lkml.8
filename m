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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0EFC433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C300220768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzS9yO9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGQLER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgGQLEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:04:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85470C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:04:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md7so6210041pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+f+w5v82UMrAgd415FBeV/7c6VBfQ5DmfWoo/tiqC+k=;
        b=rzS9yO9OFZf2npdZKwFi5/ptZCgk+fTk/2xZwkx/M4PskLpHPJgUqMPk6T0wTHEtMQ
         uMm+uv7CiBo5AYMIVVGzP+8iKBt4ydLtvwBG/EHCuYWjST/BSlP/nY7dzk+4cSZINfIz
         PrfiZfV8FhhVUGv71ls6Rq/NW8WpwlDcDsVSBBpmOJ/HGERtttgdnFwT1NcQVedclJnT
         NWl51bi07f0c9zzExyqhMSJg8HbwhlFNuyrw+gvxAwfgL2Yh6jcKO1yqP+Z8Yrf7Ompb
         8PvODFrBlWs1o/zY6hAIu8pj+M21FQbY5j5a2RtcHNps9uMYWwhRG+VKq9oPhrGMR57Q
         suCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+f+w5v82UMrAgd415FBeV/7c6VBfQ5DmfWoo/tiqC+k=;
        b=LFThqdgzkuxtXac9lxDo34r6sgIS8pCQdM9eDev1vP05YmFgERTZHVY3szuM/rHWhh
         t2lkr+Gp33Y6UBhyPtn90CZNKvKlK1PRXBQInwv2N7JSKE3X83riTd8p1h54WauRUdAw
         S+pw2a6LS9u9EVTv0BndepbB3pdbRi8iI1lVtXy6xKAjXZMHiU9ndk46GHGdS6jYG4N1
         vRgb1lth1yuEc43d6yT10zPJxdjMK1mZzW3k6sDY4Y5YEw1301HBkg6ccs0fcTKwV0Zy
         gaR/EpnbotEYgvShLNmQtg+NXn5SsCiQZCAs1cdn99vG6aTx3og48J64ICtlS1bjF8sw
         7gWg==
X-Gm-Message-State: AOAM531NON4Gx8dnHJU4cqKajMelGg9VAaF0mnGf5gogAhHhnDnqYVsb
        ILw62iIWPYDyOhih3ZIKrag=
X-Google-Smtp-Source: ABdhPJwlN8DXzPaNbTZkCBCdCy4L/eUg/CVWDJljBlIU+OGV64KJzmp8YN4B7XhmDFYTiEjtsuYyBQ==
X-Received: by 2002:a17:90b:4910:: with SMTP id kr16mr9309326pjb.126.1594983850127;
        Fri, 17 Jul 2020 04:04:10 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:ae36:984e:c073:9d0b:7c09])
        by smtp.gmail.com with ESMTPSA id o26sm7619183pfp.219.2020.07.17.04.04.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 04:04:09 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v2 5/9] mfd: mt6360: Rename mt6360_pmu_data by mt6360_data
Date:   Fri, 17 Jul 2020 19:03:27 +0800
Message-Id: <1594983811-25908-6-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Rename mt6360_pmu_data by mt6360_data because of including
not only PMU part, but also entire MT6360 IC.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c  | 44 ++++++++++++++++++++++----------------------
 include/linux/mfd/mt6360.h |  2 +-
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 665e26f..62bae1a 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -210,9 +210,9 @@ static const struct regmap_irq mt6360_pmu_irqs[] =  {
 
 static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
 {
-	struct mt6360_pmu_data *mpd = irq_drv_data;
+	struct mt6360_data *data = irq_drv_data;
 
-	return regmap_update_bits(mpd->regmap,
+	return regmap_update_bits(data->regmap,
 		MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
 }
 
@@ -310,61 +310,61 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 
 static int mt6360_pmu_probe(struct i2c_client *client)
 {
-	struct mt6360_pmu_data *mpd;
+	struct mt6360_data *data;
 	unsigned int reg_data;
 	int i, ret;
 
-	mpd = devm_kzalloc(&client->dev, sizeof(*mpd), GFP_KERNEL);
-	if (!mpd)
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
-	mpd->dev = &client->dev;
-	i2c_set_clientdata(client, mpd);
+	data->dev = &client->dev;
+	i2c_set_clientdata(client, data);
 
-	mpd->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
-	if (IS_ERR(mpd->regmap)) {
+	data->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
+	if (IS_ERR(data->regmap)) {
 		dev_err(&client->dev, "Failed to register regmap\n");
-		return PTR_ERR(mpd->regmap);
+		return PTR_ERR(data->regmap);
 	}
 
-	ret = regmap_read(mpd->regmap, MT6360_PMU_DEV_INFO, &reg_data);
+	ret = regmap_read(data->regmap, MT6360_PMU_DEV_INFO, &reg_data);
 	if (ret) {
 		dev_err(&client->dev, "Device not found\n");
 		return ret;
 	}
 
-	mpd->chip_rev = reg_data & CHIP_REV_MASK;
-	if (mpd->chip_rev != CHIP_VEN_MT6360) {
+	data->chip_rev = reg_data & CHIP_REV_MASK;
+	if (data->chip_rev != CHIP_VEN_MT6360) {
 		dev_err(&client->dev, "Device not supported\n");
 		return -ENODEV;
 	}
 
-	mt6360_pmu_irq_chip.irq_drv_data = mpd;
-	ret = devm_regmap_add_irq_chip(&client->dev, mpd->regmap, client->irq,
+	mt6360_pmu_irq_chip.irq_drv_data = data;
+	ret = devm_regmap_add_irq_chip(&client->dev, data->regmap, client->irq,
 				       IRQF_TRIGGER_FALLING, 0,
-				       &mt6360_pmu_irq_chip, &mpd->irq_data);
+				       &mt6360_pmu_irq_chip, &data->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
 		return ret;
 	}
 
-	mpd->i2c[0] = client;
+	data->i2c[0] = client;
 	for (i = 1; i < MT6360_SLAVE_MAX; i++) {
-		mpd->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
+		data->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
 							client->adapter,
 							mt6360_slave_addr[i]);
-		if (IS_ERR(mpd->i2c[i])) {
+		if (IS_ERR(data->i2c[i])) {
 			dev_err(&client->dev,
 				"Failed to get new dummy I2C device for address 0x%x",
 				mt6360_slave_addr[i]);
-			return PTR_ERR(mpd->i2c[i]);
+			return PTR_ERR(data->i2c[i]);
 		}
-		i2c_set_clientdata(mpd->i2c[i], mpd);
+		i2c_set_clientdata(data->i2c[i], data);
 	}
 
 	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
 				   mt6360_devs, ARRAY_SIZE(mt6360_devs), NULL,
-				   0, regmap_irq_get_domain(mpd->irq_data));
+				   0, regmap_irq_get_domain(data->irq_data));
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

