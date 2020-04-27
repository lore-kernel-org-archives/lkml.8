Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4632C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644DB2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="VjHrfyok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgD0LED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:04:03 -0400
Received: from mail-eopbgr1320115.outbound.protection.outlook.com ([40.107.132.115]:51520
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbgD0LED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:04:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R//XPh7VtNuLc/oqRqIQvth9vgM9BQaR1GST6AND1VWFI4k2rw9GykptU+STBguIB4dKcUhv1+5TrqjrYNFQho/dEAxLC/ezCE+A9BVsViSvCZ1Q+ZoIg7NST67YrvBqoTQ41cKhAC9Aoavf1QG6o8rJgh4jRDKeWFFwPDU3MiT3b9kCpMxxFjQtCDJqWvrULkqvRjOQjg0Wv2jMCMyiYPKwLdufMbd+npe+0QeIjaXyoJnWy8Nio8QDRKd67cV1fN+j7EuBUNli78gWfL541WWQiBcspOV3+wmOUf1dwRzgj+3l7rfNuP6bAfn1FUYxDHDLzegrRgDzVGOV4O8+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMddxCQ+4LqSk65dktj/74Jd/mz+bPz17lgnjD5fDDo=;
 b=d3lpibSkxhvjTyrtKQjUP8jMBwVuTCybvsrJPqeKIxRVfp+9nq6emXTGlm5CxyMMm6KCUCR7itHgvcoa2GW+t77Kg/QWbod2Q1xbtF7Vz9Pxe334ognG3qcul0DdEpLv5UYpUBkeYKiJyDxOyUZx6qymbIgXllQ0+kn2Ol4jk+cErJMKFuDS7qoraFbUOTogMWFL6jDBcRoLZVgkkL2+P/+nwAHWzjohNMxgyASzn60hC6z7r9TY0gcfDRINkBwtVfbX/4WT5T3PKbghTjxM5ovDEEgYR8i5O3FdnJUjxNdvgR957FHPjvo6EwWybJa/ah6T/ccTO99YfZHr6XSFaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMddxCQ+4LqSk65dktj/74Jd/mz+bPz17lgnjD5fDDo=;
 b=VjHrfyok7mmUyHBAvbZ//kolXPRz4afKx8lnMc8Drnyrny1nBbA0m4xHOUeg2XCZ5srMclcHsRYMujd2jYYBsuC/TneqKlRhZeMeUNWGZc4kGHGsicQDPSh93DIAX8kJbQN6ctO8SkAq3b+ZkMSu8IZCEtMg5iakgRNF/m5+t5M=
Received: from TY2PR01MB2924.jpnprd01.prod.outlook.com (20.177.98.81) by
 TY2PR01MB4585.jpnprd01.prod.outlook.com (20.179.170.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Mon, 27 Apr 2020 11:03:58 +0000
Received: from TY2PR01MB2924.jpnprd01.prod.outlook.com
 ([fe80::15c5:58a4:5913:d859]) by TY2PR01MB2924.jpnprd01.prod.outlook.com
 ([fe80::15c5:58a4:5913:d859%7]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 11:03:58 +0000
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] drm/panel: simple: Add Newhaven ATXL#-CTP panel
Thread-Topic: [PATCH 3/3] drm/panel: simple: Add Newhaven ATXL#-CTP panel
Thread-Index: AQHWHG0QohXUe8Vg/0OYS6a4UMIWGaiMplYAgAAKxkA=
Date:   Mon, 27 Apr 2020 11:03:58 +0000
Message-ID: <TY2PR01MB29248DC3123F2AFAE80005F2DFAF0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
References: <1587975709-2092-1-git-send-email-gareth.williams.jx@renesas.com>
 <1587975709-2092-4-git-send-email-gareth.williams.jx@renesas.com>
 <20200427084108.GA21216@ravnborg.org>
In-Reply-To: <20200427084108.GA21216@ravnborg.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gareth.williams.jx@renesas.com; 
x-originating-ip: [79.64.184.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6b195e1-0b1a-45f0-c201-08d7ea9aaf80
x-ms-traffictypediagnostic: TY2PR01MB4585:|TY2PR01MB4585:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB4585BCB2119C9E0E23333148DFAF0@TY2PR01MB4585.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2924.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(26005)(4326008)(316002)(54906003)(71200400001)(8936002)(6916009)(33656002)(186003)(9686003)(81156014)(2906002)(8676002)(55016002)(86362001)(6506007)(52536014)(5660300002)(7696005)(478600001)(76116006)(66946007)(66446008)(66476007)(66556008)(64756008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ql7LY9kMVYkBamB6r2vB0PvBczP/HbosXzdFyjppmpmLCbTAHoSodx1XkI4is5/mrtBe+T71IQl1XJqvu0wjshlbWmZT8ELr6bHoh4dfSF47Mkp5SCic0ge5qFBUN2Y3sbeW8iC9AnBsCR/2q5a7QdUzpQ7wEIw7ArvA+/iyzIan0P8V6zTCHGY6NmyTti3zmj3EVjCRv6unrKg7Drq4/3H0blbYyfI112m1ijCXGIbZiNTlIJ42jBPs8HdF34TX0R6EK1EjC3paNRoiuSBtt00/G9CqFSdAo2DYTp6M59Vca/Kzp7b8sB+dlt5aJ+pvEjNZ/YfYMCEUpV2DuLQShSogKMlIe246ymSzVZ8vJlQq6M+pQ5EqT+XQhEhgrjIwZ/pVPWngaKyc8w7ARlca+LnMek01e14g9KYFQBht4yAuTlm7zeU4t7h/5xmiyw0
x-ms-exchange-antispam-messagedata: g1d+iGzwMmfp1d64yFshE2WFAjpoeawRfr82QnFYdGlz7JJXdTg69E8ckZWZB4BRAowmIJs6qas6HyFst4N8mGlPe5qqY+z73Lg9AX0/3pomn4iZn85dfT6AVx56k8qb7WU3yKVSUegM9av4MbOyZ8aimxtjV7jnHHAhJh1roAXixC3b+2OMrftBmzpddaV0h47QqOLAoTxd8Wpxrt4CnLYcVenJGAsmYY7+PD+MB8tpivbyRNGL46ngg9vNcABUaOucpj/7KpNK4h1qS72xhYzaAlWEoyo8kzeVgJsfOSWhN1GOR3Rp3X9ocMQLtbeY3rQjoTwITr+JkCu9NinN9aX3qAf1bwRgGkbWdx5NBKbnZM4igqz8VHpuMzia40h5d3QphEFhGerAqqNggqM3WFC+6LTxbVOIBm2R3GfJIF3aHNsW/tAQXl/MvKZ2KpxoxPpjUvsn00+BAycJkN8dXTqnOK7a9/XERg83j9tRAQoyYrWF8ABwW8nIo0nSxD9h0RB4dTitEN2oCBm72nmvF4tZIzTxkcrERqnRmKyJTAyB9NH++Xf2Ufkv5KSwveBYzius6HTlodrGFy9LOlfzy0Q3o5Mhn/+I+WPX5g4jtfHOxAhYYpup2SiQrbAdZEX3x14Lr33UX/4WuyzL/s40UOeRPK6TjxPmqa15eeGMmqa0yG+ar18nBCYZuDr6weNb+TLq+qyQeOY0jlPnsaTnS23PzyXNqjtnn4ZydgoXFIl4qOGUq675mBcQNwOV8fHoRwUnM6U+d+wn77tkRTYgEkdcUXt0H4t1CCqxPjvXUSk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b195e1-0b1a-45f0-c201-08d7ea9aaf80
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 11:03:58.4729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcG++FN05950SV8hA2IbwyjBKHO0pSEDTOzj/dQmT2txCG9QydLPoR2VDbSIXRRzYGUuAZh/YX0oQ+AJ+HVy/WpRqGIfLosLOTFtWwZJiTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4585
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Thanks for giving feedback. When I send out v2 I'll CC you on the rest of t=
he series
to be sure you have visibility. My responses are below.

> On Mon, Apr 27, 2020 at 09:41:49AM +0100, Sam Ravnborg wrote:
> Hi Gareth.
>=20
> Looking forward to see the other patches - they seem to be stuck awaiting
> approval.
>=20
> A few comments in the following.
>=20
> 	Sam
>=20
> On Mon, Apr 27, 2020 at 09:21:49AM +0100, Gareth Williams wrote:
> > This commit adds support for the Newhaven ATXL#-CTP panel used by the
> > Renesas RZ/N1 Demo Board.
> >
> > Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 27
> +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c
> > b/drivers/gpu/drm/panel/panel-simple.c
> > index 5a93c4e..0b57b0e 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -2021,6 +2021,30 @@ static const struct panel_desc
> newhaven_nhd_43_480272ef_atxl =3D {
> >  		     DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE,  };
> >
> > +static const struct display_timing
> newhaven_nhd_50_800480tf_atxl_timing =3D {
> > +	.pixelclock =3D { 33300000, 33400000, 33500000 },
> > +	.hactive =3D { 800, 800, 800 },
> > +	.hfront_porch =3D { 40, 40, 40 },
> > +	.hback_porch =3D { 88, 88, 88 },
> > +	.hsync_len =3D { 1, 1, 1 },
> > +	.vactive =3D { 480, 480, 480 },
> > +	.vfront_porch =3D { 13, 13, 13 },
> > +	.vback_porch =3D { 32, 32, 32 },
> > +	.vsync_len =3D { 3, 3, 3 },
> > +	.flags =3D DISPLAY_FLAGS_HSYNC_HIGH |
> DISPLAY_FLAGS_VSYNC_HIGH, };
> > +
> > +static const struct panel_desc newhaven_nhd_50_800480tf_atxl =3D {
> > +		.timings =3D &newhaven_nhd_50_800480tf_atxl_timing,
> > +		.num_timings =3D 1,
> > +		.bpc =3D 8,
> > +		.size =3D {
> > +			.width =3D 400,
> > +			.height =3D 300,
> > +		},
> > +		.bus_flags =3D DRM_BUS_FLAG_DE_HIGH,
> Please add DRM_BUS_FLAG_PIXDATA too - as I assume this is an LVDS panel.

This is an RGB interface, however the manual lists that the rising edge is
being used so I will include the DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE
flag.

>=20
> > +};
> For new panels .connector_type is mandatory.
Okay, I will include this in v2 of the series.

>=20
>=20
> > +
> >  static const struct display_timing nlt_nl192108ac18_02d_timing =3D {
> >  	.pixelclock =3D { 130000000, 148350000, 163000000 },
> >  	.hactive =3D { 1920, 1920, 1920 },
> > @@ -2964,6 +2988,9 @@ static const struct of_device_id
> platform_of_match[] =3D {
> >  		.compatible =3D "newhaven,nhd-4.3-480272ef-atxl",
> >  		.data =3D &newhaven_nhd_43_480272ef_atxl,
> >  	}, {
> > +		.compatible =3D "newhaven,nhd-5.0-800480tf-atxl",
> > +		.data =3D &newhaven_nhd_50_800480tf_atxl,
> > +	}, {
>=20
> I did not see the other patches - so this is maybe covered.
> But newhaven,nhd-5.0-800480tf-atxl must be documented in panel-
> simple.yaml before we can apply this.

I will include a separate documentation patch in v2 with you
on CC for this.


>=20
> 	Sam
>=20
> >  		.compatible =3D "nlt,nl192108ac18-02d",
> >  		.data =3D &nlt_nl192108ac18_02d,
> >  	}, {
> > --
> > 2.7.4

	Gareth
