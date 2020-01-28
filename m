Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F079C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE152467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IR8j1bQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgA1Ofq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:35:46 -0500
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:55641
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731737AbgA1Ofp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:35:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niaNENZxhKCfe3dgV/jlpMUUgcS8PZ1lYdkxqJfkhhV5jdjt1p5tnrQUKGAogtKTPFj/IMCU1OJp9sP5LkztS9vyVc0xhNMdnJjyAeLIMnm7QE63Qg9KFJcqpyWPcX17mZdHt+qjGK+DUS4oktyk2icYdTT+f7BtvVPWL6tBusx9pIxYyA/RRdcFEet6Kbni1fc+HiC74tS+ClViU9uSyMQECShFqVadYPqoGqjYFRENQ93+lTMsEIkxQtiXFIdl73jBpchShwKod2kIDxOFi/RpYe2SqEl55rRDuUS01fOX7xgR5QParkuOHlN0y6eFC818a1Gs1WaQyqSl3LSR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FI25x3oaRWs1en9uz1ETd6l5xdxCixn30IJA0XIHi8=;
 b=exN14uVXpL+Ce6HsV5k2B+8Fdd3HQ/NxNFdNH6u009a9yK/mwcMMdUknHpI5ZHA2QXP3rAfYTUPNal1EPNmsvbAf5KLBv78y23H9TDu72KJ1jLzbvIw6UhhpucueGDIfrvd/fCFdFmoj31xoZ+XC2bxY/WhDBbNspEvnv7HaN+LkW8JZKL6sTLQi3FzaxZlTRkd6pgpjeiyWhmO2AwKQ0e7jheg3P0cxlqk0QC6e1EAm+2ZwhPz9MhDqedz/OyB93xEEvhVmSp6tkN3dtDPcaGlGmbh1IvtLkGBOdLiCcgMmrNW7Apa3bu8ZoHlfDvDmGfXrJl+6CN5SHOE6CE3tqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FI25x3oaRWs1en9uz1ETd6l5xdxCixn30IJA0XIHi8=;
 b=IR8j1bQOMYxTxNybq8e8RnOPd6HRPR3vBPSvPtO88qbfeZgWFHKjHx0qqbtGUvwqftg9/rmEBEpjKKl5ZwaJTQK3OFT8zBwjYB45aWznYfP9anp1KZ55PjU4UNozeTfWIlNk+rs0dtCoZiNCguewDXVV8/qA6mxOk138ONo7v6A=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5599.eurprd04.prod.outlook.com (20.178.125.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Tue, 28 Jan 2020 14:35:42 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 14:35:42 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 2/2] soc: imx: increase build coverage for imx8m soc
 driver
Thread-Topic: [PATCH V3 2/2] soc: imx: increase build coverage for imx8m soc
 driver
Thread-Index: AQHV1aCjGc6WVJY+NES5jeQSOsfpxg==
Date:   Tue, 28 Jan 2020 14:35:41 +0000
Message-ID: <VI1PR04MB70231AC9140BD13FD0539678EE0A0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1580191098-5886-1-git-send-email-peng.fan@nxp.com>
 <1580191098-5886-3-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc1f9f5e-cf20-4698-d8fe-08d7a3ff5a29
x-ms-traffictypediagnostic: VI1PR04MB5599:|VI1PR04MB5599:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5599DF16EB1921747573E155EE0A0@VI1PR04MB5599.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(8676002)(81166006)(55016002)(5660300002)(66556008)(186003)(8936002)(66476007)(26005)(76116006)(66946007)(64756008)(110136005)(478600001)(9686003)(316002)(66446008)(86362001)(44832011)(54906003)(91956017)(7696005)(53546011)(33656002)(71200400001)(6506007)(4326008)(2906002)(52536014)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5599;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WO86M7YQQ87T5V2oMKp0PrDRqEX/VGGmmubYLqSy/Ouc2g43xJq0UvihcwHfNFx/b/7kjNFl7p/C1NeAoL/nvk4tA4sKH1NpSCGSlv6q4FiTdRhi9QWomHoPMf4eQyzgtD22zgS8LfLzzHb+8VrBoXd2Gfd2r+BtdnvNVHjsp1PvssfOOLXBRr70clw+epNm+woSnyla5gbeifM3eNJN9JNZYA+sg8ajsGuYU4RbQdwORhGbgAGwjK5hmdQ/XxQD7A1GCR/eKAfoEpLPUWcATXVeRSnInZIYqqSBYnh1xh4C7mr4Q4CpJWJhUtGuXQRMj+dLuvO9DWWtjLHY1rJM0xoh85rtyMKJ0d5rywm2HnMG6NpknD+POAZKWpPjAdTtIQMQ9FeNzY3zSkslkOwJkVmDarJOgJLAUXaTtKIjjhHVNOYovUCgCXGh8bTFHtmF8VvcDwpY3NHvLmaCUkUdQT28b6XWm80259QQ/s0UPeUHfmX5oN+7lAXv5QLGI+iP
x-ms-exchange-antispam-messagedata: 6K6iGvB0I+H1chba2UnxmVZBdbsGYQlA3HQ+Bqbqt+UfFfi/l7sKY5RK6Uiy6yiFtxM1I7R+We5YX37yH681k5Tbdddu1KaE5v4t7/gcEOMoAMbwnACs01eT+Iswd4ip58G3M7WcTT8Fu6A9zKvE3A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1f9f5e-cf20-4698-d8fe-08d7a3ff5a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 14:35:41.9142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zWtMO3SEnmqZ3QGKtZDmmVApdcInF4P6zzFHf+daNdH3nvhYJPIzmoD/EEG6ct54Iw5vAXBTNw0FvO/4WQyxWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.2020 08:03, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> The soc-imx8.c driver is actually for i.MX8M family, so rename it=0A=
> to soc-imx8m.c.=0A=
> =0A=
> Use CONFIG_SOC_IMX8M as build gate, not CONFIG_ARCH_MXC, to control=0A=
> whether build this driver, also make it possible for compile test.=0A=
> =0A=
> Default set it to y for ARCH_MXC && ARM64=0A=
> =0A=
> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
> ---=0A=
>   drivers/soc/Makefile                        | 2 +-=0A=
>   drivers/soc/imx/Kconfig                     | 9 +++++++++=0A=
>   drivers/soc/imx/Makefile                    | 2 +-=0A=
>   drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} | 0=0A=
>   4 files changed, 11 insertions(+), 2 deletions(-)=0A=
>   rename drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} (100%)=0A=
> =0A=
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile=0A=
> index 2ec355003524..614986cd1713 100644=0A=
> --- a/drivers/soc/Makefile=0A=
> +++ b/drivers/soc/Makefile=0A=
> @@ -11,7 +11,7 @@ obj-$(CONFIG_ARCH_DOVE)		+=3D dove/=0A=
>   obj-$(CONFIG_MACH_DOVE)		+=3D dove/=0A=
>   obj-y				+=3D fsl/=0A=
>   obj-$(CONFIG_ARCH_GEMINI)	+=3D gemini/=0A=
> -obj-$(CONFIG_ARCH_MXC)		+=3D imx/=0A=
> +obj-y				+=3D imx/=0A=
>   obj-$(CONFIG_ARCH_IXP4XX)	+=3D ixp4xx/=0A=
>   obj-$(CONFIG_SOC_XWAY)		+=3D lantiq/=0A=
>   obj-y				+=3D mediatek/=0A=
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig=0A=
> index 0281ef9a1800..70019cefa617 100644=0A=
> --- a/drivers/soc/imx/Kconfig=0A=
> +++ b/drivers/soc/imx/Kconfig=0A=
> @@ -17,4 +17,13 @@ config IMX_SCU_SOC=0A=
>   	  Controller Unit SoC info module, it will provide the SoC info=0A=
>   	  like SoC family, ID and revision etc.=0A=
>   =0A=
> +config SOC_IMX8M=0A=
> +	bool "i.MX8M SoC family support"=0A=
> +	depends on ARCH_MXC || COMPILE_TEST=0A=
> +	default ARCH_MXC && ARM64=0A=
> +	help=0A=
> +	  If you say yes here you get support for the NXP i.MX8M family=0A=
> +	  support, it will provide the SoC info like SoC family,=0A=
> +	  ID and revision etc.=0A=
> +=0A=
>   endmenu=0A=
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile=0A=
> index cf9ca42ff739..103e2c93c342 100644=0A=
> --- a/drivers/soc/imx/Makefile=0A=
> +++ b/drivers/soc/imx/Makefile=0A=
> @@ -1,5 +1,5 @@=0A=
>   # SPDX-License-Identifier: GPL-2.0-only=0A=
>   obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o=0A=
>   obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o=0A=
> -obj-$(CONFIG_ARCH_MXC) +=3D soc-imx8.o=0A=
> +obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o=0A=
>   obj-$(CONFIG_IMX_SCU_SOC) +=3D soc-imx-scu.o=0A=
> diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8m.c=0A=
> similarity index 100%=0A=
> rename from drivers/soc/imx/soc-imx8.c=0A=
> rename to drivers/soc/imx/soc-imx8m.c=0A=
=0A=
