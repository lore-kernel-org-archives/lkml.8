Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B81EC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 00:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF7A20702
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 00:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PtMT/NNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgBWAL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 19:11:56 -0500
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:27277
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726895AbgBWAL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 19:11:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVhy7TZ1Uc3XTmv3kKGI/xxykR2PzYOw02Ltb8BNsdpaMtW177uFwMJE2oqtCZCUwGELPZDhcPbtYq6I2UwyneUPqt8WY2hfhCRtEzuDR2CSjCFcZTljZ34XjVyb5Tw3N4acgQow+ZZ36CZmyug4EbIOkHU9kLht6kou0Wiy837JW1JM3ibVpUg/0+hjX/FGD5+xWfyaUnl24AVyQ3iTU7rAqBCzMTg/eU58xMaa7p3bArYdlHG1ANob9foVN0QUCzbaYAWcE/Q0mQYnOrBjLiDjMzceIQiSQSDOvHLVkYCvERtwve+ifbKd8clJ/HIS5hE71GioQQf1Rsal4VoKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4o+r2wDMxw3rW5ZvK8Q/Cj6vGlgk5qpR0cj3XmRMLQ=;
 b=My7mTYnuhfdxbMW3ja+EZ9HM1zIlB/34Qwsinb/HXu+LZeFmCZz16azw/3tDokKDV+ZP2aFw16TSfB/IvTpBbljL1iI6uzpqsFCh4IRFeK4nBu3xtBga3LHaXEnAQhgb1KXZFwl1DMModFPws1QkcxXc9Z1hPOIf10KG5TjjDzpOCluR6ZnoetHxhYTvwetv/HhHByeTojdXUiNwHLru95lf9WDK10F1urGxLAlWcLvbhNPNen+KmS2zDDLPScrePK5YRxhTuZXxTkcYHS5FonqzCGJhdAcGpOJYjj5+xjSbep54MErBFyBXwMQ/zFbrTn0fGA/CQmSMWpDXx5yR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4o+r2wDMxw3rW5ZvK8Q/Cj6vGlgk5qpR0cj3XmRMLQ=;
 b=PtMT/NNyooJUFBuUZtNOJDOoZ79IhqsUMDhyGPtBN1UhPnVKEVZgca+iT0qsM3A+/lK9wZMCF1Ru9lppR2IYR3Op+LhVoJMTC5xuQr0hvGbw9Jl45JfRgTLCWo8Rf63kMN4fi5kiN1mFcV/Bboz/wUWAJaXUIsjPt5xcWwrKXCs=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7090.eurprd04.prod.outlook.com (10.186.131.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Sun, 23 Feb 2020 00:11:51 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.033; Sun, 23 Feb 2020
 00:11:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/9] remoteproc: imx_rproc: parse early-booted property
Thread-Topic: [PATCH 5/9] remoteproc: imx_rproc: parse early-booted property
Thread-Index: AQHV5vbyD0uyt2f6hkqWNb+JRXycMagmNX+AgAG3jNA=
Date:   Sun, 23 Feb 2020 00:11:51 +0000
Message-ID: <AM0PR04MB4481882E603D1C83C637183788EF0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <1582097265-20170-6-git-send-email-peng.fan@nxp.com>
 <20200221215605.GC10368@xps15>
In-Reply-To: <20200221215605.GC10368@xps15>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [117.82.241.14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c536a0fe-03fb-48a8-f797-08d7b7f4fb7e
x-ms-traffictypediagnostic: AM0PR04MB7090:|AM0PR04MB7090:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB7090B6C2F6A9B86CDABB36D788EF0@AM0PR04MB7090.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0322B4EDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(2906002)(86362001)(71200400001)(54906003)(55016002)(316002)(33656002)(4326008)(7416002)(966005)(76116006)(478600001)(186003)(66476007)(6916009)(66446008)(66556008)(64756008)(9686003)(52536014)(66946007)(5660300002)(7696005)(26005)(81156014)(81166006)(44832011)(8936002)(8676002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7090;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2VUt0n4TGNql8wH54NmGE3OjzTOfogIxn7gehC8my6tVn5rEjbty8aDLiopnOkcN9xofsraS3RMcjqPg9eNsPexAjVTjJa7FZlcizo7Bg3f2JsvMWuDfCG4rXJsZ9ME/eHsslsxfjDuXxEAUUIpeolP7KNZGM754jK2F4ZmZ/9JdlK5Ar+ZrtdfxoDQqragLXpFezlmjnDpynRlEbnTfGcNT49vG20L2iZnYg4ulwB5NwkoDY4QksTVMGmGOhaDDUBImFYSuj+4Qn13chsYCHmyksZMDkYInWgHG+TGle/3sfeT/qh3x9WtXqo7E+lPG62P9Qir9+Lul8achEJrNobLO9HRLlsu2gqsItBgVTGFlnYHiOFgRRi01quU3DU93evvfznJpxnQ/ICx4sP8HYpx0SIaRsESn4QIQBofkZ1ngTB7fTBz7N0iVcK5YIZh8QaaKHoctLTk0PdtCe0ABls6weBE4S8e/LbslGusmHmcGLTCYvPPLz7d0NHVANv64/xBNkSIYaoM3n+rpPznPg==
x-ms-exchange-antispam-messagedata: zATgaAsMxHfe9CMz+YiogORXbaGMR2qNq3q9bP7o9IEV2txzgBnIN8JFKPFOfpklbBU1wTlEmxeqylPAu9l6nNWKUwku/i9lJGFeqNdRwVmCQ4GuRJRA60dN4n8Gkb4D8uR3rNO1wIe718V6q6n/QA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c536a0fe-03fb-48a8-f797-08d7b7f4fb7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2020 00:11:51.4200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXA0K82kth63PuivgoP6OuawyHMeLoraxNO+gemvnRkVVtCuSiBOoRXCmKxuUqxNqlwtWOi4QwAzHiAM7SARQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 5/9] remoteproc: imx_rproc: parse early-booted proper=
ty
>=20
> On Wed, Feb 19, 2020 at 03:27:41PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > If early-property exists, there is no need to check syscon.
> > Just mark early_boot as true.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index b9fabe269fd2..e31ea1090cf3
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -483,7 +483,9 @@ static int imx_rproc_configure_mode(struct
> imx_rproc *priv)
> >  	int ret;
> >  	u32 val;
> >
> > -	if (of_get_property(dev->of_node, "early-booted", NULL)) {
> > +	if (dcfg->variants =3D=3D IMX7ULP) {
>=20
> Where does dcfg->variants comes from?
>=20
> This patch doesn't compile, nor does the one before it.  I will not revie=
w
> another patchset like that.

Ah. Weird. variants should be variant.=20
See https://patchwork.kernel.org/patch/11390559/

I need wait early boot related functions in
remoteproc-core.c ready, then post v2.

Thanks,
Peng.
>=20
> > +		priv->early_boot =3D true;
> > +	} else if (of_get_property(dev->of_node, "early-booted", NULL)) {
> >  		priv->early_boot =3D true;
> >  	} else {
> >  		ret =3D regmap_read(priv->regmap, dcfg->src_reg, &val); @@ -509,15
> > +511,17 @@ static int imx_rproc_probe(struct platform_device *pdev)
> >  	struct rproc *rproc;
> >  	struct regmap_config config =3D { .name =3D "imx-rproc" };
> >  	const struct imx_rproc_dcfg *dcfg;
> > -	struct regmap *regmap;
> > +	struct regmap *regmap =3D NULL;
> >  	int ret;
> >
> > -	regmap =3D syscon_regmap_lookup_by_phandle(np, "syscon");
> > -	if (IS_ERR(regmap)) {
> > -		dev_err(dev, "failed to find syscon\n");
> > -		return PTR_ERR(regmap);
> > +	if (!of_get_property(np, "early-booted", NULL)) {
> > +		regmap =3D syscon_regmap_lookup_by_phandle(np, "syscon");
> > +		if (IS_ERR(regmap)) {
> > +			dev_err(dev, "failed to find syscon\n");
> > +			return PTR_ERR(regmap);
> > +		}
> > +		regmap_attach_dev(dev, regmap, &config);
> >  	}
> > -	regmap_attach_dev(dev, regmap, &config);
> >
> >  	/* set some other name then imx */
> >  	rproc =3D rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
> > --
> > 2.16.4
> >
