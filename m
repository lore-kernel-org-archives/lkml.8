Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6078BC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E63320753
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="jYvZX++V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgCTJgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:36:35 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:33065 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbgCTJgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:36:35 -0400
Received: from [100.113.0.114] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id 70/14-39511-0AE847E5; Fri, 20 Mar 2020 09:36:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRWlGSWpSXmKPExsWSoS+Yqzu/ryT
  OYOkLHYv7X48yWkz5s5zJ4vKuOWwWnYsaGC3uXG9ndGD1eNh9gd1j56y77B53ru1h8/i8SS6A
  JYo1My8pvyKBNaPrxQO2gouaFXf3TWVuYNyo3MXIxcEosJRZYv/l6awQzjEWic5dDSwQzmZGi
  d+9P9lAHBaBE8wSnxqPgDlCAhOZJKZ/eckC4dxllJj+eQZQhpODTcBCYvKJB2BVIgJbmSSOH7
  7OApJgFnCUuL33LROILSwQL7Hl+Ud2EFtEIEHiyK1mFghbT+L4381ANRxA+1Qlbn8vBgnzCsR
  K/Ls9jxli2X1GiXPt98F6OQXiJFoezwFbzCggK/GlcTUzxC5xiVtP5oPtkhAQkFiy5zwzhC0q
  8fLxP1aI+lSJk003GCHiOhJnrz+BspUklt2YxQphy0pcmt8NFfeVOLn8NZStJfH8+g4o20JiS
  XcrC8jNEgIqEv8OVUKEcyT+zJwIdYKaxOIru6FKZCRWb00BeUVCoJtF4vSKJewTGA1mIbkawt
  aRWLD7ExuErS2xbOFr5lngoBCUODnzCcsCRpZVjJZJRZnpGSW5iZk5uoYGBrqGhsa6xkCWmV5
  ilW6iXmqpbnJqXklRIlBWL7G8WK+4Mjc5J0UvL7VkEyMwTaUUMmftYPy49r3eIUZJDiYlUd7M
  5pI4Ib6k/JTKjMTijPii0pzU4kOMMhwcShK8Eb1AOcGi1PTUirTMHGDKhElLcPAoifBqdQKle
  YsLEnOLM9MhUqcYjTkmvJy7iJlj59F5i5iFWPLy81KlxHk/9QCVCoCUZpTmwQ2CpfJLjLJSwr
  yMDAwMQjwFqUW5mSWo8q8YxTkYlYR5d4FM4cnMK4Hb9wroFCagU2SXFYOcUpKIkJJqYDoZkXd
  wYWfptbRVsv1Rxx/3OLPtXq8UnHcgbfaHR6flb3+b+J1Btn/N6vTDHY/0jr8+NaMkMvB0XLT4
  wqrfPhd2bWZ8Hpe6c+r+innGKgxH1h7qUhTTrJ9yuGbNCc2/jEYuWw9rTY14+O/55D+R9iqpj
  07UxK7cz2hq6h1feTQqQCA3beOVVxMeMFi7cDN/Dead8vBj2u08VfYdXfXzmco/zTKc+0IsNN
  a3+OPzibMNpPfsvl8qFJ/aExfN/nbxVVn/mTdOf7NaaWCewrBgdal8YsU33ykHqucU9H64uNq
  6K+aL5F1Xxx1PS2dlzbW+JTQ1do7Tg7Odf+yuOjTMuLj9Xse/ObNVjS4VnwopeVirxFKckWio
  xVxUnAgAJzE63GAEAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-31.tower-229.messagelabs.com!1584696990!1561135!1
X-Originating-IP: [104.47.17.109]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23433 invoked from network); 20 Mar 2020 09:36:31 -0000
Received: from mail-db8eur05lp2109.outbound.protection.outlook.com (HELO EUR05-DB8-obe.outbound.protection.outlook.com) (104.47.17.109)
  by server-31.tower-229.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Mar 2020 09:36:31 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPAzNMCJ/s5YzCNTMetooBBC2pPBzqxCUToUQIgq+uCGxXYgcdXJFrqsxuqRQiArrqtWMeJI/wVhT0c5amozhi3b2RzXa688WbVxf/1INI8499WQgtb5bFcj+uj7i1N3Qp1H0oTwKkJ3rMhhj8AyeR+PMvwTCbfoiePwkedS6CYAwd91L2SriS8hxN5vpGrZ2Fio+iCz3vZKgNLz+rLhg4YU7i+sI5SRn0XLUkQ/bBCFHKDvuKyr7fEbj3OL7TLelilJajKqmcq7YvnNbDUlK0zXggzIvBrAM7gTw8KUeieEn8d0nnJpGM4PYVs8O0CgaOS0z0/CNQRnvbYYeEBlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX6iJaQs7NiuIdh1BLDDlHF9gZTsjwTgu81KbtQ95Qs=;
 b=BKW5sytahCDuZUcmmqx9AKzt6xRNmGH95nSB+8UijMDBSKS+Clv4zqsg+9kjRpVhyAERY1q0c4DK3/ADm+8j636Ph2uLACnI9n2x68DgnnoG6bul/79eyUwCFP3/1uPJqrvrylxLLe6HsgUCYrftv+3H2WBdzZFQ4V+Mt7GbPWIl/8Z3oeGsq/RWnNHd/NMF71mS7j9G9Il+9iBSZsDoHZUQY1HmbsX3/SJh/Z/DSS/OEduSKrvzcB4sQXcvgnukZZfQ0n5oMTgiJP264wKPnItM3C4Vx+mZCNJNn9WIpcLXsoIMd0LGgPgsXlW29S7OZiFEO6AmctIBMPBbHFuHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX6iJaQs7NiuIdh1BLDDlHF9gZTsjwTgu81KbtQ95Qs=;
 b=jYvZX++VyV9Gn6m5OPNcw7hQKRdYLYBSbH0ePJWdPK8QNoyiMWXIimTZq7419BfIV9OqqcVIV2YngcD6bNMKzuXFR/YZTuwvOM57ORXifwT7EQthLiLjQ5aOSAgXMQhZilM8dilkU4+Hi0VXhuDlyI4nrNRonYesklkP3YCoT2M=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB2293.EURPRD10.PROD.OUTLOOK.COM (20.177.115.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Fri, 20 Mar 2020 09:36:29 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 09:36:29 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Shreyas Joshi <Shreyas.Joshi@biamp.com>,
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
Thread-Index: AQHV/psIesv7BsC0rkqsvNDeF4Z66Q==
Date:   Fri, 20 Mar 2020 09:36:29 +0000
Message-ID: <AM6PR10MB2263CBE13040737927D6E72980F50@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <AM6PR10MB22635CBCBF559AEB9A5C2BFF80120@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200226012108.361-1-shreyas.joshi@biamp.com>
 <MN2PR17MB31975A1D9E3DEDE788877F18FCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
In-Reply-To: <MN2PR17MB31975A1D9E3DEDE788877F18FCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66ed2540-219f-4a2e-4749-08d7ccb22afd
x-ms-traffictypediagnostic: AM6PR10MB2293:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB2293AD2A256020B8B85900EBA7F50@AM6PR10MB2293.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(366004)(396003)(376002)(346002)(136003)(199004)(64756008)(9686003)(66446008)(66556008)(55016002)(8676002)(66476007)(110136005)(52536014)(53546011)(2906002)(81156014)(86362001)(966005)(8936002)(81166006)(26005)(478600001)(66946007)(5660300002)(7696005)(33656002)(76116006)(316002)(4326008)(186003)(6506007)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2293;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C9Tc7TmW+PvhGFQPVKe6rUbC9g7xYNBuqHnufNFtW7R6L04IY+Bazt59qvCfjVS66Rq1G0AKT0pwnHaaH+eDAAuD7jHVrlNeF9hx6hOmoAizvUZGBvuy4b5h4nQ7TOdGfEtSO1qrHzzwHjce8L3JYUGInf+h0DEvo3hZ/KtQ+bTiFFlahEuiCMLFylygFLSVlJCAhNDICG2o7mN51bDbr4bwvB2j96IE4Oq9sEa6rPdJuJlopm/WMDlAf2P9+6XYrwAN/U2VAMSeZh1z0MN/Q9dChAZBRu7CG8nXEKIon7HslpBERUyY4zK+S1xXLs5/DOCHM1zrvxEr4AuH148ShW1XB/JaHLMMyznD2nL8UXufVbtHCCSWIgrxKFWNhCaNs7U5IsXPcO4o+ue32r8peDpTPVoMyruGhVCLJuk/R5Nuv3bZu8ucIZhaamg9sIh/ddF5g3es3/DXYvXr1yflJnsWbe2vtKDH8ERNk6U9KaQVlqH4YnD2njyLlBD+Rdkw5QTuUi37xfqvpiJw3UjqzA==
x-ms-exchange-antispam-messagedata: oFyrm7Bk2f9J4hYFT85JaQxiPByuTszxR9Qx+pRH/IR3bLXfiUjbvYhaSxRd5gQ3r1+LfgZYEIO1t3KMFu6Md7VUFrWlzAfoAtxjB3ga1lswdFlk3YW/ylK+9qkCC0y7mGLBZW0FjPvu8Vl2ogIqGQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ed2540-219f-4a2e-4749-08d7ccb22afd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 09:36:29.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +dzLQxQAG/+ptlQvD3aGHTRoue+NY+8ZHNOja1bv3uncXU2jjnOmqsyOiI6kDnoUOxylRXavFjsrBp3WQlYyhrVwv+LeBBnuOCJ377xuRnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 March 2020 02:11, Shreyas Joshi wrote:

> Thanks for the review! Has it already merged now?
> I am using this link to see my patch
>  - https://lore.kernel.org/patchwork/patch/1200436/
> I am not aware of the process like how it goes to the mainline.

When Lee has had time to review and accepts the change he will send an e-ma=
il
confirming. As far as I'm aware this hasn't yet happened.

Also check his fork of the kernel as well:

https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/

>=20
> Thanks
> Shreyas Joshi
>=20
>=20
> -----Original Message-----
> From: Shreyas Joshi <shreyas.joshi@biamp.com>
> Sent: Wednesday, 26 February 2020 11:22 AM
> To: lee.jones@linaro.org; Support.Opensource@diasemi.com;
> shreyasjoshi15@gmail.com; Adam.Thomson.Opensource@diasemi.com;
> linus.walleij@linaro.org
> Cc: linux-kernel@vger.kernel.org; Shreyas Joshi <Shreyas.Joshi@biamp.com>
> Subject: [PATCH V6] mfd: da9062: Add support for interrupt polarity defin=
ed in
> device tree
>=20
> The da9062 interrupt handler cannot necessarily be low active.
> Add a function to configure the interrupt type based on what is defined i=
n the
> device tree.
> The allowable interrupt type is either low or high level trigger.
>=20
> Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
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
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c index
> 419c73533401..fc30726e2e27 100644
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
> +static u32 da9062_configure_irq_type(struct da9062 *chip, int irq, u32
> +*trigger) {
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
> +			irq_type << DA9062AA_IRQ_TYPE_SHIFT); }
> +
>  static const struct regmap_range da9061_aa_readable_ranges[] =3D {
>  	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
>  	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C), @@ -
> 388,6 +418,7 @@ static const struct regmap_range da9061_aa_readable_range=
s[]
> =3D {
>  	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
>  	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
>  	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
> +	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_A),
>  	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
>  	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
>  	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B), @@ -
> 417,6 +448,7 @@ static const struct regmap_range
> da9061_aa_writeable_ranges[] =3D {
>  	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
>  	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
>  	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
> +	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_A),
>  	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
>  	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
>  	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B), @@ -
> 596,6 +628,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  	const struct regmap_irq_chip *irq_chip;
>  	const struct regmap_config *config;
>  	int cell_num;
> +	u32 trigger_type =3D 0;
>  	int ret;
>=20
>  	chip =3D devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL); @@ -654,10
> +687,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
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

