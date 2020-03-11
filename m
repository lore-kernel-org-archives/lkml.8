Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5114CC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20781206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iys05Zwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbgCKSza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:55:30 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:61571
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730705AbgCKSz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:55:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVePM+UNoEan/fEwKPBPGHYS0O30zOBhLRaT6WBfMd0v6X4U9L/ZxW0S1O0OCVyOjKez23XXQi7zg8XWncwNJSDo67FIGUFa1Bw+WOJBQC5UvXD2U/0NxRj6OoV+pQ79bY6zgIYQsx+KTerhvSFjDSTUgFuACZQxL0bfAwlGVEA5VJn590H3+wsfJyXOf6Qscs8x3cfCIKgpL/pBefDEC4V/Nys8tcXlcWAZZEYqh7RA3YkzlVe8zxPzAwz+JQjN69VjflAgBk4q9NNEpm4kcplFkNEf5coxF9oNfoQX2JjHpKVatKEBgDkL2DBrIuQb5EfMa6bNruGpI73PIoQ64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGN4oWPWa4f0kXlOEg1lPEwwMZbwIuOUhWVutl2cUis=;
 b=Fxj9001yd7+4ClY40mrhbbHEt4jXyM/irHLXKyFP3iUImaAbPP/lNfrOHbyZH5VbRc0CZucxDH/bNcvC61HYbGk/Ts+q4RVZBB6TXh06Taua0polojFTKrCAAiOphXS/MnnfkEsErnC/LJIqTcEMfty0TD1q1zR6b3pv1FmoxkEmEms7SQ+xeJ/38FOKytRLjqL9Qsx7fiuioOX4SFvx8774vpBzuQzaAn0z+KgblMtgaMDxT/LUNl4mMq+8rCfBPKfSciwTu5TJM0BJnIlj3hw3cTMbz8eetxpqp0RRY/Yjhlo0YXp67+dC8qNj1Jjjr8Oj6cHqEcrAdVlgvGGJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGN4oWPWa4f0kXlOEg1lPEwwMZbwIuOUhWVutl2cUis=;
 b=Iys05Zwn+8HGt318yAew4T/2zgKS3fu9hIhV27MtSMwEBg8zYdTI20Hd9Y7Hw4QtvBQ1D/2R5okUc6a2Rgu+ddp/RhMmIlPNDIkWskZqW76Qr3fUnsty7qSytBw1zbIdB5YwdT17ak8tA8W3mX5Vo1Dhn0rCvhTSiGNNTrjjyGM=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6446.eurprd04.prod.outlook.com (20.179.233.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Wed, 11 Mar 2020 18:55:26 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23%2]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 18:55:26 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 09/15] arm64: defconfig: Enable QorIQ IFC NAND controller
 driver
Thread-Topic: [PATCH 09/15] arm64: defconfig: Enable QorIQ IFC NAND controller
 driver
Thread-Index: AQHV62dV7VfUl/+IG0+BeZ8SK7tyeahDAYWAgADUq2A=
Date:   Wed, 11 Mar 2020 18:55:26 +0000
Message-ID: <VE1PR04MB6687970DAF2BFE5A620D53E58FFC0@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
 <1582585690-463-10-git-send-email-leoyang.li@nxp.com>
 <20200311061320.GC29269@dragon>
In-Reply-To: <20200311061320.GC29269@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [136.49.234.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ed74c28-9bca-443c-d959-08d7c5edc335
x-ms-traffictypediagnostic: VE1PR04MB6446:
x-microsoft-antispam-prvs: <VE1PR04MB6446BC313D3EEF0B98C8F3588FFC0@VE1PR04MB6446.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(199004)(81156014)(55016002)(8676002)(52536014)(81166006)(66556008)(64756008)(9686003)(66476007)(76116006)(66446008)(71200400001)(66946007)(5660300002)(8936002)(86362001)(26005)(33656002)(316002)(2906002)(54906003)(7696005)(4326008)(6916009)(186003)(53546011)(6506007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6446;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vES6Hg3R+wT1csFXZaoUmzmcKMceigeyo5opzlObB6gdobf1Xqh6PqDFGNT7pW2MeJqMQtaFnDFWECa+znq0BNH9T7RghIKjwhIybo55CM82kVT/EW/ZTHv3gGJJbk+Q8ZZ39S0ec9bEQIInoyBtUR69lPJ8RpjgzLU8fU1955dSEiZnw0bHL4oO6PR7skL6XGrJRi1zFn+RfVB9gjrgPL3+1Ft3d/o8f/AwZN93i4XqCIn2q3AQZsNDiD+cj5lRqDD5McS+JQeA8cZ2EMfKAyYsLpXDOKuGJg8AtYErKsBnsrmKce3sXoC9b6ctkNwaC8HUT+EvcDa74fLlJFI8UK0gY1h4oq3W8yEXYV+Qm19MSUQy0QzzJJl/4RBKYZUUDQ9GTkSgetu+aUkneF+ldksqZ33Gxtkb2t0lM9FjXzxiptYYZ3i8WrrbdC1U97nw
x-ms-exchange-antispam-messagedata: FsT3h64C+7tkUcTTxFgTpnUzLHAhgObptN16BeR2QFOlORiACXgEInd4iz8sD8cI9vSSuJV67yKlVpmFf1yJ0tmeaJ9Isx9oIsU/JYyUblBEM59hfHNnTxP2DDZQhNBm49rEO9bFmD2KPg05gcaTBg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed74c28-9bca-443c-d959-08d7c5edc335
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 18:55:26.7572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CoAft8d+zr0h2DC2SREtvPbRGZXnXuq7Urel7uBxdvREj0bIiH+LWTPbF1eKmwXmThiMlWO29/bqaNryua/nBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Wednesday, March 11, 2020 1:13 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 09/15] arm64: defconfig: Enable QorIQ IFC NAND
> controller driver
>=20
> On Mon, Feb 24, 2020 at 05:08:04PM -0600, Li Yang wrote:
> > Enables NXP/FSL QorIQ IFC flash controller driver for NAND.  Enabled as
> > built-in to load RFS from nand flash without initramfs.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  arch/arm64/configs/defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index d2d5d470a6fc..a625e322fa27 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -217,6 +217,7 @@ CONFIG_MTD_BLOCK=3Dy
> >  CONFIG_MTD_RAW_NAND=3Dy
> >  CONFIG_MTD_NAND_DENALI_DT=3Dy
> >  CONFIG_MTD_NAND_MARVELL=3Dy
> > +CONFIG_MTD_NAND_FSL_IFC=3Dy
> >  CONFIG_MTD_NAND_QCOM=3Dy
> >  CONFIG_MTD_SPI_NOR=3Dy
> >  CONFIG_SPI_CADENCE_QUADSPI=3Dy
> > @@ -801,7 +802,6 @@ CONFIG_ARCH_K3_J721E_SOC=3Dy
> >  CONFIG_TI_SCI_PM_DOMAINS=3Dy
> >  CONFIG_EXTCON_USB_GPIO=3Dy
> >  CONFIG_EXTCON_USBC_CROS_EC=3Dy
> > -CONFIG_MEMORY=3Dy
>=20
> Why is this getting removed?  Maybe worth a mentioning in the commit
> log?

MTD_NAND_FSL_IFC selects MEMORY.  I can add it in the commit message.

>=20
> Shawn
>=20
> >  CONFIG_IIO=3Dy
> >  CONFIG_EXYNOS_ADC=3Dy
> >  CONFIG_QCOM_SPMI_ADC5=3Dm
> > --
> > 2.17.1
> >
