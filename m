Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7CDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB29F206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MiXGw9Dj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgFWHG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:06:57 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:35474
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730781AbgFWHG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:06:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jbm534/kLo74VPGBFisST7ZGwrs4ITFyikI4qfKq1rTOHDmvvusz05OcEUM3HRQijm8Ms8FjlelM30x0erLyOakueqC4pAJiPg0a872JTYyWlKrzJIvlu0hXTiK3KLSGUbX41a6HzKObfmP8Hb2m5mpEbAtOSNXrxYZ71mzECg43V8sOOC9yRZFBm40UnZBjijdJS1th5D+3IK2x5X8w/p/DJ+y4Z3QIwfYNWDIste2UZjvs9++zcyWVsH1yJb79GyZFB/N1ckpvahL14Y2Mmgcb83+UO2YfLqOQ9cy+cxKeFrNjgtdbgzpR6HahQw/FN1ulOebX+0hqxxIWv6O6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDClRvSOW34Ay+DMRzXqBG4Owcpb+/SbEXKnH4p0tXE=;
 b=S0ZX93Jkw0Vgiku6z9buE6QegIEYbM5r2ZpdeWBQyW585bRIxDEEt5KUBdh52BoLiSQIpleNb9GfqCKurGZmp5qZaj5h/wigRam52GE2XkGKvsKZk3nctQo4wEUlzoGcAkYCU1cRnZlmtdwJav+nDCaR9e/u2wmD2M/saGq9bzyl/tSNPb7KeP1exWDzctGw3x0sb2HlqX8WaP+DS+NWjucdgqfo02mNfJCBa9VcEGK9aHnm6RMdUlG6g6mLK9A4tTX9kaKXW6b9+iIfGLCGpSsOARKde6WNAXLBGG1GjNn7X9ImFvcV7+XfpPMwYRVrv5mJUw75QSPtnUqsTJ2HUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDClRvSOW34Ay+DMRzXqBG4Owcpb+/SbEXKnH4p0tXE=;
 b=MiXGw9Dj0mkplpoq1703VntW/ThPGL9ir22qxXNiIawpaO4g6FF27MgHmj7iY4tWTosejSJAT409V8pGRnWcU7j6Ll1E21l9wUexxRzImJwgz2u7MXb3auq2gcxMVjJgGtKfEPMJKd+Z266fesv6MQf1PdO4km9SWzCDju119SQ=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2711.eurprd04.prod.outlook.com (2603:10a6:4:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 07:06:51 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 07:06:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/3] arm64: dts: imx8qxp: add i2c aliases
Thread-Topic: [PATCH 2/3] arm64: dts: imx8qxp: add i2c aliases
Thread-Index: AQHWN7q7FzxDRlKvSUqllYWi4vXJsajltQcAgAAz0OA=
Date:   Tue, 23 Jun 2020 07:06:51 +0000
Message-ID: <DB6PR0402MB2760A7116D8743792570BEE088940@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1590977180-9957-1-git-send-email-peng.fan@nxp.com>
 <1590977180-9957-3-git-send-email-peng.fan@nxp.com>
 <20200623035615.GN30139@dragon>
In-Reply-To: <20200623035615.GN30139@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e27f3640-e854-4b7d-5b62-08d81744013c
x-ms-traffictypediagnostic: DB6PR0402MB2711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2711D842204E22E271379A2988940@DB6PR0402MB2711.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMCu7veLhQElnMjZCkCP9DruPjgEwfTMCNS4TgM+gYFkNAslH/zzytR6j2URidFFX0RMYmXSAbBAvcKYCuZZwVD0Y/g84NpIYxT2E6wDZViTKjvM68TN4x1JhsY0lHTveOU7d9XeEoZI3tzuKc6hIC2BA43Im1HeiTFqYI1eDuqvVjHGfWJgFFNCdeiYLwSEOdlzqcPOXgTAJyYdSg0BPQ1iZCWye88gaDGaP5iCbta+aiiUnhlfSgGcTlCXrUrWCkwjn9SqYofMsQdSpsaWfbve3UZt8wo7XwJxZoNbRSz9BNvPsBjpbiCGG5X6xH/6apQNpS5ds/gWCfpEzxZIvD/NE8myYOlNs8P9fwR2vQM73HXEK2VokgzzfIUZMpcc9SsUi0wwwXujQnkJxvH13buz2H8FRfqUcp+wvtmW0A9fn+x3DqOcDMdsfTa9XlRbWm70+YQ+JZt9G5BGjuFQbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(76116006)(26005)(6916009)(478600001)(52536014)(5660300002)(2906002)(186003)(54906003)(33656002)(316002)(8936002)(66476007)(66556008)(64756008)(66446008)(4326008)(66946007)(44832011)(8676002)(7696005)(86362001)(83380400001)(71200400001)(55016002)(966005)(6506007)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 3vtIbllHpOsAXkruIpXZyYV3O6IDJtTy/xSL9ehTRY168tIV0MOWzkmTm1PLdcQZ2DQiL0E3hVpnU/DzE80/bpVhUt11YMKQThujuwdH0GQ+ooVh5GVQUgJm/7rSeHLN7kHwTW8ECiZr26jmXZ74fCd/yYUlQc0jfxVPHTKywD30gAi7g/wRRR21pXfLoP+aolyT9w0sJi4woN0ZsDGtMEicv+wBSwN6hhQ4VdVhY2yLkoUgQp1mH67NG2UeoYrS0HcZSVWdkE4W9yckCaR3x7tPnZLk5mTHfr9kXCsj5tUVwvM2MkX2v7HmiA/zh23VvljsVFjXdUTy27KprskgMryKUdDlU/S1f0H0CTlMBZFRplKaiR+Cd95EwrYryct0cdkz1t78hjUqrY8u75zgni//0xjqWyTZkdof2EnMZrfoBdlFjcTP9uaW0EUH+NmV3rBsOmclNVcy3N/3RzEQuicmD76H6NfvPShGO0IGqqx1USChss4bcIMoEuU+bhds
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27f3640-e854-4b7d-5b62-08d81744013c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 07:06:51.7453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ql2BLyCclsAQk45mN/3G5rBBSyc//BjJKpG5h+eUEDCQqT3peztHfaBcWRDSCstKI6kz/yk/sWXHgom6HZHicQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH 2/3] arm64: dts: imx8qxp: add i2c aliases
>=20
> On Mon, Jun 01, 2020 at 10:06:19AM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The devices could be enumerated properly with aliases.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > index 33363c127478..8ce997110cd6 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > @@ -19,6 +19,10 @@
> >  	#size-cells =3D <2>;
> >
> >  	aliases {
> > +		i2c0 =3D &adma_i2c0;
> > +		i2c1 =3D &adma_i2c1;
> > +		i2c2 =3D &adma_i2c2;
> > +		i2c3 =3D &adma_i2c3;
>=20
> Had a second look.  It breaks alphabetical order.  So dropped the series.

V2 has this addressed.
https://patchwork.kernel.org/cover/11619867/

Thanks,
Peng.

>=20
> Shawn
>=20
> >  		gpio0 =3D &lsio_gpio0;
> >  		gpio1 =3D &lsio_gpio1;
> >  		gpio2 =3D &lsio_gpio2;
> > --
> > 2.16.4
> >
