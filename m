Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E609C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3817020658
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=biamp.com header.i=@biamp.com header.b="d3/3jCJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgBZBWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:22:04 -0500
Received: from outbound-ip8b.ess.barracuda.com ([209.222.82.190]:34362 "EHLO
        outbound-ip8b.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729376AbgBZBWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:22:03 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174]) by mx8.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 26 Feb 2020 01:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEeIIeHFjrsMAxFSuVA3wDsvL1tsDDeRDB61zfwy97pHpDkpYqBEHp3e/YvulHcEJ+4ehGKpVakC51frm+r/qpcx98WZTEZvmNLfSf/3Vx65TyhryZZ0PBJjG6sg2GHNRoYkKgD/RRxU0YxdYVB56XMsbg4nwc0JHV3QYnTwm4sheI8sYax/1d4usfzpKFlf0+zbRfewhJOsJ5tMbsqggWVaL3NQj+ACPVmufDEUUlM5zhLgMTC3ooDAYMytQdhNLp3RYlNdKjjGjHp+7A1N9uiSHkI8TxtA2qS+B8Fxh0cfgLes0bWKuYdxgU+34isFttLmoPslyXh8YGrH/3inTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSRxDRR3QPnD6JuQNlJ6sV9ISRyrmt4YboW0nA2j284=;
 b=Bc6ViqZblsd6LUn+/Np5dmsXgvlIR1Z17edLVJ6U/ul3MioC+punDRcSxCZsmjWZGfFmXiL8fdY8vKmTBo3FEzUFPVQeUa9Yew4p0qRAX3lMkiVUE72/YNTT4+fVsg1yMlsoOZTwL6GgS2Hq9DgrgSacLKSPaPer17gbpThr9myHN3FmoExWSB2qgKGMUzSEWktqkgTl0cDTooE7ai6zoOpJ+e948BgmK0QEvoCb+zSadYT1ui3m4H3/IYw0C347airkV0o5YsrTq9hrhuyC8DaLxhJV34TCuwuqaC1fbZcKr68geavaEejug/0bWBy6bsRjpuyaNmKxokKaxxZ2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSRxDRR3QPnD6JuQNlJ6sV9ISRyrmt4YboW0nA2j284=;
 b=d3/3jCJcuUPqr4U6SP/RFlYPuqgzvuMWKJuXKD8urgWSpSacNUYujWLQ61f7cV+DJon3OIs5n/23MVmy/6QeAPRxjU8jMZoVGo5anQopw+f6IUM/iE7+GUhQRqUy+ltCEuZEsicfAxDkVaSz8QsHZKMDpnNDykQ1HL1d8TxESaY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shreyas.Joshi@biamp.com; 
Received: from MN2PR17MB3197.namprd17.prod.outlook.com (2603:10b6:208:136::33)
 by MN2PR17MB3855.namprd17.prod.outlook.com (2603:10b6:208:207::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 01:21:56 +0000
Received: from MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::90ed:ec6c:666d:4607]) by MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::90ed:ec6c:666d:4607%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 01:21:56 +0000
From:   Shreyas Joshi <shreyas.joshi@biamp.com>
To:     lee.jones@linaro.org, Support.Opensource@diasemi.com,
        shreyasjoshi15@gmail.com, Adam.Thomson.Opensource@diasemi.com,
        linus.walleij@linaro.org
CC:     linux-kernel@vger.kernel.org,
        Shreyas Joshi <shreyas.joshi@biamp.com>
Subject: [PATCH V6] mfd: da9062: Add support for interrupt polarity defined in device tree
Date:   Wed, 26 Feb 2020 11:21:08 +1000
Message-ID: <20200226012108.361-1-shreyas.joshi@biamp.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <AM6PR10MB22635CBCBF559AEB9A5C2BFF80120@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <AM6PR10MB22635CBCBF559AEB9A5C2BFF80120@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0197.ausprd01.prod.outlook.com
 (2603:10c6:10:16::17) To MN2PR17MB3197.namprd17.prod.outlook.com
 (2603:10b6:208:136::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from D19-03074.biamp.com (203.54.172.50) by SYBPR01CA0197.ausprd01.prod.outlook.com (2603:10c6:10:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 01:21:54 +0000
X-Mailer: git-send-email 2.23.0.windows.1
X-Originating-IP: [203.54.172.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91067b63-cfed-4eeb-0aaa-08d7ba5a4505
X-MS-TrafficTypeDiagnostic: MN2PR17MB3855:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR17MB3855F3DA79E0385DFF4D99E7FCEA0@MN2PR17MB3855.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(346002)(396003)(136003)(366004)(376002)(189003)(199004)(5660300002)(8936002)(81166006)(52116002)(316002)(7696005)(86362001)(6486002)(2906002)(8676002)(81156014)(6666004)(66476007)(44832011)(956004)(2616005)(16526019)(1076003)(26005)(4326008)(478600001)(36756003)(66946007)(186003)(107886003)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR17MB3855;H:MN2PR17MB3197.namprd17.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: biamp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tfzV+BNpmoU0hVcUQxA0LGcmvqGEoXm9++J4QfAJHu76heV7Fodv/o16N61YCPoRwSoMnjsmZyZ6deN7BLxuuRqUX5dJwb9DaZdGwPFN5LvaY6au335htRxuU4faWfaqR4IwK8Rj1X+LJI4nXmxiJCHI0q6nssXEvgaZq808Gp3EprjQ+M5C5G/K2SRM0tTDaTb+hClXnl4vEMrS3EKSNh+JfJWMBKBmQj46aJ5CQ2JmORFA08yKgIC6kTnM5aqrxRWNOeMC1u+UK1nATy4JFON2Z8wGz7mvpVhinEsY/nur5tdfo31d7BncrwvXb9izu4IqL9Ijn97OM9oeakzYrWVlivQ3pjHFEtr3waiOika3eF4QBSpI5n9FIlMjkn4CAxkLtzSBKzqF43j7henOWszABLdz7p28HkVyF95msBSnrN+MNVmQgmHnO0HFbek
X-MS-Exchange-AntiSpam-MessageData: BzTlX8vH5p4ygAbe9k6B7ZtNwBUaiZSsq6zHaQa6ERCbZ37ED/tJGeSfL1q+dvoZkRyK07IGYyTZBjbZWd+GJAcWHzRKRrPAsEqAsJKOY+42eJ/LH7NYT6GegJXwkOtBR6TvLiaC2HlGAsUt/CmvsA==
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91067b63-cfed-4eeb-0aaa-08d7ba5a4505
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 01:21:56.7323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADoZYv6zl7n2lXJP5SHzBykruB1V94YfusxBF8XqnMGQoTHFF8iCCaF9R2v1Fu9funYYnMuk/Vo8p16Nv0oFFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3855
X-BESS-ID: 1582680118-893015-3522-8611-1
X-BESS-VER: 2019.1_20200225.0042
X-BESS-Apparent-Source-IP: 104.47.57.174
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.222511 [from 
        cloudscan19-94.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 MSGID_FROM_MTA_HEADER  META: Message-Id was added by a relay 
        1.50 MSGID_FROM_MTA_HEADER_2 META: Message-Id was added by a relay 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=1.50 using account:ESS74049 scores of KILL_LEVEL=7.0 tests=MSGID_FROM_MTA_HEADER, MSGID_FROM_MTA_HEADER_2, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The da9062 interrupt handler cannot necessarily be low active.
Add a function to configure the interrupt type based on what is defined in =
the device tree.
The allowable interrupt type is either low or high level trigger.

Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
---

V6:
  Changed regmap_reg_range to exclude DA9062AA_CONFIG_B for writeable
  Added regmap_reg_range DA9062AA_CONFIG_A for readable

V5:
  Added #define for DA9062_IRQ_HIGH and DA9062_IRQ_LOW=20

V4:
  Changed return code to EINVAL rather than EIO for incorrect irq type
  Corrected regmap_update_bits usage
 =20
V3:
  Changed regmap_write to regmap_update_bits

V2:
  Added function to update the polarity of CONFIG_A IRQ_TYPE
 =20
 drivers/mfd/da9062-core.c | 44 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 419c73533401..fc30726e2e27 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -21,6 +21,9 @@
 #define	DA9062_REG_EVENT_B_OFFSET	1
 #define	DA9062_REG_EVENT_C_OFFSET	2
=20
+#define	DA9062_IRQ_LOW	0
+#define	DA9062_IRQ_HIGH	1
+
 static struct regmap_irq da9061_irqs[] =3D {
 	/* EVENT A */
 	[DA9061_IRQ_ONKEY] =3D {
@@ -369,6 +372,33 @@ static int da9062_get_device_type(struct da9062 *chip)
 	return ret;
 }
=20
+static u32 da9062_configure_irq_type(struct da9062 *chip, int irq, u32 *tr=
igger)
+{
+	u32 irq_type =3D 0;
+	struct irq_data *irq_data =3D irq_get_irq_data(irq);
+
+	if (!irq_data) {
+		dev_err(chip->dev, "Invalid IRQ: %d\n", irq);
+		return -EINVAL;
+	}
+	*trigger =3D irqd_get_trigger_type(irq_data);
+
+	switch (*trigger) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_type =3D DA9062_IRQ_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_type =3D DA9062_IRQ_LOW;
+		break;
+	default:
+		dev_warn(chip->dev, "Unsupported IRQ type: %d\n", *trigger);
+		return -EINVAL;
+	}
+	return regmap_update_bits(chip->regmap, DA9062AA_CONFIG_A,
+			DA9062AA_IRQ_TYPE_MASK,
+			irq_type << DA9062AA_IRQ_TYPE_SHIFT);
+}
+
 static const struct regmap_range da9061_aa_readable_ranges[] =3D {
 	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
 	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C),
@@ -388,6 +418,7 @@ static const struct regmap_range da9061_aa_readable_ran=
ges[] =3D {
 	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
 	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
 	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
+	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_A),
 	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
@@ -417,6 +448,7 @@ static const struct regmap_range da9061_aa_writeable_ra=
nges[] =3D {
 	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
 	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
 	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
+	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_A),
 	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
@@ -596,6 +628,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct regmap_irq_chip *irq_chip;
 	const struct regmap_config *config;
 	int cell_num;
+	u32 trigger_type =3D 0;
 	int ret;
=20
 	chip =3D devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
@@ -654,10 +687,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
=20
+	ret =3D da9062_configure_irq_type(chip, i2c->irq, &trigger_type);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to configure IRQ type\n");
+		return ret;
+	}
+
 	ret =3D regmap_add_irq_chip(chip->regmap, i2c->irq,
-			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
-			-1, irq_chip,
-			&chip->regmap_irq);
+			trigger_type | IRQF_SHARED | IRQF_ONESHOT,
+			-1, irq_chip, &chip->regmap_irq);
 	if (ret) {
 		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
 			i2c->irq, ret);
--=20
2.20.1

