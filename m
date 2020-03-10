Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29D8C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E5224673
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ltly2d3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCJGT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:19:56 -0400
Received: from mail-db8eur05on2042.outbound.protection.outlook.com ([40.107.20.42]:30106
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbgCJGT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:19:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBC8Ht7hpkIenz0z8XUsI8Xrlv2lXFUp0CLvfCmnbE70hQGxQP9at9SO1R8T798k27WGIRbEygbp8Nvf0GWG6vPHxZKkU1Pv95NCa0vDGfYkLwSaiU6X1lLV1yXfomYVED0ab8w6KLLedNbsPquFq85AEV1n4/mu3DMoL7y4Iet346acI2Gkqil2aDwxULCkU1YLHmI69JtdMYLvbLNvQUNzzTMT6wifA4VCq9V4GmmLkI/hyOf8ehLfDT32I9JjbL+RYqbLcDFGHpxUAafQdGqgQLcS3th3YkCFkM05EB18ZwMS/qYD9bx2wD8f/cgqMxhvqHOZT0yyJx396ktNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqsikgVHvOo/wu/NK1zTjOAGplS3MHEdJO1239z2xrc=;
 b=aPpjbobAwy9KaI+q1TYkcxH3xy6cC2WrkpR71KCpCUaiU0NiSiAyup1yT2gMF2dLgDiymI1jSsnoKieP4xj1DJzqDqWVYw3WzEVJfMw8hNqU16I0AeqlXoN0bu71INqp4mBRbBPaZDeNbr7LZuXFuVx6Y7RBkkkpgwLP4T4ntv87SK7QkIbBhmk5y4/GIb0Nh+OMcOYu0kK/nHBH0l+I5ZLwzwUHlPfXsK6MfHDYCRj+gC5+m1Pe3Gq6+pT3oSrA3pqNI0Xd6aLPVmGFj03gW07U72oR/SOrwnBsBdHPTiDdFx5KJqrBjO/wWrNg1kf7cFZwblU9vOS5cKPiLHNDyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqsikgVHvOo/wu/NK1zTjOAGplS3MHEdJO1239z2xrc=;
 b=Ltly2d3V4o3/Rz87Iyn29Y02ETy320P3S4b1WoP6aOUkfpiKpvvY7xGkwsZasv66LWk1aigICStkzUuAqQwj8crEmRu6EnFfcjkvv8eS/UNqJ0M6OFd0IvK/et82iKDEPl+FmX1m+CVCZSyQlHfkPCt8gbVwM4fLxn2CZUe+41c=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6132.eurprd04.prod.outlook.com (20.179.33.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 06:19:52 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 06:19:52 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH v2 07/14] clk: imx7ulp: make it easy to change ARM core
 clk
Thread-Topic: [PATCH v2 07/14] clk: imx7ulp: make it easy to change ARM core
 clk
Thread-Index: AQHV5vt/fQalJGbC30maMwignaLHKKhBdxSAgAAAv/A=
Date:   Tue, 10 Mar 2020 06:19:52 +0000
Message-ID: <AM0PR04MB44813CDE69F5421F9708670A88FF0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-8-git-send-email-peng.fan@nxp.com>
 <20200310060956.GJ15729@dragon>
In-Reply-To: <20200310060956.GJ15729@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a7e59cd-42f8-4dc5-21f8-08d7c4bb0b94
x-ms-traffictypediagnostic: AM0PR04MB6132:|AM0PR04MB6132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6132C3CB2236369EFCCB08F888FF0@AM0PR04MB6132.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(478600001)(5660300002)(66946007)(54906003)(55016002)(76116006)(9686003)(2906002)(316002)(66446008)(66476007)(86362001)(186003)(64756008)(66556008)(26005)(44832011)(71200400001)(7696005)(33656002)(7416002)(52536014)(6506007)(6916009)(81166006)(81156014)(8936002)(8676002)(4326008)(966005)(42463001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6132;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Ov7yjqhH4yMWxhxVMa0PjqoqYis9EYCAym56vD8A9zdcFhnZyMZoFy2zOgKnWK72I3w7pA1UB6W1R3SCbdjtWFxMp/gMHWjbp8+jaLSx9kTT33E976E1lU95a7hMilvHOXlxPyAsSgA5w9bD7goracCb/QcAen7+2nt+X7DAgTQZu4wFgtxNTS0u1/s4aU6oerR+Y43x36M+Qu+IfKua0pQzNMYAsodUM9LxAHBKw9rPa5yrARAvrQiS5iotdROctCb3hn9x/J5iJmtNMGjdTU82mpjF0nTZBO3Od6x65Oj3CBx2gwjHnANLniuxGuLa3dIUH0mfUqAJmLusM79vivobW/Q9rP/H0CGBaD2yZ6do6tH5Q2HbHe2A6FtTFyoAvCaTlTH8uf3arSH+TV/n2xT/s1vccD4H0IDzu/wR7UCIrKCnWe4oye7VB2pHHYMIGeqM2tyVFmrjvox/oWiR05dQLtbA8xgNFGJQ01kPyn8mxjYBn4VI4MMlKvWaaIsrGeHhyZ8k9T3HkT6V/ijMTpPbmVVsGsj7xH2EtD5smlFN5qZ744GEWSh9LrYxvPS
x-ms-exchange-antispam-messagedata: XIIPueHwlmGRz8Xz8OPgmHd4abGxuWJ3YFS+iKYu7OaWGHWCc1fjKCn8XL3sqNs7ntDd6Yc9nwGKtAzbrXunK1/+Ay90M5W1dbinirYkyA/FLNPlrySuccxZJeXSMztWKWgnjhx1B28WJhaf5Na/RA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7e59cd-42f8-4dc5-21f8-08d7c4bb0b94
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 06:19:52.7311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRDqLGbNOp5HM5Df3XT4akZUgVN0TV0PCuqe5s2eTV/R+FORqrdY4eWTsJ/iZsbtKwoU6UoThClt2pzuzg+Z4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH v2 07/14] clk: imx7ulp: make it easy to change ARM co=
re
> clk
>=20
> On Wed, Feb 19, 2020 at 03:59:50PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > ARM clk could only source from divcore or hsrun_divcore.
> >
> > However when ARM core is running normaly, whether divcore or
> > hwrun_divcore will finally source from SPLL_PFD0. However SPLL_PFD0 is
> > marked with CLK_SET_GATE, so we need to disable SPLL_PFD0, when
> > configure the rate. So add CORE and HSRUN_CORE virtual clk to make it
> > easy to configure the clk using imx_clk_hw_cpu API.
>=20
> It sounds a bit hackish, so would like to hear an ACK from Stephen on it.

Same to i.MX7/8M SoCs, the cpu clk could not change on the fly,
That's why we use a imx_clk_hw_cpu for i.MX7/8M cpu clock.

To i.MX7ULP, it is a bit different, cpu could sources from two clocks
based on a SMC setting which is abstract as a mux in clk-imx7ulp.c.

However we still could not change HSRUN_CORE or CORE clk
on the fly whether the cpu sources form HSRUN_CORE or CORE clk.

That's why I add virtual clk for HSRUN and CORE, same as i.MX7/8M.

Stephen rejected my original patch to use a virtual clk for the final
output which add imx_hw_clk_cpuv2,=20
https://patchwork.kernel.org/patch/11364633/

So I implement the method in this patch which is cleaner and
simple. With this approach, it is easy to reuse cpufreq-dt driver,
we no need a new clk driver and no need a new cpufreq driver
for i.MX7ULP.

Please consider this patch.

Thanks,
Peng.=20



>=20
> Shawn
>=20
> >
> > Since CORE and HSRUN_CORE already marked with CLK_IS_CRITICAL, no
> need
> > to set ARM as CLK_IS_CRITICAL. And when set the rate of ARM clk,
> > prograting it the parent with CLK_SET_RATE_PARENT will finally set the
> > SPLL_PFD0 clk.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx7ulp.c             | 6 ++++--
> >  include/dt-bindings/clock/imx7ulp-clock.h | 5 ++++-
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx7ulp.c
> > b/drivers/clk/imx/clk-imx7ulp.c index 3710aa0dee9b..634c0b6636b0
> > 100644
> > --- a/drivers/clk/imx/clk-imx7ulp.c
> > +++ b/drivers/clk/imx/clk-imx7ulp.c
> > @@ -29,7 +29,7 @@ static const char * const ddr_sels[]		=3D
> { "apll_pfd_sel", "dummy", "dummy", "dum
> >  static const char * const nic_sels[]		=3D { "firc", "ddr_clk", };
> >  static const char * const periph_plat_sels[]	=3D { "dummy", "nic1_bus_=
clk",
> "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
> >  static const char * const periph_bus_sels[]	=3D { "dummy", "sosc_bus_c=
lk",
> "dummy", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_cl=
k", };
> > -static const char * const arm_sels[]		=3D { "divcore", "dummy", "dummy=
",
> "hsrun_divcore", };
> > +static const char * const arm_sels[]		=3D { "core", "dummy", "dummy",
> "hsrun_core", };
> >
> >  /* used by sosc/sirc/firc/ddr/spll/apll dividers */  static const
> > struct clk_div_table ulp_div_table[] =3D { @@ -121,7 +121,9 @@ static
> > void __init imx7ulp_clk_scg1_init(struct device_node *np)
> >  	hws[IMX7ULP_CLK_DDR_SEL]	=3D imx_clk_hw_mux_flags("ddr_sel",
> base + 0x30, 24, 2, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_RATE_PARENT |
> CLK_OPS_PARENT_ENABLE);
> >
> >  	hws[IMX7ULP_CLK_CORE_DIV]	=3D imx_clk_hw_divider_flags("divcore",
> 	"scs_sel",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT);
> > +	hws[IMX7ULP_CLK_CORE]		=3D imx_clk_hw_cpu("core", "divcore",
> hws[IMX7ULP_CLK_CORE_DIV]->clk, hws[IMX7ULP_CLK_SYS_SEL]->clk,
> hws[IMX7ULP_CLK_SPLL_SEL]->clk, hws[IMX7ULP_CLK_FIRC]->clk);
> >  	hws[IMX7ULP_CLK_HSRUN_CORE_DIV] =3D
> > imx_clk_hw_divider_flags("hsrun_divcore", "hsrun_scs_sel", base +
> > 0x1c, 16, 4, CLK_SET_RATE_PARENT);
> > +	hws[IMX7ULP_CLK_HSRUN_CORE] =3D imx_clk_hw_cpu("hsrun_core",
> > +"hsrun_divcore", hws[IMX7ULP_CLK_HSRUN_CORE_DIV]->clk,
> > +hws[IMX7ULP_CLK_HSRUN_SYS_SEL]->clk,
> hws[IMX7ULP_CLK_SPLL_SEL]->clk,
> > +hws[IMX7ULP_CLK_FIRC]->clk);
> >
> >  	hws[IMX7ULP_CLK_DDR_DIV]	=3D imx_clk_hw_divider_gate("ddr_clk",
> "ddr_sel", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, base + 0x30, 0, 3,
> >  							       0, ulp_div_table, &imx_ccm_lock);
> @@ -270,7 +272,7 @@
> > static void __init imx7ulp_clk_smc1_init(struct device_node *np)
> >  	base =3D of_iomap(np, 0);
> >  	WARN_ON(!base);
> >
> > -	hws[IMX7ULP_CLK_ARM] =3D imx_clk_hw_mux_flags("arm", base + 0x10,
> 8, 2, arm_sels, ARRAY_SIZE(arm_sels), CLK_IS_CRITICAL);
> > +	hws[IMX7ULP_CLK_ARM] =3D imx_clk_hw_mux_flags("arm", base + 0x10,
> 8,
> > +2, arm_sels, ARRAY_SIZE(arm_sels), CLK_SET_RATE_PARENT);
> >
> >  	imx_check_clk_hws(hws, clk_data->num);
> >
> > diff --git a/include/dt-bindings/clock/imx7ulp-clock.h
> > b/include/dt-bindings/clock/imx7ulp-clock.h
> > index 38145bdcd975..b58370d146e2 100644
> > --- a/include/dt-bindings/clock/imx7ulp-clock.h
> > +++ b/include/dt-bindings/clock/imx7ulp-clock.h
> > @@ -58,7 +58,10 @@
> >  #define IMX7ULP_CLK_HSRUN_SYS_SEL	44
> >  #define IMX7ULP_CLK_HSRUN_CORE_DIV	45
> >
> > -#define IMX7ULP_CLK_SCG1_END		46
> > +#define IMX7ULP_CLK_CORE		46
> > +#define IMX7ULP_CLK_HSRUN_CORE		47
> > +
> > +#define IMX7ULP_CLK_SCG1_END		48
> >
> >  /* PCC2 */
> >  #define IMX7ULP_CLK_DMA1		0
> > --
> > 2.16.4
> >
