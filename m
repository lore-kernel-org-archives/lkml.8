Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C82C8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40BBA2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MQgKuvPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgD3M4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:56:35 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:11779
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbgD3M4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:56:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mex5Yrlq29Kph6ug9HE2hpnCcu2nCJ84xqiTwfSDBqTkArVY0hzU3vARQuCDODME/ap/Rl5dOSr4JhEHvFgGBNUuICcmdaVBvxLxNPHMwD/RuohO28AFumuhrHhjPTj2h01sOJuhI9aQ3nEp3mLd5KZDQYp9CTe/OufnZEU2P+ORjo+IhR/RTCpHgHRuYEGbaWEfZF4guRt5PEqejMsnk/tpJ9HoJt9VOjWydRIOyEfv9egKzKitbKxQJXBHHE9RQApQNsItmdPD2NG7SPphiYt/507IsRe6sRwQRz9YlLPTD4smGU6RJMIJIIQMCSdCDq9c/xzLNinqqqwnT8GIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoqANuWtX4E5GMuWIBrWBEYG7iJVULcC1HgrZQckwyE=;
 b=JFTEPfGOFGkm74RweVv/a9sUf8TiXfAH4v5iGMo6OZOdqLbQGRk4oAUXH2xPlBzwxtWV/DcyMekWMi5zg0e+8yxq+EeS4kXRu3mXSbueXVtWPwsZfASF3lgukahL/kRa/XAhMQf5CBvUGO1dd9cVKXfcfQLMYomRFsEqdkt29ikn0kjgTYBftKBzjNQgTXwEmKUdM/ii+NDPg2ZLXlAHpDk3HJi28C3XCtMCdKiL8YHSbkUBtcG0qT4K3rPTVeYasLKkm2jWu/r1YoNw4SoVvK4lBgZPUtHYNQhgAsdADXaiAG2TNcW3QX2tAi9/OiaF3nOyLOAfcqq/BCnLBn+A1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoqANuWtX4E5GMuWIBrWBEYG7iJVULcC1HgrZQckwyE=;
 b=MQgKuvPEe20ujfM+Vmwxcwr/NSAVhCXPy2xosl8+MeEaBVRXtJBe/Ppb2Cq+GyEufhPGcN+48nlLgqf64Un7x/Y5+O9E/EglLzijLM4R66ckUUQG/eZ1CpnavyyeCp+jZS32McDGV95UBour2JtFh7pv/hURq0f0+oG4hdAdaCk=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2789.eurprd04.prod.outlook.com (2603:10a6:4:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 12:56:29 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 12:56:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
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
Subject: RE: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Thread-Topic: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Thread-Index: AQHV+FjOyMJp4JjxAkWF8jtS4KMMQqiLILmAgAHSuqCABMhVgIAAJqsA
Date:   Thu, 30 Apr 2020 12:56:28 +0000
Message-ID: <DB6PR0402MB2760925E380A8E5907F6EF3788AA0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <1584008384-11578-8-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB4966D0EF272CAB282BF72EB580AE0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB276047141A63BE756B9C06D988AF0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200430100055.6rhec5rwtz2yyqbl@fsr-ub1664-175>
In-Reply-To: <20200430100055.6rhec5rwtz2yyqbl@fsr-ub1664-175>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [117.80.211.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1edf83e8-53e1-4c24-bdbb-08d7ed05e65c
x-ms-traffictypediagnostic: DB6PR0402MB2789:|DB6PR0402MB2789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB278926A45CFE2F4909C94A0688AA0@DB6PR0402MB2789.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ila3Eo5xOkhqMrZm5G/IWlDPO9s9gfxqIAZvw9ovTljxfJ2woRC4WKboIC7XH2NF14zgbrbfhtsyF1Q0X+viqD9VCkhd46OQbIHgQhNwqKGLufZTGEKbIf5eFtNwVIFRI7mrpFxtD+w53pyh0PG8Rt+fqF5PPosWdfVVqIaLb4r4aLizsZjrQ4s3EVcI0FVw8TQ5tHR9Ev2Fn05NswbthgsPSUNsUJwNBDi6IQhEaTdWDu5UaMB/qkrdp1qxdIBZHeDQsdQwkT0XHNK431VgZExhgtY/lCU9cTw0GxLvW8PBCFmgOhYiLkULkZ7nUkr6MJtPl5hVmappBK7DL586Mz05vfAkM2Ric3s38Apnr3tAloPM3bPz8rEwoilLk3luLzT6k6BZvvl95NkIvQG/onl+iiIcmVCuhHrKAxzK9ujzFe2ON7c7kjEZcFqXtafs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(2906002)(8676002)(52536014)(54906003)(110136005)(66446008)(66556008)(64756008)(66476007)(6636002)(7416002)(33656002)(66946007)(76116006)(8936002)(478600001)(5660300002)(9686003)(55016002)(86362001)(7696005)(71200400001)(4326008)(26005)(316002)(6506007)(186003)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZJisakEVTiDNU0Bg5cbo3UXInzvk/tarMNIOveXvCgk6vpVXWcc2SS+h9IW3fQv6e5oTY6u6Eula0vr5bjBsGqjqQX6BmHMroeVdMTrlqeSehFq0Q3/JfjM1UXfMBl3j+dlUg9oMnpHCxqz2EMj9MltNNGDdgmzdguGXryPLAE+EEe3tXzlq6ko7t5SawIM0H7EngrwT2ZtEhjvsHc6JLuy+IBKUzlOjxgkNBEqkKrHFpZaRNW3zuQtdcBkpyjix7ndj/dUB6DREJBrp6CTcl+vJOMtztjirYVbjI2yBNN+G5PVlV6qhTwNRQctYYJHC3y9MmrfaSSpR7FasMpvddpmmDpRFHf90Db32W4gtZecBtC2/eXVWlx51jcAYURGbdt3SdGdlGuNVxL6tvqBsu/0IjsmOTepeOYH67RZ7UlavUcJBlUYprXD9lv1j3xlAyMtcV80lVTCU3iImWu8yACI9orpkaNQzKz3hNFORdtomV7u8+7PYnBIuFgtrTdvD2izh8s4ynB7GDWcTJr6PTZoYCAtFXxHX8qLgMuvbwntjYdlW9uDdK4EGcabQf1Xe6rMJIkbMXjDnm4qIndfS8AaCZbsGKYd2PoazhsxJqti16QI3Wxpw5kDwJigso+BT4nRtbsYG/UdgtUyeFVqU0fUzPYp8a2ftL1VxGsb9fnFxIgIdVESHder6SVEJAfW9cDyIZL3FWyKjOojmo25mnb85itnN2tposPDtPHjMy8sEYg2rAqhKO1vNCR/lCPCPajKNvvQiBnEGG/f7FMQ0hkBnxHpNL1SE0QqkztM696c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edf83e8-53e1-4c24-bdbb-08d7ed05e65c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 12:56:28.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAChpjwFz2SIj9ie9YfpGR7gQFo6a1kJnV1EBn3Q9DsEY6oBGnltCilOqYi7rZZR5ljWZjnnQxxGsG6G6BeiFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel, Aisheng, Leonard and all

> Subject: Re: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite
> clk
>=20
....
> > > > +
> > > > +	return clk_mux_val_to_index(hw, mux->table, mux->flags, val); }
> > >
> > > You don't have to redefinition them if they're the same as clk_mux_op=
s.
> > > You have the access to clk_mux_ops.
> >
> > This will require export_symbol of clk_mux_ops callbacks.
> >
>=20
> Maybe you can do here:
>=20
> return clk_mux_ops.get_parent(hw);

Ok, will try this.

>=20
> > >
> > > > +
> > > > +static int imx8m_clk_composite_mux_set_parent(struct clk_hw *hw,
> > > > +u8
> > > > +index) {
> > > > +	struct clk_mux *mux =3D to_clk_mux(hw);
> > > > +	u32 val =3D clk_mux_index_to_val(mux->table, mux->flags, index);
> > > > +	unsigned long flags =3D 0;
> > > > +	u32 reg;
> > > > +
> > > > +	if (mux->lock)
> > > > +		spin_lock_irqsave(mux->lock, flags);
> > > > +
> > > > +	reg =3D readl(mux->reg);
> > > > +	reg &=3D ~(mux->mask << mux->shift);
> > > > +	val =3D val << mux->shift;
> > > > +	reg |=3D val;
> > > > +	/* write twice to make sure SEL_A/B point the same mux */
> > > > +	writel(reg, mux->reg);
> > > > +	writel(reg, mux->reg);
> > >
> > > Why this affects both SEL_A/B?
> >
> > The internal counter will make sure both SEL_A/B point to the same
> > mux.
> >
> > > Very tricky and may worth more comments.
> >
> > Ah, I think RM should be clear about the target interface and
> > non-target interface.
> >
> > When you write once, saying use SEL_A, when you write the 2nd, the
> > hardware will use SEL_B, when you write 3rd, the hardware will use
> > SEL_A.
> > and ...
> >
>=20
> This is a very interesting behavior from HW point of view.
> So every write changes the mux ?
>=20
> Unless there is an ERRATA for this, we'll get a lot of pushback from upst=
ream.

Let me share more details about this. Then if ok, I'll put in commit log an=
d post
V2.

There is no errata, this is the hardware designed as is and it exist since =
i.MX7D.
i.MX8M and i.MX7D using same CCM root design.

It support target(smart) interface and normal interface. Target interface i=
s exported
for programmer easy to configure ccm root. Normal interface is also
exported, but we not use it in our driver, because it will introduce more
complexity compared with target interface.

From RM:
"
The Target Interface is optimized to simplify software operation. Using thi=
s interface, all
clock roots are in the same program model with the same register bit field =
mapping. The
software does not handle the details of the clock slice and clock slice typ=
es. Software
writes the desired settings to the register, and the internal hardware logi=
c generates a
required sequence to achieve the desired settings.
"

From i.MX8MN RM:
"
A requirement of the Target Interface's software is that the
target clock source is active.
"

We touch target interface, but hardware logic actually also need configure =
normal interface.

I draw a simple normal interface for core clock slice pic:

CLK[0-7] --------->SEL_A ----->-----CG---->|
         |                        \
         |                          mux-->post_podf-->
         V                        /                  =20
         |------>SEL_B------>---CG---->| /


The mux in the upper pic is not the target interface MUX, target interface =
MUX is
hiding SEL_A and SEL_B. When you choose clk[0-7], you are actually writing
SEL_A or SEL_B depends on the internal counter which will also control the
internal "mux".

Whether the hardware touch SEL_A or SEL_B, it requires the clock input to
SEL_A or SEL_B must be active. However SEL_A and SEL_B could have
different value. Saying SEL_A is clk1, SEL_B is clk4, the internal counter
controlled automatically by hardware logic choose SEL_A, then Linux will
disable clk4 because of no user. Now we write target MUX to choose clk5,
the internal counter will configure SEL_B to clk5 and switch to SEL_B,
however the previous SEL_B input clk4 is off, system hang, the hardware
requires SEL_B input clk4 is on, then hardware could configure SEL_B to
clk5.

That's why write twice to make sure the internal counter could select
SEL_A and SEL_B to same active input clk.

Please see whether this clarify the issue or not. I could post the upper
into commit log in V3. The fixes needs to be into 5.7 to avoid system
boot hang.

Thanks,
Peng.

>=20
> > >
> > > Besides that, I'd like to see Abel's comments on this patch.
> >
> >
> > Abel,
> >
> >  Any comments?
> >
> > Thanks,
> > Peng.
> >
> > >
> > > Regards
> > > Aisheng
> > >
> > > > +
> > > > +	if (mux->lock)
> > > > +		spin_unlock_irqrestore(mux->lock, flags);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int
> > > > +imx8m_clk_composite_mux_determine_rate(struct clk_hw *hw,
> > > > +				       struct clk_rate_request *req) {
> > > > +	struct clk_mux *mux =3D to_clk_mux(hw);
> > > > +
> > > > +	return clk_mux_determine_rate_flags(hw, req, mux->flags); }
> > >
> > > Same as bove.
> > >
> > > > +
> > > > +
> > > > +const struct clk_ops imx8m_clk_composite_mux_ops =3D {
> > > > +	.get_parent =3D imx8m_clk_composite_mux_get_parent,
> > > > +	.set_parent =3D imx8m_clk_composite_mux_set_parent,
> > > > +	.determine_rate =3D imx8m_clk_composite_mux_determine_rate,
> > > > +};
> > > > +
> > > >  struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
> > > >  					const char * const *parent_names,
> > > >  					int num_parents, void __iomem *reg, @@
> -136,6
> > > > +193,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char
> > > > +*name,
> > > >  	struct clk_gate *gate =3D NULL;
> > > >  	struct clk_mux *mux =3D NULL;
> > > >  	const struct clk_ops *divider_ops;
> > > > +	const struct clk_ops *mux_ops;
> > > >
> > > >  	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
> > > >  	if (!mux)
> > > > @@ -157,10 +215,12 @@ struct clk_hw
> > > > *imx8m_clk_hw_composite_flags(const char *name,
> > > >  		div->shift =3D PCG_DIV_SHIFT;
> > > >  		div->width =3D PCG_CORE_DIV_WIDTH;
> > > >  		divider_ops =3D &clk_divider_ops;
> > > > +		mux_ops =3D &imx8m_clk_composite_mux_ops;
> > > >  	} else {
> > > >  		div->shift =3D PCG_PREDIV_SHIFT;
> > > >  		div->width =3D PCG_PREDIV_WIDTH;
> > > >  		divider_ops =3D &imx8m_clk_composite_divider_ops;
> > > > +		mux_ops =3D &clk_mux_ops;
> > > >  	}
> > > >
> > > >  	div->lock =3D &imx_ccm_lock;
> > > > @@ -176,7 +236,7 @@ struct clk_hw
> > > *imx8m_clk_hw_composite_flags(const
> > > > char *name,
> > > >  	gate->lock =3D &imx_ccm_lock;
> > > >
> > > >  	hw =3D clk_hw_register_composite(NULL, name, parent_names,
> > > > num_parents,
> > > > -			mux_hw, &clk_mux_ops, div_hw,
> > > > +			mux_hw, mux_ops, div_hw,
> > > >  			divider_ops, gate_hw, &clk_gate_ops, flags);
> > > >  	if (IS_ERR(hw))
> > > >  		goto fail;
> > > > --
> > > > 2.16.4
> >
