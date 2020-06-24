Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B82EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABD620786
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q1PY8GNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbgFXBkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:40:23 -0400
Received: from mail-am6eur05on2062.outbound.protection.outlook.com ([40.107.22.62]:6112
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387780AbgFXBkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiCHA2bYUpKhtCY/YGPuQ5RiRA5pojT0LRVSgZGgC9BpqsrJQSSGbc5Zwvi3k0M17E/DJICeVQd//KpcJChYUI7Kx35tRFGB6EGhAiBrR//FCPwwhKT2boOA0ny9GIDRvRLnOJneSMoYDAbFi3gmfxNSOFHA459wvb74c1meP9CEZSqp+dJ+0uFWWXk1UdbCogQp3VxWnn376awg27Ijjui3F9XbGb4pXFGMWjlbID4rmoFVdAaWlhCFAmodfXVt7fXUQbOgn6sOVgwbRbvsYsukirH5SAc27VIFJZ3hyKFc2j4v04RqbcaXIXTc1nDLgkRYlK1zxYIeQOBM7gCx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogZpg/MKhWKI6tpOXytlDpIo2jxPgi50V30xuz4gZk8=;
 b=QTfLX9RI2x33cDmdRMMRYeDtl1/3sWDxgu5I0cd4Wth6xDZJrtJ/uHOmBXU8SRejMxE/oX1Ym65Pfd3049ooy+qlXOEwjubNr4g1x1nk990EX5vKidMHqcdHjEN1EKtgZmlqwhjZ69nhEO3mC41bNwNVnz7UzNsP4N/yjYDbKLls6+gqzuN1SZbXPjd+Ih4DNq5ULHpFMV3xerx5tO6l8M1/mI0MierBmXp9CXh/0vpPY9sBBmbPzHFB8+xPW156RjlxPZAdVwM4SxVqHEqKenE8JAWLTG1vPUoxAdgt/eBMPNRPUS6is+sO2rZ9pyu680sgncfh7JfzMe3V5UlMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogZpg/MKhWKI6tpOXytlDpIo2jxPgi50V30xuz4gZk8=;
 b=q1PY8GNujJLxYLuuhElXxE5l5rnRerFSiz9It4z9WOjNjmEKxPljnTw87c5d/2CaUooAPpFUMIbdAOaYSy39qJVBuNzEgbttuvY/PyhvYjKGl8ORniuGVrt+oFZsGmguR/NJTzp0BV+sHZzev3XLKkJhEnJEQ6H0EQip8zPBTzI=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR04MB6215.eurprd04.prod.outlook.com
 (2603:10a6:20b:b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 01:40:18 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1%7]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 01:40:18 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v1] ARM: imx6plus: enable internal routing of
 clk_enet_ref where possible
Thread-Topic: [EXT] Re: [PATCH v1] ARM: imx6plus: enable internal routing of
 clk_enet_ref where possible
Thread-Index: AQHWSVTyt8Q1j3Wp3UC7ZOoTU+UqLKjm/Zhw
Date:   Wed, 24 Jun 2020 01:40:18 +0000
Message-ID: <AM6PR0402MB3607AD6AA7968D3A93D93007FF950@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200613201703.16788-1-TheSven73@gmail.com>
 <20200623115335.GC30139@dragon>
In-Reply-To: <20200623115335.GC30139@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [101.224.80.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e147ca4e-53cb-49f6-abd4-08d817df8d16
x-ms-traffictypediagnostic: AM6PR04MB6215:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB62151163D33E6A1BD9E8F593FF950@AM6PR04MB6215.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pesb0LWXP1uwJIN+uzxF9HohkhuqlMDBD/FFvPnkfeaY0NWA3jEQasLJ54vER20JfyzvnHDZWs5KA/vQmeHUllXWhhPd329AaDGGo/j0t+HxyQFzG56pdnLWLKgsXYGkyoGncGfZaQ2Uepup2NhJ92iVaF6d0fZ3Tgev22WqAlkihoDFxR+2e+dKQd7pd4J3hrgyevl00bm2/wPQHWog5Rd05fyyRqaiy0KeWdFBGekSQVL715MvARAiwqPByzTeFC1rLqrku8rOGlY3MQOlY2+8WG8Qim1RR6/fMporMKR/dfnlP0Y26XrcCT7xnu2v/CjiLtdAgZVBji7g/uaDYnKAzsgClh05rif9oC+ALl8c4KBYu/a43MSq4hgF7JM8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(316002)(8936002)(5660300002)(478600001)(9686003)(52536014)(4326008)(7696005)(8676002)(83380400001)(55016002)(54906003)(110136005)(76116006)(26005)(66946007)(66476007)(66446008)(33656002)(6506007)(2906002)(66556008)(71200400001)(64756008)(186003)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6EEM3NB3r5bGk7AT3StoQgPz4rcBzPI07U2ZHvOTycsbYl355voLtQcgB3X51+Re7DiE2Xu9rlmM+Xkt8buxhZoJqGSGDtL1QGXPPTQpICmmqSq8XXB6wK9X4NqGRILvyoHBn6PAcYJ4ky1112A9s/MPTnPQYndvvFtY5AijvtvdfEGeDXw0WsaLFLVpHcYnSsPWpy3dsZd5QRG+fg8WXGEELrT4MIvhbvLfAasdO7ODGYU4kzzwFCpnuS/5dlc19s4+SWD0uYA1iARKBxtFH/flUPz7oLKWNyUUNlGJS3Jnhbe2sFhi7cNnne26cBnvU1tVIm5cyYLrq1bXnGbHtbIrVoUsHBEqQFbj4G0vewEIpl7j+M7kGg340c84VW3J+qY6UAgUQD6Z3igoKH+rFAKOKe+bqgWylDzEFN5y/4xxyi1H7c2C30eBVUTYEzl6tJAeYRT60kjgtF1lySj+/YANb5z0njGy1TZ3+lY/CmI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e147ca4e-53cb-49f6-abd4-08d817df8d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 01:40:18.4655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2okf5W9G8QXLiqh5lmfuho3zDeGZKIjCnpgM4TUCIMKzpD6ne3RS0eq1SWlmnCiIF6y8doSFuP7d3iSiNplXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Guo <shawnguo@kernel.org> Sent: Tuesday, June 23, 2020 7:54 PM
> Hi Fugang,
>=20
> Can you take a look at this patch?  Thanks!
>=20
The patch looks good.
Reviewed-by: Fugang Duan <fugang.duan@nxp.com>

> Shawn
>=20
> On Sat, Jun 13, 2020 at 04:17:03PM -0400, Sven Van Asbroeck wrote:
> > On imx6, the ethernet reference clock (clk_enet_ref) can be generated
> > by either the imx6, or an external source (e.g. an oscillator or the
> > PHY). When generated by the imx6, the clock source (from ANATOP) must
> > be routed to the input of clk_enet_ref via two pads on the SoC,
> > typically via a dedicated track on the PCB.
> >
> > On an imx6 plus however, there is a new setting which enables this
> > clock to be routed internally on the SoC, from its ANATOP clock
> > source, straight to clk_enet_ref, without having to go through the SoC
> > pads.
> >
> > Board designs where the clock is generated by the imx6 should not be
> > affected by routing the clock internally. Therefore on a plus, we can
> > enable internal routing by default.
> >
> > To: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> > ---
> >  arch/arm/mach-imx/mach-imx6q.c              | 18
> ++++++++++++++++++
> >  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  1 +
> >  2 files changed, 19 insertions(+)
> >
> > Tree: next-20200613
> >
> > diff --git a/arch/arm/mach-imx/mach-imx6q.c
> > b/arch/arm/mach-imx/mach-imx6q.c index 85c084a716ab..4d22567bb650
> > 100644
> > --- a/arch/arm/mach-imx/mach-imx6q.c
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > @@ -203,6 +203,24 @@ static void __init imx6q_1588_init(void)
> >       else
> >               pr_err("failed to find fsl,imx6q-iomuxc-gpr regmap\n");
> >
> > +     /*
> > +      * On imx6 plus, enet_ref from ANATOP/CCM can be internally
> routed to
> > +      * be the PTP clock source, instead of having to be routed throug=
h
> > +      * pads.
> > +      * Board designs which route the ANATOP/CCM clock through pads
> are
> > +      * unaffected when routing happens internally. So on these design=
s,
> > +      * route internally by default.
> > +      */
> > +     if (clksel =3D=3D IMX6Q_GPR1_ENET_CLK_SEL_ANATOP &&
> cpu_is_imx6q() &&
> > +                     imx_get_soc_revision() >=3D
> IMX_CHIP_REVISION_2_0) {
> > +             if (!IS_ERR(gpr))
> > +                     regmap_update_bits(gpr, IOMUXC_GPR5,
> > +
> IMX6Q_GPR5_ENET_TXCLK_SEL,
> > +
> IMX6Q_GPR5_ENET_TXCLK_SEL);
> > +             else
> > +                     pr_err("failed to find fsl,imx6q-iomuxc-gpr
> regmap\n");
> > +             }
> > +
> >       clk_put(enet_ref);
> >  put_ptp_clk:
> >       clk_put(ptp_clk);
> > diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > index d4b5e527a7a3..eb65d48da0df 100644
> > --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > @@ -240,6 +240,7 @@
> >  #define IMX6Q_GPR4_IPU_RD_CACHE_CTL          BIT(0)
> >
> >  #define IMX6Q_GPR5_L2_CLK_STOP                       BIT(8)
> > +#define IMX6Q_GPR5_ENET_TXCLK_SEL            BIT(9)
> >  #define IMX6Q_GPR5_SATA_SW_PD                        BIT(10)
> >  #define IMX6Q_GPR5_SATA_SW_RST                       BIT(11)
> >
> > --
> > 2.17.1
> >
