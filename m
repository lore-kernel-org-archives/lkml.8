Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91933C0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 02:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516FD20674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 02:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=biamp.com header.i=@biamp.com header.b="N5yqxmFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgCQCLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:11:18 -0400
Received: from outbound-ip13b.ess.barracuda.com ([209.222.82.195]:53976 "EHLO
        outbound-ip13b.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgCQCLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 22:11:17 -0400
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2058.outbound.protection.outlook.com [104.47.46.58]) by mx15.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 17 Mar 2020 02:11:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJncQjPKogk6nXykJHnPRNwVJpGsS1CYQqo414ctyYSRXrWoUtxNuxoHqj2Lr2n2XrgAnM3fPWj7boo861hGwARD+GKL8MF5BAWTeAhHwFAdjeYxoOOcLIGnsaSXD1WxQm0i/lH4oj90zYK78/nbAv8NZh9HY6VdmbrPBb090Y1e+TcGrDwV7TEc2N418VRuF0LlB6yuohuC887EGSM8JPxohO1lCHP8YgwqhQVg6Esldj8yXxuY9l1m5FdKwlJK+syTAv5RRfo+LkKM4MJvyrCYi6IS2E/yroKUX9nVRKm+/I1XS8nEmELl/5mnLEAQw2UYTzjcwB0UURlPrG/cpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCNKy7BaR8qtehSheH72dAPS++/+yOikYHOa1yL8C1Y=;
 b=QIzTYPruwTJPAT+jGgBgNd+ddV4vGf+F5fh1TIgCjYC93Zvtx4PiBduHgqML1xDBuwNO0VNPqaCdNlnPUR/f8aa/rlI+sJktPTSBY0lP9G0GtYckLm8MP9yRAJEfvrQmNP8uTgAUOPbkTSB1Ay0LzERidkEipoMDtv1yWwq4sQ3a3Zd62cNlJCOoB7rJqsYOr3UKkiMILAlaZpmlAeQstcbNrSZy0zy3ajeaSTRGOlww6XxAlWqFixnQ75oOTHow8G0oOdmY5sa4wttkSy7695UhOBbG4LndhFSB7TfOlr6ZrZVz1SFYri9XxNvjuhXtqyD9BleBkYHWxq8UGc8ONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCNKy7BaR8qtehSheH72dAPS++/+yOikYHOa1yL8C1Y=;
 b=N5yqxmFXxOQ1lktKikYu7LfV3oWttEI9yFKPZCe7w+9kVi7NYKzLc2ipy3/TqTn8sLAGXYLg/hDb0xTmr6SbYzBzqXnADykuZNhQqsGXBhXugknVAtAwDx/J7WFPaYArZFpaeZvas1F4WpPZGNd0RiS0J0HtTxdCfPqse1fql0E=
Received: from MN2PR17MB3197.namprd17.prod.outlook.com (2603:10b6:208:136::33)
 by MN2PR17MB3533.namprd17.prod.outlook.com (2603:10b6:208:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Tue, 17 Mar
 2020 02:11:05 +0000
Received: from MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::31e3:fa7c:d1c0:ce24]) by MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::31e3:fa7c:d1c0:ce24%3]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 02:11:05 +0000
From:   Shreyas Joshi <Shreyas.Joshi@biamp.com>
To:     Shreyas Joshi <Shreyas.Joshi@biamp.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Support.Opensource@diasemi.com" <Support.Opensource@diasemi.com>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>,
        "Adam.Thomson.Opensource@diasemi.com" 
        <Adam.Thomson.Opensource@diasemi.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V6] mfd: da9062: Add support for interrupt polarity
 defined in device tree
Thread-Topic: [PATCH V6] mfd: da9062: Add support for interrupt polarity
 defined in device tree
Thread-Index: AQHV7EMiHDYnv4ttBUekTGBj8r6AgahMKX+g
Date:   Tue, 17 Mar 2020 02:11:05 +0000
Message-ID: <MN2PR17MB31975A1D9E3DEDE788877F18FCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
References: <AM6PR10MB22635CBCBF559AEB9A5C2BFF80120@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200226012108.361-1-shreyas.joshi@biamp.com>
In-Reply-To: <20200226012108.361-1-shreyas.joshi@biamp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shreyas.Joshi@biamp.com; 
x-originating-ip: [203.54.172.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7edc3dc8-1042-4aae-ee04-08d7ca187323
x-ms-traffictypediagnostic: MN2PR17MB3533:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR17MB3533F6F4F3F4C7E6CFE97FFEFCF60@MN2PR17MB3533.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(376002)(346002)(39850400004)(199004)(4326008)(8676002)(110136005)(81166006)(86362001)(5660300002)(7696005)(9686003)(8936002)(55016002)(81156014)(52536014)(478600001)(966005)(66556008)(186003)(66446008)(64756008)(2906002)(26005)(53546011)(6506007)(76116006)(66946007)(71200400001)(316002)(66476007)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR17MB3533;H:MN2PR17MB3197.namprd17.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: biamp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6dEjDr7mXXAdvQuoJE7vmyndTWLByeXy5wQOSy2ZYg6mokMczWz0m2gxdiUMhzjKGEw8E4717nSeo6ojKW/b0JV+vKrTlTQyDGxEyFwjx8mGo5Rl3+65ldm5jTL/ck6bApmMkbB0++3XNNi4vyqnWMNw9RUfnV3wvt6zheipV7e7Y5HupYj2yxclR4KOI6POy0/dvV3f1XYqT3Ora6qgenqy923InLLu1OuuOx6+E+n/6GktWU7bKgjhq+r/t1dt0S52QEudRhT5oq/WM9PAoroBuT+zH89kuXQfWD/f0e/D3dXgNwWAC69SdmEOkrt+JvOwwqSk7loZTrCAHAGtMO71no35oUb1gIjNs5luLeUJqbiXFoqbqt9CAVvFOURtExr+x1+uygHdilmwzdapkbRGBBJBV6TS69ZztcI8loodm7Dja75aiHpIO9WFTFvYky2X52HcdA6KPcuZWNBAJt8aug2JNyjFSeA3F7X2FsY9MrJ1khpR8gyXf+BAtKlWB+dE6qFs6GSrT3oBcWl9xQ==
x-ms-exchange-antispam-messagedata: L46gRXAKCOntiGWn5W5CYH1Qg42Oc/+JHpM6iit33lho5SXgmkSVnKucApD1/pncvVxZ4iG4IGok2bEuXV2q3id/ydxWYlO54OvVu6u92YDA9jkaU1wwMkNcs5A0XoVzgLhfyznvw6bd8xMHss1EzA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edc3dc8-1042-4aae-ee04-08d7ca187323
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 02:11:05.3276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7t8uFNe2x7fhkXPFhTG02hU3wvm1enspMVsEWzKkO/5gy+Z9oT94M/c3g/dSyOYodhXzLlHCgTBXrGeVeBnPEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3533
X-BESS-ID: 1584411070-893029-20171-8065-1
X-BESS-VER: 2019.1_20200316.2111
X-BESS-Apparent-Source-IP: 104.47.46.58
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.222890 [from 
        cloudscan14-19.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 MAILTO_TO_SPAM_ADDR    META: Includes a link to a likely spammer email 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.50 BSF_SC0_SA_TO_FROM_ADDR_MATCH META: Sender Address Matches Recipient Address  
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS74049 scores of KILL_LEVEL=7.0 tests=MAILTO_TO_SPAM_ADDR, BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_ADDR_MATCH
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review! Has it already merged now?
I am using this link to see my patch=20
 - https://lore.kernel.org/patchwork/patch/1200436/=20
I am not aware of the process like how it goes to the mainline.

Thanks
Shreyas Joshi


-----Original Message-----
From: Shreyas Joshi <shreyas.joshi@biamp.com>=20
Sent: Wednesday, 26 February 2020 11:22 AM
To: lee.jones@linaro.org; Support.Opensource@diasemi.com; shreyasjoshi15@gm=
ail.com; Adam.Thomson.Opensource@diasemi.com; linus.walleij@linaro.org
Cc: linux-kernel@vger.kernel.org; Shreyas Joshi <Shreyas.Joshi@biamp.com>
Subject: [PATCH V6] mfd: da9062: Add support for interrupt polarity defined=
 in device tree

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

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c index 41=
9c73533401..fc30726e2e27 100644
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
+static u32 da9062_configure_irq_type(struct da9062 *chip, int irq, u32=20
+*trigger) {
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
+			irq_type << DA9062AA_IRQ_TYPE_SHIFT); }
+
 static const struct regmap_range da9061_aa_readable_ranges[] =3D {
 	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
 	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C), @@ -388,6 +418,7 @=
@ static const struct regmap_range da9061_aa_readable_ranges[] =3D {
 	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
 	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
 	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
+	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_A),
 	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B), @@ -417,6 +448,7 @@=
 static const struct regmap_range da9061_aa_writeable_ranges[] =3D {
 	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
 	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
 	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
+	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_A),
 	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B), @@ -596,6 +628,7 @@=
 static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct regmap_irq_chip *irq_chip;
 	const struct regmap_config *config;
 	int cell_num;
+	u32 trigger_type =3D 0;
 	int ret;
=20
 	chip =3D devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL); @@ -654,10 +=
687,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
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
--
2.20.1

