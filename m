Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DFCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BCB20866
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSfbJTKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgHZKt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgHZKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:49:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5E8C061756;
        Wed, 26 Aug 2020 03:49:38 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 31so822697pgy.13;
        Wed, 26 Aug 2020 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=08o5ly8B0TR5JXi4Q4xNhjYvt/vu2rxsxB9CO4/WNo0=;
        b=KSfbJTKZxRm3OlxBgBs9R6Om/Ztv7hoaseoMvRdgqb+YERO/lqK2cDd/S4/WxNdZ9w
         A8hTfIxvW9N/xOSeVSH0hSuy8qhUGv6fldlAuwSYyTmoMgxZ1SE/HkvowS4vhkLPgnPb
         Az1iAwwU6PWkTXE/ifvo/FWZ1YDRsSKxPQdTEimL6YaWxPTDeBz5gpsUE8b3IxwYpmMi
         gYpn7XeOxrZDwq+iVefwAS51i6V2EoWSu6G/9JSJJS/CcHhGJKHrtM2mP6oAU6vf0VDa
         Ivpny8HW4wSVAM6ZE3gokVrPAymCnY9py6IcMGxY3e2HTlRlz/3XLrezjdISPhDEO3QV
         sF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=08o5ly8B0TR5JXi4Q4xNhjYvt/vu2rxsxB9CO4/WNo0=;
        b=gSspgYSnhJFXes/fv/cY81j4HxOYh0RICOzrlZeXWnzTEJHqD+aiRqq8LwvSaMLvrV
         m591m/rbbpVuBkVEsUORCcgbhGzzlgBOC0Lt8VozWrJjMV3N6lu1po/SJmmO9cApLGLl
         jJeIPJT/MhmqziqTBVlLEjtZuLapTIXWtv6zet5ivGThrXm3fH2wxhl7fxYnzBxTU7WS
         UVN95JdM9DeLkcvfg6ifFyyfQDp0OzYf/os6gfLeGvzQg9EDt5+8rAqgo0D8h91JB44d
         34gxceKgBVvnBs493Rrk2OXa5dBK+MPlh06B/xMC+CvyjyAAirbhBKZhIUA7SE7oOeL2
         4KIQ==
X-Gm-Message-State: AOAM5312KwIMWyswlM6ZIUhxfis+qNozSZzUPMzCGKofV1eJYEYg1IaR
        3DB29/ObpP5BkOxxFHlRTzk=
X-Google-Smtp-Source: ABdhPJxl9i29K0vQZW7ARuDzsT0apugEtdS0A0pH9OWA1ZLdGd3VxqTzUuBE7vAaBT3plIKtttfr1g==
X-Received: by 2002:a63:c901:: with SMTP id o1mr9617194pgg.2.1598438978322;
        Wed, 26 Aug 2020 03:49:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56a:2197:d2eb:7e49:dfa1:a882])
        by smtp.gmail.com with ESMTPSA id d127sm2540349pfc.175.2020.08.26.03.49.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 03:49:38 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: [PATCH v4 1/2] regulator: mt6360: Add support for MT6360 regulator
Date:   Wed, 26 Aug 2020 18:49:17 +0800
Message-Id: <1598438958-26802-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598438958-26802-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1598438958-26802-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add MT6360 regulator driver that contains two BUCKs and six LDOs

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mt6360-regulator.c               | 459 +++++++++++++++++++++
 .../regulator/mediatek,mt6360-regulator.h          |  16 +
 4 files changed, 485 insertions(+)
 create mode 100644 drivers/regulator/mt6360-regulator.c
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6360-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index de17ef7..8a6c3c6 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -711,6 +711,15 @@ config REGULATOR_MT6358
 	  This driver supports the control of different power rails of device
 	  through regulator interface.
 
+config REGULATOR_MT6360
+	tristate "MT6360 SubPMIC Regulator"
+	depends on MFD_MT6360
+	help
+	  Say Y here to enable MT6360 regulator support.
+	  This is support MT6360 PMIC/LDO part include
+	  2-channel buck with Thermal Shutdown and Overload Protection
+	  6-channel High PSRR and Low Dropout LDO.
+
 config REGULATOR_MT6380
 	tristate "MediaTek MT6380 PMIC"
 	depends on MTK_PMIC_WRAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index d8d3ecf..821a33f 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
+obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_LABIBB) += qcom-labibb-regulator.o
diff --git a/drivers/regulator/mt6360-regulator.c b/drivers/regulator/mt6360-regulator.c
new file mode 100644
index 0000000..89ce379
--- /dev/null
+++ b/drivers/regulator/mt6360-regulator.c
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (C) 2020 MediaTek Inc.
+//
+// Author: Gene Chen <gene_chen@richtek.com>
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
+
+enum {
+	MT6360_REGULATOR_BUCK1 = 0,
+	MT6360_REGULATOR_BUCK2,
+	MT6360_REGULATOR_LDO6,
+	MT6360_REGULATOR_LDO7,
+	MT6360_REGULATOR_LDO1,
+	MT6360_REGULATOR_LDO2,
+	MT6360_REGULATOR_LDO3,
+	MT6360_REGULATOR_LDO5,
+	MT6360_REGULATOR_MAX,
+};
+
+struct mt6360_irq_mapping {
+	const char *name;
+	irq_handler_t handler;
+};
+
+struct mt6360_regulator_desc {
+	const struct regulator_desc desc;
+	unsigned int mode_reg;
+	unsigned int mode_mask;
+	unsigned int state_reg;
+	unsigned int state_mask;
+	const struct mt6360_irq_mapping *irq_tables;
+	int irq_table_size;
+};
+
+struct mt6360_regulator_data {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+static irqreturn_t mt6360_pgb_event_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev = data;
+
+	regulator_notifier_call_chain(rdev, REGULATOR_EVENT_FAIL, NULL);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mt6360_oc_event_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev = data;
+
+	regulator_notifier_call_chain(rdev, REGULATOR_EVENT_OVER_CURRENT, NULL);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mt6360_ov_event_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev = data;
+
+	regulator_notifier_call_chain(rdev, REGULATOR_EVENT_REGULATION_OUT, NULL);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mt6360_uv_event_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev = data;
+
+	regulator_notifier_call_chain(rdev, REGULATOR_EVENT_UNDER_VOLTAGE, NULL);
+	return IRQ_HANDLED;
+}
+
+static const struct mt6360_irq_mapping buck1_irq_tbls[] = {
+	{ "buck1_pgb_evt", mt6360_pgb_event_handler },
+	{ "buck1_oc_evt", mt6360_oc_event_handler },
+	{ "buck1_ov_evt", mt6360_ov_event_handler },
+	{ "buck1_uv_evt", mt6360_uv_event_handler },
+};
+
+static const struct mt6360_irq_mapping buck2_irq_tbls[] = {
+	{ "buck2_pgb_evt", mt6360_pgb_event_handler },
+	{ "buck2_oc_evt", mt6360_oc_event_handler },
+	{ "buck2_ov_evt", mt6360_ov_event_handler },
+	{ "buck2_uv_evt", mt6360_uv_event_handler },
+};
+
+static const struct mt6360_irq_mapping ldo6_irq_tbls[] = {
+	{ "ldo6_pgb_evt", mt6360_pgb_event_handler },
+	{ "ldo6_oc_evt", mt6360_oc_event_handler },
+};
+
+static const struct mt6360_irq_mapping ldo7_irq_tbls[] = {
+	{ "ldo7_pgb_evt", mt6360_pgb_event_handler },
+	{ "ldo7_oc_evt", mt6360_oc_event_handler },
+};
+
+static const struct mt6360_irq_mapping ldo1_irq_tbls[] = {
+	{ "ldo1_pgb_evt", mt6360_pgb_event_handler },
+	{ "ldo1_oc_evt", mt6360_oc_event_handler },
+};
+
+static const struct mt6360_irq_mapping ldo2_irq_tbls[] = {
+	{ "ldo2_pgb_evt", mt6360_pgb_event_handler },
+	{ "ldo2_oc_evt", mt6360_oc_event_handler },
+};
+
+static const struct mt6360_irq_mapping ldo3_irq_tbls[] = {
+	{ "ldo3_pgb_evt", mt6360_pgb_event_handler },
+	{ "ldo3_oc_evt", mt6360_oc_event_handler },
+};
+
+static const struct mt6360_irq_mapping ldo5_irq_tbls[] = {
+	{ "ldo5_pgb_evt", mt6360_pgb_event_handler },
+	{ "ldo5_oc_evt", mt6360_oc_event_handler },
+};
+
+static const struct linear_range buck_vout_ranges[] = {
+	REGULATOR_LINEAR_RANGE(300000, 0x00, 0xc7, 5000),
+	REGULATOR_LINEAR_RANGE(1300000, 0xc8, 0xff, 0),
+};
+
+static const struct linear_range ldo_vout_ranges1[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0x09, 10000),
+	REGULATOR_LINEAR_RANGE(600000, 0x0a, 0x10, 0),
+	REGULATOR_LINEAR_RANGE(610000, 0x11, 0x19, 10000),
+	REGULATOR_LINEAR_RANGE(700000, 0x1a, 0x20, 0),
+	REGULATOR_LINEAR_RANGE(710000, 0x21, 0x29, 10000),
+	REGULATOR_LINEAR_RANGE(800000, 0x2a, 0x30, 0),
+	REGULATOR_LINEAR_RANGE(810000, 0x31, 0x39, 10000),
+	REGULATOR_LINEAR_RANGE(900000, 0x3a, 0x40, 0),
+	REGULATOR_LINEAR_RANGE(910000, 0x41, 0x49, 10000),
+	REGULATOR_LINEAR_RANGE(1000000, 0x4a, 0x50, 0),
+	REGULATOR_LINEAR_RANGE(1010000, 0x51, 0x59, 10000),
+	REGULATOR_LINEAR_RANGE(1100000, 0x5a, 0x60, 0),
+	REGULATOR_LINEAR_RANGE(1110000, 0x61, 0x69, 10000),
+	REGULATOR_LINEAR_RANGE(1200000, 0x6a, 0x70, 0),
+	REGULATOR_LINEAR_RANGE(1210000, 0x71, 0x79, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0x7a, 0x80, 0),
+	REGULATOR_LINEAR_RANGE(1310000, 0x81, 0x89, 10000),
+	REGULATOR_LINEAR_RANGE(1400000, 0x8a, 0x90, 0),
+	REGULATOR_LINEAR_RANGE(1410000, 0x91, 0x99, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 0x9a, 0xa0, 0),
+	REGULATOR_LINEAR_RANGE(1510000, 0xa1, 0xa9, 10000),
+	REGULATOR_LINEAR_RANGE(1600000, 0xaa, 0xb0, 0),
+	REGULATOR_LINEAR_RANGE(1610000, 0xb1, 0xb9, 10000),
+	REGULATOR_LINEAR_RANGE(1700000, 0xba, 0xc0, 0),
+	REGULATOR_LINEAR_RANGE(1710000, 0xc1, 0xc9, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0xca, 0xd0, 0),
+	REGULATOR_LINEAR_RANGE(1810000, 0xd1, 0xd9, 10000),
+	REGULATOR_LINEAR_RANGE(1900000, 0xda, 0xe0, 0),
+	REGULATOR_LINEAR_RANGE(1910000, 0xe1, 0xe9, 10000),
+	REGULATOR_LINEAR_RANGE(2000000, 0xea, 0xf0, 0),
+	REGULATOR_LINEAR_RANGE(2010000, 0xf1, 0xf9, 10000),
+	REGULATOR_LINEAR_RANGE(2100000, 0xfa, 0xff, 0),
+};
+
+static const struct linear_range ldo_vout_ranges2[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x09, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0x0a, 0x10, 0),
+	REGULATOR_LINEAR_RANGE(1310000, 0x11, 0x19, 10000),
+	REGULATOR_LINEAR_RANGE(1400000, 0x1a, 0x1f, 0),
+	REGULATOR_LINEAR_RANGE(1500000, 0x20, 0x29, 10000),
+	REGULATOR_LINEAR_RANGE(1600000, 0x2a, 0x2f, 0),
+	REGULATOR_LINEAR_RANGE(1700000, 0x30, 0x39, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0x3a, 0x40, 0),
+	REGULATOR_LINEAR_RANGE(1810000, 0x41, 0x49, 10000),
+	REGULATOR_LINEAR_RANGE(1900000, 0x4a, 0x4f, 0),
+	REGULATOR_LINEAR_RANGE(2000000, 0x50, 0x59, 10000),
+	REGULATOR_LINEAR_RANGE(2100000, 0x5a, 0x60, 0),
+	REGULATOR_LINEAR_RANGE(2110000, 0x61, 0x69, 10000),
+	REGULATOR_LINEAR_RANGE(2200000, 0x6a, 0x6f, 0),
+	REGULATOR_LINEAR_RANGE(2500000, 0x70, 0x79, 10000),
+	REGULATOR_LINEAR_RANGE(2600000, 0x7a, 0x7f, 0),
+	REGULATOR_LINEAR_RANGE(2700000, 0x80, 0x89, 10000),
+	REGULATOR_LINEAR_RANGE(2800000, 0x8a, 0x90, 0),
+	REGULATOR_LINEAR_RANGE(2810000, 0x91, 0x99, 10000),
+	REGULATOR_LINEAR_RANGE(2900000, 0x9a, 0xa0, 0),
+	REGULATOR_LINEAR_RANGE(2910000, 0xa1, 0xa9, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0xaa, 0xb0, 0),
+	REGULATOR_LINEAR_RANGE(3010000, 0xb1, 0xb9, 10000),
+	REGULATOR_LINEAR_RANGE(3100000, 0xba, 0xc0, 0),
+	REGULATOR_LINEAR_RANGE(3110000, 0xc1, 0xc9, 10000),
+	REGULATOR_LINEAR_RANGE(3200000, 0xca, 0xcf, 0),
+	REGULATOR_LINEAR_RANGE(3300000, 0xd0, 0xd9, 10000),
+	REGULATOR_LINEAR_RANGE(3400000, 0xda, 0xe0, 0),
+	REGULATOR_LINEAR_RANGE(3410000, 0xe1, 0xe9, 10000),
+	REGULATOR_LINEAR_RANGE(3500000, 0xea, 0xf0, 0),
+	REGULATOR_LINEAR_RANGE(3510000, 0xf1, 0xf9, 10000),
+	REGULATOR_LINEAR_RANGE(3600000, 0xfa, 0xff, 0),
+};
+
+static const struct linear_range ldo_vout_ranges3[] = {
+	REGULATOR_LINEAR_RANGE(2700000, 0x00, 0x09, 10000),
+	REGULATOR_LINEAR_RANGE(2800000, 0x0a, 0x10, 0),
+	REGULATOR_LINEAR_RANGE(2810000, 0x11, 0x19, 10000),
+	REGULATOR_LINEAR_RANGE(2900000, 0x1a, 0x20, 0),
+	REGULATOR_LINEAR_RANGE(2910000, 0x21, 0x29, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0x2a, 0x30, 0),
+	REGULATOR_LINEAR_RANGE(3010000, 0x31, 0x39, 10000),
+	REGULATOR_LINEAR_RANGE(3100000, 0x3a, 0x40, 0),
+	REGULATOR_LINEAR_RANGE(3110000, 0x41, 0x49, 10000),
+	REGULATOR_LINEAR_RANGE(3200000, 0x4a, 0x4f, 0),
+	REGULATOR_LINEAR_RANGE(3300000, 0x50, 0x59, 10000),
+	REGULATOR_LINEAR_RANGE(3400000, 0x5a, 0x60, 0),
+	REGULATOR_LINEAR_RANGE(3410000, 0x61, 0x69, 10000),
+	REGULATOR_LINEAR_RANGE(3500000, 0x6a, 0x70, 0),
+	REGULATOR_LINEAR_RANGE(3510000, 0x71, 0x79, 10000),
+	REGULATOR_LINEAR_RANGE(3600000, 0x7a, 0x7f, 0),
+};
+
+static int mt6360_regulator_set_mode(struct regulator_dev *rdev,
+				     unsigned int mode)
+{
+	const struct mt6360_regulator_desc *rdesc = (struct mt6360_regulator_desc *)rdev->desc;
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	int shift = ffs(rdesc->mode_mask) - 1;
+	unsigned int val;
+	int ret;
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		val = MT6360_OPMODE_NORMAL;
+		break;
+	case REGULATOR_MODE_STANDBY:
+		val = MT6360_OPMODE_ULP;
+		break;
+	case REGULATOR_MODE_IDLE:
+		val = MT6360_OPMODE_LP;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(regmap, rdesc->mode_reg, rdesc->mode_mask, val << shift);
+	if (ret) {
+		dev_err(&rdev->dev, "%s: fail (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static unsigned int mt6360_regulator_get_mode(struct regulator_dev *rdev)
+{
+	const struct mt6360_regulator_desc *rdesc = (struct mt6360_regulator_desc *)rdev->desc;
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	int shift = ffs(rdesc->mode_mask) - 1;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, rdesc->mode_reg, &val);
+	if (ret)
+		return ret;
+
+	val &= rdesc->mode_mask;
+	val >>= shift;
+
+	switch (val) {
+	case MT6360_OPMODE_LP:
+		return REGULATOR_MODE_IDLE;
+	case MT6360_OPMODE_ULP:
+		return REGULATOR_MODE_STANDBY;
+	case MT6360_OPMODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mt6360_regulator_get_status(struct regulator_dev *rdev)
+{
+	const struct mt6360_regulator_desc *rdesc = (struct mt6360_regulator_desc *)rdev->desc;
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, rdesc->state_reg, &val);
+	if (ret)
+		return ret;
+
+	if (val & rdesc->state_mask)
+		return REGULATOR_STATUS_ON;
+
+	return REGULATOR_STATUS_OFF;
+}
+
+static const struct regulator_ops mt6360_regulator_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_mode = mt6360_regulator_set_mode,
+	.get_mode = mt6360_regulator_get_mode,
+	.get_status = mt6360_regulator_get_status,
+};
+
+static unsigned int mt6360_regulator_of_map_mode(unsigned int hw_mode)
+{
+	switch (hw_mode) {
+	case MT6360_OPMODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	case MT6360_OPMODE_LP:
+		return REGULATOR_MODE_IDLE;
+	case MT6360_OPMODE_ULP:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+#define MT6360_REGULATOR_DESC(_name, _sname, ereg, emask, vreg,	vmask,	\
+			      mreg, mmask, streg, stmask, vranges,	\
+			      vcnts, offon_delay, irq_tbls)		\
+{									\
+	.desc = {							\
+		.name = #_name,						\
+		.supply_name = #_sname,					\
+		.id =  MT6360_REGULATOR_##_name,			\
+		.of_match = of_match_ptr(#_name),			\
+		.regulators_node = of_match_ptr("regulator"),		\
+		.of_map_mode = mt6360_regulator_of_map_mode,		\
+		.owner = THIS_MODULE,					\
+		.ops = &mt6360_regulator_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.vsel_reg = vreg,					\
+		.vsel_mask = vmask,					\
+		.enable_reg = ereg,					\
+		.enable_mask = emask,					\
+		.linear_ranges = vranges,				\
+		.n_linear_ranges = ARRAY_SIZE(vranges),			\
+		.n_voltages = vcnts,					\
+		.off_on_delay = offon_delay,				\
+	},								\
+	.mode_reg = mreg,						\
+	.mode_mask = mmask,						\
+	.state_reg = streg,						\
+	.state_mask = stmask,						\
+	.irq_tables = irq_tbls,						\
+	.irq_table_size = ARRAY_SIZE(irq_tbls),				\
+}
+
+static const struct mt6360_regulator_desc mt6360_regulator_descs[] =  {
+	MT6360_REGULATOR_DESC(BUCK1, BUCK1_VIN, 0x117, 0x40, 0x110, 0xff, 0x117, 0x30, 0x117, 0x04,
+			      buck_vout_ranges, 256, 0, buck1_irq_tbls),
+	MT6360_REGULATOR_DESC(BUCK2, BUCK2_VIN, 0x127, 0x40, 0x120, 0xff, 0x127, 0x30, 0x127, 0x04,
+			      buck_vout_ranges, 256, 0, buck2_irq_tbls),
+	MT6360_REGULATOR_DESC(LDO6, LDO_VIN3, 0x137, 0x40, 0x13B, 0xff, 0x137, 0x30, 0x137, 0x04,
+			      ldo_vout_ranges1, 256, 0, ldo6_irq_tbls),
+	MT6360_REGULATOR_DESC(LDO7, LDO_VIN3, 0x131, 0x40, 0x135, 0xff, 0x131, 0x30, 0x131, 0x04,
+			      ldo_vout_ranges1, 256, 0, ldo7_irq_tbls),
+	MT6360_REGULATOR_DESC(LDO1, LDO_VIN1, 0x217, 0x40, 0x21B, 0xff, 0x217, 0x30, 0x217, 0x04,
+			      ldo_vout_ranges2, 256, 0, ldo1_irq_tbls),
+	MT6360_REGULATOR_DESC(LDO2, LDO_VIN1, 0x211, 0x40, 0x215, 0xff, 0x211, 0x30, 0x211, 0x04,
+			      ldo_vout_ranges2, 256, 0, ldo2_irq_tbls),
+	MT6360_REGULATOR_DESC(LDO3, LDO_VIN1, 0x205, 0x40, 0x209, 0xff, 0x205, 0x30, 0x205, 0x04,
+			      ldo_vout_ranges2, 256, 100, ldo3_irq_tbls),
+	MT6360_REGULATOR_DESC(LDO5, LDO_VIN2, 0x20B, 0x40, 0x20F, 0x7f, 0x20B, 0x30, 0x20B, 0x04,
+			      ldo_vout_ranges3, 128, 100, ldo5_irq_tbls),
+};
+
+static int mt6360_regulator_irq_register(struct platform_device *pdev,
+					 struct regulator_dev *rdev,
+					 const struct mt6360_irq_mapping *tbls,
+					 int tbl_size)
+{
+	int i, irq, ret;
+
+	for (i = 0; i < tbl_size; i++) {
+		const struct mt6360_irq_mapping *irq_desc = tbls + i;
+
+		irq = platform_get_irq_byname(pdev, irq_desc->name);
+		if (irq < 0) {
+			dev_err(&pdev->dev, "Fail to get %s irq\n", irq_desc->name);
+			return irq;
+		}
+
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, irq_desc->handler, 0,
+						irq_desc->name, rdev);
+		if (ret) {
+			dev_err(&pdev->dev, "Fail to request %s irq\n", irq_desc->name);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int mt6360_regulator_probe(struct platform_device *pdev)
+{
+	struct mt6360_regulator_data *mrd;
+	struct regulator_config config = {};
+	int i, ret;
+
+	mrd = devm_kzalloc(&pdev->dev, sizeof(*mrd), GFP_KERNEL);
+	if (!mrd)
+		return -ENOMEM;
+
+	mrd->dev = &pdev->dev;
+
+	mrd->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!mrd->regmap) {
+		dev_err(&pdev->dev, "Failed to get parent regmap\n");
+		return -ENODEV;
+	}
+
+	config.dev = pdev->dev.parent;
+	config.driver_data = mrd;
+	config.regmap = mrd->regmap;
+
+	for (i = 0; i < ARRAY_SIZE(mt6360_regulator_descs); i++) {
+		const struct mt6360_regulator_desc *rdesc = mt6360_regulator_descs + i;
+		struct regulator_dev *rdev;
+
+		rdev = devm_regulator_register(&pdev->dev, &rdesc->desc, &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "Failed to register  %d regulaotr\n", i);
+			return PTR_ERR(rdev);
+		}
+
+		ret = mt6360_regulator_irq_register(pdev, rdev, rdesc->irq_tables,
+						    rdesc->irq_table_size);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to register  %d regulaotr irqs\n", i);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id mt6360_regulator_id_table[] = {
+	{ "mt6360-regulator", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, mt6360_regulator_id_table);
+
+static struct platform_driver mt6360_regulator_driver = {
+	.driver = {
+		.name = "mt6360-regulator",
+	},
+	.probe = mt6360_regulator_probe,
+	.id_table = mt6360_regulator_id_table,
+};
+module_platform_driver(mt6360_regulator_driver);
+
+MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
+MODULE_DESCRIPTION("MT6360 Regulator Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/regulator/mediatek,mt6360-regulator.h b/include/dt-bindings/regulator/mediatek,mt6360-regulator.h
new file mode 100644
index 0000000..21c75de
--- /dev/null
+++ b/include/dt-bindings/regulator/mediatek,mt6360-regulator.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __DT_BINDINGS_MEDIATEK_MT6360_REGULATOR_H__
+#define __DT_BINDINGS_MEDIATEK_MT6360_REGULATOR_H__
+
+/*
+ * BUCK/LDO mode constants which may be used in devicetree properties
+ * (eg. regulator-allowed-modes).
+ * See the manufacturer's datasheet for more information on these modes.
+ */
+
+#define MT6360_OPMODE_LP		2
+#define MT6360_OPMODE_ULP		3
+#define MT6360_OPMODE_NORMAL		0
+
+#endif
-- 
2.7.4

