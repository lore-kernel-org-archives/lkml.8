Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0170CC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07C02087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YLyswj3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgATNlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:41:18 -0500
Received: from mail-eopbgr140081.outbound.protection.outlook.com ([40.107.14.81]:15266
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726626AbgATNlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:41:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pizwg8jPLaAkRSjhFV256qFwfx2AEsEoeFRZo6KkuXw/Tq0IZwXZ/1gJpRTRCZJVSvVidKSmeh03bxutDlQ0Os/EsoY8yYyhGtZh+NapNS8sdPp5pf2hdEEYrZdwtjxjY8FVybxqZuP/wLy1NCjxgD/SaBYJNUd82UHAJYDdTiLTsoOANlIM4eOJIflaRKJj11P/5VKcYYSBGnTUKvYDTCr+1FuH3S7yVLuMmL2ABpzTRPjFszNynBJr7KOiRGU4VcV05jLdqp3r/Jf4z3+H498dS723KxaumczRFriCvLUBs1+cLMs1WOsKWJjVlPwqoEQTOxy6hLT4P90YTGBL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Um2LmzTaVMSt3ymdpwDMXW3UnG+kHcqBUdDBNyphCkA=;
 b=aE2DR0d5rHfRb+Gl+aHNJU4ql0vFp16bea7P9l61Q1MR4uXLGPVi6aQJlzueGvatj4T9rkvWzDqljwVjxFodROURPqJpWqjNeKS1zZnTfB3SLdBO1N7meO63InpDaApoptFdlSTZ9A0gnuyP3ouQZB1Huy7DiL2I42ntke1YzQbfLpzrmWy3cWZsjTcZjvAjvR3BAX2yZDRLxa3mXZBWZrFAHb0Q/IBsSKC+2G6UQ1CFkX7nTQERcocAT18gl2frzpW4P1xrKRTfTXlng9AxRNVys25S1ZXsCER0+6doIkfm28ui9AsaIax2xfSKI/HpUfAJQU4JnZ8P3hzySRk6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Um2LmzTaVMSt3ymdpwDMXW3UnG+kHcqBUdDBNyphCkA=;
 b=YLyswj3yv9addm0RO1UYKh5c1J/E9YZ86I/EJeAlnl3CQqZnNeJ3xMo2nFZOAlNZ+zLonH2A5WPNLHK+JHF0Cjd15P0Yqraf4I3xLAK2wvm+K020DpJezu3oU0CwIjvK647YQNEp5mW1JS886+MG/saQhy9cyuMm1FtuYGv9fS0=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB7149.eurprd04.prod.outlook.com (10.186.159.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 13:41:14 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 13:41:13 +0000
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
Subject: Re: [PATCH V3 1/4] clk: imx: composite-8m: add
 imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V3 1/4] clk: imx: composite-8m: add
 imx8m_clk_hw_composite_core
Thread-Index: AQHVzBLeomevoDMgFk6s1Cu8sUYGcA==
Date:   Mon, 20 Jan 2020 13:41:13 +0000
Message-ID: <VI1PR04MB7023C33CB9D5EEFB094BF1ADEE320@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1579140562-8060-1-git-send-email-peng.fan@nxp.com>
 <1579140562-8060-2-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a850660-d49e-43b5-fc05-08d79dae6aec
x-ms-traffictypediagnostic: VI1PR04MB7149:|VI1PR04MB7149:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB714919FF6899FBA0485805EAEE320@VI1PR04MB7149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(478600001)(52536014)(55016002)(9686003)(8936002)(4326008)(7696005)(86362001)(2906002)(33656002)(81166006)(110136005)(91956017)(54906003)(44832011)(64756008)(66556008)(66446008)(81156014)(186003)(66476007)(316002)(66946007)(8676002)(71200400001)(76116006)(5660300002)(26005)(53546011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7149;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: InbLd+ERJ2hfIg/Qtot8qTJlgEEm26U+Ij7/ErMLw7v+Tt7FPgIvp4TpQjCuPBGZut28PxWX3WS9eC2Lx2aO8SkmthjBEmbEHo22/d3avv7LEtQCuIPACRBA9qKdDTHDOOMEeQ5nh+mefp1q7s6KtTsYFkGmBojXmxfv3l2VEyE+m0Ttn/Fgd4WaacYmP4vftvwqJYYlBBajtnQX2/RkWhB9vNcGfFYFpQ/l/v2kDeInqrY58ifjrIm/Nqe2FyT8HIQQvjDp7hvl+aPC45F0lSSmWq9IAqZGTQutoELFlV2T4fpDVwBZs7rvq9t9mUH5ZHGi/X2oFqfIXb0eUh/M4QtAe2fczl1k1gfUzkqufwMs9TBjMTcYaeEay54kO5ZWa/CggEjuqw/5+EiT8T8HShj2xW+6r5VxExpMptnrrjGjyTUN13Z14GTHCyqn0zcQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a850660-d49e-43b5-fc05-08d79dae6aec
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 13:41:13.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUVWKH1MBEPmQAexo8ScNNifvPVUQz/QpwFdlxMh4OlrkdhvEcRY1k47bZEEWDvD9hCX4LmDZdVJUDXEZ8otSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.2020 04:15, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> There are several clock slices, current composite code=0A=
> only support bus/ip clock slices, it could not support core=0A=
> slice.=0A=
> =0A=
> So introduce a new API imx8m_clk_hw_composite_core to support=0A=
> core slice. To core slice, post divider with 3 bits width and=0A=
> no pre divider. Other fields are same as bus/ip slices.=0A=
> =0A=
> Add a flag IMX_COMPOSITE_CORE for the usecase.=0A=
> =0A=
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>=0A=
> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
> ---=0A=
>   drivers/clk/imx/clk-composite-8m.c | 18 ++++++++++++++----=0A=
>   drivers/clk/imx/clk.h              | 13 +++++++++++--=0A=
>   2 files changed, 25 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-com=
posite-8m.c=0A=
> index e0f25983e80f..4174506e8bdd 100644=0A=
> --- a/drivers/clk/imx/clk-composite-8m.c=0A=
> +++ b/drivers/clk/imx/clk-composite-8m.c=0A=
> @@ -15,6 +15,7 @@=0A=
>   #define PCG_PREDIV_MAX		8=0A=
>   =0A=
>   #define PCG_DIV_SHIFT		0=0A=
> +#define PCG_CORE_DIV_WIDTH	3=0A=
>   #define PCG_DIV_WIDTH		6=0A=
>   #define PCG_DIV_MAX		64=0A=
>   =0A=
> @@ -126,6 +127,7 @@ static const struct clk_ops imx8m_clk_composite_divid=
er_ops =3D {=0A=
>   struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,=0A=
>   					const char * const *parent_names,=0A=
>   					int num_parents, void __iomem *reg,=0A=
> +					u32 composite_flags,=0A=
>   					unsigned long flags)=0A=
>   {=0A=
>   	struct clk_hw *hw =3D ERR_PTR(-ENOMEM), *mux_hw;=0A=
> @@ -133,6 +135,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const cha=
r *name,=0A=
>   	struct clk_divider *div =3D NULL;=0A=
>   	struct clk_gate *gate =3D NULL;=0A=
>   	struct clk_mux *mux =3D NULL;=0A=
> +	const struct clk_ops *divider_ops;=0A=
>   =0A=
>   	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);=0A=
>   	if (!mux)=0A=
> @@ -149,8 +152,16 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const ch=
ar *name,=0A=
>   =0A=
>   	div_hw =3D &div->hw;=0A=
>   	div->reg =3D reg;=0A=
> -	div->shift =3D PCG_PREDIV_SHIFT;=0A=
> -	div->width =3D PCG_PREDIV_WIDTH;=0A=
> +	if (composite_flags & IMX_COMPOSITE_CORE) {=0A=
> +		div->shift =3D PCG_DIV_SHIFT;=0A=
> +		div->width =3D PCG_CORE_DIV_WIDTH;=0A=
> +		divider_ops =3D &clk_divider_ops;=0A=
> +	} else {=0A=
> +		div->shift =3D PCG_PREDIV_SHIFT;=0A=
> +		div->width =3D PCG_PREDIV_WIDTH;=0A=
> +		divider_ops =3D &imx8m_clk_composite_divider_ops;=0A=
> +	}=0A=
> +=0A=
>   	div->lock =3D &imx_ccm_lock;=0A=
>   	div->flags =3D CLK_DIVIDER_ROUND_CLOSEST;=0A=
>   =0A=
> @@ -164,8 +175,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const cha=
r *name,=0A=
>   =0A=
>   	hw =3D clk_hw_register_composite(NULL, name, parent_names, num_parents=
,=0A=
>   			mux_hw, &clk_mux_ops, div_hw,=0A=
> -			&imx8m_clk_composite_divider_ops,=0A=
> -			gate_hw, &clk_gate_ops, flags);=0A=
> +			divider_ops, gate_hw, &clk_gate_ops, flags);=0A=
>   	if (IS_ERR(hw))=0A=
>   		goto fail;=0A=
>   =0A=
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h=0A=
> index b05213b91dcf..f074dd8ec42e 100644=0A=
> --- a/drivers/clk/imx/clk.h=0A=
> +++ b/drivers/clk/imx/clk.h=0A=
> @@ -477,20 +477,29 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, con=
st char *parent_name,=0A=
>   		struct clk *div, struct clk *mux, struct clk *pll,=0A=
>   		struct clk *step);=0A=
>   =0A=
> +#define IMX_COMPOSITE_CORE	BIT(0)=0A=
> +=0A=
>   struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,=0A=
>   					    const char * const *parent_names,=0A=
>   					    int num_parents,=0A=
>   					    void __iomem *reg,=0A=
> +					    u32 composite_flags,=0A=
>   					    unsigned long flags);=0A=
>   =0A=
> +#define imx8m_clk_hw_composite_core(name, parent_names, reg)	\=0A=
> +	imx8m_clk_hw_composite_flags(name, parent_names, \=0A=
> +			ARRAY_SIZE(parent_names), reg, \=0A=
> +			IMX_COMPOSITE_CORE, \=0A=
> +			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)=0A=
> +=0A=
>   #define imx8m_clk_composite_flags(name, parent_names, num_parents, reg,=
 \=0A=
>   				  flags) \=0A=
>   	to_clk(imx8m_clk_hw_composite_flags(name, parent_names, \=0A=
> -				num_parents, reg, flags))=0A=
> +				num_parents, reg, 0, flags))=0A=
>   =0A=
>   #define __imx8m_clk_hw_composite(name, parent_names, reg, flags) \=0A=
>   	imx8m_clk_hw_composite_flags(name, parent_names, \=0A=
> -		ARRAY_SIZE(parent_names), reg, \=0A=
> +		ARRAY_SIZE(parent_names), reg, 0, \=0A=
>   		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)=0A=
>   =0A=
>   #define __imx8m_clk_composite(name, parent_names, reg, flags) \=0A=
> =0A=
=0A=
