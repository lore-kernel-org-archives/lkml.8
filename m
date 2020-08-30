Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110B1C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 22:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9FDE206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 22:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="b9zWS31Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgH3W17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 18:27:59 -0400
Received: from mail-sg2apc01hn2206.outbound.protection.outlook.com ([52.100.184.206]:52000
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbgH3W16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 18:27:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFQLnHhKBHAOAYZNvJOPnEEKpGE6RSzznifbdu9Dvtpk6yAWGGIqPiH4WFm510GIDOQCjY4CXrcHV8CHIHgsWhzXGAF127Ubxf2eHwZ9f/qsH7Vm5iT0HIxMGodZ2Q+LoSIGXwqiy8ZFT3ZLpdIBgkRta0Kn888+qaF2wGxbP7usK7oLmOYxjcVCfxr/UvWOy8Wzt9dEYpLJfZnK1T/pIjvlmZGPXbMs21bZYWz4ZnFMHiLc27V0Iz//B0kyQQnuRsn167FqmiPtRp8tLSe9RImvcu/wWZmG/c2dDhFmBX2Knb5jlt7DIWEXHER3IjX91zT6YW5Omxk4BvNPNfi7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgHQGB30eWszS15dxREs5CyErva2+jMVYN5kRQh0+/M=;
 b=Oq0GDXilnlRdbUtwPrD+ourjvUgUiGCu/0QqnbM7ekvOHX2RSmGn00UIF17u8DxJ7HiihryZH1QNWVgpMCa/nYQBffiGe+CDA0w8cwCqPRETCSWOed14O668o3yG/z88DeLDHVm8AvsS0InxC8SBwwE28EEAG7vfD+ovHvkRIzTz7/8zN/y6/dKhE3uRmalrMzR48SThsSlZxiJsltBZV2ukNnE/eFbRmq1SXvXOq6cYsFNZlmGXMSpOmW5X18L7MMF+JwBEV2yoNcWCqF7Mokv4KXTX7//dCwNgIqzkPf55CwIpTYzUzHBr2fGRbjRr5htFyKPk8j/bNjdLUb2plg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgHQGB30eWszS15dxREs5CyErva2+jMVYN5kRQh0+/M=;
 b=b9zWS31Ycpmm9H3vJfC2cR81j41LSPVUbs06sSUQ9jFIdyzpsrY/y4BQufCic3Jm/YiMkqJ916kdT8vqKdltBZIZgAAm4IRzri+rVIrrQ+qu5WlycgYrP+orbBMsUfqoeaT4SxWVcCiMTi2FZ6K6P+GbY1eP+a4uh25GMTCWPVM=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB3771.jpnprd01.prod.outlook.com (2603:1096:404:de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Sun, 30 Aug
 2020 22:27:18 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3305.034; Sun, 30 Aug 2020
 22:27:18 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Qian Cai <cai@lca.pw>, Muchun Song <songmuchun@bytedance.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memory-failure: Fix return wrong value when isolate
 page fail
Thread-Topic: [PATCH] mm/memory-failure: Fix return wrong value when isolate
 page fail
Thread-Index: AQHWfqVM3JSCQxmTuEa2NoqeFTKL/KlRDpsAgAAtigA=
Date:   Sun, 30 Aug 2020 22:27:18 +0000
Message-ID: <20200830222718.GA23542@hori.linux.bs1.fc.nec.co.jp>
References: <20200830081053.64981-1-songmuchun@bytedance.com>
 <20200830194417.GA4039@lca.pw>
In-Reply-To: <20200830194417.GA4039@lca.pw>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lca.pw; dkim=none (message not signed)
 header.d=none;lca.pw; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab921a3c-9930-4b46-1488-08d84d33db29
x-ms-traffictypediagnostic: TY2PR01MB3771:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB37713C1EF1649B788674C1C6E7500@TY2PR01MB3771.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:9;SRV:;IPV:NLI;SFV:SPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(55236004)(64756008)(66476007)(66556008)(54906003)(5660300002)(76116006)(66946007)(85182001)(26005)(66446008)(110136005)(83380400001)(86362001)(316002)(6506007)(6486002)(186003)(33656002)(6512007)(1076003)(8676002)(478600001)(71200400001)(4326008)(8936002)(2906002)(966005)(9686003);DIR:OUT;SFP:1501;
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X1l5yUMhWXqU7GeOHiAObzunlG9T+vldJkvul92Qd0GIgn3BOUWGncd7xZTL4pr0b1PFc6UhrTys2rLqO3r3mM6xo9w/05MV7stsdaOWUby2qRmeB424EwEbTbzFh0IH+n+Gg72cWQeAx53vb8Yv1klQCTLcZYhpmXcJncWXnApvDxEotyp5GL7z3iN2IPzFj1iuh3tRCLvOvMPQMpqHy9KWQEWl+9fZDjElcQRbUnduUPAEKR9btmkW7ufY0ou2L4LiO4lJjR/gcrwqDMQObuIM/NTabnWMbRNGud0zN3XBWvxIZtryCjK25rZIuFW1eqomJrHdzuEg/OIGfAOs8hifiHb02PCnN7FWgdbmgncWo2C87kf55hlhMP6u33oaBwEpDbcMOEBAxOmbZ3CjqxTbpNVY62BWO2WVMqej/3iv8+xC2Yse4ulRB3tkVCDza2zxuS/MeWVRiXwim0BZg/J/FW9Cy43BAj+v/hN+w0Zm2DUBYd5PdKmFrNtM1CPdPD4c/mG8J4nR55+SUyNHfn57iR8HQlj9j1F6xfovqpl4FBylS3CgqP+6O/diyexc6qoP9e/eGRXvG2US8HsrAPe9cwuZXekTuuZcXjm7IZ+TVnl0ckiNU7hHB8pNfIeDGo6Ek2hv6aYhJyTTOHgW9ywpop4dr6D4RgQCm/aHOcjuZh7X9GhMUNG7lnvmHbmmk//SrPuDiH1yjWywvik84wDTCeNjK35nQXieq4YpsKceFayA1zfUj3w0mFFJq4h38t3K4PsvufewmRIUgxbWXTIuwY4HO6fRY7BRgJU3yPUr4oX1y+KtXnqzVoRIcFSskSpzXdHFzaCOKYA3YqAkO/CXv3OFhhbEz2nLaF94oljzF3U4jeFKpG+gP7AXAVZvnM9Ciy9ZKdDro8Nm0V+IjQyZMZrQO3rlD6/+2UbTTs/SbPZb8p6yg/1bkKry2s2m
x-ms-exchange-antispam-messagedata: EwqAmNXJtkbJaUNdMjj0TfLCpS7pnGKmY6iXm18VmQPb7u5gaK7dQsNuFwWh1uuz5L0cs1mzCwg5BPM3Zn5QEitkp77uZIRbcVh6umiNNPvs8rr12fPx6C0TZHbys073dJ5zGc5+431Dy0/EPk4rri7xvOMZvashgtyVIZSg4wPkGkOblt4M0HNTW33Ox041b7o7uxTq2Mg8Pi1do+qGysEwb0It8R+joNCUt0tPgOEOcu2diCo5F8obJ6N+o7Y7rrNnlfTc4PB23IBDUJgN5czHjTYru8r88n2lp0L4RNoXOi4f3DHbZqZ8t5apYqaiWX3MgwyzzKwVDxvF7pncHid5ImWHv4OehmFrVxg9cdqKadIjKmPm84ZeJUGn+l1e8d10aBzQY54pWgXh+h7PDcIRNaFIooOqmxk3Fi/chOQ/Z6gm5aTAq45jTbvZg2FgjNtb04CHQnbeNtcadLdrAB1jAZZekGvoBBs1gydkqIiXywXqk0w4PGw/8/zLOmnkrWXwANTEirBFdO2VTIXWHmB2Rq5dJ2wSXQLHlJPzh9i6O4wVIYDBwo4CQp2IxdY/wubjztVvynYfeeUTmTg5H59rrx2kgoN+xJIOIdJ9TMa4o2aAlfUc9yhDch8LHhWYHsG6Cq2DGl2ADoScLzbB+Q==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <77168D14E0092B48913FDB3A9F8F4D09@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab921a3c-9930-4b46-1488-08d84d33db29
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2020 22:27:18.8088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZuypFXZuNsTCpOJEQ+9LUsleakTADHXbMj16DcprUHizB6VHotUi9+rTrWh69fe2xUJarZspDqwbtADtveonhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 03:44:18PM -0400, Qian Cai wrote:
> On Sun, Aug 30, 2020 at 04:10:53PM +0800, Muchun Song wrote:
> > When we isolate page fail, we should not return 0, because we do not
> > set page HWPoison on any page.
> >=20
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> This seems solve the problem for me that madvise(MADV_SOFT_OFFLINE) will =
run
> into ENOMEM eventually:
>=20
> https://lore.kernel.org/lkml/20200811220643.GB39857@lca.pw/
>=20
> Reviewed-by: Qian Cai <cai@lca.pw>

Thank you very much, both of you!

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

> > ---
> >  mm/memory-failure.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 696505f56910..4eb3c42ffe35 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1850,6 +1850,7 @@ static int __soft_offline_page(struct page *page)
> >  	} else {
> >  		pr_info("soft offline: %#lx: %s isolation failed: %d, page count %d,=
 type %lx (%pGp)\n",
> >  			pfn, msg_page[huge], ret, page_count(page), page->flags, &page->fla=
gs);
> > +		ret =3D -EBUSY;
> >  	}
> >  	return ret;
> >  }
> > --=20
> > 2.11.0
> >=20
> >=20
> =
