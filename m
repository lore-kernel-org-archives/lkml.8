Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D941C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A0120874
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R//Xv1j2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbgFWXMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:12:23 -0400
Received: from mail-db8eur05on2087.outbound.protection.outlook.com ([40.107.20.87]:20255
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387709AbgFWXMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:12:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ+VzPdjJ3GlWzrwbfruS0XLJtcW28BN0rWzTLKAnJFKFSYLyZkOFEZYGdNiA95jXMI+pAV2fe+gzjuPc3/R7kgR7JuOWzSXdoeMaFJ8bQETs8Vj15jStTAGt4n59gNaBR0zRnZfiLKNP3l4GxurE86NMBIntJRSswdi2ZV/COzW7PrRXREf5IY4bCioObVHyNgFFQQpW9PxRTTjCXuziCG+K7a7sVAGnJaIJUBLFsBQdqJ+IEkJFkzXaWfwg95NLD+O+2efKNuIhQxZt9Qasv529IfCVFZKkE7Qi9P8d08igXn+plyYeIYwLXbssqxIsHO45vYBxYjzAg2oQ5pMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/ij0VBzE27tiqbwtB48wRdFAG/6lQKkNgzshQcxCYE=;
 b=ZxfCSdpcIkGt3bW6nBm6hEy/Vgfla53fDTX1IkcldIt6DdhicOsGHggAOwJF8C5jvTDXb67N1LEmERQ6wfDfSe3hBSpNiYExs4nM/Ii415rII+T+BCn/oeafpbEGbdpXrub1Gb7OEhgBw5dLOGm7VjmSaeK9S1vvBj/g2KUzzB9tHUzgbf29wvf6o0HWgk6TOzRSdXe3rdZ2MDhCZa1X/4SzcIi9UxghLzUZyXt+BR//eD6HQ21B48DB7y0XQ5JHge4sHJz4wHg3rTjKgPZBNcYDXU6Tgn0VX6uvOFFbxedsHWWuBiCvwePFCpeD1GgFxKYNKj2Jd1PNjfg7Cpxiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/ij0VBzE27tiqbwtB48wRdFAG/6lQKkNgzshQcxCYE=;
 b=R//Xv1j2qCjSDrosYtrIVujiWCpMFP87WKwkVzC6K48rwWcWChPP/2n7klysg0Ds6bw64vse7kzCg0Rf7S3Fa0bFtg2Wv2UZscCmDYb2JgGn8gcWDFFTWZwpxDDp0TzdMIB3GEwm9tEkKpCvP0QV4xwCko3bPQMkEv9/JCLUUyQ=
Received: from AM0PR04MB6676.eurprd04.prod.outlook.com (2603:10a6:208:177::33)
 by AM0PR04MB5284.eurprd04.prod.outlook.com (2603:10a6:208:cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 23 Jun
 2020 23:12:05 +0000
Received: from AM0PR04MB6676.eurprd04.prod.outlook.com
 ([fe80::1d94:409a:2958:316d]) by AM0PR04MB6676.eurprd04.prod.outlook.com
 ([fe80::1d94:409a:2958:316d%4]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 23:12:05 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [RESEND PATCH] arm64: dts: ls1028a: Add DSPI nodes
Thread-Topic: [RESEND PATCH] arm64: dts: ls1028a: Add DSPI nodes
Thread-Index: AQHWSHA0vQ9gRlWUdkSHMdyW1ZGEcKjm1SYQ
Date:   Tue, 23 Jun 2020 23:12:05 +0000
Message-ID: <AM0PR04MB667637011B99FCC3883AC5A78F940@AM0PR04MB6676.eurprd04.prod.outlook.com>
References: <20200622082909.42254-1-qiang.zhao@nxp.com>
In-Reply-To: <20200622082909.42254-1-qiang.zhao@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [136.49.234.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d364d98-4de2-443d-fc8f-08d817cad836
x-ms-traffictypediagnostic: AM0PR04MB5284:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5284E2CABBE50749CEC5713F8F940@AM0PR04MB5284.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0VoTbmccy8T8zhYAJ2n85B3Zt2Pl2HXfLrwlKSPGkx5C+JEEO8xPsze87CfiWQNJRbfqVeTEgp7z42jyKAzcFYQ5i9hE1jnki03inqRUmplFYzvBY/IuDSCaOrhrFILDgwC4yzOmmJxOiO2eQLQIXsKDsY7Ky571XbJmT9sVG9H3wpGLKlcLeK3DCgZXcATBNGmv9WSJYTfOtDxdwtIcFs5Yz23IlsmMXSJ2Aoy5vWmjNaB6HcQgyi0fXzvBPk8v0/e9HrAuAsvUgu+evcDcL1RdU+jqD+vpmT9i4wYV/aGE1E/o4FFMDQmB7BHHxbE7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(5660300002)(86362001)(8676002)(8936002)(52536014)(66446008)(66476007)(66556008)(66946007)(33656002)(64756008)(76116006)(83380400001)(71200400001)(26005)(4326008)(6506007)(186003)(53546011)(9686003)(55016002)(2906002)(478600001)(110136005)(7696005)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yzWxORnk81ac8qfwqKGttb6WY4x30+CCNO8B6PNB8Hw4Kg4R23Tn2yPEFkWE76IBKm++vdHGjrN7bmUu1n9HPq4KGj5H1p/flYXqOEhaAyHS2R5eA8qHruLus8CmEZlfJWwHYyOtf9fSqR9op5FcMXROi28/jgff/Rm8VDGuU8ORg4FlBddQbLLdiyrjo3wdWDZFH7jPbVi6tYlVi1NCPKmt9aiIay3/BNyPvhFKDeZa5OQpFOjq2ZWjS3pZbSN0sp1LAN+uHuR+x7+pftyseVEut0rOUMZzFsS5Iym2FcoTOlIYCRrVZG5YRBX2LYM/iq9Z1piL7VwsrbdC/TV6ku69gJZK6t9Uiomta43B5QGInaAs+daV8OSmPJV9YFuMTWnEZG9uVSMUFHWtM6iw9aBHGiwyd7jU+0+wlsZ2+2wOXPbDw5EjQPXO0FU/ISAb71IcKq9dprnLrjF9O/6y5n+il9nd5yK8zV17Y6JkJHeylDKl3+ech2sTPaqNXl7s
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d364d98-4de2-443d-fc8f-08d817cad836
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 23:12:05.0300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+wEEysQz+ViSLxSJlZ2i5lI/YR1ANcHOIgcLNDYJTDCdt7HSdtTqr2ArCbFM1zg6F2emZGDWhR7khiX+Wta+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5284
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Qiang Zhao <qiang.zhao@nxp.com>
> Sent: Monday, June 22, 2020 3:29 AM
> To: shawnguo@kernel.org
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Leo Li
> <leoyang.li@nxp.com>; Qiang Zhao <qiang.zhao@nxp.com>; Xiaowei Bao
> <xiaowei.bao@nxp.com>
> Subject: [RESEND PATCH] arm64: dts: ls1028a: Add DSPI nodes

This patch is actually defining dspi flash nodes for LS1028a-qds board inst=
ead of adding dspi nodes for the soc.

>=20
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
>=20
> Add the DSPI nodes for ls1028a.
>=20
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 85
> +++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index dd69c5b..e4f00c2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -107,6 +107,91 @@
>  	};
>  };
>=20
> +&dspi0 {
> +	bus-num =3D <0>;
> +	status =3D "okay";
> +
> +	flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "jedec,spi-nor";
> +		spi-cpol;
> +		spi-cpha;
> +		reg =3D <0>;
> +		spi-max-frequency =3D <10000000>;
> +	};
> +
> +	flash@1 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "jedec,spi-nor";
> +		spi-cpol;
> +		spi-cpha;
> +		reg =3D <1>;
> +		spi-max-frequency =3D <10000000>;
> +	};
> +
> +	flash@2 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "jedec,spi-nor";
> +		spi-cpol;
> +		spi-cpha;
> +		reg =3D <2>;
> +		spi-max-frequency =3D <10000000>;
> +	};
> +};
> +
> +&dspi1 {
> +	bus-num =3D <1>;
> +	status =3D "okay";
> +
> +	flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;

These probably are not needed when no sub nodes are defined.

> +		compatible =3D "jedec,spi-nor";
> +		spi-cpol;
> +		spi-cpha;
> +		reg =3D <0>;
> +		spi-max-frequency =3D <10000000>;
> +	};
> +
> +	flash@1 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "jedec,spi-nor";
> +		spi-cpol;
> +		spi-cpha;
> +		reg =3D <1>;
> +		spi-max-frequency =3D <10000000>;
> +	};
> +
> +	flash@2 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "jedec,spi-nor";
> +		spi-cpol;
> +		spi-cpha;
> +		reg =3D <2>;
> +		spi-max-frequency =3D <10000000>;
> +	};
> +};
> +
> +&dspi2 {
> +	bus-num =3D <2>;
> +	status =3D "okay";
> +
> +	flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "jedec,spi-nor";
> +		spi-cpol;
> +		spi-cpha;
> +		reg =3D <0>;
> +		spi-max-frequency =3D <10000000>;
> +	};
> +};
> +
>  &duart0 {
>  	status =3D "okay";
>  };
> --
> 2.7.4

