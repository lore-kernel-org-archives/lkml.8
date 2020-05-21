Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749C1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5377E207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eVUSjKof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgEUGFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:05:20 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:62114
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727782AbgEUGFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:05:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7THmxLeSToxqUflwwigA7x0nITNzhnETE/THP2E4nHjkM2HfrJQyjCxbD4YpmRnrvGExs4NvAEqYGeXopU5Z9X+ua3U5f9ZOniNTTPpfvyR8sZVeUYIC2x+bCvOXZXIRA3lJfzN9sCqH6x13P35WWmlM1H51jRFaTnjpiDx8SfLQS6NmUJFDQBm4HsLPmTgFZv9KhBPCweippypC9lwMs3fdAe9j44GEAoQvXcfmk/flfU5QA5HXjwCvGxo4UN4X6Uy7af3a2wQosHWOOUlY79XcaXrPhXkiEfhqSenjyvHGSXiQ8TkqVKTyhgtrw/AH2LckbHTu04FVpNeuNFKcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt0bYkqArHOat4epzHl3QBbnf5JyzoI57EDOAw8wK9o=;
 b=iy9n2LZPev6FT+0GoR6wQWXjiyJYGPZ+k0IH5FpuL52c9iEaGPJCPj9MnzcSlVLNuAimkE0Y/wUf1Sus9GYUuQjnT7Yk8949Wgngx/27s0aQv14o1ZoDc1o3/iNfWBjWVDae7GVXexEQzePfWCZbzx+gBKAulnoMps0u+CmjiiCTg3/SR4rvC22pmLfTiGhYXemPs5LR6g9zz2f9EHNJ0j7SfC5W0dzcUw8/5GFuXy6L8HRRbHlNt4sE3z1meJ11AmMbySOLhMOaLYcjaU4nS7oBsxNPgjWRtn+NXeRYZI2005U299IFou7QAxJM9F+X/Pw8NlQXlQXWoCpq44Vm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt0bYkqArHOat4epzHl3QBbnf5JyzoI57EDOAw8wK9o=;
 b=eVUSjKof/Rir1Tbtmz8iaI8t9Le+n6M2AuHAGq4ONPZj28588v4qNqx6/m7qrqtTkpwfnupMn8QAsE56HkZeigBOoZjvW2XHHdZzoz2RGsiOmvd/Nc5bD6iwc78NbKF0Ur2ZN65T6s8yYR0nreiue6iTku8fGSxDUrdQ0djUv9E=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 06:05:14 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 06:05:14 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2
 voltage range
Thread-Topic: [PATCH v1 2/2] arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2
 voltage range
Thread-Index: AQHWLx+OOjBI45o49kK5ywpfqow5U6iyDIwAgAAAQSA=
Date:   Thu, 21 May 2020 06:05:14 +0000
Message-ID: <VE1PR04MB66382DE5A0FAB91CD702408D89B70@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1590060368-2282-1-git-send-email-yibin.gong@nxp.com>
 <1590060368-2282-2-git-send-email-yibin.gong@nxp.com>
 <DB6PR0402MB2760907E5DE55EBA3BE38D9B88B70@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB2760907E5DE55EBA3BE38D9B88B70@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4bcea7c-16f4-442f-ca9f-08d7fd4cedb7
x-ms-traffictypediagnostic: VE1PR04MB6702:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB670246F7B7C1B1AFAA5A46B189B70@VE1PR04MB6702.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5W6zLY/cUfXyoc2e0AnsLAOuaxPNzIFbXj8bf6FhVr7MXrFJ6oi99nMLrDZqxPdpgJVsj1qKbGeIZjfWlJTeFg7Ob7xL/IHndD7Np5z6VZf/sjws15noX5R1ghmqITWxo9TIHVzBUkQhbLGtY3Fm/TvBLmgJhMUDu0j4Oo6frF3lSnzCOO7spAlBHvsvUeYw0qnkjW7tF50SUeyUN4eul0u1O0ZjTwcKE9B0d9qffmGAY/KMJYfyJLxp5PV+I+6NMgjit5FmFHNmWCRt6ndQVaObJNbrFbn8SJZWTp6Kf60qB7gREr59ySekhKJySXstCG9JGBo2xMEaEKtjbn3x7LKajzO9lIPg213WnX4O6bk+uAWMkqwsey0cZ2lcG75E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(6506007)(52536014)(5660300002)(186003)(316002)(4326008)(2906002)(26005)(33656002)(8936002)(478600001)(71200400001)(55016002)(66446008)(9686003)(66556008)(64756008)(110136005)(66946007)(66476007)(6636002)(76116006)(86362001)(54906003)(7696005)(8676002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: N6sHiRdSrFG1H7y+tasMmUkQ/HG4Yd/t/8aOwlNmI/YfFT7e4yi9yxQxcwvySoVrv2J/uLIYNt057mH8NXgq0kHTfK+9pYYPTwCRs3z1RdQh7t4iYN4ZYJhGgIqTPlwg7Acyle6S+eqyl6Yp6cvrp6LyoAZ0LNz3Cbm8OJbQeGGwKZukY6LzE7yg3e16zbH+XCEyJD8Ase77Nwm+92P6MhQHIi+tJkqMl3bp3pQ/PFZYGIYFRx57C7A6y7lrynCyA0+CqmsFkQWtDyQAiz5IiUuJnH4ON3/TD62xdOb+LvNhgpzlfT9meqxzk4CHY3hyWRCug7IXWOb4ZK5K1jojBXmq5tPWq9kFRyN2WrQ/eKY4AnolYEkzcSc37sBOVdolLxf1DiyADztuMhg1BxCE5862PIM4GYMLW8o6fkwRF+3XNgJrV7ju276/Ac7dylZKDK/+R6M1xd6I2W4IF4KM5pA0TYiKk5zs49MZUHrcmL8eMDTZUQXrFGJwUmNiJGAU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bcea7c-16f4-442f-ca9f-08d7fd4cedb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 06:05:14.2702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: grDviiXfr0x2PLp5q3t42powe7YU29FcyKyh5i3nQW2gEUU7D2jFPFO1alPw98CVJg/E3sXeFnuhJgnLUmtZDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6702
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020/05/21 14:02 Peng Fan <peng.fan@nxp.com> wrote:
> > Subject: [PATCH v1 2/2] arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2
> > voltage range
> >
> > Correct ldo1 voltage range from wrong high group(3.0v~3.3v) to low
> > group
> > (1.6v~1.9v) because the ldo1 should be 1.8v. Actually, two voltage
> > groups have been supported at bd718x7-regulator driver, hence, just
> > corrrect the voltage range to 1.6v~3.3v. For ldo2@0.8v, correct voltage=
 range
> too.
> > Otherwise, ldo1 would be kept @3.0v and ldo2@0.9v which violate
> > i.mx8mm datasheet as the below warning log in kernel:
> >
> > [    0.995524] LDO1: Bringing 1800000uV into 3000000-3000000uV
> > [    0.999196] LDO2: Bringing 800000uV into 900000-900000uV
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts | 4 ++--
> >  arch/arm64/boot/dts/freescale/imx8mn-evk.dts      | 9 +++++++++
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > index d07e0e6..a1e5483 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > @@ -113,7 +113,7 @@
> >
> >  			ldo1_reg: LDO1 {
> >  				regulator-name =3D "LDO1";
> > -				regulator-min-microvolt =3D <3000000>;
> > +				regulator-min-microvolt =3D <1600000>;
> >  				regulator-max-microvolt =3D <3300000>;
> >  				regulator-boot-on;
> >  				regulator-always-on;
> > @@ -121,7 +121,7 @@
> >
> >  			ldo2_reg: LDO2 {
> >  				regulator-name =3D "LDO2";
> > -				regulator-min-microvolt =3D <900000>;
> > +				regulator-min-microvolt =3D <800000>;
> >  				regulator-max-microvolt =3D <900000>;
> >  				regulator-boot-on;
> >  				regulator-always-on;
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> > index 61f3519..117ff4b 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> > @@ -13,6 +13,15 @@
> >  	compatible =3D "fsl,imx8mn-evk", "fsl,imx8mn";  };
> >
> > +&ecspi1 {
> > +	status =3D "okay";
> > +spidev0: spi@0 {
> > +	compatible =3D "ge,achc";
> > +	reg =3D <0>;
> > +	spi-max-frequency =3D <1000000>;
> > +	};
> > +};
> > +
>=20
> This was added by mistake?
Sorry, will send out v2.

