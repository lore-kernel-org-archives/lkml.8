Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1690C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7041C20C09
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Aj36h4T0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbgIHTHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:07:49 -0400
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:53838
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730949AbgIHQHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:07:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuW/2hGQ6G2CYtoOdiUdvpNVt2xXsrqE2QCzeFj3uRIMItGJTU8AQoalbdDoTY2h6DAb1jJ16TwoDz3RNfcf0Lc/ySRGpUzPThOshTZ7XLyytRCloLiM4JN5sN624Jxqng1KkdZNiCrvZkl9mOhSUV2JhATbgwRetiChNwj5RR4I+9X/6iHRhdV9M37UPdVVI4pMoLYkKso5fzHrTZr8VH7EBl+xqZiYjkbg8A3ugMsS1AictfXvKyMp2Wm5XZqiEzwtTBE+zVHzMN/SJ/MZJDZO4ovZ0SZQtrygAnt+Q17Yrfbp1hSvJiQZVkL74zff1qPlOMrHU1o/CW44KHakvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3pivkGVTm4lb22M4WHnQIAy97tEHYK9A3MF5GEI+hE=;
 b=kCApNZ6VRCVlGesPqsZZ5JW1U2DzWTvdVUvOBQPcVpVVaoj45HWTlefGo1LCQxGHkC8U6UDgvQu3tGpjJ0+bOuwLj1hjs3tNz9w7cLWGMOSXrHtEtAsnkVr0x5drUyL0wJ/8Cm+S1n2ANJFBtSeORl76f+QZlMuCVbPhzjOyhUD0IM+ZlIAtqcjdKKCewV2HdNeO4EbcJk2SELyfdwB+D6KW5wv+uXaKtYfXJwTdsausopdJ1zYr4RxKMYS/SQ1DuKQtATrZP9Ys08yf3qQaMnBpaRGe9wrmT+Ch5aowU58kRY2xqHoweTF2vuqg+YNNGx4kNGzTci0PjvsPJMxU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3pivkGVTm4lb22M4WHnQIAy97tEHYK9A3MF5GEI+hE=;
 b=Aj36h4T0rEIU70icXvxfzIX7tmGkfb65q+FVHLcstkkN8XNXk59YBOttwnCcdS/t+Qq+T3MLIvMWNCWAn+e4+DM/F7qwYrv7b79bQcd5PQJ0qYHkruS9BveSysM1JaMBI39IhO6oO9x99ovmBtaesUad1fRb13e8M/LfNaqX3mY=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6620.eurprd04.prod.outlook.com (2603:10a6:10:107::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 12:10:49 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 12:10:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH] clk: imx: lpcg-scu: SW workaround for errata (e10858)
Thread-Topic: [PATCH] clk: imx: lpcg-scu: SW workaround for errata (e10858)
Thread-Index: AQHWhcFn0/+Aux5DqUWd1exW7eRQAKleh2oAgAAev3A=
Date:   Tue, 8 Sep 2020 12:10:49 +0000
Message-ID: <DB6PR0402MB2760700DC65AD1138EEBDA3688290@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1599556487-31364-1-git-send-email-peng.fan@nxp.com>
 <20200908101858.kiuzcnc6rolbbyma@fsr-ub1664-175>
In-Reply-To: <20200908101858.kiuzcnc6rolbbyma@fsr-ub1664-175>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [121.224.118.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18590080-a6cb-4167-0b0a-08d853f03960
x-ms-traffictypediagnostic: DB8PR04MB6620:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB66207B7B38545B22A44211B388290@DB8PR04MB6620.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sLxsRsMJQRs50Q05mCC/uHQcZjy75idWqz3hXDqcnRChuaj6Kq57xBDRAKh9U1FmBY8PvgGOCwBf9kRpBG2gqxdtBfL6nf2N+GQ/JNf/unvn54tFWI1dgcEq2i5faCsdsJwX5/oJ4TN5Hlzhb1IdlgkUVK6cx2k1x6cJgGGvJU4Grb+pwSx9fdpNJAhtDimc5dDIlBI0F3X+6GWJUS1d8Vxo39gBUtUYihrpfdSxrUh9D/7Xhy6hHGkqaNaXtMTT/1ANtIs4YZFDwWFPNMJfbU8dsZxy4KHY8T/FLS9tLELmszFDBrNwojA6sJu1pej7Y1wHr/UOqVDBjy3Kn7KWEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(26005)(6506007)(66446008)(64756008)(66946007)(66556008)(186003)(6636002)(6862004)(86362001)(71200400001)(33656002)(52536014)(5660300002)(76116006)(44832011)(66476007)(53546011)(4326008)(8676002)(7696005)(54906003)(2906002)(8936002)(83380400001)(9686003)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KLLilySm4SS3oLUq/KSvSg287tVvLzLpon2Vao3FuF/Pw8bDvrLDyRQrxTyfx4qnv6wYGEVHvwN2u9jriOmxQIftNDYaTID5E9NQXvOEdiQrt65fxmU2O+a9jPyQTXY0+ozmzFKGCAbG76dlRLGnybQagWtmwwsxo9opGLXkCJwmS3WIGl4+hzz4bdN5eSFLTiYJDIRzwJGV4qQd40upzJ2zLP5oHCwtePIL/Dq4luCZqlGziBfEeXeemKlpKmZ4ZNVorUIGE+NmqwY94OgL1Cab8vebYwRVfs4feZ0DoCwxLJcL8VjB1f5PlsfOEO83LMYTaqNEWlBmE/ZDSiGzpjpKyFf/ktm6BXpg6zcDOEPRo/23H8YoV4KScofg81JG+LpR+/4uj+zJXFQ3InwaMmnjexy4LQ0lJJEC9ddbFQ14WhqhCR13R+z2U42Npe0P0ZKOwl5fBvx43CNjtrSgZtAeMadfTamZjqYJfpqyh3131s66W2tt5C1NST20W+qT0RGJMuSBy2piqXbyY8orEYulid2qjIaf1+pg3p+JKFQ6sFvGqyLzWyh4Y9/g/jfWG2MtefXC1WMi1IrFBiNvl81/3tn4yoSiNMuKoq8JEJkzZnPpK3hQ88nnsYhivJE+NdxiOh3ltj6I2e/3QpgGFw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18590080-a6cb-4167-0b0a-08d853f03960
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 12:10:49.1407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Reuri6mkGurgAjo7jrs9dHy9EXDogfNw9y3SuU3Fp1X4GcSa91DjTu9Hha3LOvk1HQ9QH/XTuPFEr6FxOdVvyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6620
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] clk: imx: lpcg-scu: SW workaround for errata (e10858=
)
>=20
> On 20-09-08 17:14:47, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Back-to-back LPCG writes can be ignored by the LPCG register due to a
> > HW bug. The writes need to be separated by at least 4 cycles of the
> > gated clock.
> >
> > The workaround is implemented as follows:
> > 1. For clocks running greater than or equal to 24MHz, a read followed
> > by the write will provide sufficient delay.
> > 2. For clocks running below 24MHz, add a delay of 4 clock cylces after
> > the write to the LPCG register.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/imx/clk-lpcg-scu.c | 31 +++++++++++++++++++++++++++++--
> >  1 file changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-lpcg-scu.c
> > b/drivers/clk/imx/clk-lpcg-scu.c index 1f0e44f921ae..6ee9d2caedf2
> > 100644
> > --- a/drivers/clk/imx/clk-lpcg-scu.c
> > +++ b/drivers/clk/imx/clk-lpcg-scu.c
> > @@ -6,6 +6,7 @@
> >
> >  #include <linux/bits.h>
> >  #include <linux/clk-provider.h>
> > +#include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/slab.h>
> > @@ -38,6 +39,31 @@ struct clk_lpcg_scu {
> >
> >  #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu,
> > hw)
> >
> > +/* e10858 -LPCG clock gating register synchronization errata */
> > +static void do_lpcg_workaround(u32 rate, void __iomem *reg, u32 val)
> > +{
> > +	writel(val, reg);
> > +
> > +	if (rate >=3D 24000000 || rate =3D=3D 0) {
> > +		u32 reg1;
> > +
> > +		/*
> > +		 * The time taken to access the LPCG registers from the AP core
> > +		 * through the interconnect is longer than the minimum delay
> > +		 * of 4 clock cycles required by the errata.
> > +		 * Adding a readl will provide sufficient delay to prevent
> > +		 * back-to-back writes.
> > +		 */
> > +		reg1 =3D readl(reg);
> > +	} else {
> > +		/*
> > +		 * For clocks running below 24MHz, wait a minimum of
> > +		 * 4 clock cycles.
> > +		 */
> > +		ndelay(4 * (DIV_ROUND_UP(1000000000, rate)));
> > +	}
>=20
> Just to make sure this is totally understood, if the lpcg consumer needs =
to two
> enables/disables in less than 4 multiplied by the clock period, the secon=
d
> enable/disable will be delayed.

You surely wanna this following errata description.

Thanks,
Peng.

>=20
> If we're fine with this, then here is my R-b.
>=20
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
>=20
> > +}
> > +
> >  static int clk_lpcg_scu_enable(struct clk_hw *hw)  {
> >  	struct clk_lpcg_scu *clk =3D to_clk_lpcg_scu(hw); @@ -54,7 +80,8 @@
> > static int clk_lpcg_scu_enable(struct clk_hw *hw)
> >  		val |=3D CLK_GATE_SCU_LPCG_HW_SEL;
> >
> >  	reg |=3D val << clk->bit_idx;
> > -	writel(reg, clk->reg);
> > +
> > +	do_lpcg_workaround(clk_hw_get_rate(hw), clk->reg, reg);
> >
> >  	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
> >
> > @@ -71,7 +98,7 @@ static void clk_lpcg_scu_disable(struct clk_hw *hw)
> >
> >  	reg =3D readl_relaxed(clk->reg);
> >  	reg &=3D ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
> > -	writel(reg, clk->reg);
> > +	do_lpcg_workaround(clk_hw_get_rate(hw), clk->reg, reg);
> >
> >  	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);  }
> > --
> > 2.28.0
> >
