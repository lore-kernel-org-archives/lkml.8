Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA55C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3F22076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="phncpLC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgHCNhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:37:09 -0400
Received: from mail-eopbgr1400057.outbound.protection.outlook.com ([40.107.140.57]:31465
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726862AbgHCNhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:37:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVLOmtIckgytvMoubv1x50LbEytmPJTqQDKspSPtgcSnhPTy3cGTUh0cxAOaHEgLjljMtKkmEv6hAXWyFy/DRuyNUKYsN8DmrVTUm9/H+VEHyXE0JSfyQxVocPeyYIJsrDVGFig5zM7ql5eQIE5RiWE09vBAb06yQjAIOLndeWjwqhmRR6k/rKrmoCF/yEmBdz5lceKJxxvI9NQVyyzlpWB5RVSUp3mwq8knMpdCvi8mZqC6fk7FlQnm2tC3/+/WvirI3BfCZWjHZchwA/Daf8dbyC4Bmqt81DTIJPS2bYjzwrkB6FCt2f8wqmpryiUdmfRnlhfe41p17cdxB72F4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVA1U10WEJ/5JvxQKcf7plkrgzr5zwxXutpbVmpEvV4=;
 b=jYAPx3lfx9ZSurlp/LiAVlj93nWWXEx0foZ2Sxk1c+OMefFj4YnjvZjkcHT40ZPimmfymP40QkVmX7hfPYnDl4C7QITA5C7eErI71IHbccxgw+E7kiYvl2qvIGBQp8qL2hxX7lfPbqlVbsJ9gQeLkz8vrVmzCrvSwe4KcU8M3ZMOYnOrD8X3T5/tKwheeArQdNrUEhWyMck860uTSQ4kAF1Oe7m/sTTe6f4/YjC+YMUZzvYNSix3nwwdtXQw2d7INZmxf5Zn/uHWYp0tA3KmP756JYkiGOAJ0Udr2FSg/NIu5NXEv31Ay9iyEOl7wTvWX6JThNmyY0i4GZ+GFHDn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVA1U10WEJ/5JvxQKcf7plkrgzr5zwxXutpbVmpEvV4=;
 b=phncpLC4BI8ubQKmuyG9DyCzRMweIqFShWoPnYhZPVxZ0Upol6hvHw8RoDO38RYP/3BRiCKX+UFsObEav0nzUSVs5fieKE9TVItCBayehoY8OHEF+/bT5ha2pimEePzCfKKbIwghcvLs/msiC5LaDjyNbwtwy3CAm3arNBb7nMs=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYAPR01MB5053.jpnprd01.prod.outlook.com (2603:1096:404:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Mon, 3 Aug
 2020 13:36:58 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 13:36:58 +0000
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
Thread-Index: AQHWaZM8vhDjVzP7UUGE+zgLjtO6e6kmYyqA
Date:   Mon, 3 Aug 2020 13:36:58 +0000
Message-ID: <20200803133657.GA13307@hori.linux.bs1.fc.nec.co.jp>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
 <20200803123954.GA4631@lca.pw>
In-Reply-To: <20200803123954.GA4631@lca.pw>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lca.pw; dkim=none (message not signed)
 header.d=none;lca.pw; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc915d97-17b2-4cac-c74d-08d837b24b66
x-ms-traffictypediagnostic: TYAPR01MB5053:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB505360F214AA6ADE16D17616E74D0@TYAPR01MB5053.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nfwX1hk4Y0OCx28gG6vRoLkFW1SyxPy9WlOhUQi783AM65yBVDiuVDpkq6we9mnBFW+XldMyw6wIxgDpWA4kcs/6JA9MZ0++4pCBoGzeJ7ZJ5VrbPy8siAPClK9xDS48MrcTq3jWsch4Y1Q4x/jM3Tm4JElD0kdj0Uk4kCXN2MhVAQ4dLg1hmJXN5vWQtMlAh5RUkYVsgzQ6/wuNHWPOe7viOXav9WgUraUD78oqGnaZCufT4zGNQAZhtbq97DyEGDMxD6dx6k4aW4N76LthyIOtz9UAKM4H/p/bZ67kY0TqDtP4SHzCZyoe05c3QaS4UGL8Ws8cz77m85U8bWRhmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(66446008)(55236004)(33656002)(6506007)(85182001)(53546011)(9686003)(71200400001)(76116006)(66946007)(66556008)(64756008)(6916009)(6512007)(66476007)(86362001)(478600001)(6486002)(83380400001)(8936002)(7416002)(2906002)(8676002)(1076003)(316002)(26005)(5660300002)(54906003)(186003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qM/GINDA4h/loEsNEQivNFnLS4pJ9gonTPHx2QfijiZL20xa74PbEa3OC8hQdQNEaLi1kTSgBbBUKHfa7Mm2/QtI99NcSppfy2Y1r4+7ysMP3bQAWjtubMCglbfLUDrJXGV5ND61PvKW6poTSh9O80hyDO1mpYae8lk0i/ZbB7BY37E+GcMR6RielXSetNEc3+uTM9JlIaeF7PWp7tL31UY3ty9fIvR27gxP9D9tGqcZBmjryozsM7z4+Ol6N3Y/4ItMwVx2FRW9amuY1Ret/FP7igRHLzimOkr7Xioly3fUf7obkW7txA67FsUf9GKYWyN8ja27B/YECM+6LP5ViM5OvbqfVua17aQ3nB7Asgki/fKe5R+5OHcKafCBTDe4pvZVpa5ZYcRoMNNWHGcz8VBx5meWy1EH24tSe9PdVtGDJNViZypE1A8vKv1GwwUi9HvQEwoxy6mb/YxuVfOFuEW1SjxabX2VJAeuazR48oOrRjHPrfauQfngCeQRtoQjkM71aMZ7B/DRyoMX5Pv3VCiCQfLDZ9fvpmODS13Sw0uerIpG70l2GhwlKnioyVE3iWzUU76UmWN/CEp+ScZ7m48jAjWUCgFW6gaed68hJo14MvCK3552fWGaNLPXWHiKK7e8GakpmiDCa2ANc3oMIw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D3348E932E7B3B4FB91D1512DDCE39E9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc915d97-17b2-4cac-c74d-08d837b24b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 13:36:58.0828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Huk10hRF2WJGabLMqoM3y1u5qQiwVi4eJQuPr6IZqQZueslT453wobtnzpt4T04iFhlJxgWPmbNc/C64lSPiNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Aug 03, 2020 at 08:39:55AM -0400, Qian Cai wrote:
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
>=20
> I am still getting EIO everywhere on next-20200803 (which includes this v=
5).
>=20
> # ./random 1
> - start: migrate_huge_offline
> - use NUMA nodes 0,8.
> - mmap and free 8388608 bytes hugepages on node 0
> - mmap and free 8388608 bytes hugepages on node 8
> madvise: Input/output error
>=20
> From the serial console,
>=20
> [  637.164222][ T8357] soft offline: 0x118ee0: hugepage isolation failed:=
 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
> [  637.164890][ T8357] Soft offlining pfn 0x20001380 at process virtual a=
ddress 0x7fff9f000000
> [  637.165422][ T8357] Soft offlining pfn 0x3ba00 at process virtual addr=
ess 0x7fff9f200000
> [  637.166409][ T8357] Soft offlining pfn 0x201914a0 at process virtual a=
ddress 0x7fff9f000000
> [  637.166833][ T8357] Soft offlining pfn 0x12b9a0 at process virtual add=
ress 0x7fff9f200000
> [  637.168044][ T8357] Soft offlining pfn 0x1abb60 at process virtual add=
ress 0x7fff9f000000
> [  637.168557][ T8357] Soft offlining pfn 0x20014820 at process virtual a=
ddress 0x7fff9f200000
> [  637.169493][ T8357] Soft offlining pfn 0x119720 at process virtual add=
ress 0x7fff9f000000
> [  637.169603][ T8357] soft offline: 0x119720: hugepage isolation failed:=
 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
> [  637.169756][ T8357] Soft offlining pfn 0x118ee0 at process virtual add=
ress 0x7fff9f200000
> [  637.170653][ T8357] Soft offlining pfn 0x200e81e0 at process virtual a=
ddress 0x7fff9f000000
> [  637.171067][ T8357] Soft offlining pfn 0x201c5f60 at process virtual a=
ddress 0x7fff9f200000
> [  637.172101][ T8357] Soft offlining pfn 0x201c8f00 at process virtual a=
ddress 0x7fff9f000000
> [  637.172241][ T8357] __get_any_page: 0x201c8f00: unknown zero refcount =
page type 87fff8000000000

I might misjudge to skip the following patch, sorry about that.
Could you try with it?

---
From eafe6fde94cd15e67631540f1b2b000b6e33a650 Mon Sep 17 00:00:00 2001
From: Oscar Salvador <osalvador@suse.de>
Date: Mon, 3 Aug 2020 22:25:10 +0900
Subject: [PATCH] mm,hwpoison: Drain pcplists before bailing out for non-bud=
dy
 zero-refcount page

A page with 0-refcount and !PageBuddy could perfectly be a pcppage.
Currently, we bail out with an error if we encounter such a page,
meaning that we do not handle pcppages neither from hard-offline
nor from soft-offline path.

Fix this by draining pcplists whenever we find this kind of page
and retry the check again.
It might be that pcplists have been spilled into the buddy allocator
and so we can handle it.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b2753ce2b85b..02be529445c0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -949,13 +949,13 @@ static int page_action(struct page_state *ps, struct =
page *p,
 }
=20
 /**
- * get_hwpoison_page() - Get refcount for memory error handling:
+ * __get_hwpoison_page() - Get refcount for memory error handling:
  * @page:	raw error page (hit by memory error)
  *
  * Return: return 0 if failed to grab the refcount, otherwise true (some
  * non-zero value.)
  */
-static int get_hwpoison_page(struct page *page)
+static int __get_hwpoison_page(struct page *page)
 {
 	struct page *head =3D compound_head(page);
=20
@@ -985,6 +985,28 @@ static int get_hwpoison_page(struct page *page)
 	return 0;
 }
=20
+static int get_hwpoison_page(struct page *p)
+{
+	int ret;
+	bool drained =3D false;
+
+retry:
+	ret =3D __get_hwpoison_page(p);
+	if (!ret) {
+		if (!is_free_buddy_page(p) && !page_count(p) && !drained) {
+			/*
+			 * The page might be in a pcplist, so try to drain
+			 * those and see if we are lucky.
+			 */
+			drain_all_pages(page_zone(p));
+			drained =3D true;
+			goto retry;
+		}
+	}
+
+	return ret;
+}
+
 /*
  * Do all that is necessary to remove user space mappings. Unmap
  * the pages and send SIGBUS to the processes if the data was dirty.
@@ -1683,10 +1705,6 @@ static int __get_any_page(struct page *p, unsigned l=
ong pfn)
 {
 	int ret;
=20
-	/*
-	 * When the target page is a free hugepage, just remove it
-	 * from free hugepage list.
-	 */
 	if (!get_hwpoison_page(p)) {
 		if (PageHuge(p)) {
 			pr_info("%s: %#lx free huge page\n", __func__, pfn);
--=20
2.25.1=
