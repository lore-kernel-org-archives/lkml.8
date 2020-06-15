Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1D920644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5C3+r70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgFODX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 23:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgFODXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 23:23:55 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A636C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 20:23:55 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y17so6213487plb.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 20:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRvF8lsQr0x7g53xkS96+XLvR3HzDaPgTkkvksL0qaM=;
        b=r5C3+r70CCfmisprWufKz4VD6dttYApZzuqUMJR/3xHZFlPK8WVFiNNQpmUueNMAQ4
         0jxKZEOZspqFRpxKHeEDNW7dmsQIIXuJ4d9Uwqk3LftHOcZOKJcRU080NIGHVXmuHL0b
         huFZxswewC5O/ryyb9DR8ba9iD8UwyXd18tbnwH8oq9GZ952iM0A/1JmiP7FOzf7Smjk
         3Q/OCRgWbg2Mw4eGEbpmlvmq4v96GNVyuf+F2S3U+J1QkjvN5c3VTLHBu4e3XG5gS33a
         i9287blUvqGmVfiT9hCD6rTdkkgShI0deMbwsSt5ASTnuo9coodxhnPz6865h6CuXXJ2
         YjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRvF8lsQr0x7g53xkS96+XLvR3HzDaPgTkkvksL0qaM=;
        b=LG04xBj/0nGEd6Euu3djrOe9W95H/Fp4KZ4W5jdmW7UeyOevXhsq+2ij0Gy2OWMl8X
         F5tkYQN0m1bM24MbbfaIadUSOWxZ2yIHA3otiaDgOi5Lt3O4jVsVe0q6+pXuGvNQDHYb
         2RcENJA+dFPLafYe7563YWAFuZLhmbdEUDv5nnaOJiLTRdYrla5+jYswvMmoF/5M3x7u
         r++3a/uzCJjjhG4W5OieeFTL/b19ZBVq490zSQ7RoS92DXic/VQLKs5il+0/Bs0Q/nc+
         DgQPluCLIEO4UiefVGVFW0LjGBK7A3CpjNcLr5wI2RHkbx67V/ZBhxGs6sFSgX4jECgo
         ZFiw==
X-Gm-Message-State: AOAM531LZ83b4wS+kXIEU1Hy9M6x27uhRXqMuN5NztgITXKTCl643cPX
        mMHln8fTwM1PRhC/cnHzvU0=
X-Google-Smtp-Source: ABdhPJxmgNxqvIWnyFBWd1nUgEymdAzcov5NPD7csneQTI7UHPxcTvx++csvf3LRmbeeWjxCRWMV1g==
X-Received: by 2002:a17:902:fe95:: with SMTP id x21mr20974152plm.17.1592191435080;
        Sun, 14 Jun 2020 20:23:55 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 10sm12011661pfn.6.2020.06.14.20.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 20:23:54 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Freeman Liu <freeman.liu@unisoc.com>
Subject: [PATCH] nvmem: sc27xx: add sc2730 efuse support
Date:   Mon, 15 Jun 2020 11:23:47 +0800
Message-Id: <20200615032347.10586-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

Add support to the new efuse IP which is integrated in the SC2730
which includes multiple blocks in a single chip.

Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/nvmem/sc27xx-efuse.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
index ab5e7e0bc3d8..7d453c9d80da 100644
--- a/drivers/nvmem/sc27xx-efuse.c
+++ b/drivers/nvmem/sc27xx-efuse.c
@@ -4,12 +4,14 @@
 #include <linux/hwspinlock.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/nvmem-provider.h>
 
 /* PMIC global registers definition */
 #define SC27XX_MODULE_EN		0xc08
+#define SC2730_MODULE_EN		0x1808
 #define SC27XX_EFUSE_EN			BIT(6)
 
 /* Efuse controller registers definition */
@@ -49,12 +51,29 @@
 #define SC27XX_EFUSE_POLL_TIMEOUT	3000000
 #define SC27XX_EFUSE_POLL_DELAY_US	10000
 
+/*
+ * Since different PMICs of SC27xx series can have different
+ * address , we should save address in the device data structure.
+ */
+struct sc27xx_efuse_variant_data {
+	u32 module_en;
+};
+
 struct sc27xx_efuse {
 	struct device *dev;
 	struct regmap *regmap;
 	struct hwspinlock *hwlock;
 	struct mutex mutex;
 	u32 base;
+	const struct sc27xx_efuse_variant_data *var_data;
+};
+
+static const struct sc27xx_efuse_variant_data sc2731_edata = {
+	.module_en = SC27XX_MODULE_EN,
+};
+
+static const struct sc27xx_efuse_variant_data sc2730_edata = {
+	.module_en = SC2730_MODULE_EN,
 };
 
 /*
@@ -119,7 +138,7 @@ static int sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
 		return ret;
 
 	/* Enable the efuse controller. */
-	ret = regmap_update_bits(efuse->regmap, SC27XX_MODULE_EN,
+	ret = regmap_update_bits(efuse->regmap, efuse->var_data->module_en,
 				 SC27XX_EFUSE_EN, SC27XX_EFUSE_EN);
 	if (ret)
 		goto unlock_efuse;
@@ -169,7 +188,7 @@ static int sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
 
 disable_efuse:
 	/* Disable the efuse controller after reading. */
-	regmap_update_bits(efuse->regmap, SC27XX_MODULE_EN, SC27XX_EFUSE_EN, 0);
+	regmap_update_bits(efuse->regmap, efuse->var_data->module_en, SC27XX_EFUSE_EN, 0);
 unlock_efuse:
 	sc27xx_efuse_unlock(efuse);
 
@@ -187,8 +206,15 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
 	struct nvmem_config econfig = { };
 	struct nvmem_device *nvmem;
 	struct sc27xx_efuse *efuse;
+	const struct sc27xx_efuse_variant_data *pdata;
 	int ret;
 
+	pdata = of_device_get_match_data(&pdev->dev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "No matching driver data found\n");
+		return -EINVAL;
+	}
+
 	efuse = devm_kzalloc(&pdev->dev, sizeof(*efuse), GFP_KERNEL);
 	if (!efuse)
 		return -ENOMEM;
@@ -219,6 +245,7 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
 
 	mutex_init(&efuse->mutex);
 	efuse->dev = &pdev->dev;
+	efuse->var_data = pdata;
 
 	econfig.stride = 1;
 	econfig.word_size = 1;
@@ -238,7 +265,8 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sc27xx_efuse_of_match[] = {
-	{ .compatible = "sprd,sc2731-efuse" },
+	{ .compatible = "sprd,sc2731-efuse", .data = &sc2731_edata},
+	{ .compatible = "sprd,sc2730-efuse", .data = &sc2730_edata},
 	{ }
 };
 
-- 
2.20.1

