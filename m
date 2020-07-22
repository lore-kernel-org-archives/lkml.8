Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E218AC433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BE820729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9PDOYZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbgGVKIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVKIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB57C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so1288581wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tqJGHcqnXllhT3i9mtu0Lc+0SV7sbcx3SOZYG1XkKfA=;
        b=p9PDOYZQBZFwInhDslg9WZYyix7m2mpmo8VPUoS4fP+oZL443IxmyIIyf8xSpK5H8K
         goHRonE5J8yxyVzO2gJ5BXCGOSYZYPhnUhlqcZHkZLBJkDzXceAur9kOUe2NFkSLNAGR
         soVnih22Rn8gbnCSRorLphgewQqtnwJZwEfBckmuzS/XL3/qoyBPk2yA0s0nOUxrHTPW
         4uX82uZ1mzbXMn1GPjgh8Py8RyV3jE2ucb2932Yl2DkQCwD/pW7WHBKugp8ZM3yuWw/o
         8fJhuK6k2W6jEHbuxTfpgLWhqItKYIk7qrX3FMlePfyKNdQ4cvRXfQsKvm57WN+NOokG
         rh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tqJGHcqnXllhT3i9mtu0Lc+0SV7sbcx3SOZYG1XkKfA=;
        b=onnfd+Avn1ilRp1FcfZrqJ/Y4ve7yW9vcHsZ0zxBLXHKX2CRpgkYKVOLTHG3lLD1Fh
         gGejlXa8MnRgpAFpn4d+/rCiJH9mw4AXGFhrTmRfsWl6IEwg8jwMOZU+sJAfkY+y7v7U
         /rCGc8xZLhUmbwER4J4MChrbaCw368GTVEsLnGutxWhi+kruHSWjus8alUbDejAASZs+
         s647n/XreItkFhFqu9WPx4fUVTR6IPC96u3j64/8E3ZDVY/oW5E5cFrCEtZMYj5TKP/X
         AJ+crD1jcawe5wTD+/p4z8mNrVKAqLzBjpeVh32At2yBysUWbYHdenOR5h7r3yU4WdXN
         HinA==
X-Gm-Message-State: AOAM532PD9aR59GFIo43bZzqRp3yeaidrAuLXH3JD6UJiJLsHcbKr4dn
        t7s8LmA9e+VwaHabB3rJRcnuRw==
X-Google-Smtp-Source: ABdhPJyJF+IsSOwm01NqNnxjh+zl+l/Teu3+D5MO9+5TOTJgwB4WUDz6RUA3GHhCZeDUMWX9Wget5A==
X-Received: by 2002:adf:9bdd:: with SMTP id e29mr17170709wrc.394.1595412495100;
        Wed, 22 Jul 2020 03:08:15 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:14 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Freeman Liu <freeman.liu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/14] nvmem: sc27xx: add sc2730 efuse support
Date:   Wed, 22 Jul 2020 11:06:55 +0100
Message-Id: <20200722100705.7772-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
References: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
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
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.21.0

