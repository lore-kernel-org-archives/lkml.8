Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FBDC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1529E24658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V4l8bC6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBSKUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:20:22 -0500
Received: from mail-eopbgr140082.outbound.protection.outlook.com ([40.107.14.82]:45185
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbgBSKUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:20:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dj23PwS4B23XdnVblyp92xrEh74AKxHo20SJUc4nbDXBEF1Vk3KSggyMnRKLvYVhckhi9lInNcD/QV91YIZvPsVg+ZLERM01naAe9V92uhFXmX4DxGTCjbM1jGUbPl3Yo+xV+psaHwfSt6b5oV2AoNxPnR0OLKZLHGZJKfSBO2JK3V2B77b6eHbdyozr5pQvMyIqVgG/brPQEWtaC0dzarEGd5nUj69/Luk8lRi57oNe/wsLgAw4I4tVvN2uAycFp5Qjm9ObAUpKaTLlR0Y1575yIVsDvgXqfhu6fvi56/J2e79lB2EV0SRzd0jzcUeOgidPsT2MzxBrpWIeXiWV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3dB2i0Ig86H8iZdEGCP5pr7VoOEGZmTbWhiO8QzFXQ=;
 b=ZPN7BbweQDPwhEivDg0if/wSGL13tyjTR3Hv1JoJD9Tz5Y3i7XLdrbrblKTF2pYWxF1RurdbF9qlDPMgIwHZIzbpuibmsKCk8LuTUHJx5sjBOPVBwm8jCoKi7cmpP9D5lNkFCMgvOXxKD55arz4c3e3rH34Dk7evV6fqtLWOUX5crcMq6516vIgMePEKVmMLLfl/9vIxlVoGUMDff+uG5UV0gMUw29EbGSH1gVuIuaJaFRZW+7c1hz/36378eGjoWWidehMwCOY9L8VRKrcJjJt030eJ4AQY7sYdQybYF4HW6rXElcOSv3DCsRNUrnPNQcztsItcYEXS6gC5z2tYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3dB2i0Ig86H8iZdEGCP5pr7VoOEGZmTbWhiO8QzFXQ=;
 b=V4l8bC6n0if8+dGoi/mA7KTvLNcdjubRbMVsifymDMJ95lxbCi+AX3JTcmPleruf+Wdn3289WyKGdf+sea2i9MMuh/ononVqPX5JVrfx9gaQN+NF/AzNO7FyKJy+PunIvHVjsLKQsiZYRvf1Be7Swjzy8vi6kjUFEhDa4pZ44DY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6884.eurprd04.prod.outlook.com (52.132.213.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Wed, 19 Feb 2020 10:20:18 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 10:20:18 +0000
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
Subject: RE: [PATCH V3 1/4] clk: imx: composite-8m: add
 imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V3 1/4] clk: imx: composite-8m: add
 imx8m_clk_hw_composite_core
Thread-Index: AQHV5wtPHJjqDVyDiUGylTO3QWs3rKgiTgRQ
Date:   Wed, 19 Feb 2020 10:20:17 +0000
Message-ID: <AM0PR04MB4481BEE793A6FEE5588ACEAC88100@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
 <1582106022-20926-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1582106022-20926-2-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9f3b8e8-9f5b-44d8-4507-08d7b5255172
x-ms-traffictypediagnostic: AM0PR04MB6884:|AM0PR04MB6884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB68847C647FD1DFE3451397BF88100@AM0PR04MB6884.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(64756008)(66446008)(52536014)(5660300002)(186003)(26005)(2906002)(55016002)(9686003)(76116006)(66946007)(6506007)(4326008)(66476007)(66556008)(7696005)(316002)(6636002)(8676002)(71200400001)(8936002)(81156014)(81166006)(86362001)(33656002)(44832011)(110136005)(54906003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6884;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oaMilSviC/ViaD9VSHsTFYSqNhK9URGOSMNfByfHVULGrMEAZ4c7Mrz0X3nkXH2YO2Vq9ihf9pwqVrN1Ja2jpDUO50uBUk/gRuklXqwFFSR0gSETvPs/mCqraD0OaHP7KBrPg2giexQbpx2DJpGUHiMfozZvqTHwUtZ6L5m/lqkGxcOBvy/gy1OjUymds+SsbWCrwIkK6bDuxw3U37SdPBaDojpzwaf8H+y4ScplVzR830f2qAeaampiMVNvMMPZi7XkS2OGyC7EtVclZyUTh8P0gXSt64ym6r+LuhDS6j5SEyqzp57rT97UP7tnH0xopTXiOwXdwocHx/EtgLaspTRCxn5i3lfLCy3xtkD3ONjtalrNAH9jM2/MJ0ZA9gMWutoq4iFyZ35v7y7sEbMBxZ5hdamBubxxDH35ReMGQJ0ExCqP2pHNZoM1n3ypZPt1
x-ms-exchange-antispam-messagedata: KOohFzGYxJw6zSElvHqH0r1S8igqtTG4q8vl0Iay8t8LvyEOp+XKMs+YreRfkzHz8j77GdP/WAy72yfsrx9iML7MrKilyxmQ2D++hFeHXvFcaHWTutbYlaaPMlG91AxTJujWrOAMBMMjcU22qDPw0w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f3b8e8-9f5b-44d8-4507-08d7b5255172
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 10:20:18.0105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /P1I/uUC6bWkCSZ4XEpZthIE3608A+J0Y5yBa9O91wCavvHqr2eJBeDf4/sgmPxhrFzPc36Ix4a8sFIZ/AWmbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH V3 1/4] clk: imx: composite-8m: add
> imx8m_clk_hw_composite_core

Sorry, some patches are wrongly sent out, please ignore this thread.
I'll use PATCH RESEND to resend and drop unneed patches.

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> There are several clock slices, current composite code only support bus/i=
p
> clock slices, it could not support core slice.
>=20
> So introduce a new API imx8m_clk_hw_composite_core to support core slice.
> To core slice, post divider with 3 bits width and no pre divider. Other f=
ields are
> same as bus/ip slices.
>=20
> Add a flag IMX_COMPOSITE_CORE for the usecase.
>=20
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-composite-8m.c | 18 ++++++++++++++----
>  drivers/clk/imx/clk.h              | 13 +++++++++++--
>  2 files changed, 25 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-composite-8m.c
> b/drivers/clk/imx/clk-composite-8m.c
> index e0f25983e80f..4174506e8bdd 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -15,6 +15,7 @@
>  #define PCG_PREDIV_MAX		8
>=20
>  #define PCG_DIV_SHIFT		0
> +#define PCG_CORE_DIV_WIDTH	3
>  #define PCG_DIV_WIDTH		6
>  #define PCG_DIV_MAX		64
>=20
> @@ -126,6 +127,7 @@ static const struct clk_ops
> imx8m_clk_composite_divider_ops =3D {  struct clk_hw
> *imx8m_clk_hw_composite_flags(const char *name,
>  					const char * const *parent_names,
>  					int num_parents, void __iomem *reg,
> +					u32 composite_flags,
>  					unsigned long flags)
>  {
>  	struct clk_hw *hw =3D ERR_PTR(-ENOMEM), *mux_hw; @@ -133,6 +135,7
> @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
>  	struct clk_divider *div =3D NULL;
>  	struct clk_gate *gate =3D NULL;
>  	struct clk_mux *mux =3D NULL;
> +	const struct clk_ops *divider_ops;
>=20
>  	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
>  	if (!mux)
> @@ -149,8 +152,16 @@ struct clk_hw
> *imx8m_clk_hw_composite_flags(const char *name,
>=20
>  	div_hw =3D &div->hw;
>  	div->reg =3D reg;
> -	div->shift =3D PCG_PREDIV_SHIFT;
> -	div->width =3D PCG_PREDIV_WIDTH;
> +	if (composite_flags & IMX_COMPOSITE_CORE) {
> +		div->shift =3D PCG_DIV_SHIFT;
> +		div->width =3D PCG_CORE_DIV_WIDTH;
> +		divider_ops =3D &clk_divider_ops;
> +	} else {
> +		div->shift =3D PCG_PREDIV_SHIFT;
> +		div->width =3D PCG_PREDIV_WIDTH;
> +		divider_ops =3D &imx8m_clk_composite_divider_ops;
> +	}
> +
>  	div->lock =3D &imx_ccm_lock;
>  	div->flags =3D CLK_DIVIDER_ROUND_CLOSEST;
>=20
> @@ -164,8 +175,7 @@ struct clk_hw
> *imx8m_clk_hw_composite_flags(const char *name,
>=20
>  	hw =3D clk_hw_register_composite(NULL, name, parent_names,
> num_parents,
>  			mux_hw, &clk_mux_ops, div_hw,
> -			&imx8m_clk_composite_divider_ops,
> -			gate_hw, &clk_gate_ops, flags);
> +			divider_ops, gate_hw, &clk_gate_ops, flags);
>  	if (IS_ERR(hw))
>  		goto fail;
>=20
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index
> b05213b91dcf..f074dd8ec42e 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -477,20 +477,29 @@ struct clk_hw *imx_clk_hw_cpu(const char *name,
> const char *parent_name,
>  		struct clk *div, struct clk *mux, struct clk *pll,
>  		struct clk *step);
>=20
> +#define IMX_COMPOSITE_CORE	BIT(0)
> +
>  struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
>  					    const char * const *parent_names,
>  					    int num_parents,
>  					    void __iomem *reg,
> +					    u32 composite_flags,
>  					    unsigned long flags);
>=20
> +#define imx8m_clk_hw_composite_core(name, parent_names, reg)	\
> +	imx8m_clk_hw_composite_flags(name, parent_names, \
> +			ARRAY_SIZE(parent_names), reg, \
> +			IMX_COMPOSITE_CORE, \
> +			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
> +
>  #define imx8m_clk_composite_flags(name, parent_names, num_parents,
> reg, \
>  				  flags) \
>  	to_clk(imx8m_clk_hw_composite_flags(name, parent_names, \
> -				num_parents, reg, flags))
> +				num_parents, reg, 0, flags))
>=20
>  #define __imx8m_clk_hw_composite(name, parent_names, reg, flags) \
>  	imx8m_clk_hw_composite_flags(name, parent_names, \
> -		ARRAY_SIZE(parent_names), reg, \
> +		ARRAY_SIZE(parent_names), reg, 0, \
>  		flags | CLK_SET_RATE_NO_REPARENT |
> CLK_OPS_PARENT_ENABLE)
>=20
>  #define __imx8m_clk_composite(name, parent_names, reg, flags) \
> --
> 2.16.4

