Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D78C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC94206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="uOs4hSix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgBLMlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:41:20 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.6]:44274 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727555AbgBLMlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:41:19 -0500
Received: from [100.112.193.253] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.eu-west-1.aws.symcld.net id 37/87-30238-D62F34E5; Wed, 12 Feb 2020 12:41:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRWlGSWpSXmKPExsWSoc9noZvzyTn
  OYM5GS4v7X48yWlzeNYfNonNRA6PFnevtjA4sHg+7L7B77Jx1l93jzrU9bB6fN8kFsESxZuYl
  5VcksGasa3vFWrBSuuLExpeMDYxd4l2MXByMAkuZJe6dXcMO4Rxjkdj/axcrhLOZUeJ37082E
  IdF4ASzxIyFO8DKhAT6mST23fsB5dwFKlvRAORwcrAJWEhMPvEArEVE4C+jxJalp8ESzAKOEr
  f3vmUCsYUF4iXef/rJCGKLCCRIzFpxhh3CNpJ4N3slmM0ioCrRvWUhM4jNKxArMWvqNhYQW0j
  AVeLhpg6wOKeAm0T/+mVgcxgFZCW+NK5mhtglLnHryXywXRICAhJL9pxnhrBFJV4+/scKUZ8q
  cbLpBiNEXEfi7PUnULaixJ5zC6F6ZSUuze8GinMA2b4SK9ZUQYS1JJ6c+swOYVtILOluZYEoU
  ZH4d6gSIpwjMeFzBwuErSbxbdsSKFtGYvXMdawQ9iwWiRnr6yYwGsxCcjSErSOxYPcnNghbW2
  LZwtfMs8ABIShxcuYTlgWMLKsYzZOKMtMzSnITM3N0DQ0MdA0NjXQNLY10Tcz1Eqt0E/VSS3X
  LU4tLdA31EsuL9Yorc5NzUvTyUks2MQLTUkrBAf0djL/WvNc7xCjJwaQkynvrhnOcEF9Sfkpl
  RmJxRnxRaU5q8SFGGQ4OJQle7Y9AOcGi1PTUirTMHGCKhElLcPAoifDe+QCU5i0uSMwtzkyHS
  J1iNOaY8HLuImaOnUfnLWIWYsnLz0uVEueNAZkkAFKaUZoHNwiWui8xykoJ8zIyMDAI8RSkFu
  VmlqDKv2IU52BUEuYNAJnCk5lXArfvFdApTECnXDdxADmlJBEhJdXA5Gk3d9u5aye7eU7ub3V
  OlkmztRP9yv/8gUVye/HHiDm7t6822T+/Ydqj1enHwg0MPmfI5M1oaBDXWTV737O1b86846za
  zfiHsdJbuiO3bpNg+It359wP3XN3tp2TparctKtMcOHO5vQO1qDVFw4e2Lc6br0tw55ldivk9
  rH6XAl4fzb3SFpQVI1Y83WD/bFOvmZFDtr1qxc+uuS2t/7qjJJrR22e5e7e90uAv8PwWtUF96
  Z411PpFaaBMpML+dcI1b87l/D2jtj1J9e2aM6vumIgKdZlyTul0cTltsTteMWCPVcaUhk/3p1
  ydoty9o5ZiR/vXC2IOOnwkMPns1vSUYHpQroHvjyY67Dw0QR5cSWW4oxEQy3mouJEANg3ZYtY
  BAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-9.tower-262.messagelabs.com!1581511276!1653535!1
X-Originating-IP: [104.47.14.56]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12332 invoked from network); 12 Feb 2020 12:41:16 -0000
Received: from mail-vi1eur04lp2056.outbound.protection.outlook.com (HELO EUR04-VI1-obe.outbound.protection.outlook.com) (104.47.14.56)
  by server-9.tower-262.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Feb 2020 12:41:16 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By9yygyjQyxH+H45qyVNLPMeZmk37zsYWpyWJ2c4HV6CvSYz9ZPJpCrL51tPK8pPGv5vDxmZcLGlqDZ4jXXI1kcGgXIERIECf85Vgn/3HNbexfdpQUIOKjWuQBdSAeaKBySJhWMe2LrPFB0POIxNSt4TI88S8HL7pI6YDHkqb6MnHHh9PW/JK89v/2F9zlz1J23DxCE8O+bPtZFXzdij/kr7MiLFuKLYsG5EdSrjnO16zp9gABTKahFhcExkWmpE+sjOpl7QNSmtw13np/nKFLKFhWwVEV0iNyQBcMM/ZZSB3ANhxzi9R7rKLXP688xOgtbnMHT/5//crHXGZTPRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxQT9qR3TDPqyc61wha+hc4r16j54AlIVmWKH/iyrT4=;
 b=OF0Gf/tZ/OrV5EFtyxxqfGXlAq5FEx6DfULTlFgse3XRpMkEWaMz2PXC3CPy9QMpp1f5zS0qAnxxHh0GwGqBDtaIZZENF/EjwTpD730/PrueHZ5eR+CTiaZo/pN6N7Rlv+5y6NWwZ1xGdNTS1IL3UawNcg2WqPCx4lRREjOi/20EvNHW0l/prV8RrwLgddjIJoQNfxhyLVgksJMr+Am6AoVkq+afwuYMUGs8yomFtGgIJRvkSaxG5LjrsC3IEwpIEUBudNtvhJzbs+VIa1d4MBe4sLisvsC2Ga9PJV63sqL/KWbqIQ/Xg9Cy9smAnDPVy16xNcGXgpeQPMLG/8UXEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxQT9qR3TDPqyc61wha+hc4r16j54AlIVmWKH/iyrT4=;
 b=uOs4hSixmRLMOqLf2c3q4UC1+y14hs88FVWt72ehD6RKCeRVOMutE1qE/QyI5DXPsAJ54xNwJG4IPKuDwANbnVjNqm0Nq4sNHkSqs0hUys5Y74txpVB0UZcs3qyul6rZIipxQceeKTukJsSNhgvRB4Atrto7PiLVad0ETBGkfcA=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB2821.EURPRD10.PROD.OUTLOOK.COM (20.179.2.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Wed, 12 Feb 2020 12:41:15 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 12:41:15 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Shreyas Joshi <shreyas.joshi@biamp.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3] mfd: da9062: add support for interrupt polarity
 defined in device tree
Thread-Topic: [PATCH V3] mfd: da9062: add support for interrupt polarity
 defined in device tree
Thread-Index: AQHV3L9+iYKeveLLe0mjuHlLhDTzkagXh4/A
Date:   Wed, 12 Feb 2020 12:41:15 +0000
Message-ID: <AM6PR10MB22633D335FAD6AF40FA344F3801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <20200206073126.zf3ahv3b3lafctcn@shreyas_biamp.biamp.com>
In-Reply-To: <20200206073126.zf3ahv3b3lafctcn@shreyas_biamp.biamp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96771219-814d-4148-ae84-08d7afb8d97b
x-ms-traffictypediagnostic: AM6PR10MB2821:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB28211D8410DD43261F1CA959A71B0@AM6PR10MB2821.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39850400004)(376002)(346002)(136003)(199004)(189003)(2906002)(53546011)(52536014)(4326008)(6506007)(26005)(8936002)(55236004)(186003)(5660300002)(55016002)(9686003)(478600001)(71200400001)(86362001)(316002)(66446008)(81166006)(110136005)(81156014)(8676002)(64756008)(76116006)(66476007)(7696005)(33656002)(66946007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2821;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qJ2h/ErEbkTbyz8OsP/QmPeQVUfphqoonRKvrEAEVB01yRLA61SKUya3ce2QXevIsJmv8wto9B2/e2usvveOjlMN2RECg3zCRekyqv7N+XEMQxFOihNrrJRlD8EgrhTsyBvMXW0dVVzS097H2zLC0I4oWBmyOTd/sdGXGUEor6DwovGDpfOMG3AQI+zsLYQXK/Gg1dXQ2O3fYoIlQR5XbvgkrPOVTbXzZnm3cKFfbZ6nI/XaMLGs7pamxkMMiJyi6Rcf6KRuiXst7+vO0vm11tlVkeT/OwA9YdKW7/hlFDI/9Le6rKVPNJhCfo/87jBnTXGCzXRZYQfnI+MYxVq9+BmaSxwFnPJF4n+mp4A7P9PtX6LTpPFJbQI/hIc+eEmuYkzoJhF8tsVUrYdbwAB5V6mlqYqhiq4CuGUArfICbJrv8u21Xm+kxYXqqKclFEk
x-ms-exchange-antispam-messagedata: EoPuqfqjSNQ8WtR9WNUKBSGrqw6CUiPSuAQtU7nJjbQRFOUIxgoiL1715jYfe18mbHAOhpwoQU+luo/bm/88YPcgnhRzS0ktxlHGEbHyDrQWL53lRIVNQ8slVNmvyrtygSfxrJCe81LlLJBgcVsWKA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96771219-814d-4148-ae84-08d7afb8d97b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 12:41:15.2929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2wb10ZWCJfJByWeOC2ZbZezJZx6+WnaFZvu3yKOAGPYaY2RRH+LzKtaqLiIxPEwuoFLmg9foW+2vsBTUIjiP2STLwMf3fYtbyycOk/K1lQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 February 2020 07:31, Shreyas Joshi wrote:

> The da9062 interrupt handler cannot necessarily be low active.
> Add a function to configure the interrupt type based on what is defined i=
n the
> device tree. The allowable interrupt type is either low or high level tri=
gger.
>=20
> Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
> ---
>  drivers/mfd/da9062-core.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index 419c73533401..c44a48ba3d05 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -369,6 +369,32 @@ static int da9062_get_device_type(struct da9062 *chi=
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
> +		irq_type =3D 1;
> +		break;
> +	case IRQ_TYPE_LEVEL_LOW:
> +		irq_type =3D 0;
> +		break;
> +	default:
> +		dev_warn(chip->dev, "Unsupported IRQ type: %d\n", *trigger);
> +		return -EIO;

Don't think EIO is the correct return code. Think EINVAL is more appropriat=
e.

> +		}

Indentation here for closing bracket isn't right. Make sure you run this th=
rough
the checkpatch.pl script.

> +	return regmap_update_bits(chip->regmap, DA9062AA_CONFIG_A,
> +			DA9062AA_IRQ_TYPE_MASK, irq_type);
> +}

This won't work. 'irq_type' needs to be shifted the correct number of bits.
See DA9062AA_IRQ_TYPE_SHIFT.

> +
>  static const struct regmap_range da9061_aa_readable_ranges[] =3D {
>  	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
>  	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C),
> @@ -417,6 +443,7 @@ static const struct regmap_range
> da9061_aa_writeable_ranges[] =3D {
>  	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
>  	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
>  	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
> +	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_B),
>  	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
>  	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
>  	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
> @@ -596,6 +623,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  	const struct regmap_irq_chip *irq_chip;
>  	const struct regmap_config *config;
>  	int cell_num;
> +	u32 trigger_type =3D 0;
>  	int ret;
>=20
>  	chip =3D devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
> @@ -654,10 +682,14 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  	if (ret)
>  		return ret;
>=20
> +	if (da9062_configure_irq_type(chip, i2c->irq, &trigger_type) < 0) {

You're returning error codes from 'da9062_configure_irq_type' so why are yo=
u
overriding what's returned with -EINVAL below?

> +		dev_err(chip->dev, "Failed to configure IRQ type\n");
> +		return -EINVAL;
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

