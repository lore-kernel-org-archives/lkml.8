Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8DAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 05:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE4E20782
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 05:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="njnr49IZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgF1FFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 01:05:20 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:25955
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbgF1FFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 01:05:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0V70N1mzbPtAd/Ac+6xS4cGXLtU9rJdK/nS1yrYx0bfATGyaSIhh9C8bY+3EGAcIsAJjVHM4V0yBWITc4/uTyUCD9zHCfJadxwsKV0WPRZ7BQbkV22KsIAy05Ptxa1tbJF6zkjnEVb6Jq6PJSTCWuOkb82wjuC3YcW6VdOt3IBmEvoI6E26SH6uC3JUg7Xbbh8/nSBXfCGGcSasOENqk5WK/n6Sn+K/tHwQzx/ZlPopgBMGWtvPdk/h1WAEhPQJTlYO6J4eyy0Xlyz+NanTbRUf/NlURx0cpF4bMXcZFtBMF719LAEw5ShpIJ7AdVPe1TMMvbQZvtooq6gaEyF2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7l9GV1dbxIZM4h7beds6oD7wPsHwhruQapohL3Xbz3U=;
 b=Gw+3yU6ZH7MyYYkUvPLNMdZuFfsHTKDAySpOnlfdR9TuStHEGhW3ztFTDtEzrykxmfX92Z/78KHGLywIE44uMaQpBLp5+JLdh2cTgYKm/TITXawCLNmk+YgWXgPQp3FWByPmy+Zf4qNRP2rGkh/Q9dgY0Jq/5aJVvD550aMmdMT/X0JjamvwydhW0J3tvJS9mgQkawaVTdkamZWLHMe823L2ZFnUe36OlSg8WORRphFnujotBGkI0nI1e7m+FUzCCFpq+/yxkRVg1gew9xghOBvmBaeVlhnKxmVxcaW0DcDyXF45nwczYxMtWdhBDkHvbZ75ebtfeEgaNjHwMzvgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7l9GV1dbxIZM4h7beds6oD7wPsHwhruQapohL3Xbz3U=;
 b=njnr49IZuxduyizBeq7OyTYQmWQVAuzagaOc0ArAN3RmmnlYAcKHYXnNnktv7CHa9VEqt54V/EKxV6XV0wo0CwwnVzTurx+rTDhGSuuyuuDC9/UMP265esgz4xaMAcyaKJjotBG2WaJc7xM+yDBADjwU6laG2wj++1BtgSz0ukE=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR0402MB3605.eurprd04.prod.outlook.com
 (2603:10a6:209:3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Sun, 28 Jun
 2020 05:05:15 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1%7]) with mapi id 15.20.3131.026; Sun, 28 Jun 2020
 05:05:15 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH v4 2/2] ARM: imx6plus: enable internal routing of
 clk_enet_ref where possible
Thread-Topic: [EXT] [PATCH v4 2/2] ARM: imx6plus: enable internal routing of
 clk_enet_ref where possible
Thread-Index: AQHWSvkYcUowKEcmtU6JLU1iKnAQWajtfTlQ
Date:   Sun, 28 Jun 2020 05:05:15 +0000
Message-ID: <AM6PR0402MB3607D35B83AF82EF0A25DA3DFF910@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200625140105.14999-1-TheSven73@gmail.com>
 <20200625140105.14999-2-TheSven73@gmail.com>
In-Reply-To: <20200625140105.14999-2-TheSven73@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c155350-6b8d-4a8e-15ef-08d81b20d878
x-ms-traffictypediagnostic: AM6PR0402MB3605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB3605A00EA6405E5656BDCA92FF910@AM6PR0402MB3605.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0448A97BF2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BAiTpccLxDtOsB6eI6eJBy5+2D6HX/M/Pkfh0nn31UsKJExDYldNL+8vhPTMOktHZm9XcWBMgkqkveHjGyDeT18l1f+iJAHsznYL1YXDdePwy0WvWMIFdNegKIzYZhZH6T57zcJDlaUpD8Gubpnh5dfUb71E3GKqWY0pGzakLsZRdcrgqDdeCaYGzxYRMTeQjgLjK0YwzSn7g6giNKoPJGXlLeNFRX/w+fLQaPM3musbEU4h1QzcunM/1N9uG76cRNmg7LTYU3ule2/cclE2NMYuDiN7tgGYlxWQXFICMSjC8HulqZW6IuC7e/qf/v7oGbAzLg5bKgzhoZ0FKB7iw15qqtPeED4+ImXJT1QlT5V17um1i3De9+GED9paNGaB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(366004)(136003)(346002)(376002)(66446008)(64756008)(26005)(66556008)(66476007)(33656002)(7696005)(66946007)(76116006)(478600001)(8676002)(186003)(5660300002)(86362001)(83380400001)(6506007)(9686003)(110136005)(52536014)(4326008)(2906002)(55016002)(316002)(54906003)(8936002)(71200400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7Fa5VLbx32Ct+wFoAa2hOSvGBGGFthzSWXxHzTnMYvueBB/kdRZM5v7vss7JaDvAsHkXfH646Ufg4U6vgU84sUFm0exV36ZvSp9yjiUwkdWM6yqO0zLOSLy88TDlF1WjdZ9n0lKjrTyZmj4fcA0gzmi3J+60Z9kk+mqEFy2unXT+0aBD+KtDCi/Q4d67NEKx+zbzvOHiipe/I/3jLjIqJphkJLIrcuN/u94VPB5vX68UxecsNcThNVunl7moSO/GDGs3egYC07g4+rmSpNlIDifDNQWTyBwFpOgTUS83etaka2J2Ktb9xHfPt87tHc6LttUulXG/Cv2aRyZIdqotNIK5SSEOCBrrs0G1P9vAQkJilfbMU8taCnjKskr17J/5PFVnoWCKh/NeyCTb8pGFjoh4wWfcEohDoZo55avdoCkE6o+F0kVtWL9+4MbmN4GoLaAnfRL5PDOf++TeQCOjborNBMvoHzhhPw2lJWuvxJs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c155350-6b8d-4a8e-15ef-08d81b20d878
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2020 05:05:15.6439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySbnv1FMsmGCO8zgRDe6TSMePnvmgT6z/FAgssPkR+vB91YgHVO6/v8M1TTi4YQPwduBw022/sAxdQet6eJdEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <thesven73@gmail.com> Sent: Thursday, June 25, 2020=
 10:01 PM
> On imx6, the ethernet reference clock (clk_enet_ref) can be generated by
> either the imx6, or an external source (e.g. an oscillator or the PHY). W=
hen
> generated by the imx6, the clock source (from ANATOP) must be routed to t=
he
> input of clk_enet_ref via two pads on the SoC, typically via a dedicated =
track
> on the PCB.
>=20
> On an imx6 plus however, there is a new setting which enables this clock =
to
> be routed internally on the SoC, from its ANATOP clock source, straight t=
o
> clk_enet_ref, without having to go through the SoC pads.
>=20
> Board designs where the clock is generated by the imx6 should not be
> affected by routing the clock internally. Therefore on a plus, we can ena=
ble
> internal routing by default.
>=20
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>

For the version:

Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
> ---
> v3 -> v4:
>   - avoid double-check for IS_ERR(gpr) by including Fabio Estevam's
>     patch.
> v2 -> v3:
>   - remove check for imx6q, which is already implied when
>     of_machine_is_compatible("fsl,imx6qp")
> v1 -> v2:
>   - Fabio Estevam: use of_machine_is_compatible() to determine if we
>     are running on an imx6 plus.
>=20
> To: Shawn Guo <shawnguo@kernel.org>
> To: Andy Duan <fugang.duan@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
>=20
>  arch/arm/mach-imx/mach-imx6q.c              | 14 ++++++++++++++
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  1 +
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/arch/arm/mach-imx/mach-imx6q.c
> b/arch/arm/mach-imx/mach-imx6q.c index ae89ad93ca83..07cfe0d349c3
> 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -204,6 +204,20 @@ static void __init imx6q_1588_init(void)
>         regmap_update_bits(gpr, IOMUXC_GPR1,
> IMX6Q_GPR1_ENET_CLK_SEL_MASK,
>                            clksel);
>=20
> +       /*
> +        * On imx6 plus, enet_ref from ANATOP/CCM can be internally
> routed to
> +        * be the PTP clock source, instead of having to be routed throug=
h
> +        * pads.
> +        * Board designs which route the ANATOP/CCM clock through pads
> are
> +        * unaffected when routing happens internally. So on these design=
s,
> +        * route internally by default.
> +        */
> +       if (clksel =3D=3D IMX6Q_GPR1_ENET_CLK_SEL_ANATOP &&
> +                       of_machine_is_compatible("fsl,imx6qp"))
> +               regmap_update_bits(gpr, IOMUXC_GPR5,
> +                               IMX6Q_GPR5_ENET_TXCLK_SEL,
> +                               IMX6Q_GPR5_ENET_TXCLK_SEL);
> +
>         clk_put(enet_ref);
>  put_ptp_clk:
>         clk_put(ptp_clk);
> diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> index d4b5e527a7a3..eb65d48da0df 100644
> --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> @@ -240,6 +240,7 @@
>  #define IMX6Q_GPR4_IPU_RD_CACHE_CTL            BIT(0)
>=20
>  #define IMX6Q_GPR5_L2_CLK_STOP                 BIT(8)
> +#define IMX6Q_GPR5_ENET_TXCLK_SEL              BIT(9)
>  #define IMX6Q_GPR5_SATA_SW_PD                  BIT(10)
>  #define IMX6Q_GPR5_SATA_SW_RST                 BIT(11)
>=20
> --
> 2.17.1

