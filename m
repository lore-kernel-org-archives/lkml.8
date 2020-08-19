Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243F0C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0C020657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FIggxJUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHSAvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:51:36 -0400
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:64838
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbgHSAvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 20:51:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nufgd2TCLbpdqqNBEsZIxO4QNB8xd6pOy4ZEDHjKqS9O/9fIDhuSaGaqCTzhO36Ex/JLSKsx7vrnDnj/UYCb2Q/uYsDWXxjPP+WHnPdR2b9ilGA4xJ+UjPSaO6sHnuBAVHaj7NFNWhpoNhHTVTPnNgP0+452A0zobPazRtRWUo8cWsVpqt1y9UqVsA6OIG/JgbxuevsTu+H9S2LXzGNKsBxtzt+kLCvcq/vjJdidFUnr8qsKK3AzMTfRXWfEXJOP9mLHQJsEyMA/GG3xDqysrO/nSy7XwxCV640HzHTl/P8l64Laj+wtcQCNos+r8dtlliY1vWRtHlKbCCQsKqe/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfREFvQLp8qODB6gtrGaxzvYE8LUDJz6QxDiqgDR2Ec=;
 b=NenlgQxY5ndm9XvJsQoAnBkl3kBvWSWrL005EMYY1BLRWTKItu2IBqujKPa22p8+YSOzz15hNfpHwbwBUKrPy7WvdtkqNdujRX7eiZ1iZybbRtmtC35LK+lbQBNmHTp3RlwA8evVgZM/XaciQ5iXi/QMMvhpiF0UxCxP1MyBV/FsUwkAwjx07FEtZnYe7BFnMsW+xUrsshPE1kn2oZwKC0gjR5j41tRMoB3/16JWO9zbQW1oiM+Sgm1QpotR5aJNhusiLrVulZ/K0eNP0jyQf68KiB9M0ScYI0XX46Wk3pxwMU4usV6ambVDnW+iuc+O2veWtWWVEucbFA0cH5IvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfREFvQLp8qODB6gtrGaxzvYE8LUDJz6QxDiqgDR2Ec=;
 b=FIggxJUwcpSIFNOS1734ksJdY6WFGZk6nn272nTIP6r8vbYm6kO/y8qs5TWsMX627zkuK9QB/O9NRzcojEdzSGkDuTne8ieiEtT2mjPd9wKp9P8v3069w8rElrccFOB/Y05LtHJzJA4M42Sc+66g5NFi0sTeKKvRHvx/iBNzxVY=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5466.eurprd04.prod.outlook.com (2603:10a6:10:8a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 00:51:27 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3283.027; Wed, 19 Aug
 2020 00:51:27 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 04/10] remoteproc: imx_rproc: make syscon optional
Thread-Topic: [PATCH 04/10] remoteproc: imx_rproc: make syscon optional
Thread-Index: AQHWYY4pPqmFoZ4ZzEWHmcUWZM64s6k+jjUAgAAzq9A=
Date:   Wed, 19 Aug 2020 00:51:27 +0000
Message-ID: <DB6PR0402MB276017AA0C124172D9BC3483885D0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200724080813.24884-5-peng.fan@nxp.com> <20200818214350.GA3822080@xps15>
In-Reply-To: <20200818214350.GA3822080@xps15>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfc45e1a-7f7c-41ad-34ef-08d843da0147
x-ms-traffictypediagnostic: DB7PR04MB5466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB546685AFBB97AFAB96C926C9885D0@DB7PR04MB5466.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pLfydgKMQyctdjeJMuvEGkmMHCM6Ffu4tBUXlxXoSAJdiInh9i/YGfUa99BuNtuxwjlstijsDgSAao78tqQcVPrI1GzAEq+Ld6BPSiLxBrzcC07fWtA2XDYsXYimrsZXp7+LmVCWsQSDWnTysgPnobngj/6M08WTJCmGxrwOPf2ClDFpP/Y+2stbzN24ZNXK6u/3Ht+ZyAqmcVz++zYSwb9jqI5A5b6/4B6hrbzPnY+9Sde1B46DBqYm8T4huBgjjF6Vfp38qNDC7J+ditsMCxhqx69l6I0FXNFaRg5NH+1Va2o/174jWm50J6jQu6XeLEhB5gpXeHp3eee6tpqDrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(54906003)(86362001)(6506007)(5660300002)(6916009)(33656002)(186003)(8936002)(44832011)(52536014)(83380400001)(26005)(64756008)(66556008)(478600001)(66946007)(66476007)(55016002)(316002)(2906002)(8676002)(4326008)(9686003)(66446008)(7696005)(76116006)(71200400001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: j71cyJg/clua9299jNKsgZiSaLDD1rOluljqhQShhORS9wOMGXHGEf1iBwrAxjetizelO2tiNqRiCVM6fGc4q88e/B1MbcTODSTI4TaWPcK2FksFsYbyx5WdVt52PpV9TX8QgJUTg4PF645R2odfpwEArgRdr3mwpx2DKCkoDPW349tm1L9PBPAN5DzrOvPsd21j8XhSrE17fjUkfCLqyBjI7fSRuFO/k81wAoD7IqmtBzeCSnZ4z344nh3gGOm1qOUyOgZoZDyO15O7WcQXwX0If/VSGsVra0e2+KbaTXqq1SqxlK9htVOPyw06KhHzEKcuQqaoxulFtFeJS9dr+c6BQ/E5CiE70dvfJy3Og4JvxZ7Mw7ll+kZL05SJpABdhRc2qM5GCLmfR+i5nRFm0SGjFKlw4uaSy1TnQ7wrKgZ8ZOf7kjVXPthT348g/1QmhlY66FPINpBetsJJxtPANujcMZe/5mcdikEU/TS+LZv6uf4D3HebZJb0IMy02qdKLr7pFO98VuLFx+56l58V2BlrG0xw9xUl5PqNX8kHb3BbGG3k9zcOzs9D3ayMHWwR/M0PofHSnkIXnejRC3HVyUGMGCSUrvD/LjzQUrxnsHOtPjEKXmRcoSexQ4/wiGcnboF2s7e730jbuCs+G92Zdw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc45e1a-7f7c-41ad-34ef-08d843da0147
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 00:51:27.5301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEHNfVO/C2Km77aAhqrFR018fucGqZw+TXIh4HP4oONsYYMfG60+7VYzfunmeeoXZ65aIB/qhoBwmJaVyjhwJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 04/10] remoteproc: imx_rproc: make syscon optional
>=20
> Hi Peng,
>=20
> On Fri, Jul 24, 2020 at 04:08:07PM +0800, Peng Fan wrote:
> > Make syscon optional, since i.MX8QM/QXP/7ULP not have SRC to control
> M4.
> > But currently i.MX8QM/QXP/7ULP not added, so still check regmap when
> > start/stop to avoid unhappy things.
>=20
> On the i.MX8QM/QXP/7ULP processors, the remote processors are not
> handled by the remoteproc cores, as implemented in this patch.  In such a
> scenario how does the remoteproc core know the remote processor has
> crashed and how does it recover from such a condition?

For 7ULP dual boot case, A7 is under control of M4, so if m4 crash, I suppo=
se
A7 would not work properly.

For 8QM/QXP partition case, M4 is in a standalone partition, if M4 crash or
reboot, the system controller unit will restart M4 and notify Acore that M4
restart.

Thanks,
Peng.

>=20
> Thanks,
> Mathieu
>=20
> >
> > Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 82594a800a1b..4fad5c0b1c05
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -162,6 +162,9 @@ static int imx_rproc_start(struct rproc *rproc)
> >  	struct device *dev =3D priv->dev;
> >  	int ret;
> >
> > +	if (!priv->regmap)
> > +		return -EOPNOTSUPP;
> > +
> >  	ret =3D regmap_update_bits(priv->regmap, dcfg->src_reg,
> >  				 dcfg->src_mask, dcfg->src_start);
> >  	if (ret)
> > @@ -177,6 +180,9 @@ static int imx_rproc_stop(struct rproc *rproc)
> >  	struct device *dev =3D priv->dev;
> >  	int ret;
> >
> > +	if (!priv->regmap)
> > +		return -EOPNOTSUPP;
> > +
> >  	ret =3D regmap_update_bits(priv->regmap, dcfg->src_reg,
> >  				 dcfg->src_mask, dcfg->src_stop);
> >  	if (ret)
> > @@ -325,9 +331,10 @@ static int imx_rproc_probe(struct platform_device
> *pdev)
> >  	regmap =3D syscon_regmap_lookup_by_phandle(np, "syscon");
> >  	if (IS_ERR(regmap)) {
> >  		dev_err(dev, "failed to find syscon\n");
> > -		return PTR_ERR(regmap);
> > +		regmap =3D NULL;
> > +	} else {
> > +		regmap_attach_dev(dev, regmap, &config);
> >  	}
> > -	regmap_attach_dev(dev, regmap, &config);
> >
> >  	/* set some other name then imx */
> >  	rproc =3D rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
> > --
> > 2.16.4
> >
