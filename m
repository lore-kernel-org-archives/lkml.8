Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CD8C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A600F2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="TFLdMQiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgA3J5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 04:57:45 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.117]:46578 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbgA3J5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 04:57:45 -0500
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.eu-central-1.aws.symcld.net id 79/FC-01390-598A23E5; Thu, 30 Jan 2020 09:57:41 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRWlGSWpSXmKPExsWSoc9kqTt1hVG
  cwfd1Qhb3vx5ltLi8aw6bReeiBkaLO9fbGR1YPB52X2D32DnrLrvHnWt72Dw+b5ILYIlizcxL
  yq9IYM3o+HqNreCYRMWcr0dZGxh3inQxcnEwCixllpjx5RZLFyMnkHOMRWLpXG6IxGZGid+9P
  9lAHBaBE8wSb659ZQRxhAQmMUn8+tYE5dxnlNh95CQbSD+bgIXE5BMPwGwRgb+MEn/OaIDYzA
  KOErf3vmUCsYUFYiTubDzDDlETK9FweiojhG0kMXXmCVYQm0VAVaJvySNmEJsXqObn53lANRx
  Ay1wlvu4RAwlzCrhJtF+4xAZxtqzEl8bVzBCrxCVuPZkPtkpCQEBiyZ7zzBC2qMTLx/9YIepT
  JU423WCEiOtInL3+BMpWkpg39wiULStxaX43lO0rsXDJK3YIW0vi7ZFpbBC2hcSS7lYWkNMkB
  FQk/h2qhAjnSBz/cgqqVU3i6qejLBC2jMTOVbdZQcEmITCLReLptivMExgNZiE5G8LWkViw+x
  MbhK0tsWzha+ZZ4JAQlDg58wnLAkaWVYwWSUWZ6RkluYmZObqGBga6hobGuia6RkZ6iVW6SXq
  ppbrJqXklRYlASb3E8mK94src5JwUvbzUkk2MwLSUUsgitoNx1tr3eocYJTmYlER5WfuM4oT4
  kvJTKjMSizPii0pzUosPMcpwcChJ8DICE52QYFFqempFWmYOMEXCpCU4eJREeL1A0rzFBYm5x
  ZnpEKlTjMYcE17OXcTMsfPovEXMQix5+XmpUuK8/suBSgVASjNK8+AGwVL3JUZZKWFeRgYGBi
  GegtSi3MwSVPlXjOIcjErCvCYgU3gy80rg9r0COoUJ6JRviQYgp5QkIqSkGpjEC7cK7rtgvPO
  cTLYid++JdR4xK09OjPXLVC0oiVS7ntj7cuXKf0tyTFMuWxYttQt6l2a6XfLCz87ud7csvoiv
  kP25jPG190x5h+a+nce3SxT57vV8ZxR47uUBIbUuudV3H29+x7bocbbt6QPtkxSmTEvinZy3d
  Irmw7XLtT5v6eE/FOr4q1LAxzi41Fmv2dv9geElp7jwqxJr+aft432why3LfdGP+fc23CwWlG
  vo+tDElXNJ4OlhFbXdb6rj/5VdOMWVxc5bMHFLyXSmU3u+WfB5xifUalk1tz4zknEJ3isd7Bm
  cL2/5pGT5ZstFd+8yvXhfbnrl0srzjD8Fah/Nfyaepl/NwKsW2+QU9FiJpTgj0VCLuag4EQDH
  k1ltWAQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-15.tower-246.messagelabs.com!1580378260!166361!1
X-Originating-IP: [104.47.2.57]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26374 invoked from network); 30 Jan 2020 09:57:41 -0000
Received: from mail-db5eur01lp2057.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) (104.47.2.57)
  by server-15.tower-246.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Jan 2020 09:57:41 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luMyt95dxmT+9jTeJd179kSwlS8ClhQWISy0zY5mRKePKJFPCAojLu3fqxCxVjgFu/WlTFhPe7WvCchvBeyDBhvRXCoOFI2QJeevfm04tm4CHvlQB5x/P99EX/KIFbcGWgfeqiZQU5HY9m2eMq3gpPvKrbHL/gPRRUuJa7v8sNug6J/EkyVehIkYBrOwJ86utbuaj96klNS6YA0SwLxQ5mJLoYm0Itj4//2OuRd7ZqovtHWOpoprY+Ud9EEQ9UAF2zalL9ahOdXqC2eQAXPrgDIgTd7Jdz/iYgJGkfJdFwBeZE3+FDwFYAwJX/z/qIbbkGi952XPyASkyfcT3MDtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VphI12yJUCvLBKMqfv4Jq3ANzM++FK36RlFYOcMbXo=;
 b=TAcb8SdoMXm84zqdDT3qpahHxXmem2yxGs9JpyLQ9Bdi3h6LXiwLhsfpn7HL1SpQoNrL45NTT+3j6+9CSxnuxnp7QY+KbKJMp8ZmgtXiamedDpWHs6YUB+/i0zKYj+JiWoRmmv4OEGJikr7TRpJ/ZflZYK+98OkGp/Ndgjml3Mk0OMt5LW+E0Z6Fo91141J5GvdwN7SJpBE4lCLpZIOFmE8Ufc2O+67SnwSae0ggiKpZyTJIi0IVPtRjYKJ6JYFi8UtZ4LxOGXTbEw7bCP/4Ex3Gpy1FsdxZ31Zr66FBicu/3tpaxZUiU5B0mvFZol/LsnC28tNnn4DUrBEW5zDhRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VphI12yJUCvLBKMqfv4Jq3ANzM++FK36RlFYOcMbXo=;
 b=TFLdMQiqU54jc5+Tpu6G8+R/67K4ZrarfCJQMD7jzOtWO8IK4/oNAlE8De75NFWyeQQAlOys+4v4gHjUvmQDUcF32sAe6+38Ect9GneXAHqCBEKP+AtzJBADDVVadXuclj8NY8fX6pVaiVVMtkY/DzfOM84wkfJUJcUCuT8HMkc=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB2086.EURPRD10.PROD.OUTLOOK.COM (52.134.113.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 09:57:39 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f8b1:d153:8394:6454]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f8b1:d153:8394:6454%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 09:57:39 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Shreyas Joshi <Shreyas.Joshi@biamp.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mfd: da9062: add support for interrupt polarity defined
 in device tree
Thread-Topic: [PATCH] mfd: da9062: add support for interrupt polarity defined
 in device tree
Thread-Index: AQHV1vqvrnZ+m6pd90mES33Xb0II9KgC+EtQ
Date:   Thu, 30 Jan 2020 09:57:39 +0000
Message-ID: <AM6PR10MB226310AB7693DEAA44EFA90D80040@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <20200129232007.tmpc7p6l5ouibvwh@shreyas_biamp.biamp.com>
In-Reply-To: <20200129232007.tmpc7p6l5ouibvwh@shreyas_biamp.biamp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddffac52-a744-4adc-6b37-08d7a56ad761
x-ms-traffictypediagnostic: AM6PR10MB2086:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB20867EB4AC877DB29794C5F8A7040@AM6PR10MB2086.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(189003)(199004)(71200400001)(26005)(8676002)(33656002)(4326008)(478600001)(5660300002)(53546011)(186003)(8936002)(81166006)(81156014)(7696005)(2906002)(9686003)(110136005)(55016002)(76116006)(66476007)(52536014)(64756008)(66556008)(66446008)(6506007)(316002)(55236004)(86362001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2086;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YvmBpiM9b0nQPeTP1uZ/Evezlsx2HXxavQMweS7ehQdx78fwuKz3tolu3TTyOgXH3iaIoOOKn/ykUDXCNMy5Nm2nt81m2RNQ+2OLYYdo0EQyCd0p2lNYs8AVGvHdV08zFvaJgrSiByIEnJFoLfJJUDSpzD6/kMNLWiWzbEhFDkYvksQiCwu9a3+Vw2OPRqOcqOg/X21J/RUGoRq7+JFoujRKfjJV5CefIyrvgdj42Cc5SZziS8caOAFYyLsba296yYqcYBFdxg6ifTMIfBWtXITypYJb0ItzJ59HBW3Wg2a7P6OrQbWIkID3CVfUEHf7HxU2p46CbqM/Ua79Aadz5jcctCAUfx24hGaLbEf4yORWFFpuqrFVZ7f12ULI9Z7lA03WE6wOQ165NIXwFzs7SjcxbpjXIdMMwLBaSVavrsDqoPznKSs8E9irpNldmO3H
x-ms-exchange-antispam-messagedata: wAf1KtrEue+b8IcWm4AopLovsLrGM9gmSk5apRKK1FYCs/dSj9dYI2daFUIhfq0PurHj5R7Bws5OUGqEcQMPX4qcH5Z7oZaKQvYyMUFDgIJQOP+bUmpiSMDgv7FWMTidKenwextogfaDm55LS6YlDg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddffac52-a744-4adc-6b37-08d7a56ad761
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 09:57:39.3717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Fv8XL0wXpRIztAOJ++/fZBcZ1wGakUhYSd17qWBeI0aMdh29YMDXpkDvWrhRqrXRcERKHy8TeIi4h2Rt5aSbCqZSKOrPyUYbv06MNUwn5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 January 2020 23:20, Shreyas Joshi wrote:

> The da9062 interrupt handler cannot necessarily be low active.
> Add a helper function to read the polarity defined in the device tree.
> Based on the user defined polarity in device tree, the interrupt is
> set active.

When sending an updated patch you normally add a version identifier to the =
patch
title/subject, for example '[PATCH v2]'.=20

>=20
> Signed-off-by: shreyas <shreyas.joshi@biamp.com>

Would suggest using your full name above in the 'Signed-off-by'.

> ---
And under here you would normally add a description of changes in each vers=
ion
of a patch. Don't suppose it matters too much this time, but just for futur=
e
reference. See 'Documentation/process/submitting-patches.rst' for further
information.

>  drivers/mfd/da9062-core.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index 419c73533401..62ba10aeb440 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -369,6 +369,22 @@ static int da9062_get_device_type(struct da9062 *chi=
p)
>  	return ret;
>  }
>=20
> +static inline u32 irqd_get_polarity(struct irq_data *d, struct device *d=
ev)
> +{
> +	u32 trigger_type =3D irqd_get_trigger_type(d);
> +
> +	switch (trigger_type) {
> +	case IRQ_TYPE_LEVEL_HIGH:
> +	case IRQ_TYPE_LEVEL_LOW:
> +	case IRQ_TYPE_NONE:
> +		return trigger_type;
> +	default:
> +		dev_warn(dev, "Invalid IRQ type: %d defaulting to
> IRQ_TYPE_NONE\n",
> +				trigger_type);
> +		return IRQ_TYPE_NONE;
> +	}
> +}
> +
>  static const struct regmap_range da9061_aa_readable_ranges[] =3D {
>  	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
>  	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C),
> @@ -592,6 +608,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  	struct da9062 *chip;
>  	const struct of_device_id *match;
>  	unsigned int irq_base;
> +	struct irq_data *irq_data;
>  	const struct mfd_cell *cell;
>  	const struct regmap_irq_chip *irq_chip;
>  	const struct regmap_config *config;
> @@ -654,9 +671,16 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  	if (ret)
>  		return ret;
>=20
> +	irq_data =3D irq_get_irq_data(i2c->irq);
> +	if (!irq_data) {
> +		dev_err(chip->dev, "Invalid IRQ: %d\n", i2c->irq);
> +		return -EINVAL;
> +	}
> +
>  	ret =3D regmap_add_irq_chip(chip->regmap, i2c->irq,
> -			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> -			-1, irq_chip,
> +			irqd_get_polarity(irq_data, chip->dev)
> +			| IRQF_ONESHOT | IRQF_SHARED | IRQF_ONESHOT
> +			| IRQF_SHARED, -1, irq_chip,
>  			&chip->regmap_irq);

I think you miss my point here. The HW has the option to be either ACTIVE_L=
OW
(default) or ACTIVE_HIGH. If DT is specifiying for example ACTIVE_HIGH but =
the
HW is configured for ACTIVE_LOW then you would likely see an IRQ storm.

As mentioned before, I think you should update the setting in CONFIG_A regi=
ster,
regarding the nIRQ pin polarity, based on the DT selection you've read.=20

>  	if (ret) {
>  		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
> --
> 2.20.1

