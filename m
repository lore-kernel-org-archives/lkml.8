Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F7CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 19:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7216120727
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 19:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgEPTsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 15:48:22 -0400
Received: from mail-oln040092003037.outbound.protection.outlook.com ([40.92.3.37]:26176
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726536AbgEPTsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 15:48:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXfRwADjnfBUenGvRBoQJu8VNDUha/5bHe7lIWJGUgSQ5NDov3kr22ZysTzp4umAMy7/J73ZXmuWxTcV4sw02J9a0fnCM1Zu+/yKSpGQyWs0Btpj4TiIcRX3sH7SZIUPSJU4TzKWRANTQO8PIUkWKgqLxoEFjqEjHXIJ1Cxx3Vlar8o1igT5EHd8XQjmKIeMB/ZhTn+ecAb3NgI3mOuwGKDTO57iiNNPeTpgoohHV51ut2mlQoyKsOu/g4hw0yl9lqtNAt6p0br00mRvjjYfksDcssP8ESaeiI35FnoFWoD88So8s9GK8PxE2C3BXwlNA1hnFNmRhxVOTqa5ZtrKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhQceXd7CNyjnj5PJK+MahYwa6+70HrRMmwEskP0vUY=;
 b=UjzrXZ+4dwjDerLhEIN02+KMlhgoycDpdBdDMXLy3+hh3scDJHTBQpyUiwWhjzLoqHGnYesr/ULVQAVo7Eg2Utbjr42FJ9mp8fiso2km2KfdkLQQkP6yt6W+AFlrfQbpNqf0KxR8Ou8RLR2+8TqzfAXz8nyPkuVpw2Mf4exu1g1QyBXd49u22zyL31qNF829ukxj43SA05KRbTVcOPa3Hm7Wko7sS+86a0BL4V8tlL31vJHrL49xi0dbtul1ps1JvOPbZ48rK+dcYvSPbuEf07nPSHpZkfBGMMrcuBl6XRDeKX0IzAn57ROUQ4BnAwHSKw+zEvSHh+BhHz3SIFNpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
 (10.152.76.51) by BL2NAM02HT029.eop-nam02.prod.protection.outlook.com
 (10.152.77.4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Sat, 16 May
 2020 19:48:18 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e46::50) by BL2NAM02FT054.mail.protection.outlook.com
 (2a01:111:e400:7e46::363) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Sat, 16 May 2020 19:48:18 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:9012E6F1DB73BC1BDDE26BC5F8C1FE021ABB5A673F6D7AFB831F0D43BE98E7D9;UpperCasedChecksum:CDEB029778ABF3424DBA4FBEF9FD2F7419E278745C10845464637B9DA978D14A;SizeAsReceived:7780;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 19:48:18 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 2/2] regulator: max8998: Add charger regulator
Date:   Sat, 16 May 2020 12:47:59 -0700
Message-ID: <BN6PR04MB0660E1F4A3D5A348BE88311CA3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200516194759.7643-1-xc-racer2@live.ca>
References: <20200516194759.7643-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:300:d4::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200516194759.7643-2-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR19CA0016.namprd19.prod.outlook.com (2603:10b6:300:d4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Sat, 16 May 2020 19:48:17 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200516194759.7643-2-xc-racer2@live.ca>
X-TMN:  [Fic/eJm8RqLjtPpljjaShl4FWApE9dCWi7aG+zxNIb/mKVyvYyO3ADax88QB/eVe]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d3d6d928-4242-4cea-0790-08d7f9d2149a
X-MS-TrafficTypeDiagnostic: BL2NAM02HT029:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjyPhzyyc/hWeP5inr2G9tmW27qiZJ/2wE8GwRI4Hcez80W5mBFXtEAqnGh6hQGe2O/qdUaxa61haVnceX3A99EJDUIeWM34FlMybnb1tm1flTEp2G+AwOhHTJ0krNqMyAHHATZFZgZQdjbBdZRFpI7jEhvkBKwU8gWtx9dgCzi6aucf6v+N3m3djnbCERwUZMPWn4+wNY5POM9266wVdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: Av/xDrxFXqvl87IF2KPs2dQeWadmivi2GhI0waNdPguKjrjKYcH/uu3StQ5b0SwIlsgvMMyTsJSuKX+p4Cg+6ks01tFY7Yuye+NK2UKacmGoqHHmpm5vkDt2CNAhaLAxLiET2BjslcDlC7hndwfEzduGREGbVfuVChQRXBczU43d1IVJgq+dNGbsfWeMeshslpY2yhUZWugzH2HpzqZCAg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d6d928-4242-4cea-0790-08d7f9d2149a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2020 19:48:18.4150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max8998 has a current regulator for charging control.  The
charger driver in drivers/power/supply/max8998_charger.c has a
comment in it stating that 'charger control is done by a current
regulator "CHARGER"', but this regulator was never added until
now.

The current values have been extracted from a downstream driver
for the SGH-T959V.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/regulator/max8998.c | 105 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max8998.h |   1 +
 2 files changed, 106 insertions(+)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 60599c3bb845..668ced006417 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -33,6 +33,10 @@ struct max8998_data {
 	unsigned int		buck2_idx;
 };
 
+static const unsigned int charger_current_table[] = {
+	90000, 380000, 475000, 550000, 570000, 600000, 700000, 800000,
+};
+
 static int max8998_get_enable_register(struct regulator_dev *rdev,
 					int *reg, int *shift)
 {
@@ -63,6 +67,10 @@ static int max8998_get_enable_register(struct regulator_dev *rdev,
 		*reg = MAX8998_REG_CHGR2;
 		*shift = 7 - (ldo - MAX8998_ESAFEOUT1);
 		break;
+	case MAX8998_CHARGER:
+		*reg = MAX8998_REG_CHGR2;
+		*shift = 0;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -88,6 +96,11 @@ static int max8998_ldo_is_enabled(struct regulator_dev *rdev)
 	return val & (1 << shift);
 }
 
+static int max8998_ldo_is_enabled_inverted(struct regulator_dev *rdev)
+{
+	return (!max8998_ldo_is_enabled(rdev));
+}
+
 static int max8998_ldo_enable(struct regulator_dev *rdev)
 {
 	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
@@ -358,6 +371,74 @@ static int max8998_set_voltage_buck_time_sel(struct regulator_dev *rdev,
 	return 0;
 }
 
+int max8998_set_current_limit(struct regulator_dev *rdev,
+			      int min_uA, int max_uA)
+{
+	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
+	struct i2c_client *i2c = max8998->iodev->i2c;
+	unsigned int n_currents = rdev->desc->n_current_limits;
+	int i, sel = -1;
+
+	if (n_currents == 0)
+		return -EINVAL;
+
+	if (rdev->desc->curr_table) {
+		const unsigned int *curr_table = rdev->desc->curr_table;
+		bool ascend = curr_table[n_currents - 1] > curr_table[0];
+
+		/* search for closest to maximum */
+		if (ascend) {
+			for (i = n_currents - 1; i >= 0; i--) {
+				if (min_uA <= curr_table[i] &&
+				    curr_table[i] <= max_uA) {
+					sel = i;
+					break;
+				}
+			}
+		} else {
+			for (i = 0; i < n_currents; i++) {
+				if (min_uA <= curr_table[i] &&
+				    curr_table[i] <= max_uA) {
+					sel = i;
+					break;
+				}
+			}
+		}
+	}
+
+	if (sel < 0)
+		return -EINVAL;
+
+	sel <<= ffs(rdev->desc->csel_mask) - 1;
+
+	return max8998_update_reg(i2c, rdev->desc->csel_reg,
+				  sel, rdev->desc->csel_mask);
+}
+
+int max8998_get_current_limit(struct regulator_dev *rdev)
+{
+	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
+	struct i2c_client *i2c = max8998->iodev->i2c;
+	u8 val;
+	int ret;
+
+	ret = max8998_read_reg(i2c, rdev->desc->csel_reg, &val);
+	if (ret != 0)
+		return ret;
+
+	val &= rdev->desc->csel_mask;
+	val >>= ffs(rdev->desc->csel_mask) - 1;
+
+	if (rdev->desc->curr_table) {
+		if (val >= rdev->desc->n_current_limits)
+			return -EINVAL;
+
+		return rdev->desc->curr_table[val];
+	}
+
+	return -EINVAL;
+}
+
 static const struct regulator_ops max8998_ldo_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
@@ -379,6 +460,15 @@ static const struct regulator_ops max8998_buck_ops = {
 	.set_voltage_time_sel	= max8998_set_voltage_buck_time_sel,
 };
 
+static const struct regulator_ops max8998_charger_ops = {
+	.set_current_limit	= max8998_set_current_limit,
+	.get_current_limit	= max8998_get_current_limit,
+	.is_enabled		= max8998_ldo_is_enabled_inverted,
+	/* Swapped as register is inverted */
+	.enable			= max8998_ldo_disable,
+	.disable		= max8998_ldo_enable,
+};
+
 static const struct regulator_ops max8998_others_ops = {
 	.is_enabled		= max8998_ldo_is_enabled,
 	.enable			= max8998_ldo_enable,
@@ -397,6 +487,19 @@ static const struct regulator_ops max8998_others_ops = {
 		.owner = THIS_MODULE, \
 	}
 
+#define MAX8998_CURRENT_REG(_name, _ops, _table, _reg, _mask) \
+	{ \
+		.name = #_name, \
+		.id = MAX8998_##_name, \
+		.ops = _ops, \
+		.curr_table = _table, \
+		.n_current_limits = ARRAY_SIZE(_table), \
+		.csel_reg = _reg, \
+		.csel_mask = _mask, \
+		.type = REGULATOR_CURRENT, \
+		.owner = THIS_MODULE, \
+	}
+
 #define MAX8998_OTHERS_REG(_name, _id) \
 	{ \
 		.name = #_name, \
@@ -432,6 +535,8 @@ static const struct regulator_desc regulators[] = {
 	MAX8998_OTHERS_REG(ENVICHG, MAX8998_ENVICHG),
 	MAX8998_OTHERS_REG(ESAFEOUT1, MAX8998_ESAFEOUT1),
 	MAX8998_OTHERS_REG(ESAFEOUT2, MAX8998_ESAFEOUT2),
+	MAX8998_CURRENT_REG(CHARGER, &max8998_charger_ops,
+			    charger_current_table, MAX8998_REG_CHGR1, 0x7),
 };
 
 static int max8998_pmic_dt_parse_dvs_gpio(struct max8998_dev *iodev,
diff --git a/include/linux/mfd/max8998.h b/include/linux/mfd/max8998.h
index 061af220dcd3..79c020bd0c70 100644
--- a/include/linux/mfd/max8998.h
+++ b/include/linux/mfd/max8998.h
@@ -39,6 +39,7 @@ enum {
 	MAX8998_ENVICHG,
 	MAX8998_ESAFEOUT1,
 	MAX8998_ESAFEOUT2,
+	MAX8998_CHARGER,
 };
 
 /**
-- 
2.20.1

