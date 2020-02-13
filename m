Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7682C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6102173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=biamp.com header.i=@biamp.com header.b="LSWtt3CP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgBMFkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 00:40:02 -0500
Received: from outbound-ip8a.ess.barracuda.com ([209.222.82.175]:48724 "EHLO
        outbound-ip8a.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbgBMFkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:40:02 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102]) by mx14.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 13 Feb 2020 05:39:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKMb/dl+05HRAz+gsjWM9pfHX9HC44uk2DmdMcc/Eo1XZ+28uegfGvD3mkf63CAnpLHGfISsClFgzZkKr1ron4+73aT/dnBRD+jkHrgJn162mxNlx343KxU2rRRee2qKVR1zjFl6lYcLrq92tYnhkCIZoYdGp5qd5VsHB8FkYGADzpRPlky8sJz+XnhOmMKHq92D2aSKxDeQUw4Vz83vSZ9Z3jK/CmX9GbFmGUxYVIIzyz0qMt2NZ49DtECUVpQ37Rn5QUoNk/PhWfpi10E8WZL+Kr3rvNwC4DZeIh8ma0Xb8uH3hVCgi7KK47yBVLyqjUZMxrs5oLF403VSw/i11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl6t5HfOm1YayZGWCwUlDuRgRITtvlyLmht5oJcL6hU=;
 b=T0Yc2ua5ubsW5EoHDh58DxH2MyjUuvssfvkbBeeMJ/JzMrmujH/o44VpuaDS5qF3xgQZJKfP5ebMZz9C/f59JSW3zICh6B7PP3wqpJbeqjmJjcSelnrLbbM8k6gOkK5Tu+DQBjlOmMTs8tEXkQdck4Z9LgU8a5hkcKaWyn6pcW0JNNqI2V6JRg8kFJCxzHifBRMs2e4ymNJjG8e+0Ui2a5efJ/4Vk8BW8WYqE8OFKrpiuEE0iYMnUIdhefXn/qFqK1RZlDlQ7HALLisOP8JLalvceoyIzHYkZmnFyWsXCq9oJ4mwjGPT78Ycqrghl3n+53+5Mh3x1N5NRfyuXutTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl6t5HfOm1YayZGWCwUlDuRgRITtvlyLmht5oJcL6hU=;
 b=LSWtt3CP/kuFPDSDRTF200Az3zf2DFM5E4cmyVv6KeSjVoGE0SBo6XVDitFonhul5g79hxP9iDVRX+k2ppEdH5pVkviZIXmcRWkq3V9weOuVZks1mDeGDywCICH7n8ATnLkC3t1dMeMKRpUVbwsUbvdoLHQ9zeRaQ79Issv+m8c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shreyas.Joshi@biamp.com; 
Received: from MN2PR17MB3197.namprd17.prod.outlook.com (20.179.149.225) by
 MN2PR17MB2735.namprd17.prod.outlook.com (20.178.245.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 05:39:55 +0000
Received: from MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::90ed:ec6c:666d:4607]) by MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::90ed:ec6c:666d:4607%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 05:39:54 +0000
Date:   Wed, 12 Feb 2020 21:39:43 -0800
From:   Shreyas Joshi <shreyas.joshi@biamp.com>
To:     lee.jones@linaro.org, Support.Opensource@diasemi.com,
        shreyasjoshi15@gmail.com, Adam.Thomson.Opensource@diasemi.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V4] mfd: da9062: add support for interrupt polarity defined
 in device tree
Message-ID: <20200213053943.kxss6vvhi3jacfpw@shreyas_biamp.biamp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: SY2PR01CA0038.ausprd01.prod.outlook.com
 (2603:10c6:1:15::26) To MN2PR17MB3197.namprd17.prod.outlook.com
 (2603:10b6:208:136::33)
MIME-Version: 1.0
Received: from shreyas_biamp.biamp.com (203.54.172.54) by SY2PR01CA0038.ausprd01.prod.outlook.com (2603:10c6:1:15::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Thu, 13 Feb 2020 05:39:53 +0000
X-Originating-IP: [203.54.172.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f074cde7-c68a-47ba-d9b3-08d7b0472755
X-MS-TrafficTypeDiagnostic: MN2PR17MB2735:
X-Microsoft-Antispam-PRVS: <MN2PR17MB2735415FEFD6ED9911B76162FC1A0@MN2PR17MB2735.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39850400004)(396003)(136003)(346002)(366004)(199004)(189003)(5660300002)(2906002)(4326008)(16526019)(1076003)(26005)(186003)(55016002)(478600001)(8676002)(81156014)(81166006)(7696005)(52116002)(66556008)(66476007)(66946007)(8936002)(86362001)(44832011)(6666004)(316002)(956004);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR17MB2735;H:MN2PR17MB3197.namprd17.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: biamp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cIqQvcNuRsuFDIGPkn2Sl9AvAk6CeKeK7uCZwU0F9WpiDROd+DGoFe0zzAvqOVfp/4hEeXWWvxR0ErolNlJd3QITlHSg0mn8DNVu8q14t/8HF6w8KKDWFLDlNMYFU3rdTpuB5XQzpHPOCHubGaycoJCXyBs4xI/ERZGX6uqBzmIe7GmNzb28Hu35B3p7hGe3IqncrwxQ5r4LAjgP2o3YxwE9X4MfMXAWe4gSwZz26zQDBovhjt37I/eDgx1VOhTz57P+oH2CXf2C7G+QE9dzEvAxvQsDA8yYfuJAUb3PvroHfAqTQMYSqhv4OQJFNf2OO3OfaJ+cq28SqnZ5ZD4SxLGptNeDRbzvSPA1LueBprfXWYYFAhl9hCJv1yTYrv9PluNrpp4r1PwXMwzPuK1P5xQbAAiIgaCmfb4TVsOCRMrO07TpzdTBSPxu4HZp8hV
X-MS-Exchange-AntiSpam-MessageData: ER2CRPBctkM8aIWHfOknqu2cbmpTfP4WqR/T509KFoCk6kJ3xQmAlgWsHWFaXCxvdgiIhOjpI/uyaC3XaUDwc6RuavoeR87NXkjFogYnn2P4bo1eKUnPnvu4iAE5/z6i1v8GInuQyRDYj6VlV7tAcg==
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f074cde7-c68a-47ba-d9b3-08d7b0472755
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 05:39:54.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXty4+TSih0lypnVKnL0vhzkXRD0xd6uupxL/7aa8Vk8NjVbqjYpco9HCbeXSXpbBn69eiS3NhkP+y3oqati9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB2735
X-BESS-ID: 1581572397-893026-12789-7192-1
X-BESS-VER: 2019.1_20200212.2352
X-BESS-Apparent-Source-IP: 104.47.58.102
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.222219 [from 
        cloudscan12-126.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 MSGID_FROM_MTA_HEADER  META: Message-Id was added by a relay 
        1.50 MSGID_FROM_MTA_HEADER_2 META: Message-Id was added by a relay 
X-BESS-Outbound-Spam-Status: SCORE=1.50 using account:ESS74049 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MSGID_FROM_MTA_HEADER, MSGID_FROM_MTA_HEADER_2
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The da9062 interrupt handler cannot necessarily be low active.
Add a function to configure the interrupt type based on what is defined in the device tree.
The allowable interrupt type is either low or high level trigger.

Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
---
 drivers/mfd/da9062-core.c | 40 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 419c73533401..6d9b60cb745d 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -369,6 +369,33 @@ static int da9062_get_device_type(struct da9062 *chip)
 	return ret;
 }
 
+static u32 da9062_configure_irq_type(struct da9062 *chip, int irq, u32 *trigger)
+{
+	u32 irq_type = 0;
+	struct irq_data *irq_data = irq_get_irq_data(irq);
+
+	if (!irq_data) {
+		dev_err(chip->dev, "Invalid IRQ: %d\n", irq);
+		return -EINVAL;
+	}
+	*trigger = irqd_get_trigger_type(irq_data);
+
+	switch (*trigger) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_type = 1;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_type = 0;
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
 static const struct regmap_range da9061_aa_readable_ranges[] = {
 	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
 	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C),
@@ -417,6 +444,7 @@ static const struct regmap_range da9061_aa_writeable_ranges[] = {
 	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
 	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
 	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
+	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_B),
 	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
@@ -596,6 +624,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct regmap_irq_chip *irq_chip;
 	const struct regmap_config *config;
 	int cell_num;
+	u32 trigger_type = 0;
 	int ret;
 
 	chip = devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
@@ -654,10 +683,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
 
+	ret = da9062_configure_irq_type(chip, i2c->irq, &trigger_type);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to configure IRQ type\n");
+		return ret;
+	}
+
 	ret = regmap_add_irq_chip(chip->regmap, i2c->irq,
-			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
-			-1, irq_chip,
-			&chip->regmap_irq);
+			trigger_type | IRQF_SHARED | IRQF_ONESHOT,
+			-1, irq_chip, &chip->regmap_irq);
 	if (ret) {
 		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
 			i2c->irq, ret);
-- 
2.20.1

