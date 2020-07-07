Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352BDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F41820702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El9To4oT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgGGKbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:31:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFF4C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:31:31 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cv18so814514pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pxv+3HGXjyEd1PWFcHfkuckp8xQI63ps2NNvxzmKA3Y=;
        b=El9To4oTyvG9A2WMjAE6sJhWDuOjrE6Mnm+wiLdbJPwhysQdeiW+uZjoxNCtO7GlzC
         NyVYdVanVNbOIF9921gHq5ZFDBkDT/HsTnhYQpSL/ZjgUoG1lMF89TUkQqqk/zDVxtEB
         sjPLnEVihUJPq2g/nN/3lnIZQCuBZZxmNDuFAq5W8L59H8JcU92pawMCGk+DUP4bZkEA
         LOqzU3AVe4+wdCa/EUOTEVhLrYyGTaMXxUyJeSePytGwTr1BYEZGG1t0U7AiczJBZlXW
         ZGy91Kf86KWw2KlHa98Yw4zG00+vNGJsT/sWPS/S3ahhsGoifEV8Y4S30YyHq/QAFLbA
         3TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pxv+3HGXjyEd1PWFcHfkuckp8xQI63ps2NNvxzmKA3Y=;
        b=CQ8m2A91lr3A9oXf89fplG+fXCvcw5epmQUFPV3/ELjmFsnO2SxabrlzRGOziECBsn
         evqw3HwiSyprsFXdYdYIwH+r7MCl4BcyMOLY+hufw7idf8m0k2Aogv41mQT7XWGMBGtt
         hgowAFYkOQruuZy8K9Oq4oXAbW7n4ihOBnlYAre+L/iolKhEWMkA1n+AiszCYRY/Eug8
         3GxhwWpg1uSml29VqCqwv1IWf73tUhf1J5ynVaG0Wc1xHsCaH5N/FAnGA9Qjqop6b0YI
         7XS0b4N28XiVDC/6C5uqw5MgnKsq90V/d68nbrXWITPsJTpg5NtZWssLSJzE4F6RQ2JR
         YmYA==
X-Gm-Message-State: AOAM530I0zG3ii0TNQpI4DwYj5oNGmHgeIJamRIYx7VUFO01zTkdq71W
        DS7WRWoT4XAycS25EqK6Oy8=
X-Google-Smtp-Source: ABdhPJz0QpDL9bmryLcPNuvptoOiEywLclN6HSp8WKJzfOQzCVRPaQ8T62aScsd21yV6M7kkDmivLw==
X-Received: by 2002:a17:90a:cc0f:: with SMTP id b15mr3640923pju.83.1594117890879;
        Tue, 07 Jul 2020 03:31:30 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:549:1a30:cc80:8285:be58:d37a])
        by smtp.gmail.com with ESMTPSA id io3sm2159014pjb.22.2020.07.07.03.31.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 03:31:30 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: [PATCH 3/4] mfd: mt6360: Fix flow which is used to check ic exist
Date:   Tue,  7 Jul 2020 18:30:55 +0800
Message-Id: <1594117856-14343-4-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Fix flow which is used to check ic exist

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c  | 28 +++++++++++++++++++---------
 include/linux/mfd/mt6360.h |  8 ++++----
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 2dd5918..4bb2949 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -293,6 +293,23 @@ static const struct mfd_cell mt6360_devs[] = {
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
 
+static int mt6360_check_vendor_info(struct mt6360_data *data)
+{
+	u32 info;
+	int ret;
+
+	ret = regmap_read(data->regmap, MT6360_REG_PMU_DEVINFO, &info);
+	if (ret < 0)
+		return ret;
+
+	if ((info & MT6360_CHIPVEN_MASK) != MT6360_CHIPVEN_VAL)
+		return -ENODEV;
+
+	data->chip_rev = info & MT6360_CHIPREV_MASK;
+
+	return 0;
+}
+
 static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 	MT6360_PMU_SLAVEID,
 	MT6360_PMIC_SLAVEID,
@@ -303,7 +320,6 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 static int mt6360_probe(struct i2c_client *client)
 {
 	struct mt6360_data *data;
-	unsigned int reg_data;
 	int i, ret;
 
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
@@ -319,16 +335,10 @@ static int mt6360_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 	}
 
-	ret = regmap_read(data->regmap, MT6360_PMU_DEV_INFO, &reg_data);
+	ret = mt6360_check_vendor_info(data);
 	if (ret) {
-		dev_err(&client->dev, "Device not found\n");
-		return ret;
-	}
-
-	data->chip_rev = reg_data & CHIP_REV_MASK;
-	if (data->chip_rev != CHIP_VEN_MT6360) {
 		dev_err(&client->dev, "Device not supported\n");
-		return -ENODEV;
+		return ret;
 	}
 
 	ret = devm_regmap_add_irq_chip(&client->dev, data->regmap, client->irq,
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
index 9fc6718..5ec0f5d 100644
--- a/include/linux/mfd/mt6360.h
+++ b/include/linux/mfd/mt6360.h
@@ -30,7 +30,7 @@ struct mt6360_data {
 };
 
 /* PMU register defininition */
-#define MT6360_PMU_DEV_INFO			(0x00)
+#define MT6360_REG_PMU_DEVINFO			(0x00)
 #define MT6360_PMU_CORE_CTRL1			(0x01)
 #define MT6360_PMU_RST1				(0x02)
 #define MT6360_PMU_CRCEN			(0x03)
@@ -233,8 +233,8 @@ struct mt6360_data {
 #define MT6360_IRQ_REGNUM	16
 #define MT6360_IRQ_RETRIG	BIT(2)
 
-#define CHIP_VEN_MASK				(0xF0)
-#define CHIP_VEN_MT6360				(0x50)
-#define CHIP_REV_MASK				(0x0F)
+#define MT6360_CHIPVEN_MASK			(0xF0)
+#define MT6360_CHIPVEN_VAL			(0x50)
+#define MT6360_CHIPREV_MASK			(0x0F)
 
 #endif /* __MT6360_H__ */
-- 
2.7.4

