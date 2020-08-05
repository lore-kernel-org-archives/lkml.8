Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F64FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C4820842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="q9OYhQp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgHEUoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:44:08 -0400
Received: from mail-eopbgr1400044.outbound.protection.outlook.com ([40.107.140.44]:45408
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgHEUoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:44:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwnnQ5I9P0GHIdCG915gjvYbNpmFgoU8GjXrDkooVRR4wsvY7BPTuF98stg0OkGDkzC5nyOlc6+nFA/cBt2z0TFwcNulo21Xt3pGsLdPZadgguQCV/5AFnSmPEXb+xqHGsqo4qMyYku7ty7SShl/Wq+FIo7Delf2nR2my7lEmJZC8LXektRmKYDTxDMaVAK4yy4xyjGCI11rHSPTgOukB2ljcTLIcnWOkZkH23oRBCyGE2+QaU15QqNWhwPmUEVYXDNqG0lCGHvtbO0CJffnBXY/C9NUrdxl5c4w7xpBYWXP3+cp/p3aXtR79RfQ0zLyAQQcdvX4IybqYAOfWIvyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tBXliWszOw0XOVA04IbkdWxXdvahcIPdJgoTmb7LdQ=;
 b=WitNodaSExOufRgzk1fw4aJv2ZqQxgEjSe+vrp5viOA44JjW8UHDsyC89NwuR+m6DTWV9SCpDuaqplxjHfA0EpJCOWOqzoP7p9wddeM33TtEHsLBHoz2jzkOD51mOyyBBjzneTNkycgvyymoxNobx/kbj7LPcU6VoEWfYTO/GRm39rxyVc3p0ZWrpmAAQSjm9fAuhh5EhpDIJOExJ2yEXruUmwf/0W5MazjK7Qo4OXreo4nPSnb0354qs0y9juoVbluJ6ohLOUrxASxmwzX321RCxEoiE6uL1wXvciVaVZtcG6hxlFN6SyurK8FGSSUICmt9/RaSw5s5IacIkOttLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tBXliWszOw0XOVA04IbkdWxXdvahcIPdJgoTmb7LdQ=;
 b=q9OYhQp1EvZKRZ3v+nC9Y5q1c0AfY4i4uUy53gsNqWYQ05GNPINv9VZuppFBkqJXhxAHrIRDCHeaYm3fd7EEiMX/UPh9z2E6vuOIFvKw7djgii1LIuy3sPX6UOmV/ltY6cG8OjinU3IOvIaHmy6LrUYxa2y3hCrAXL4f51hdLm0=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY1PR01MB1610.jpnprd01.prod.outlook.com (2603:1096:403:5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Wed, 5 Aug
 2020 20:43:55 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042%7]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 20:43:55 +0000
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
Thread-Index: AQHWaZM8vhDjVzP7UUGE+zgLjtO6e6kmYyqAgAAcjYCAA39mAA==
Date:   Wed, 5 Aug 2020 20:43:55 +0000
Message-ID: <20200805204354.GA16406@hori.linux.bs1.fc.nec.co.jp>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
 <20200803123954.GA4631@lca.pw>
 <20200803133657.GA13307@hori.linux.bs1.fc.nec.co.jp>
 <20200803151907.GA8894@lca.pw>
In-Reply-To: <20200803151907.GA8894@lca.pw>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lca.pw; dkim=none (message not signed)
 header.d=none;lca.pw; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14f83b2a-738f-45c1-8fee-08d839804594
x-ms-traffictypediagnostic: TY1PR01MB1610:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB16107843D2F75A67766D4402E74B0@TY1PR01MB1610.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QDCJms8ScZ/hId7q0O6mPYi6dHF423NLMEd/bprrebCz4JTH6Cu9iu0OSJiaPXXg4zq6UQWsM5bqcI7keGfJ7CcNDrJ+n9wy1M9WCGjgB1mE2dsuQC87PTvXe350uf/7tcgyIYLEDeeomzBjlKdGFLqrrgMN4gBO31hc3N4bnqmm4RkcVdexGy+24EVC3hbW39H4Ssm9/6sODT1RdhB50DwN/LpQtUMcLwcvKvlCh8sryfn3UomxIWMl+fYjJFF85l6YiyOmTbKtQJRq1/5+XPgFQZmXOEVU6xrOXrRYns66c4/fK6IZ0ExHJs87PlPMoM+xXw5sMbzTg7KLuyY90A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(6486002)(2906002)(186003)(30864003)(33656002)(6512007)(9686003)(4326008)(8676002)(26005)(83380400001)(66946007)(85182001)(71200400001)(6506007)(53546011)(478600001)(8936002)(66446008)(316002)(86362001)(76116006)(66476007)(66556008)(64756008)(7416002)(54906003)(1076003)(6916009)(55236004)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: LYKPnxqEJzXPrQa6YU7ge9HgAgdNhHKXpd3hxU5hwK3PbbaUadGnwbzMOFKGEx/XtvLBFUErdkPJZId61HHrhdqyEhzjfWZzTPSyeIgxym2qOw/3qs6wmDPg4NkLrWoP7v0HCPPYqjzj93Bpd8fVpkl/BdoYZfBhiWvDFJYePYOO7jamssNIjhkmZADHLcQBqQQQPoivCCidwSud099Qah70syQtg+J8YPc3aOjKK7FUwYMKCvPfmQp7vu452+7UdZ4HI02WvFBTLqW63d0uQk3PDIpxtROt2IObepzAzaxGTF7zguutLNsDhcn4UBYO7YrsIcNHY8+VVnC/BsVC9RInSF1EgbSLCFSJqIWhPUbrzyl+Fn10zeKDzvnAo50qmv0QhvIodTRfsMx4AB6fgTAvkG99ZFqZwedSk+IqIQRheWBb2iNgt0319CiwdG4dICv2v4rMznbQeLZBbY6pAmDhyNEO9Zm0PZdiaCDpuhDkOwY1QeQDncNMSUZBoLX+PRs/dt5Osvu7EKPiLAU6QBg+X6N4E9kQCPs6USTP15sR0eLu4sI7kMdgq7gixGUK4UPI3pYszMtJ7j2ZN2FYzzwZZW9T+k3agSWOklT2CmkmSGphPQdvi4ISQrVplbfw2jYDgCDadGS+coJOtxiqHQ==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <C14E9A8F46AFB64DAD7A51D644638FED@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f83b2a-738f-45c1-8fee-08d839804594
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 20:43:55.8216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QgI/5BvFG7Cjd+MVdP4SOyXMseix43nEuCWf60APqYYVIHwxji/rpKkst3RqqftYBmYaEqlnZf58YEb0GkTMhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 11:19:09AM -0400, Qian Cai wrote:
> On Mon, Aug 03, 2020 at 01:36:58PM +0000, HORIGUCHI NAOYA(=1B$BKY8}=1B(B =
=1B$BD>Li=1B(B) wrote:
> > Hello,
> >=20
> > On Mon, Aug 03, 2020 at 08:39:55AM -0400, Qian Cai wrote:
> > > On Fri, Jul 31, 2020 at 12:20:56PM +0000, nao.horiguchi@gmail.com wro=
te:
> > > > This patchset is the latest version of soft offline rework patchset
> > > > targetted for v5.9.
> > > >=20
> > > > Main focus of this series is to stabilize soft offline.  Historical=
ly soft
> > > > offlined pages have suffered from racy conditions because PageHWPoi=
son is
> > > > used to a little too aggressively, which (directly or indirectly) i=
nvades
> > > > other mm code which cares little about hwpoison.  This results in u=
nexpected
> > > > behavior or kernel panic, which is very far from soft offline's "do=
 not
> > > > disturb userspace or other kernel component" policy.
> > > >=20
> > > > Main point of this change set is to contain target page "via buddy =
allocator",
> > > > where we first free the target page as we do for normal pages, and =
remove
> > > > from buddy only when we confirm that it reaches free list. There is=
 surely
> > > > race window of page allocation, but that's fine because someone rea=
lly want
> > > > that page and the page is still working, so soft offline can happil=
y give up.
> > > >=20
> > > > v4 from Oscar tries to handle the race around reallocation, but tha=
t part
> > > > seems still work in progress, so I decide to separate it for change=
s into
> > > > v5.9.  Thank you for your contribution, Oscar.
> > > >=20
> > > > The issue reported by Qian Cai is fixed by patch 16/16.
> > >=20
> > > I am still getting EIO everywhere on next-20200803 (which includes th=
is v5).
> > >=20
> > > # ./random 1
> > > - start: migrate_huge_offline
> > > - use NUMA nodes 0,8.
> > > - mmap and free 8388608 bytes hugepages on node 0
> > > - mmap and free 8388608 bytes hugepages on node 8
> > > madvise: Input/output error
> > >=20
> > > From the serial console,
> > >=20
> > > [  637.164222][ T8357] soft offline: 0x118ee0: hugepage isolation fai=
led: 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
> > > [  637.164890][ T8357] Soft offlining pfn 0x20001380 at process virtu=
al address 0x7fff9f000000
> > > [  637.165422][ T8357] Soft offlining pfn 0x3ba00 at process virtual =
address 0x7fff9f200000
> > > [  637.166409][ T8357] Soft offlining pfn 0x201914a0 at process virtu=
al address 0x7fff9f000000
> > > [  637.166833][ T8357] Soft offlining pfn 0x12b9a0 at process virtual=
 address 0x7fff9f200000
> > > [  637.168044][ T8357] Soft offlining pfn 0x1abb60 at process virtual=
 address 0x7fff9f000000
> > > [  637.168557][ T8357] Soft offlining pfn 0x20014820 at process virtu=
al address 0x7fff9f200000
> > > [  637.169493][ T8357] Soft offlining pfn 0x119720 at process virtual=
 address 0x7fff9f000000
> > > [  637.169603][ T8357] soft offline: 0x119720: hugepage isolation fai=
led: 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
> > > [  637.169756][ T8357] Soft offlining pfn 0x118ee0 at process virtual=
 address 0x7fff9f200000
> > > [  637.170653][ T8357] Soft offlining pfn 0x200e81e0 at process virtu=
al address 0x7fff9f000000
> > > [  637.171067][ T8357] Soft offlining pfn 0x201c5f60 at process virtu=
al address 0x7fff9f200000
> > > [  637.172101][ T8357] Soft offlining pfn 0x201c8f00 at process virtu=
al address 0x7fff9f000000
> > > [  637.172241][ T8357] __get_any_page: 0x201c8f00: unknown zero refco=
unt page type 87fff8000000000
> >=20
> > I might misjudge to skip the following patch, sorry about that.
> > Could you try with it?
>=20
> Still getting EIO after applied this patch.
>=20
> [ 1215.499030][T88982] soft offline: 0x201bdc20: hugepage isolation faile=
d: 0, page count 2, type 87fff800001000e (referenced|uptodate|dirty|head)
> [ 1215.499775][T88982] Soft offlining pfn 0x201bdc20 at process virtual a=
ddress 0x7fff91a00000
> [ 1215.500189][T88982] Soft offlining pfn 0x201c19c0 at process virtual a=
ddress 0x7fff91c00000
> [ 1215.500297][T88982] soft offline: 0x201c19c0: hugepage isolation faile=
d: 0, page count 2, type 87fff800001000e (referenced|uptodate|dirty|head)
> [ 1215.500982][T88982] Soft offlining pfn 0x1f1fa0 at process virtual add=
ress 0x7fff91a00000
> [ 1215.501086][T88982] soft offline: 0x1f1fa0: hugepage isolation failed:=
 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
> [ 1215.501237][T88982] Soft offlining pfn 0x1f4520 at process virtual add=
ress 0x7fff91c00000
> [ 1215.501355][T88982] soft offline: 0x1f4520: hugepage isolation failed:=
 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
> [ 1215.502196][T88982] Soft offlining pfn 0x1f4520 at process virtual add=
ress 0x7fff91a00000
> [ 1215.502573][T88982] Soft offlining pfn 0x1f1fa0 at process virtual add=
ress 0x7fff91c00000
> [ 1215.502687][T88982] soft offline: 0x1f1fa0: hugepage isolation failed:=
 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
> [ 1215.503245][T88982] Soft offlining pfn 0x201c3cc0 at process virtual a=
ddress 0x7fff91a00000
> [ 1215.503594][T88982] Soft offlining pfn 0x201c3ce0 at process virtual a=
ddress 0x7fff91c00000
> [ 1215.503755][T88982] __get_any_page: 0x201c3ce0: unknown zero refcount =
page type 87fff8000000000

So I lean to cancel patch 3/16 where madvise_inject_error() releases page
refcount before calling soft_offline_page(). That should solve the issue
because refcount of the target page never becomes zero.
Patch 4/16, 8/16 and 9/16 depend on it, so they should be removed too.
I'll resubmit the series later, but I prepare the delta below (based on
next-20200805), so it would be appreciated if you can run random.c with it
to confrim the fix.

Thanks,
Naoya Horiguchi
---
From 533090c0869aeca88d8ff14d27c3cef8fc060ccd Mon Sep 17 00:00:00 2001
From: Naoya Horiguchi <naoya.horiguchi@nec.com>
Date: Thu, 6 Aug 2020 01:29:08 +0900
Subject: [PATCH] (for testing) revert change around removing
 MF_COUNT_INCREASED

revert the following patches
- mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
- mm,madvise: Refactor madvise_inject_error
- mm,hwpoison: remove MF_COUNT_INCREASED
- mm,hwpoison: remove flag argument from soft offline functions

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 drivers/base/memory.c |  2 +-
 include/linux/mm.h    |  9 +++++----
 mm/madvise.c          | 36 +++++++++++++++++++-----------------
 mm/memory-failure.c   | 31 ++++++++++++++++++++-----------
 4 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 3e6d27c9dff6..4db3c660de83 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -463,7 +463,7 @@ static ssize_t soft_offline_page_store(struct device *d=
ev,
 	if (kstrtoull(buf, 0, &pfn) < 0)
 		return -EINVAL;
 	pfn >>=3D PAGE_SHIFT;
-	ret =3D soft_offline_page(pfn);
+	ret =3D soft_offline_page(pfn, 0);
 	return ret =3D=3D 0 ? count : ret;
 }
=20
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4f12b2465e80..442921a004a2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2976,9 +2976,10 @@ void register_page_bootmem_memmap(unsigned long sect=
ion_nr, struct page *map,
 				  unsigned long nr_pages);
=20
 enum mf_flags {
-	MF_ACTION_REQUIRED =3D 1 << 0,
-	MF_MUST_KILL =3D 1 << 1,
-	MF_SOFT_OFFLINE =3D 1 << 2,
+	MF_COUNT_INCREASED =3D 1 << 0,
+	MF_ACTION_REQUIRED =3D 1 << 1,
+	MF_MUST_KILL =3D 1 << 2,
+	MF_SOFT_OFFLINE =3D 1 << 3,
 };
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
@@ -2988,7 +2989,7 @@ extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
 extern atomic_long_t num_poisoned_pages __read_mostly;
-extern int soft_offline_page(unsigned long pfn);
+extern int soft_offline_page(unsigned long pfn, int flags);
=20
=20
 /*
diff --git a/mm/madvise.c b/mm/madvise.c
index 843f6fad3b89..5fa5f66468b3 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -886,15 +886,16 @@ static long madvise_remove(struct vm_area_struct *vma=
,
 static int madvise_inject_error(int behavior,
 		unsigned long start, unsigned long end)
 {
+	struct page *page;
 	struct zone *zone;
 	unsigned long size;
=20
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
=20
+
 	for (; start < end; start +=3D size) {
 		unsigned long pfn;
-		struct page *page;
 		int ret;
=20
 		ret =3D get_user_pages_fast(start, 1, 0, &page);
@@ -909,26 +910,27 @@ static int madvise_inject_error(int behavior,
 		 */
 		size =3D page_size(compound_head(page));
=20
-		/*
-		 * The get_user_pages_fast() is just to get the pfn of the
-		 * given address, and the refcount has nothing to do with
-		 * what we try to test, so it should be released immediately.
-		 * This is racy but it's intended because the real hardware
-		 * errors could happen at any moment and memory error handlers
-		 * must properly handle the race.
-		 */
-		put_page(page);
-
 		if (behavior =3D=3D MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
-				pfn, start);
-			ret =3D soft_offline_page(pfn);
-		} else {
-			pr_info("Injecting memory failure for pfn %#lx at process virtual addre=
ss %#lx\n",
-				pfn, start);
-			ret =3D memory_failure(pfn, 0);
+					pfn, start);
+
+			ret =3D soft_offline_page(pfn, MF_COUNT_INCREASED);
+			if (ret)
+				return ret;
+			continue;
 		}
=20
+		pr_info("Injecting memory failure for pfn %#lx at process virtual addres=
s %#lx\n",
+				pfn, start);
+
+		/*
+		 * Drop the page reference taken by get_user_pages_fast(). In
+		 * the absence of MF_COUNT_INCREASED the memory_failure()
+		 * routine is responsible for pinning the page to prevent it
+		 * from being released back to the page allocator.
+		 */
+		put_page(page);
+		ret =3D memory_failure(pfn, 0);
 		if (ret)
 			return ret;
 	}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a229d4694954..fd50a6f9a60d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1167,7 +1167,7 @@ static int memory_failure_hugetlb(unsigned long pfn, =
int flags)
=20
 	num_poisoned_pages_inc();
=20
-	if (!get_hwpoison_page(p)) {
+	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
 		/*
 		 * Check "filter hit" and "race with other subpage."
 		 */
@@ -1363,7 +1363,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * In fact it's dangerous to directly bump up page count from 0,
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
-	if (!get_hwpoison_page(p)) {
+	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
 		if (is_free_buddy_page(p)) {
 			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
 			return 0;
@@ -1392,7 +1392,10 @@ int memory_failure(unsigned long pfn, int flags)
 	shake_page(p, 0);
 	/* shake_page could have turned it free. */
 	if (!PageLRU(p) && is_free_buddy_page(p)) {
-		action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
+		if (flags & MF_COUNT_INCREASED)
+			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
+		else
+			action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
 		return 0;
 	}
=20
@@ -1540,7 +1543,7 @@ static void memory_failure_work_func(struct work_stru=
ct *work)
 		if (!gotten)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
-			soft_offline_page(entry.pfn);
+			soft_offline_page(entry.pfn, entry.flags);
 		else
 			memory_failure(entry.pfn, entry.flags);
 	}
@@ -1679,10 +1682,13 @@ EXPORT_SYMBOL(unpoison_memory);
  * that is not free, and 1 for any other page type.
  * For 1 the page is returned with increased page count, otherwise not.
  */
-static int __get_any_page(struct page *p, unsigned long pfn)
+static int __get_any_page(struct page *p, unsigned long pfn, int flags)
 {
 	int ret;
=20
+	if (flags & MF_COUNT_INCREASED)
+		return 1;
+
 	/*
 	 * When the target page is a free hugepage, just remove it
 	 * from free hugepage list.
@@ -1709,12 +1715,12 @@ static int __get_any_page(struct page *p, unsigned =
long pfn)
 	return ret;
 }
=20
-static int get_any_page(struct page *page, unsigned long pfn)
+static int get_any_page(struct page *page, unsigned long pfn, int flags)
 {
-	int ret =3D __get_any_page(page, pfn);
+	int ret =3D __get_any_page(page, pfn, flags);
=20
 	if (ret =3D=3D -EBUSY)
-		ret =3D __get_any_page(page, pfn);
+		ret =3D __get_any_page(page, pfn, flags);
=20
 	if (ret =3D=3D 1 && !PageHuge(page) &&
 	    !PageLRU(page) && !__PageMovable(page)) {
@@ -1727,7 +1733,7 @@ static int get_any_page(struct page *page, unsigned l=
ong pfn)
 		/*
 		 * Did it turn free?
 		 */
-		ret =3D __get_any_page(page, pfn);
+		ret =3D __get_any_page(page, pfn, 0);
 		if (ret =3D=3D 1 && !PageLRU(page)) {
 			/* Drop page reference which is from __get_any_page() */
 			put_page(page);
@@ -1869,6 +1875,7 @@ static int soft_offline_free_page(struct page *page)
 /**
  * soft_offline_page - Soft offline a page.
  * @pfn: pfn to soft-offline
+ * @flags: flags. Same as memory_failure().
  *
  * Returns 0 on success, otherwise negated errno.
  *
@@ -1887,7 +1894,7 @@ static int soft_offline_free_page(struct page *page)
  * This is not a 100% solution for all memory, but tries to be
  * ``good enough'' for the majority of memory.
  */
-int soft_offline_page(unsigned long pfn)
+int soft_offline_page(unsigned long pfn, int flags)
 {
 	int ret;
 	struct page *page;
@@ -1901,11 +1908,13 @@ int soft_offline_page(unsigned long pfn)
=20
 	if (PageHWPoison(page)) {
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
+		if (flags & MF_COUNT_INCREASED)
+			put_page(page);
 		return 0;
 	}
=20
 	get_online_mems();
-	ret =3D get_any_page(page, pfn);
+	ret =3D get_any_page(page, pfn, flags);
 	put_online_mems();
=20
 	if (ret > 0)
--=20
2.25.1
