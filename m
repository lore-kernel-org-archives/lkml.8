Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73144C35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3982520675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o1NuAwU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgBXBNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:13:39 -0500
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:14913
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727151AbgBXBNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:13:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRpYxmG6RESaz4vext5QxwsFTAHqAL90CV3D3owFaSr/z8rmSIE1g/0SL/PfPnXp6yztw2q211oMMKObJuVMwr6AMhwZGYXCtBLTWdXRRyIs5GmTKob4GFKM0ida7ZAXrPboDdKEcuIC5+Tt0g4KnEyMnjd+raPnylH66F1BZT3XbNiCo6ClnS6xjfw+h0T8Q7YGLXwrjRBuNihDZ3itS+qyQijJtbSqqBgYT0g1Xc4AAqs8CUmL3sjh3bHdXdPe9l9eAnvQxnPUKwK1INtDsxWxS9GCpS3J4iFg26/SBArd7WEkeBDfSD+zsuuV4doY8zZDOQeEGCW85KYOLkfifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTaeFQzM9ZAZi6Z7CvVHmRzhgAxeplQ48EkpyO9HGSc=;
 b=ArNHw1kAvJucw6E6sHTugcRrl2d+yqk0vMPfU/0ajKzQhMvU5DpP/W2iz1kNraYCls0EEYNj8miqyzRZMf9YMIMRZb4jXXq3iM087dUCMeQlBcTSCuDW6Kxzxkd/zqK59D1IxdsK7tIqYcTpTygrkHgFvomLcJnmMtyVAkneccHsXhrcD/yZHz6ZOkqNKVWIWMHEV3qMQabl+mEZ0YT36tvzME4flphenxLiFLGXmZJRE1znlRr/ejtPnx0zgiTQK8NInm+ZU0Z2G0xVVnGzdJXNuBLfnKIZu1rp7MR7FmmHbhfVjJ74a8j8jeuwQjbZeP+/MXYT2JCqTQqDSHZRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTaeFQzM9ZAZi6Z7CvVHmRzhgAxeplQ48EkpyO9HGSc=;
 b=o1NuAwU4xlLS/dC9Lo56R/nHnzBy2b6XJ7EAFtzSe3dAq82wPL4W3ellLpZxeV21hRDn7v3iqnFbvWS03ndiNmj+RqGikzD8YIp8AxlHBuOku/A9kikRwxBXshNLkUpKOJH/bw2BFmM7OLxqgCIMuZWh6VW8cU+19qQVf+AUNX0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5219.eurprd04.prod.outlook.com (20.177.42.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 01:13:35 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 01:13:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: RE: [PATCH RESEND v3 4/4] clk: imx: imx8mp: fix a53 cpu clock
Thread-Topic: [PATCH RESEND v3 4/4] clk: imx: imx8mp: fix a53 cpu clock
Thread-Index: AQHV5w6f0zjaDYEaLkyYsPIcQ5s2t6gpkOhw
Date:   Mon, 24 Feb 2020 01:13:35 +0000
Message-ID: <AM0PR04MB4481D310ED1E08FBDB300FC288EC0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582107429-21123-1-git-send-email-peng.fan@nxp.com>
 <1582107429-21123-5-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1582107429-21123-5-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [117.82.241.14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ecce32b-0f51-44ce-7f60-08d7b8c6c5bd
x-ms-traffictypediagnostic: AM0PR04MB5219:|AM0PR04MB5219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5219EA21D43D8009B07E802988EC0@AM0PR04MB5219.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(71200400001)(8936002)(81156014)(2906002)(81166006)(44832011)(52536014)(478600001)(6636002)(8676002)(316002)(54906003)(66556008)(66446008)(66476007)(66946007)(64756008)(5660300002)(86362001)(7696005)(33656002)(186003)(6506007)(4326008)(110136005)(9686003)(55016002)(76116006)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5219;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ci+zyzSvPoOtt64WjM/EpXsXOaatBxubNKhDrvCMCZUm654e8k8kQ3/SKpod7dZA2NrPJwWbg1hGpaxDytFBcaIu1FkSFO9Nm7mQO4YdALfnqCFPHMEkMnwjI7oBu7Br89AlWplgVJZFBQA1etVf3FS3Z0PuQucFT+opHOChC763lcH7WMXiLJyQwgyN8HIkuFC2NOIFPVS6zKhHnazvVJtmLRgf0xQrhp6bg3J1tCyJ1JRRMxmHpHE/kxWiKEsxdGdscvqiR5W+3dhjPtVUrLoPh8iCP4nWFI75sNSK2L1DPloJ6tnkHPvgfFgS0ACtYlAZ6LZ65pL7mBOFokmZ1gCsQkVQT+u/f/AtgB1f+S10+WfxzvIynpqgK95ZyDuHObatSPWG4/RlOuQ/Tej+Dwft1rDOfKwqdTTWokAi3ELgPl98iCOQFAU2PdLvaJVS7kD6JpRjQKs1pbL7/iOVe7SJBsSmaR1tWlO2KU0EVF3lYauyadcqY8HDQAiCKeA0
x-ms-exchange-antispam-messagedata: 4jEg0mRZlRdh6Zm1mI3CXRaRqeMk/0anjesKm6V4KQWuRv/mgTaOGNpC6WA+Da3fV0HKstjnGeXUtVm4ruPtP9GKlWeqXI+sferFMfwyAY6QsD8V5hyG8NZr48SsLD1efrrLsakppxbspLKqq/5pow==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecce32b-0f51-44ce-7f60-08d7b8c6c5bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 01:13:35.4161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AKlRZOoVUcnoyyf0AQQlmSaLQXUaW2QRWuwETBZyPjhbzNXArtG1iAPeLA80cYDGEeQ6WgZz2FZvsyc8tyiYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: [PATCH RESEND v3 4/4] clk: imx: imx8mp: fix a53 cpu clock

Would you pick up this? Without this patch, i.MX8MP will hang when
booting.

Thanks,
Peng.
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The A53 CCM clk root only accepts input up to 1GHz, CCM A53 root signoff
> timing is 1Ghz, however the A53 core which sources from CCM root could ru=
n
> above 1GHz which voilates the CCM.
>=20
> There is a CORE_SEL slice before A53 core, we need configure the CORE_SEL
> slice source from ARM PLL, not A53 CCM clk root.
>=20
> The A53 CCM clk root should only be used when need to change ARM PLL
> frequency.
>=20
> Add arm_a53_core clk that could source from arm_a53_div and arm_pll_out.
> Configure a53 ccm root sources from 800MHz sys pll Configure a53 core
> sources from arm_pll_out Mark arm_a53_core as critical clk
>=20
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mp.c             | 16 ++++++++++++----
>  include/dt-bindings/clock/imx8mp-clock.h |  3 ++-
>  2 files changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index a16af4fce044..d67ee36b84de 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -34,6 +34,8 @@ static const char * const imx8mp_a53_sels[] =3D
> {"osc_24m", "arm_pll_out", "sys_pl
>  					       "sys_pll2_1000m", "sys_pll1_800m",
> "sys_pll1_400m",
>  					       "audio_pll1_out", "sys_pll3_out", };
>=20
> +static const char * const imx8mp_a53_core_sels[] =3D {"arm_a53_div",
> +"arm_pll_out", };
> +
>  static const char * const imx8mp_m7_sels[] =3D {"osc_24m", "sys_pll2_200=
m",
> "sys_pll2_250m",
>  					      "vpu_pll_out", "sys_pll1_800m",
> "audio_pll1_out",
>  					      "video_pll1_out", "sys_pll3_out", }; @@
> -554,6 +556,9 @@ static int imx8mp_clocks_probe(struct platform_device
> *pdev)
>  	hws[IMX8MP_CLK_HSIO_AXI_DIV] =3D
> imx_clk_hw_divider2("hsio_axi_div", "hsio_axi_cg", ccm_base + 0x8380, 0, =
3);
>  	hws[IMX8MP_CLK_MEDIA_ISP_DIV] =3D
> imx_clk_hw_divider2("media_isp_div", "media_isp_cg", ccm_base + 0x8400,
> 0, 3);
>=20
> +	/* CORE SEL */
> +	hws[IMX8MP_CLK_A53_CORE] =3D
> imx_clk_hw_mux2_flags("arm_a53_core",
> +ccm_base + 0x9880, 24, 1, imx8mp_a53_core_sels,
> +ARRAY_SIZE(imx8mp_a53_core_sels), CLK_IS_CRITICAL);
> +
>  	hws[IMX8MP_CLK_MAIN_AXI] =3D
> imx8m_clk_hw_composite_critical("main_axi", imx8mp_main_axi_sels,
> ccm_base + 0x8800);
>  	hws[IMX8MP_CLK_ENET_AXI] =3D imx8m_clk_hw_composite("enet_axi",
> imx8mp_enet_axi_sels, ccm_base + 0x8880);
>  	hws[IMX8MP_CLK_NAND_USDHC_BUS] =3D
> imx8m_clk_hw_composite_critical("nand_usdhc_bus",
> imx8mp_nand_usdhc_sels, ccm_base + 0x8900); @@ -724,11 +729,14 @@
> static int imx8mp_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MP_CLK_VPU_ROOT] =3D imx_clk_hw_gate4("vpu_root_clk",
> "vpu_bus", ccm_base + 0x4630, 0);
>  	hws[IMX8MP_CLK_AUDIO_ROOT] =3D
> imx_clk_hw_gate4("audio_root_clk", "ipg_root", ccm_base + 0x4650, 0);
>=20
> -	hws[IMX8MP_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_div",
> -					     hws[IMX8MP_CLK_A53_DIV]->clk,
> -					     hws[IMX8MP_CLK_A53_SRC]->clk,
> +	clk_hw_set_parent(hws[IMX8MP_CLK_A53_SRC],
> hws[IMX8MP_SYS_PLL1_800M]);
> +	clk_hw_set_parent(hws[IMX8MP_CLK_A53_CORE],
> hws[IMX8MP_ARM_PLL_OUT]);
> +
> +	hws[IMX8MP_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_core",
> +					     hws[IMX8MP_CLK_A53_CORE]->clk,
> +					     hws[IMX8MP_CLK_A53_CORE]->clk,
>  					     hws[IMX8MP_ARM_PLL_OUT]->clk,
> -					     hws[IMX8MP_SYS_PLL1_800M]->clk);
> +					     hws[IMX8MP_CLK_A53_DIV]->clk);
>=20
>  	imx_check_clk_hws(hws, IMX8MP_CLK_END);
>=20
> diff --git a/include/dt-bindings/clock/imx8mp-clock.h
> b/include/dt-bindings/clock/imx8mp-clock.h
> index 2fab63186bca..c92d1f4117eb 100644
> --- a/include/dt-bindings/clock/imx8mp-clock.h
> +++ b/include/dt-bindings/clock/imx8mp-clock.h
> @@ -294,7 +294,8 @@
>  #define IMX8MP_CLK_DRAM_ALT_ROOT		285
>  #define IMX8MP_CLK_DRAM_CORE			286
>  #define IMX8MP_CLK_ARM				287
> +#define IMX8MP_CLK_A53_CORE			288
>=20
> -#define IMX8MP_CLK_END				288
> +#define IMX8MP_CLK_END				289
>=20
>  #endif
> --
> 2.16.4

