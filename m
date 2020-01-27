Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5110FC35247
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 05:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19108214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 05:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X4VO6Hm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgA0FAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 00:00:31 -0500
Received: from mail-eopbgr140055.outbound.protection.outlook.com ([40.107.14.55]:5205
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbgA0FAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 00:00:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixbrgpBkZ+qPCNrScidjSBbX4zuOaE6FkD38wewDhomfbpsAeIJm4snWNx6XILnWDaC+GA3zzhlSm4wSqDMIFn5zMVYRjA06B3gaMU/pfxVJcAdAYvfA4N2UHmzMTTGLqLepjLKRCKGygQzR0aLoV4q8N74cOqq+zFZSXbHcwNj2lfz31nMB2Ob7k8MxgihiFMO5UIuu4p4wJfWh8dkerXQ/JCrw4cTlRVcbsUWu04UaTD7IRFQ/xKt5l2r7RGIYz70XMWjJNQYskpfevKQBoV9HAMkdKYEv9TG+RpR1LJ5df2Ma0mRY7PUyhy1q/AoOm1HVQ79wb064Rdsp+spJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6VWt2dUTfR+eYglH/8RzaKXrQPUuZ2/G07u54Uknco=;
 b=fYsSajpebAFnmEbBnLB8gnznFZ1pGEep95nvVqPCH/q1uYlSCayZ6KEI4m5oqbTw7SrrSp84Aan91KCm2hxadsELkIjGr6N+MNPt45Cds/8OcC9/EpKhJPEBJSHjidRgkklF27bVFcc0857f6JGIgXzFbZh8lEiRlU2K5CwgLfs7Gegabe60sOidfBw1l2HOslV0XmNRqPQmVmtENNBCCcxmtPaRCexwmj2gf+7knu9i8elYqtuURZdrc3BPnYnClvJIoCZJUM0hnaLH3qjZAy8eAEj4rEozW3i+fBrHWIMwtLBUUUnv6BLY1EuxB+cSPBSNeJgDPxykUMGzcTGjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6VWt2dUTfR+eYglH/8RzaKXrQPUuZ2/G07u54Uknco=;
 b=X4VO6Hm5IcE0hWGfM8qr5uXajbFH7gkZ5J0Ao2iA8utHZpV10504Gd/RSt19a2JKN8AMlTBqdNuZPkex3SCW9Y8D3ADp4FOQ8jsfJMdLgdzKRr1eTQ9I/Y+Ca8J1tcLIVmhmNjDniJamgdhXr2bvHiV7SpYOg2ynlLWql86CX6w=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6883.eurprd04.prod.outlook.com (52.132.212.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Mon, 27 Jan 2020 05:00:26 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 05:00:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
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
Subject: RE: [PATCH V3 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V3 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Index: AQHVzBLhTw2vfOWK6k2th/PMm5Cat6f+BJtQ
Date:   Mon, 27 Jan 2020 05:00:26 +0000
Message-ID: <AM0PR04MB4481A8AF4694F539FBED0D54880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1579140562-8060-1-git-send-email-peng.fan@nxp.com>
 <1579140562-8060-3-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB70239267F223F63918362DDCEE320@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB70239267F223F63918362DDCEE320@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ce7a854-e73f-4a91-5b03-08d7a2e5d2ac
x-ms-traffictypediagnostic: AM0PR04MB6883:|AM0PR04MB6883:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6883DFBCF04FEBCC70E27EB8880B0@AM0PR04MB6883.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(52536014)(8936002)(5660300002)(55016002)(9686003)(66556008)(64756008)(66446008)(66476007)(76116006)(53546011)(66946007)(8676002)(81156014)(81166006)(44832011)(71200400001)(6506007)(186003)(86362001)(33656002)(26005)(110136005)(4326008)(316002)(54906003)(2906002)(7696005)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6883;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bpvQNh9p/rff4/IjTUKSeOcHbVaZidA+wfdjC9Gh7O72axqc2BVotyIcwx2B2v+fBqHEioqr9W5MOi854Spjct9pzOpRbQS0wGtTJGkf4m09vcYuDNBgYPmIhFI293QIHkxUG3jddhnatp8UhJ/owDcmyxj/0U0TtaSjL/1tkfiz+MXQkEDmnKbw/m7Ahh9uhSPSvYuOtcG1Rj4jhlYS6B+Sxm/VRoNNglI/78bzCegO7EQvsGe75mVhmo1NWVf8qE7phTAqsESwUs+Q2TdwBTRa4870mkY1qMqsuDbqO2TALf9RYrPqL9cRxi99+m2Z1mHEn2fGqXVEIETX5Yimhnnz6vHGH38hEE3REsxVm9CTejidUJEIYAeA5RoWch/lUi5wtdbypOOER316yz9JLVIW6qs8rZsoPreLk5BrT/wbVdeF9gd3Cf3LpSSaeuPjbggQSAefvW85pV2mE522iTmplXlm7s+MiEPoKBlhLJTAn+AXPE0KvkTEMAaFOwM9
x-ms-exchange-antispam-messagedata: AL2/2jhIcb+mdH+t+ggQWgjeAyP/5dJuALdezdX3RjKnibrgcP+Zir9UCckcc7tqA7SuSeUQrLXZ4g3kVDDfqXAmy4zl07A3ViQmOIZcYcGn52aliH7vKJzNUVPh4godnHM0C5QmfVVzYu0enFgn/g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce7a854-e73f-4a91-5b03-08d7a2e5d2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 05:00:26.1232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGgAQMofhNrsHMUOu5PGHFJj+2dxXROloxcP4sygsKnPVi3gM/q5sZaoVTYi8xyXrRiEgfR1Eeq0PZz4FlqY6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V3 2/4] clk: imx: imx8mq: use
> imx8m_clk_hw_composite_core
>=20
> On 16.01.2020 04:15, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Use imx8m_clk_hw_composite_core to simplify code.
> >
> > Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >   drivers/clk/imx/clk-imx8mq.c | 22 ++++++++--------------
> >   1 file changed, 8 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mq.c
> > b/drivers/clk/imx/clk-imx8mq.c index 4c0edca1a6d0..e928c1355ad8
> 100644
> > --- a/drivers/clk/imx/clk-imx8mq.c
> > +++ b/drivers/clk/imx/clk-imx8mq.c
> > @@ -403,22 +403,16 @@ static int imx8mq_clocks_probe(struct
> > platform_device *pdev)
> >
> >   	/* CORE */
> >   	hws[IMX8MQ_CLK_A53_SRC] =3D imx_clk_hw_mux2("arm_a53_src",
> base + 0x8000, 24, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels));
> > -	hws[IMX8MQ_CLK_M4_SRC] =3D imx_clk_hw_mux2("arm_m4_src", base
> + 0x8080, 24, 3, imx8mq_arm_m4_sels, ARRAY_SIZE(imx8mq_arm_m4_sels));
> > -	hws[IMX8MQ_CLK_VPU_SRC] =3D imx_clk_hw_mux2("vpu_src", base +
> 0x8100, 24, 3, imx8mq_vpu_sels, ARRAY_SIZE(imx8mq_vpu_sels));
> > -	hws[IMX8MQ_CLK_GPU_CORE_SRC] =3D
> imx_clk_hw_mux2("gpu_core_src", base + 0x8180, 24, 3,
> imx8mq_gpu_core_sels, ARRAY_SIZE(imx8mq_gpu_core_sels));
> > -	hws[IMX8MQ_CLK_GPU_SHADER_SRC] =3D
> imx_clk_hw_mux2("gpu_shader_src", base + 0x8200, 24, 3,
> imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_sels));
> > -
> >   	hws[IMX8MQ_CLK_A53_CG] =3D
> imx_clk_hw_gate3_flags("arm_a53_cg", "arm_a53_src", base + 0x8000, 28,
> CLK_IS_CRITICAL);
> > -	hws[IMX8MQ_CLK_M4_CG] =3D imx_clk_hw_gate3("arm_m4_cg",
> "arm_m4_src", base + 0x8080, 28);
> > -	hws[IMX8MQ_CLK_VPU_CG] =3D imx_clk_hw_gate3("vpu_cg", "vpu_src",
> base + 0x8100, 28);
> > -	hws[IMX8MQ_CLK_GPU_CORE_CG] =3D imx_clk_hw_gate3("gpu_core_cg",
> "gpu_core_src", base + 0x8180, 28);
> > -	hws[IMX8MQ_CLK_GPU_SHADER_CG] =3D
> imx_clk_hw_gate3("gpu_shader_cg", "gpu_shader_src", base + 0x8200, 28);
> > -
> >   	hws[IMX8MQ_CLK_A53_DIV] =3D
> imx_clk_hw_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3);
> > -	hws[IMX8MQ_CLK_M4_DIV] =3D imx_clk_hw_divider2("arm_m4_div",
> "arm_m4_cg", base + 0x8080, 0, 3);
> > -	hws[IMX8MQ_CLK_VPU_DIV] =3D imx_clk_hw_divider2("vpu_div",
> "vpu_cg", base + 0x8100, 0, 3);
> > -	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D
> imx_clk_hw_divider2("gpu_core_div", "gpu_core_cg", base + 0x8180, 0, 3);
> > -	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D
> imx_clk_hw_divider2("gpu_shader_div", "gpu_shader_cg", base + 0x8200, 0,
> 3);
> > +
> > +	hws[IMX8MQ_CLK_M4_DIV] =3D
> imx8m_clk_hw_composite_core("arm_m4_div", imx8mq_arm_m4_sels, base
> + 0x8080);
> > +	hws[IMX8MQ_CLK_VPU_DIV] =3D
> imx8m_clk_hw_composite_core("vpu_div", imx8mq_vpu_sels, base +
> 0x8100);
> > +	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D
> imx8m_clk_hw_composite_core("gpu_core_div", imx8mq_gpu_core_sels,
> base + 0x8180);
> > +	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D
> > +imx8m_clk_hw_composite("gpu_shader_div", imx8mq_gpu_shader_sels,
> base
> > ++ 0x8200);
>=20
> > +	/* For DTS which still assign parents for gpu core src clk */
> > +	hws[IMX8MQ_CLK_GPU_CORE_SRC] =3D
> hws[IMX8MQ_CLK_GPU_CORE_DIV];
> > +	hws[IMX8MQ_CLK_GPU_SHADER_SRC] =3D
> hws[IMX8MQ_CLK_GPU_SHADER_DIV];
>=20
> Why not assign to all the old clocks?

Are those clocks expect the GPU ones needed?

Currently only the gpu clocks are needed, others are not used in dts.

For dts update to use the SRC clocks should be avoided in future for Linux,
DIV clocks should be used.

How do you think?

Thanks,
Peng.
