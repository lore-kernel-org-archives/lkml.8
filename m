Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D414DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB8F20760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QulTsQJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgF3AnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:43:06 -0400
Received: from mail-eopbgr00066.outbound.protection.outlook.com ([40.107.0.66]:33344
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726959AbgF3AnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:43:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E66fBf1tHUXMYMUdLbb0z0QlzaCvd/4SfkD4GWA2Xg6SSb3MBCe0bS+znV2ebrljJogZQVo9U2ou8QpetAklGIw5o3aQGc6/2omExyTSrf8HBK2JdE30i+MPXSV5S0d9VFcCBK9grgyNF6m2aLa0fFAzoX78E6dg77MWNbAmzY5AEFABmxhbUDMObsmHHqGdMQ9Y2QrLiQrDTg4GtjFt220OxbJ6CkPn6BF8dAACtHCETt0mtm4Kw7ovmw1Jp6WeFJRlc2ZwIQsHfOMwtAXG3r1/w/P41eekjvLvI/58/YJuAIuWpxIYjwD+QxlsdCpJh49Kr05f2EJAu/iy+Jc8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eqq9t5OO5wzBrOjemkF1jNnBo+FtsZqTSbEFhMwIhM=;
 b=LKmnC02y5fuI4wp2RY/Jqg3eA5GLRe+4rPw0GVsO3r4puXpvckca+fdJifhAmchfTIOm3OecRu1hnxqQsXWtvj6uFUI/+Dz78Cqd3VCb49zpud76opK5PpNkLJrtDaywjMK4KuZ/X8GUG4AinjIaSMbsajo3FWbtJGGQ2Ur1CtQcgn58oAWIj6jKZ1we7BfpDvHoUtqx+xa1AWsv9VLd1UlzRpeoj2MlMN9hwlMWSvVubssa+x33mkIEx6JOcZMlw8E45ZC+KYLTn2rNj88fTewjuU1bT9nCZCa9vAWykmYqn+Ofadovjs53LGczpqIhEthF6N4fh5FNJYb2Ii+/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eqq9t5OO5wzBrOjemkF1jNnBo+FtsZqTSbEFhMwIhM=;
 b=QulTsQJbQg3rmI1t9UT4ZtHJf2rqSlB05Njeyz+7SXTEDivS1jJD2YCoxmlkVdpnjvjlwpppOjLz5WCx3VyRAJVUVugdrTtfMweRSPigi29bkFJX2SWiwzwXtPZW/g8Oe8DWfeDNVKGoKLaOj8SOJHi9AmQy7IwAQfGlMybSNv0=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB5911.eurprd04.prod.outlook.com (2603:10a6:20b:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Tue, 30 Jun
 2020 00:43:00 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 00:43:00 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Topic: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Index: AQHWS6lrNGtWbd2boEmTo3bADIlBSqjvNguAgAAr6YCAAPWjgA==
Date:   Tue, 30 Jun 2020 00:43:00 +0000
Message-ID: <20200630004323.GA12443@b29397-desktop>
References: <20200626110311.221596-1-philippe.schenker@toradex.com>
 <20200629072703.GC30684@b29397-desktop>
 <88f0a5bf564eded8b210457204facdf2c7a9c5dc.camel@toradex.com>
In-Reply-To: <88f0a5bf564eded8b210457204facdf2c7a9c5dc.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toradex.com; dkim=none (message not signed)
 header.d=none;toradex.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7087e0d-0cde-4717-b049-08d81c8e8a3e
x-ms-traffictypediagnostic: AM6PR04MB5911:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR04MB5911C8E54E6EB184C6587D858B6F0@AM6PR04MB5911.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FpIkIXKj2MTWx+lX3bg8Kz0hyO07/JSnoIw2llTyvT7tPgLHftUWf+x9+m4XlqBEu76teCNhXMFsbEbmszJnvO1JbiSP4984EuNIOnBrcBGDepq/d8BDYbflfXZQu7aegre4j7I/d6Co6WKJACZXgIpxmf8Kyn+zfZUlj7ZXN5SVJRc6P3e0INE7ajcRR7TULd1/2ym+sOxTpWBeMUuWstKZ6H5XmLpnOXRTrXmQlN+YJ9EeiC9l9hqHUWu3aFkZmT2mKtaTX294XR0Pr7H3dzo1mrpdWNcRpBNvIbRJZlqERBGg5Ag0druTonhLIxvJDcXx7+wec3+FQUabJAGw0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(39860400002)(376002)(346002)(136003)(366004)(396003)(83380400001)(64756008)(86362001)(66446008)(9686003)(6512007)(66556008)(66476007)(6916009)(4326008)(54906003)(1076003)(33656002)(186003)(53546011)(316002)(8676002)(478600001)(5660300002)(6486002)(76116006)(66946007)(8936002)(26005)(6506007)(91956017)(2906002)(33716001)(44832011)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BZNjcvW4ZlqfltZFp7V3n6ovxySqlxAl6TZBegInJLL+eQZMzypiaZ5uhVMOw182AQ3gL2UhMnyAl/m5HwhFZrqctH4hs02IPHunPFI87VH9eRVhaXi6xURoJUMUG5mZ2f8vhG/2YycgHNHLxc/b6fsQUqfUI/cbCmxxQPi5+Jw/0qKPe9IoVuXFBAlCDd1UBHBos1FXnXJSlq7LTslI5AeQT1YtF96QRK4+eXnTTJ6lkMQPZ2u5XjWKTSp5TPST5CgibY6Tp2D+mLlcSZ3c/l/TKgTM7ZrtoymLRDXB6Hm95R+JSbtNVwvG6XAq0go/NQovoj2u7bfAsgb3d3O5YKhXNG5KePWF0wGVydnGfyOzHCbYwlbsUD21YT8C6lCJp/y4q5lF2kzp51Q2CHXm99a8kBJVndThCxRY/VTTAQ2QjR9kJajHv1SqY1MhrpirOeK0SjTNmMs6TxOoTDtFudhRQnzaoIKmAMsqEHA0Zuc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <452AFB99CCC2C24F98D0011042D3DA46@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7087e0d-0cde-4717-b049-08d81c8e8a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 00:43:00.2317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEA3YofHQFmqdU89VfNOdZ6G1kTBAtUeUV5MZcjUuipxPXGqfwy48Laj4BxKoKk4LcFQGPX7IuyhNJEDguaJzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-06-29 10:04:13, Philippe Schenker wrote:
> On Mon, 2020-06-29 at 07:26 +0000, Peter Chen wrote:
> > On 20-06-26 13:03:11, Philippe Schenker wrote:
> > > If the hardware is in low-power-mode and one plugs in device or host
> > > it did not switch the mode due to the early exit out of the
> > > interrupt.
> >=20
> > Do you mean there is no coming call for role-switch? Could you please
> > share
> > your dts changes? Try below patch:
>=20
> Here are my DTS changes:
>=20
> diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> index 97601375f2640..c424f707a1afa 100644
> --- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> @@ -13,6 +13,13 @@
>                 stdout-path =3D "serial0:115200n8";
>         };
> =20
> +       extcon_usbc_det: usbc_det {
> +               compatible =3D "linux,extcon-usb-gpio";
> +               id-gpio =3D <&gpio7 14 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_usbc_det>;
> +       };
> +
>         /* fixed crystal dedicated to mpc258x */
>         clk16m: clk16m {
>                 compatible =3D "fixed-clock";
> @@ -174,6 +181,7 @@
>  };
> =20
>  &usbotg1 {
> +       extcon =3D <&extcon_usbc_det>, <&extcon_usbc_det>;

If you have only ID extcon, but no VBUS extcon, you only need to
add only phandle, see dt-binding for detail please.

>         status =3D "okay";
>  };
> =20
> diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi
> b/arch/arm/boot/dts/imx7-colibri.dtsi
> index e18e89dec8792..caea90d2421fd 100644
> --- a/arch/arm/boot/dts/imx7-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
> @@ -457,7 +457,7 @@
>  };
> =20
>  &usbotg1 {
> -       dr_mode =3D "host";
> +       dr_mode =3D "otg";
>  };
> =20
>  &usdhc1 {
> @@ -486,7 +486,7 @@
>  &iomuxc {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3
> &pinctrl_gpio4
> -                    &pinctrl_gpio7 &pinctrl_usbc_det>;
> +                    &pinctrl_gpio7>;
> =20
>         pinctrl_gpio1: gpio1-grp {
>                 fsl,pins =3D <
>=20
> >=20
> >=20
> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > index e8ce300ad490..9e10dcfeb98f 100644
> > --- a/drivers/usb/chipidea/core.c
> > +++ b/drivers/usb/chipidea/core.c
> > @@ -1313,6 +1313,29 @@ static void ci_controller_suspend(struct
> > ci_hdrc *ci)
> >  	enable_irq(ci->irq);
> >  }
> > =20
> > +/*
> > + * Handle the wakeup interrupt triggered by extcon connector
> > + * We need to call ci_irq again for extcon since the first
> > + * interrupt (wakeup int) only let the controller be out of
> > + * low power mode, but not handle any interrupts.
> > + */
> > +static void ci_extcon_wakeup_int(struct ci_hdrc *ci)
> > +{
> > +	struct ci_hdrc_cable *cable_id, *cable_vbus;
> > +	u32 otgsc =3D hw_read_otgsc(ci, ~0);
> > +
> > +	cable_id =3D &ci->platdata->id_extcon;
> > +	cable_vbus =3D &ci->platdata->vbus_extcon;
> > +
> > +	if (!IS_ERR(cable_id->edev) && ci->is_otg &&
> > +		(otgsc & OTGSC_IDIE) && (otgsc & OTGSC_IDIS))
> > +		ci_irq(ci->irq, ci);
> > +
> > +	if (!IS_ERR(cable_vbus->edev) && ci->is_otg &&
> > +		(otgsc & OTGSC_BSVIE) && (otgsc & OTGSC_BSVIS))
> > +		ci_irq(ci->irq, ci);
> > +}
> > +
> >  static int ci_controller_resume(struct device *dev)
> >  {
> >  	struct ci_hdrc *ci =3D dev_get_drvdata(dev);
> > @@ -1343,6 +1366,7 @@ static int ci_controller_resume(struct device
> > *dev)
> >  		enable_irq(ci->irq);
> >  		if (ci_otg_is_fsm_mode(ci))
> >  			ci_otg_fsm_wakeup_by_srp(ci);
> > +		ci_extcon_wakeup_int(ci);
> >  	}
> > =20
> >  	return 0;
>=20
> Thanks for creating this patch! I wanted also something like that, but
> couldn't find out where to put it.=20
>=20
> I tried this patch and with the above devicetree changes this works
> perfectly! Thanks Peter!
>=20
> Should I send the patch with you as the "Suggested-by" or do you want to
> send the patch so you are the Author? I would have it ready in my git
> repo.

This patch was a part of one patch at downstream, I will submit one and
add your tags.

> > >=20
> > > Hi Peter
> > >=20
> > > During my investigation I found a bug in ci_irq. I would appreciate
> > > if you could review this. From what I see this patch should be save
> > > to apply.
> > >=20
> > > This patch does not solve all of our issues. When I have RUNTIME_PM
> > > enabled on imx6ull or imx7. RNDIS still does not come up. So there
> > > has to be another bug hiding somewhere in the Runtime PM code to
> > > prevent
> > > RNDIS from working properly. I quickly looked through your patches
> > > that added this stuff back in 2015 but couldn't spot anything
> > > related to
> > > usb gadget-mode.
> > >=20
> > > If you right away know where the problem could be hiding itself,
> > > I would appreciate a hint.
> > >=20
> >=20
> > I need information for call trace for further suggestion.

With this patch, does your RNDIS issue be fixed or still not?

Peter
> >=20
> > Peter
> >=20
> > > ---
> > >=20
> > >  drivers/usb/chipidea/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/usb/chipidea/core.c
> > > b/drivers/usb/chipidea/core.c
> > > index 9a7c53d09ab4..5159420a23a4 100644
> > > --- a/drivers/usb/chipidea/core.c
> > > +++ b/drivers/usb/chipidea/core.c
> > > @@ -518,7 +518,7 @@ static irqreturn_t ci_irq(int irq, void *data)
> > >  		disable_irq_nosync(irq);
> > >  		ci->wakeup_int =3D true;
> > >  		pm_runtime_get(ci->dev);
> > > -		return IRQ_HANDLED;
> > > +		ret =3D IRQ_HANDLED;
> > >  	}
> > > =20
> > >  	if (ci->is_otg) {
> > > --=20
> > > 2.27.0
> > >=20

--=20

Thanks,
Peter Chen=
