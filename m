Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E627CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846DD2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uqwf/p3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGACwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:52:06 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:63397
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgGACwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:52:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oac1PoiOQNb5dWjD5E3QRo/VkUpys+YNczIXtZgoNakMPRdys/D7GulN5OpQ5R+zNDljwZ/rpeqNygyuzWLTtNwU9OJEeJHQsFgO31oceNswWyDTCw0ptDw2WuwW33XUa0FmkwxL+l9hMYjEW16XO2xSytJGFWaMZ2MtftLGbIZmITrP8gH8rjsSJCHso+VSc6ESx9+qrMx3VxfuYCX/Su0RSHEzF4l1rt1mpAJsM05ngqpfga7xgAy7J67mvjRGstKnu3SICfAW7yT5crtGLIH+UiDyLfoGGkvNbePETME46pEUHzXm7zpVpX3gdedC93YZoe09PXhMCgMDhJuHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwluqcS5XLGeYrYzgQfbbAToVlCuofuvJ10xP7weyaM=;
 b=Wd2sbXZVQviYqFZUYxb0E0b66EC2VyirmEX7SxUa/IEbnyK1EwzxOtkdNkgG4BX4UD557G10jfibKSjJ894RtzOLshm1RJgYqarb49E6N3/Cfx5/oPdBWmezgjkZPBIhIw0KcAWI5DFAzXnHV4TeZjR3Go2LYJVdjDxzAes8gI+3RrWVVqzOngLU68ndyZ0Jc1rDQmJUhcXrnrFeZQTK1YV5aN5c9HbSLd8ydLF74IXGEa/KKQTEJEb/6Lbl4dxOrJJmBzF74maMkyy4fVh/bTV81AVya4CYChs3gA/aQ0KK7+t3U9pnp6D6cjhSfiTy7P/kPTqV2R8ZpFf+23t+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwluqcS5XLGeYrYzgQfbbAToVlCuofuvJ10xP7weyaM=;
 b=Uqwf/p3yY2jC6ZjciJSA/xGOZSrj3d0ZX93xl2H+UEX2iX4w8U/9/jRsSRN3Qcdp+TdafHDcwkqA5YmLHV2HKsHLZ85s9jmjXR2z0UgA+qlphiOZgEbvVj9TNsH2L3QPNyAK00xesuvNK9DDG0owGCtrY9KgABg10+szBj4O7d4=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB5496.eurprd04.prod.outlook.com (2603:10a6:20b:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Wed, 1 Jul
 2020 02:52:00 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 02:52:00 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Topic: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Index: AQHWS6lrNGtWbd2boEmTo3bADIlBSqjvNguAgAAr6YCAAPWjgIAAvP+AgAD5YgA=
Date:   Wed, 1 Jul 2020 02:52:00 +0000
Message-ID: <20200701025223.GA11041@b29397-desktop>
References: <20200626110311.221596-1-philippe.schenker@toradex.com>
 <20200629072703.GC30684@b29397-desktop>
 <88f0a5bf564eded8b210457204facdf2c7a9c5dc.camel@toradex.com>
 <20200630004323.GA12443@b29397-desktop>
 <7ee055810cb7c4a06bf978f3d443c908f237c006.camel@toradex.com>
In-Reply-To: <7ee055810cb7c4a06bf978f3d443c908f237c006.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toradex.com; dkim=none (message not signed)
 header.d=none;toradex.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b3cbd72-5c55-4150-fccf-08d81d69ba50
x-ms-traffictypediagnostic: AM6PR04MB5496:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR04MB54968262EA1B2C00944EE03A8B6C0@AM6PR04MB5496.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j0Est4Wg2wtTyQCbEMMYQ2nuNwYBlES/cYVNS+fqCjWb9fox8OiIojdM6szwSdVNhkC0wy0Q6NFv1fQnlRqtPHxfnMVYKio8Q0zoPEz1ymI+RCFKUbRNSjWCIeOd9SgA3yBG4BpYC6ehPqsBz4R7+bym7LB9b1hBU57x1AN1aemBEG+JjF4rvqQVu952iNYDkLcXVXlwgWHtDlro/mos3te0gF2Si6NsBRATC6dS3VrXOApnjmF8W6rEpkkHleDCUbIlnq9anjVO7n6hcuSOKRQ81eOHZKjuGd4qOGFLAingm7a3257dLE71BUKBh1489p28c4tS2sQGph80H1+PvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(366004)(396003)(346002)(39860400002)(136003)(376002)(1076003)(54906003)(66446008)(76116006)(66946007)(2906002)(86362001)(53546011)(6506007)(91956017)(316002)(6512007)(9686003)(66556008)(66476007)(64756008)(4326008)(5660300002)(33716001)(44832011)(6486002)(6916009)(8676002)(478600001)(26005)(83380400001)(71200400001)(33656002)(186003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: gMVXPgIh7871rRD/2ch5KWsp7d+IbZvafQX020nf3oMiPUJPxE224ficWarLYSRI7JDtmKgILQaXCHBGKVxLOCQGx6/2bj0JPhBcc533CXqv54Y//7zTdyt8aFikgjWB+lZAhc6xM8e8SN6WElh30s1Kdn2ZhdXLIbXC/F8HCCbDjINHY06gLRNtO3eo+IchqYitu4kFvIfmhfUylvpdpushstopTM35LvCdQi/OG/vOg2ZpaG/lPVHo6sN2nmIeKhlOg2gpQrn1eUt8CS8bjiwXxYJpspkVhJNy3pK8bGBZbuTx9JMYIPSphavimb95wuUO+FIlV80qF+78gzTW3KtjJSdF3WxDtN7XF+vOuFX3q3u3UXqQtoD5+FP/Xab1cDtYtGVbjvgSxDz3RC1Lw47QUj0Xa8IzbEuuycaU3yLTVyyY2VhbPbKPxu3sv2t/psTay0bDBEkEtKEWNBaTWoNG/h235hWKKVpmOM/fiWg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C913C65A0A6BA41894449CDA16825E6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3cbd72-5c55-4150-fccf-08d81d69ba50
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 02:52:00.6929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoCu0rKADb45kwOJG8BMUMN+3SG8LbaxNE4NL4G9WS1kEC7H+GIAiqZfWjQde0Iyg5tfORsvFa7iVZFQioyoBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-06-30 11:59:49, Philippe Schenker wrote:
> On Tue, 2020-06-30 at 00:43 +0000, Peter Chen wrote:
> > On 20-06-29 10:04:13, Philippe Schenker wrote:
> > > On Mon, 2020-06-29 at 07:26 +0000, Peter Chen wrote:
> > > > On 20-06-26 13:03:11, Philippe Schenker wrote:
> > > > > If the hardware is in low-power-mode and one plugs in device or
> > > > > host
> > > > > it did not switch the mode due to the early exit out of the
> > > > > interrupt.
> > > >=20
> > > > Do you mean there is no coming call for role-switch? Could you
> > > > please
> > > > share
> > > > your dts changes? Try below patch:
> > >=20
> > > Here are my DTS changes:
> > >=20
> > > diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> > > b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> > > index 97601375f2640..c424f707a1afa 100644
> > > --- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> > > +++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> > > @@ -13,6 +13,13 @@
> > >                 stdout-path =3D "serial0:115200n8";
> > >         };
> > > =20
> > > +       extcon_usbc_det: usbc_det {
> > > +               compatible =3D "linux,extcon-usb-gpio";
> > > +               id-gpio =3D <&gpio7 14 GPIO_ACTIVE_HIGH>;
> > > +               pinctrl-names =3D "default";
> > > +               pinctrl-0 =3D <&pinctrl_usbc_det>;
> > > +       };
> > > +
> > >         /* fixed crystal dedicated to mpc258x */
> > >         clk16m: clk16m {
> > >                 compatible =3D "fixed-clock";
> > > @@ -174,6 +181,7 @@
> > >  };
> > > =20
> > >  &usbotg1 {
> > > +       extcon =3D <&extcon_usbc_det>, <&extcon_usbc_det>;
> >=20
> > If you have only ID extcon, but no VBUS extcon, you only need to
> > add only phandle, see dt-binding for detail please.
>=20
> You where right again! Thanks, this actually solves the RNDIS issue for
> our colibri-imx7 board:
>=20
> +       extcon =3D <0>, <&extcon_usbc_det>;
>=20
> Howevever on this iMX7 board we have VBUS hooked up to the SoC, that's
> why it works only with ID.
>=20
> On Colibri-iMX6ULL we do not have VBUS hooked up.

So, there is no any events for connecting to Host? If it is, the
workaround for this board is disable runtime pm. And you only need to
write one extcon phandle for ID since you have external event for ID,
but no event for VBUS. ID event is not the same with VBUS, for example,
if you plug cable into host, you will not get the ID event, you could
only get VBUS event if there is an event (eg, through GPIO) for it.

Peter

> So device/host
> switching works only with 'extcon =3D <&extcon_usbc_det>,
> <&extcon_usbc_det>;' but then RNDIS and also a normal thumb-drive does
> not work. How could I work around this fact? A dummy-gpio that would
> always read "high" for vbus would be a solution for me.
>=20
> Philippe
>=20

--=20

Thanks,
Peter Chen=
