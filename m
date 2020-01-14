Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E74C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F252075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T32zCECK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgANQtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:49:24 -0500
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:24574
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727102AbgANQtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:49:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9E4oR+Rj/mMzfbwMXL9t/mbtHbM6+E82fScoVDzy2dBhnqeWNzVCzomm4UuxqGMR63odw4bxW4N6z6rGxYW8HjPxWH7d6R8rk8U6nN96lsKM6sMjOIR0uX1/QirmrLjHAdUJ8GvlyX3P56vQ8lCcjNHbyu4HUtzK5K8nLoFIR6uBg/6F8649xkpz7/cRNaaxL6KgxJuKfvd0gz/i0/doRFIqHvvcuQ5l6DUD4OzWH2O5jOQX14BDrkQfMI7wPjmLfZoo6DldrmW4c3ir/HjHdwzV6Nd4ULVwlFIMrBaPOsxb+jE7vHbT/VogUNXeqxsanV5OmpNVEaOQNkyQ5Fbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtoNz0yqQKiYLgoKaXmzbbXbIAxcTwRAEmG94KFCaVU=;
 b=QQz4Jk/K1WnIaRLTuleicwFxVd/qMtuesJ3bLIVophk3s2zmQKWfmqqS0a9m6W2p0m6jilvx0S8uPsrd6b8LjoukmCZCjj3ZW3cIjFpA3ENL7xg+87T0HDXwtypLxqJFWw81PNgqMDfqnoFVWaDlde7BWMHdSroi4gECUOGMSozZNVJyOKUAyv1rtZkxCKVWXJXZ3P7os0lyu+kLllttiqIkFvuPaOn2K+0gc+8nMfVtmBJ4poYuaSugRePECx/dAjVTHJWhyQQXw/BxOk6DYzLWicaKyGWCwGO626swlrP9Rbh5xbRXZoxvT2dlcVpw04qgSdlT8NJqoym59Bvlmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtoNz0yqQKiYLgoKaXmzbbXbIAxcTwRAEmG94KFCaVU=;
 b=T32zCECKbXM7BVZK0z2vhX//b8MbIT/qN2PleDZIppBJidk+BT7v/ZKym1qYQDLMRKSjS0mE1vEXmM8KAGBVu8vxu9jwcA7FDTLN6ZxdvbPTbpnPTgYBnOzVQ8dNuHyq9bEcjjVO4T2U+uFigYvrdB+Slp8ng6Edc0AAW5SkNSI=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5757.eurprd04.prod.outlook.com (20.178.126.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 16:49:20 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 16:49:20 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
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
        Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH V2 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V2 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Index: AQHVx4YVaHYUgIfOpEylrWn5NhhQ0A==
Date:   Tue, 14 Jan 2020 16:49:20 +0000
Message-ID: <VI1PR04MB7023981770D458F6D1FB546FEE340@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1578640411-16991-1-git-send-email-peng.fan@nxp.com>
 <1578640411-16991-3-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10ab29de-fbd3-4587-d4d6-08d79911b37b
x-ms-traffictypediagnostic: VI1PR04MB5757:|VI1PR04MB5757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB57578BFF9341A11CA305B58AEE340@VI1PR04MB5757.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(189003)(199004)(5660300002)(81166006)(6506007)(53546011)(316002)(54906003)(55016002)(52536014)(9686003)(478600001)(44832011)(66556008)(66476007)(66946007)(76116006)(64756008)(66446008)(110136005)(7696005)(91956017)(8676002)(2906002)(33656002)(81156014)(86362001)(26005)(186003)(4326008)(8936002)(71200400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5757;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxD+hiEJVSH0wQoHiar1Scria8w4fQRzRaKOXBvWuPY8x3pG8VHZY0Jsiu6hWDOq4ElZxnVX/T2Q02DFoow6+HGqgL1MD4hsM7yCy9ggAtxHJnXII42LE7QAwbCeixBZkHvzXHmY62Jtp5vhdgqkuuNrNhemeqhXvf0hn19jvOlFNHTyoZhqT1reUeqtoSveEjzSMD264rT742VQwhlGliBkprCe0YnpZw7GKvEaO+KnbVEgVdpp1JXyBKws1gOJN/Ax+XNxTpNvX9PlCgaOU+jE0TwOo7YJb7bmZa54nPxaXloQn+A+ZV5B6jpUUceTXJyEhnVecnQA3MNGGYl6uvjMxCu54sE/Ld92VhKHtu7xqHGrysDRfgW5zYK2lRqOJy7jSJf7ltr/1KhwqhaNZq3+AdOPdo2cswMaJhrD0reSYRVHgoyuI8Mg2sSWYYN+AWQbKJpt8pCpIPEC/ui0HMe0KM5GD+C605nGi+9vVNbm8RUcCgfLobSgGfBB6AfQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ab29de-fbd3-4587-d4d6-08d79911b37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 16:49:20.0447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cM3FL2j6zQ4KzL7+b5oBJfIol/6lz2MmAsIhoGIAP/VbHnYWmiHfG0IIER2ge9Y9zeKSivdge4oGb9KzvLXFpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.01.2020 09:17, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> Use imx8m_clk_hw_composite_core to simplify code.=0A=
> =0A=
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>=0A=
> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
> ---=0A=
>   drivers/clk/imx/clk-imx8mq.c | 19 +++++--------------=0A=
>   1 file changed, 5 insertions(+), 14 deletions(-)=0A=
> =0A=
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c=
=0A=
> index 4c0edca1a6d0..b031183ff427 100644=0A=
> --- a/drivers/clk/imx/clk-imx8mq.c=0A=
> +++ b/drivers/clk/imx/clk-imx8mq.c=0A=
> @@ -403,22 +403,13 @@ static int imx8mq_clocks_probe(struct platform_devi=
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
>   =0A=
>   	/* BUS */=0A=
>   	hws[IMX8MQ_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi=
", imx8mq_main_axi_sels, base + 0x8800);=0A=
=0A=
Collapsing _SRC _CG into _DIV is an useful simplification but it =0A=
technically breaks DT compatibility rules.=0A=
=0A=
Inside imx8mq.dtsi there are clock assignments for =0A=
IMX8MQ_CLK_GPU_CORE_SRC and IMX8MQ_CLK_GPU_SHADER_SRC which no longer =0A=
exist so those assignments don't take effect.=0A=
=0A=
I think patching dts would be reasonable fix.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
