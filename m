Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D23C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBAA0207DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C0Og8Erj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgGCIKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:10:01 -0400
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:47808
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbgGCIKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:10:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcT0spsiwEWxpVlPozIJxZzjuYLMPSmPQi4deyWMJai5S1TCWX3ztbAqkgyhKhd1ny/nOFh9uyuVa3l2IiPh7K3PKHg19HorllK70277Agh8bdNvrUVcsuFt1dEYH7ZTOR/bpntM1zBgoz+zHlps4VjMpTyWwEK7W6QkUX06bIw5XDtZOn+jyillr98/Gqm1OCqPa73LbK3xep0Y+30iFQBSJYtBDFcx3g4aOEDL9CnVSFZaiwc53wJWNMBbgLaDujpFDBiV09l5UrkfoY3qf8czPubDtcbCEOxylQehEfuZTNdVEZmiAk9UVHFbgwXsSbezVZFA05q+6uOXnepl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwHmtP3X4Se2Ag6+bF09jiIa++9mgNd5O3qCdkwkMKY=;
 b=FDbykYgHo7TsnlJHTUPzbPgL4fP7zlLlg0nZEYsZznw/jDnbe2GvsFtv8sYFHcQBagk07y+Z6k36klo84eSaIyrydh03V4NaoTq4EAta17SM/76J4DacvcePYg7JgfumQ/VnEABqLGkCmTYALBbmMm6kpZ+8iNLRJzf5dQn1j/kGlifHD53T9nKtZv56/lsuUC1qxIgYPi5FCBwINZXvexKUSn2ik3l520vXPC/Qq/lnuevkERTbX9vpK0mk18XvVKMJFKQrNlJRg1BfUu8exeQ7tTEP7gDfNz7xWuJIKLPF2Lj57p1Zu9Jfj6pdn9IcufD/kCHIE+h0gnRWXmwQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwHmtP3X4Se2Ag6+bF09jiIa++9mgNd5O3qCdkwkMKY=;
 b=C0Og8ErjDxcMMfjPBG4P0ZqCHKehlkRfseRZBrOvKU7dvqlniJddqClt1VbsoElv27ZqjtebwVzn4tkQjrqFxTaYDYj/aKZAudguXfpt3qoou1RujHivFqs9qYfoI0PMEPT9umKYexF230ktEdOYCTCDJ8ei3iAKXuMP9jZBxwY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0401MB2302.eurprd04.prod.outlook.com (2603:10a6:800:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Fri, 3 Jul
 2020 08:05:14 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 08:05:14 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        frieder.schrempf@kontron.de, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, anson.huang@nxp.com,
        festevam@gmail.com, s.hauer@pengutronix.de, john.lee@nxp.com
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v2 1/4] regulator: pca9450: add pca9450 pmic driver
Date:   Sat,  4 Jul 2020 00:19:35 +0800
Message-Id: <1593793178-9737-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
References: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0160.apcprd01.prod.exchangelabs.com (2603:1096:4:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.21 via Frontend Transport; Fri, 3 Jul 2020 08:05:08 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11eeb40c-f6af-482f-5d20-08d81f27d0d9
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB230282473257BEB7AD12C324896A0@VI1PR0401MB2302.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:132;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BbXgNcjlChaN0lkfCEa/PVBQOhF4kGNLmUIhcMmZkeSmq7zBTFQwDHHB73mSlCSG7Z7h6HsadrX0BlxmcddcDD0T8Kun6N1wIsp8kJnFzZWT7BMN1YqiZqtCnKc2cWhg1YZrRak/8eC1gfrQ7GU8JH9XEnP6OqXOJ+lCtPusJCKGK4sFMg2GQo5VCmB2awjkvgvP2pvauiqYxtxbACfKymIhiGRPMwntsQUezh05uSVjU6nWwA/jm2UyCaVZ8VzgBAbDwRtZH8zcJIiFGHiXKC8BGftXE0XD3KqoHb5mlmI2IfVCXfTzowxVF7shl89kaCziIx0ilhKvtXTeLZwJLGvYWUbURi0m7cyjj9Ixq7kRhgAv8P1Fin5M3XWxuhRj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(7416002)(6512007)(8676002)(6636002)(6666004)(8936002)(86362001)(52116002)(478600001)(5660300002)(16526019)(30864003)(316002)(6506007)(2906002)(4326008)(2616005)(83380400001)(66556008)(26005)(186003)(66946007)(36756003)(956004)(6486002)(66476007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MkNXibJ5PbPe4ZDG8A2HJtDjDjF/qvXfK3kXj0mrFP6RD94292uDMD/DJ7Umqm7WHptkWPQsJIZP/YEiOz+udvPwyojqZaMBtA+EoRz/NMrL92rWyvZhJXe/YBmEiTaNoc/Des95nwiKlsIQTIXuqHn/rLqwp7gNwVB9ag2SllINdx4q0a1LDxHC+yLaAuuu1ntADjPs/e0/V10OILVgkXFroIOshjmvhlOPtNBhQap+KBsWMdX9sVRWEVj6+5GEAPCHdmsOH+LbxVFS8rxdqPaDvVx67YRgQ9Q9hiY73bCjUy2ofSWmOvJgG9EpYBXbQkYcAd4A0i2GT0wwo6GRrha6ZhXHmX4b6eFOkXziRzXTjbEU1Hqj1LgkoCGZjFnfOFQgLgI3P3P8nILp85+JxD2x71Y0BlpZ0HFoid7SwGUULo68gqmqeNMEFvka6ITruU8F7r8JB/Is4OAx52anVk4pLBfPTTz+LuO9SmmfRqA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11eeb40c-f6af-482f-5d20-08d81f27d0d9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:05:14.6533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xPcBeWjZGcajZNk/tRsc7A5wYRogL7GQc3dWZC7AYjROgMMhAukjXXbpP9TEUKOLUftPe/6oMbXNK81JN6Pmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NXP pca9450 pmic driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/regulator/Kconfig             |   8 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/pca9450-regulator.c | 843 ++++++++++++++++++++++++++++++++++
 include/linux/regulator/pca9450.h     | 219 +++++++++
 4 files changed, 1071 insertions(+)
 create mode 100644 drivers/regulator/pca9450-regulator.c
 create mode 100644 include/linux/regulator/pca9450.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index f60eeaa..f992a17 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -740,6 +740,14 @@ config REGULATOR_PBIAS
 	 This driver provides support for OMAP pbias modelled
 	 regulators.
 
+config REGULATOR_PCA9450
+	tristate "NXP PCA9450A/PCA9450B/PCA9450C regulator driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say y here to support the NXP PCA9450A/PCA9450B/PCA9450C PMIC
+	  regulator driver.
+
 config REGULATOR_PCAP
 	tristate "Motorola PCAP2 regulator driver"
 	depends on EZX_PCAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5ce7350..ff524922 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_SMD_RPM) += qcom_smd-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
+obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
 obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
 obj-$(CONFIG_REGULATOR_PV88080) += pv88080-regulator.o
diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
new file mode 100644
index 00000000..0225045
--- /dev/null
+++ b/drivers/regulator/pca9450-regulator.c
@@ -0,0 +1,843 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020 NXP.
+ * NXP PCA9450 pmic driver
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/regulator/pca9450.h>
+
+struct pc9450_dvs_config {
+	unsigned int run_reg; /* dvs0 */
+	unsigned int run_mask;
+	unsigned int standby_reg; /* dvs1 */
+	unsigned int standby_mask;
+};
+
+struct pca9450_regulator_desc {
+	struct regulator_desc desc;
+	const struct pc9450_dvs_config dvs;
+};
+
+struct pca9450 {
+	struct device *dev;
+	struct regmap *regmap;
+	enum pca9450_chip_type type;
+	unsigned int rcnt;
+	int irq;
+};
+
+static const struct regmap_range pca9450_status_range = {
+	.range_min = PCA9450_REG_INT1,
+	.range_max = PCA9450_REG_PWRON_STAT,
+};
+
+static const struct regmap_access_table pca9450_volatile_regs = {
+	.yes_ranges = &pca9450_status_range,
+	.n_yes_ranges = 1,
+};
+
+static const struct regmap_config pca9450_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_table = &pca9450_volatile_regs,
+	.max_register = PCA9450_MAX_REGISTER - 1,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+/*
+ * BUCK1/2/3
+ * BUCK1RAM[1:0] BUCK1 DVS ramp rate setting
+ * 00: 25mV/1usec
+ * 01: 25mV/2usec
+ * 10: 25mV/4usec
+ * 11: 25mV/8usec
+ */
+static int pca9450_dvs_set_ramp_delay(struct regulator_dev *rdev,
+				      int ramp_delay)
+{
+	int id = rdev_get_id(rdev);
+	unsigned int ramp_value;
+
+	switch (ramp_delay) {
+	case 1 ... 3125:
+		ramp_value = BUCK1_RAMP_3P125MV;
+		break;
+	case 3126 ... 6250:
+		ramp_value = BUCK1_RAMP_6P25MV;
+		break;
+	case 6251 ... 12500:
+		ramp_value = BUCK1_RAMP_12P5MV;
+		break;
+	case 12501 ... 25000:
+		ramp_value = BUCK1_RAMP_25MV;
+		break;
+	default:
+		ramp_value = BUCK1_RAMP_25MV;
+	}
+
+	return regmap_update_bits(rdev->regmap, PCA9450_REG_BUCK1CTRL + id * 3,
+				  BUCK1_RAMP_MASK, ramp_value << 6);
+}
+
+static struct regulator_ops pca9450_dvs_buck_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay = pca9450_dvs_set_ramp_delay,
+};
+
+static struct regulator_ops pca9450_buck_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+};
+
+static struct regulator_ops pca9450_ldo_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+/*
+ * BUCK1/2/3
+ * 0.60 to 2.1875V (12.5mV step)
+ */
+static const struct linear_range pca9450_dvs_buck_volts[] = {
+	REGULATOR_LINEAR_RANGE(600000,  0x00, 0x7F, 12500),
+};
+
+/*
+ * BUCK4/5/6
+ * 0.6V to 3.4V (25mV step)
+ */
+static const struct linear_range pca9450_buck_volts[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x70, 25000),
+	REGULATOR_LINEAR_RANGE(3400000, 0x71, 0x7F, 0),
+};
+
+/*
+ * LDO1
+ * 1.6 to 3.3V ()
+ */
+static const struct linear_range pca9450_ldo1_volts[] = {
+	REGULATOR_LINEAR_RANGE(1600000, 0x00, 0x03, 100000),
+	REGULATOR_LINEAR_RANGE(3000000, 0x04, 0x07, 100000),
+};
+
+/*
+ * LDO2
+ * 0.8 to 1.15V (50mV step)
+ */
+static const struct linear_range pca9450_ldo2_volts[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x07, 50000),
+};
+
+/*
+ * LDO3/4
+ * 0.8 to 3.3V (100mV step)
+ */
+static const struct linear_range pca9450_ldo34_volts[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x19, 100000),
+	REGULATOR_LINEAR_RANGE(3300000, 0x1A, 0x1F, 0),
+};
+
+/*
+ * LDO5
+ * 1.8 to 3.3V (100mV step)
+ */
+static const struct linear_range pca9450_ldo5_volts[] = {
+	REGULATOR_LINEAR_RANGE(1800000,  0x00, 0x0F, 100000),
+};
+
+static int buck_set_dvs(const struct regulator_desc *desc,
+			struct device_node *np, struct regmap *regmap,
+			char *prop, unsigned int reg, unsigned int mask)
+{
+	int ret, i;
+	uint32_t uv;
+
+	ret = of_property_read_u32(np, prop, &uv);
+	if (ret == -EINVAL)
+		return 0;
+	else if (ret)
+		return ret;
+
+	for (i = 0; i < desc->n_voltages; i++) {
+		ret = regulator_desc_list_voltage_linear_range(desc, i);
+		if (ret < 0)
+			continue;
+		if (ret == uv) {
+			i <<= ffs(desc->vsel_mask) - 1;
+			ret = regmap_update_bits(regmap, reg, mask, i);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int pca9450_set_dvs_levels(struct device_node *np,
+			    const struct regulator_desc *desc,
+			    struct regulator_config *cfg)
+{
+	struct pca9450_regulator_desc *data = container_of(desc,
+					struct pca9450_regulator_desc, desc);
+	const struct pc9450_dvs_config *dvs = &data->dvs;
+	unsigned int reg, mask;
+	char *prop;
+	int i, ret = 0;
+
+	for (i = 0; i < PCA9450_DVS_LEVEL_MAX; i++) {
+		switch (i) {
+		case PCA9450_DVS_LEVEL_RUN:
+			prop = "nxp,dvs-run-voltage";
+			reg = dvs->run_reg;
+			mask = dvs->run_mask;
+			break;
+		case PCA9450_DVS_LEVEL_STANDBY:
+			prop = "nxp,dvs-standby-voltage";
+			reg = dvs->standby_reg;
+			mask = dvs->standby_mask;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		ret = buck_set_dvs(desc, np, cfg->regmap, prop, reg, mask);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static const struct pca9450_regulator_desc pca9450a_regulators[] = {
+	{
+		.desc = {
+			.name = "buck1",
+			.of_match = of_match_ptr("BUCK1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK1,
+			.ops = &pca9450_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK1_VOLTAGE_NUM,
+			.linear_ranges = pca9450_dvs_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK1OUT_DVS0,
+			.vsel_mask = BUCK1OUT_DVS0_MASK,
+			.enable_reg = PCA9450_REG_BUCK1CTRL,
+			.enable_mask = BUCK1_ENMODE_MASK,
+			.owner = THIS_MODULE,
+			.of_parse_cb = pca9450_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PCA9450_REG_BUCK1OUT_DVS0,
+			.run_mask = BUCK1OUT_DVS0_MASK,
+			.standby_reg = PCA9450_REG_BUCK1OUT_DVS1,
+			.standby_mask = BUCK1OUT_DVS1_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck2",
+			.of_match = of_match_ptr("BUCK2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK2,
+			.ops = &pca9450_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK2_VOLTAGE_NUM,
+			.linear_ranges = pca9450_dvs_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
+			.vsel_mask = BUCK2OUT_DVS0_MASK,
+			.enable_reg = PCA9450_REG_BUCK2CTRL,
+			.enable_mask = BUCK1_ENMODE_MASK,
+			.owner = THIS_MODULE,
+			.of_parse_cb = pca9450_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PCA9450_REG_BUCK2OUT_DVS0,
+			.run_mask = BUCK2OUT_DVS0_MASK,
+			.standby_reg = PCA9450_REG_BUCK2OUT_DVS1,
+			.standby_mask = BUCK2OUT_DVS1_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck3",
+			.of_match = of_match_ptr("BUCK3"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK3,
+			.ops = &pca9450_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK3_VOLTAGE_NUM,
+			.linear_ranges = pca9450_dvs_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK3OUT_DVS0,
+			.vsel_mask = BUCK3OUT_DVS0_MASK,
+			.enable_reg = PCA9450_REG_BUCK3CTRL,
+			.enable_mask = BUCK3_ENMODE_MASK,
+			.owner = THIS_MODULE,
+			.of_parse_cb = pca9450_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PCA9450_REG_BUCK3OUT_DVS0,
+			.run_mask = BUCK3OUT_DVS0_MASK,
+			.standby_reg = PCA9450_REG_BUCK3OUT_DVS1,
+			.standby_mask = BUCK3OUT_DVS1_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck4",
+			.of_match = of_match_ptr("BUCK4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK4,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK4_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK4OUT,
+			.vsel_mask = BUCK4OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK4CTRL,
+			.enable_mask = BUCK4_ENMODE_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck5",
+			.of_match = of_match_ptr("BUCK5"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK5,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK5_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK5OUT,
+			.vsel_mask = BUCK5OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK5CTRL,
+			.enable_mask = BUCK5_ENMODE_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck6",
+			.of_match = of_match_ptr("BUCK6"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK6,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK6_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK6OUT,
+			.vsel_mask = BUCK6OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK6CTRL,
+			.enable_mask = BUCK6_ENMODE_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo1",
+			.of_match = of_match_ptr("LDO1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO1,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO1_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo1_volts),
+			.vsel_reg = PCA9450_REG_LDO1CTRL,
+			.vsel_mask = LDO1OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO1CTRL,
+			.enable_mask = LDO1_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo2",
+			.of_match = of_match_ptr("LDO2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO2,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO2_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo2_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo2_volts),
+			.vsel_reg = PCA9450_REG_LDO2CTRL,
+			.vsel_mask = LDO2OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO2CTRL,
+			.enable_mask = LDO2_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo3",
+			.of_match = of_match_ptr("LDO3"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO3,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO3_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo34_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo34_volts),
+			.vsel_reg = PCA9450_REG_LDO3CTRL,
+			.vsel_mask = LDO3OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO3CTRL,
+			.enable_mask = LDO3_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo4",
+			.of_match = of_match_ptr("LDO4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO4,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO4_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo34_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo34_volts),
+			.vsel_reg = PCA9450_REG_LDO4CTRL,
+			.vsel_mask = LDO4OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO4CTRL,
+			.enable_mask = LDO4_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo5",
+			.of_match = of_match_ptr("LDO5"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO5,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO5_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo5_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
+			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
+			.vsel_mask = LDO5HOUT_MASK,
+			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_mask = LDO5H_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+};
+
+/*
+ * Buck3 removed on PCA9450B and connected with Buck1 internal for dual phase
+ * on PCA9450C as no Buck3.
+ */
+static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
+	{
+		.desc = {
+			.name = "buck1",
+			.of_match = of_match_ptr("BUCK1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK1,
+			.ops = &pca9450_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK1_VOLTAGE_NUM,
+			.linear_ranges = pca9450_dvs_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK1OUT_DVS0,
+			.vsel_mask = BUCK1OUT_DVS0_MASK,
+			.enable_reg = PCA9450_REG_BUCK1CTRL,
+			.enable_mask = BUCK1_ENMODE_MASK,
+			.owner = THIS_MODULE,
+			.of_parse_cb = pca9450_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PCA9450_REG_BUCK1OUT_DVS0,
+			.run_mask = BUCK1OUT_DVS0_MASK,
+			.standby_reg = PCA9450_REG_BUCK1OUT_DVS1,
+			.standby_mask = BUCK1OUT_DVS1_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck2",
+			.of_match = of_match_ptr("BUCK2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK2,
+			.ops = &pca9450_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK2_VOLTAGE_NUM,
+			.linear_ranges = pca9450_dvs_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
+			.vsel_mask = BUCK2OUT_DVS0_MASK,
+			.enable_reg = PCA9450_REG_BUCK2CTRL,
+			.enable_mask = BUCK1_ENMODE_MASK,
+			.owner = THIS_MODULE,
+			.of_parse_cb = pca9450_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PCA9450_REG_BUCK2OUT_DVS0,
+			.run_mask = BUCK2OUT_DVS0_MASK,
+			.standby_reg = PCA9450_REG_BUCK2OUT_DVS1,
+			.standby_mask = BUCK2OUT_DVS1_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck4",
+			.of_match = of_match_ptr("BUCK4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK4,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK4_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK4OUT,
+			.vsel_mask = BUCK4OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK4CTRL,
+			.enable_mask = BUCK4_ENMODE_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck5",
+			.of_match = of_match_ptr("BUCK5"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK5,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK5_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK5OUT,
+			.vsel_mask = BUCK5OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK5CTRL,
+			.enable_mask = BUCK5_ENMODE_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck6",
+			.of_match = of_match_ptr("BUCK6"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK6,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK6_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK6OUT,
+			.vsel_mask = BUCK6OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK6CTRL,
+			.enable_mask = BUCK6_ENMODE_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo1",
+			.of_match = of_match_ptr("LDO1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO1,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO1_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo1_volts),
+			.vsel_reg = PCA9450_REG_LDO1CTRL,
+			.vsel_mask = LDO1OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO1CTRL,
+			.enable_mask = LDO1_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo2",
+			.of_match = of_match_ptr("LDO2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO2,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO2_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo2_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo2_volts),
+			.vsel_reg = PCA9450_REG_LDO2CTRL,
+			.vsel_mask = LDO2OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO2CTRL,
+			.enable_mask = LDO2_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo3",
+			.of_match = of_match_ptr("LDO3"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO3,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO3_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo34_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo34_volts),
+			.vsel_reg = PCA9450_REG_LDO3CTRL,
+			.vsel_mask = LDO3OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO3CTRL,
+			.enable_mask = LDO3_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo4",
+			.of_match = of_match_ptr("LDO4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO4,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO4_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo34_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo34_volts),
+			.vsel_reg = PCA9450_REG_LDO4CTRL,
+			.vsel_mask = LDO4OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO4CTRL,
+			.enable_mask = LDO4_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo5",
+			.of_match = of_match_ptr("LDO5"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO5,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO5_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo5_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
+			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
+			.vsel_mask = LDO5HOUT_MASK,
+			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_mask = LDO5H_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+};
+
+static irqreturn_t pca9450_irq_handler(int irq, void *data)
+{
+	struct pca9450 *pca9450 = data;
+	struct regmap *regmap = pca9450->regmap;
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(regmap, PCA9450_REG_INT1, &status);
+	if (ret < 0) {
+		dev_err(pca9450->dev,
+			"Failed to read INT1(%d)\n", ret);
+		return IRQ_NONE;
+	}
+
+	if (status & IRQ_PWRON)
+		dev_warn(pca9450->dev, "PWRON interrupt.\n");
+
+	if (status & IRQ_WDOGB)
+		dev_warn(pca9450->dev, "WDOGB interrupt.\n");
+
+	if (status & IRQ_VR_FLT1)
+		dev_warn(pca9450->dev, "VRFLT1 interrupt.\n");
+
+	if (status & IRQ_VR_FLT2)
+		dev_warn(pca9450->dev, "VRFLT2 interrupt.\n");
+
+	if (status & IRQ_LOWVSYS)
+		dev_warn(pca9450->dev, "LOWVSYS interrupt.\n");
+
+	if (status & IRQ_THERM_105)
+		dev_warn(pca9450->dev, "IRQ_THERM_105 interrupt.\n");
+
+	if (status & IRQ_THERM_125)
+		dev_warn(pca9450->dev, "IRQ_THERM_125 interrupt.\n");
+
+	return IRQ_HANDLED;
+}
+
+static int pca9450_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
+{
+	enum pca9450_chip_type type = (unsigned int)(uintptr_t)
+				      of_device_get_match_data(&i2c->dev);
+	const struct pca9450_regulator_desc	*regulator_desc;
+	struct regulator_config config = { };
+	struct pca9450 *pca9450;
+	unsigned int device_id, i;
+	int ret;
+
+	if (!i2c->irq) {
+		dev_err(&i2c->dev, "No IRQ configured?\n");
+		return -EINVAL;
+	}
+
+	pca9450 = devm_kzalloc(&i2c->dev, sizeof(struct pca9450), GFP_KERNEL);
+	if (!pca9450)
+		return -ENOMEM;
+
+	switch (type) {
+	case PCA9450_TYPE_PCA9450A:
+		regulator_desc = pca9450a_regulators;
+		pca9450->rcnt = ARRAY_SIZE(pca9450a_regulators);
+		break;
+	case PCA9450_TYPE_PCA9450BC:
+		regulator_desc = pca9450bc_regulators;
+		pca9450->rcnt = ARRAY_SIZE(pca9450bc_regulators);
+		break;
+	default:
+		dev_err(&i2c->dev, "Unknown device type");
+		return -EINVAL;
+	}
+
+	pca9450->irq = i2c->irq;
+	pca9450->type = type;
+	pca9450->dev = &i2c->dev;
+
+	dev_set_drvdata(&i2c->dev, pca9450);
+
+	pca9450->regmap = devm_regmap_init_i2c(i2c,
+					       &pca9450_regmap_config);
+	if (IS_ERR(pca9450->regmap)) {
+		dev_err(&i2c->dev, "regmap initialization failed\n");
+		return PTR_ERR(pca9450->regmap);
+	}
+
+	ret = regmap_read(pca9450->regmap, PCA9450_REG_DEV_ID, &device_id);
+	if (ret) {
+		dev_err(&i2c->dev, "Read device id error\n");
+		return ret;
+	}
+
+	/* Check your board and dts for match the right pmic */
+	if (((device_id >> 4) != 0x1 && type == PCA9450_TYPE_PCA9450A) ||
+	    ((device_id >> 4) != 0x3 && type == PCA9450_TYPE_PCA9450BC)) {
+		dev_err(&i2c->dev, "Device id(%x) mismatched\n",
+			device_id >> 4);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < pca9450->rcnt; i++) {
+		const struct regulator_desc *desc;
+		struct regulator_dev *rdev;
+		const struct pca9450_regulator_desc *r;
+
+		r = &regulator_desc[i];
+		desc = &r->desc;
+
+		config.regmap = pca9450->regmap;
+		config.dev = pca9450->dev;
+
+		rdev = devm_regulator_register(pca9450->dev, desc, &config);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
+			dev_err(pca9450->dev,
+				"Failed to register regulator(%s): %d\n",
+				desc->name, ret);
+			return ret;
+		}
+	}
+
+	ret = devm_request_threaded_irq(pca9450->dev, pca9450->irq, NULL,
+					pca9450_irq_handler,
+					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+					"pca9450-irq", pca9450);
+	if (ret != 0) {
+		dev_err(pca9450->dev, "Failed to request IRQ: %d\n",
+			pca9450->irq);
+		return ret;
+	}
+	/* Unmask all interrupt except PWRON/WDOG/RSVD */
+	ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_INT1_MSK,
+				IRQ_VR_FLT1 | IRQ_VR_FLT2 | IRQ_LOWVSYS |
+				IRQ_THERM_105 | IRQ_THERM_125,
+				IRQ_PWRON | IRQ_WDOGB | IRQ_RSVD);
+	if (ret) {
+		dev_err(&i2c->dev, "Unmask irq error\n");
+		return ret;
+	}
+
+	dev_info(&i2c->dev, "%s probed.\n",
+		type == PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
+
+	return 0;
+}
+
+static const struct of_device_id pca9450_of_match[] = {
+	{
+		.compatible = "nxp,pca9450a",
+		.data = (void *)PCA9450_TYPE_PCA9450A,
+	},
+	{
+		.compatible = "nxp,pca9450b",
+		.data = (void *)PCA9450_TYPE_PCA9450BC,
+	},
+	{
+		.compatible = "nxp,pca9450c",
+		.data = (void *)PCA9450_TYPE_PCA9450BC,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pca9450_of_match);
+
+static struct i2c_driver pca9450_i2c_driver = {
+	.driver = {
+		.name = "nxp-pca9450",
+		.of_match_table = pca9450_of_match,
+	},
+	.probe = pca9450_i2c_probe,
+};
+
+static int __init pca9450_i2c_init(void)
+{
+	return i2c_add_driver(&pca9450_i2c_driver);
+}
+module_init(pca9450_i2c_init);
+
+static void __exit pca9450_i2c_exit(void)
+{
+	i2c_del_driver(&pca9450_i2c_driver);
+}
+module_exit(pca9450_i2c_exit);
+
+MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
+MODULE_DESCRIPTION("NXP PCA9450 Power Management IC driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
new file mode 100644
index 00000000..1bbd301
--- /dev/null
+++ b/include/linux/regulator/pca9450.h
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright 2020 NXP. */
+
+#ifndef __LINUX_REG_PCA9450_H__
+#define __LINUX_REG_PCA9450_H__
+
+#include <linux/regmap.h>
+
+enum pca9450_chip_type {
+	PCA9450_TYPE_PCA9450A = 0,
+	PCA9450_TYPE_PCA9450BC,
+	PCA9450_TYPE_AMOUNT,
+};
+
+enum {
+	PCA9450_BUCK1 = 0,
+	PCA9450_BUCK2,
+	PCA9450_BUCK3,
+	PCA9450_BUCK4,
+	PCA9450_BUCK5,
+	PCA9450_BUCK6,
+	PCA9450_LDO1,
+	PCA9450_LDO2,
+	PCA9450_LDO3,
+	PCA9450_LDO4,
+	PCA9450_LDO5,
+	PCA9450_REGULATOR_CNT,
+};
+
+enum {
+	PCA9450_DVS_LEVEL_RUN = 0,
+	PCA9450_DVS_LEVEL_STANDBY,
+	PCA9450_DVS_LEVEL_MAX,
+};
+
+#define PCA9450_BUCK1_VOLTAGE_NUM	0x80
+#define PCA9450_BUCK2_VOLTAGE_NUM	0x80
+#define PCA9450_BUCK3_VOLTAGE_NUM	0x80
+#define PCA9450_BUCK4_VOLTAGE_NUM	0x80
+
+#define PCA9450_BUCK5_VOLTAGE_NUM	0x80
+#define PCA9450_BUCK6_VOLTAGE_NUM	0x80
+
+#define PCA9450_LDO1_VOLTAGE_NUM	0x08
+#define PCA9450_LDO2_VOLTAGE_NUM	0x08
+#define PCA9450_LDO3_VOLTAGE_NUM	0x20
+#define PCA9450_LDO4_VOLTAGE_NUM	0x20
+#define PCA9450_LDO5_VOLTAGE_NUM	0x10
+
+enum {
+	PCA9450_REG_DEV_ID	    = 0x00,
+	PCA9450_REG_INT1	    = 0x01,
+	PCA9450_REG_INT1_MSK	    = 0x02,
+	PCA9450_REG_STATUS1	    = 0x03,
+	PCA9450_REG_STATUS2	    = 0x04,
+	PCA9450_REG_PWRON_STAT	    = 0x05,
+	PCA9450_REG_SWRST	    = 0x06,
+	PCA9450_REG_PWRCTRL         = 0x07,
+	PCA9450_REG_RESET_CTRL      = 0x08,
+	PCA9450_REG_CONFIG1         = 0x09,
+	PCA9450_REG_CONFIG2         = 0x0A,
+	PCA9450_REG_BUCK123_DVS     = 0x0C,
+	PCA9450_REG_BUCK1OUT_LIMIT  = 0x0D,
+	PCA9450_REG_BUCK2OUT_LIMIT  = 0x0E,
+	PCA9450_REG_BUCK3OUT_LIMIT  = 0x0F,
+	PCA9450_REG_BUCK1CTRL       = 0x10,
+	PCA9450_REG_BUCK1OUT_DVS0   = 0x11,
+	PCA9450_REG_BUCK1OUT_DVS1   = 0x12,
+	PCA9450_REG_BUCK2CTRL       = 0x13,
+	PCA9450_REG_BUCK2OUT_DVS0   = 0x14,
+	PCA9450_REG_BUCK2OUT_DVS1   = 0x15,
+	PCA9450_REG_BUCK3CTRL       = 0x16,
+	PCA9450_REG_BUCK3OUT_DVS0   = 0x17,
+	PCA9450_REG_BUCK3OUT_DVS1   = 0x18,
+	PCA9450_REG_BUCK4CTRL       = 0x19,
+	PCA9450_REG_BUCK4OUT        = 0x1A,
+	PCA9450_REG_BUCK5CTRL       = 0x1B,
+	PCA9450_REG_BUCK5OUT        = 0x1C,
+	PCA9450_REG_BUCK6CTRL       = 0x1D,
+	PCA9450_REG_BUCK6OUT        = 0x1E,
+	PCA9450_REG_LDO_AD_CTRL     = 0x20,
+	PCA9450_REG_LDO1CTRL        = 0x21,
+	PCA9450_REG_LDO2CTRL        = 0x22,
+	PCA9450_REG_LDO3CTRL        = 0x23,
+	PCA9450_REG_LDO4CTRL        = 0x24,
+	PCA9450_REG_LDO5CTRL_L      = 0x25,
+	PCA9450_REG_LDO5CTRL_H      = 0x26,
+	PCA9450_REG_LOADSW_CTRL     = 0x2A,
+	PCA9450_REG_VRFLT1_STS      = 0x2B,
+	PCA9450_REG_VRFLT2_STS      = 0x2C,
+	PCA9450_REG_VRFLT1_MASK     = 0x2D,
+	PCA9450_REG_VRFLT2_MASK     = 0x2E,
+	PCA9450_MAX_REGISTER	    = 0x2F,
+};
+
+/* PCA9450 BUCK ENMODE bits */
+#define BUCK_ENMODE_OFF			0x00
+#define BUCK_ENMODE_ONREQ		0x01
+#define BUCK_ENMODE_ONREQ_STBYREQ	0x02
+#define BUCK_ENMODE_ON			0x03
+
+/* PCA9450_REG_BUCK1_CTRL bits */
+#define BUCK1_RAMP_MASK			0xC0
+#define BUCK1_RAMP_25MV			0x0
+#define BUCK1_RAMP_12P5MV		0x1
+#define BUCK1_RAMP_6P25MV		0x2
+#define BUCK1_RAMP_3P125MV		0x3
+#define BUCK1_DVS_CTRL			0x10
+#define BUCK1_AD			0x08
+#define BUCK1_FPWM			0x04
+#define BUCK1_ENMODE_MASK		0x03
+
+/* PCA9450_REG_BUCK2_CTRL bits */
+#define BUCK2_RAMP_MASK			0xC0
+#define BUCK2_RAMP_25MV			0x0
+#define BUCK2_RAMP_12P5MV		0x1
+#define BUCK2_RAMP_6P25MV		0x2
+#define BUCK2_RAMP_3P125MV		0x3
+#define BUCK2_DVS_CTRL			0x10
+#define BUCK2_AD			0x08
+#define BUCK2_FPWM			0x04
+#define BUCK2_ENMODE_MASK		0x03
+
+/* PCA9450_REG_BUCK3_CTRL bits */
+#define BUCK3_RAMP_MASK			0xC0
+#define BUCK3_RAMP_25MV			0x0
+#define BUCK3_RAMP_12P5MV		0x1
+#define BUCK3_RAMP_6P25MV		0x2
+#define BUCK3_RAMP_3P125MV		0x3
+#define BUCK3_DVS_CTRL			0x10
+#define BUCK3_AD			0x08
+#define BUCK3_FPWM			0x04
+#define BUCK3_ENMODE_MASK		0x03
+
+/* PCA9450_REG_BUCK4_CTRL bits */
+#define BUCK4_AD			0x08
+#define BUCK4_FPWM			0x04
+#define BUCK4_ENMODE_MASK		0x03
+
+/* PCA9450_REG_BUCK5_CTRL bits */
+#define BUCK5_AD			0x08
+#define BUCK5_FPWM			0x04
+#define BUCK5_ENMODE_MASK		0x03
+
+/* PCA9450_REG_BUCK6_CTRL bits */
+#define BUCK6_AD			0x08
+#define BUCK6_FPWM			0x04
+#define BUCK6_ENMODE_MASK		0x03
+
+/* PCA9450_BUCK1OUT_DVS0 bits */
+#define BUCK1OUT_DVS0_MASK		0x7F
+#define BUCK1OUT_DVS0_DEFAULT		0x14
+
+/* PCA9450_BUCK1OUT_DVS1 bits */
+#define BUCK1OUT_DVS1_MASK		0x7F
+#define BUCK1OUT_DVS1_DEFAULT		0x14
+
+/* PCA9450_BUCK2OUT_DVS0 bits */
+#define BUCK2OUT_DVS0_MASK		0x7F
+#define BUCK2OUT_DVS0_DEFAULT		0x14
+
+/* PCA9450_BUCK2OUT_DVS1 bits */
+#define BUCK2OUT_DVS1_MASK		0x7F
+#define BUCK2OUT_DVS1_DEFAULT		0x14
+
+/* PCA9450_BUCK3OUT_DVS0 bits */
+#define BUCK3OUT_DVS0_MASK		0x7F
+#define BUCK3OUT_DVS0_DEFAULT		0x14
+
+/* PCA9450_BUCK3OUT_DVS1 bits */
+#define BUCK3OUT_DVS1_MASK		0x7F
+#define BUCK3OUT_DVS1_DEFAULT		0x14
+
+/* PCA9450_REG_BUCK4OUT bits */
+#define BUCK4OUT_MASK			0x7F
+#define BUCK4OUT_DEFAULT		0x6C
+
+/* PCA9450_REG_BUCK5OUT bits */
+#define BUCK5OUT_MASK			0x7F
+#define BUCK5OUT_DEFAULT		0x30
+
+/* PCA9450_REG_BUCK6OUT bits */
+#define BUCK6OUT_MASK			0x7F
+#define BUCK6OUT_DEFAULT		0x14
+
+/* PCA9450_REG_LDO1_VOLT bits */
+#define LDO1_EN_MASK			0xC0
+#define LDO1OUT_MASK			0x07
+
+/* PCA9450_REG_LDO2_VOLT bits */
+#define LDO2_EN_MASK			0xC0
+#define LDO2OUT_MASK			0x07
+
+/* PCA9450_REG_LDO3_VOLT bits */
+#define LDO3_EN_MASK			0xC0
+#define LDO3OUT_MASK			0x0F
+
+/* PCA9450_REG_LDO4_VOLT bits */
+#define LDO4_EN_MASK			0xC0
+#define LDO4OUT_MASK			0x0F
+
+/* PCA9450_REG_LDO5_VOLT bits */
+#define LDO5L_EN_MASK			0xC0
+#define LDO5LOUT_MASK			0x0F
+
+#define LDO5H_EN_MASK			0xC0
+#define LDO5HOUT_MASK			0x0F
+
+/* PCA9450_REG_IRQ bits */
+#define IRQ_PWRON			0x80
+#define IRQ_WDOGB			0x40
+#define IRQ_RSVD			0x20
+#define IRQ_VR_FLT1			0x10
+#define IRQ_VR_FLT2			0x08
+#define IRQ_LOWVSYS			0x04
+#define IRQ_THERM_105			0x02
+#define IRQ_THERM_125			0x01
+
+#endif /* __LINUX_REG_PCA9450_H__ */
-- 
2.7.4

