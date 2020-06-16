Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814DFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 02:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60EDB2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 02:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skeTW2FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgFPCFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 22:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgFPCFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 22:05:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE99EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 19:05:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j4so4430311plk.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 19:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jqSbYIPnY6ci51ta8tYoTw2b3jpAI+B7iVRHzIcHBMc=;
        b=skeTW2FKZcVJOT07Lv7sRc0GeKB4kjIUSEG1sKws8vBGognffqobLrxueS5gtKkgCv
         DuMHuJPs1s8kctma7CssV7BnNpluob6TjtLa+usGzXYpJLvK21+okCK0L/tSKkvtDcMY
         kEzr3aDVhj7louujAlY+98U1kMGf9zfmGCuhSrZMZZFaYCAJicH+WipgB6nAMY/2m0wE
         LpsBjhOKmoj+H2sGbgiv3hWPNfFgtwHqkIVYg3yTXqo4INrX26NOhRuL1mV3ieqslZrw
         Yy8TwqAsuxe81JZ5IAbppT/ssGNWUWpNPL4uI+mdveV4RonlzCIF6c5A5fIhXrE1f4Sv
         9GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jqSbYIPnY6ci51ta8tYoTw2b3jpAI+B7iVRHzIcHBMc=;
        b=hedddqP0GDjWcWHfcFEZp5rmoFfQ7a+kVPh0Zu0uhoIM+WNkNKPYpHqGTvzTv6gESb
         wis2GdhHQ3ht5s1H/kkEUbUI5+aIBmgBVWnIIcf3jLKtwc2bDs/1zeIvYGNEIIj2+RNP
         Fhqy6zyEmpzoTJMGNYt2Wm3JJxdvLUcKbaFhE7HmFb9ZQLIbLpjU0WQOj718WQtElwAg
         foZm7mwRUqp7IZrfwf8rMvge7iq7JJxD6QAwKxV3xv0gjQlB+yuMFyjzuSEzcYXnK7hF
         Jt+MjcPKQO9avHQJNvau+HLN2PaSQSRWspxspJvzvVRpfSb7MDeixkeNfbPqEjJq/x7P
         cAag==
X-Gm-Message-State: AOAM532Iv+5Wo4OiJvpgQEo/UgeHnHvkUZUcQ8ckz7ey28kKOaqfGkDL
        V5J74DjByTTWvr27AxF+mEc=
X-Google-Smtp-Source: ABdhPJyV+LZWepMi1+A2rLs/paQuZyjS2m64Hfm8gC82rm4ZiTXJ05c9CTXLLUDbDxQDMMZKTKvZyw==
X-Received: by 2002:a17:90b:4c0b:: with SMTP id na11mr538099pjb.176.1592273122516;
        Mon, 15 Jun 2020 19:05:22 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f14sm13076332pgj.62.2020.06.15.19.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 19:05:21 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Freeman Liu <freeman.liu@unisoc.com>
Subject: [PATCH V2] nvmem: sc27xx: add sc2730 efuse support
Date:   Tue, 16 Jun 2020 10:05:15 +0800
Message-Id: <20200616020515.13494-1-zhang.lyra@gmail.com>
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
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
---
Changes from v1:
* Addressed comments from Srinivas;
* Added reviewed-by from Baolin.
---
 drivers/nvmem/sc27xx-efuse.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
index ab5e7e0bc3d8..c825fc902d10 100644
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
 
@@ -219,6 +238,7 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
 
 	mutex_init(&efuse->mutex);
 	efuse->dev = &pdev->dev;
+	efuse->var_data = of_device_get_match_data(&pdev->dev);
 
 	econfig.stride = 1;
 	econfig.word_size = 1;
@@ -238,7 +258,8 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sc27xx_efuse_of_match[] = {
-	{ .compatible = "sprd,sc2731-efuse" },
+	{ .compatible = "sprd,sc2731-efuse", .data = &sc2731_edata},
+	{ .compatible = "sprd,sc2730-efuse", .data = &sc2730_edata},
 	{ }
 };
 
-- 
2.20.1

