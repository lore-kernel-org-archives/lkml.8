Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E1FC2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF59720B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K8MS6S/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDJC5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 22:57:22 -0400
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:34912
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbgDJC5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 22:57:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggxRl+Pa8ryTa2SyhDzK5KoVVFH2k8BrQlXIEKHT32Ra6BN11YKPBk0flTkNQgO9AbQFfJyyCZXGieWTM6rECfLbj2b/99EGzzFQNoekviIPArHRcT/n7QMk4ExGeQr1didgNYnTXDtnU5VfIRCBvkE/25Lk8DkKQO/BF1idWWkZV+l3z6I2oKYrQExJMz7jm0lJAFaNyqfJRtTyrI7/9dVH3vaBnbdYt3HDWW+OU8WPXum4W6iz8wUliMHPnP2rbaCmYIinIPwUDb9OrvRreCStyNrr7cfM5hZ9Ul990qpiesiriTH4UN/gsHpN9R+IAlkL2B5uCvblGcHTcVjSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPp8InAV/rLxcVs2WqvCvrkeZmu9p/r8TRlZX4FVUI8=;
 b=mCLgQAeePQUdGgdz+HHyWCdHpkVwogKPhIUKyCt1xXnw1+eTZEfdL0Y6BCYsa+eTReaY9069PjgWSd4xPS1MY0DmOYd21KJitCc+VPYKCfp8M7sjKGq/HBOXOJncQoJWpc+aos8ERGm9fXfygbNjlUrC8B2043uppY5tbqCsR78Qro9dsvSnomCd/x0DcQgNUdzF9U24Jsdgvr9uQ3LxNaWdPFjdU+fvguG2t1KMyzJeTZJs2RM0uQdr7QClk+qTh5A2RGSu+iLe6uCs4Vbvu359QyEJX9YlWrDm/cZhZ/4T/sXAP+PXRawU6sFOngXnkaNIDfSfxpfrsjyv3HgymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPp8InAV/rLxcVs2WqvCvrkeZmu9p/r8TRlZX4FVUI8=;
 b=K8MS6S/xIHFie0Y+tuPPpvPYhLrBA8oh6ZO6qgwv1rqpT/stDV9Co9bp9mi8ZRynDQmVG7UKPYhaixW+Q7Q1Oqrr0gY+9yOQTXyI446u+lds1Wl781xmgHH4pjfYU6pHQH+08pNgvfgHG+7d2UyXreY3I5Y8G0hcBp2Ewv4vV2E=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB5795.eurprd04.prod.outlook.com (2603:10a6:208:129::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Fri, 10 Apr
 2020 02:57:17 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 02:57:17 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3] clk: imx7ulp: make it easy to change ARM core clk
Thread-Topic: [PATCH V3] clk: imx7ulp: make it easy to change ARM core clk
Thread-Index: AQHV+25io4hbrmtY9UyI4uVCEcItFKhx0Fug
Date:   Fri, 10 Apr 2020 02:57:16 +0000
Message-ID: <AM0PR04MB44818D3FDBC60C41900466E388DE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1584347553-2654-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1584347553-2654-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 351b56c6-9ed5-4777-8182-08d7dcfae0ff
x-ms-traffictypediagnostic: AM0PR04MB5795:|AM0PR04MB5795:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB579530869FAD5255062B139388DE0@AM0PR04MB5795.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(66946007)(966005)(66446008)(66556008)(2906002)(478600001)(64756008)(81156014)(9686003)(55016002)(71200400001)(6506007)(54906003)(186003)(4326008)(66476007)(52536014)(76116006)(110136005)(5660300002)(8936002)(26005)(44832011)(8676002)(86362001)(33656002)(316002)(7696005)(42463001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/tfw0+wBd128EykcgUfB37xV2RApmiV3xYUBN78gTYVjeR0kHBD9LHsFme+YBYc67WKlp1POLA+Ze0dHtOJCGUXEYzS67B4OcC6wy1d9E83AESNgd0nHGCWKB7k1hFEhXHxfMw0H5PxFRPmAWzdXQnnC4Faw5lquau5V4PMdcBXWgBQ0NDCUSHF3Pcn28tNQLEj5c6uVDpMTypPJcA+TnR0IN3+4zKRn2brq/yz8NB+uBhTVKMH2/9RfwbxgEUsq+eUbjbHugyc+aW5jxsd362tctaBIKlWC0Ze41SMe35KTeccTtY/CJ74JCzI/NaNqDnx50FNGTdhoHQRyeOXI2UGyFiSgRHsU2oWPu4r/47FaxmeqL1dsZo9MW78Jmbzw6440M4y00WpnfdkRd/Yy/q2gmBgUEBiUNTqfyIOjOSOFK3eVy8v9kcCr7PekN3R0k3yN8VdeV+i3i2OhIS3SAuPdWiB5Z0KPeQ/OXOjf+J8gG3slrt7ZEazyXzwO8xH2OXnxJzhB5vnuGb0zctYEe71ZYUulP7VXqLGhWzwOBeVyuqPRyKSHbZ/TwltZoQM
x-ms-exchange-antispam-messagedata: CIsh1PsycGZW/4ID2i98ugirSmOpHFWW76j5b9BD+4m0bvgOrKjpUBngK0Q0X1cicRxYkITKs+cXszCu1NdE+/Q+RlE026pIYUzvZqtm9iAPvH1r6q/Vh6M+gnv6tOJF5iKQKLpC+83njSEye/eUtw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351b56c6-9ed5-4777-8182-08d7dcfae0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 02:57:16.9891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJFA+rA11fNL0KA8DHRmJ8gmRgalqMwIqTGbipCxvUVvDRVGGnTwEGqZzff25PDVd8WRtQagja8VE0GvrpEY7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH V3] clk: imx7ulp: make it easy to change ARM core clk

This patch is important for us to support cpufreq on i.MX7ULP,
Could I have any A-b or R-b tags?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> ARM clk could only source from divcore or hsrun_divcore.
>=20
> Follow what we already used on i.MX7D and i.MX8M SoCs, use
> imx_clk_hw_cpu API. When ARM core is running normaly, whether divcore or
> hwrun_divcore will finally source from SPLL_PFD0. However SPLL_PFD0 is
> marked with CLK_SET_GATE, so we need to disable SPLL_PFD0, when
> configure the rate.
> So add CORE and HSRUN_CORE virtual clk to make it easy to configure the c=
lk
> using imx_clk_hw_cpu API.
>=20
> Since CORE and HSRUN_CORE already marked with CLK_IS_CRITICAL, no
> need to set ARM as CLK_IS_CRITICAL. And when set the rate of ARM clk,
> prograting it the parent with CLK_SET_RATE_PARENT will finally set the
> SPLL_PFD0 clk.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V3:
>  Update commit log. Make this a standalone patch from V2
> V2:
>  https://patchwork.kernel.org/patch/11390595/
>  No change
>=20
>  drivers/clk/imx/clk-imx7ulp.c             | 6 ++++--
>  include/dt-bindings/clock/imx7ulp-clock.h | 5 ++++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.=
c
> index 3710aa0dee9b..634c0b6636b0 100644
> --- a/drivers/clk/imx/clk-imx7ulp.c
> +++ b/drivers/clk/imx/clk-imx7ulp.c
> @@ -29,7 +29,7 @@ static const char * const ddr_sels[]		=3D
> { "apll_pfd_sel", "dummy", "dummy", "dum
>  static const char * const nic_sels[]		=3D { "firc", "ddr_clk", };
>  static const char * const periph_plat_sels[]	=3D { "dummy", "nic1_bus_cl=
k",
> "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
>  static const char * const periph_bus_sels[]	=3D { "dummy", "sosc_bus_clk=
",
> "dummy", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_cl=
k", };
> -static const char * const arm_sels[]		=3D { "divcore", "dummy", "dummy",
> "hsrun_divcore", };
> +static const char * const arm_sels[]		=3D { "core", "dummy", "dummy",
> "hsrun_core", };
>=20
>  /* used by sosc/sirc/firc/ddr/spll/apll dividers */  static const struct
> clk_div_table ulp_div_table[] =3D { @@ -121,7 +121,9 @@ static void __ini=
t
> imx7ulp_clk_scg1_init(struct device_node *np)
>  	hws[IMX7ULP_CLK_DDR_SEL]	=3D imx_clk_hw_mux_flags("ddr_sel",
> base + 0x30, 24, 2, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_RATE_PARENT |
> CLK_OPS_PARENT_ENABLE);
>=20
>  	hws[IMX7ULP_CLK_CORE_DIV]	=3D imx_clk_hw_divider_flags("divcore",
> 	"scs_sel",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT);
> +	hws[IMX7ULP_CLK_CORE]		=3D imx_clk_hw_cpu("core", "divcore",
> hws[IMX7ULP_CLK_CORE_DIV]->clk, hws[IMX7ULP_CLK_SYS_SEL]->clk,
> hws[IMX7ULP_CLK_SPLL_SEL]->clk, hws[IMX7ULP_CLK_FIRC]->clk);
>  	hws[IMX7ULP_CLK_HSRUN_CORE_DIV] =3D
> imx_clk_hw_divider_flags("hsrun_divcore", "hsrun_scs_sel", base + 0x1c, 1=
6,
> 4, CLK_SET_RATE_PARENT);
> +	hws[IMX7ULP_CLK_HSRUN_CORE] =3D imx_clk_hw_cpu("hsrun_core",
> +"hsrun_divcore", hws[IMX7ULP_CLK_HSRUN_CORE_DIV]->clk,
> +hws[IMX7ULP_CLK_HSRUN_SYS_SEL]->clk,
> hws[IMX7ULP_CLK_SPLL_SEL]->clk,
> +hws[IMX7ULP_CLK_FIRC]->clk);
>=20
>  	hws[IMX7ULP_CLK_DDR_DIV]	=3D imx_clk_hw_divider_gate("ddr_clk",
> "ddr_sel", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, base + 0x30, 0, 3,
>  							       0, ulp_div_table, &imx_ccm_lock);
> @@ -270,7 +272,7 @@ static void __init imx7ulp_clk_smc1_init(struct
> device_node *np)
>  	base =3D of_iomap(np, 0);
>  	WARN_ON(!base);
>=20
> -	hws[IMX7ULP_CLK_ARM] =3D imx_clk_hw_mux_flags("arm", base + 0x10,
> 8, 2, arm_sels, ARRAY_SIZE(arm_sels), CLK_IS_CRITICAL);
> +	hws[IMX7ULP_CLK_ARM] =3D imx_clk_hw_mux_flags("arm", base + 0x10,
> 8, 2,
> +arm_sels, ARRAY_SIZE(arm_sels), CLK_SET_RATE_PARENT);
>=20
>  	imx_check_clk_hws(hws, clk_data->num);
>=20
> diff --git a/include/dt-bindings/clock/imx7ulp-clock.h
> b/include/dt-bindings/clock/imx7ulp-clock.h
> index 38145bdcd975..b58370d146e2 100644
> --- a/include/dt-bindings/clock/imx7ulp-clock.h
> +++ b/include/dt-bindings/clock/imx7ulp-clock.h
> @@ -58,7 +58,10 @@
>  #define IMX7ULP_CLK_HSRUN_SYS_SEL	44
>  #define IMX7ULP_CLK_HSRUN_CORE_DIV	45
>=20
> -#define IMX7ULP_CLK_SCG1_END		46
> +#define IMX7ULP_CLK_CORE		46
> +#define IMX7ULP_CLK_HSRUN_CORE		47
> +
> +#define IMX7ULP_CLK_SCG1_END		48
>=20
>  /* PCC2 */
>  #define IMX7ULP_CLK_DMA1		0
> --
> 2.16.4

