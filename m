Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5806C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C22D20724
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f+IC/xra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgBMDPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:15:25 -0500
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:51227
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729378AbgBMDPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:15:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyn77o2stjkIQH+UToHBiwHSrINO0IIOnQE3b79e+uKploBJ7Jd7edMs2llAhXOUIHCG6+knAwHWluERk6uMYhFXVGU5E8Bm0XUIivQKHctiZku4FWR2g10m5xyfwnjdIKfqH/waAvuF4Vm31T4sRXxZr0Da0H5wQVXjVIsy61hoUvvlU/jiX1kHCb0vA999TeMhT+yde96gAJDREF/B5H8/tNASOZ9Rc5vk28ADuwgrMGwHTB9Qzwi1Ql7pPURQoaFM4njj/yRggcoP5EfubDVJ4yVw0PMM2Z5PtjM87OD3XrS7huLBRUXejO+LTJieNzbCdtdQQR0WeXS7KY2v7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08Ys/QhSybmrSQZcy/33cBBL4g9qOVd7VJRQEQj/VHQ=;
 b=h/G73JNzofOQdnJK6GANZa0MAEYHb/R3nlCc4th9jytaa4pxjPAYb9kDik6k0N+WAK1tWcPkPL/yL5AgY98XxIJe5Bg1AC/KMVRaXF/VKDHMotTKQFNveDSAtXFjZ+RCKC4HP8V7mxvo3mkvJytHmBnKzwa08/3jljNTooLSlkF/VDqgV3eCwm//Kqfum64lnvjBh6kMvnV3t90tFzLPpHRoEvUGgs/hZi++jOSlTXmbhbstJHHpzELmZde+NoYaiYufcm8XStYJukmkwfgzZ8wsx+G60ooJ3pprLfh3zrnMhRzayrrx4K/+NbD88laqE9l5wKtWJYJXiuplH6DfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08Ys/QhSybmrSQZcy/33cBBL4g9qOVd7VJRQEQj/VHQ=;
 b=f+IC/xraBDWeGqV3QpTK+QFmOhXNjPE0ML6dd2OByqtXqFsEs0JHWGPAJoCS9jw8Fkm6O853fm6BATQrxfMF2xrAxblFnVWYKNxnMCQJkVYLfGvK0LrhJGVmRDl7RNONizogdYRMpQm/R6DxCNlHly3XHCFKTl0SC01wKR4Vl24=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5282.eurprd04.prod.outlook.com (20.177.42.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 03:15:21 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 03:15:21 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] ARM: dts: imx: use generic name bus
Thread-Topic: [PATCH 1/2] ARM: dts: imx: use generic name bus
Thread-Index: AQHVzDd9dofq1wixmkSbfSHsuEOGXqgYlUCAgAAJbaA=
Date:   Thu, 13 Feb 2020 03:15:21 +0000
Message-ID: <AM0PR04MB4481DDD5A9B9A9B9ED0BB4D6881A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1579156408-23739-1-git-send-email-peng.fan@nxp.com>
 <1579156408-23739-2-git-send-email-peng.fan@nxp.com>
 <20200213023330.GK11096@dragon>
In-Reply-To: <20200213023330.GK11096@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 181f296e-1b40-4d5e-a67c-08d7b032f605
x-ms-traffictypediagnostic: AM0PR04MB5282:|AM0PR04MB5282:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5282828EA571B895A5486A20881A0@AM0PR04MB5282.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(199004)(189003)(52536014)(5660300002)(81166006)(8676002)(7696005)(66946007)(66476007)(66556008)(64756008)(76116006)(66446008)(9686003)(4326008)(8936002)(81156014)(33656002)(478600001)(44832011)(55016002)(6506007)(2906002)(186003)(86362001)(316002)(26005)(6916009)(54906003)(71200400001)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5282;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WFiqDaAPB+XgUMVd1fbngPuXEzhyb5GzpGcuG2/kbeKvJJASuPyZjATDZ80WJNHIDFf2oF8az7UmKx7PPm/J6e+2mh6CQs96VeC5P5j/ornGjDsCX1OWYG1AmUHfxp0sUXtazJ9Yb7x1/nTn87VidfS3s8NVZQi2w6VWOrI1+PtuICxEYcNBnW9+PITf7MRLBhb3iRbUr2FuiPgDS152NNI8P5hmrODVJUBqqtHUbAzDmsblBWtVYljZYes6sWO4cjncSJljA9+BfEcTZa6Q730xh3v0kNK4Sm2EY30ieJXtQvdkp0ar6XMHsad6qK9puHyzOw+/wqA2bbmNWxtJNgY1r8GKRLAhmoN7IHFvUjka7hTJnfZHiQbdfOtPuSCV70U0vm7ZfYL3G8Ns98vpQFTfr1gx5++Fnhc45cLuigFJPIO5YO8/ZxgbJB2TSHkZBEiNS2vYhLja7h1+Ogd/rnlnfZC4C01KKgFbPyKMd92KzTsk36J3bJoT5Qzfwkdm
x-ms-exchange-antispam-messagedata: wjrMhGxhu7oFEmZVKyjVZMB/gc8RQrgvGk5MTH0kfgDMq95om3WCyRQbkneAyb+kweoGN28TyvcgnGQbMm2/ACTZtEVw9yaHTP0UCx+KDVgeseNsQA1JcxrEygKSyWcDaT8DUt/w24Kg6RYO/UbziA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181f296e-1b40-4d5e-a67c-08d7b032f605
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 03:15:21.7533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpSiNqDBrtDjHlAjgEtMaSwrWDDCfjFVGX/FC1dNNTIEhsp4qsSk6mIt1h3kCsJuf1avpyxKKohdTx+DamPrsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5282
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH 1/2] ARM: dts: imx: use generic name bus
>=20
> On Thu, Jan 16, 2020 at 06:37:57AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Per devicetree specification, generic names are recommended to be
> > used, such as bus.
> >
> > i.MX AIPS is a AHB - IP bridge bus, so we could use bus as node name.
> >
> > Script:
> > sed -i "s/\<aips@/bus@/" arch/arm/boot/dts/imx*.dtsi sed -i
> > "s/\<aips-bus@/bus@/" arch/arm/boot/dts/imx*.dtsi
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx25.dtsi   | 4 ++--
> >  arch/arm/boot/dts/imx31.dtsi   | 4 ++--
> >  arch/arm/boot/dts/imx35.dtsi   | 4 ++--
> >  arch/arm/boot/dts/imx50.dtsi   | 4 ++--
> >  arch/arm/boot/dts/imx51.dtsi   | 4 ++--
> >  arch/arm/boot/dts/imx53.dtsi   | 4 ++--
> >  arch/arm/boot/dts/imx6dl.dtsi  | 4 ++--
> >  arch/arm/boot/dts/imx6q.dtsi   | 2 +-
> >  arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
> > arch/arm/boot/dts/imx6qp.dtsi  | 2 +-  arch/arm/boot/dts/imx6sl.dtsi
> > | 4 ++--  arch/arm/boot/dts/imx6sll.dtsi | 4 ++--
> > arch/arm/boot/dts/imx6sx.dtsi  | 6 +++---
> > arch/arm/boot/dts/imx6ul.dtsi  | 4 ++--
> > arch/arm/boot/dts/imx6ull.dtsi | 2 +-
> >  arch/arm/boot/dts/imx7s.dtsi   | 6 +++---
> >  16 files changed, 31 insertions(+), 31 deletions(-)
>=20
> We may want to cover Vybrid family (see vf500.dtsi, vfxxx.dtsi) as well.

ok. Since Patch 2/2 has been applied by you. I'll only post v2 for patch 1/=
2.

Thanks,
Peng.

>=20
> Shawn
