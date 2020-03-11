Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MENTIONS_GIT_HOSTING,PDS_HP_HELO_NORDNS,RDNS_NONE,
	SIGNED_OFF_BY,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:41174
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbgCKHJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:09:23 -0400
From: Peng Fan <peng.fan@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Date: Wed, 11 Mar 2020 07:07:39 +0000
Message-ID:
 <AM0PR04MB4481217C984C72BC23E2475388FC0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582602242-28577-1-git-send-email-peng.fan@nxp.com>
 <20200311062135.GD29269@dragon>
In-Reply-To: <20200311062135.GD29269@dragon>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311070739.glHkuIGOlv9vzzaiuQNHC6Bd4LqRLPKrtq7KYZxKTGA@z>

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

