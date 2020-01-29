Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3BCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D41206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=biamp.com header.i=@biamp.com header.b="WCVJLM24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgA2Xfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:35:54 -0500
Received: from outbound-ip8a.ess.barracuda.com ([209.222.82.175]:59228 "EHLO
        outbound-ip8a.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgA2Xfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 18:35:53 -0500
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jan 2020 18:35:53 EST
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170]) by mx4.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 Jan 2020 23:35:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ct5XfyaSEfF75aRhk8lxp/pKmmFSXc7adX8omI4Y3AC4Qr0UJGwgeFxqcr2sXWevKhUEiQO9MVpQD29Pu5SAzScJInOndXZKaAjjPx+V83NJkzw01fhL2FAfvzN5g8ZSE+KHEbgMZFG0/ErNDToeLTHPLAkLRridnV+a3jvIv3n/YGx2Kyn6IZIsHty+l5zB7glMiFpLz89oQ3kJv1S15xow4J8HQcNM25e5dFROSPdUGv6zOM2GOqkjMIbbWMrRhTqHBkFpLMN9ozPB9zEKKLtKRA9jksWcFmJSX13fjgEQNan2exh7TH7oYwxAdHnUIb1731sFtOjlXHs2cWvWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Wqlo8jZS1PJNVW/TG8a9GjRaJ0dwJVM8f1rkmFOAjE=;
 b=bOoCMiPJ/gDWmJJ33a2f5GA11RbShAXDbfwhKZ5K2HEDhovgV12S8F8Uy6Hlu8NIucQQAaKUnqw6k+SysvGyex3LhClW3oyShijutVFIAER7/nKtyuo/Qv2tsrkKwZAVbhRHQNxXqTtzXolSj67lZ3doANKDtXHSHYBP39puGmoZpNviSeiykd2NkdsK20u43g3pDCfw4xQe50ULuvE2yp8Xx3M4YA56vXNF+Dhs/UIPf6YEK5rnvzQWK+zqFEgSfnaX8E+2Lnel3/qbPtV+HtaFwiub9hkzLyl3ur9lxylkknNxzVuRVMaO4Dtf+BZ+xSewyRlz7BSQcueU0M0ApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Wqlo8jZS1PJNVW/TG8a9GjRaJ0dwJVM8f1rkmFOAjE=;
 b=WCVJLM24AL5vUDiAX4J9hLK/vzdfUcpQyesce4hPHEuUhN71jBOvwqC4eVbIe+qF1xvWYlLWo79/wVIoFo8Xv6fzsY9jI2dNPCJMmDySEbLNowZ8R38z5WJSEOLjvb2IDh+Xi8lrnjW63WUSwzaFhxQC03ZABiPCLakoq7Wq1uo=
Received: from MN2PR17MB3197.namprd17.prod.outlook.com (20.179.149.225) by
 MN2PR17MB3664.namprd17.prod.outlook.com (52.135.39.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Wed, 29 Jan 2020 23:20:25 +0000
Received: from MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::90ed:ec6c:666d:4607]) by MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::90ed:ec6c:666d:4607%4]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020
 23:20:25 +0000
Received: from shreyas_biamp.biamp.com (203.54.172.54) by SYBPR01CA0183.ausprd01.prod.outlook.com (2603:10c6:10:52::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Wed, 29 Jan 2020 23:20:23 +0000
From:   Shreyas Joshi <Shreyas.Joshi@biamp.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Support.Opensource@diasemi.com" <Support.Opensource@diasemi.com>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>,
        "Adam.Thomson.Opensource@diasemi.com" 
        <Adam.Thomson.Opensource@diasemi.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: da9062: add support for interrupt polarity defined in
 device tree
Thread-Topic: [PATCH] mfd: da9062: add support for interrupt polarity defined
 in device tree
Thread-Index: AQHV1vqvrnZ+m6pd90mES33Xb0II9A==
Date:   Wed, 29 Jan 2020 23:20:25 +0000
Message-ID: <20200129232007.tmpc7p6l5ouibvwh@shreyas_biamp.biamp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0183.ausprd01.prod.outlook.com
 (2603:10c6:10:52::27) To MN2PR17MB3197.namprd17.prod.outlook.com
 (2603:10b6:208:136::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shreyas.Joshi@biamp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [203.54.172.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 086f9e93-c824-4d78-6ac4-08d7a511d21d
x-ms-traffictypediagnostic: MN2PR17MB3664:
x-microsoft-antispam-prvs: <MN2PR17MB36644F6455C5719F1ED9DB05FC050@MN2PR17MB3664.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(39850400004)(136003)(346002)(366004)(199004)(189003)(4326008)(71200400001)(1076003)(186003)(26005)(16526019)(2906002)(5660300002)(8676002)(81156014)(110136005)(66556008)(8936002)(66476007)(66446008)(81166006)(55016002)(316002)(7696005)(44832011)(956004)(478600001)(66946007)(64756008)(86362001)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR17MB3664;H:MN2PR17MB3197.namprd17.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: biamp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xaCXfDrwBRgngfyA4nfBr6HDNZyyxRBWSGdVe0M3qw8UE6WdSo+r3HJYz+iHSJtOTDIwo7HaJ1muyLQATsq6jC82vqBgpXfpVzZmEXAFcYkn+JRkTes5j1tVA7OCFiu3zIl3j4VsKFg1G3xmFiAU+grzQwSGw0aJsDyjCjyretySQv5wAzITyDYAnNUxWSgOTDsUBfRZIW6tmA2DchMlvYRa/2NNQlF4hOgNMx3ouBj3Ld1JOj0+JQYVPlzu1kf5xRH/sGttldnbus0UuX0090lJ6gADny9D8DIG3OdOb23q0M+ruj70t+QmxulV8euWaWpb4lncDsF1EZ2o3sUyR6ie+gHeSpHEO7SdzHk5CTDs4tGDG7LtRhqKP85IpwZaFheimhGzqwBNtZRyZehD9+yMc5+xokO9m/xHBbPA4zEWQT0FDovQshuYhsYnbzsE
x-ms-exchange-antispam-messagedata: YWlvdgn4ZXjUTrB/Z/wasemFqlE4YWLhVfcwks1Zzi5oz3P/WKNYKX8zo4rtDTv6MteJNMxfRyqFHfltFA4dhKJzF/7oH2wGjAEX80xb1lTq3phqH1xPSPkJvWk9udWVBnvWVs9nDf4l53kB25Vlxw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D1B499105E20149B21F7A171CD5E0FD@namprd17.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086f9e93-c824-4d78-6ac4-08d7a511d21d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 23:20:25.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZAG1RewCT6BURazwyPs5c/qDyNph4llFAJweIR0oVIScTbeaqDOOriVs9Va0KITcMkPoh6vzwM6Goh3RxrDLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3664
X-BESS-ID: 1580340952-893006-23720-46320-1
X-BESS-VER: 2019.1_20200128.2125
X-BESS-Apparent-Source-IP: 104.47.55.170
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.222006 [from 
        cloudscan17-143.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS74049 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The da9062 interrupt handler cannot necessarily be low active.
Add a helper function to read the polarity defined in the device tree.
Based on the user defined polarity in device tree, the interrupt is
set active.

Signed-off-by: shreyas <shreyas.joshi@biamp.com>
---
 drivers/mfd/da9062-core.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 419c73533401..62ba10aeb440 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -369,6 +369,22 @@ static int da9062_get_device_type(struct da9062 *chip)
 	return ret;
 }
=20
+static inline u32 irqd_get_polarity(struct irq_data *d, struct device *dev=
)
+{
+	u32 trigger_type =3D irqd_get_trigger_type(d);
+
+	switch (trigger_type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_LEVEL_LOW:
+	case IRQ_TYPE_NONE:
+		return trigger_type;
+	default:
+		dev_warn(dev, "Invalid IRQ type: %d defaulting to IRQ_TYPE_NONE\n",
+				trigger_type);
+		return IRQ_TYPE_NONE;
+	}
+}
+
 static const struct regmap_range da9061_aa_readable_ranges[] =3D {
 	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
 	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C),
@@ -592,6 +608,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	struct da9062 *chip;
 	const struct of_device_id *match;
 	unsigned int irq_base;
+	struct irq_data *irq_data;
 	const struct mfd_cell *cell;
 	const struct regmap_irq_chip *irq_chip;
 	const struct regmap_config *config;
@@ -654,9 +671,16 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
=20
+	irq_data =3D irq_get_irq_data(i2c->irq);
+	if (!irq_data) {
+		dev_err(chip->dev, "Invalid IRQ: %d\n", i2c->irq);
+		return -EINVAL;
+	}
+
 	ret =3D regmap_add_irq_chip(chip->regmap, i2c->irq,
-			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
-			-1, irq_chip,
+			irqd_get_polarity(irq_data, chip->dev)
+			| IRQF_ONESHOT | IRQF_SHARED | IRQF_ONESHOT
+			| IRQF_SHARED, -1, irq_chip,
 			&chip->regmap_irq);
 	if (ret) {
 		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
--=20
2.20.1

