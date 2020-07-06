Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343E5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA7820772
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="BStXhIsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgGFICr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:02:47 -0400
Received: from mail-am6eur05on2138.outbound.protection.outlook.com ([40.107.22.138]:39361
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728292AbgGFICo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:02:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/rT7LQydWBd48wx8lqrisyFHg1mTTIdW/evLIIEqDllw8nxAyF1dwCpIwBLaOH+tW51DKAQd3uRZsyf/qEXkVVQlgrjZ/LO+GAYmEychMJzQOsO8hI2SwaSiDBw+TZbPlOUWTAZfuawpJ9IJH9rRd4v57LAKwoSNeUUG0KvLjemuE/Osl63RfpC3wzDG8PLANzNtQxUUwKhdB/bqeAodPJHoMuoY7LWcn3P4t8Bw1NVkA9iDggxd/pn2snjpTfGYOW8uKxYqWowZs3D6KDKy7ttPtmNk0AUcHiBV01CPxna27WnaRxsJtkb+VrD6O7Zy24/0ZqrriZXT86reBWBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rRUgTktYmBWPzONC9G/LmPyHIIbPN7SU1KNhuQA5WQ=;
 b=A87LHnNeA0Xe2pjpKCSHkhaEhEnJrJXauybPeJ7GvSCsgAHQDtgObNIEdc2oV/i1J3GuiXJ1Q07dVr0MIOofLpz8ZRMC7/q6A+EOhbcs08/ZeL1oeEh6Tbjm0FCXI7tLQ7St7YezF/+z/TOSdrH+6Tq5bGOq1hw3J2UGYl2aOI+dKjJ3zSC8+VoQxT1WXM/9HnQRHFF8nvGmPKNyZ/DQkSPTqc4kme1MYr3itQdxD6ojJIVyljsKxJWqYlDsjkdhrU4E/dDUf1CkE0+uc2boDVBzsiLAEGmmkqQ8V0ly20Imurc5VX9TV0B3LaejML3iMT8r+Mf+7+1RcfAMGs9Z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rRUgTktYmBWPzONC9G/LmPyHIIbPN7SU1KNhuQA5WQ=;
 b=BStXhIsxX03fbM2NjpDlvYj6ayHyh8YY+aBJYys13n6HkjOsvb1Ebq1l2xmQ++i2kXcCvIlou3cBJkpizTDFfx4hjcjnPHm5PeRVdF9+Hml5caDW3DM3HUHsr3iTQJkHrGr5oI8Kc88G54FE6N6HmBUjMjvCHcnySt6LhbWxryg=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB7PR10MB2427.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Mon, 6 Jul
 2020 08:02:32 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 08:02:32 +0000
Subject: Re: [PATCH v2 1/4] regulator: pca9450: add pca9450 pmic driver
To:     Robin Gong <yibin.gong@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, anson.huang@nxp.com,
        festevam@gmail.com, s.hauer@pengutronix.de, john.lee@nxp.com
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
References: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
 <1593793178-9737-2-git-send-email-yibin.gong@nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <f53fe9f2-9120-d7c3-1eb4-df1efafd23f4@kontron.de>
Date:   Mon, 6 Jul 2020 10:02:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <1593793178-9737-2-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::33) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.99.63] (80.147.118.32) by AM0PR08CA0020.eurprd08.prod.outlook.com (2603:10a6:208:d2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Mon, 6 Jul 2020 08:02:30 +0000
X-Originating-IP: [80.147.118.32]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26264962-ddd6-4f30-4295-08d82182ef4a
X-MS-TrafficTypeDiagnostic: DB7PR10MB2427:
X-Microsoft-Antispam-PRVS: <DB7PR10MB24279EC015B2F32389A10539E9690@DB7PR10MB2427.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:132;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8wqbS1SxwQHjZZ3IXk1hs3SteO7spHm4k2Ar5fAjtpsWiE7dJZqBOE7FDTfgp7H3OeCJ6axbEA5EuBzocfeVIxAc4fgHzh+k2R49R29A4/LrXtMbaxD4eGTQiiwmk1Cog5H6yfoXm4g/rXnjQ+R9xWwO9g5+Z71d/IEKy8xkE8qBLiDhfdmQtU3NbhRj3MAS9GLREMv27X08ITbPuYVL8aIc8CIP2CPxXat+LHRc/IqHilAtsl66LN7KcH641keY0fiwYHBCVYwqY5rndpqMSaGn+Bt/ryIOCGzFdt97+1nf0tj0v97P2LFlL4l7Fm7MNjzNooTr8UJ7eWz7xRsxzem7dHzcdOmA7vCnUTiQNME4Ij9XlCjPlUm9zCpV70Vvahjh3KbvbSX2iBvN/w3uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(376002)(346002)(39850400004)(396003)(16526019)(186003)(66946007)(8676002)(6486002)(66476007)(66556008)(44832011)(4326008)(8936002)(7416002)(36756003)(956004)(83380400001)(53546011)(26005)(2616005)(478600001)(86362001)(2906002)(52116002)(31686004)(5660300002)(16576012)(31696002)(316002)(30864003)(921003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ndvmaXATbXzvxDbVnoVcnoqvli3t+UB49KZ7rfzj5kbkove0HdUie9KVNHN43ftmUCmUFtf/h+lS2gUOn0TFG1TlH5CCnOnVO7KbzSjIBrYtCy+6Xptfa2yfzP43D0KHGaunXYV77dAtXWducihlLwu7d5HHHaELjXuFGa2jSKSVr+emeK/+y87kSCsw7CBUs1vpUAjKlaQEhtWOgTSYaF45LlaiS9oaOlQtWXudbDUV13LUQljpae70zPJ3eeCY54OzS6OAMWnrQk/SH45gb1G/ayOM3zX7qEGil7IYeN3gbesJJndZA5sV0Te1lOMHy/6+KWHT9+EPODvnOPmlKDw4icWbeYEwC4dIruG2pOu6uIyw49aVFz1/AHGee8yRUtNHVWMjRtJ1NulDu1aj9RsWKKIyl5RGeD7Dg+owD85qZaQbiGLCKkVjZvjT5UyDdSqF6xdu8oIScog0SR/QMdP2JbjQoH9XaOWlsCAwZe0=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 26264962-ddd6-4f30-4295-08d82182ef4a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 08:02:31.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IM7+xv8XH4dMM3uOEcGEhMNQU9o7bI5PI9PIQnCFxptFjUX+QAeWSX9+77bW57IYXE2++yw6ybef2ahCY2MQ7asOU4ftDgpAvuW786nB/zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.20 18:19, Robin Gong wrote:
> Add NXP pca9450 pmic driver.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   drivers/regulator/Kconfig             |   8 +
>   drivers/regulator/Makefile            |   1 +
>   drivers/regulator/pca9450-regulator.c | 843 ++++++++++++++++++++++++++++++++++
>   include/linux/regulator/pca9450.h     | 219 +++++++++
>   4 files changed, 1071 insertions(+)
>   create mode 100644 drivers/regulator/pca9450-regulator.c
>   create mode 100644 include/linux/regulator/pca9450.h
> 
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index f60eeaa..f992a17 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -740,6 +740,14 @@ config REGULATOR_PBIAS
>   	 This driver provides support for OMAP pbias modelled
>   	 regulators.
>   
> +config REGULATOR_PCA9450
> +	tristate "NXP PCA9450A/PCA9450B/PCA9450C regulator driver"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say y here to support the NXP PCA9450A/PCA9450B/PCA9450C PMIC
> +	  regulator driver.
> +
>   config REGULATOR_PCAP
>   	tristate "Motorola PCAP2 regulator driver"
>   	depends on EZX_PCAP
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 5ce7350..ff524922 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -94,6 +94,7 @@ obj-$(CONFIG_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
>   obj-$(CONFIG_REGULATOR_QCOM_SMD_RPM) += qcom_smd-regulator.o
>   obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
>   obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
> +obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
>   obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
>   obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
>   obj-$(CONFIG_REGULATOR_PV88080) += pv88080-regulator.o
> diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
> new file mode 100644
> index 00000000..0225045
> --- /dev/null
> +++ b/drivers/regulator/pca9450-regulator.c
> @@ -0,0 +1,843 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2020 NXP.
> + * NXP PCA9450 pmic driver
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <linux/regulator/pca9450.h>
> +
> +struct pc9450_dvs_config {
> +	unsigned int run_reg; /* dvs0 */
> +	unsigned int run_mask;
> +	unsigned int standby_reg; /* dvs1 */
> +	unsigned int standby_mask;
> +};
> +
> +struct pca9450_regulator_desc {
> +	struct regulator_desc desc;
> +	const struct pc9450_dvs_config dvs;
> +};
> +
> +struct pca9450 {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	enum pca9450_chip_type type;
> +	unsigned int rcnt;
> +	int irq;
> +};
> +
> +static const struct regmap_range pca9450_status_range = {
> +	.range_min = PCA9450_REG_INT1,
> +	.range_max = PCA9450_REG_PWRON_STAT,
> +};
> +
> +static const struct regmap_access_table pca9450_volatile_regs = {
> +	.yes_ranges = &pca9450_status_range,
> +	.n_yes_ranges = 1,
> +};
> +
> +static const struct regmap_config pca9450_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.volatile_table = &pca9450_volatile_regs,
> +	.max_register = PCA9450_MAX_REGISTER - 1,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
> +/*
> + * BUCK1/2/3
> + * BUCK1RAM[1:0] BUCK1 DVS ramp rate setting
> + * 00: 25mV/1usec
> + * 01: 25mV/2usec
> + * 10: 25mV/4usec
> + * 11: 25mV/8usec
> + */
> +static int pca9450_dvs_set_ramp_delay(struct regulator_dev *rdev,
> +				      int ramp_delay)
> +{
> +	int id = rdev_get_id(rdev);
> +	unsigned int ramp_value;
> +
> +	switch (ramp_delay) {
> +	case 1 ... 3125:
> +		ramp_value = BUCK1_RAMP_3P125MV;
> +		break;
> +	case 3126 ... 6250:
> +		ramp_value = BUCK1_RAMP_6P25MV;
> +		break;
> +	case 6251 ... 12500:
> +		ramp_value = BUCK1_RAMP_12P5MV;
> +		break;
> +	case 12501 ... 25000:
> +		ramp_value = BUCK1_RAMP_25MV;
> +		break;
> +	default:
> +		ramp_value = BUCK1_RAMP_25MV;
> +	}
> +
> +	return regmap_update_bits(rdev->regmap, PCA9450_REG_BUCK1CTRL + id * 3,
> +				  BUCK1_RAMP_MASK, ramp_value << 6);
> +}
> +
> +static struct regulator_ops pca9450_dvs_buck_regulator_ops = {
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = regulator_is_enabled_regmap,
> +	.list_voltage = regulator_list_voltage_linear_range,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +	.set_voltage_time_sel = regulator_set_voltage_time_sel,
> +	.set_ramp_delay = pca9450_dvs_set_ramp_delay,
> +};
> +
> +static struct regulator_ops pca9450_buck_regulator_ops = {
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = regulator_is_enabled_regmap,
> +	.list_voltage = regulator_list_voltage_linear_range,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +	.set_voltage_time_sel = regulator_set_voltage_time_sel,
> +};
> +
> +static struct regulator_ops pca9450_ldo_regulator_ops = {
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = regulator_is_enabled_regmap,
> +	.list_voltage = regulator_list_voltage_linear_range,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +};
> +
> +/*
> + * BUCK1/2/3
> + * 0.60 to 2.1875V (12.5mV step)
> + */
> +static const struct linear_range pca9450_dvs_buck_volts[] = {
> +	REGULATOR_LINEAR_RANGE(600000,  0x00, 0x7F, 12500),
> +};
> +
> +/*
> + * BUCK4/5/6
> + * 0.6V to 3.4V (25mV step)
> + */
> +static const struct linear_range pca9450_buck_volts[] = {
> +	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x70, 25000),
> +	REGULATOR_LINEAR_RANGE(3400000, 0x71, 0x7F, 0),
> +};
> +
> +/*
> + * LDO1
> + * 1.6 to 3.3V ()
> + */
> +static const struct linear_range pca9450_ldo1_volts[] = {
> +	REGULATOR_LINEAR_RANGE(1600000, 0x00, 0x03, 100000),
> +	REGULATOR_LINEAR_RANGE(3000000, 0x04, 0x07, 100000),
> +};
> +
> +/*
> + * LDO2
> + * 0.8 to 1.15V (50mV step)
> + */
> +static const struct linear_range pca9450_ldo2_volts[] = {
> +	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x07, 50000),
> +};
> +
> +/*
> + * LDO3/4
> + * 0.8 to 3.3V (100mV step)
> + */
> +static const struct linear_range pca9450_ldo34_volts[] = {
> +	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x19, 100000),
> +	REGULATOR_LINEAR_RANGE(3300000, 0x1A, 0x1F, 0),
> +};
> +
> +/*
> + * LDO5
> + * 1.8 to 3.3V (100mV step)
> + */
> +static const struct linear_range pca9450_ldo5_volts[] = {
> +	REGULATOR_LINEAR_RANGE(1800000,  0x00, 0x0F, 100000),
> +};
> +
> +static int buck_set_dvs(const struct regulator_desc *desc,
> +			struct device_node *np, struct regmap *regmap,
> +			char *prop, unsigned int reg, unsigned int mask)
> +{
> +	int ret, i;
> +	uint32_t uv;
> +
> +	ret = of_property_read_u32(np, prop, &uv);
> +	if (ret == -EINVAL)
> +		return 0;
> +	else if (ret)
> +		return ret;
> +
> +	for (i = 0; i < desc->n_voltages; i++) {
> +		ret = regulator_desc_list_voltage_linear_range(desc, i);
> +		if (ret < 0)
> +			continue;
> +		if (ret == uv) {
> +			i <<= ffs(desc->vsel_mask) - 1;
> +			ret = regmap_update_bits(regmap, reg, mask, i);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int pca9450_set_dvs_levels(struct device_node *np,
> +			    const struct regulator_desc *desc,
> +			    struct regulator_config *cfg)
> +{
> +	struct pca9450_regulator_desc *data = container_of(desc,
> +					struct pca9450_regulator_desc, desc);
> +	const struct pc9450_dvs_config *dvs = &data->dvs;
> +	unsigned int reg, mask;
> +	char *prop;
> +	int i, ret = 0;
> +
> +	for (i = 0; i < PCA9450_DVS_LEVEL_MAX; i++) {
> +		switch (i) {
> +		case PCA9450_DVS_LEVEL_RUN:
> +			prop = "nxp,dvs-run-voltage";
> +			reg = dvs->run_reg;
> +			mask = dvs->run_mask;
> +			break;
> +		case PCA9450_DVS_LEVEL_STANDBY:
> +			prop = "nxp,dvs-standby-voltage";
> +			reg = dvs->standby_reg;
> +			mask = dvs->standby_mask;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		ret = buck_set_dvs(desc, np, cfg->regmap, prop, reg, mask);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct pca9450_regulator_desc pca9450a_regulators[] = {
> +	{
> +		.desc = {
> +			.name = "buck1",
> +			.of_match = of_match_ptr("BUCK1"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_BUCK1,
> +			.ops = &pca9450_dvs_buck_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_BUCK1_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_dvs_buck_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
> +			.vsel_reg = PCA9450_REG_BUCK1OUT_DVS0,
> +			.vsel_mask = BUCK1OUT_DVS0_MASK,
> +			.enable_reg = PCA9450_REG_BUCK1CTRL,
> +			.enable_mask = BUCK1_ENMODE_MASK,
> +			.owner = THIS_MODULE,
> +			.of_parse_cb = pca9450_set_dvs_levels,
> +		},
> +		.dvs = {
> +			.run_reg = PCA9450_REG_BUCK1OUT_DVS0,
> +			.run_mask = BUCK1OUT_DVS0_MASK,
> +			.standby_reg = PCA9450_REG_BUCK1OUT_DVS1,
> +			.standby_mask = BUCK1OUT_DVS1_MASK,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "buck2",
> +			.of_match = of_match_ptr("BUCK2"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_BUCK2,
> +			.ops = &pca9450_dvs_buck_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_BUCK2_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_dvs_buck_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
> +			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
> +			.vsel_mask = BUCK2OUT_DVS0_MASK,
> +			.enable_reg = PCA9450_REG_BUCK2CTRL,
> +			.enable_mask = BUCK1_ENMODE_MASK,
> +			.owner = THIS_MODULE,
> +			.of_parse_cb = pca9450_set_dvs_levels,
> +		},
> +		.dvs = {
> +			.run_reg = PCA9450_REG_BUCK2OUT_DVS0,
> +			.run_mask = BUCK2OUT_DVS0_MASK,
> +			.standby_reg = PCA9450_REG_BUCK2OUT_DVS1,
> +			.standby_mask = BUCK2OUT_DVS1_MASK,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "buck3",
> +			.of_match = of_match_ptr("BUCK3"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_BUCK3,
> +			.ops = &pca9450_dvs_buck_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_BUCK3_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_dvs_buck_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
> +			.vsel_reg = PCA9450_REG_BUCK3OUT_DVS0,
> +			.vsel_mask = BUCK3OUT_DVS0_MASK,
> +			.enable_reg = PCA9450_REG_BUCK3CTRL,
> +			.enable_mask = BUCK3_ENMODE_MASK,
> +			.owner = THIS_MODULE,
> +			.of_parse_cb = pca9450_set_dvs_levels,
> +		},
> +		.dvs = {
> +			.run_reg = PCA9450_REG_BUCK3OUT_DVS0,
> +			.run_mask = BUCK3OUT_DVS0_MASK,
> +			.standby_reg = PCA9450_REG_BUCK3OUT_DVS1,
> +			.standby_mask = BUCK3OUT_DVS1_MASK,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "buck4",
> +			.of_match = of_match_ptr("BUCK4"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_BUCK4,
> +			.ops = &pca9450_buck_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_BUCK4_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_buck_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
> +			.vsel_reg = PCA9450_REG_BUCK4OUT,
> +			.vsel_mask = BUCK4OUT_MASK,
> +			.enable_reg = PCA9450_REG_BUCK4CTRL,
> +			.enable_mask = BUCK4_ENMODE_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "buck5",
> +			.of_match = of_match_ptr("BUCK5"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_BUCK5,
> +			.ops = &pca9450_buck_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_BUCK5_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_buck_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
> +			.vsel_reg = PCA9450_REG_BUCK5OUT,
> +			.vsel_mask = BUCK5OUT_MASK,
> +			.enable_reg = PCA9450_REG_BUCK5CTRL,
> +			.enable_mask = BUCK5_ENMODE_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "buck6",
> +			.of_match = of_match_ptr("BUCK6"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_BUCK6,
> +			.ops = &pca9450_buck_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_BUCK6_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_buck_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
> +			.vsel_reg = PCA9450_REG_BUCK6OUT,
> +			.vsel_mask = BUCK6OUT_MASK,
> +			.enable_reg = PCA9450_REG_BUCK6CTRL,
> +			.enable_mask = BUCK6_ENMODE_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "ldo1",
> +			.of_match = of_match_ptr("LDO1"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_LDO1,
> +			.ops = &pca9450_ldo_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_LDO1_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_ldo1_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo1_volts),
> +			.vsel_reg = PCA9450_REG_LDO1CTRL,
> +			.vsel_mask = LDO1OUT_MASK,
> +			.enable_reg = PCA9450_REG_LDO1CTRL,
> +			.enable_mask = LDO1_EN_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "ldo2",
> +			.of_match = of_match_ptr("LDO2"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_LDO2,
> +			.ops = &pca9450_ldo_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_LDO2_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_ldo2_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo2_volts),
> +			.vsel_reg = PCA9450_REG_LDO2CTRL,
> +			.vsel_mask = LDO2OUT_MASK,
> +			.enable_reg = PCA9450_REG_LDO2CTRL,
> +			.enable_mask = LDO2_EN_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "ldo3",
> +			.of_match = of_match_ptr("LDO3"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_LDO3,
> +			.ops = &pca9450_ldo_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_LDO3_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_ldo34_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo34_volts),
> +			.vsel_reg = PCA9450_REG_LDO3CTRL,
> +			.vsel_mask = LDO3OUT_MASK,
> +			.enable_reg = PCA9450_REG_LDO3CTRL,
> +			.enable_mask = LDO3_EN_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "ldo4",
> +			.of_match = of_match_ptr("LDO4"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_LDO4,
> +			.ops = &pca9450_ldo_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_LDO4_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_ldo34_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo34_volts),
> +			.vsel_reg = PCA9450_REG_LDO4CTRL,
> +			.vsel_mask = LDO4OUT_MASK,
> +			.enable_reg = PCA9450_REG_LDO4CTRL,
> +			.enable_mask = LDO4_EN_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "ldo5",
> +			.of_match = of_match_ptr("LDO5"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_LDO5,
> +			.ops = &pca9450_ldo_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_LDO5_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_ldo5_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
> +			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
> +			.vsel_mask = LDO5HOUT_MASK,
> +			.enable_reg = PCA9450_REG_LDO5CTRL_H,
> +			.enable_mask = LDO5H_EN_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +};
> +
> +/*
> + * Buck3 removed on PCA9450B and connected with Buck1 internal for dual phase
> + * on PCA9450C as no Buck3.
> + */
> +static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
> +	{
> +		.desc = {
> +			.name = "buck1",
> +			.of_match = of_match_ptr("BUCK1"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_BUCK1,
> +			.ops = &pca9450_dvs_buck_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_BUCK1_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_dvs_buck_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
> +			.vsel_reg = PCA9450_REG_BUCK1OUT_DVS0,
> +			.vsel_mask = BUCK1OUT_DVS0_MASK,
> +			.enable_reg = PCA9450_REG_BUCK1CTRL,
> +			.enable_mask = BUCK1_ENMODE_MASK,
> +			.owner = THIS_MODULE,
> +			.of_parse_cb = pca9450_set_dvs_levels,
> +		},
> +		.dvs = {
> +			.run_reg = PCA9450_REG_BUCK1OUT_DVS0,
> +			.run_mask = BUCK1OUT_DVS0_MASK,
> +			.standby_reg = PCA9450_REG_BUCK1OUT_DVS1,
> +			.standby_mask = BUCK1OUT_DVS1_MASK,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "buck2",
> +			.of_match = of_match_ptr("BUCK2"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_BUCK2,
> +			.ops = &pca9450_dvs_buck_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_BUCK2_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_dvs_buck_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
> +			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
> +			.vsel_mask = BUCK2OUT_DVS0_MASK,
> +			.enable_reg = PCA9450_REG_BUCK2CTRL,
> +			.enable_mask = BUCK1_ENMODE_MASK,
> +			.owner = THIS_MODULE,
> +			.of_parse_cb = pca9450_set_dvs_levels,
> +		},
> +		.dvs = {
> +			.run_reg = PCA9450_REG_BUCK2OUT_DVS0,
> +			.run_mask = BUCK2OUT_DVS0_MASK,
> +			.standby_reg = PCA9450_REG_BUCK2OUT_DVS1,
> +			.standby_mask = BUCK2OUT_DVS1_MASK,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "buck4",
> +			.of_match = of_match_ptr("BUCK4"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_BUCK4,
> +			.ops = &pca9450_buck_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_BUCK4_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_buck_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
> +			.vsel_reg = PCA9450_REG_BUCK4OUT,
> +			.vsel_mask = BUCK4OUT_MASK,
> +			.enable_reg = PCA9450_REG_BUCK4CTRL,
> +			.enable_mask = BUCK4_ENMODE_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "buck5",
> +			.of_match = of_match_ptr("BUCK5"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_BUCK5,
> +			.ops = &pca9450_buck_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_BUCK5_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_buck_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
> +			.vsel_reg = PCA9450_REG_BUCK5OUT,
> +			.vsel_mask = BUCK5OUT_MASK,
> +			.enable_reg = PCA9450_REG_BUCK5CTRL,
> +			.enable_mask = BUCK5_ENMODE_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "buck6",
> +			.of_match = of_match_ptr("BUCK6"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_BUCK6,
> +			.ops = &pca9450_buck_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_BUCK6_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_buck_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
> +			.vsel_reg = PCA9450_REG_BUCK6OUT,
> +			.vsel_mask = BUCK6OUT_MASK,
> +			.enable_reg = PCA9450_REG_BUCK6CTRL,
> +			.enable_mask = BUCK6_ENMODE_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "ldo1",
> +			.of_match = of_match_ptr("LDO1"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_LDO1,
> +			.ops = &pca9450_ldo_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_LDO1_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_ldo1_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo1_volts),
> +			.vsel_reg = PCA9450_REG_LDO1CTRL,
> +			.vsel_mask = LDO1OUT_MASK,
> +			.enable_reg = PCA9450_REG_LDO1CTRL,
> +			.enable_mask = LDO1_EN_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "ldo2",
> +			.of_match = of_match_ptr("LDO2"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_LDO2,
> +			.ops = &pca9450_ldo_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_LDO2_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_ldo2_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo2_volts),
> +			.vsel_reg = PCA9450_REG_LDO2CTRL,
> +			.vsel_mask = LDO2OUT_MASK,
> +			.enable_reg = PCA9450_REG_LDO2CTRL,
> +			.enable_mask = LDO2_EN_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "ldo3",
> +			.of_match = of_match_ptr("LDO3"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_LDO3,
> +			.ops = &pca9450_ldo_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_LDO3_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_ldo34_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo34_volts),
> +			.vsel_reg = PCA9450_REG_LDO3CTRL,
> +			.vsel_mask = LDO3OUT_MASK,
> +			.enable_reg = PCA9450_REG_LDO3CTRL,
> +			.enable_mask = LDO3_EN_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "ldo4",
> +			.of_match = of_match_ptr("LDO4"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_LDO4,
> +			.ops = &pca9450_ldo_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_LDO4_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_ldo34_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo34_volts),
> +			.vsel_reg = PCA9450_REG_LDO4CTRL,
> +			.vsel_mask = LDO4OUT_MASK,
> +			.enable_reg = PCA9450_REG_LDO4CTRL,
> +			.enable_mask = LDO4_EN_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc = {
> +			.name = "ldo5",
> +			.of_match = of_match_ptr("LDO5"),
> +			.regulators_node = of_match_ptr("regulators"),
> +			.id = PCA9450_LDO5,
> +			.ops = &pca9450_ldo_regulator_ops,
> +			.type = REGULATOR_VOLTAGE,
> +			.n_voltages = PCA9450_LDO5_VOLTAGE_NUM,
> +			.linear_ranges = pca9450_ldo5_volts,
> +			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
> +			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
> +			.vsel_mask = LDO5HOUT_MASK,
> +			.enable_reg = PCA9450_REG_LDO5CTRL_H,
> +			.enable_mask = LDO5H_EN_MASK,
> +			.owner = THIS_MODULE,
> +		},
> +	},
> +};
> +
> +static irqreturn_t pca9450_irq_handler(int irq, void *data)
> +{
> +	struct pca9450 *pca9450 = data;
> +	struct regmap *regmap = pca9450->regmap;
> +	unsigned int status;
> +	int ret;
> +
> +	ret = regmap_read(regmap, PCA9450_REG_INT1, &status);
> +	if (ret < 0) {
> +		dev_err(pca9450->dev,
> +			"Failed to read INT1(%d)\n", ret);
> +		return IRQ_NONE;
> +	}
> +
> +	if (status & IRQ_PWRON)
> +		dev_warn(pca9450->dev, "PWRON interrupt.\n");
> +
> +	if (status & IRQ_WDOGB)
> +		dev_warn(pca9450->dev, "WDOGB interrupt.\n");
> +
> +	if (status & IRQ_VR_FLT1)
> +		dev_warn(pca9450->dev, "VRFLT1 interrupt.\n");
> +
> +	if (status & IRQ_VR_FLT2)
> +		dev_warn(pca9450->dev, "VRFLT2 interrupt.\n");
> +
> +	if (status & IRQ_LOWVSYS)
> +		dev_warn(pca9450->dev, "LOWVSYS interrupt.\n");
> +
> +	if (status & IRQ_THERM_105)
> +		dev_warn(pca9450->dev, "IRQ_THERM_105 interrupt.\n");
> +
> +	if (status & IRQ_THERM_125)
> +		dev_warn(pca9450->dev, "IRQ_THERM_125 interrupt.\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pca9450_i2c_probe(struct i2c_client *i2c,
> +			     const struct i2c_device_id *id)
> +{
> +	enum pca9450_chip_type type = (unsigned int)(uintptr_t)
> +				      of_device_get_match_data(&i2c->dev);
> +	const struct pca9450_regulator_desc	*regulator_desc;
> +	struct regulator_config config = { };
> +	struct pca9450 *pca9450;
> +	unsigned int device_id, i;
> +	int ret;
> +
> +	if (!i2c->irq) {
> +		dev_err(&i2c->dev, "No IRQ configured?\n");
> +		return -EINVAL;
> +	}
> +
> +	pca9450 = devm_kzalloc(&i2c->dev, sizeof(struct pca9450), GFP_KERNEL);
> +	if (!pca9450)
> +		return -ENOMEM;
> +
> +	switch (type) {
> +	case PCA9450_TYPE_PCA9450A:
> +		regulator_desc = pca9450a_regulators;
> +		pca9450->rcnt = ARRAY_SIZE(pca9450a_regulators);
> +		break;
> +	case PCA9450_TYPE_PCA9450BC:
> +		regulator_desc = pca9450bc_regulators;
> +		pca9450->rcnt = ARRAY_SIZE(pca9450bc_regulators);
> +		break;
> +	default:
> +		dev_err(&i2c->dev, "Unknown device type");
> +		return -EINVAL;
> +	}
> +
> +	pca9450->irq = i2c->irq;
> +	pca9450->type = type;
> +	pca9450->dev = &i2c->dev;
> +
> +	dev_set_drvdata(&i2c->dev, pca9450);
> +
> +	pca9450->regmap = devm_regmap_init_i2c(i2c,
> +					       &pca9450_regmap_config);
> +	if (IS_ERR(pca9450->regmap)) {
> +		dev_err(&i2c->dev, "regmap initialization failed\n");
> +		return PTR_ERR(pca9450->regmap);
> +	}
> +
> +	ret = regmap_read(pca9450->regmap, PCA9450_REG_DEV_ID, &device_id);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Read device id error\n");
> +		return ret;
> +	}
> +
> +	/* Check your board and dts for match the right pmic */
> +	if (((device_id >> 4) != 0x1 && type == PCA9450_TYPE_PCA9450A) ||
> +	    ((device_id >> 4) != 0x3 && type == PCA9450_TYPE_PCA9450BC)) {
> +		dev_err(&i2c->dev, "Device id(%x) mismatched\n",
> +			device_id >> 4);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < pca9450->rcnt; i++) {
> +		const struct regulator_desc *desc;
> +		struct regulator_dev *rdev;
> +		const struct pca9450_regulator_desc *r;
> +
> +		r = &regulator_desc[i];
> +		desc = &r->desc;
> +
> +		config.regmap = pca9450->regmap;
> +		config.dev = pca9450->dev;
> +
> +		rdev = devm_regulator_register(pca9450->dev, desc, &config);
> +		if (IS_ERR(rdev)) {
> +			ret = PTR_ERR(rdev);
> +			dev_err(pca9450->dev,
> +				"Failed to register regulator(%s): %d\n",
> +				desc->name, ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = devm_request_threaded_irq(pca9450->dev, pca9450->irq, NULL,
> +					pca9450_irq_handler,
> +					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
> +					"pca9450-irq", pca9450);
> +	if (ret != 0) {
> +		dev_err(pca9450->dev, "Failed to request IRQ: %d\n",
> +			pca9450->irq);
> +		return ret;
> +	}
> +	/* Unmask all interrupt except PWRON/WDOG/RSVD */
> +	ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_INT1_MSK,
> +				IRQ_VR_FLT1 | IRQ_VR_FLT2 | IRQ_LOWVSYS |
> +				IRQ_THERM_105 | IRQ_THERM_125,
> +				IRQ_PWRON | IRQ_WDOGB | IRQ_RSVD);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Unmask irq error\n");
> +		return ret;
> +	}
> +
> +	dev_info(&i2c->dev, "%s probed.\n",
> +		type == PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id pca9450_of_match[] = {
> +	{
> +		.compatible = "nxp,pca9450a",
> +		.data = (void *)PCA9450_TYPE_PCA9450A,
> +	},
> +	{
> +		.compatible = "nxp,pca9450b",
> +		.data = (void *)PCA9450_TYPE_PCA9450BC,
> +	},
> +	{
> +		.compatible = "nxp,pca9450c",
> +		.data = (void *)PCA9450_TYPE_PCA9450BC,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pca9450_of_match);
> +
> +static struct i2c_driver pca9450_i2c_driver = {
> +	.driver = {
> +		.name = "nxp-pca9450",
> +		.of_match_table = pca9450_of_match,
> +	},
> +	.probe = pca9450_i2c_probe,
> +};
> +
> +static int __init pca9450_i2c_init(void)
> +{
> +	return i2c_add_driver(&pca9450_i2c_driver);
> +}
> +module_init(pca9450_i2c_init);
> +
> +static void __exit pca9450_i2c_exit(void)
> +{
> +	i2c_del_driver(&pca9450_i2c_driver);
> +}
> +module_exit(pca9450_i2c_exit);
> +
> +MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
> +MODULE_DESCRIPTION("NXP PCA9450 Power Management IC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
> new file mode 100644
> index 00000000..1bbd301
> --- /dev/null
> +++ b/include/linux/regulator/pca9450.h
> @@ -0,0 +1,219 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Copyright 2020 NXP. */
> +
> +#ifndef __LINUX_REG_PCA9450_H__
> +#define __LINUX_REG_PCA9450_H__
> +
> +#include <linux/regmap.h>
> +
> +enum pca9450_chip_type {
> +	PCA9450_TYPE_PCA9450A = 0,
> +	PCA9450_TYPE_PCA9450BC,
> +	PCA9450_TYPE_AMOUNT,
> +};
> +
> +enum {
> +	PCA9450_BUCK1 = 0,
> +	PCA9450_BUCK2,
> +	PCA9450_BUCK3,
> +	PCA9450_BUCK4,
> +	PCA9450_BUCK5,
> +	PCA9450_BUCK6,
> +	PCA9450_LDO1,
> +	PCA9450_LDO2,
> +	PCA9450_LDO3,
> +	PCA9450_LDO4,
> +	PCA9450_LDO5,
> +	PCA9450_REGULATOR_CNT,
> +};
> +
> +enum {
> +	PCA9450_DVS_LEVEL_RUN = 0,
> +	PCA9450_DVS_LEVEL_STANDBY,
> +	PCA9450_DVS_LEVEL_MAX,
> +};
> +
> +#define PCA9450_BUCK1_VOLTAGE_NUM	0x80
> +#define PCA9450_BUCK2_VOLTAGE_NUM	0x80
> +#define PCA9450_BUCK3_VOLTAGE_NUM	0x80
> +#define PCA9450_BUCK4_VOLTAGE_NUM	0x80
> +
> +#define PCA9450_BUCK5_VOLTAGE_NUM	0x80
> +#define PCA9450_BUCK6_VOLTAGE_NUM	0x80
> +
> +#define PCA9450_LDO1_VOLTAGE_NUM	0x08
> +#define PCA9450_LDO2_VOLTAGE_NUM	0x08
> +#define PCA9450_LDO3_VOLTAGE_NUM	0x20
> +#define PCA9450_LDO4_VOLTAGE_NUM	0x20
> +#define PCA9450_LDO5_VOLTAGE_NUM	0x10
> +
> +enum {
> +	PCA9450_REG_DEV_ID	    = 0x00,
> +	PCA9450_REG_INT1	    = 0x01,
> +	PCA9450_REG_INT1_MSK	    = 0x02,
> +	PCA9450_REG_STATUS1	    = 0x03,
> +	PCA9450_REG_STATUS2	    = 0x04,
> +	PCA9450_REG_PWRON_STAT	    = 0x05,
> +	PCA9450_REG_SWRST	    = 0x06,
> +	PCA9450_REG_PWRCTRL         = 0x07,
> +	PCA9450_REG_RESET_CTRL      = 0x08,
> +	PCA9450_REG_CONFIG1         = 0x09,
> +	PCA9450_REG_CONFIG2         = 0x0A,
> +	PCA9450_REG_BUCK123_DVS     = 0x0C,
> +	PCA9450_REG_BUCK1OUT_LIMIT  = 0x0D,
> +	PCA9450_REG_BUCK2OUT_LIMIT  = 0x0E,
> +	PCA9450_REG_BUCK3OUT_LIMIT  = 0x0F,
> +	PCA9450_REG_BUCK1CTRL       = 0x10,
> +	PCA9450_REG_BUCK1OUT_DVS0   = 0x11,
> +	PCA9450_REG_BUCK1OUT_DVS1   = 0x12,
> +	PCA9450_REG_BUCK2CTRL       = 0x13,
> +	PCA9450_REG_BUCK2OUT_DVS0   = 0x14,
> +	PCA9450_REG_BUCK2OUT_DVS1   = 0x15,
> +	PCA9450_REG_BUCK3CTRL       = 0x16,
> +	PCA9450_REG_BUCK3OUT_DVS0   = 0x17,
> +	PCA9450_REG_BUCK3OUT_DVS1   = 0x18,
> +	PCA9450_REG_BUCK4CTRL       = 0x19,
> +	PCA9450_REG_BUCK4OUT        = 0x1A,
> +	PCA9450_REG_BUCK5CTRL       = 0x1B,
> +	PCA9450_REG_BUCK5OUT        = 0x1C,
> +	PCA9450_REG_BUCK6CTRL       = 0x1D,
> +	PCA9450_REG_BUCK6OUT        = 0x1E,
> +	PCA9450_REG_LDO_AD_CTRL     = 0x20,
> +	PCA9450_REG_LDO1CTRL        = 0x21,
> +	PCA9450_REG_LDO2CTRL        = 0x22,
> +	PCA9450_REG_LDO3CTRL        = 0x23,
> +	PCA9450_REG_LDO4CTRL        = 0x24,
> +	PCA9450_REG_LDO5CTRL_L      = 0x25,
> +	PCA9450_REG_LDO5CTRL_H      = 0x26,
> +	PCA9450_REG_LOADSW_CTRL     = 0x2A,
> +	PCA9450_REG_VRFLT1_STS      = 0x2B,
> +	PCA9450_REG_VRFLT2_STS      = 0x2C,
> +	PCA9450_REG_VRFLT1_MASK     = 0x2D,
> +	PCA9450_REG_VRFLT2_MASK     = 0x2E,
> +	PCA9450_MAX_REGISTER	    = 0x2F,
> +};
> +
> +/* PCA9450 BUCK ENMODE bits */
> +#define BUCK_ENMODE_OFF			0x00
> +#define BUCK_ENMODE_ONREQ		0x01
> +#define BUCK_ENMODE_ONREQ_STBYREQ	0x02
> +#define BUCK_ENMODE_ON			0x03
> +
> +/* PCA9450_REG_BUCK1_CTRL bits */
> +#define BUCK1_RAMP_MASK			0xC0
> +#define BUCK1_RAMP_25MV			0x0
> +#define BUCK1_RAMP_12P5MV		0x1
> +#define BUCK1_RAMP_6P25MV		0x2
> +#define BUCK1_RAMP_3P125MV		0x3
> +#define BUCK1_DVS_CTRL			0x10
> +#define BUCK1_AD			0x08
> +#define BUCK1_FPWM			0x04
> +#define BUCK1_ENMODE_MASK		0x03
> +
> +/* PCA9450_REG_BUCK2_CTRL bits */
> +#define BUCK2_RAMP_MASK			0xC0
> +#define BUCK2_RAMP_25MV			0x0
> +#define BUCK2_RAMP_12P5MV		0x1
> +#define BUCK2_RAMP_6P25MV		0x2
> +#define BUCK2_RAMP_3P125MV		0x3
> +#define BUCK2_DVS_CTRL			0x10
> +#define BUCK2_AD			0x08
> +#define BUCK2_FPWM			0x04
> +#define BUCK2_ENMODE_MASK		0x03
> +
> +/* PCA9450_REG_BUCK3_CTRL bits */
> +#define BUCK3_RAMP_MASK			0xC0
> +#define BUCK3_RAMP_25MV			0x0
> +#define BUCK3_RAMP_12P5MV		0x1
> +#define BUCK3_RAMP_6P25MV		0x2
> +#define BUCK3_RAMP_3P125MV		0x3
> +#define BUCK3_DVS_CTRL			0x10
> +#define BUCK3_AD			0x08
> +#define BUCK3_FPWM			0x04
> +#define BUCK3_ENMODE_MASK		0x03
> +
> +/* PCA9450_REG_BUCK4_CTRL bits */
> +#define BUCK4_AD			0x08
> +#define BUCK4_FPWM			0x04
> +#define BUCK4_ENMODE_MASK		0x03
> +
> +/* PCA9450_REG_BUCK5_CTRL bits */
> +#define BUCK5_AD			0x08
> +#define BUCK5_FPWM			0x04
> +#define BUCK5_ENMODE_MASK		0x03
> +
> +/* PCA9450_REG_BUCK6_CTRL bits */
> +#define BUCK6_AD			0x08
> +#define BUCK6_FPWM			0x04
> +#define BUCK6_ENMODE_MASK		0x03
> +
> +/* PCA9450_BUCK1OUT_DVS0 bits */
> +#define BUCK1OUT_DVS0_MASK		0x7F
> +#define BUCK1OUT_DVS0_DEFAULT		0x14
> +
> +/* PCA9450_BUCK1OUT_DVS1 bits */
> +#define BUCK1OUT_DVS1_MASK		0x7F
> +#define BUCK1OUT_DVS1_DEFAULT		0x14
> +
> +/* PCA9450_BUCK2OUT_DVS0 bits */
> +#define BUCK2OUT_DVS0_MASK		0x7F
> +#define BUCK2OUT_DVS0_DEFAULT		0x14
> +
> +/* PCA9450_BUCK2OUT_DVS1 bits */
> +#define BUCK2OUT_DVS1_MASK		0x7F
> +#define BUCK2OUT_DVS1_DEFAULT		0x14
> +
> +/* PCA9450_BUCK3OUT_DVS0 bits */
> +#define BUCK3OUT_DVS0_MASK		0x7F
> +#define BUCK3OUT_DVS0_DEFAULT		0x14
> +
> +/* PCA9450_BUCK3OUT_DVS1 bits */
> +#define BUCK3OUT_DVS1_MASK		0x7F
> +#define BUCK3OUT_DVS1_DEFAULT		0x14
> +
> +/* PCA9450_REG_BUCK4OUT bits */
> +#define BUCK4OUT_MASK			0x7F
> +#define BUCK4OUT_DEFAULT		0x6C
> +
> +/* PCA9450_REG_BUCK5OUT bits */
> +#define BUCK5OUT_MASK			0x7F
> +#define BUCK5OUT_DEFAULT		0x30
> +
> +/* PCA9450_REG_BUCK6OUT bits */
> +#define BUCK6OUT_MASK			0x7F
> +#define BUCK6OUT_DEFAULT		0x14
> +
> +/* PCA9450_REG_LDO1_VOLT bits */
> +#define LDO1_EN_MASK			0xC0
> +#define LDO1OUT_MASK			0x07
> +
> +/* PCA9450_REG_LDO2_VOLT bits */
> +#define LDO2_EN_MASK			0xC0
> +#define LDO2OUT_MASK			0x07
> +
> +/* PCA9450_REG_LDO3_VOLT bits */
> +#define LDO3_EN_MASK			0xC0
> +#define LDO3OUT_MASK			0x0F
> +
> +/* PCA9450_REG_LDO4_VOLT bits */
> +#define LDO4_EN_MASK			0xC0
> +#define LDO4OUT_MASK			0x0F
> +
> +/* PCA9450_REG_LDO5_VOLT bits */
> +#define LDO5L_EN_MASK			0xC0
> +#define LDO5LOUT_MASK			0x0F
> +
> +#define LDO5H_EN_MASK			0xC0
> +#define LDO5HOUT_MASK			0x0F
> +
> +/* PCA9450_REG_IRQ bits */
> +#define IRQ_PWRON			0x80
> +#define IRQ_WDOGB			0x40
> +#define IRQ_RSVD			0x20
> +#define IRQ_VR_FLT1			0x10
> +#define IRQ_VR_FLT2			0x08
> +#define IRQ_LOWVSYS			0x04
> +#define IRQ_THERM_105			0x02
> +#define IRQ_THERM_125			0x01
> +
> +#endif /* __LINUX_REG_PCA9450_H__ */
> 
