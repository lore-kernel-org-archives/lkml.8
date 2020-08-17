Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A00C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF512078A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wlg/dqCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHQH0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:26:53 -0400
Received: from mail-eopbgr20068.outbound.protection.outlook.com ([40.107.2.68]:33046
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbgHQH0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:26:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYExHsaJRmWXlfghFtSjstthJCNs+aWe54tFu9KasWL3USRMX5xs986epd+pWMVAB5NzCu3v+dM13nsEo3aK2XB3kaLwiqF78oOKjj/1k6QDabo50jhAp65aGlh/R9bXVHohu4j3lX4obNg1IMEiHEr+nbTeL8OV0O2xVCNMMIXQYiDF2GgvuLOL84ihi4ltSLKMWJ38HdRkKKhSZWM1LUTwf8DYLLTLCm9SiN56/pabrVFiqyqKFGDt6TmPX0YCkYnJKkSeksbqrIhZoYhTvs6d2suutLYwTeFz8zwgPitqzBfw4JOy8StgzVcG5RTAC39O/hvJsgxulZ33YpfqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo30cFCQGu0R+YOYTvedSn19zuwocmAoDQ4hp9JVY3w=;
 b=UU3lGAEdTczCqwuLNHgiWVY+t+gyNXTAaTdfRLgxf5nwXrQA30AjF2PI+zB6wbmS1hhhhkrD3UtZli9tTXpAozg07B5ohI25EB8l6eN26DQ7c4GiZDlgcbAxUxlNqry9A2SQrIIwDG8r4FJfRX0Fa9Nth2y0IWpCwnfHrhGWORZZ5d8Cj07qjrpO9ljZ8J9eCw9Mxrs/l3WHglh2KdnucQRfGdTW0IiEXH5q25hy7qXbS4dL1mIfq9nErtfCZ0rxiqJiwNtQjxz5HrUReh6+OBAbjR0J9t/7yC2drpPVltVRuWcTgw20SRQ+mMgPBx4IF+x+RKqxeZWoWap9I8jVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo30cFCQGu0R+YOYTvedSn19zuwocmAoDQ4hp9JVY3w=;
 b=Wlg/dqClbubFm45aIRhzhIq/mrswSUEawLz3SQ7Yn6doZTZSMdVPpYUe52d99zbHuTeSxkSEDHkjiFfxSFQkQT3eLe+skX0drBPzZBuzhgGfl3jjZ4lHcDWqtojb2KIEGqEL2BfBeOyDXWxJHP9REAO2UhlIvcke/BJgV2CEK3M=
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Mon, 17 Aug
 2020 07:26:42 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::c10b:eaf9:da9a:966e]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::c10b:eaf9:da9a:966e%7]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 07:26:42 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v1 0/5] imx6qp QuadPlus: support improved enet
 clocking
Thread-Topic: [EXT] Re: [PATCH v1 0/5] imx6qp QuadPlus: support improved enet
 clocking
Thread-Index: AQHWdGaEHGWKlL1NRkSmOlcnqonx+qk75gRA
Date:   Mon, 17 Aug 2020 07:26:42 +0000
Message-ID: <AM8PR04MB7315BD29E65F11A6DF693224FF5F0@AM8PR04MB7315.eurprd04.prod.outlook.com>
References: <20200713002512.28742-1-TheSven73@gmail.com>
 <20200817071726.GA16951@dragon>
In-Reply-To: <20200817071726.GA16951@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e69c08ef-fc9e-4211-0ea5-08d8427ee382
x-ms-traffictypediagnostic: AM0PR04MB5858:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5858B2F5243772817FB77088FF5F0@AM0PR04MB5858.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qc5MMKH5yqDUeCe/2Fk9O/GN1dEQChNMIS9gZVEzS+lijHsGBRAOVHcvPepul/QEK4aVTgAJMjCHYj03RYBocZXHtFzp0ksW/dzSgXfqbApVAZiy62Do+xtccde6QiLGTaTCUUbM5jHUL3k10r3sZcAOP6bxhkrjtLioTb2LzQ9RsS+H7RmvC/1+Cm46apS0Ay+ECzERDSaNb4T0D/oV6eVMmEyEb9Rju9rGMO6tLoHUxiLXYcWZqYubzthWMIVcebfrYGO++3aHvCtA2GBBl7S6J04MOLPJRbILXy5Rd8nt3DFHz76m657JT5yH62ez/asowhxaasM+dTuTiwIDPabRENSEFv9Suj1/fAutQsgAywMbd26Kw3yAEfvxNMKJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(86362001)(5660300002)(4326008)(110136005)(8936002)(66946007)(64756008)(66446008)(66476007)(76116006)(2906002)(52536014)(66556008)(26005)(9686003)(83380400001)(186003)(55016002)(71200400001)(7696005)(6506007)(478600001)(54906003)(316002)(33656002)(8676002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KDVM51Js5x3vEHG6C4vFaq/H9LUycw8EUZFkKQSSJtwo9ZSg9gB/wW1cjxYBnAz3wqQNTLn5owE7wZVW5THM/WQGLyuZVWBmywu3KfBX0SvgLUSl0sv2pxoJeo2yl13drwu4xhE8g1PiaCsCeXs79Bbp/vvdYn5hT6vDQZtWo+v7oNUWN8zzEk+/D/aF5STBoPqydqfLhPL6ylFvJn2C+AhLt8eRgoiGTqBIx4A8X4u11zi+VXjV1TBS/uQpUQpkXO8/xzIGLR8cpBMLwg1zoJiyA+PTzyAyBn98Sj3Gq8jYFGrafzsx3opUnd9PIRVDRiGvCGMMpbW74TDrDY0Qwuv2Mw8JIKSdCV+9xMxgFPstOw7TGhVzsVZULI8mXTuXSoV7rpeb0QVAbwaAh78ZY/wCMJesQu4Cxw/ycobgSz+KgGtFkeUF/a8KIovtpb2jivHz+d14mimaLVoVtB791pa2SLdRccjz8n6Wj//f0lCfe7Ozvwz2o2c4NoApbr8J6xjZbGx3EDYdJoCDetOgC+XFMUDIw9qThHWpl6yh4jvwpN/yCXzkp0PrwM0HjDzhieW2hmwiC2CrnTZdL935+SrXunYv9kRhp5BhQBWPu9tubOQtsaeRhlEMUt4r3aLjFBNPQKblxYn/9XMH2jkzgw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69c08ef-fc9e-4211-0ea5-08d8427ee382
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 07:26:42.2551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrLWmIBEcqgphDYzrpH72pO+qigK1AKv9jom+g8vjKZtq/rrU7lkHEGcwyG3SYSp7S30qU5hAxBO7NYqLSA1Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5858
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Guo <shawnguo@kernel.org> Sent: Monday, August 17, 2020 3:17 PM
> On Sun, Jul 12, 2020 at 08:25:07PM -0400, Sven Van Asbroeck wrote:
> > On the imx6qp QuadPlus, the h/w designers have improved enet clocking.
> >
> > This patchset extends the clock tree to reflect the situation on QuadPl=
us.
> >
> > This allows board designers to choose the enet clocking method by
> > making simple clocktree changes in the devicetree.
> >
> > Default setting: external routing of enet_ref from pad to pad.
> >
> > Example, change the default to enet_ref @ 125MHz clock routed internall=
y:
> >
> > &fec {
> >       assigned-clocks =3D <&clks IMX6QDL_CLK_ENET_PTP>,
> >                         <&clks IMX6QDL_CLK_ENET_REF>;
> >       assigned-clock-parents =3D <&clks IMX6QDL_CLK_ENET_REF>;
> >       assigned-clock-rates =3D <0>, <125000000>; };
> >
> > To: Shawn Guo <shawnguo@kernel.org>
> > To: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-clk@vger.kernel.org
> >
> > Sven Van Asbroeck (5):
> >   ARM: mach-imx6q: do not select enet PTP clock source on QuadPlus
> >   clk: imx: add simple regmap-backed clock mux
> >   dt-bindings: imx6qdl-clock: add QuadPlus enet clocks
> >   clk: imx6q: support improved enet clocking on QuadPlus
> >   ARM: dts: imx6qp: support improved enet clocking on QuadPlus
>=20
> Hi Fugang,
>=20
> Can you take a look at the series?
>=20
> Shawn

In fact, Sven already sent the patch list to me in private for review
due to miss cc to me. We discussed the series for long time and suppose
Sven will send v2 patch set.

Regards,
Fugang
