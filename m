Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6E4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB1720890
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvM2S4Un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgFSJJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgFSJJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:09:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93CFC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:09:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e9so4232560pgo.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hKVi3xiQuCjj9PHZdv2h0Zn9ArwEp+vtWNV+ecyvnSI=;
        b=OvM2S4UnSwRFdW9KlJbaw93S0oKeLqFRrbhMbdihw4sUx6qMvGAVYDt2OoOG61ETrV
         QBaNMjEC1XXixroJ88tjZlPOqHLAw9GyZ5C+P7LeSxEf6lZKAmDRLyl/5KbGZXqLp1lF
         27FnHkmsOl3+OA/iXLVydE5TSWwKArCvgGqygeR8OiVkhibSKHd0dvaVuoKljfq6my2k
         wsfprm1tI9uHp43OVrKDie0fdaAIcQA6MNsrhyKDu2TNLwmjsl8KfIkYy7GBJM6vs2O4
         ufrwwMGx93MqTnipRmr3y6F31g7TF0iwmOO28HyRkRe9vYw6H7loU6qUq6TiB3HKBb/J
         90+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hKVi3xiQuCjj9PHZdv2h0Zn9ArwEp+vtWNV+ecyvnSI=;
        b=SJymM8R1I07h+ClBCw0syj/xdQfljKhLUA9rHBGAkPICBN4ARS7SCPcMjJWbbLT/L1
         5XuGgxTi/2NrBM1uWb6NcHkhx0gPzcfgd11tLcdiK/3FQi5sWZ1I/52h3GX4YvBoLvdM
         sGnaTEPn78urwMJYyvBiFgWbT77JmE1C71SexHKy0kJS+t8GphtGsKHxQmK565k5/GZ5
         MKTwsNpEk6PULbTNmIHlxYC2tzkPTFmPoJPJgTwp6B/GmuXAlxMG4hiwWY2q0k12R0dk
         eca51pr2KBMN1490Ae3PA8eTyFOmmUMm4pvgCI1VOu1p0Utm3JZeOa4fRrj15qyGS8ln
         kPMg==
X-Gm-Message-State: AOAM530qSdKaqk6kKxJSjpoMtRMrNAx2qzP7FQmd/otjlu3EYJqdoCXl
        QZcU3NylQvjf11E4dLsKYpc=
X-Google-Smtp-Source: ABdhPJxpMJpCkPJHwDspbzZwX4pTTq7T4vgki19SPhemT1cEgA8yZqx/i/9HXfuQlsbqnnLpLDX5bQ==
X-Received: by 2002:a62:2942:: with SMTP id p63mr7645497pfp.56.1592557776974;
        Fri, 19 Jun 2020 02:09:36 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id i62sm5405963pfg.90.2020.06.19.02.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 02:09:35 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Xiaopeng Bai <xiaopeng.bai@unisoc.com>
Subject: [PATCH v2] mfd: sprd: populate sub-devices defined in DT
Date:   Fri, 19 Jun 2020 17:09:14 +0800
Message-Id: <20200619090914.23801-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

SC27XX-SPI added subdevices according to a pre-defined mfd_cell array,
no matter these devices were really included on board. In this patch,
switch to use devm_of_platform_populate() for adding sub-devices which
are defined in devicetree.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
Changes since v1:
* Address comments from Lee Jones:
- Switch to use devm_of_platform_populate() to add sub-devices.
---
 drivers/mfd/sprd-sc27xx-spi.c | 75 ++---------------------------------
 1 file changed, 3 insertions(+), 72 deletions(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 33336cde4724..d030a5da5544 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/mfd/core.h>
 #include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <uapi/linux/usb/charger.h>
@@ -93,73 +94,6 @@ enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
 
-static const struct mfd_cell sprd_pmic_devs[] = {
-	{
-		.name = "sc27xx-wdt",
-		.of_compatible = "sprd,sc2731-wdt",
-	}, {
-		.name = "sc27xx-rtc",
-		.of_compatible = "sprd,sc2731-rtc",
-	}, {
-		.name = "sc27xx-charger",
-		.of_compatible = "sprd,sc2731-charger",
-	}, {
-		.name = "sc27xx-chg-timer",
-		.of_compatible = "sprd,sc2731-chg-timer",
-	}, {
-		.name = "sc27xx-fast-chg",
-		.of_compatible = "sprd,sc2731-fast-chg",
-	}, {
-		.name = "sc27xx-chg-wdt",
-		.of_compatible = "sprd,sc2731-chg-wdt",
-	}, {
-		.name = "sc27xx-typec",
-		.of_compatible = "sprd,sc2731-typec",
-	}, {
-		.name = "sc27xx-flash",
-		.of_compatible = "sprd,sc2731-flash",
-	}, {
-		.name = "sc27xx-eic",
-		.of_compatible = "sprd,sc2731-eic",
-	}, {
-		.name = "sc27xx-efuse",
-		.of_compatible = "sprd,sc2731-efuse",
-	}, {
-		.name = "sc27xx-thermal",
-		.of_compatible = "sprd,sc2731-thermal",
-	}, {
-		.name = "sc27xx-adc",
-		.of_compatible = "sprd,sc2731-adc",
-	}, {
-		.name = "sc27xx-audio-codec",
-		.of_compatible = "sprd,sc2731-audio-codec",
-	}, {
-		.name = "sc27xx-regulator",
-		.of_compatible = "sprd,sc2731-regulator",
-	}, {
-		.name = "sc27xx-vibrator",
-		.of_compatible = "sprd,sc2731-vibrator",
-	}, {
-		.name = "sc27xx-keypad-led",
-		.of_compatible = "sprd,sc2731-keypad-led",
-	}, {
-		.name = "sc27xx-bltc",
-		.of_compatible = "sprd,sc2731-bltc",
-	}, {
-		.name = "sc27xx-fgu",
-		.of_compatible = "sprd,sc2731-fgu",
-	}, {
-		.name = "sc27xx-7sreset",
-		.of_compatible = "sprd,sc2731-7sreset",
-	}, {
-		.name = "sc27xx-poweroff",
-		.of_compatible = "sprd,sc2731-poweroff",
-	}, {
-		.name = "sc27xx-syscon",
-		.of_compatible = "sprd,sc2731-syscon",
-	},
-};
-
 static int sprd_pmic_spi_write(void *context, const void *data, size_t count)
 {
 	struct device *dev = context;
@@ -263,12 +197,9 @@ static int sprd_pmic_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_AUTO,
-				   sprd_pmic_devs, ARRAY_SIZE(sprd_pmic_devs),
-				   NULL, 0,
-				   regmap_irq_get_domain(ddata->irq_data));
+	ret = devm_of_platform_populate(&spi->dev);
 	if (ret) {
-		dev_err(&spi->dev, "Failed to register device %d\n", ret);
+		dev_err(&spi->dev, "Failed to populate sub-devices %d\n", ret);
 		return ret;
 	}
 
-- 
2.20.1

