Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AA6C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940EA2192A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QcW1HMxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgCKHJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:09:23 -0400
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:41174
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbgCKHJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:09:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK3YgjrYuZQNHDsdmytNqvK5ewkQ11UkG8aSIcI9cnw1ZP5wmJAAmSz21Wg47cFJd+amcO8pwbUASPfAkdGMqbCBoSmQHWMuudOi8qneAYFMnZruGb5nuId3Gm4n/JoG2UtBN44p2zpM0TqouNimNd5QZY0RQSyw7xMnXGxBfBnH4l0t1sceGGDZ0miH/qfLZcYtPFuQkmNFWuedAgJ6KmvZzxwXo8D4iNUu7PIc75GGGngu3q5Fg5d9oHTSB+mPReamA5svaJlDNC2NRx23HguPtEFtfn17k9xqijW8xorOoKExLTzu1EhBglwKDOh027WdO6Z2GurFBHa0+LxWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZVyqJGG8o3GgXh4RNTGRTLybOa1U54SS9v9hNzNEGU=;
 b=TgKlnuanLo2dnumLxBt56eF78eOHty6vDXTcZ7cnszeH2qYQXvSMCuGGxq26o5urp6mWJSI5UZfscxNRI9zCZvgPk+uDxc54NXDz3LvRfUF3yaMadrlrgKi7Vbe+UaYDlIWHPqlMRmxYEInn8ig8gfxlTUzGV5ryBVTwgvyRDal9Bj5gbasoPulEGHXllTBiDYTQPr6yi2ikU5gBa7ibhltXBDYaVO0P/mkVPtd7v+P1KORqLDwP0G4KJ2C/+kvc3O2MSQ9YCvmSgXKEEn8i0CBCTUEV7TrnNjorYpkN6Pr9qNYSd5ocuZu4UB9p9FNapTO8Sj3+5y0/LczjUgaQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZVyqJGG8o3GgXh4RNTGRTLybOa1U54SS9v9hNzNEGU=;
 b=QcW1HMxE/oiMxEkgBQ3ZtkQF6YyflYNRUifuN1ud/vS0vEGyRe1Bzsn5qS5ITAsZIPkesRdRWMq6/jxsn6EiUUjOzSjm0I32YkcaWLIXx4EusQl82CTWhNtFK/x1dHyRaa8df4jhIaCqFNTFBkirbdm3eK4FFBWP4WsEcolROoc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5028.eurprd04.prod.outlook.com (20.177.41.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Wed, 11 Mar 2020 07:07:39 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 07:07:39 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH] ARM64: dts: imx8m: fix aips dts node
Thread-Topic: [PATCH] ARM64: dts: imx8m: fix aips dts node
Thread-Index: AQHV646vutoeRArZGkWqXGNmEtg+gahDA4OAgAAMiJA=
Date:   Wed, 11 Mar 2020 07:07:39 +0000
Message-ID: <AM0PR04MB4481217C984C72BC23E2475388FC0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582602242-28577-1-git-send-email-peng.fan@nxp.com>
 <20200311062135.GD29269@dragon>
In-Reply-To: <20200311062135.GD29269@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f78bc77-709a-4398-912d-08d7c58ae298
x-ms-traffictypediagnostic: AM0PR04MB5028:|AM0PR04MB5028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB50286363DDC291BD5E8531D088FC0@AM0PR04MB5028.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(199004)(2906002)(64756008)(66476007)(478600001)(86362001)(5660300002)(4326008)(66446008)(33656002)(66556008)(76116006)(71200400001)(66946007)(966005)(52536014)(6506007)(7696005)(9686003)(186003)(8936002)(26005)(6916009)(44832011)(8676002)(55016002)(316002)(54906003)(81166006)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5028;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0B+IbT6i2TwAbGsufNCesEBhBWTORdhwMxrli0opPL2fPNUa4c4rAwph6yiNBY2DbIv6fWPs3j3HqWuaTS3c7rW7wCnMhlFmvl6zZkp+XMN92iGUGw1HpzfYlPm4uulXLWb4LGj1BjoYOvZ5f2iHJcSs/hRDNx9F3GTakFJho+V56bxxWCtIuC4W94o+chk/LBBD1VA/nXsgdVQ9h5F5LlfyYQ9dzTdOM3LZzpRBxE1P2t72VLm0Fj/lAbMXjIZ8A7Kp9zs9bOWHSuhGAbU4WtHoBYGgfe5O0mK7SXw99jeGzCDA9ORDc+biz+3/83FQawRRPgoH9Yb/jwm3YyVntmDFQY8ogBBoASezAa1oKUIgjHlbqrYMc7mt7LqYApBHAKiSWflZTLAyfJ16qWuE0KECmeVvo1Ia6hPpvBkRHp5EtwzRILoyZi2clQXc/zUzIDJRUCVsZUQHfn6FCZxTrQJ4Rjtr/OoKzmuqPjjaxi98tJNJV+58tvCzPz8/tMsjIGReSpXXsbwvQc36A618++Hjqw4wBu/127IKdYTZk8XrmW5X+EWku/wS7mWlajwh
x-ms-exchange-antispam-messagedata: BFFVHxDT/W6rGjpkExMEilfqKAUXcvmZilts1og/qumcmxtl/mI9eNG3WbX/ZgYydlChFRWBJR9/h7/3IucUbsZCYB4nTWC/zazBNLoPOY+uRlbPqwCi3aNwBJ3MAFDboICn12XSTpbwM+mxGvo7+A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f78bc77-709a-4398-912d-08d7c58ae298
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 07:07:39.2613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X1HdPD32S+0oSrw6zbxZUAKFq/M9l8CauCTfS3IRkbgAaIQvIurssfzj3yQm749AjJCT89I3BgaB9MDfNTaoJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH] ARM64: dts: imx8m: fix aips dts node
>=20
> On Tue, Feb 25, 2020 at 11:44:02AM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Per binding doc fsl,aips-bus.yaml, compatible and reg is
>=20
> Where can I find this binding doc?

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3Ddb1b4b3a7ae19d1abc6d52e9b3dc05b4bb99320f

>=20
> > required. And for reg, the AIPS configuration space should be used,
> > not all the AIPS bus space.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> Prefix 'arm64: ...' for arch/arm64 patches.

Could you please help correct or should I submit v2?

Thanks,
Peng.

>=20
> Shawn
>=20
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 12 ++++++++----
> > arch/arm64/boot/dts/freescale/imx8mn.dtsi | 16 ++++++++--------
> > arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++------
> > arch/arm64/boot/dts/freescale/imx8mq.dtsi | 12 ++++++++----
> >  4 files changed, 30 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index b3d0b29d7007..a4356d2047cd 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -227,7 +227,8 @@
> >  		ranges =3D <0x0 0x0 0x0 0x3e000000>;
> >
> >  		aips1: bus@30000000 {
> > -			compatible =3D "simple-bus";
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x301f0000 0x10000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges =3D <0x30000000 0x30000000 0x400000>; @@ -496,7
> +497,8 @@
> >  		};
> >
> >  		aips2: bus@30400000 {
> > -			compatible =3D "simple-bus";
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x305f0000 0x10000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges =3D <0x30400000 0x30400000 0x400000>; @@ -555,7
> +557,8 @@
> >  		};
> >
> >  		aips3: bus@30800000 {
> > -			compatible =3D "simple-bus";
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x309f0000 0x10000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges =3D <0x30800000 0x30800000 0x400000>; @@ -800,7
> +803,8 @@
> >  		};
> >
> >  		aips4: bus@32c00000 {
> > -			compatible =3D "simple-bus";
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x32df0000 0x10000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges =3D <0x32c00000 0x32c00000 0x400000>; diff --git
> > a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > index f2775724377f..4848ce82f083 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > @@ -203,8 +203,8 @@
> >  		ranges =3D <0x0 0x0 0x0 0x3e000000>;
> >
> >  		aips1: bus@30000000 {
> > -			compatible =3D "simple-bus";
> > -			reg =3D <0x30000000 0x400000>;
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x301f0000 0x10000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges;
> > @@ -401,8 +401,8 @@
> >  		};
> >
> >  		aips2: bus@30400000 {
> > -			compatible =3D "simple-bus";
> > -			reg =3D <0x30400000 0x400000>;
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x305f0000 0x10000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges;
> > @@ -461,8 +461,8 @@
> >  		};
> >
> >  		aips3: bus@30800000 {
> > -			compatible =3D "simple-bus";
> > -			reg =3D <0x30800000 0x400000>;
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x309f0000 0x10000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges;
> > @@ -707,8 +707,8 @@
> >  		};
> >
> >  		aips4: bus@32c00000 {
> > -			compatible =3D "simple-bus";
> > -			reg =3D <0x32c00000 0x400000>;
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x32df0000 0x10000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges;
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index 71b0c8f23693..eb67f56cdfe2 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -144,8 +144,8 @@
> >  		ranges =3D <0x0 0x0 0x0 0x3e000000>;
> >
> >  		aips1: bus@30000000 {
> > -			compatible =3D "simple-bus";
> > -			reg =3D <0x30000000 0x400000>;
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x301f0000 0x10000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges;
> > @@ -309,8 +309,8 @@
> >  		};
> >
> >  		aips2: bus@30400000 {
> > -			compatible =3D "simple-bus";
> > -			reg =3D <0x30400000 0x400000>;
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x305f0000 0x400000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges;
> > @@ -369,8 +369,8 @@
> >  		};
> >
> >  		aips3: bus@30800000 {
> > -			compatible =3D "simple-bus";
> > -			reg =3D <0x30800000 0x400000>;
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x309f0000 0x400000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges;
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 6a1e83922c71..07070464063d 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -290,7 +290,8 @@
> >  		dma-ranges =3D <0x40000000 0x0 0x40000000 0xc0000000>;
> >
> >  		bus@30000000 { /* AIPS1 */
> > -			compatible =3D "simple-bus";
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x301f0000 0x10000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges =3D <0x30000000 0x30000000 0x400000>; @@ -692,7
> +693,8 @@
> >  		};
> >
> >  		bus@30400000 { /* AIPS2 */
> > -			compatible =3D "simple-bus";
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x305f0000 0x10000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges =3D <0x30400000 0x30400000 0x400000>; @@ -751,7
> +753,8 @@
> >  		};
> >
> >  		bus@30800000 { /* AIPS3 */
> > -			compatible =3D "simple-bus";
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x309f0000 0x10000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges =3D <0x30800000 0x30800000 0x400000>, @@ -1023,7
> +1026,8 @@
> >  		};
> >
> >  		bus@32c00000 { /* AIPS4 */
> > -			compatible =3D "simple-bus";
> > +			compatible =3D "fsl,aips", "simple-bus";
> > +			reg =3D <0x32df0000 0x10000>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			ranges =3D <0x32c00000 0x32c00000 0x400000>;
> > --
> > 2.16.4
> >
