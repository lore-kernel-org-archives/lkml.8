Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C531C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7642071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQzatJcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgFVMlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgFVMlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:41:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53853C061796
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:41:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x207so8364617pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doG+Qibpx9UFueyy0W0CrVNyS15JzsuLsQupBt9QvgE=;
        b=iQzatJcuL9WDIP4KEVDiKSFveg8Z6pgISK4ejtUpZTwbG7IRlVUv4Mf/wnJs42D4Dv
         70Hx3RD3MobgA5MXVgVPMF4k2IhgcVOecPttAD1gXYJG9jELvhVObPBiJ1o5faeRZktC
         66z1azO20UW7HnLGftv1okbgf+dZ1njRKAlIJwi4Wdmzg3D5BHSbxo3MxrJV4j/R9fnX
         BK6cNF8RIFoZyUIAmCEMpiXh/4xH14MUZ4PDB156Uh9DXcPnj2Vr0yXVxjx5heiKHF4R
         aRwcIF3A8lHd+zHQO9UxGr4z4lMkFYaS2Pk1gC0ViH7fH7QodpaL3id9oKVAxlDXj0oE
         IEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doG+Qibpx9UFueyy0W0CrVNyS15JzsuLsQupBt9QvgE=;
        b=o/2KrqnYSDFnNNd5zD0D2SS6reBDE5EPqgmIyt+pZbVWIkBkFa0dEikHeiwJjuMPVr
         B8l3CEu4T5VrJouNGD2nJ8cLskyqVpblUPX7xLqaaIzmz8fQQSyr0dOHUj8XVvEVCFBn
         zOxUEZ6HkODwYzE1DOW1HgvxEAn3KL+WVBzJDzIEp+vbdg/bINGIgsXezHO9XrwISgSJ
         VsEcTBLjiBtHxk7d9mMOnHrTuBWLpuekcLjKYRnNrzpeT66I3HnmHai7O43a0GCattNJ
         35Motp2fXTAwdAk1yLJbnn+RcDvgWPgc0eRS6zr2l62X4Oos8YThbwDyyOpefePcTdUh
         kw9A==
X-Gm-Message-State: AOAM5314GUCjF7Zlph8DIBsoRAakOgj2fQUtDtpvOK5l8k6PAcx0KwbV
        prGvEWjnqhDwk/wrxklLdN9Hvw==
X-Google-Smtp-Source: ABdhPJxCieCQSLmPNdyAB5ZCSv2fxRpAFBKFrnxFg2tSTBO3DVw+rZwT5Thxv2w8QpFlBlREe7oRMg==
X-Received: by 2002:a62:8608:: with SMTP id x8mr19358832pfd.96.1592829695710;
        Mon, 22 Jun 2020 05:41:35 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id i62sm14590581pfg.90.2020.06.22.05.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 05:41:35 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     nishakumari@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v5 4/4] regulator: qcom: Add labibb driver
Date:   Mon, 22 Jun 2020 18:11:10 +0530
Message-Id: <20200622124110.20971-5-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622124110.20971-1-sumit.semwal@linaro.org>
References: <20200622124110.20971-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nisha Kumari <nishakumari@codeaurora.org>

Qualcomm platforms have LAB(LCD AMOLED Boost)/IBB(Inverting Buck Boost)
regulators, labibb for short, which are used as power supply for
LCD Mode displays.

This patch adds labibb regulator driver for pmi8998 PMIC, found on
SDM845 platforms.

Signed-off-by: Nisha Kumari <nishakumari@codeaurora.org>
  [sumits: reworked the driver design as per upstream review]
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>

---
v5: sumits: review comments addressed
     - removed dev_info about registering
     - removed of_get_child_by_name()
     - changed from using STATUS1 register to using ENABLE_CTL; this
       allows us to use the regulator_*_regmap helpers and makes this
       code cleaner. (In limited testing, STATUS1 seemed to report the
       change faster than ENABLE_CTL, but in absence of mechanism to
       validate if the regulator has indeed fully ramped when STATUS1
       starts flagging, broonie suggested to use the slower ENABLE_CTL
       path for safety).
v4: sumits: address review comments from v3, including cleaning up
     register_labibb_regulator(), and adapted to updated meaning of
     poll_enabled_time.
v3: sumits: addressed review comments from v2; moved to use core
     regulator features like enable_time, off_on_delay, and the newly
     added poll_enabled_time. Moved the check_enabled functionality
     to core framework via poll_enabled_time.
v2: sumits: reworked the driver for more common code, and addressed
     review comments from v1
---
 drivers/regulator/Kconfig                 |  10 ++
 drivers/regulator/Makefile                |   1 +
 drivers/regulator/qcom-labibb-regulator.c | 175 ++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/regulator/qcom-labibb-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 8f677f5d79b4..c6377df023bc 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1178,5 +1178,15 @@ config REGULATOR_WM8994
 	  This driver provides support for the voltage regulators on the
 	  WM8994 CODEC.
 
+config REGULATOR_QCOM_LABIBB
+	tristate "QCOM LAB/IBB regulator support"
+	depends on SPMI || COMPILE_TEST
+	help
+	  This driver supports Qualcomm's LAB/IBB regulators present on the
+	  Qualcomm's PMIC chip pmi8998. QCOM LAB and IBB are SPMI
+	  based PMIC implementations. LAB can be used as positive
+	  boost regulator and IBB can be used as a negative boost regulator
+	  for LCD display panel.
+
 endif
 
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index e8f163371071..2c2b0861df76 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
+obj-$(CONFIG_REGULATOR_QCOM_LABIBB) += qcom-labibb-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_RPM) += qcom_rpm-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_SMD_RPM) += qcom_smd-regulator.o
diff --git a/drivers/regulator/qcom-labibb-regulator.c b/drivers/regulator/qcom-labibb-regulator.c
new file mode 100644
index 000000000000..8c7dd1928380
--- /dev/null
+++ b/drivers/regulator/qcom-labibb-regulator.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2020, The Linux Foundation. All rights reserved.
+
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define REG_PERPH_TYPE                  0x04
+
+#define QCOM_LAB_TYPE			0x24
+#define QCOM_IBB_TYPE			0x20
+
+#define PMI8998_LAB_REG_BASE		0xde00
+#define PMI8998_IBB_REG_BASE		0xdc00
+
+#define REG_LABIBB_STATUS1		0x08
+#define REG_LABIBB_ENABLE_CTL		0x46
+#define LABIBB_STATUS1_VREG_OK_BIT	BIT(7)
+#define LABIBB_CONTROL_ENABLE		BIT(7)
+
+#define LAB_ENABLE_CTL_MASK		BIT(7)
+#define IBB_ENABLE_CTL_MASK		(BIT(7) | BIT(6))
+
+#define LABIBB_OFF_ON_DELAY		1000
+#define LAB_ENABLE_TIME			(LABIBB_OFF_ON_DELAY * 2)
+#define IBB_ENABLE_TIME			(LABIBB_OFF_ON_DELAY * 10)
+#define LABIBB_POLL_ENABLED_TIME	1000
+
+struct labibb_regulator {
+	struct regulator_desc		desc;
+	struct device			*dev;
+	struct regmap			*regmap;
+	struct regulator_dev		*rdev;
+	u16				base;
+	u8				type;
+};
+
+struct labibb_regulator_data {
+	const char			*name;
+	u8				type;
+	u16				base;
+	struct regulator_desc		*desc;
+};
+
+static struct regulator_ops qcom_labibb_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+};
+
+static struct regulator_desc pmi8998_lab_desc = {
+	.enable_mask		= LAB_ENABLE_CTL_MASK,
+	.enable_reg		= (PMI8998_LAB_REG_BASE + REG_LABIBB_ENABLE_CTL),
+	.enable_val		= LABIBB_CONTROL_ENABLE,
+	.enable_time		= LAB_ENABLE_TIME,
+	.poll_enabled_time	= LABIBB_POLL_ENABLED_TIME,
+	.off_on_delay		= LABIBB_OFF_ON_DELAY,
+	.owner			= THIS_MODULE,
+	.type			= REGULATOR_VOLTAGE,
+	.ops			= &qcom_labibb_ops,
+};
+
+static struct regulator_desc pmi8998_ibb_desc = {
+	.enable_mask		= IBB_ENABLE_CTL_MASK,
+	.enable_reg		= (PMI8998_IBB_REG_BASE + REG_LABIBB_ENABLE_CTL),
+	.enable_val		= LABIBB_CONTROL_ENABLE,
+	.enable_time		= IBB_ENABLE_TIME,
+	.poll_enabled_time	= LABIBB_POLL_ENABLED_TIME,
+	.off_on_delay		= LABIBB_OFF_ON_DELAY,
+	.owner			= THIS_MODULE,
+	.type			= REGULATOR_VOLTAGE,
+	.ops			= &qcom_labibb_ops,
+};
+
+static const struct labibb_regulator_data pmi8998_labibb_data[] = {
+	{"lab", QCOM_LAB_TYPE, PMI8998_LAB_REG_BASE, &pmi8998_lab_desc},
+	{"ibb", QCOM_IBB_TYPE, PMI8998_IBB_REG_BASE, &pmi8998_ibb_desc},
+	{ },
+};
+
+static const struct of_device_id qcom_labibb_match[] = {
+	{ .compatible = "qcom,pmi8998-lab-ibb", .data = &pmi8998_labibb_data},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcom_labibb_match);
+
+static int qcom_labibb_regulator_probe(struct platform_device *pdev)
+{
+	struct labibb_regulator *vreg;
+	struct device *dev = &pdev->dev;
+	struct regulator_config cfg = {};
+
+	const struct of_device_id *match;
+	const struct labibb_regulator_data *reg_data;
+	struct regmap *reg_regmap;
+	unsigned int type;
+	int ret;
+
+	reg_regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!reg_regmap) {
+		dev_err(&pdev->dev, "Couldn't get parent's regmap\n");
+		return -ENODEV;
+	}
+
+	match = of_match_device(qcom_labibb_match, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
+	for (reg_data = match->data; reg_data->name; reg_data++) {
+
+		/* Validate if the type of regulator is indeed
+		 * what's mentioned in DT.
+		 */
+		ret = regmap_read(reg_regmap, reg_data->base + REG_PERPH_TYPE,
+				  &type);
+		if (ret < 0) {
+			dev_err(dev,
+				"Peripheral type read failed ret=%d\n",
+				ret);
+			return -EINVAL;
+		}
+
+		if (WARN_ON((type != QCOM_LAB_TYPE) && (type != QCOM_IBB_TYPE)) ||
+		    WARN_ON(type != reg_data->type))
+			return -EINVAL;
+
+		vreg  = devm_kzalloc(&pdev->dev, sizeof(*vreg),
+					   GFP_KERNEL);
+		if (!vreg)
+			return -ENOMEM;
+
+		vreg->regmap = reg_regmap;
+		vreg->dev = dev;
+		vreg->base = reg_data->base;
+		vreg->type = reg_data->type;
+
+		memcpy(&vreg->desc, reg_data->desc, sizeof(vreg->desc));
+		vreg->desc.of_match = reg_data->name;
+		vreg->desc.name = reg_data->name;
+
+		cfg.dev = vreg->dev;
+		cfg.driver_data = vreg;
+		cfg.regmap = vreg->regmap;
+
+		vreg->rdev = devm_regulator_register(vreg->dev, &vreg->desc,
+							&cfg);
+
+		if (IS_ERR(vreg->rdev)) {
+			dev_err(dev, "qcom_labibb: error registering %s : %d\n",
+					reg_data->name, ret);
+			return PTR_ERR(vreg->rdev);
+		}
+	}
+
+	return 0;
+}
+
+static struct platform_driver qcom_labibb_regulator_driver = {
+	.driver	= {
+		.name = "qcom-lab-ibb-regulator",
+		.of_match_table	= qcom_labibb_match,
+	},
+	.probe = qcom_labibb_regulator_probe,
+};
+module_platform_driver(qcom_labibb_regulator_driver);
+
+MODULE_DESCRIPTION("Qualcomm labibb driver");
+MODULE_AUTHOR("Nisha Kumari <nishakumari@codeaurora.org>");
+MODULE_AUTHOR("Sumit Semwal <sumit.semwal@linaro.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

