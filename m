Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3559BC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DF820720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=biamp.com header.i=@biamp.com header.b="FcgPKaa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgBFHbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 02:31:45 -0500
Received: from outbound-ip13a.ess.barracuda.com ([209.222.82.180]:53320 "EHLO
        outbound-ip13a.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727904AbgBFHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:31:44 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100]) by mx9.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 06 Feb 2020 07:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvZznWNHqSx7C7vUwKxDD4+zOun/F0mCCc2d4vnMOIceLCkHaiA5IbI7syqUkV1ld4xSOsF5kFgcnLxtR+1UHKzrO/QL2R7ZA3BwEER3oop2AEBr21vkGHg5OlS3ag7otS8d/cyzT4yRQhT1oV/5+YJL4WKXYwZd48aN/hX0Sp1vNh5jsIEIok4q+7wrg+iznYtmyxWtQpkD/nRx+R18jymzwLFh/aPow4OEw7634PCYZt8QbQw6oQp+TRMH7oaMxnMYIl54dhEusvopXtMPiqjtB3mk6hzBh0cX6U3q0ZgA01mRyESPnKd8ZKmJ/cf/s0v8ezi3RCSdcgf6lKCFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Lc5zgOprsZCj8hOfATscSxJx8QZu6/vevtKzfe7pG8=;
 b=iVR2+/VfaZhE+wI8W9AhhiqHb6sHW2nruTcKjKCwx4YUbDAJPeuYZJWo5fS9XxsVZFrJU6MEBsqq3QH1wTcV8T6vZ9Uv43KbsaqtAEcHVzF1WEjYUF77Eyt99eRMtZ8hITgYmnXKjOpF9RWQgfFxQoD8XkOG8jc9NPRQVmSsIwDoATc4jSso6n7o5Gqa0YAzcyIbfTWLyeNDpyjaDck+auhJkkDQCFeXb5uyBGOT6qbNHkEuyGzofvHllo6bzF+xwKwVyd02bwfGgLHGluEvDzGE7Iga8+xqf2Ah+4dsYFPfTZNFKjzvP6qEdH2b4bfWfZAHVuc74+mGdhI5I4F2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Lc5zgOprsZCj8hOfATscSxJx8QZu6/vevtKzfe7pG8=;
 b=FcgPKaa6fN7LC0QomzTX19EPF8DMdJr5HQ8WDNfNPWedxVpIN/w8/0rZLl0yFFQIoPExTr1dNI8VlGEGfQgH45576MP2ml/jwepR+btAjJL/UzTvea8H/SVupeChsaSXcnivG6HOBY5loLb2Z1VU6arzh4rIHTf6cI6uWAQyz1g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shreyas.Joshi@biamp.com; 
Received: from MN2PR17MB3197.namprd17.prod.outlook.com (20.179.149.225) by
 MN2PR17MB3581.namprd17.prod.outlook.com (52.135.39.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 6 Feb 2020 07:31:36 +0000
Received: from MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::90ed:ec6c:666d:4607]) by MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::90ed:ec6c:666d:4607%4]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 07:31:36 +0000
Date:   Wed, 5 Feb 2020 23:31:26 -0800
From:   Shreyas Joshi <shreyas.joshi@biamp.com>
To:     lee.jones@linaro.org, Support.Opensource@diasemi.com,
        shreyasjoshi15@gmail.com, Adam.Thomson.Opensource@diasemi.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V3] mfd: da9062: add support for interrupt polarity defined
 in device tree
Message-ID: <20200206073126.zf3ahv3b3lafctcn@shreyas_biamp.biamp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: SY3PR01CA0091.ausprd01.prod.outlook.com
 (2603:10c6:0:19::24) To MN2PR17MB3197.namprd17.prod.outlook.com
 (2603:10b6:208:136::33)
MIME-Version: 1.0
Received: from shreyas_biamp.biamp.com (203.54.172.54) by SY3PR01CA0091.ausprd01.prod.outlook.com (2603:10c6:0:19::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend Transport; Thu, 6 Feb 2020 07:31:34 +0000
X-Originating-IP: [203.54.172.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1ef0e83-5af3-486f-3fb1-08d7aad698ce
X-MS-TrafficTypeDiagnostic: MN2PR17MB3581:
X-Microsoft-Antispam-PRVS: <MN2PR17MB35814435AEAE23091A3F7112FC1D0@MN2PR17MB3581.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(39850400004)(396003)(366004)(199004)(189003)(4326008)(52116002)(7696005)(8936002)(86362001)(956004)(8676002)(81156014)(81166006)(55016002)(478600001)(6666004)(1076003)(316002)(66476007)(66946007)(2906002)(66556008)(5660300002)(44832011)(16526019)(26005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR17MB3581;H:MN2PR17MB3197.namprd17.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: biamp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAOP6tfUKYjvGrtmJwfm/AmxV1ukKpIQJkUQrQ1ZNkdkM2q2OX9liXfzbz8/BLVXPNgf3/03RiqQA4jsniKN5O0E5xmL0D2P8gZ5lKTGRN7Gk7rxns0IWewJxi9GVuswBgBeniyhpoE54aEIf5cJvbTRr96l4cAxqE4MPi1NwcRzU29LB/t/rRW9DRKex1yQZ9ATSeNZ1pPvLLuTFIMQAiJqcQG56QUDs9sAcuxURdj3E5Fqet4hpJdsKMC0NiCDJBC17gSKWty3t8AimfdfZl+rljk5YLl6LIzf2FRwU/J0MFNxUw72EPl0GH4TtOsWgqhAEKbnPzuxwRTHaONuOfgZAILVxqJdWgaZ+cYModVD1YsqiEgCfCxf4/n7RomOPzGeTgDDx+z8qEhqc+KieEB05xwiUFGHKVWBCSbyoFEKqD9vMqti5NctAzFpr+hK
X-MS-Exchange-AntiSpam-MessageData: +qZMHPbbYe0M+fE9guIEbDtK5zE3/p6wRO2YI4LFvy6FxTe9spaed+YdcJlzLWeaNhL7QJIuRWOTdr8qBRZrjqkJIHe0jjemWv5wBqNqnTa45ItMEf8iG8zJz9gquuqnpCC/RZ1EiWxs9Em/N+feCQ==
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ef0e83-5af3-486f-3fb1-08d7aad698ce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 07:31:36.1630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQTCLBBkpKXKfq9+1Py83egZUgwHydEHaxhKkdpqP+LJXpvdzu8JceCeWl+L8WrglcbOvdT+R3B515iyTsHHHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3581
X-BESS-ID: 1580974298-893016-32019-11219-1
X-BESS-VER: 2019.1_20200205.2123
X-BESS-Apparent-Source-IP: 104.47.55.100
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.222125 [from 
        cloudscan12-123.us-east-2a.ess.aws.cudaops.com]
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
Add a function to configure the interrupt type based on what is defined in the
device tree. The allowable interrupt type is either low or high level trigger.

Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
---
 drivers/mfd/da9062-core.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 419c73533401..c44a48ba3d05 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -369,6 +369,32 @@ static int da9062_get_device_type(struct da9062 *chip)
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
+		return -EIO;
+		}
+	return regmap_update_bits(chip->regmap, DA9062AA_CONFIG_A,
+			DA9062AA_IRQ_TYPE_MASK, irq_type);
+}
+
 static const struct regmap_range da9061_aa_readable_ranges[] = {
 	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
 	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C),
@@ -417,6 +443,7 @@ static const struct regmap_range da9061_aa_writeable_ranges[] = {
 	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
 	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
 	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
+	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_B),
 	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
@@ -596,6 +623,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct regmap_irq_chip *irq_chip;
 	const struct regmap_config *config;
 	int cell_num;
+	u32 trigger_type = 0;
 	int ret;
 
 	chip = devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
@@ -654,10 +682,14 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
 
+	if (da9062_configure_irq_type(chip, i2c->irq, &trigger_type) < 0) {
+		dev_err(chip->dev, "Failed to configure IRQ type\n");
+		return -EINVAL;
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

