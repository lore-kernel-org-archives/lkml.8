Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1D8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6423B20781
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="G3Wx8Pkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgHDBQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:16:50 -0400
Received: from mail-eopbgr1410089.outbound.protection.outlook.com ([40.107.141.89]:53856
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726615AbgHDBQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 21:16:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+yTG0Q4tINewUQ8Dy/RM3uCzXcjT5AJgjmhCXrHhN/m+ibbPVQLIyqNc/rd0XyOvkCCaCVevz9SH37LMPboCc/krO0HvEJy5sKQmUMIF+UU5pJMwAlxvXyu2b3FNi4GkJMGx8kNxKMT6RHrgwvqGGGxQ+IOFeao35lvqXk1iqDrvZ772oKBGwM2D5DNFOZYK97v43vvUmCssIQ2c07gK9Tj1bsITqDGJ0QCht9mKPj2rZHZyFpiv8W6TpcE3QR3EGOp4/wL49d3CmFKZszIs2vpGVHz+uBhVe44k17Pb5rOOfuvD2FUZ37KbItPtotDIJQPqh0SbBTqdJ5GT00BAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCLHnBGYh/+JYhvG7GCswr7fcveAugMk2OgLrMXmtCU=;
 b=ajEqVAAhgfQa1GmRnkHrwm5v0XEQ0o67GWUHgsA1MBk/U5Si1Iyv9jo2ClTgahivOfYQiFrOsi1xEhh5fk56oc1hrprJjN+IEZJL0i+01g96cvKOfo9jZXyKJp050RT8kKliSxCDyzC1QZN/lhqEGeD6ffnuTKPzL3QD4heEyzaKzk5uefyGKiuwcwb87Yu3cwcRUXKWaNtH+ctLsOW3N46EkvsAY2SD9gx4D8xF4f4nGKrgAfy3zb1reTyq1v6CRwmM6VEgluL+f+uU5suHYvfHNtEmn4mIIVZg5BIJfB0S0I+s9P0LW2+FG7zUvUG3ceSxAW8agBOZOdRpsiAdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCLHnBGYh/+JYhvG7GCswr7fcveAugMk2OgLrMXmtCU=;
 b=G3Wx8PkqiSSg16wJb0a6iiO6ngJ037R2/iSPHnslkztgzyGIn0n4E9R4oiMU5JP2hQJEldroMJZgQzeX61ffc4UTpni6gLuho+rSgNH+YLAMYDrVBhl7sK+1U7J6T246IOLjSempSzy26OMKPope5J4xr5KrdG3+sHR41j4PzVk=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYXPR01MB1887.jpnprd01.prod.outlook.com (2603:1096:403:e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Tue, 4 Aug
 2020 01:16:45 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 01:16:45 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Qian Cai <cai@lca.pw>
CC:     "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "zeil@yandex-team.ru" <zeil@yandex-team.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/16] HWPOISON: soft offline rework
Thread-Topic: [PATCH v5 00/16] HWPOISON: soft offline rework
Thread-Index: AQHWaclRY/IcAl5ZPUiTqlijcX3D9KknJkIA
Date:   Tue, 4 Aug 2020 01:16:45 +0000
Message-ID: <20200804011644.GA25028@hori.linux.bs1.fc.nec.co.jp>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
 <20200803190709.GB8894@lca.pw>
In-Reply-To: <20200803190709.GB8894@lca.pw>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lca.pw; dkim=none (message not signed)
 header.d=none;lca.pw; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6fe92b0-e9c5-4e63-8317-08d838140dda
x-ms-traffictypediagnostic: TYXPR01MB1887:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYXPR01MB1887DAB6D57966C650385BE8E74A0@TYXPR01MB1887.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gUXACrSvIGchbed2YPgcgkPtp5QaPHnQml0bsUle1ibKs2xwlRgJ5W7GCkByIK32fjM8JRlFn1Rgcl7+G6pK2v44rYCYMUR/Nov9lPyU2yiMbIsmuvxjnE1mT6WY+jqp4u7T5QDzMboHOqyoh8lxTMbSA0RmeT3aYsYXuYmV40G8ih1iMvX3rkauk9KF0LwvxLP7OxCNU563Sgyt1SoIQvIzNN/zfnzKpNNuS0Gsv+5FAai7tfb2nZt50icZ51+oteC2nt/zDz6yrAwH/GwH1223Gz4sWlqD1GP5blUdVnSc8nBGu5boh8I77LHWKdtP6Wzs19PlJ3DmEiJ71UM8V1TaknmyEGtIX3KmP6ttnUGik1qOhNi37dU/V2C3TVYIx2EZCilRBCl11PZLHSH1IQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(316002)(54906003)(66946007)(66556008)(66476007)(64756008)(85182001)(186003)(8936002)(1076003)(66446008)(7416002)(478600001)(6512007)(55236004)(6506007)(4326008)(6916009)(6486002)(33656002)(83380400001)(9686003)(2906002)(966005)(5660300002)(8676002)(76116006)(86362001)(26005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: IqkGVJMHQyi7RmBkKexqauCP/0wYogNXh37u8uE7+1ZpWVzZOIZ5csinP6hohFfQGpXaOYlv5mzpQ2d2LQcJwejP1lys8kNReQbfao3CMnQ1dF5mAu8mEktUIVaQZCWsffOuJkdg1VJXu5v1YHzks932RgxJyzgr+WfnbXm1Q1g5CdJq55DhAR/lVg3d/2Pt/z5MR7/o6KXbPvfz6sQeCX7sVzO5ttL5ff7PTiRNuHap86ajy1cDwvRUD0QI5PzPkt9pOPiAOiVqNp1lH1GYTJx2KgGT0HbJ4Zc3XIiojFHislh3vB6Bo+M70tglS7NgZ59Gh+kIkyxvXqbAwb4zeP7ZQLlC3GyDRXxQNETJ1ZC/jzc4aUckWFhBv1cVI4itZCOkI8GbWNHxhevwKpxxHeWuBHYtD1oGhVZ7iq74eA4kFbmWuth8QOaGh9hzjT+GcHgJeA2TtK/cRojaufDUBeTZiv3qXXWeg1iIBhahzxDOTaSENZeiDam95627CfiDJMeJ+Y1GU7c8oNk7Vj8yH9uNmHXBS/8BEYagDJXeZsNcAUwBNtCtG+JHQ/8R6XubtxEArZhNsZeZ7ZCyS1LkTEHjDRWj9qIsm+CYSZS7gJ+1bcoC3j/zrByVCRxQhQKGZqGzKcVZ6/X7riDnHUc2/g==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <31975729E6EA7A45BBA2FE3830354E7D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fe92b0-e9c5-4e63-8317-08d838140dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 01:16:45.5051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2jLx5g2z1YBgWYVpVXSoYmm8r0W6Q10MjbMgmINI153kXj1Tf7eKVIMr9vgsGcDGTXgsqe7QBuw7717hxfFng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1887
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 03:07:09PM -0400, Qian Cai wrote:
> On Fri, Jul 31, 2020 at 12:20:56PM +0000, nao.horiguchi@gmail.com wrote:
> > This patchset is the latest version of soft offline rework patchset
> > targetted for v5.9.
> >=20
> > Main focus of this series is to stabilize soft offline.  Historically s=
oft
> > offlined pages have suffered from racy conditions because PageHWPoison =
is
> > used to a little too aggressively, which (directly or indirectly) invad=
es
> > other mm code which cares little about hwpoison.  This results in unexp=
ected
> > behavior or kernel panic, which is very far from soft offline's "do not
> > disturb userspace or other kernel component" policy.
> >=20
> > Main point of this change set is to contain target page "via buddy allo=
cator",
> > where we first free the target page as we do for normal pages, and remo=
ve
> > from buddy only when we confirm that it reaches free list. There is sur=
ely
> > race window of page allocation, but that's fine because someone really =
want
> > that page and the page is still working, so soft offline can happily gi=
ve up.
> >=20
> > v4 from Oscar tries to handle the race around reallocation, but that pa=
rt
> > seems still work in progress, so I decide to separate it for changes in=
to
> > v5.9.  Thank you for your contribution, Oscar.
> >=20
> > The issue reported by Qian Cai is fixed by patch 16/16.
> >=20
> > This patchset is based on v5.8-rc7-mmotm-2020-07-27-18-18, but I applie=
d
> > this series after reverting previous version.
> > Maybe https://github.com/Naoya-Horiguchi/linux/commits/soft-offline-rew=
ork.v5
> > shows what I did more precisely.
> >=20
> > Any other comment/suggestion/help would be appreciated.
>=20
> There is another issue with this patchset (with and without the patch [1]=
).
>=20
> [1] https://lore.kernel.org/lkml/20200803133657.GA13307@hori.linux.bs1.fc=
.nec.co.jp/
>=20
> Arm64 using 512M-size hugepages starts to fail allocations prematurely.
>=20
> # ./random 1
> - start: migrate_huge_offline
> - use NUMA nodes 0,1.
> - mmap and free 2147483648 bytes hugepages on node 0
> - mmap and free 2147483648 bytes hugepages on node 1
> madvise: Cannot allocate memory
>=20
> [  284.388061][ T3706] soft offline: 0x956000: hugepage isolation failed:=
 0, page count 2, type 17ffff80001000e (referenced|uptodate|dirty|head)
> [  284.400777][ T3706] Soft offlining pfn 0x8e000 at process virtual addr=
ess 0xffff80000000
> [  284.893412][ T3706] Soft offlining pfn 0x8a000 at process virtual addr=
ess 0xffff60000000
> [  284.901539][ T3706] soft offline: 0x8a000: hugepage isolation failed: =
0, page count 2, type 7ffff80001000e (referenced|uptodate|dirty|head)
> [  284.914129][ T3706] Soft offlining pfn 0x8c000 at process virtual addr=
ess 0xffff80000000
> [  285.433497][ T3706] Soft offlining pfn 0x88000 at process virtual addr=
ess 0xffff60000000
> [  285.720377][ T3706] Soft offlining pfn 0x8a000 at process virtual addr=
ess 0xffff80000000
> [  286.281620][ T3706] Soft offlining pfn 0xa000 at process virtual addre=
ss 0xffff60000000
> [  286.290065][ T3706] soft offline: 0xa000: hugepage migration failed -1=
2, type 7ffff80001000e (referenced|uptodate|dirty|head)

I think that this is due to the lack of contiguous memory.
This test program iterates soft offlining many times for hugepages,
so finally one page in every 512MB will be removed from buddy, then we
can't allocate hugepage any more even if we have enough free pages.
This is not good for heavy hugepage users, but that should be intended.

It seems that random.c calls madvise(MADV_SOFT_OFFLINE) for 2 hugepages,
and iterates it 1000 (=3D=3DNR_LOOP) times, so if the system doesn't have
enough memory to cover the range of 2000 hugepages (1000GB in the Arm64
system), this ENOMEM should reproduce as expected.

>=20
> Reverting this patchset and its dependency patchset [2] (reverting the
> dependency alone did not help) fixed it,

But it's still not clear to me why this was not visible before this
patchset, so I need more check for it.

Thanks,
Naoya Horiguchi

>=20
> # ./random 1
> - start: migrate_huge_offline
> - use NUMA nodes 0,1.
> - mmap and free 2147483648 bytes hugepages on node 0
> - mmap and free 2147483648 bytes hugepages on node 1
> - pass: mmap_offline_node_huge
>=20
> [2] https://lore.kernel.org/linux-mm/1594622517-20681-1-git-send-email-ia=
mjoonsoo.kim@lge.com/=20
>=20
> >=20
> > Thanks,
> > Naoya Horiguchi
> > ---
> > Previous versions:
> >   v1: https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-emai=
l-n-horiguchi@ah.jp.nec.com/
> >   v2: https://lore.kernel.org/linux-mm/20191017142123.24245-1-osalvador=
@suse.de/
> >   v3: https://lore.kernel.org/linux-mm/20200624150137.7052-1-nao.horigu=
chi@gmail.com/
> >   v4: https://lore.kernel.org/linux-mm/20200716123810.25292-1-osalvador=
@suse.de/
> > ---
> > Summary:
> >=20
> > Naoya Horiguchi (8):
> >       mm,hwpoison: cleanup unused PageHuge() check
> >       mm, hwpoison: remove recalculating hpage
> >       mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
> >       mm,hwpoison-inject: don't pin for hwpoison_filter
> >       mm,hwpoison: remove MF_COUNT_INCREASED
> >       mm,hwpoison: remove flag argument from soft offline functions
> >       mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
> >       mm,hwpoison: double-check page count in __get_any_page()
> >=20
> > Oscar Salvador (8):
> >       mm,madvise: Refactor madvise_inject_error
> >       mm,hwpoison: Un-export get_hwpoison_page and make it static
> >       mm,hwpoison: Kill put_hwpoison_page
> >       mm,hwpoison: Unify THP handling for hard and soft offline
> >       mm,hwpoison: Rework soft offline for free pages
> >       mm,hwpoison: Rework soft offline for in-use pages
> >       mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_p=
age
> >       mm,hwpoison: Return 0 if the page is already poisoned in soft-off=
line
> >=20
> >  drivers/base/memory.c      |   2 +-
> >  include/linux/mm.h         |  12 +-
> >  include/linux/page-flags.h |   6 +-
> >  include/ras/ras_event.h    |   3 +
> >  mm/hwpoison-inject.c       |  18 +--
> >  mm/madvise.c               |  39 +++---
> >  mm/memory-failure.c        | 334 ++++++++++++++++++++-----------------=
--------
> >  mm/migrate.c               |  11 +-
> >  mm/page_alloc.c            |  60 ++++++--
> >  9 files changed, 233 insertions(+), 252 deletions(-)
> =
