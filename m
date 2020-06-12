Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE6CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91681207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="q0JF7vmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgFLGU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 02:20:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:24975 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgFLGU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:20:58 -0400
IronPort-SDR: 3bCJYl5Z9P98oxAlV5LYEEEB8BfURlsqsPTbxh7axP/n1mRXvRbCyU+3JRuG10K6r91h0N9Gfq
 xAKwNA4Aj0HQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 23:20:50 -0700
IronPort-SDR: hieNkR4k3H3oz8U2p3qPgi3WIp9ekHi0Y+xkGiuboOFqa+rI/GbHqdwzybelb5+Y2TpeUwnCs7
 8lovBmvFNTXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,502,1583222400"; 
   d="scan'208";a="259809710"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jun 2020 23:20:50 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jun 2020 23:20:50 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jun 2020 23:20:49 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 11 Jun 2020 23:20:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jun 2020 23:20:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NywUEhDTox3nAtaxKfCpLgCwLYGdK5htCGIoHvC3VVadz4xvwaTsTMT3U3k3lc7aK0yxDsOXX1QevxofDDHKdQdlWxkg5jMuK5ZaDhagnzlcrvBOGMC2EsqmRIuzFk1IXrta94gwystEqJtN4A8qf880GjcmIk+/uWpIA57gJcoXVipp6BM/aXr2fWTCj/E+jzCj7tZuEa2eGQDt61wdZ/Jx9XcOcNbOlyQshijWo/sohZ96Pd6O6VLmyv18zbYXoQ34lho6jd3w1gWrKfmadk4TFpttXy5zL5YKqygYJIOFn+op8lUZ1ul3dcsxlsXG2ogd62LWJ2Q1dktO6pQ7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3/PnQWVwfURvyuhT729ayE4Y3x8FBOUo/Sfjt0IBAg=;
 b=X2kN8SbBtrPF0OBGfUe9EvJ+BbJhWS2wtnKzBWuf4QckXX2p5iJ5e6UtCdXOdx403BQshfW0tM+MufsKhZR4HKLwmFqkclioU+Wflv1zmazGM9FasdiDI3bYpd6p4JZMQdk5WOsnT+xfyHkVUjViZ8I5Vx489qW5YMsGiqjlVumwBdMl16W1tKsL2juJ3yuzfqKqe4ZNhZVH8Wufi2hyrnQPncXWn9ItoXcB/UaRp6OCQWoAmaQxYcSI8EbLAZ5Om7hs6dZktJj9dRuN1ERcTSwfbe+9v8lXc1y/1gxUTG/EE91We4ORxDOYJg8bX3eMl8SW8SsqvM+YP5jq3dif7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3/PnQWVwfURvyuhT729ayE4Y3x8FBOUo/Sfjt0IBAg=;
 b=q0JF7vmq5potkh5WPS4SR7TekarFUbX5NVNr/utLyumkMA+/QGIGgxOf2hJXRyrNey+sJovUnUIvYqmW+vpRueceHTBKPjl/rwsa3EaEwUyFqk4b6sSfPpilJBLom6XLEeYpWJccO7zPP3hWR9c2sZWSdewMZ/c3gnCHPztqKho=
Received: from BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26)
 by BYAPR11MB3607.namprd11.prod.outlook.com (2603:10b6:a03:b2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Fri, 12 Jun
 2020 06:20:48 +0000
Received: from BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::c85c:ec78:c650:6ac9]) by BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::c85c:ec78:c650:6ac9%3]) with mapi id 15.20.3088.018; Fri, 12 Jun 2020
 06:20:48 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [PATCH] nios2: enable HAVE_COPY_THREAD_TLS, switch to
 kernel_clone_args
Thread-Topic: [PATCH] nios2: enable HAVE_COPY_THREAD_TLS, switch to
 kernel_clone_args
Thread-Index: AQHWMbMGtusV1wwtGU+hyBMCvC9pdqjUn1/A
Date:   Fri, 12 Jun 2020 06:20:48 +0000
Message-ID: <BY5PR11MB38931405FE73FF989B773B77CC810@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <20200524100606.1378815-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200524100606.1378815-1-christian.brauner@ubuntu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a874305-accf-4a9a-26dc-08d80e98bf89
x-ms-traffictypediagnostic: BYAPR11MB3607:
x-microsoft-antispam-prvs: <BYAPR11MB3607A959EDD6026733EC4DC2CC810@BYAPR11MB3607.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vphwFil/NndEnrt6eUW7heOaIKBXpAtK61KSwe7A4V5yf6ST8CuX11y80mz8Le6wGYocc8ZSRVYO7iwR8Z2/iSaSjEFt3+Upppp79pNO3zmsuJjN7O3dL23UQekSLAfhZZusqg/f8fU8OEi3seFFE9SG/R8LhOrkMYFvcVDRDazkPr6ZH3xolOx7T9Gz1ySXzv4/0MeS3v6aEWrTISPE7shT4iuP2UZ8sDjUW2nhOEjHZTdH4ehyKsEgAzAkhHNUKeh7BHKGPUhscr4R5cn9KzLCdYxZd9/73rvK8qqbmTW8ZRPE3wDi3eoNjxRbUzTIjBRiWlZ++QJo1ht3FQm/yTEQmuy6ApnYgk8UurT3tPf47Q/yuBxj9gFbXKrdQobM0NY/JZfO6+dFy2b4xjIA+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(376002)(366004)(346002)(39860400002)(71200400001)(4326008)(5660300002)(55016002)(9686003)(33656002)(26005)(7696005)(6506007)(53546011)(8936002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(186003)(83380400001)(966005)(52536014)(86362001)(110136005)(8676002)(54906003)(316002)(2906002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VSP9XAFuRee2f/LsN9467WgN935iyj6kiCK9N7UEQYYYBuWahZrn/KxxsB8FjWDPgjV7j3E7q1nY9zBJGG6+Jn7hTXX3sMpG7SSrXnmoyBk6DMPNyplA5IJEn2NOu4w53H2aee2MYBHouydyBcDV1082UcjkhW5EJQoTpkPQk0DDISM6RAZTxKMz41q8hFEdLsNImc6406UEaqUzojRvjVpMOBM8bAixVwMMkGjmleVbUnnv0Yi1gJQdwMyEpTJRAHK/QTvzfyLPrcR7bL2khhQUwMVPy5vhgqIyTjrec1N66YVQzUl0OUiY4esNCmTP8zhlwc31nR0Uaf+Yq18gUZc0CNrDirEXU94cm8STggql8fdFZP8h4tVKIVAC0r1wkq1ZdYGZjQGR7wc1dmGWNF46WhqbWkzY89TMIZUyHdsRZ5mRhdUgVOEPTRHVNmh1tsidE7XPh13K908XgPsaK3Ail0uqr5r8x7pDnMOj0dKR6cqkcecQxB+BbEdAoiOy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a874305-accf-4a9a-26dc-08d80e98bf89
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 06:20:48.3280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hqtkas/1p114TDbQ9NsdjoLiHLNl9Ln6EehuTqm9A1PHZ3NLPa81DJE/Q+X8KV7w/Ii2VqmyfxL+SG+Ob+//GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3607
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Sent: Sunday, May 24, 2020 6:06 PM
> To: Tan, Ley Foon <ley.foon.tan@intel.com>; Arnd Bergmann
> <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org; Thomas Gleixner <tglx@linutronix.de>;
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>; Christian Brauner
> <christian.brauner@ubuntu.com>
> Subject: [PATCH] nios2: enable HAVE_COPY_THREAD_TLS, switch to
> kernel_clone_args
>=20
> This is part of a larger series that aims at getting rid of the
> copy_thread()/copy_thread_tls() split that makes the process creation
> codepaths in the kernel more convoluted and error-prone than they need to
> be.
> I'm converting all the remaining arches that haven't yet switched and am
> collecting individual acks. Once I have them, I'll send the whole series
> removing the copy_thread()/copy_thread_tls() split, the
> HAVE_COPY_THREAD_TLS define and the legacy do_fork() helper. The only
> kernel-wide process creation entry point for anything not going directly
> through the syscall path will then be based on struct kernel_clone_args.
> No more danger of weird process creation abi quirks between architectures
> hopefully, and easier to maintain overall.
> It also unblocks implementing clone3() on architectures not support
> copy_thread_tls(). Any architecture that wants to implement clone3() will
> need to select HAVE_COPY_THREAD_TLS and thus need to implement
> copy_thread_tls(). So both goals are connected but independently benefici=
al.
>=20
> HAVE_COPY_THREAD_TLS means that a given architecture supports
> CLONE_SETTLS and not setting it should usually mean that the architecture=
s
> doesn't implement it but that's not how things are. In fact all architect=
ures
> support CLONE_TLS it's just that they don't follow the calling convention=
 that
> HAVE_COPY_THREAD_TLS implies. That means all architectures can be
> switched over to select HAVE_COPY_THREAD_TLS. Once that is done we can
> remove that macro (yay, less code), the unnecessary do_fork() export in
> kernel/fork.c, and also rename copy_thread_tls() back to copy_thread(). A=
t
> this point
> copy_thread() becomes the main architecture specific part of process
> creation but it will be the same layout and calling convention for all
> architectures. (Once that is done we can probably cleanup each
> copy_thread() function even more but that's for the future.)
>=20
> Since nios2 does support CLONE_SETTLS there's no reason to not select
> HAVE_COPY_THREAD_TLS. This brings us one step closer to getting rid of th=
e
> copy_thread()/copy_thread_tls() split we still have and ultimately the
> HAVE_COPY_THREAD_TLS define in general. A lot of architectures have
> already converted and nios2 is one of the few hat haven't yet. This also
> unblocks implementing the clone3() syscall on nios2. Once that is done we
> can get of another ARCH_WANTS_* macro.
>=20
> Once Any architecture that supports HAVE_COPY_THREAD_TLS cannot call
> the
> do_fork() helper anymore. This is fine and intended since it should be
> removed in favor of the new, cleaner _do_fork() calling convention based =
on
> struct kernel_clone_args. In fact, most architectures have already switch=
ed.
> With this patch, nios2 joins the other arches which can't use the fork(),
> vfork(), clone(), clone3() syscalls directly and who follow the new proce=
ss
> creation calling convention that is based on struct kernel_clone_args whi=
ch
> we introduced a while back. This means less custom assembly in the
> architectures entry path to set up the registers before calling into the =
process
> creation helper and it is easier to to support new features without havin=
g to
> adapt calling conventions. It also unifies all process creation paths bet=
ween
> fork(), vfork(), clone(), and clone3(). (We can't fix the ABI nightmare t=
hat
> legacy
> clone() is but we can prevent stuff like this happening in the future.)
>=20
> For some more context, please see:
> commit 606e9ad20094f6d500166881d301f31a51bc8aa7
> Merge: ac61145a725a 457677c70c76
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sat Jan 11 15:33:48 2020 -0800
>=20
>     Merge tag 'clone3-tls-v5.5-rc6' of
> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
>=20
>     Pull thread fixes from Christian Brauner:
>      "This contains a series of patches to fix CLONE_SETTLS when used wit=
h
>       clone3().
>=20
>       The clone3() syscall passes the tls argument through struct clone_a=
rgs
>       instead of a register. This means, all architectures that do not
>       implement copy_thread_tls() but still support CLONE_SETTLS via
>       copy_thread() expecting the tls to be located in a register argumen=
t
>       based on clone() are currently unfortunately broken. Their tls valu=
e
>       will be garbage.
>=20
>       The patch series fixes this on all architectures that currently def=
ine
>       __ARCH_WANT_SYS_CLONE3. It also adds a compile-time check to
> ensure
>       that any architecture that enables clone3() in the future is forced=
 to
>       also implement copy_thread_tls().
>=20
>       My ultimate goal is to get rid of the copy_thread()/copy_thread_tls=
()
>       split and just have copy_thread_tls() at some point in the not too
>       distant future (Maybe even renaming copy_thread_tls() back to simpl=
y
>       copy_thread() once the old function is ripped from all arches). Thi=
s
>       is dependent now on all arches supporting clone3().
>=20
>       While all relevant arches do that now there are still four missing:
>       ia64, m68k, sh and sparc. They have the system call reserved, but n=
ot
>       implemented. Once they all implement clone3() we can get rid of
>       ARCH_WANT_SYS_CLONE3 and HAVE_COPY_THREAD_TLS.
>=20
> Note that in the meantime, m68k has already switched to the new calling
> convention. And I've got sparc patches acked by Dave and ia64 is already
> done too. You can find a link to a booting qemu nios2 system with all the
> changes here at [1].
>=20
> [1]: https://asciinema.org/a/333353
> Cc: linux-kernel@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

Assume this patch will merge with your series.

Regards
Ley Foon
