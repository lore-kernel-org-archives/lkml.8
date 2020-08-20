Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F0EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BACA207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="CoU4S+pE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHTJTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:19:04 -0400
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:4192
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726749AbgHTJSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:18:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjSy3e99Mp5cAg6W5o4YCfxr/L6QvBo+AwPbbnepLigfv5+cpafeCQPZifFFg0hvTv4PAYrnLuc7twASdSAV8Kb5r+C5sMkobdh9uY4VCoakTurQOr7csGzOL/DvgqM8Q8HCNGlxbUNzBiy4VUGIqlWz9OzJEvwSVdEWeKLcL5sFuYiFEm1RzuOXuZU5oddv64y2ouFpw+YsQsO3XDSF1xpXLtyEK9zow79yWDNWh1QJvpEpnudUogU+kILoxKgSUaHtIpgqyXI01C4CTU5qGyU845vr15Cq9igPvIKfjwgjH9/vnosqqhTjB6ae3uoWzGAvun4NZ5b6AmQkgzXrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hmJAE5UypAbrxuyGNX+5sB2bkmKsErS+K23OirHL/g=;
 b=IcPJvCb11nDDjLD1wXegU6TdM/BvapjEMvyLyzcvudb5N6rU72BP1Hu9x+i1Opjbb+O7wJliJOeI9G3wJMAmuazZMgW6N9HTQTN/HgQfnW3PjGVpv76h1gqufi6ZM749frsP5hUZ6jeJFS8BiO+EveFUkTln3fkTBp24LqQOFLy1TS3IjxfUfl6JfnSazsbyz/wz0c7nX5z808Zs9sLSqjStlp5OsDaHjDC3UT2Ls+SzF1sTuvmMBq6VPmTkcWox9yrYCKSaaJuIlRJuNdDChpDYbAqO1sN1dGxPcNn3QRqFMQQ9WJbEwe9VRnrHbAQHMme57u+RhAbUVoG34oj8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hmJAE5UypAbrxuyGNX+5sB2bkmKsErS+K23OirHL/g=;
 b=CoU4S+pEuIaR/Y8tEoEvRGg/1KgEIKKGjbXmnGkhPtba2PHU71tfhtOzN/0DrpcMNQpVxPp6Jb5OJEQbQNzUvzXxXVI2KDm1/0XnJfGaljEM9+VhioKQlDj9PtpGltLpqvsUvg9c0iObA7gunwjRSsoy2Irw39qKzwc7U0NSr28=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN8PR03MB4738.namprd03.prod.outlook.com (2603:10b6:408:6d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 09:17:14 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 09:17:14 +0000
Date:   Thu, 20 Aug 2020 17:10:51 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/4] regulator: mp886x: implement set_ramp_delay
Message-ID: <20200820171051.55a238e8@xhacker.debian>
In-Reply-To: <20200820171020.5df4683b@xhacker.debian>
References: <20200820171020.5df4683b@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:404:14::27) To BN7PR03MB4547.namprd03.prod.outlook.com
 (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TYAPR03CA0015.apcprd03.prod.outlook.com (2603:1096:404:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 09:17:11 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7c49669-31d6-4402-b4df-08d844e9d38a
X-MS-TrafficTypeDiagnostic: BN8PR03MB4738:
X-Microsoft-Antispam-PRVS: <BN8PR03MB473838E83CA62B236D055723ED5A0@BN8PR03MB4738.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TopOt1hTUzDHMZahIiOKvRTs5Zc0RJR325cpJuUZg2MNUfYX4wyDho98/TrptYI84d616UknZMmN6QydEENeaCP7VbrCED3OJaIFhhpDyW/cB0bOB7OcpiXfaRjVcr1dQQG3H+OkU7ClUX9dxY5ZumRsteUc4GsCmkgdpIZcwn6SdwnujQxJgaDyUMgdsK0iWHmbDvwM7XdVucDBpUQK1mbxgNpAuR11Z1BaDg0oNID3f920fz64tI5Yuooz9GWoZQvc13N60wkLBTRUD5Tc95jJi5XwqiZ9e9gLpyCeTMUidHqHTsfZYrsu1LFNuCAVQph8QeSpQLG0VOqLMCmSyn4aPw0ULp8WEHo6NkAWdIWJ4KabkHDIi/pUOhzgp8+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(376002)(136003)(316002)(2906002)(110136005)(66476007)(6486002)(66556008)(66946007)(110011004)(16576012)(4326008)(8676002)(478600001)(5660300002)(26005)(86362001)(9686003)(6666004)(52116002)(956004)(186003)(1076003)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wo9xPt+GcWbhPV7KOIXZ0sMvNjgaAkc/Wq9fZQCpJ+s+/kkY7wgisp8YWWQg7+fQxiCcfQa6srtU47oWB/3IiIqmq6nwDYK3IOwtMnLu7cFAobhwxln1R4qaj5U+SSTtkuWf9BRqfU5xaqrgIT/l8sKH0KG5ssW6kPWH8j/g+lBZGEJ0AeKB7l2ADjYOb/FBndrVTgawxbR3EGo4n4hy/oW9y1Sde9Qagu9Da1CLebhVcB20+aw3ukQwZCTQM5zQz0zmJJxF7rCv194EX3LtTsYU/NFD8TlGOw4shBus82tIdy4F5icZNZGDM/ih7xp1d9ZvKqs+ZfPmmEA4kRftNmzrRgjSc0MTBTCD30medugo4Vss9JwvFdF76/TLa0XeSf5yWbK8Jun7DzoHfRWpIRt7YE6uqFKBRrT8StEpMCuti21fJwTriodAq1aFgxB1d7EUGNXFkFRsYWE9CS6e+k7e7F0021oKS09J8J+g67+Ev/ZF8dIpt9hxWRMymksVe4a2/qWQf0YsYztfmuvG5wRvGLKvRic4W0oQmKsca2FXHQ6k1jAiEZgc66BEO32Xybm07OAvIIxP5R3lF6znGMtUgw8qeZ2Wmj0KneLg9qWGOzK9fhgxncY1eh9UUDgasNHjGbVrrFzXf7H6Hi2vyg==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c49669-31d6-4402-b4df-08d844e9d38a
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 09:17:14.3764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szaplZKJZFEyOrY536KvBj8+nM69k3FKJPUEOool3cFVh9tnvwPenVhFzzzvBEGizDernftUhahpxPD34TlvmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the .set_ramp_delay for MP8867 and MP8869. MP8867 and MP8869
could share the implementation, the only difference is the slew_rates
array.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/mp886x.c | 67 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
index d3d475f717f4..1305bf217df1 100644
--- a/drivers/regulator/mp886x.c
+++ b/drivers/regulator/mp886x.c
@@ -18,18 +18,48 @@
 #define  MP886X_V_BOOT		(1 << 7)
 #define MP886X_SYSCNTLREG1	0x01
 #define  MP886X_MODE		(1 << 0)
+#define  MP886X_SLEW_SHIFT	3
+#define  MP886X_SLEW_MASK	(0x7 << MP886X_SLEW_SHIFT)
 #define  MP886X_GO		(1 << 6)
 #define  MP886X_EN		(1 << 7)
 
+struct mp886x_cfg_info {
+	const struct regulator_ops *rops;
+	const int slew_rates[8];
+};
+
 struct mp886x_device_info {
 	struct device *dev;
 	struct regulator_desc desc;
 	struct regulator_init_data *regulator;
 	struct gpio_desc *en_gpio;
+	const struct mp886x_cfg_info *ci;
 	u32 r[2];
 	unsigned int sel;
 };
 
+static int mp886x_set_ramp(struct regulator_dev *rdev, int ramp)
+{
+	struct mp886x_device_info *di = rdev_get_drvdata(rdev);
+	const struct mp886x_cfg_info *ci = di->ci;
+	int reg = -1, i;
+
+	for (i = 0; i < ARRAY_SIZE(ci->slew_rates); i++) {
+		if (ramp <= ci->slew_rates[i])
+			reg = i;
+		else
+			break;
+	}
+
+	if (reg < 0) {
+		dev_err(di->dev, "unsupported ramp value %d\n", ramp);
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(rdev->regmap, MP886X_SYSCNTLREG1,
+				  MP886X_SLEW_MASK, reg << MP886X_SLEW_SHIFT);
+}
+
 static int mp886x_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	switch (mode) {
@@ -117,6 +147,21 @@ static const struct regulator_ops mp8869_regulator_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.set_mode = mp886x_set_mode,
 	.get_mode = mp886x_get_mode,
+	.set_ramp_delay = mp886x_set_ramp,
+};
+
+static const struct mp886x_cfg_info mp8869_ci = {
+	.rops = &mp8869_regulator_ops,
+	.slew_rates = {
+		40000,
+		30000,
+		20000,
+		10000,
+		5000,
+		2500,
+		1250,
+		625,
+	},
 };
 
 static int mp8867_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
@@ -173,6 +218,21 @@ static const struct regulator_ops mp8867_regulator_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.set_mode = mp886x_set_mode,
 	.get_mode = mp886x_get_mode,
+	.set_ramp_delay = mp886x_set_ramp,
+};
+
+static const struct mp886x_cfg_info mp8867_ci = {
+	.rops = &mp8867_regulator_ops,
+	.slew_rates = {
+		64000,
+		32000,
+		16000,
+		8000,
+		4000,
+		2000,
+		1000,
+		500,
+	},
 };
 
 static int mp886x_regulator_register(struct mp886x_device_info *di,
@@ -183,7 +243,7 @@ static int mp886x_regulator_register(struct mp886x_device_info *di,
 
 	rdesc->name = "mp886x-reg";
 	rdesc->supply_name = "vin";
-	rdesc->ops = of_device_get_match_data(di->dev);
+	rdesc->ops = di->ci->rops;
 	rdesc->type = REGULATOR_VOLTAGE;
 	rdesc->n_voltages = 128;
 	rdesc->enable_reg = MP886X_SYSCNTLREG1;
@@ -234,6 +294,7 @@ static int mp886x_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(di->en_gpio))
 		return PTR_ERR(di->en_gpio);
 
+	di->ci = of_device_get_match_data(dev);
 	di->dev = dev;
 
 	regmap = devm_regmap_init_i2c(client, &mp886x_regmap_config);
@@ -258,11 +319,11 @@ static int mp886x_i2c_probe(struct i2c_client *client)
 static const struct of_device_id mp886x_dt_ids[] = {
 	{
 		.compatible = "mps,mp8867",
-		.data = &mp8867_regulator_ops
+		.data = &mp8867_ci
 	},
 	{
 		.compatible = "mps,mp8869",
-		.data = &mp8869_regulator_ops
+		.data = &mp8869_ci
 	},
 	{ }
 };
-- 
2.28.0

