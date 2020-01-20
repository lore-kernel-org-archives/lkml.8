Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FE3C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CF62087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lg28HM97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgATNkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:40:16 -0500
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:53380
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726991AbgATNkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:40:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQz582JJut6a3XXUOeJBE5ANXtlJ0bn8j+Focf5ohjxvtsmpBzYbm3GLGg9l+KqRh/5aCIso4cBYRWKJbscqYw8xdXjbcSbZCNJi8LhSFOCZX2jy7fmQMzLNfIpEpvZ8VCcjgdqvIF4nZylCnyfPrFiqemDnWNK7E0enFuR16j5rgvZXfXAuaHUXL4EWq+Tlc6zmLY1AgCV1ebGTB1N3ftCFsGCsKxL/f9pnMDL5tO7yJMCYOQmPfoxHrvl1wHCayalTtFWreq9ToFmLMkBJk53ef9/QbihIkbM+LZqj2jHjh57vRyYqPTvVXJfgbsgyZk9AbB+2xeI2XoxO1Qa0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyGZy3sD8EmZuxkstiz1d477j7s9NMXzEstrmtRDH6U=;
 b=dHNeCrbfikInOM0tsUn4aYJB0+XleFXx+9Q3puyllX9kwqzdv0sowILQxfn4d3vkpXgwb/HlLeP+gZAZn2XkH+VnzigyGXbaxTgGQ2r//ob0Us+QfKWDDUjC42cqP7BmjBWIKtspbQVjGHm3lQcjxtIJG1ZbbJKud1Nns8yf+yUj4ASUAoEG+aUoXRBTPJJzaB9+mAIBiW+GP9fT+RrErOyMYM3pxUIzFFDJ5a8Y5o+6TLKJ1t/AhIX/Wna2rYbe4o6Q/SnOQmAJQ8MJXuFnQOZEFIO0cWyRaIX7DHPIhKHo6sm/fjF3Q5VpRzxAcVGu6/ssWOX4LIw5KKOxwyCgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyGZy3sD8EmZuxkstiz1d477j7s9NMXzEstrmtRDH6U=;
 b=lg28HM97Ym9G+vTgC/sVxPU390osKrZSiPLWzOh7oUsqeCimUw+CI+PdTz1X3Z71m61xVFVgG699zdQSOy2F1f1HOxiN2wlhBBBQm7Pys8QZD69YNdhVlrXoyYC+ilty0Yc+zj1aNnjRuSAVNZu/zDSbbxrWXsYpddgT1olUgFw=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4109.eurprd04.prod.outlook.com (52.133.15.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.22; Mon, 20 Jan 2020 13:40:10 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 13:40:10 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [PATCH V3 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V3 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Index: AQHVzBLhUkGtl3RwMUeoFEsar3ylZA==
Date:   Mon, 20 Jan 2020 13:40:10 +0000
Message-ID: <VI1PR04MB70239267F223F63918362DDCEE320@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1579140562-8060-1-git-send-email-peng.fan@nxp.com>
 <1579140562-8060-3-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44fceb7f-dbe2-4a75-b72b-08d79dae453e
x-ms-traffictypediagnostic: VI1PR04MB4109:|VI1PR04MB4109:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB410930A5A3604E52081C0E93EE320@VI1PR04MB4109.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(199004)(189003)(8936002)(55016002)(81166006)(81156014)(71200400001)(9686003)(478600001)(8676002)(110136005)(54906003)(316002)(86362001)(33656002)(186003)(5660300002)(6506007)(53546011)(2906002)(4326008)(76116006)(66946007)(66446008)(64756008)(66476007)(44832011)(66556008)(7696005)(26005)(52536014)(91956017)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4109;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uCv584JttstAW8geNG8aQLJa8goH904BKlAXjhcwt60byZCYv3ZkDAGMyAj3fNIP3Jc49RRT2D+SkCi9I9e1bbY7YHMtq5z2/wA7+x0oRCzBgcRU/GzmSzqeQWKK+2EQn3yW0lIHs/b5Rf+DS/v1poeTKgkn+ZP4emK+wRkjYDkRvmGLt+hiUTEXa5FtSS8sZmVgBHKPjyzz4cTr96VJRSTZDkvBHJgbImB2yl62py9zqeXi9isEfude2fgkZVksoE80P6YVQUo+gDSC0Oq7YYZi3vDe1XVUErKFYmEIg3N2DNvAB5E+KZyg+X1TiDAmpcMECLEyYW77zqjHe53zoAdj9VUcsMJJ35B25TyLUMVM0xcrMg/dX2i5YH2Va+K/EGpBXUaEZbFL5t2WPHWcfQIArzVMihOWc4u7CS1O19FRTjH5lXslZA7ZHwEc02ax5MK0GdI8rhg6iwZ/66B7vVw3MBV8/Ev5DahcEbArEpqVOCP6COxbCfL9fe8lUoRg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fceb7f-dbe2-4a75-b72b-08d79dae453e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 13:40:10.6100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 671PO2fm5mTwNbMX7inSluGjh7gEsvQw99/WJRfVnPMKTQXr3afm3iSiyjVNBvVFqS0pX9IpwJbhyNm688Vu6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.2020 04:15, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> Use imx8m_clk_hw_composite_core to simplify code.=0A=
> =0A=
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>=0A=
> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
> ---=0A=
>   drivers/clk/imx/clk-imx8mq.c | 22 ++++++++--------------=0A=
>   1 file changed, 8 insertions(+), 14 deletions(-)=0A=
> =0A=
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c=
=0A=
> index 4c0edca1a6d0..e928c1355ad8 100644=0A=
> --- a/drivers/clk/imx/clk-imx8mq.c=0A=
> +++ b/drivers/clk/imx/clk-imx8mq.c=0A=
> @@ -403,22 +403,16 @@ static int imx8mq_clocks_probe(struct platform_devi=
ce *pdev)=0A=
>   =0A=
>   	/* CORE */=0A=
>   	hws[IMX8MQ_CLK_A53_SRC] =3D imx_clk_hw_mux2("arm_a53_src", base + 0x80=
00, 24, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels));=0A=
> -	hws[IMX8MQ_CLK_M4_SRC] =3D imx_clk_hw_mux2("arm_m4_src", base + 0x8080,=
 24, 3, imx8mq_arm_m4_sels, ARRAY_SIZE(imx8mq_arm_m4_sels));=0A=
> -	hws[IMX8MQ_CLK_VPU_SRC] =3D imx_clk_hw_mux2("vpu_src", base + 0x8100, 2=
4, 3, imx8mq_vpu_sels, ARRAY_SIZE(imx8mq_vpu_sels));=0A=
> -	hws[IMX8MQ_CLK_GPU_CORE_SRC] =3D imx_clk_hw_mux2("gpu_core_src", base +=
 0x8180, 24, 3,  imx8mq_gpu_core_sels, ARRAY_SIZE(imx8mq_gpu_core_sels));=
=0A=
> -	hws[IMX8MQ_CLK_GPU_SHADER_SRC] =3D imx_clk_hw_mux2("gpu_shader_src", ba=
se + 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_s=
els));=0A=
> -=0A=
>   	hws[IMX8MQ_CLK_A53_CG] =3D imx_clk_hw_gate3_flags("arm_a53_cg", "arm_a=
53_src", base + 0x8000, 28, CLK_IS_CRITICAL);=0A=
> -	hws[IMX8MQ_CLK_M4_CG] =3D imx_clk_hw_gate3("arm_m4_cg", "arm_m4_src", b=
ase + 0x8080, 28);=0A=
> -	hws[IMX8MQ_CLK_VPU_CG] =3D imx_clk_hw_gate3("vpu_cg", "vpu_src", base +=
 0x8100, 28);=0A=
> -	hws[IMX8MQ_CLK_GPU_CORE_CG] =3D imx_clk_hw_gate3("gpu_core_cg", "gpu_co=
re_src", base + 0x8180, 28);=0A=
> -	hws[IMX8MQ_CLK_GPU_SHADER_CG] =3D imx_clk_hw_gate3("gpu_shader_cg", "gp=
u_shader_src", base + 0x8200, 28);=0A=
> -=0A=
>   	hws[IMX8MQ_CLK_A53_DIV] =3D imx_clk_hw_divider2("arm_a53_div", "arm_a5=
3_cg", base + 0x8000, 0, 3);=0A=
> -	hws[IMX8MQ_CLK_M4_DIV] =3D imx_clk_hw_divider2("arm_m4_div", "arm_m4_cg=
", base + 0x8080, 0, 3);=0A=
> -	hws[IMX8MQ_CLK_VPU_DIV] =3D imx_clk_hw_divider2("vpu_div", "vpu_cg", ba=
se + 0x8100, 0, 3);=0A=
> -	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D imx_clk_hw_divider2("gpu_core_div", "g=
pu_core_cg", base + 0x8180, 0, 3);=0A=
> -	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D imx_clk_hw_divider2("gpu_shader_div"=
, "gpu_shader_cg", base + 0x8200, 0, 3);=0A=
> +=0A=
> +	hws[IMX8MQ_CLK_M4_DIV] =3D imx8m_clk_hw_composite_core("arm_m4_div", im=
x8mq_arm_m4_sels, base + 0x8080);=0A=
> +	hws[IMX8MQ_CLK_VPU_DIV] =3D imx8m_clk_hw_composite_core("vpu_div", imx8=
mq_vpu_sels, base + 0x8100);=0A=
> +	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D imx8m_clk_hw_composite_core("gpu_core_=
div", imx8mq_gpu_core_sels, base + 0x8180);=0A=
> +	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D imx8m_clk_hw_composite("gpu_shader_d=
iv", imx8mq_gpu_shader_sels, base + 0x8200);=0A=
=0A=
> +	/* For DTS which still assign parents for gpu core src clk */=0A=
> +	hws[IMX8MQ_CLK_GPU_CORE_SRC] =3D hws[IMX8MQ_CLK_GPU_CORE_DIV];=0A=
> +	hws[IMX8MQ_CLK_GPU_SHADER_SRC] =3D hws[IMX8MQ_CLK_GPU_SHADER_DIV];=0A=
=0A=
Why not assign to all the old clocks?=0A=
