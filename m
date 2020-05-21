Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7B7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11F920872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YmQ8IdzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgEUGC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:02:28 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:14343
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727033AbgEUGC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+IRgvb98lYSeIqFyAnQw3B4+dgsy/OH5tD7fdUFjKLVssro3dRg/5/egjPnnyr41YGIijmO+QeI1oSzlJFk5eaLVxTxFuhzeCRXZJq2iBv5cRTo8zI42s72v5PQeB44xZN3N9PCyCDtMcGIuCVXj+GgTx76F5hjlCRu1NM/z88JAvCfJoPpazV1o9ZmcPv6n56LXtfJWbeUIpEOTmT3OGB+7WiEX/nb0xUfGuwTq37BDnc8W6V7DJGfZVqoosc6pWT5UhkdTv1diSF8Jlgs8swxcZstNbBG93Fin1SQSK20k2JbrIrpiPXCth387j3D/+VkRorZinkuZVXaod+f4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HAfyWLXl1LQgvZgM1LwF3z29A5+h+8dEL2+pMl2RZ4=;
 b=ST0queO0f0J3rVzpa+OafOCuubHUksp0IlBZnwDcgqlJ190tQMGlNXnfhao+9U/4VJO51a856tS4Ph9fGaazxeuu1ninG26zt6xCWIvQT2n40iNpaH4wHWdh24em5Bsk4opQH3JQCtwI4IF8fHqRisZtIwL7stl6nWcUSXrwRiJlDHa3q12p39r713A7pqW2xBYT+UlZY01HUkaLBFcjoB/p1ZpdC+p1I4+WA49XaTZcL2AS6ZhLHou6L285R6AqjuO+YmWfGh+me920SOY2A4J3cOwx5YEGaZoGSXdiApnHyEor2FmnhxoPuPY7LTzp3NuPTnGsxdxLpbaSTjGzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HAfyWLXl1LQgvZgM1LwF3z29A5+h+8dEL2+pMl2RZ4=;
 b=YmQ8IdzEglmzdnUwlUCDhBjM++NKAhZnOy2mSlSWYLU/Zip7b4oCPpbPCQH47cwhcSPHDp76Zo7Pay46tTG5iwYMo+QlGbh+72FUyBvj75Vzhc53Q2ujzzFRtPaAxWwcHusN65kfbuIkoCBajpMvt4w1obKTWfrXJROeE29TlB4=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2710.eurprd04.prod.outlook.com (2603:10a6:4:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 21 May
 2020 06:02:24 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 06:02:24 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Robin Gong <yibin.gong@nxp.com>,
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
Thread-Index: AQHWLx+QIxebg2Y/5kmAxIei6CuwCKiyDF8g
Date:   Thu, 21 May 2020 06:02:24 +0000
Message-ID: <DB6PR0402MB2760907E5DE55EBA3BE38D9B88B70@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1590060368-2282-1-git-send-email-yibin.gong@nxp.com>
 <1590060368-2282-2-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1590060368-2282-2-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 352697ec-f1de-4f55-09cf-08d7fd4c8857
x-ms-traffictypediagnostic: DB6PR0402MB2710:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB27108869A0DB5983E6F84B6A88B70@DB6PR0402MB2710.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HOjR2kzYGym0HGmYy9ivT87UIdkUDW7F6p+T2miioUxxzYIrtUCCQCPjPcxo3tdgKKACPcNdbuMWoecI7gFyjfznOahGcut7uQpUm1b0x7nuVT6LB5U0z1Lzwb2K+fjbRaB6+2CR+gVun6A+L1HQCpH+xVZUjTkk04UmM6EVruhP/vuRLGeblYM2nosrq20V8l5hi/I8jpusUaqx+mn0xexAXGxte4s71GH/YOKGzdyWI0cDq+t3Vm3CCcr/J72sjYre80xFTVUHflAw66noBBYdqadMCrWt8AFRxgMoGEVaEVb2iwHpsQhcS1MUdNvxxr8yPcDZrEhBv6PT2T9CZ+Yt2mZTHnjQwC+UUxpWNc+V1LYfD0RokuAGkOSUqqN2lMS/BLmBs09INfr8sqBkE/07oDA3R5RPqU3RmmXXoZIdYGXAihJOU2VpApXqavNS50To/eHQht7N2ZUu3hKyDjz0CvBA5tD+iUeKNuqeyam9ORnmaDRHveUY0F+wYMhU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(86362001)(2906002)(186003)(76116006)(66446008)(66556008)(64756008)(66946007)(33656002)(44832011)(71200400001)(66476007)(4326008)(52536014)(316002)(26005)(5660300002)(6636002)(478600001)(6506007)(54906003)(55016002)(110136005)(7696005)(9686003)(8936002)(8676002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Xv3xPdMgHOUZxaVnbJMDYf53ZE/nHplY9sx8lGwIXcx4YL/XJiF8ySkrVjr4cXPo4IXn/UGSkuQ5ebbtLntN4xmNoX63b3F5Rtn2L4aIrRtXzLJGLGCHcagniGgE7+vW/9077B0QdkGMb/3SbWHKNWktDKdrh3uy3JaeeoIjv+piwSowHkvrzQoy0ykB7EL/2c51SdkUa0XisCoipVqETv52j2i4rFGMIoCKOdNnHeS6bbWtvvYLwzTZMnmRDJWfRL0/MX76Th1fpW71JB2NPiB7vRCzEhFgSHWy/pzjJndObx/oyJ/Wr6MKZx2hakSNNogfLA0saAAzPLqHGJQLapUnn8W8Gle/IEfnkM9tyGQ2ra55yB5Uxy+g1xpkPjXlxfCP5OlCw7eSDzqhlMPUgpHwWpaQ4SXsd4SKDT0dBxA8MTOg6EB/JtoCsWAW3iaBtQAOXR+OGZHXoEDfh7n9SzMQuUSGoVWaxFxCiepgHSzBXmRINM3HJhlIGee1ZwTr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352697ec-f1de-4f55-09cf-08d7fd4c8857
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 06:02:24.1992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KIZvqn57OKTIpDGbJvuI4rB476KHKnCEDiGQ71CnZozF5EXG0IJARp83mJgoECIyA8uZDol3C4OUqc+lhvbOQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2710
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v1 2/2] arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2
> voltage range
>=20
> Correct ldo1 voltage range from wrong high group(3.0v~3.3v) to low group
> (1.6v~1.9v) because the ldo1 should be 1.8v. Actually, two voltage groups
> have been supported at bd718x7-regulator driver, hence, just corrrect the
> voltage range to 1.6v~3.3v. For ldo2@0.8v, correct voltage range too.
> Otherwise, ldo1 would be kept @3.0v and ldo2@0.9v which violate i.mx8mm
> datasheet as the below warning log in kernel:
>=20
> [    0.995524] LDO1: Bringing 1800000uV into 3000000-3000000uV
> [    0.999196] LDO2: Bringing 800000uV into 900000-900000uV
>=20
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts | 4 ++--
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dts      | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> index d07e0e6..a1e5483 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> @@ -113,7 +113,7 @@
>=20
>  			ldo1_reg: LDO1 {
>  				regulator-name =3D "LDO1";
> -				regulator-min-microvolt =3D <3000000>;
> +				regulator-min-microvolt =3D <1600000>;
>  				regulator-max-microvolt =3D <3300000>;
>  				regulator-boot-on;
>  				regulator-always-on;
> @@ -121,7 +121,7 @@
>=20
>  			ldo2_reg: LDO2 {
>  				regulator-name =3D "LDO2";
> -				regulator-min-microvolt =3D <900000>;
> +				regulator-min-microvolt =3D <800000>;
>  				regulator-max-microvolt =3D <900000>;
>  				regulator-boot-on;
>  				regulator-always-on;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> index 61f3519..117ff4b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> @@ -13,6 +13,15 @@
>  	compatible =3D "fsl,imx8mn-evk", "fsl,imx8mn";  };
>=20
> +&ecspi1 {
> +	status =3D "okay";
> +spidev0: spi@0 {
> +	compatible =3D "ge,achc";
> +	reg =3D <0>;
> +	spi-max-frequency =3D <1000000>;
> +	};
> +};
> +

This was added by mistake?

Regards,
Peng.

>  &A53_0 {
>  	/delete-property/operating-points-v2;
>  };
> --
> 2.7.4

