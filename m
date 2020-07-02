Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E251BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC6A20702
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="E9ZTQZ9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgGBJR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:17:26 -0400
Received: from mail-dm6nam11on2045.outbound.protection.outlook.com ([40.107.223.45]:7591
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbgGBJRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:17:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk8b3Z6ehWnbclb7kPFwNhEQ6B/BQlbhCC2MMFx/b6hOxjp/qOvBO5xDiivCRuKjURDurJ7Sys6L9AuTpV/9yR2pBj4SNq/XObYBSWQEozRKXsU7uxz1oKXGTV/Lv5D2fm7XTlOQ8s/dmnpAf5Kps+kaPXDeHEuBI5jjiN+BsYQtz+01nBwt0uX5gN1xmeN1gVdq/dbiZENKymtyq54qqN99op7mYjK6GOxY5ppGs2DX6Td2O+1SyGFEoroMhN6SVPWsVDGo3XurX6orNgIEzPFp18HkIF/RfoV2OtJlqtL8GfUyqFNlggSOsnR2o0CrUws3/WNHKT+pjuSN3sG72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx8h2Nk5YQQLzlzqO5wRVd8Ad7bSQ0ahd7vDnR2az58=;
 b=Mv2F7aJqXDy4+Ur+dYrzYInggvFsyWVjGuPDp+tsMLwTQgBe/jAb3ajGHciy3DCy3ZXTPvkb47YOr3W9vsY8B3Sw+C+ySVyXkFzWMAoM3c1fAksJQfjS/BSykYlQVuNcRJcOvQvre2qq0nqWPVs6oLRSKOM+OUMA2hTD8Xzt5NLhsKoOpIe62RbKUW/u1FwKje1aUERyBjnOR7DOdrdDkoDH2wte66HKIEhda4RgVe/6IiCb4bHBQ63LXxwYCwB9+NDAWFMHCRz+SyXKY8Cg+lqVDLG165NreSzOZ53vhG4IIclXM8E+EtEbm327fWPJr/fggqZMLiMWdQOFsT2X/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx8h2Nk5YQQLzlzqO5wRVd8Ad7bSQ0ahd7vDnR2az58=;
 b=E9ZTQZ9iVtUMDH053PC0euV+18NHNZdKeJZLk8Hr2XRiSDcvrqWic/bj0jhBgmxXSvTv2wmqxfCfx5fk1Vvv1GExUsINCh3OreMB4SpThqfr6CNly37TXqoaOZxhxIYp7sfP+uewnhQRVMfkBrfHSK4GNuAFSXsiNrMzSPgiWA4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB3574.namprd03.prod.outlook.com (2603:10b6:a02:aa::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Thu, 2 Jul
 2020 09:17:21 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998%7]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 09:17:21 +0000
Date:   Thu, 2 Jul 2020 17:14:38 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] regulator: add support for SY8827N regulator
Message-ID: <20200702171438.20edc523@xhacker.debian>
In-Reply-To: <20200702171304.68928e88@xhacker.debian>
References: <20200702171304.68928e88@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR04CA0020.apcprd04.prod.outlook.com
 (2603:1096:404:f6::32) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR04CA0020.apcprd04.prod.outlook.com (2603:1096:404:f6::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Thu, 2 Jul 2020 09:17:19 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7edb78a-7076-46a1-9e19-08d81e68b9b7
X-MS-TrafficTypeDiagnostic: BYAPR03MB3574:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3574B208CD096FFF90557713ED6D0@BYAPR03MB3574.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9Z/BbC9h3Bn/+1XgkuLPB7d13f0w8k6E/WVu+H9g7of/Vw6yYDg34LqCeFaS3rjWszrZ3MUSLNce35E6XueMFKW/yrsdlAvEEl62VzRrhjSLW4pJet5wS21DU4lcg3qp8RIjbP2De4lePdVDYglmrCnR9RVV3Qq82/cwa0QIRddhTU+vTBaPSdedMzVq/quneZ4HbtAObhIqFnu6CAWjjp7hfUEHzG6kv6uoIYV2/bATrsXQGHvFG1ZlY/rP6oqM+0r1JHemBf+4N3SIDjPJfiWaRG5JlDiWJfODWhRWk4YX0Ic4XkyZ4cHLtno+82Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(396003)(39850400004)(346002)(136003)(956004)(478600001)(2906002)(66476007)(66556008)(66946007)(83380400001)(8676002)(8936002)(9686003)(4326008)(55016002)(16526019)(26005)(186003)(316002)(110136005)(86362001)(7696005)(1076003)(52116002)(6666004)(6506007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4wdpUwsk+ztF7ntow/yg2ElcRON7XW1fYPAdJYWbuI08wqjNEFHnSg9IGB36fr0g1bBUN+JQnUsD+CmtmoJkz6dUX/BLtNTJup+tg2bUvbBoJaCIdwDCxxTOyOpDDaeADp3a/UkbKTrC8smcDDMdEH+tkE0SSHP4J6DhWqKvX1prw44KpaPN4I5Cuh/Ggf1oUuf0UmnQqy1/tw0GhqSbFDdfZHU53qatdraWpExKsxgjBPOftbXLcwCgw8bISJj1aTlSH27+J/fH+Trxyip0GxYxCGjLDVzgStd/+Yw902sF1HoC0GweNtCM4tYUGSyqr9sNIq4G5I9BHD4MKyDz+bd1O7KXZ0NCZfuQiMrQulmOKvnrpIoQMBGCj/IIHJy5GW7KTd4Yv3RUhFx3xyXHQFRs9yIakwg9DSgAQuYHFH6RFWYITljUVHgBF9+1x9RxMxM5WuBIQ+he6kk50iwVxKO/ThcfqMMyOV4ON4cZv+rcewWE3etK2stdVQ3r4T0l
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7edb78a-7076-46a1-9e19-08d81e68b9b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3573.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:17:21.6254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGANa7PTuzP4sszL34L8wlz7V1gerQpQuvkAJe87JHOrLW2ajoLQ1zL/B9kAeQwnqEP1E5+rYUnIgPpEJbEFVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SY8827N from Silergy Corp is a single output DC/DC converter. The
voltage can be controlled via I2C.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/Kconfig   |   7 ++
 drivers/regulator/Makefile  |   1 +
 drivers/regulator/sy8827n.c | 185 ++++++++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/regulator/sy8827n.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index edb1c4f8b496..0167dd46c7e4 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -989,6 +989,13 @@ config REGULATOR_SY8824X
 	help
 	  This driver supports SY8824C single output regulator.
 
+config REGULATOR_SY8827N
+	tristate "Silergy SY8827N regulator"
+	depends on I2C && (OF || COMPILE_TEST)
+	select REGMAP_I2C
+	help
+	  This driver supports SY8827N single output regulator.
+
 config REGULATOR_TPS51632
 	tristate "TI TPS51632 Power Regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index e8f163371071..0c32c5001561 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -120,6 +120,7 @@ obj-$(CONFIG_REGULATOR_STPMIC1) += stpmic1_regulator.o
 obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
 obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
 obj-$(CONFIG_REGULATOR_SY8824X) += sy8824x.o
+obj-$(CONFIG_REGULATOR_SY8827N) += sy8827n.o
 obj-$(CONFIG_REGULATOR_TI_ABB) += ti-abb-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6105X) += tps6105x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS62360) += tps62360-regulator.o
diff --git a/drivers/regulator/sy8827n.c b/drivers/regulator/sy8827n.c
new file mode 100644
index 000000000000..b207217f74d8
--- /dev/null
+++ b/drivers/regulator/sy8827n.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// SY8827N regulator driver
+//
+// Copyright (C) 2020 Synaptics Incorporated
+//
+// Author: Jisheng Zhang <jszhang@kernel.org>
+
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define SY8827N_VSEL0		0
+#define   SY8827N_BUCK_EN	(1 << 7)
+#define   SY8827N_MODE		(1 << 6)
+#define SY8827N_VSEL1		1
+#define SY8827N_CTRL		2
+
+#define SY8827N_NVOLTAGES	64
+#define SY8827N_VSELMIN		600000
+#define SY8827N_VSELSTEP	12500
+
+struct sy8827n_device_info {
+	struct device *dev;
+	struct regulator_desc desc;
+	struct regulator_init_data *regulator;
+	struct gpio_desc *en_gpio;
+	unsigned int vsel_reg;
+};
+
+static int sy8827n_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct sy8827n_device_info *di = rdev_get_drvdata(rdev);
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		regmap_update_bits(rdev->regmap, di->vsel_reg,
+				   SY8827N_MODE, SY8827N_MODE);
+		break;
+	case REGULATOR_MODE_NORMAL:
+		regmap_update_bits(rdev->regmap, di->vsel_reg,
+				   SY8827N_MODE, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static unsigned int sy8827n_get_mode(struct regulator_dev *rdev)
+{
+	struct sy8827n_device_info *di = rdev_get_drvdata(rdev);
+	u32 val;
+	int ret = 0;
+
+	ret = regmap_read(rdev->regmap, di->vsel_reg, &val);
+	if (ret < 0)
+		return ret;
+	if (val & SY8827N_MODE)
+		return REGULATOR_MODE_FAST;
+	else
+		return REGULATOR_MODE_NORMAL;
+}
+
+static const struct regulator_ops sy8827n_regulator_ops = {
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.map_voltage = regulator_map_voltage_linear,
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = sy8827n_set_mode,
+	.get_mode = sy8827n_get_mode,
+};
+
+static int sy8827n_regulator_register(struct sy8827n_device_info *di,
+			struct regulator_config *config)
+{
+	struct regulator_desc *rdesc = &di->desc;
+	struct regulator_dev *rdev;
+
+	rdesc->name = "sy8827n-reg";
+	rdesc->supply_name = "vin";
+	rdesc->ops = &sy8827n_regulator_ops;
+	rdesc->type = REGULATOR_VOLTAGE;
+	rdesc->n_voltages = SY8827N_NVOLTAGES;
+	rdesc->enable_reg = di->vsel_reg;
+	rdesc->enable_mask = SY8827N_BUCK_EN;
+	rdesc->min_uV = SY8827N_VSELMIN;
+	rdesc->uV_step = SY8827N_VSELSTEP;
+	rdesc->vsel_reg = di->vsel_reg;
+	rdesc->vsel_mask = rdesc->n_voltages - 1;
+	rdesc->owner = THIS_MODULE;
+
+	rdev = devm_regulator_register(di->dev, &di->desc, config);
+	return PTR_ERR_OR_ZERO(rdev);
+}
+
+static const struct regmap_config sy8827n_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int sy8827n_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct device_node *np = dev->of_node;
+	struct sy8827n_device_info *di;
+	struct regulator_config config = { };
+	struct regmap *regmap;
+	int ret;
+
+	di = devm_kzalloc(dev, sizeof(struct sy8827n_device_info), GFP_KERNEL);
+	if (!di)
+		return -ENOMEM;
+
+	di->regulator = of_get_regulator_init_data(dev, np, &di->desc);
+	if (!di->regulator) {
+		dev_err(dev, "Platform data not found!\n");
+		return -EINVAL;
+	}
+
+	di->en_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(di->en_gpio))
+		return PTR_ERR(di->en_gpio);
+
+	if (of_property_read_bool(np, "silergy,vsel-state-high"))
+		di->vsel_reg = SY8827N_VSEL1;
+	else
+		di->vsel_reg = SY8827N_VSEL0;
+
+	di->dev = dev;
+
+	regmap = devm_regmap_init_i2c(client, &sy8827n_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to allocate regmap!\n");
+		return PTR_ERR(regmap);
+	}
+	i2c_set_clientdata(client, di);
+
+	config.dev = di->dev;
+	config.init_data = di->regulator;
+	config.regmap = regmap;
+	config.driver_data = di;
+	config.of_node = np;
+
+	ret = sy8827n_regulator_register(di, &config);
+	if (ret < 0)
+		dev_err(dev, "Failed to register regulator!\n");
+	return ret;
+}
+
+static const struct of_device_id sy8827n_dt_ids[] = {
+	{
+		.compatible = "silergy,sy8827n",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sy8827n_dt_ids);
+
+static const struct i2c_device_id sy8827n_id[] = {
+	{ "sy8827n", },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, sy8827n_id);
+
+static struct i2c_driver sy8827n_regulator_driver = {
+	.driver = {
+		.name = "sy8827n-regulator",
+		.of_match_table = of_match_ptr(sy8827n_dt_ids),
+	},
+	.probe_new = sy8827n_i2c_probe,
+	.id_table = sy8827n_id,
+};
+module_i2c_driver(sy8827n_regulator_driver);
+
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_DESCRIPTION("SY8827N regulator driver");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

