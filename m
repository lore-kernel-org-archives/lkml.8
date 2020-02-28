Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D6EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD22524680
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="cg5vyBEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgB1MQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:16:27 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:55118 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgB1MQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:16:27 -0500
Received: from [100.113.6.14] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 04/AD-05601-694095E5; Fri, 28 Feb 2020 12:16:22 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRWlGSWpSXmKPExsWSoc9jpjuNJTL
  OYPUcJYv7X48yWkz5s5zJ4vKuOWwWnYsaGC3uXG9ndGD1eNh9gd1j56y77B53ru1h8/i8SS6A
  JYo1My8pvyKBNePue/WCH0oVm9bdZG9gvCXbxcjJwSiwlFni1s2iLkYuIPsYi8S7w/+ZIZzNj
  BK/e3+ygTgsAieYJS41PgNzhAQmMknsPnCBGcK5yyjxYv9cVpBhbAIWEpNPPGADsUUEtjJJzD
  lfDmIzCzhK3N77lgnEFhaIl9jy/CM7RE2CxJFbzSwQtp7EvTnfGEFsFgFViekz9oPV8wrESpy
  fM58FYlkvo8ThN9eYQRKcAtYSC57PZoT4QlbiS+NqZohl4hK3nswHa5YQEJBYsuc8M4QtKvHy
  8T9WiPpUiZNNNxgh4joSZ68/gbKVJLZ074PqlZW4NL8bKu4rceZUO5DNAWRrScx6lQERtpBY0
  t3KAhFWkfh3qBLCzJGY/lsUokJN4vPTK1AHyEjcf93CCPKJhMAsFokrC24yT2A0mIXkaAhbR2
  LB7k9sELa2xLKFr5lngUNCUOLkzCcsCxhZVjGaJxVlpmeU5CZm5ugaGhjoGhoa65rpWuglVuk
  m6aWW6ian5pUUJQLl9BLLi/WKK3OTc1L08lJLNjECk1NKIRvHDsZLy9/rHWKU5GBSEuWtfhIR
  J8SXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCV+07UE6wKDU9tSItMweYKGHSEhw8SiK8Pf+B0rzFB
  Ym5xZnpEKlTjMYcE17OXcTMsfPovEXMQix5+XmpUuK8Nxgj44QEQEozSvPgBsES+CVGWSlhXk
  YGBgYhnoLUotzMElT5V4ziHIxKwrwWTEBTeDLzSuD2vQI6hQnolPxP4SCnlCQipKQamHStZB+
  Id6/5znBjxWTeGbH/8vvPhH3r27RFgXGC8sNpK6T2/Z9l8uN824GPq6a+PbHEy1PhZxP33OBj
  jLstF2lVS+cfPuES+dLmqqzqr85j0lmvbq7c9XOP6wm/DqmbO8S3rRdRWnRo9+f6tz+fa/tIl
  /Qnz7jbcz3C2cfkl7L06VcW64J/T7G9t1GYdfpGtpx+HvvZyotui7rVuPYza59Xu2FkxqvmYb
  rh7O+zty2u8q0KVVAXD5uy1vLnzZtqFYG/+R0ueSUVXpudfGzj43evDlYnZJ9Y6ik2t17k3E6
  FhwGNDTu2FCzSFz34LeXNiV0Je1o9PzhkTTqQ/7XwaOZxIf9zn+t6Vs45yWz3+s5TJZbijERD
  Leai4kQAi02vf1sEAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-34.tower-249.messagelabs.com!1582892182!3140670!1
X-Originating-IP: [104.47.12.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12702 invoked from network); 28 Feb 2020 12:16:22 -0000
Received: from mail-db3eur04lp2054.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) (104.47.12.54)
  by server-34.tower-249.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Feb 2020 12:16:22 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnSfcVdu3AcSHBQV0qv+oMY+ntENgC+EhQ0HWrmTa2uptQDDyyTBa4f0cm7uyQ4ptsioDa7xgfPawaPhrwXH2Wt/f3atGNK8+EnU5yWbHDvTS8OGO3eJ4EZLFnb4tH1dsq1g0rDd5iaS2WyYBEmtguBM/YnIyH8bt7yq+lF08m5HyaKKfRir/3jpkKMsj8Vn6mkLgbJcu+L57VdtkOK7rgcU9gnoYDdhrdnXcO9S1UWyWeH289zxChuI+/sidFo2rA1dQtww7tZAvwfGf8dMAuiL3HaX7/ahc6F2LoqqfCMRV3uCZej66WoEbTXUmWtI7tsrRqoqCXHM/qZ4dVgZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1So/XIaC5GY7fWRwSzVowJECvL5Q8rqgSowSWGYSxw=;
 b=Mid2XlUANYoJ7rGbmQZyHJZiGZ0QQaQH0j4Ls0ePC88qf+A9cufRdWjmaA4BB1bfyhQ/mqB7nkPew7pKtLRuiPrhdA4b+Pj9x58avOt3pGjocdIJa6gMEfOtvrAYXoqZkqsjoU4H4YK+EVZbDPr+7GmCQyZLnj6EeU3mgxBzL04bQwMf3RdHokWXJRhZkXNPqF7YNTS4TM9O7q2Kt8/JQ144XppItA1aQdT8lOqwQL5A/R2r2iNMLegU+r9+579LiyaHwb64ZKyU2GJ/qv2103dfav9XXRYNYa5dm7I2KbFv8OFa4voomubVF+DLEcg4krvQj7RYks2R9fqhPLeklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1So/XIaC5GY7fWRwSzVowJECvL5Q8rqgSowSWGYSxw=;
 b=cg5vyBEMchjMlrNYDqlK0HmvV9onForXBqJbTnzLljz/DmLXxQck31RM5A5Ib/pY9TQfFXfR2B9UY5u+SXHWsnyU0ClwlL22i19YRfM+lZQr7ZdIS5NBUdVAMVXaaK/SN3HLPHXlUo9yhcR+20doCCkvwS/htVutUp1pq12qpyU=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB3031.EURPRD10.PROD.OUTLOOK.COM (10.255.122.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Fri, 28 Feb 2020 12:16:20 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2772.016; Fri, 28 Feb 2020
 12:16:20 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Shreyas Joshi <shreyas.joshi@biamp.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V6] mfd: da9062: Add support for interrupt polarity
 defined in device tree
Thread-Topic: [PATCH V6] mfd: da9062: Add support for interrupt polarity
 defined in device tree
Thread-Index: AQHV7jDiu+v5eyz+MUGktF3dkva7qA==
Date:   Fri, 28 Feb 2020 12:16:20 +0000
Message-ID: <AM6PR10MB2263E96BF13563561218B4C380E80@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <AM6PR10MB22635CBCBF559AEB9A5C2BFF80120@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200226012108.361-1-shreyas.joshi@biamp.com>
In-Reply-To: <20200226012108.361-1-shreyas.joshi@biamp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f98986c6-4ce1-4280-1148-08d7bc4804f5
x-ms-traffictypediagnostic: AM6PR10MB3031:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB3031ECB3AFC300ED8FF202FEA7E80@AM6PR10MB3031.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(81156014)(52536014)(7696005)(186003)(86362001)(81166006)(5660300002)(26005)(8676002)(110136005)(8936002)(4326008)(55016002)(6506007)(316002)(478600001)(53546011)(2906002)(55236004)(66476007)(9686003)(66556008)(71200400001)(76116006)(66446008)(33656002)(66946007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB3031;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sd0dR6WRa0QPYdO5L2tZPeifS5dixjBMwNuownRYzsPKu/qDbWXM64maJm+FSLvsrtyFqO+ZrPToitxqNeczgimjfZuAWWRIRk+enoFOeVTERekl61lQORkkXAppOwRAbprBMPtxojQPgFBUuqJaWjkGapHMgKnNgDvWBn8bZhgmUaMSrpgdAX1mD3NjcAUJMevowUteUvIKShbfos9H7pvmZwggtekKOHwZy/7TSDhrSGgJ/ppmk0wkJW6kS1QXQ5WwvwA5I6VxAxCnkrFijeVSJAQKJcq4UjD8ukFSBOmTiftndgf315+nVZ7mL7/dR9x5N+9uTBXxPPuFn0RT45ROHBEsSW33Tyhb3TOXkKPW69V9e7CWAPvU7KTkHOdySwg0geOBJAAuZhYipMvniwdTMuzQddbs+PXtIqOka0L4FmflOsXWaxuGMpGKmw4p
x-ms-exchange-antispam-messagedata: 3a3sVQLEchYJZOF3cyDuvJfifo/KLjVna2qa/K3EMymnik9JW5cOrH1T5RtTcQ71iefQneaakRcMIgqZlQgo/jYGy0PqWU9qYU3WuVEMxgXFRZc9TTMryVw1EbA8lUUyhofIaF4tHDf4zeoWpn/mVA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98986c6-4ce1-4280-1148-08d7bc4804f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 12:16:20.1921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWD58iatQgoeEF7mw+OGH5MkeUaQrrloUlDCDKrr5c2q7TdmjHmxugbnIZr97OsFE3Bf46JTJ3xlBX4SRVZTrK7/Wy0xXQMYEgyKIdrnx1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 February 2020 01:21, Shreyas Joshi wrote:

> The da9062 interrupt handler cannot necessarily be low active.
> Add a function to configure the interrupt type based on what is defined i=
n the
> device tree.
> The allowable interrupt type is either low or high level trigger.
>=20
> Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>

Thanks for persisting:

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>=20
> V6:
>   Changed regmap_reg_range to exclude DA9062AA_CONFIG_B for writeable
>   Added regmap_reg_range DA9062AA_CONFIG_A for readable
>=20
> V5:
>   Added #define for DA9062_IRQ_HIGH and DA9062_IRQ_LOW
>=20
> V4:
>   Changed return code to EINVAL rather than EIO for incorrect irq type
>   Corrected regmap_update_bits usage
>=20
> V3:
>   Changed regmap_write to regmap_update_bits
>=20
> V2:
>   Added function to update the polarity of CONFIG_A IRQ_TYPE
>=20
>  drivers/mfd/da9062-core.c | 44 ++++++++++++++++++++++++++++++++++++--
> -
>  1 file changed, 41 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index 419c73533401..fc30726e2e27 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -21,6 +21,9 @@
>  #define	DA9062_REG_EVENT_B_OFFSET	1
>  #define	DA9062_REG_EVENT_C_OFFSET	2
>=20
> +#define	DA9062_IRQ_LOW	0
> +#define	DA9062_IRQ_HIGH	1
> +
>  static struct regmap_irq da9061_irqs[] =3D {
>  	/* EVENT A */
>  	[DA9061_IRQ_ONKEY] =3D {
> @@ -369,6 +372,33 @@ static int da9062_get_device_type(struct da9062 *chi=
p)
>  	return ret;
>  }
>=20
> +static u32 da9062_configure_irq_type(struct da9062 *chip, int irq, u32 *=
trigger)
> +{
> +	u32 irq_type =3D 0;
> +	struct irq_data *irq_data =3D irq_get_irq_data(irq);
> +
> +	if (!irq_data) {
> +		dev_err(chip->dev, "Invalid IRQ: %d\n", irq);
> +		return -EINVAL;
> +	}
> +	*trigger =3D irqd_get_trigger_type(irq_data);
> +
> +	switch (*trigger) {
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		irq_type =3D DA9062_IRQ_HIGH;
> +		break;
> +	case IRQ_TYPE_LEVEL_LOW:
> +		irq_type =3D DA9062_IRQ_LOW;
> +		break;
> +	default:
> +		dev_warn(chip->dev, "Unsupported IRQ type: %d\n", *trigger);
> +		return -EINVAL;
> +	}
> +	return regmap_update_bits(chip->regmap, DA9062AA_CONFIG_A,
> +			DA9062AA_IRQ_TYPE_MASK,
> +			irq_type << DA9062AA_IRQ_TYPE_SHIFT);
> +}
> +
>  static const struct regmap_range da9061_aa_readable_ranges[] =3D {
>  	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
>  	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C),
> @@ -388,6 +418,7 @@ static const struct regmap_range
> da9061_aa_readable_ranges[] =3D {
>  	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
>  	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
>  	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
> +	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_A),
>  	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
>  	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
>  	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
> @@ -417,6 +448,7 @@ static const struct regmap_range
> da9061_aa_writeable_ranges[] =3D {
>  	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
>  	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
>  	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
> +	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_A),
>  	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
>  	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
>  	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
> @@ -596,6 +628,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  	const struct regmap_irq_chip *irq_chip;
>  	const struct regmap_config *config;
>  	int cell_num;
> +	u32 trigger_type =3D 0;
>  	int ret;
>=20
>  	chip =3D devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
> @@ -654,10 +687,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  	if (ret)
>  		return ret;
>=20
> +	ret =3D da9062_configure_irq_type(chip, i2c->irq, &trigger_type);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to configure IRQ type\n");
> +		return ret;
> +	}
> +
>  	ret =3D regmap_add_irq_chip(chip->regmap, i2c->irq,
> -			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> -			-1, irq_chip,
> -			&chip->regmap_irq);
> +			trigger_type | IRQF_SHARED | IRQF_ONESHOT,
> +			-1, irq_chip, &chip->regmap_irq);
>  	if (ret) {
>  		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
>  			i2c->irq, ret);
> --
> 2.20.1
