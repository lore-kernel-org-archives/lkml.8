Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABD6C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107E620714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="XOffpXz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgG1BOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:14:31 -0400
Received: from mail-dm6nam11on2125.outbound.protection.outlook.com ([40.107.223.125]:6817
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbgG1BOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:14:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLeYbOo+nFtppkOtw2dDv6YyRbbARFTSOvYhvZkjGyLeyfj287a+4vfEVj4P+oeiKKXaVwidrymSwu4+nOJUgfZysTCrvgnnYLEqFkM7iDyJ5gIfH4jAqlCHpx1kRxxa12oSYi+ThFPx6p8ENgI+/EIrlwHh+FNz4RstlrBasqowCnZZXGM45iEL01nFGrge0KcxXcudaZO5sBf7jdjdehnM26+qHPZJJXA9/1QZk8f3ZWe5Lh2sA89jSEyeIuPbEpgyu/IcpTiNl5H1rcmMmOQtpshUP4OH47XaIpq//pC6XS6HAEHJBDyyhKI79xiFJrcIsxIW2a4MGwvu2Fxytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB6ivvkGztVHVgGQL9IA+uKRfrQcij6LNzI0zGta7uM=;
 b=MKqvj/PeoVS/nLWktrbQFqgOyZTOGC+dErynfY95C1f7VM5q8N+CJb4thEPMP1rTtyuT+x/y1WJYfaYeEp1VHzk/ly8IDhC4Xgw0HLnSGil52U/IlhdAXFmNc23dUMFvODy6tLMU/75W62orrMDIt0iQFTOwQvDj1zihhbR/rROvfEysaR4VuWLWWJ4wJrEyQr/47mEYY1KI746kBf/9GQBXhGUbAdw/U/3B4XqbrlxGx85pjHzQpfneiLb1WYxkpfijHSuPLr2uVf5O4pYMvyyXZapsrf5mvVhZQXxAAev3WqLihA85ISxnVAKIag9dMaLdEEj6DbwJh7uVcDQx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB6ivvkGztVHVgGQL9IA+uKRfrQcij6LNzI0zGta7uM=;
 b=XOffpXz6GrxmrEv1gARZJGmnn0yXUth9dO3MWiGLLeq5Ux+XykZhwLNZxxBIyYWnrJ0hoXWo4eohiuF5vts1p5I5MawgESoUj3ltrsJYRzyERgVm2LBsjXLqRPuYFZJPAzJG7dKDyjUdIwVbQ/xLFEg7gtTKLW+NmUgqGrmbxVk=
Received: from MWHPR11MB2047.namprd11.prod.outlook.com (2603:10b6:300:2a::12)
 by MWHPR11MB1295.namprd11.prod.outlook.com (2603:10b6:300:2b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 28 Jul
 2020 01:14:27 +0000
Received: from MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::d9e8:a3eb:4f08:e795]) by MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::d9e8:a3eb:4f08:e795%5]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 01:14:27 +0000
From:   Steve Lee <SteveS.Lee@maximintegrated.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "jack.yu@realtek.com" <jack.yu@realtek.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        "steves.lee.maxim@gmail.com" <steves.lee.maxim@gmail.com>
Subject: RE: [PATCH 3/3] ASoC: max98390: update dsm param bin max size
Thread-Topic: [PATCH 3/3] ASoC: max98390: update dsm param bin max size
Thread-Index: AQHWYZh9qD+EsXpBKU+c1fLFOfcsSqkWjXCAgAQirUCAALp7AIAAyxUQ
Date:   Tue, 28 Jul 2020 01:14:27 +0000
Message-ID: <MWHPR11MB2047D0064F1412305176322492730@MWHPR11MB2047.namprd11.prod.outlook.com>
References: <20200724085644.9837-1-steves.lee@maximintegrated.com>
 <20200724105059.GA5664@sirena.org.uk>
 <MWHPR11MB204753BF80DED8923AD3BEA292720@MWHPR11MB2047.namprd11.prod.outlook.com>
 <20200727130734.GD6275@sirena.org.uk>
In-Reply-To: <20200727130734.GD6275@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=maximintegrated.com;
x-originating-ip: [211.35.184.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d490a7f6-bfdd-4810-41e2-08d8329392a9
x-ms-traffictypediagnostic: MWHPR11MB1295:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1295BB177D7ED6DA6CA0224192730@MWHPR11MB1295.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gti4Hzs8/YZHsd9+RFwx2Uo2ziG0J3kE4wyLN6imkAA0I1rFzGsQOZT7U//XvbeyZAa0RaS2uhZjQJMmE0ub2dQoaGzHwE+mgJrC3OtsO55/QopFipjpA6hUgwWO5vSyxMchfWxr42JETJpN/wOQ0SZVR0vqSftii3IiBre0YlA67UFWU4vldi5ljikx+j50fMKNlXEK37BJEvvUPvaN0d3VL17QHnQO+EtEGGMITObFUugtwjEuHnXqMAa3Fyt0MN9f4snS5Ru4hPWE6XYOB9ZlbXjpLrojEaC+7BcJ4uyf2pJMIoXlPZ24jC6VTe2/f9wKaS0MFZbhYvcA7E5UnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB2047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(6916009)(8676002)(53546011)(186003)(83380400001)(316002)(9686003)(15650500001)(54906003)(4326008)(33656002)(2906002)(6506007)(26005)(7696005)(478600001)(52536014)(76116006)(64756008)(66446008)(66556008)(66476007)(5660300002)(8936002)(7416002)(66946007)(55016002)(71200400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: f0//Rl1QNRjZwOPOdX7a64f/CGs4IyfuOMJ+Tg/KByJd5kyYM1NEAcWRPrQsL4eMn+KGKgMRps7KZst5QAiHqEXEQnfZkK5wcJzFIpK4ypX19fi7GoCvNzl5kfoeiEGYnH3i3hmXU495dq0UQB7ki6rHl4/uyVm2DcuV0Izp4T0Ldfm7yXqUo1zcWkAYU8YU7GONXlwaRmN+hMLEMDEwEzNCYwg4QUlfZdqBzfZfp+1z5tzh5T5oDiTCCU86GdI8jgPfHhKsup81JD37d6QB8JdYJFGgeHJ/SmRqdm5xfjGW1Njtn4pIBQUOiuSAUs/qCzKxoxeyMm3TrIkfJxxv9S0ZrlNjct/Gt0aYq62/XESYNrHjfsP53HdtPjh4u3BLTbkKBAwzng4nsXSv9icqsA9nZ6kkHZSnqOX74h3qEJHMepiUPOmn/Q250OeCwPoPIX49o8P/Wl5o5ablp4ysf7fzYw7+FK/BK1QkzynIvdcoGXpSSVKthmNlqka8+Vjq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB2047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d490a7f6-bfdd-4810-41e2-08d8329392a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 01:14:27.2873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IgmwCO7L+LDvE/uYexJHDRsVltStOzKWQ7gmDsCCJ2jiJZbBeFW8E0+rjsdXXw8bPl2pDXcWMUWXw1Z/n74oUsIuiLgeYEI6gxeiC2LR/Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Monday, July 27, 2020 10:08 PM
> To: Steve Lee <SteveS.Lee@maximintegrated.com>
> Cc: lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.com;
> ckeepax@opensource.cirrus.com; geert@linux-m68k.org;
> rf@opensource.wolfsonmicro.com; shumingf@realtek.com;
> srinivas.kandagatla@linaro.org; krzk@kernel.org; dmurphy@ti.com;
> jack.yu@realtek.com; nuno.sa@analog.com; linux-kernel@vger.kernel.org;
> alsa-devel@alsa-project.org; ryan.lee.maxim@gmail.com; Ryan Lee
> <RyanS.Lee@maximintegrated.com>; steves.lee.maxim@gmail.com
> Subject: Re: [PATCH 3/3] ASoC: max98390: update dsm param bin max size
>=20
> On Mon, Jul 27, 2020 at 02:00:09AM +0000, Steve Lee wrote:
>=20
> > > I'm missing patches 1-2 and have no cover letter - what's the story
> > > with dependencies?
>=20
> >  I will re-send patch ang please ignore this patch.
> > DSM init param is extended to cover more register so that DSM MAX PARAM
> SIZE value is changed.
>=20
> I applied these on Friday having found the other two patches (you're not =
sending
> things as a thread so they get lost, for example if someone sends a big s=
eries at
> a similar time like what happened on Friday) so your new version won't ap=
ply,
> please resend whatever change you want to make as an incremental patch
> against current code.
 =20
>=20
> Please do not submit new versions of already applied patches, please subm=
it
> incremental updates to the existing code.  Modifying existing commits cre=
ates
> problems for other users building on top of those commits so it's best pr=
actice
> to only change pubished git commits if absolutely essential.

Thanks, I missed patched was already applied. I will send patch upon these =
patches later.
=20

