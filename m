Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55EDC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8660C20656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="DJidnPkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgBUOrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:47:55 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:52323 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728068AbgBUOry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:47:54 -0500
Received: from [100.113.7.160] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id 1E/8E-52742-89DEF4E5; Fri, 21 Feb 2020 14:47:52 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRWlGSWpSXmKPExsWSoc9jrTv9rX+
  cwdftqhb3vx5ltJjyZzmTxeVdc9gsOhc1MFrcud7O6MDq8bD7ArvHzll32T3uXNvD5vF5k1wA
  SxRrZl5SfkUCa8bKhUfYCm7KVRx72MfUwPhMsouRi4NRYCmzxNG/+5ggnGMsEmsnr2WGcDYzS
  vzu/ckG4rAInGCWaHi8Ecjh5BASmMgkcahBFyQhJHCXUaLv8iFWkASbgIXE5BMPwIpEBLYySc
  w5Xw5iMws4Stze+5YJxBYWiJeYtXEWK0RNgsS1pjdAcQ4g20hi4wYXkDCLgKrE5aazYCW8ArE
  SP+ZeZYTY6yox6fNtNpByTgE3iSU9UiBhRgFZiS+Nq5khNolL3HoyH2yThICAxJI955khbFGJ
  l4//sULUp0qcbLrBCBHXkTh7/QmUrSix59xCqF5ZiUvzu6HivhKXJ35mhbC1JP5Pngw100JiS
  XcrC8g5EgIqEv8OVUKEcySmNm5lh7DVJG686YAql5G4dfsYOGwlBGaxSOy9P51tAqPBLCRnQ9
  g6Egt2f2KDsLUlli18zTwLHBKCEidnPmFZwMiyitEiqSgzPaMkNzEzR9fQwEDX0NBY10TX1FI
  vsUo3SS+1VDc5Na+kKBEoqZdYXqxXXJmbnJOil5dasokRmJ5SClmsdzBeXvte7xCjJAeTkiiv
  Yp9/nBBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3omvgXKCRanpqRVpmTnAVAmTluDgURLhNX0Dl
  OYtLkjMLc5Mh0idYjTmmPBy7iJmjp1H5y1iFmLJy89LlRLnzQcpFQApzSjNgxsES+GXGGWlhH
  kZGRgYhHgKUotyM0tQ5V8xinMwKgnzHgG5hyczrwRu3yugU5iATnkv7ANySkkiQkqqgWmSqcG
  3963bkxZZB9oXRjGrSxlO4Twy6zH3mqk5xzcei9lh+EunKWHXiTdbL9QmOt+SNXbdeEv0r/My
  008N5Tf5AwM23xb5+XTy3scb9xbmNQhqcT4uk8o4evawpFr6qUW/rXda/2d6nd8tprc4xXazT
  ukhr6CX2lt8vK0OuBd/2hy4sHYxf6/enWXmN72/nb+wzmH3XYuGYF6pCRtT2TYeqNa5bKl2IG
  Otf71Ffvi/tnlCIbVpUskcJswvq5KvXhecbMWr18W2+feG/sKUu1r2N2dpne5f9LDpktHayKr
  ZTTOClrAnbQ91ily84wzzbz2dB2Eb+F0k9zmJt62S++xpMFOHryjta0K4WUyhsBJLcUaioRZz
  UXEiANKrk8RcBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-25.tower-239.messagelabs.com!1582296471!2488351!1
X-Originating-IP: [104.47.12.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10382 invoked from network); 21 Feb 2020 14:47:51 -0000
Received: from mail-db3eur04lp2059.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) (104.47.12.59)
  by server-25.tower-239.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Feb 2020 14:47:51 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY1ITEo1lfKUSg8g/IpiUrzmn58kvNjJV/ISWF95D1relWugR+kaOw/fhQcZRbHF+vv/dbKT78q6MyQGNpeCkAT5A3iEhku6RW2kEVNuzZSC359RDcLQuLfB4dA4P2qiEAMTQQX/nPJN6pTXzL+IGEOC9IPM1YfdDNM42vP47SszUfzS7lvhDqhSjIRRvmq7YL4RpeA2a5Lzx/MlVin69U4ygeF29RVml0qrUGQs9pDcpwcjvGLZqS7dm36XwlOKBwie0rMRRS9pjGzypdKYf0YTH4oLRanx7apxOv7hf6Ei/ytdzZl+4auK4cl42z710wOMqV87vsFMPs/qo63QqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nehs9oNcQMfXLARXPZe4QYD8bCiyR/Q05EEY1gmfowU=;
 b=V5otSwKq0GYJD6OWYe6tTGdrMjKoGvoydWPdjskk5GYAGY1CE07jZcHbJxjm1ik0WTpxbo6o7Jn2Uzds7toNFLXiQw1fFkrf8RkuIBNATyDT61X2ZRjgXDUWtT/ofy71hiP9uvp1XSD3GexI1mi0euClmECsljBl6GTO0lH3W/ga77TggtT8+IlFL5X/uTKtd2zt1IKn0UUhd1thHy0JQlu+qQ7JhtYUy+JYWES6ckYMp62Cd5vTrISUGqEP1I56GTBKQm2gSL8/QIBD97jv34Sya8BEyV7hyugL9b+BycozOvwA4qXFJofncnThrmDl37gQ10L/MR9acwXaomliQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nehs9oNcQMfXLARXPZe4QYD8bCiyR/Q05EEY1gmfowU=;
 b=DJidnPkYj1zWsmQtVBKbwZZ+P4FF4Gm2EqFsG62UVtEWl8WgLf9WkHZSef0GkAXUFayqV9JSnIZr5Gewju4Jle6ksTbFu0zPBsiYpFi9+VkgfzqBmgC7pZrPvelv2/BLAggkXkyXn5PGJnNa6VK1EnMDNvb3oqi0hvjANqcWUaw=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB2279.EURPRD10.PROD.OUTLOOK.COM (20.177.115.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Fri, 21 Feb 2020 14:47:50 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 14:47:50 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Shreyas Joshi <shreyas.joshi@biamp.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V5] mfd: da9062: add support for interrupt polarity
 defined in device tree
Thread-Topic: [PATCH V5] mfd: da9062: add support for interrupt polarity
 defined in device tree
Thread-Index: AQHV5StvWfQVKiOEQ0KNfwswAU8c4aglvkQw
Date:   Fri, 21 Feb 2020 14:47:49 +0000
Message-ID: <AM6PR10MB22635CBCBF559AEB9A5C2BFF80120@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <20200217004416.lhbl7rzvaf5q4fbz@shreyas_biamp.biamp.com>
In-Reply-To: <20200217004416.lhbl7rzvaf5q4fbz@shreyas_biamp.biamp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7341b5ca-6871-4266-2906-08d7b6dd05fe
x-ms-traffictypediagnostic: AM6PR10MB2279:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB2279284C61D4D27C19D86DD9A7120@AM6PR10MB2279.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(76116006)(55236004)(71200400001)(316002)(66946007)(110136005)(86362001)(66446008)(66476007)(66556008)(8936002)(9686003)(26005)(64756008)(55016002)(81156014)(7696005)(6506007)(2906002)(33656002)(186003)(53546011)(4326008)(478600001)(81166006)(52536014)(5660300002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2279;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p5KC0owXCrcP2gotCxfaiLc4nJO00avTcEXQFp+Cv2ZyZKGnzgIdyiMqjRQcoN+Nz3ralLyHsC7OfrVxLm2jpJsNSDOZuB0iciLrkYZZ23QguuJz6jXYsncm/ozhs28zaHUCPy3Hcifu+4ZpX//G28WE8NUF3K42uqja8GPg8zKSCwSMYd6H/cMD3Sej3eXGqEtzyFKhTUmA5KNAnHacrFZoWVGTpL9Ygpmf6EIEBEwtT6nI5dOOX5ZyxnA10iyv1+Y0cHtCPUrCjtvp4GJfKCpKCo7J/ybs1KRyzBqaV3l0HSNGbjDEtfcETomulLXVH1zOpoj6kt7CoCKeLCtGKi5RpC6Wy2KZddw7sn4Ojrt8G+u4xf183BXsi5GL5Ja+cP48Vwk1inLSvyoh0TUXWWTt4mSEqn8NJj+7VRu3ueI18PoDEoR7LsMIu+afzZNV
x-ms-exchange-antispam-messagedata: QbhTCvqyb6giCyqWG+yIqyIncj08Ch4WUuxLA5XW2eWzbTkC3l69I2+IeaD2o24H7+WOLex6shO7PxxFVbEU1bLQBh15NetYcLB4M1dE7S0vOx45ZLItcBBdxmxAIj3vJfnZi1PHeuXzsxiSHPhyXw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7341b5ca-6871-4266-2906-08d7b6dd05fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 14:47:49.9355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LTyZF/kiD5Z/vT8NvdeD45bw1gM8B5qJpQ9wM64qFUvo4RBpXqjZAb3Dc69350WMqQmstoTQAGOR3Z6fHVc4S7bHq1NCgaouSM+ki75Cw1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 February 2020 00:44, Shreyas Joshi wrote:

> The da9062 interrupt handler cannot necessarily be low active.
> Add a function to configure the interrupt type based on what is defined i=
n the
> device tree.
> The allowable interrupt type is either low or high level trigger.
>=20
> Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
> ---

This is V5 of the patch and there's still no revision history information h=
ere.
Please add this in the future when submitting patches as it helps reviewers
understand (or reminds them) what has come before.

>  drivers/mfd/da9062-core.c | 43 ++++++++++++++++++++++++++++++++++++--
> -
>  1 file changed, 40 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index 419c73533401..cd3c4c80699e 100644
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
> @@ -417,6 +447,7 @@ static const struct regmap_range
> da9061_aa_writeable_ranges[] =3D {
>  	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
>  	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
>  	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
> +	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_B),

Hmm. I don't believe we need access to CONFIG_B here do we? Just CONFIG_A t=
o
configure polarity. Also we will need this register to be part of the
aa_readable_ranges table for regmap_update_bits() to work I believe.

Otherwise I think this looks ok so will give the nod once these changes hav=
e
been made.

>  	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
>  	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
>  	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
> @@ -596,6 +627,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  	const struct regmap_irq_chip *irq_chip;
>  	const struct regmap_config *config;
>  	int cell_num;
> +	u32 trigger_type =3D 0;
>  	int ret;
>=20
>  	chip =3D devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
> @@ -654,10 +686,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
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

