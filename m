Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014DCC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF68C20724
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q84PW7+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgBLNrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:47:43 -0500
Received: from mail-eopbgr150073.outbound.protection.outlook.com ([40.107.15.73]:21837
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727439AbgBLNrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:47:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkpzD2R8+ufzpo276Fu1mlUv+rB+WH0RQ91gQIsUZfYJYroQuaq8bOgvtpoPhrWjwT5Fso7mYher9y0DG4B2YfYQCxpKT6+Z6F6uSmGYaXUBQbBllFXTNhLO2roRFwL6gzgfXBypm5E0TDfJZ0jfjb/je/N73TDO2HtTKpmKxuvqPiiocb3BXLdsQxYn0P2uME8M7RN1jeigmyAK9O7dru2+mCkkqVTn2OfgWSSQwiVh2DNJZIM+OhAY1TwQYE77JSne6JkgVJUaWaT2orhYDbx6XaGhA81+yOBDXhv6T6YEu808edFuTVXisRH2irGrO0sS3APPt54kLeoliPKfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAhYFwFxfz7rKc2UVmoE13yAuDAqkXFjoApYdBSkQLQ=;
 b=e7J1WN8uOKq9rJzYszQDJEOoRGj4VF2jHlm9gxx5hljSzbTE3HO7hTLEeN1/oDftSS+64Pe2oWtifjuKgRVdQV8UxH6b5t7zm4c4CVs1O6FPGLyNvCUh6zNw65qFDlBwl+IbqrYemJkPARHVPTBMzccqmVvWkmyeoR3VhrI2TeGH3qpjKa9lLKmjO2+5jWyAYK6XmKdeytCreQ9opk8sveWzSo534ebbXse9Oh8sLO8gy8Cb4i8BI5B6u8gqlu6ha0jv1JYl0xIuOwD3j8t+BlvB99t8mIncUwHiZt7YMryyCuPwbQmnQYf9LhGTswnMroweV9ECoHOdXTb0aruWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAhYFwFxfz7rKc2UVmoE13yAuDAqkXFjoApYdBSkQLQ=;
 b=q84PW7+bFmq5Dh3VizIHUGgfU7VGe2ThRt35O072PCrZQaXUiaHhtGW3kJuxeDE2MIkwojWD/uo8dZe5S2nKjZbWxdkQaWnez09H8aVjZilQwQtNXDuCqGjtHsRPeXHrNyTUvnExkyQYKNDPn4WI0tpV6DHylF4UhYk1h6nawlo=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5889.eurprd04.prod.outlook.com (20.178.118.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Wed, 12 Feb 2020 13:47:38 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 13:47:38 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
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
Subject: RE: [PATCH V2 1/4] clk: imx: imx8mq: fix a53 cpu clock
Thread-Topic: [PATCH V2 1/4] clk: imx: imx8mq: fix a53 cpu clock
Thread-Index: AQHVyqwL+gJCbLkXRk231KEqZiOAVqgXv2QAgAAAROA=
Date:   Wed, 12 Feb 2020 13:47:38 +0000
Message-ID: <AM0PR04MB4481C9B71B5860BACA47CB1B881B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1578986576-6168-1-git-send-email-peng.fan@nxp.com>
 <1578986576-6168-2-git-send-email-peng.fan@nxp.com>
 <20200212134310.GG11096@dragon>
In-Reply-To: <20200212134310.GG11096@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e1862e5-854f-4031-b88b-08d7afc21fcb
x-ms-traffictypediagnostic: AM0PR04MB5889:|AM0PR04MB5889:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB588997224AFEA6540640B079881B0@AM0PR04MB5889.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(2906002)(52536014)(4326008)(6506007)(26005)(44832011)(8936002)(186003)(5660300002)(9686003)(55016002)(478600001)(86362001)(71200400001)(316002)(66446008)(6916009)(54906003)(81166006)(81156014)(8676002)(64756008)(76116006)(66476007)(7696005)(33656002)(66556008)(66946007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5889;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SgIzHIPioB996eeh7AbLNeYOSrEXnhMuqeg4wBGiSeNvec2Lji65PbPwnFrAZ3fxR8LcqKwFv5P9zQM4rtipWA72/GuVJqtL9amZ8Q/rGpVvEidSkTLalVJRRi7s/kHZxWh12Zm7jtsl0QmKe27+Uls0D1PzpEUJ6RVSTuxeblCC37dMwul7BOcCVrTKDGxQz/moybnLCi54XDKGnYofbU/hWgtKk2CoxLvqDqQdTvbE0gSCAhnuDN1LN4+6fpwsBS2B+Q3kV53dgjUlErByBDrgttSrsgnYkwzl1Qy1OnE5oi4+tm1W3OpdLLi5H1kALy44IRm9w0ipvwKHjrbkJ98g3WrnhYyWCJvJ98sBR2bRDAt9Y46YHjx9dPGZoGqx2NfhkcnJZtbuc7BAQRPe2CEKWzkvA5nxfJx7RomLjfPKpdIRUKA0U1mmq40LMFh1ZCVc4MYpgqX2arw+Pla/YrK8ni3M8pNz5BJJGgUEozBfWIfBvYalWlVz+6mJusqh
x-ms-exchange-antispam-messagedata: bQgYB3BbtK+9RGdSYGEcvB7gMcB5rTMt8ODm/vptz0vwLKWRNSExIHyHZ4+hVevVAhgGoJCrKwXxzqfRB3rVFsYxKxc2qpkMMGjmVcfiOmTYSEnrzK19VCMmXpCs6mQj2sv8VlTUeDVh9yOaPmdkZA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1862e5-854f-4031-b88b-08d7afc21fcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 13:47:38.6806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zw31SEIktbbmI+rH8MLgJjPZbxEoearo0F5LI6H3u2eoMYr8ho5BpclLsnh6LkHzUODDwydQvp2DgXNQhb+RNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5889
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH V2 1/4] clk: imx: imx8mq: fix a53 cpu clock
>=20
> On Tue, Jan 14, 2020 at 07:27:15AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
>=20
> The 'imx: ' in subject is not really needed.  'clk: imx8mq: ' should be a=
lready
> clear enough.
>=20
> >
> > The A53 CCM clk root only accepts input up to 1GHz, CCM A53 root
> > signoff timing is 1Ghz,
>=20
> Is this restriction mentioned in any document?

This information was not mentioned in documentation. But I have confirmed
the limitation with design team.

>=20
> > however the A53 core which sources from CCM root could run above 1GHz
> > which voilates the CCM.
>=20
> s/voilates/violates

Fix in v3.

>=20
> >
> > There is a CORE_SEL slice before A53 core, we need configure the
>=20
> s/need/need to

Fix in v3.

>=20
> > CORE_SEL slice source from ARM PLL, not A53 CCM clk root.
> >
> > The A53 CCM clk root should only be used when need to change ARM PLL
> > frequency.
> >
> > Add arm_a53_core clk that could source from arm_a53_div and
> arm_pll_out.
> > Configure a53 ccm root sources from 800MHz sys pll Configure a53 core
> > sources from arm_pll_out Mark arm_a53_core as critical clock
> >
> > Fixes: db27e40b27f1 ("clk: imx8mq: Add the missing ARM clock")
>=20
> We have been running this for quite a while with OPPs above 1GHz.  Why
> didn't we hear any issue report?

In room temperature, there might be no issue. But the A53 clk root
signoff timing is 1Ghz, so if we keep using the clk root for OPPs above
1GHz, we could not make sure there is no problem.

Thanks,
Peng.

>=20
> Shawn
>=20
> > Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  None
> >
> >  drivers/clk/imx/clk-imx8mq.c             | 16 ++++++++++++----
> >  include/dt-bindings/clock/imx8mq-clock.h |  4 +++-
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mq.c
> > b/drivers/clk/imx/clk-imx8mq.c index b031183ff427..82a16b8e98a9
> 100644
> > --- a/drivers/clk/imx/clk-imx8mq.c
> > +++ b/drivers/clk/imx/clk-imx8mq.c
> > @@ -41,6 +41,8 @@ static const char * const video2_pll_out_sels[] =3D
> > {"video2_pll1_ref_sel", };  static const char * const imx8mq_a53_sels[]=
 =3D
> {"osc_25m", "arm_pll_out", "sys2_pll_500m", "sys2_pll_1000m",
> >  					"sys1_pll_800m", "sys1_pll_400m", "audio_pll1_out",
> > "sys3_pll_out", };
> >
> > +static const char * const imx8mq_a53_core_sels[] =3D {"arm_a53_div",
> > +"arm_pll_out", };
> > +
> >  static const char * const imx8mq_arm_m4_sels[] =3D {"osc_25m",
> "sys2_pll_200m", "sys2_pll_250m", "sys1_pll_266m",
> >  					"sys1_pll_800m", "audio_pll1_out", "video_pll1_out",
> > "sys3_pll_out", };
> >
> > @@ -411,6 +413,9 @@ static int imx8mq_clocks_probe(struct
> platform_device *pdev)
> >  	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D
> imx8m_clk_hw_composite_core("gpu_core_div", imx8mq_gpu_core_sels,
> base + 0x8180);
> >  	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D
> > imx8m_clk_hw_composite("gpu_shader_div", imx8mq_gpu_shader_sels,
> base
> > + 0x8200);
> >
> > +	/* CORE SEL */
> > +	hws[IMX8MQ_CLK_A53_CORE] =3D
> imx_clk_hw_mux2_flags("arm_a53_core",
> > +base + 0x9880, 24, 1, imx8mq_a53_core_sels,
> > +ARRAY_SIZE(imx8mq_a53_core_sels), CLK_IS_CRITICAL);
> > +
> >  	/* BUS */
> >  	hws[IMX8MQ_CLK_MAIN_AXI] =3D
> imx8m_clk_hw_composite_critical("main_axi", imx8mq_main_axi_sels, base
> + 0x8800);
> >  	hws[IMX8MQ_CLK_ENET_AXI] =3D imx8m_clk_hw_composite("enet_axi",
> > imx8mq_enet_axi_sels, base + 0x8880); @@ -574,11 +579,14 @@ static int
> imx8mq_clocks_probe(struct platform_device *pdev)
> >  	hws[IMX8MQ_GPT_3M_CLK] =3D imx_clk_hw_fixed_factor("gpt_3m",
> "osc_25m", 1, 8);
> >  	hws[IMX8MQ_CLK_DRAM_ALT_ROOT] =3D
> > imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
> >
> > -	hws[IMX8MQ_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_div",
> > -					   hws[IMX8MQ_CLK_A53_DIV]->clk,
> > -					   hws[IMX8MQ_CLK_A53_SRC]->clk,
> > +	clk_hw_set_parent(hws[IMX8MQ_CLK_A53_SRC],
> hws[IMX8MQ_SYS1_PLL_800M]);
> > +	clk_hw_set_parent(hws[IMX8MQ_CLK_A53_CORE],
> > +hws[IMX8MQ_ARM_PLL_OUT]);
> > +
> > +	hws[IMX8MQ_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_core",
> > +					   hws[IMX8MQ_CLK_A53_CORE]->clk,
> > +					   hws[IMX8MQ_CLK_A53_CORE]->clk,
> >  					   hws[IMX8MQ_ARM_PLL_OUT]->clk,
> > -					   hws[IMX8MQ_SYS1_PLL_800M]->clk);
> > +					   hws[IMX8MQ_CLK_A53_DIV]->clk);
> >
> >  	imx_check_clk_hws(hws, IMX8MQ_CLK_END);
> >
> > diff --git a/include/dt-bindings/clock/imx8mq-clock.h
> > b/include/dt-bindings/clock/imx8mq-clock.h
> > index 3bab9b21c8d7..ac71e9e502b8 100644
> > --- a/include/dt-bindings/clock/imx8mq-clock.h
> > +++ b/include/dt-bindings/clock/imx8mq-clock.h
> > @@ -424,6 +424,8 @@
> >  #define IMX8MQ_SYS2_PLL_500M_CG			283
> >  #define IMX8MQ_SYS2_PLL_1000M_CG		284
> >
> > -#define IMX8MQ_CLK_END				285
> > +#define IMX8MQ_CLK_A53_CORE			285
> > +
> > +#define IMX8MQ_CLK_END				286
> >
> >  #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
> > --
> > 2.16.4
> >
