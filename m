Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D46EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A1602078A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B/GSBvpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgGAJCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:02:50 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:14468
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728994AbgGAJCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:02:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTEcbTaaePnlzT49QPXv464dwnSB/6DuUcAwa7Rkf7n7kBpoHP5hZrZDf0lSx+k7MjVlrsTGIJ1BGAiOYjJ/5GEfvL2HwL26COKCPG3GDB9oCa6rXqU2AJToRxFiiCfobq1Jv16Q8lp9+CQ6UGqkST2noG3O5IStoQU6uthcepTjlC892OJp5sMq4yvI/H9yj0rouEMu4znfOY7cS76wsZOm44t4K/eAaLSuzku2e4Cg5UMq1nIhyV2Fcz3/PWVds/bZgU1z7iYesN7csp6NErJGSpsYRmorhzg8Mr/sTubG4KJGDJiyRcPqAY74rEEyNFpRBgIR6vEq8g4ANCGPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtlBwy8TKU6UUa9JbR7xxdsPgKeVccOjjdEaJgbC+xU=;
 b=eDTn0KGiKCEdXkSg6JKzpcbVqVCc6s4+XEo8katQaB14huFWk92JnvwCCb8EHCMOO5wM7E4tFuEVaAIOshsfuyWca36CU7lERApGvC6XaU39Wovra+3EGNlP9r+RLvThMQhqpE9ExMwVqWPvTDQfL9w3V78bFZSB7R7XqU9ZqBSq/mziis4P2raQb3KE9CzNfTz8apzghzG6UN8IpwfIt+KWSRx/T1OMIiCyrZk4Uff3TU0h0YnWlqc6qwOm1H1wy7tEeJ7jTILHtBjqp98FniZFHhHTuhbtZdzIwRUbbShelLqI7TZj8eMSEk4glvAA+N6BlF1MAbxQ/XUQ54gX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtlBwy8TKU6UUa9JbR7xxdsPgKeVccOjjdEaJgbC+xU=;
 b=B/GSBvpuPeDwsbGbim+BN0WSqNfbchU8ER7L23fkjl6lLFtDzJVsTJoYGOFYJ8Xk46fEawc5vUvaMJT1OJfb4u93pakKm/wF26CrawYRKYTiKyAajMKIp8h+PQJbtgh6PmGbYwEfTgZXN5c+G3ETwb6LKBpIKTEuEzVYdXKljNQ=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB4246.eurprd04.prod.outlook.com (2603:10a6:209:50::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Wed, 1 Jul
 2020 09:02:43 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.023; Wed, 1 Jul 2020
 09:02:43 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Topic: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Index: AQHWS6lrNGtWbd2boEmTo3bADIlBSqjvNguAgAAr6YCAAPWjgIAAvP+AgAD5YgCAAF78AIAACJcA
Date:   Wed, 1 Jul 2020 09:02:43 +0000
Message-ID: <20200701090305.GB22478@b29397-desktop>
References: <20200626110311.221596-1-philippe.schenker@toradex.com>
 <20200629072703.GC30684@b29397-desktop>
 <88f0a5bf564eded8b210457204facdf2c7a9c5dc.camel@toradex.com>
 <20200630004323.GA12443@b29397-desktop>
 <7ee055810cb7c4a06bf978f3d443c908f237c006.camel@toradex.com>
 <20200701025223.GA11041@b29397-desktop>
 <b5c61ae5f17b74624c1e2e4b08fc2fdcd1fb53f6.camel@toradex.com>
In-Reply-To: <b5c61ae5f17b74624c1e2e4b08fc2fdcd1fb53f6.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toradex.com; dkim=none (message not signed)
 header.d=none;toradex.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 238eae92-91e9-46a4-d6aa-08d81d9d842e
x-ms-traffictypediagnostic: AM6PR04MB4246:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR04MB424669DE63673EB062A44CF28B6C0@AM6PR04MB4246.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +AIOUD5f7/ttxMbTClzCO+632L6fKy/2erY89C2EIYwRCg+khLLVXDhHxJukefV4Srrnvq1EExPu1xg893sZ5RLuKY4tmjYSHao2z5gpyqiw7A9mjyX4WaECZeL/2r8xMx9HN20KIo+3ndqVUYvCVIahTkqj1G9C4wGZHVS5Hdn60+ci2EES45BOK/tIv1tl2tBtyM41PXt44YNAPjUTq6QUt8+gxpZTTdEPEsRJv+PhL1KzmvIRkL9zxBzp5MqSpcRy05+zz9XLWQomPxuuj6OMQUkJ+3SzY9kXyQIZ75aaGyGnPQV6Na520VN6pN+gmWebT+yK6nXIfmQkKrWYLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(39860400002)(366004)(136003)(346002)(376002)(396003)(26005)(6512007)(9686003)(33716001)(83380400001)(86362001)(54906003)(4326008)(316002)(8936002)(6486002)(478600001)(6916009)(1076003)(33656002)(8676002)(71200400001)(66476007)(66946007)(76116006)(66446008)(66556008)(64756008)(91956017)(5660300002)(6506007)(44832011)(53546011)(2906002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Dzmf+hYcZ3ofK0pqvYoUbGt2HL+cz3pM3x1LRwPgSLoRCjp0c895HPESbo6gHd1hrOilr0yW++SHQq8Ut/Q733dAAmMR7m/FCcv9gu9p+Sd1r+3sej23OhqR0uuVGEK3scWflopBpOSDCNq1u46w88rD5krlQ+1mDwdV698GUvK1IHOCG5lGn0W15z55fyec6TCFUTu/LX/SaEgvOLCjx7QkQJlWucVxODdH8eXR/Bvoc4AR9HyTSc911iovIbgT5ak53xQsdCz23RJ0cbYV3QlAtVzWkg3PV/9UukCJywTADARtVuGwJC365dUTxqWTfwTtj79ziv8pDhiz0neBddR+fNAjOkxn43gC5yr/AQGLtrgK74hUQ6BBO8TfJUmB67LhPiBqj3zz2/0PjiYZTXX/mJgek0c0Eekmxb3+jaTf5GNX56j7Wl+N7yhrr0OSyjYHfXR65HXn/v4vQdGzrFqVEJwqtBnDNx5r+fgAjdQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0E516AD2A453E49B4AA27B5A50A6285@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238eae92-91e9-46a4-d6aa-08d81d9d842e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 09:02:43.6583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgtIqpoH7IKCTCCe6GlJnxhazGMWb7d88IxSPhYH70gCl6PMo5DvFN1ZlozLoGsM1HWqFYt4ClP17+zTD4/zGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-01 08:32:22, Philippe Schenker wrote:
> On Wed, 2020-07-01 at 02:52 +0000, Peter Chen wrote:
> > On 20-06-30 11:59:49, Philippe Schenker wrote:
> > > On Tue, 2020-06-30 at 00:43 +0000, Peter Chen wrote:
> > > > On 20-06-29 10:04:13, Philippe Schenker wrote:
> > > > > On Mon, 2020-06-29 at 07:26 +0000, Peter Chen wrote:
> > > > > > On 20-06-26 13:03:11, Philippe Schenker wrote:
> > > > > > > If the hardware is in low-power-mode and one plugs in device
> > > > > > > or
> > > > > > > host
> > > > > > > it did not switch the mode due to the early exit out of the
> > > > > > > interrupt.
> > > > > >=20
> > > > > > Do you mean there is no coming call for role-switch? Could you
> > > > > > please
> > > > > > share
> > > > > > your dts changes? Try below patch:
> > > > >=20
> > > > > Here are my DTS changes:
> > > > >=20
> > > > > diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> > > > > b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> > > > > index 97601375f2640..c424f707a1afa 100644
> > > > > --- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> > > > > +++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> > > > > @@ -13,6 +13,13 @@
> > > > >                 stdout-path =3D "serial0:115200n8";
> > > > >         };
> > > > > =20
> > > > > +       extcon_usbc_det: usbc_det {
> > > > > +               compatible =3D "linux,extcon-usb-gpio";
> > > > > +               id-gpio =3D <&gpio7 14 GPIO_ACTIVE_HIGH>;
> > > > > +               pinctrl-names =3D "default";
> > > > > +               pinctrl-0 =3D <&pinctrl_usbc_det>;
> > > > > +       };
> > > > > +
> > > > >         /* fixed crystal dedicated to mpc258x */
> > > > >         clk16m: clk16m {
> > > > >                 compatible =3D "fixed-clock";
> > > > > @@ -174,6 +181,7 @@
> > > > >  };
> > > > > =20
> > > > >  &usbotg1 {
> > > > > +       extcon =3D <&extcon_usbc_det>, <&extcon_usbc_det>;
> > > >=20
> > > > If you have only ID extcon, but no VBUS extcon, you only need to
> > > > add only phandle, see dt-binding for detail please.
> > >=20
> > > You where right again! Thanks, this actually solves the RNDIS issue
> > > for
> > > our colibri-imx7 board:
> > >=20
> > > +       extcon =3D <0>, <&extcon_usbc_det>;
> > >=20
> > > Howevever on this iMX7 board we have VBUS hooked up to the SoC,
> > > that's
> > > why it works only with ID.
> > >=20
> > > On Colibri-iMX6ULL we do not have VBUS hooked up.
> >=20
> > So, there is no any events for connecting to Host? If it is, the
> > workaround for this board is disable runtime pm. And you only need to
> > write one extcon phandle for ID since you have external event for ID,
> > but no event for VBUS. ID event is not the same with VBUS, for
> > example,
> > if you plug cable into host, you will not get the ID event, you could
> > only get VBUS event if there is an event (eg, through GPIO) for it.
> >=20
> > Peter
>=20
> No we don't have extra Host events. We have one GPIO, if it is high USB
> should be in gadget mode and if the GPIO is low USB should be in host
> mode.
>=20
> Is there no way we can achieve this on mainline without disabling
> runtime PM?
>=20

At least I think so, since you don't have any events to let the
SW know you connects to host if the controller is in low power mode.

Peter

> Philippe
>=20
> >=20
> > > So device/host
> > > switching works only with 'extcon =3D <&extcon_usbc_det>,
> > > <&extcon_usbc_det>;' but then RNDIS and also a normal thumb-drive
> > > does
> > > not work. How could I work around this fact? A dummy-gpio that would
> > > always read "high" for vbus would be a solution for me.
> > >=20
> > > Philippe
> > >=20

--=20

Thanks,
Peter Chen=
