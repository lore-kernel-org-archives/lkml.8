Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1701C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B092920714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="rQtjTpag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgFOFgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 01:36:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:64043 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728210AbgFOFgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 01:36:04 -0400
IronPort-SDR: AxCI4PtEvaiycsC0zNn9K/DcIc8NFaVIz9DcsPQGFel8hgSnKb5XfF/KJ/H0oVHuu8Ka0WcKbY
 tAZudzWGxE1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2020 22:36:04 -0700
IronPort-SDR: tjL4Phx3B6mSrPeEU7YUADxc+Y2AH+SC5itT3EmJbCyBtDRSrsQWek5MGOIrf0M5HJ1HnlozsK
 gGKiLmEN1kWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="420246022"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga004.jf.intel.com with ESMTP; 14 Jun 2020 22:36:00 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 14 Jun 2020 22:36:00 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 14 Jun 2020 22:35:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVMk0zq6AeCQ57Ahe7QawcdNeQJDnevEq2g7tXyRHw2jbNejeIGi5sOJCivemjRUv/SU1xcKLuDjb3rqWKdngPJjMms96q6LXk2h5QJQtG44mTJgjaMSuEfIc4H30krtJSr3auhz1z2QcKmiQAtjVoGlb6YIUrq7hM1A/MIl3JZ2521V72QcHqVrrmQi8eOQdgH9e9s4HEcEi01phTTWmUNwiSciOrpG4Yl7aW8RN9nCjHdLhu0cyvfuS8xld1PtJQoVgAkIY6thGaCXzpFh7oTBuMDFRzAy9ZqsZ2BGl3OLYNopdU1ViwazHOzab//1MfZkjEwNGQ5Co572wR2fVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FHnxFQInOnNhp6WkZxcpmlfDD/vTclkA6UHAYI11Js=;
 b=mQPJiPWD1pYLQvBPB/iTSBQF6rTTHo3WtJyLToomjXZchbAYDGrSG3GAt5bXqcNC0pWaZtQSNM95fZew7VIYa/Z44swgehHIgjg/IVgKenic/ERbM1YIyM/Dqcr62FPTzC5xP9hEP+VLtG1fLRsVEh9u93mf2OErvsNixrDwAo4XXNfrcgJN1UCMgz73oQqvYqVqedr2w2CCsrRv5sSq3TYrwtE6RX2/1daCWK/rgdwp4Tiw44Ou6piUlt3IOqRJ9+jAU/625CNB2mFmurzG+NtAF6FJwFaMkj3qKg1TDq9iwxtkAueUuiyIKHjyaJkQ0vs/4N6k8dFlt1FKNXyQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FHnxFQInOnNhp6WkZxcpmlfDD/vTclkA6UHAYI11Js=;
 b=rQtjTpag3NqR6wvuC9fZXBtwLEC9jgEIbDGf3I8zqG2x+n2FVdF4ATJRJRs3hkqhaycDsuKGf4QO/qdDHhBZg8AloibvXwFQnrxtfvvJDsER1ZpVBq74mra6k8Scp2F5spHPmiX5Y4fA+bYzYlu8MMB2Z+fBsRMQ3hS6WzZ4Ryo=
Received: from CY4PR1101MB2326.namprd11.prod.outlook.com
 (2603:10b6:903:b3::23) by CY4PR11MB1367.namprd11.prod.outlook.com
 (2603:10b6:903:2d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 05:35:58 +0000
Received: from CY4PR1101MB2326.namprd11.prod.outlook.com
 ([fe80::20ad:67f:8bea:34a0]) by CY4PR1101MB2326.namprd11.prod.outlook.com
 ([fe80::20ad:67f:8bea:34a0%8]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 05:35:58 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        "alex.huangjianhui@huawei.com" <alex.huangjianhui@huawei.com>,
        "dylix.dailei@huawei.com" <dylix.dailei@huawei.com>,
        "chenzefeng2@huawei.com" <chenzefeng2@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
Thread-Topic: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
Thread-Index: AQHWQOg7pvDM2vjI7kmUTaz/F8Qw8ajY8l4AgAAdh4CAABsdYA==
Date:   Mon, 15 Jun 2020 05:35:58 +0000
Message-ID: <CY4PR1101MB23261B27ACF9D7FBC3969318E79C0@CY4PR1101MB2326.namprd11.prod.outlook.com>
References: <20200612183450.4189588-1-keescook@chromium.org>
 <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
 <202006142054.C00B3E9C9@keescook>
In-Reply-To: <202006142054.C00B3E9C9@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.151.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3bff23a-b160-42ac-a730-08d810edfb85
x-ms-traffictypediagnostic: CY4PR11MB1367:
x-microsoft-antispam-prvs: <CY4PR11MB1367ED95BE6FC7DB41AD53F0E79C0@CY4PR11MB1367.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7/5u2PoNi5fnLi4o32kU7xODNTdtCO23o28q2JR6u74XcdE+OB7Cdt5ySjQ22G4QroCrEeGhY5rXp4vtVBWQ8trSk1oMm4vMk2WOQqhi7UMvXWtAGVdYbewWobjdhbLJEAgkhw7eaHsxp70kKzNRh1aPh6xdvZKJ7qpCQt4Q8lpXJL+oqsqTEjy1CTjMy3ZHtTS5agZjxuPJ2uoD/dAsJjpeHSEqDQkBSbHIl8+VJTseUqw4fP0vJcHXg3eW74z5kKbTbOX9UwE2FlAmN1QGMGztNPSNIReZc0tOIW3N38kyyiUrzFZ5V6csdrIfHRTw7UHrDDZfIU/ZrjwgcrE7vFB3sZTXehQSV0G4H3IkSkoAzJOUOJ/ZDpBDR2ArTRzJWYF8fq3dj1cIlruml4m9hA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1101MB2326.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(396003)(366004)(39860400002)(316002)(6506007)(53546011)(2906002)(66476007)(66446008)(66556008)(64756008)(76116006)(66946007)(26005)(4326008)(9686003)(55016002)(186003)(33656002)(86362001)(7696005)(966005)(478600001)(110136005)(5660300002)(7416002)(54906003)(8676002)(83380400001)(71200400001)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jO6T3dTolTxLhSCrRgkslLBMFeoN4KkI5BoPMIL8mL+e5CcvDhSkZo9oLGDMlZP49Y1SqQDKLX4Wdw1O88AIVZejt7hCVvnfklKfoa+RitrOzO/gkXIF8KjuYx7kmOX7eufUi1z1Jp0XhDT1biyE8Gthrj3Xc49uBrELhewbnWKPM4dW6x+GixPzeH5iONbEausMWolzOzTaZokpaGtU4d+MLQiuGuYIH20nVSUKcRI+B5rsae58TuqNvIuC+r01W5g+g477AkVTtAnJ/GAiTFxo3P+V1BnfKDfUMbzFfWuH8ceLlMEAhzs9NJ4L/OWRzuHO7Q5Vir0NsoHasU4sFxI+YT1S/CbabpeXXLFytnY3hUKUuGFT2bq/sdip64mWKEtbAqXz+jmamh/XqsgsALDqkm5lENS4YWKy5N1PjmQFc3jkQSM8XjTaYJJnt7ze0I7GzzFLklEJqoPuI8+BbQ1X0zqMeXUkn8e2xs0LBbsiKAxgM2lfvrLaF3zrLGbP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bff23a-b160-42ac-a730-08d810edfb85
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 05:35:58.4399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N0fycMOrheA11Pg4ow0/aaES9ZH6dpxJfDG9ZFLEpxVkHmlJl9fn2UwLh9qY4+tN+5+z7zVb9esIGHJEsT/fAitA5dBGQmJoqkpmHcD9eXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1367
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jun 15, 2020 at 10:10:08AM +0800, Xiaoming Ni wrote:
> > On 2020/6/13 2:34, Kees Cook wrote:
> > > This series was never applied[1], and was recently pointed out as
> > > missing[2]. If someone has a tree for this, please take it. Otherwise=
,
> > > please Ack and I'll send it to Linus.
> > >
> > > Thanks!
> > >
> > > -Kees
> > >
> > > [1] https://lore.kernel.org/lkml/20190306110549.7628-1-
> elena.reshetova@intel.com/
> > > [2] https://lore.kernel.org/lkml/1591957695-118312-1-git-send-email-
> nixiaoming@huawei.com/
> > >
> > > Elena Reshetova (3):
> > >    nsproxy: convert nsproxy.count to refcount_t
> > >    groups: convert group_info.usage to refcount_t
> > >    creds: convert cred.usage to refcount_t
> > >
> > >   include/linux/cred.h    | 15 +++++++-------
> > >   include/linux/nsproxy.h |  7 +++----
> > >   kernel/cred.c           | 44 ++++++++++++++++++++------------------=
---
> > >   kernel/groups.c         |  2 +-
> > >   kernel/nsproxy.c        |  6 +++---
> > >   net/sunrpc/auth.c       |  2 +-
> > >   6 files changed, 38 insertions(+), 38 deletions(-)
> > >
> >
> > Should mm->mm_users also be replaced by refcount_t?
>=20
> I'll say "yes". :)
> https://lore.kernel.org/lkml/1487671124-11188-1-git-send-email-
> elena.reshetova@intel.com/
>=20
> > In addition, is it better to change all variables that use
> > atomic_dec_and_test to control the release process to refconut_t?
>=20
> For the most part, yes. The following may find a lot of them:
> scripts/coccinelle/api/atomic_as_refcounter.cocci
>=20
> If you can go through that and double check for prior series from Elena,
> we can get through all the rest of them.

I have these ones also here in case anyone is interested:
https://github.com/ereshetova/linux-stable/commits/refcount_t_fs
https://github.com/ereshetova/linux-stable/commits/refcount_t_block

They haven't been rebased for a while, but if there is an interest,=20
I can certainly do it.

Best Regards,
Elena.
