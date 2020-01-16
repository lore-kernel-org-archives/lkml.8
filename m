Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE94AC32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 00:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94805206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 00:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="CSg3DyAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbgAPAJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 19:09:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:54523 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729186AbgAPAJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 19:09:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 16:09:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="220195805"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jan 2020 16:09:46 -0800
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 16:09:45 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX158.amr.corp.intel.com (10.22.240.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 16:09:45 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 16:09:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnIQwOUHy7u5j4bQuiWYzz6kTtj9zc/CgMvESur1m8zqTESphvx1uEWFMrzbU3ibOBxdZGersE1qslVYZ0jPXn4RB6TIOkgVooeFQikBRyLe/vLIHRpJqA/LvRKfCTJ16BWaKanJnnqF4co5P0bIfpfvpjhAkJnUDRwdAzy9WDCURjS0SbUGLKzxIbfLLr0eRHaVhpLx26oOTlsIh6Hs6Uw/mqvwYA8w+dbtXXRAbGfE/0y0zvovq0/7dvsh6xyqLiWzrNGJCRk1KeYiPzho4QTGCANLT51BycptR6BihYDMPrBSfkCO6EAq1h8Os8QYj48EXB7f0763rDWwM65Ing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aE8asw6ittTKb4c1hbNh0rKZ2yCLJKKOhOQDWsDIuGU=;
 b=MP/cU+mPlfsHTsqEh2fuhssu1vOVwmIZYPxnARW9naOMFmLCsKuGBGqL4madVboYtfToUg4XOQL3QxN3Tl7y8oovQg0T5rbIF/hyL26I/Qw0jUojAqis8DK23Eg2cLPyF1OmZMnZ8BndrY/n3Jyy6MXdKYx+cXTAY7jENLLVZTrSlddUOxmMMJylwSUpg52a53SzG3H1r6X/jrBG4cnR7M0Khv2lBwEGHAzg+8ZRuiQydjR3/FqRChfPI8eSf1bgvMDzNBNbdrQ6YgEtlau4pSzWdTbzci7vR1qTYi/aWWeGHOo9lMKmS4LpnlN81/PE4caxAqdaYIGJDQ5muoS2xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aE8asw6ittTKb4c1hbNh0rKZ2yCLJKKOhOQDWsDIuGU=;
 b=CSg3DyAH0mvzj3aY0RV4saVhH3dNdX3h18NHCwADEVlJhRF/q7nkqa+pk+XFQWMQtBJIAziQT+rABfLo34EDphxoxc4iBSZfWJ3TM4ew1ChJGCBF2Bld1rfNzk+HztJoIxzrPILzdcs83nltXFCjh6cnVHnrEHQyRewbtXEhWQc=
Received: from MN2PR11MB4509.namprd11.prod.outlook.com (52.135.39.90) by
 MN2PR11MB3584.namprd11.prod.outlook.com (20.178.251.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Thu, 16 Jan 2020 00:09:44 +0000
Received: from MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::bd81:f020:90e3:a12d]) by MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::bd81:f020:90e3:a12d%7]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 00:09:44 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "'lftan.linux@gmail.com'" <lftan.linux@gmail.com>
Subject: RE: [GIT PULL][RESEND] arch/nios2 update for 5.5
Thread-Topic: [GIT PULL][RESEND] arch/nios2 update for 5.5
Thread-Index: AdXMACFQFvoIjeFmRG+tETjRj9SIpgAAQv6w
Date:   Thu, 16 Jan 2020 00:09:44 +0000
Message-ID: <MN2PR11MB450935C69DAE265BCF9BB389CC360@MN2PR11MB4509.namprd11.prod.outlook.com>
References: <MN2PR11MB450981DBCE5894AFEE2B016FCC360@MN2PR11MB4509.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB450981DBCE5894AFEE2B016FCC360@MN2PR11MB4509.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjM1OTRmOTgtYzUzOS00NjhkLWJlNmYtMmU1YTJhODFlMmMxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQlVWMXFnYjJCWUQwZ2wyVWdYSmVsVmx6d25kaklGVWJRRUI2MGpaV0kwR091QnZBbG03aStaRGxyaHB0QUs5OCJ9
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ley.foon.tan@intel.com; 
x-originating-ip: [192.198.147.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3faefa08-0b8c-4f54-8cdf-08d79a18640a
x-ms-traffictypediagnostic: MN2PR11MB3584:
x-microsoft-antispam-prvs: <MN2PR11MB35841A8403F8A76F7D62B2D5CC360@MN2PR11MB3584.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(2940100002)(8936002)(4326008)(81166006)(2906002)(86362001)(316002)(66946007)(6916009)(66476007)(54906003)(7696005)(64756008)(8676002)(81156014)(71200400001)(33656002)(186003)(66446008)(55016002)(53546011)(26005)(6506007)(76116006)(15650500001)(66556008)(478600001)(9686003)(52536014)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR11MB3584;H:MN2PR11MB4509.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QZ2gr0DEkVfBP4ILg2tsEtCD4nB+dKcm5hH6NwmoUoLZBrYgBVBauwiEl2YRHVvjt6+7NxttSXf7lU0hOMZ0nPIrhePyMD+SmN43082BEL61yLlOeN1/PDDRHM2OTDers4dYBqdwg/80ar5cBxXAzJ1NPOlcJvd6L4Q0Fpjs1eFt69exnpVsBW+3+WoEaqE6oj/3VHDDbKsEj04ffUXPRFbcjQouF/2IKgZZv6ePxhF1ZBHrSXm1RGgrUuPnS+nFZK1QMi5k/YBA8QfjvRBF5+kL7o2s0H6+AxqASjGaHTO/No5Eo6n1IZyttPxAF7YhzNaELLI8kBIgWCtMLYMXV+zhvfAoMTULdbK3ALGEt20lZK9XEfgndT0hjtr84Q8Od+qAkrsIMJzEmtRUqYOd/JiakeGjbQd4/rBi6kMCO70TFIY0MezL16/ORWNcfNSK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3faefa08-0b8c-4f54-8cdf-08d79a18640a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 00:09:44.2301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBqR5Idfh60dKJO2gngd47KYCQ2zR6K1vBobtHJSeUnShT2jto/i0tUZLiiYEv+5N6Czp6+C8UN21miUFMx6sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3584
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Tan, Ley Foon
> Sent: Thursday, January 16, 2020 8:06 AM
> To: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>;
> 'lftan.linux@gmail.com' <lftan.linux@gmail.com>
> Subject: [GIT PULL][RESEND] arch/nios2 update for 5.5
>=20
> Hi Linus
>=20
> One update for nios2 maintainer email, please consider pulling.
>=20
> Note, resend due to linux-kernel mailing list reject html contain email.
>=20
> Thanks.
>=20
> Regards
> Ley Foon
>=20
> The following changes since commit
> 95e20af9fb9ce572129b930967dcb762a318c588:
>=20
>   Merge tag 'nfs-for-5.5-2' of git://git.linux-nfs.org/projects/anna/linu=
x-nfs
> (2020-01-14 13:33:14 -0800)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git for-linus
>=20
> for you to fetch changes up to
> 051d75d3bb31d456a41c7dc8cf2b8bd23a96774f:
>=20
>   MAINTAINERS: Update Ley Foon Tan's email address (2020-01-15 11:11:22
> +0800)
>=20
> ----------------------------------------------------------------
> Ley Foon Tan (1):
>       MAINTAINERS: Update Ley Foon Tan's email address
>=20
>  MAINTAINERS | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Seem like it is already merged to kernel tree. Please ignore this.
Thanks.

Regards
Ley Foon
