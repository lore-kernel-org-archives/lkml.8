Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2728C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D45221582
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zjjb0Vt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgIIHKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:10:40 -0400
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:39550
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728729AbgIIHKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:10:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e52+DvJ+RFSskvSYCQayAxlErnhqxmGrlv2kGwul7rYB1etZw+OKEHTpXFlTfv1DGP9MLckDrTR2YbXoJrM8OCZ8mLn7/YcxFe6xwxALLa3xiev7NCmrJbb/+OAerUQyH/sOkOeMkqtnRqL7Epi7CvwLXNHvQXGQhv2cpWghB4d/CsheZJMyOJiXe3PPnwbG4KgxgDgNgnggr+Uap6MyytoA83gQIOl/GMW7I1CaTQ6WcGVXzZR2+FtXmMrXqT8vu7hve2/QMSnQMSd/cAlLln7dmuCCWuKL2PLnXkVBR/TEyC1fozGR2oGIA0uedQerjs8fq77efhkoZ8rzTr3jGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GisOiA8Heg4oRfzeLFnV+JjERGwguwh0dqebfdr1g0=;
 b=X9DFntL6xq/HuHXP+zlvmeMrCZnCfjpa8ZI8ar908HEJ58LpTxSbsY4eyiMezsQ4bi2Xn2Tvw7YQDkBbjZTgexHscpqlDYdmIz5Rku4MRI5z6n5Gd2ArYS/Myxxo0SA+UYzF+aNTU04XCOpDu0Nen90hz2x6bYOP/RhlFG+c/ozuX7gYq0GxfNOpDpkhwvP7NcIo/gmh3+SyarYKy5eE4Uh74aIFmbk0lAAdih7fKTK1p8p8DlRcKAm+9RTlxOAa5rwh3vYEKJ9MkQ4q6nz3tWWUJ0APUgSoSPHMZy6ZwE996WGY5L1U/TKlOAQ26INlLo82+3/mWpFnVmpW9OXKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GisOiA8Heg4oRfzeLFnV+JjERGwguwh0dqebfdr1g0=;
 b=Zjjb0Vt/WEgxROtq/5Vtft8HEDYnSC9BKp5l9rpffbwVMeZdefHDG9CEXdFSIS76nmUUvf1ossHuG9J/eOpEYWd+qiuoiT4EsIe9SS7aryeuoYrYxk7hPJpwWDRUr48BSdU+iVexgSMUo7DJyfEnM6UTgG1YKjC+mZeTKpdvekQ=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM6PR04MB5432.eurprd04.prod.outlook.com (2603:10a6:20b:93::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 07:10:12 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 07:10:12 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: RE: [PATCH 2/2] arm64: dts: lx2160a: add device tree for lx2162aqds
 board
Thread-Topic: [PATCH 2/2] arm64: dts: lx2160a: add device tree for lx2162aqds
 board
Thread-Index: AQHWgTuoJIcsrSh3jEy4wdu9ducPKqlZsQ4AgAY8A2A=
Date:   Wed, 9 Sep 2020 07:10:12 +0000
Message-ID: <AM7PR04MB688571606382A8992C71E8E38E260@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <1599059610-7570-1-git-send-email-meenakshi.aggarwal@nxp.com>
 <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
 <20200905075419.GN9261@dragon>
In-Reply-To: <20200905075419.GN9261@dragon>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.92.43.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23b187d1-78eb-43bb-a6d1-08d8548f6500
x-ms-traffictypediagnostic: AM6PR04MB5432:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB54322C07AF85D4EBD0FDAF908E260@AM6PR04MB5432.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GK+nhiLtGX700oNDOPLBfKJaAIZOJJ+1i6ULEA47NRB1DKt0iwp0vby8D3QovuYdj+CD1G6fQgSMope8hmnzza2iq8EyY838G5E/ctFXL/iLHrYaKMwBDIulXw/5MJDG8SxB6rt7ZahECHgWc4dTsnWS7TjZZe4OG0R/y4Vztl6oOcFw/bUIlmsdehire60+9Bw8JHk7vZuH6utZi/EoNXtzhq0yz3uriAEzy+zvM6wcBgAP4sLu+e/EEZUYd3ZMJO258krVNmFUajA+UUUKrcGWPJgKcoEMrPKo/G9FnIN+E5ALU8j4urZrlwTjVtOHN2C/PGki8KxsH5aNppjarA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(44832011)(52536014)(5660300002)(9686003)(8936002)(4326008)(55016002)(86362001)(71200400001)(316002)(26005)(2906002)(83380400001)(53546011)(7696005)(6506007)(64756008)(186003)(478600001)(66946007)(54906003)(66556008)(66446008)(76116006)(6916009)(8676002)(66476007)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Otg5vLvrWuFW7lPKU9h4aQgOLuUpfCqnPplwW0uhq52IZ7ZGD7C/l1tUO6b0FGltvj3f3p/Co/k27uOsJjz9bB6SFqZBBBseAmU1qBtd1Snx5bkKbTTY1wuukdwEkorF8moClCEggvJ6HNg/j5bY2r0glO9fdAD7s++bNuoObplxCHId8vJon3GStbPNpJu4TASSE8q7ED7qRS6P9x0ksOUZTV4YslFE+qZYkW1KcjCDJC5SlAANg0hkoCrTfaJ3n2SWk3+9J5qZ1h8sPFuqGujZHTp0cKv8ZEy/1G22zDEIm7oIeIlZzkHcgCcbewx54nHUqRwP8nygyBFJ/AgiklKP+ZiWu8V43oLy6AGsr6H5q4T3k6+qMSyFuSICVy4vK0B0FVha6m2CWANJdXSIIhuO77f2LHgJ0nTrrI6PCrfgd0Dj8T8gRRjPkBVqoLiVm09MayzhujG78INr9l40vAi/nwtBrsK1aRn/Jf2v7bzKIRuY6U+2ffpMstKeoTFHk0/07hikTIr7siNiIpqk2To3Qc6bdxMfPooTW8flvT1JunxWHq46VUz8csFB0abEgqsEq8sdEvu5K55eNvMzx2xI8fiIMPbGgNibnRq9EOSeIF6y5+K5YZWOv9UT34IzxafrZqKJsysc0pZPx2jE/A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b187d1-78eb-43bb-a6d1-08d8548f6500
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 07:10:12.3756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDsXDe6ziUO5E1Ej0g3oLw23sUOveo8kThfJ7+EASwp2gksVKuMJjzOBAf5xsCaO9264Vgs146a49pJN2sF7GE2oLPj1a2eaw5CsyjTvRYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5432
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Saturday, September 5, 2020 1:24 PM
> To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Cc: robh+dt@kernel.org; Varun Sethi <V.Sethi@nxp.com>; Leo Li
> <leoyang.li@nxp.com>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Ioana Ciornei
> <ioana.ciornei@nxp.com>; Kuldeep Singh <kuldeep.singh@nxp.com>
> Subject: Re: [PATCH 2/2] arm64: dts: lx2160a: add device tree for lx2162a=
qds
> board
>=20
> On Wed, Sep 02, 2020 at 08:43:30PM +0530, meenakshi.aggarwal@nxp.com
> wrote:
> > From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> >
> > Add device tree support for LX2162AQDS board.
> > LX2162A has same die as of LX2160A with different packaging.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> > Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile            |   1 +
> >  arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts | 336
> > ++++++++++++++++++++++
> >  2 files changed, 337 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > b/arch/arm64/boot/dts/freescale/Makefile
> > index a39f0a1..ab9fbd3 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D
> > fsl-lx2160a-clearfog-cx.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-honeycomb.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-qds.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-rdb.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2162a-qds.dtb
> >
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mn-evk.dtb diff --git
> > a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
> > b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
> > new file mode 100644
> > index 0000000..a81c6a4
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
> > @@ -0,0 +1,336 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT) // // Device Tree file
> > +for LX2162AQDS // // Copyright 2020 NXP
> > +
> > +/dts-v1/;
> > +
> > +#include "fsl-lx2160a.dtsi"
> > +
> > +/ {
> > +	model =3D "NXP Layerscape LX2162AQDS";
> > +	compatible =3D "nxp,lx2162a-qds", "fsl,lx2160a";
> > +
> > +	aliases {
> > +		crypto =3D &crypto;
> > +		serial0 =3D &uart0;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +
> > +	sb_3v3: regulator-sb3v3 {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "MC34717-3.3VSB";
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
>=20
> I do not see any point to have regulator-boot-on or regulator-always-on f=
or a
> regulator that doesn't have on/off control.
[Meenakshi Aggarwal] Properties are added to specify that platform firmware=
's out of reset configuration enabled the regulator and=20
regulator should never be disabled or change its operative status.

Can you help in understanding why these optional properties cannot be used =
together
>=20
> > +	};
> > +
> > +	mdio-mux-1 {
> > +		compatible =3D "mdio-mux-multiplexer";
> > +		mux-controls =3D <&mux 0>;
> > +		mdio-parent-bus =3D <&emdio1>;
> > +		#address-cells=3D<1>;
> > +		#size-cells =3D <0>;
> > +
> > +		mdio@0 { /* On-board RTL8211F PHY #1 RGMII1*/
> > +			reg =3D <0x00>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			rgmii_phy1: ethernet-phy@1 {
> > +				compatible =3D "ethernet-phy-id001c.c916";
> > +				reg =3D <0x1>;
> > +				eee-broken-1000t;
> > +			};
> > +		};
> > +
> > +		mdio@8 { /* On-board RTL8211F PHY #2 RGMII2*/
>=20
> Missing one space before closing comment.
[Meenakshi Aggarwal] will correct in next version
>=20
> Shawn
>=20
> > +			reg =3D <0x8>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			rgmii_phy2: ethernet-phy@2 {
> > +				compatible =3D "ethernet-phy-id001c.c916";
> > +				reg =3D <0x2>;
> > +				eee-broken-1000t;
> > +			};
> > +		};
> > +
> > +		mdio@18 { /* Slot #1 */
> > +			reg =3D <0x18>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@19 { /* Slot #2 */
> > +			reg =3D <0x19>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@1a { /* Slot #3 */
> > +			reg =3D <0x1a>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@1b { /* Slot #4 */
> > +			reg =3D <0x1b>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@1c { /* Slot #5 */
> > +			reg =3D <0x1c>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@1d { /* Slot #6 */
> > +			reg =3D <0x1d>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@1e { /* Slot #7 */
> > +			reg =3D <0x1e>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@1f { /* Slot #8 */
> > +			reg =3D <0x1f>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +	};
> > +
> > +	mdio-mux-2 {
> > +		compatible =3D "mdio-mux-multiplexer";
> > +		mux-controls =3D <&mux 1>;
> > +		mdio-parent-bus =3D <&emdio2>;
> > +		#address-cells=3D<1>;
> > +		#size-cells =3D <0>;
> > +
> > +		mdio@0 { /* Slot #1 (secondary EMI) */
> > +			reg =3D <0x00>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@1 { /* Slot #2 (secondary EMI) */
> > +			reg =3D <0x01>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@2 { /* Slot #3 (secondary EMI) */
> > +			reg =3D <0x02>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@3 { /* Slot #4 (secondary EMI) */
> > +			reg =3D <0x03>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@4 { /* Slot #5 (secondary EMI) */
> > +			reg =3D <0x04>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@5 { /* Slot #6 (secondary EMI) */
> > +			reg =3D <0x05>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@6 { /* Slot #7 (secondary EMI) */
> > +			reg =3D <0x06>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mdio@7 { /* Slot #8 (secondary EMI) */
> > +			reg =3D <0x07>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +	};
> > +};
> > +
> > +&crypto {
> > +	status =3D "okay";
> > +};
> > +
> > +&dpmac17 {
> > +	phy-handle =3D <&rgmii_phy1>;
> > +	phy-connection-type =3D "rgmii-id";
> > +};
> > +
> > +&dpmac18 {
> > +	phy-handle =3D <&rgmii_phy2>;
> > +	phy-connection-type =3D "rgmii-id";
> > +};
> > +
> > +&dspi0 {
> > +	status =3D "okay";
> > +
> > +	dflash0: flash@0 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		compatible =3D "jedec,spi-nor";
> > +		reg =3D <0>;
> > +		spi-max-frequency =3D <1000000>;
> > +	};
> > +};
> > +
> > +&dspi1 {
> > +	status =3D "okay";
> > +
> > +	dflash1: flash@0 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		compatible =3D "jedec,spi-nor";
> > +		reg =3D <0>;
> > +		spi-max-frequency =3D <1000000>;
> > +	};
> > +};
> > +
> > +&dspi2 {
> > +	status =3D "okay";
> > +
> > +	dflash2: flash@0 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		compatible =3D "jedec,spi-nor";
> > +		reg =3D <0>;
> > +		spi-max-frequency =3D <1000000>;
> > +	};
> > +};
> > +
> > +&emdio1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&emdio2 {
> > +	status =3D "okay";
> > +};
> > +
> > +&esdhc0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&esdhc1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&fspi {
> > +	status =3D "okay";
> > +
> > +	mt35xu512aba0: flash@0 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		compatible =3D "jedec,spi-nor";
> > +		m25p,fast-read;
> > +		spi-max-frequency =3D <50000000>;
> > +		reg =3D <0>;
> > +		spi-rx-bus-width =3D <8>;
> > +		spi-tx-bus-width =3D <8>;
> > +	};
> > +};
> > +
> > +&i2c0 {
> > +	status =3D "okay";
> > +
> > +	fpga@66 {
> > +		compatible =3D "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c",
> > +			     "simple-mfd";
> > +		reg =3D <0x66>;
> > +
> > +		mux: mux-controller {
> > +			compatible =3D "reg-mux";
> > +			#mux-control-cells =3D <1>;
> > +			mux-reg-masks =3D <0x54 0xf8>, /* 0: reg 0x54, bits 7:3
> */
> > +					<0x54 0x07>; /* 1: reg 0x54, bit 2:0 */
> > +		};
> > +	};
> > +
> > +	i2c-mux@77 {
> > +		compatible =3D "nxp,pca9547";
> > +		reg =3D <0x77>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		i2c@2 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			reg =3D <0x2>;
> > +
> > +			power-monitor@40 {
> > +				compatible =3D "ti,ina220";
> > +				reg =3D <0x40>;
> > +				shunt-resistor =3D <500>;
> > +			};
> > +
> > +			power-monitor@41 {
> > +				compatible =3D "ti,ina220";
> > +				reg =3D <0x41>;
> > +				shunt-resistor =3D <1000>;
> > +			};
> > +		};
> > +
> > +		i2c@3 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			reg =3D <0x3>;
> > +
> > +			temperature-sensor@4c {
> > +				compatible =3D "nxp,sa56004";
> > +				reg =3D <0x4c>;
> > +				vcc-supply =3D <&sb_3v3>;
> > +			};
> > +
> > +			rtc@51 {
> > +				compatible =3D "nxp,pcf2129";
> > +				reg =3D <0x51>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&sata0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&sata1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&sata2 {
> > +	status =3D "okay";
> > +};
> > +
> > +&sata3 {
> > +	status =3D "okay";
> > +};
> > +
> > +&uart0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&uart1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&usb0 {
> > +	status =3D "okay";
> > +};
> > --
> > 2.7.4
> >
