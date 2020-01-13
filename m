Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBB9C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D6D20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZdwVJneB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgAMVsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:48:41 -0500
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:6126
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728746AbgAMVsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:48:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh5cXC3Mi/07Y0slkhSg8oj23LTfO4dkXs72Nv7qb8KAuGG3GhpgFfCkewiu9ohfwaMEc7wM2yFYwb1EQsZb5NhHklphqTIx4fPwEf+83ypvdGNUJWX3psBCsTOyzvHugwltY3PG156SnX6DEa1bb51D3wslfSss+UqFDw7ilOf4Nx1IaOFP/853UCGYeUaZELbWRg4NiRWGLEkCUp9d7xTVEVR9DCrB8IDO8pqOjtNBKmYZkUFDBvFjim8NamEMYmyAQ6s/epD/1LzBC4vFTiAH90DP3Yi6EciEYU2FlXcRp4EDXC2Riz4G2tAEVEA/VTjNtHfNLAl7awDDxky6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsUHYK3xGrq3V+57zjg02kzd1iqubfAyG5hTJUNdUGo=;
 b=RZsKC4A48Gudvm9eLqy3Nb79Pu4XI6pUselwalCG2iAe7YuqL/cUs2sRuH6TZwTBNdV2Uv8V8ni8cyvsygFaTI2TLuxVfiJnEf7BG3LxUSlre4LsuaxUVtzjApuEn4xrxjId/RS1zFo82FITwE+pKvBlujAFo4iv48IklynZIO6nAH78/HwFcVdZ++PwtjWkP+4PSd7DVTHVrgCOpkZzWEkZ2r2EkdROZ/ZpIgNWos0PIBUE/xUxyxsQsNZ4qxLJOXiZLm+178NYNEqlA33r2M23kI9kSsRWGZZPPiEB8iMV3K+Jz4ixo8+k0yqlJ456TBInxDGDgiRaEsLegeaQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsUHYK3xGrq3V+57zjg02kzd1iqubfAyG5hTJUNdUGo=;
 b=ZdwVJneBuchnir5iQRI9BbFVs1LD2NDidGf7PjYNAvOig+Ftp9fcouclvBEumqoT6BeVqjbE8+UghJJu8jfWAUmIIBpMiRNpmpz4Mx5AGqxKqA1kg4tJL8M5fyy09Pa5PwfT/nfZA2kgieKBMqEcWBF9MaKc9C98HVgAPyGPHTk=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4942.eurprd04.prod.outlook.com (20.177.50.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.16; Mon, 13 Jan 2020 21:48:35 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 21:48:34 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH V2 3/4] clk: imx: imx8mm: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V2 3/4] clk: imx: imx8mm: use imx8m_clk_hw_composite_core
Thread-Index: AQHVx4YX3PTv50+zWUiBWV9s8OC3Ag==
Date:   Mon, 13 Jan 2020 21:48:34 +0000
Message-ID: <VI1PR04MB70237EA2E18574985CAB529DEE350@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1578640411-16991-1-git-send-email-peng.fan@nxp.com>
 <1578640411-16991-4-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a7e8161-a55e-45e4-85db-08d7987256fe
x-ms-traffictypediagnostic: VI1PR04MB4942:|VI1PR04MB4942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4942EE1DF885966CC344F98CEE350@VI1PR04MB4942.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:404;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(81156014)(5660300002)(33656002)(4326008)(66946007)(6636002)(8936002)(66556008)(91956017)(44832011)(66446008)(76116006)(478600001)(66476007)(53546011)(8676002)(86362001)(186003)(54906003)(316002)(2906002)(64756008)(6506007)(110136005)(81166006)(7696005)(52536014)(71200400001)(9686003)(55016002)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4942;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7YOlKN5rvXrgvdQvVPXspbLwJTDmOgp28DzQCKzE8Xo1Ra41QHcVsO8jbIvqqEpDGVKpQ+GTBn0faNLfb/8odtkNCZBo2cvea+LQjL4Q1Xqxo8ObuYRKnsa77Oo0vEfAYg52RplC5/bBYsl+XK3aiM66V6yoq4rjjXlxKkqkCYntvJpEd1zxsv00ebDfcXWnrp+0N4NfXZBJhp+LX/GrTjCEinkPTTOfpAiwhT/BWWWIl+ZVdzK65OjteeYMp26CJB5LceHsyErzrCCUIvee/4aPM5jS9orUQdYBQW1Iqtlp1dQYrPM0aGVtz7GR7f6Yzq+qo214tt6bE3/7ug2iKhWn8OqK/zVM1Ue5BsnCXy6nEU6auqcpysbE6BMvGoRulm2VUlR0Q5cjIFCP9tBcrKO7ch3nRIAJwix137ftjzK5TeOZnCWxZov0SeIRfExRe7i4eIyH6K2dgR3jWdmU5FVh4f9+vEDknHX2i52z3MajPpbdzWF6SJtcMfAgt+kF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7e8161-a55e-45e4-85db-08d7987256fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 21:48:34.8224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZMoFB5bGBlbygj0pxgJFN62QeE7pEWHrN0iuloyDaDwM4bfaji070AwNvylAlHeonySLFeTX3RltoQjN97Y/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.01.2020 09:18, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> Use imx8m_clk_hw_composite_core to simplify code.=0A=
> =0A=
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>=0A=
> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
=0A=
This seems to break imx8mm-evk boot in next-20200113. Board boots fine =0A=
if I revert commit 15a8b30ba79f ("clk: imx: imx8mm: use =0A=
imx8m_clk_hw_composite_core").=0A=
=0A=
It works on imx8mq-evk tough, not clear why this is happening.=0A=
=0A=
> ---=0A=
>   drivers/clk/imx/clk-imx8mm.c | 17 +++++------------=0A=
>   1 file changed, 5 insertions(+), 12 deletions(-)=0A=
> =0A=
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c=
=0A=
> index 2ed93fc25087..197ba2cdab7d 100644=0A=
> --- a/drivers/clk/imx/clk-imx8mm.c=0A=
> +++ b/drivers/clk/imx/clk-imx8mm.c=0A=
> @@ -414,20 +414,13 @@ static int imx8mm_clocks_probe(struct platform_devi=
ce *pdev)=0A=
>   =0A=
>   	/* Core Slice */=0A=
>   	hws[IMX8MM_CLK_A53_SRC] =3D imx_clk_hw_mux2("arm_a53_src", base + 0x80=
00, 24, 3, imx8mm_a53_sels, ARRAY_SIZE(imx8mm_a53_sels));=0A=
> -	hws[IMX8MM_CLK_M4_SRC] =3D imx_clk_hw_mux2("arm_m4_src", base + 0x8080,=
 24, 3, imx8mm_m4_sels, ARRAY_SIZE(imx8mm_m4_sels));=0A=
> -	hws[IMX8MM_CLK_VPU_SRC] =3D imx_clk_hw_mux2("vpu_src", base + 0x8100, 2=
4, 3, imx8mm_vpu_sels, ARRAY_SIZE(imx8mm_vpu_sels));=0A=
> -	hws[IMX8MM_CLK_GPU3D_SRC] =3D imx_clk_hw_mux2("gpu3d_src", base + 0x818=
0, 24, 3,  imx8mm_gpu3d_sels, ARRAY_SIZE(imx8mm_gpu3d_sels));=0A=
> -	hws[IMX8MM_CLK_GPU2D_SRC] =3D imx_clk_hw_mux2("gpu2d_src", base + 0x820=
0, 24, 3, imx8mm_gpu2d_sels,  ARRAY_SIZE(imx8mm_gpu2d_sels));=0A=
>   	hws[IMX8MM_CLK_A53_CG] =3D imx_clk_hw_gate3("arm_a53_cg", "arm_a53_src=
", base + 0x8000, 28);=0A=
> -	hws[IMX8MM_CLK_M4_CG] =3D imx_clk_hw_gate3("arm_m4_cg", "arm_m4_src", b=
ase + 0x8080, 28);=0A=
> -	hws[IMX8MM_CLK_VPU_CG] =3D imx_clk_hw_gate3("vpu_cg", "vpu_src", base +=
 0x8100, 28);=0A=
> -	hws[IMX8MM_CLK_GPU3D_CG] =3D imx_clk_hw_gate3("gpu3d_cg", "gpu3d_src", =
base + 0x8180, 28);=0A=
> -	hws[IMX8MM_CLK_GPU2D_CG] =3D imx_clk_hw_gate3("gpu2d_cg", "gpu2d_src", =
base + 0x8200, 28);=0A=
>   	hws[IMX8MM_CLK_A53_DIV] =3D imx_clk_hw_divider2("arm_a53_div", "arm_a5=
3_cg", base + 0x8000, 0, 3);=0A=
> -	hws[IMX8MM_CLK_M4_DIV] =3D imx_clk_hw_divider2("arm_m4_div", "arm_m4_cg=
", base + 0x8080, 0, 3);=0A=
> -	hws[IMX8MM_CLK_VPU_DIV] =3D imx_clk_hw_divider2("vpu_div", "vpu_cg", ba=
se + 0x8100, 0, 3);=0A=
> -	hws[IMX8MM_CLK_GPU3D_DIV] =3D imx_clk_hw_divider2("gpu3d_div", "gpu3d_c=
g", base + 0x8180, 0, 3);=0A=
> -	hws[IMX8MM_CLK_GPU2D_DIV] =3D imx_clk_hw_divider2("gpu2d_div", "gpu2d_c=
g", base + 0x8200, 0, 3);=0A=
> +=0A=
> +	hws[IMX8MM_CLK_M4_DIV] =3D imx8m_clk_hw_composite_core("arm_m4_div", im=
x8mm_m4_sels, base + 0x8080);=0A=
> +	hws[IMX8MM_CLK_VPU_DIV] =3D imx8m_clk_hw_composite_core("vpu_div", imx8=
mm_vpu_sels, base + 0x8100);=0A=
> +	hws[IMX8MM_CLK_GPU3D_DIV] =3D imx8m_clk_hw_composite_core("gpu3d_div", =
imx8mm_gpu3d_sels, base + 0x8180);=0A=
> +	hws[IMX8MM_CLK_GPU2D_DIV] =3D imx8m_clk_hw_composite_core("gpu2d_div", =
imx8mm_gpu2d_sels, base + 0x8200);=0A=
>   =0A=
>   	/* BUS */=0A=
>   	hws[IMX8MM_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi=
",  imx8mm_main_axi_sels, base + 0x8800);=0A=
>=0A=
