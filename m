Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AFAC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F53B2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FephGL4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgDXT3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:29:09 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:49997
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbgDXT3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:29:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYv7pXFyfypZi6WpE10jAzzET2JhO0Sshlmz6m0J883fxAb0ZzlIcQZCJFQ6ql4mpT9kIuYcgZUzGATI+AbP0q8aHtvlNhbHpFmzJscbm/Bp6WDh8fdhjiHzUI2KWOjHMFnpbJTThA0/z54XtsuVvgJezmaLW55hi88OuLjDiZ+fDW7ohxwdMj5br1Gb+vpDnkukPVTvgmCSqMFLE+KyIVleydISTI0XlbUKmAMcRVpGvUqLZ4Yf69CFvG3Ft4mFhwWAZxhojRo4VmimRQlupNdUHyDCERytWXcQ+Zxb+PDlElRNbZ2X8te7jjFfDAVVolRU9JNo6Y0D7v81J90c8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMUS30HN5O4f433+owxb1LAdwLy3OuwBOdIoKgVBvMw=;
 b=GSodwmuUAj+fPebr5Wj35kyWnm0CJMKiyRm2aGdNRM8KlMkqUD9bLBw8cRn94Z3Z9zv5Xzh8ahHXliBWUH9DtZzrTa83okEzc2Xl9UM1yGE0qmr7m1VzL4K/mjEvuSOT2E6YPkwyJyQ4TRRzIXSta2i4Id6AQ+VV/uZsNOOodaJ398iIs+RecWjQy0rHulJQdnvvPQou9VERrFFvH5gdIOBxMToaRzjrXieRaBvBCYL4FKBhl/dDNOEYwhYwedpvxNdBkJVD8i2HttAYTe5d6nH0dRrmlhBGnf4j1R3u710OwWR5opTpVN9F9E2E7TN75YABzBJ2n9w0ltNSJ5G5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMUS30HN5O4f433+owxb1LAdwLy3OuwBOdIoKgVBvMw=;
 b=FephGL4pprfXY6a1oTaSu7z3J3xO+YCnPgNjUShRGTM0Ufas1nTE/cTQrw3OO0XMhyZOUEGjCUrqXDNHndL8sI7MyAeci8+JxIKtKhceoA3pDBefKwl6GXh94UkCWtUpJmE/UyFFDJpVRO28EWujBdqoBTcYF/P24rpXhSBoZOI=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23)
 by VI1PR04MB6334.eurprd04.prod.outlook.com (2603:10a6:803:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 19:29:02 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::8de5:8c61:6e4d:9fe9]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::8de5:8c61:6e4d:9fe9%9]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 19:29:02 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Thread-Topic: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Thread-Index: AQHV+FjQMBLZK1sUBkmPtGWbyCJKZA==
Date:   Fri, 24 Apr 2020 19:29:01 +0000
Message-ID: <VI1PR04MB69418E9348D5765B4AE01D18EED00@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <1584008384-11578-8-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.3.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ccba8604-20a6-4e88-9f2d-08d7e885be81
x-ms-traffictypediagnostic: VI1PR04MB6334:|VI1PR04MB6334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6334DDF5FECB9AFEC1CDC3A2EED00@VI1PR04MB6334.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(86362001)(44832011)(2906002)(4326008)(8676002)(66446008)(66946007)(64756008)(52536014)(76116006)(66556008)(71200400001)(66476007)(91956017)(5660300002)(6506007)(81156014)(8936002)(110136005)(186003)(6636002)(9686003)(55016002)(33656002)(316002)(7696005)(26005)(54906003)(478600001)(53546011)(7416002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUmUbE2N4DKA/Sg2XE/RMXehxA99I5wDGuxRRNvxtOE/3+CBQYuAo/o6M1pzJPyXoLt9ea0Q6T7AqI4REmvsSE0beBY6+9ueoCWb/bdFe+sorQPJzaFGgS67drRNMZPiB8mo/RNXH9G+7kWWXG7+aBCjnESaeghVY0bjFzFwFX7a/tn3PN6VqF4qX4fkdJKRYv+c14HQRXly8NTRtuDXrdalUhCP+ZxURmdSZGT1UTd0C57jjUg/DM5dbH2VF0N5mKedubRRG6yD7dAwra/oFiHM9o1sd8LSkWKyjMHIssGhXrq0ujxZ7K3u9aCuCIOxp1R8Mi/pHznQd0g6/2p73RuaolIoM+p567S5r+0N8PRzv9AJvD56IFA8s8B61r6X36/4eFsKACzKU/SffZGqWC6Zm1EooJttNyaRoZuqyCJqLrA/W1bwTEFl+JeuyxK+
x-ms-exchange-antispam-messagedata: DeATf/V+9WmqHoxwcXmKGE5UVx8oy6T2PKqvyvXpMZvllfhaV2nPiBUdAJTP41c4d0oWHqnaFTdr8SQAlif5MDxCLeYvVSED9EbTtqHWOHBF8vjySMwi8Gp9si/n/3JcdSzogtPiSV/mfhVJKA9nTw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccba8604-20a6-4e88-9f2d-08d7e885be81
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 19:29:01.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9ZNJomv7ZIBFm+xKs8ox0wjrAsfxtQMpghzOx06bp2nQm1nLTOAutDwZZvwQ7ihII1/w3ZgR3WofMiZUEDKVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-12 12:27 PM, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> The CORE/BUS root slice has following design, simplied graph:=0A=
> The difference is core not have pre_div block.=0A=
> A composite core/bus clk has 8 inputs for mux to select, saying clk[0-7].=
=0A=
> =0A=
>              SEL_A  GA=0A=
>              +--+  +-+=0A=
>              |  +->+ +------+=0A=
> CLK[0-7]--->+  |  +-+      |=0A=
>         |    |  |      +----v---+    +----+=0A=
>         |    +--+      |pre_diva+---->    |  +---------+=0A=
>         |              +--------+    |mux +--+post_div |=0A=
>         |    +--+      |pre_divb+--->+    |  +---------+=0A=
>         |    |  |      +----^---+    +----+=0A=
>         +--->+  |  +-+      |=0A=
>              |  +->+ +------+=0A=
>              +--+  +-+=0A=
>              SEL_B  GB=0A=
> =0A=
> There will be system hang, when doing the following steps:=0A=
> 1. switch mux from clk0 to clk1=0A=
> 2. gate off clk0=0A=
> 3. swtich from clk1 to clk2, or gate off clk1=0A=
> =0A=
> Step 3 triggers system hang.=0A=
> =0A=
> If we skip step2, keep clk0 on, step 3 will not trigger system hang.=0A=
> However we have CLK_OPS_PARENT_ENABLE flag, which will unprepare disable=
=0A=
> the clk0 which will not be used.=0A=
=0A=
As far as I understand when switching from clk1 to clk2 this is done by =0A=
temporarily switching the rightmost SELECT mux to whatever was in the =0A=
spare SEL, which is essentially arbitrary from linux POV.=0A=
=0A=
This is quite unexpected but in theory it might be desirable to use a =0A=
third parent as a fallback.=0A=
=0A=
> =0A=
> To address this issue, we could use following simplied software flow:=0A=
> After the first target register set=0A=
> wait the target register set finished=0A=
> set the target register set again=0A=
> wait the target register set finished=0A=
> =0A=
> The upper flow will make sure SEL_A and SEL_B both set the new mux,=0A=
> but with only one path gate on.=0A=
> And there will be no system hang anymore with step3.=0A=
=0A=
Your fix tries to work around this scenario by always setting the mux =0A=
value in SEL_A and SEL_B to the same value after each set_parent operation.=
=0A=
=0A=
But what if SEL_A and SEL_B are different at linux boot time and the =0A=
first reparenting is done *after* disabling unused clocks? This doesn't =0A=
happen for A53 because it's reparented during clock provider probe but =0A=
maybe this scenario could be contrived if bootloader touches one of the =0A=
other bus slices.=0A=
=0A=
It might be extra safe to assign the parent of the spare mux at the =0A=
start of each set_parent call. This could even be done on probe and this =
=0A=
way wouldn't have to duplicate mux_ops just to do a double write.=0A=
=0A=
> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
> ---=0A=
> =0A=
> V2:=0A=
>   Drop wait after write, add one line comment for write twice.=0A=
> =0A=
>   drivers/clk/imx/clk-composite-8m.c | 62 +++++++++++++++++++++++++++++++=
++++++-=0A=
>   1 file changed, 61 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-com=
posite-8m.c=0A=
> index 99773519b5a5..eae02c151ced 100644=0A=
> --- a/drivers/clk/imx/clk-composite-8m.c=0A=
> +++ b/drivers/clk/imx/clk-composite-8m.c=0A=
> @@ -24,6 +24,12 @@=0A=
>   =0A=
>   #define PCG_CGC_SHIFT		28=0A=
>   =0A=
> +#define PRE_REG_OFF		0x30=0A=
> +#define PRE_MUXA_SHIFT		24=0A=
> +#define PRE_MUXA_MASK		0x7=0A=
> +#define PRE_MUXB_SHIFT		8=0A=
> +#define PRE_MUXB_MASK		0x7=0A=
=0A=
These are unused.=0A=
=0A=
> +=0A=
>   static unsigned long imx8m_clk_composite_divider_recalc_rate(struct clk=
_hw *hw,=0A=
>   						unsigned long parent_rate)=0A=
>   {=0A=
> @@ -124,6 +130,57 @@ static const struct clk_ops imx8m_clk_composite_divi=
der_ops =3D {=0A=
>   	.set_rate =3D imx8m_clk_composite_divider_set_rate,=0A=
>   };=0A=
>   =0A=
> +static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)=0A=
> +{=0A=
> +	struct clk_mux *mux =3D to_clk_mux(hw);=0A=
> +	u32 val;=0A=
> +=0A=
> +	val =3D readl(mux->reg) >> mux->shift;=0A=
> +	val &=3D mux->mask;=0A=
> +=0A=
> +	return clk_mux_val_to_index(hw, mux->table, mux->flags, val);=0A=
> +}=0A=
> +=0A=
> +static int imx8m_clk_composite_mux_set_parent(struct clk_hw *hw, u8 inde=
x)=0A=
> +{=0A=
> +	struct clk_mux *mux =3D to_clk_mux(hw);=0A=
> +	u32 val =3D clk_mux_index_to_val(mux->table, mux->flags, index);=0A=
> +	unsigned long flags =3D 0;=0A=
> +	u32 reg;=0A=
> +=0A=
> +	if (mux->lock)=0A=
> +		spin_lock_irqsave(mux->lock, flags);=0A=
> +=0A=
> +	reg =3D readl(mux->reg);=0A=
> +	reg &=3D ~(mux->mask << mux->shift);=0A=
> +	val =3D val << mux->shift;=0A=
> +	reg |=3D val;=0A=
> +	/* write twice to make sure SEL_A/B point the same mux */=0A=
> +	writel(reg, mux->reg);=0A=
> +	writel(reg, mux->reg);=0A=
> +=0A=
> +	if (mux->lock)=0A=
> +		spin_unlock_irqrestore(mux->lock, flags);=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static int=0A=
> +imx8m_clk_composite_mux_determine_rate(struct clk_hw *hw,=0A=
> +				       struct clk_rate_request *req)=0A=
> +{=0A=
> +	struct clk_mux *mux =3D to_clk_mux(hw);=0A=
> +=0A=
> +	return clk_mux_determine_rate_flags(hw, req, mux->flags);=0A=
> +}=0A=
> +=0A=
> +=0A=
> +const struct clk_ops imx8m_clk_composite_mux_ops =3D {=0A=
> +	.get_parent =3D imx8m_clk_composite_mux_get_parent,=0A=
> +	.set_parent =3D imx8m_clk_composite_mux_set_parent,=0A=
> +	.determine_rate =3D imx8m_clk_composite_mux_determine_rate,=0A=
> +};=0A=
> +=0A=
>   struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,=0A=
>   					const char * const *parent_names,=0A=
>   					int num_parents, void __iomem *reg,=0A=
> @@ -136,6 +193,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const cha=
r *name,=0A=
>   	struct clk_gate *gate =3D NULL;=0A=
>   	struct clk_mux *mux =3D NULL;=0A=
>   	const struct clk_ops *divider_ops;=0A=
> +	const struct clk_ops *mux_ops;=0A=
>   =0A=
>   	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);=0A=
>   	if (!mux)=0A=
> @@ -157,10 +215,12 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const c=
har *name,=0A=
>   		div->shift =3D PCG_DIV_SHIFT;=0A=
>   		div->width =3D PCG_CORE_DIV_WIDTH;=0A=
>   		divider_ops =3D &clk_divider_ops;=0A=
> +		mux_ops =3D &imx8m_clk_composite_mux_ops;=0A=
>   	} else {=0A=
>   		div->shift =3D PCG_PREDIV_SHIFT;=0A=
>   		div->width =3D PCG_PREDIV_WIDTH;=0A=
>   		divider_ops =3D &imx8m_clk_composite_divider_ops;=0A=
> +		mux_ops =3D &clk_mux_ops;=0A=
>   	}=0A=
>   =0A=
>   	div->lock =3D &imx_ccm_lock;=0A=
> @@ -176,7 +236,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const cha=
r *name,=0A=
>   	gate->lock =3D &imx_ccm_lock;=0A=
>   =0A=
>   	hw =3D clk_hw_register_composite(NULL, name, parent_names, num_parents=
,=0A=
> -			mux_hw, &clk_mux_ops, div_hw,=0A=
> +			mux_hw, mux_ops, div_hw,=0A=
>   			divider_ops, gate_hw, &clk_gate_ops, flags);=0A=
>   	if (IS_ERR(hw))=0A=
>   		goto fail;=0A=
> =0A=
=0A=
