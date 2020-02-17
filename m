Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0803BC3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 00:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD18A20726
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 00:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=biamp.com header.i=@biamp.com header.b="RQKtv1AK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgBQAog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 19:44:36 -0500
Received: from outbound-ip8b.ess.barracuda.com ([209.222.82.190]:39908 "EHLO
        outbound-ip8b.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbgBQAog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 19:44:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107]) by mx10.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 17 Feb 2020 00:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko1N6MDNJtsBPUmMAEg4StBPcm/qMpD/WpIw2cQPKYgniPuzA0QCtuvSTX9pBGDEXxU/kl3nQ22QA8sf2VJmvOQ469YHbeI7qclKPwUTZloep9pM2uuo8jbTBlz4CLCM32gE8138MhOcp2wpA0fMZ5xdP/uBVjbRD9cqmJnm4VU2NONqltPuE51zLAdLrKqfsfG16pf/DV2Y2Z4ucZDQzOQk8FUTAeIYdDBOBl25K8N8DUlm1GCcp07wY+W4PnpQTV+qG+tTBgLpjgqx7whkTdB1wWjCxEG4gadGhUVtrHSVgSHoP5O9vEOIhPu7NJZptSkaxzSsY8B/3bgBIVNBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1/wHtIBKCX6ReK45gmqk1RTYj390NvdRaDD8u1KDsA=;
 b=kZfv/sWR8MLORA3R0UG/zO+Kqq48TB7GYrxWtHRUVHp4PywZyXeug3U7rbrfMki9b/hC1uytwVeU1ANiTIQSkOI8/S9Y1u9pYOttDmviKT6BTi0goBtEF/cYWF/IgsDJ9ADjlULUCDn15023s2yAh4H9fHzQPiT0sYqkUfvFSc88YkRpc0EkCJNQsbXWkxgQ8Eq8QxgkDdpi/0/SMWpsuTS96l0oYDiGfm2Wk3kj8hM0LoLJMdJtdL1lcYOLO4UggeYgyy3efQVRy9XFQOKL1Uzh2dnZtwBoVmZkOgsgKR2wDuBE+WR9W7V5R8Hd9gxddD0HHdeduRnS1N4+yhTPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1/wHtIBKCX6ReK45gmqk1RTYj390NvdRaDD8u1KDsA=;
 b=RQKtv1AKSMftc0zPSJjbljulZN2UKpTRaIA84+wn3tum+DaGeTciG81vwaegFgRmwI/qqZF9Av0EXRfTnthszJOwTeWBdtF5idmd6gSKWBFPi7zkyJpIB4VXbK6gueKhvQMIdZ4yC25w2pGCVJDTWARSYkZ0xx8qvn594wnPEBA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shreyas.Joshi@biamp.com; 
Received: from MN2PR17MB3197.namprd17.prod.outlook.com (20.179.149.225) by
 MN2PR17MB3421.namprd17.prod.outlook.com (52.135.39.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Mon, 17 Feb 2020 00:44:27 +0000
Received: from MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::90ed:ec6c:666d:4607]) by MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::90ed:ec6c:666d:4607%4]) with mapi id 15.20.2729.031; Mon, 17 Feb 2020
 00:44:26 +0000
Date:   Sun, 16 Feb 2020 16:44:16 -0800
From:   Shreyas Joshi <shreyas.joshi@biamp.com>
To:     lee.jones@linaro.org, Support.Opensource@diasemi.com,
        shreyasjoshi15@gmail.com, Adam.Thomson.Opensource@diasemi.com,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V5] mfd: da9062: add support for interrupt polarity defined
 in device tree
Message-ID: <20200217004416.lhbl7rzvaf5q4fbz@shreyas_biamp.biamp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: SYYP282CA0009.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::19) To MN2PR17MB3197.namprd17.prod.outlook.com
 (2603:10b6:208:136::33)
MIME-Version: 1.0
Received: from shreyas_biamp.biamp.com (203.54.172.54) by SYYP282CA0009.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:b4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Mon, 17 Feb 2020 00:44:24 +0000
X-Originating-IP: [203.54.172.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 550b0598-60ce-4faa-ff6d-08d7b34289f4
X-MS-TrafficTypeDiagnostic: MN2PR17MB3421:
X-Microsoft-Antispam-PRVS: <MN2PR17MB3421B227E2EFB29DCD4168FCFC160@MN2PR17MB3421.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0316567485
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(39840400004)(376002)(136003)(366004)(189003)(199004)(7696005)(52116002)(478600001)(2906002)(5660300002)(66556008)(316002)(81156014)(8676002)(81166006)(86362001)(8936002)(55016002)(26005)(66476007)(44832011)(186003)(4326008)(1076003)(66946007)(956004)(16526019)(6666004);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR17MB3421;H:MN2PR17MB3197.namprd17.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: biamp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzpVwr3P3icaTc1PnL3pVNyZohwJ8oIubetMgBkIwcdg+QKOaFPZAowmY/8Wr4VT+hxSpYTu3rlo7Tv2WwSmgB+IwGhDnkwnUcXzynTtcmFMuC2gle7JoOZDkM/UcMeUB4tm/4zRblRMoGX0G4ljIDafnFbI6G2Lz0Vw+A7s0rlWaTL7fn9c6WeOw1AoEcPqHexlV/1tZ+LdeQbAoYt9g6d47Imonfp0T4utuVt1cjq/DyrgoFe8OANoIZpJfjzKorxmWCQuHAjCgLaZIpRcvloKLtbnU3OLCOg3qiiyxRrKUG5X8Iazb0fufxLaBwd9WVv5o63EKajM5wSQzSgL7Wh0M4881N5gYwDKIvl4+QJNUdPhPzQNe5JRvzZ4xiE0VMTP64FU2WdkHJ9RHLuaVh+fd8qtlCiAU+kExs1q9qY8iFXebRkMFAoTvT59K2dc
X-MS-Exchange-AntiSpam-MessageData: HryX9wEbgqd+mEUopW3PjSmD+IaGJCBgiIqL2bQBPAqzyMaSl2eozzzWAOValOKTpvY5aI+F8y8gWVdks+N+gDePEWMlhs6L/OrwrRprmfZq01IdAVG+xrJ17tBM3w77/NqAfG2v6mCPxJOvi3sFOA==
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550b0598-60ce-4faa-ff6d-08d7b34289f4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2020 00:44:26.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eBq3K+oefhM0fk+oa8dXi8NDz1gMsbuAAzv1kuOLRasf/J/Qu0CdlYpYvtj3dD5UbpjV4FfO4cP4gk1jbgEQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3421
X-BESS-ID: 1581900270-893019-15164-49924-1
X-BESS-VER: 2019.1_20200214.2117
X-BESS-Apparent-Source-IP: 104.47.58.107
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.222310 [from 
        cloudscan11-192.us-east-2a.ess.aws.cudaops.com]
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
Add a function to configure the interrupt type based on what is defined in the device tree.
The allowable interrupt type is either low or high level trigger.

Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
---
 drivers/mfd/da9062-core.c | 43 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 419c73533401..cd3c4c80699e 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -21,6 +21,9 @@
 #define	DA9062_REG_EVENT_B_OFFSET	1
 #define	DA9062_REG_EVENT_C_OFFSET	2
 
+#define	DA9062_IRQ_LOW	0
+#define	DA9062_IRQ_HIGH	1
+
 static struct regmap_irq da9061_irqs[] = {
 	/* EVENT A */
 	[DA9061_IRQ_ONKEY] = {
@@ -369,6 +372,33 @@ static int da9062_get_device_type(struct da9062 *chip)
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
+		irq_type = DA9062_IRQ_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_type = DA9062_IRQ_LOW;
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
@@ -417,6 +447,7 @@ static const struct regmap_range da9061_aa_writeable_ranges[] = {
 	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
 	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
 	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
+	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_B),
 	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
@@ -596,6 +627,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct regmap_irq_chip *irq_chip;
 	const struct regmap_config *config;
 	int cell_num;
+	u32 trigger_type = 0;
 	int ret;
 
 	chip = devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
@@ -654,10 +686,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
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

