Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C1DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B22C2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="pf04KLMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGQGz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:55:59 -0400
Received: from mail-eopbgr1400059.outbound.protection.outlook.com ([40.107.140.59]:26016
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726166AbgGQGz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:55:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4/KNgqQ62iyu+RFAUkvwdoSvIpSyZLsoLj5UQ44oh7ZpCD5MFVPDUYVn+169Y5Bbnc292FO5i8AIOk0uhOIyVGdf+PnhuwX75M1WV66oNDQjUy6BoNBfIO08gPmr3Iu0nEGYYVqu++psfAPn/oIwCGkSoswuqTyr7+IGBaU9qQzvCyj3gpYsDBku3iCDSE3GRV3a7qY91UuIa59Yu97+Tk3kbjCsngz9BeZfnO4ckVkA+lMBMqOzZrBLI1BLcIz60R1Kf/Y+8EPCDHBMWqeheCokGm6BO8B9o6D0GP22IAWW3ubMyV0lT3sSWx/1ICX4Q3A2c1F+nlVTrjjzHyWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sew+sj7R60iMtB0vRGd4Ck2Nt7KLbq8hjZbXmm+WHrY=;
 b=XztWdHk8kwOaa9SI7b7Ys4iJRO1ju8A4QGVaX/GNzZoC9/fcmkEerGyVg0UcoFb76m2zLpJ3UrDYmH7izvrU1DBheYKsBBOnghDEyVytvAgcuFc5jCD/37pU3k2AsFh7TaRdIowWnK3aR93Y0IYvTFUMxxIabfje8S75DINfDUO1KXJEbb+D5k8QZ+8XauUYr/wG3MurRes0Ixn4UTutLiBKtaHtbmWfRPG/J1atTHLcz2PkI1FcgobMqPm/FrghZG0P1ovljjz6LluD12a38PQhDss94pw0DOFqSbyBT8jSbRIvjhA3Xo3s89O3UdOXu9GjR2zR0ALBJmi2VSWm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sew+sj7R60iMtB0vRGd4Ck2Nt7KLbq8hjZbXmm+WHrY=;
 b=pf04KLMm1vPb8wBeBV70uDOqPTcayJAXbZIiqJKpKZwT1yEmEkV7F5IJzpP2cLUjxVIXHSu2YRT1joZJJ6cVmUrDekMvPc6SAomG7abS56tsZ4fOlkpePAmLkSCkLa4GIxJbOcd4UEStRWWkengxuPtYQwqpjjbV4cSi7J2tpyc=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYAPR01MB2767.jpnprd01.prod.outlook.com (2603:1096:404:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 17 Jul
 2020 06:55:53 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::99a9:dbe4:15e2:3c15]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::99a9:dbe4:15e2:3c15%4]) with mapi id 15.20.3174.025; Fri, 17 Jul 2020
 06:55:53 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "david@redhat.com" <david@redhat.com>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.com>
Subject: Re: [PATCH v4 12/15] mm,hwpoison: Rework soft offline for in-use
 pages
Thread-Topic: [PATCH v4 12/15] mm,hwpoison: Rework soft offline for in-use
 pages
Thread-Index: AQHWW24L3MUp+TUYEUyOQLgUEXJef6kLV8IA
Date:   Fri, 17 Jul 2020 06:55:52 +0000
Message-ID: <20200717065552.GA20384@hori.linux.bs1.fc.nec.co.jp>
References: <20200716123810.25292-1-osalvador@suse.de>
 <20200716123810.25292-13-osalvador@suse.de>
In-Reply-To: <20200716123810.25292-13-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba0e7171-4eb5-443a-09f7-08d82a1e7278
x-ms-traffictypediagnostic: TYAPR01MB2767:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB27672F9D863910E6D5B1B199E77C0@TYAPR01MB2767.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jBJjmUt7pMpLNx0u8snOJQrpLRFa5VI9fG+dXGaAIYm4zIqBlppYgFBTuRvHPdiTLQSV4oNW8a98ydsUvfuWGYSOrCEptvg99tMP3GKGGhOTMN8vGCEJEzaeh/HxTIxg6s5Q0soNpXZu+P7tmx/d9VXql3EUr56jMim+hG3Ie12ZBI1N//dyp+PAYYCD/U+IZNk/GwOrv3p8aXF40u5nBuQz9ddfAZkSnUM3/8ViqKgYPt2gPnUp7IJTUJHcnQySdwHvgcLsUYuL69u4XfABmIZWXw4BMawf/fuf/w2MrD1iwCzcRHAh8X9e3fXA/j8cTNneSZIzBJ2KTnbRzYWSVMA4vkZzuC3kUy4ITAMK/M6WjWM+06ZzuT7Kg6MXn/Oq0NqlifROctUTe08wWCj1jp87yohok7oZWS/MopuEoH9Js232XDWa8F0Jm6RHoHj9HTdCp1JhQ6MFwsltZmE4nQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(6916009)(30864003)(66446008)(6506007)(64756008)(4326008)(66946007)(2906002)(26005)(33656002)(76116006)(66556008)(66476007)(186003)(85182001)(83380400001)(55236004)(478600001)(6512007)(71200400001)(86362001)(54906003)(5660300002)(8936002)(316002)(1076003)(8676002)(9686003)(6486002)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8pJS1XyZ3ukRZZRWInXYWGSeXuRMVUwdBOEAWmBm02b4SAmhYmPQOBWo/dQuRF7E3IiyG9bJbCEF9SkVHHBjsJcv6gFq1CVpXga0/M6YjAntjdPHj+HAvqzYBnd1lhHaFYB2/aP99zVXLihlYnBpbg6LNQdK6IdLr1fA6L5/AW7qeJD0nISb7raCDvGQBgX+ihdxsCdIWLNYxxTKy6ofdl3MoBGr5vFbePeCGdz9/8h0dFebClDnrlRoiiTcymPG0ynl9F37X2drB3nq5AyyAz7yGejF04qpJCHyQhvSn1JD8JpGQSiuuRKCZ+mZ+UyfYg6av4b21hKqw3AIV+kGke5jwenl3cYvnLc7SyDK7HrEEYLYPthNUg4QjHuHBMmgjLp4s8EycVQE3ouuRLR0rwY9Q6QONh9RQkBgeyjZVAxawwzE7PPdVtt51GMF9o8VhKvugbcwIkntSU02pKaZoCLnVxliCYyeXU6eCmu/Zs5BYJoEkthyTk+LOEJYmqn3
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <7AC0E0D1AA659147837FA6AEE3DE1154@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0e7171-4eb5-443a-09f7-08d82a1e7278
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 06:55:52.9500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNe+d/T2JIoqBrL8KO5+eS82RQmB70awNN6ILxTxqpiCGoMb78oDY0cTzYOjYnq8J15XDghw2H4EhabrahujZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 02:38:06PM +0200, Oscar Salvador wrote:
> This patch changes the way we set and handle in-use poisoned pages.
> Until now, poisoned pages were released to the buddy allocator, trusting
> that the checks that take place prior to deliver the page to its end
> user would act as a safe net and would skip that page.
>=20
> This has proved to be wrong, as we got some pfn walkers out there, like
> compaction, that all they care is the page to be PageBuddy and be in a
> freelist.
> Although this might not be the only user, having poisoned pages
> in the buddy allocator seems a bad idea as we should only have
> free pages that are ready and meant to be used as such.
>=20
> Before explaining the taken approach, let us break down the kind
> of pages we can soft offline.
>=20
> - Anonymous THP (after the split, they end up being 4K pages)
> - Hugetlb
> - Order-0 pages (that can be either migrated or invalited)
>=20
> * Normal pages (order-0 and anon-THP)
>=20
>   - If they are clean and unmapped page cache pages, we invalidate
>     then by means of invalidate_inode_page().
>   - If they are mapped/dirty, we do the isolate-and-migrate dance.
>=20
>   Either way, do not call put_page directly from those paths.
>   Instead, we keep the page and send it to page_set_poison to perform the
>   right handling.
>=20
>   Among other things, page_set_poison() sets the HWPoison flag and does t=
he last
>   put_page.
>   This call to put_page is mainly to be able to call __page_cache_release=
,
>   since this function is not exported.
>=20
>   Down the chain, we placed a check for HWPoison page in
>   free_pages_prepare, that just skips any poisoned page, so those pages
>   do not end up either in a pcplist or in buddy-freelist.
>=20
>   After that, we set the refcount on the page to 1 and we increment
>   the poisoned pages counter.
>=20
>   We could do as we do for free pages:
>   1) wait until the page hits buddy's freelists
>   2) take it off
>   3) flag it
>=20
>   The problem is that we could race with an allocation, so by the time we
>   want to take the page off the buddy, the page is already allocated, so =
we
>   cannot soft-offline it.
>   This is not fatal of course, but if it is better if we can close the ra=
ce
>   as does not require a lot of code.
>=20
> * Hugetlb pages
>=20
>   - We isolate-and-migrate them
>=20
>   There is no magic in here, we just isolate and migrate them.
>   A new set of internal functions have been made to flag a hugetlb page a=
s
>   poisoned (SetPageHugePoisoned(), PageHugePoisoned(), ClearPageHugePoiso=
ned())
>   This allows us to flag the page when we migrate it, back in
>   move_hugetlb_state().
>
>   Later on we check whether the page is poisoned in __free_huge_page,
>   and we bail out in that case before sending the page to e.g: active
>   free list.
>   This gives us full control of the page, and we can handle it
>   page_handle_poison().
>=20
>   In other words, we do not allow migrated hugepages to get back to the
>   freelists.
>=20
>   Since now the page has no user and has been migrated, we can call
>   dissolve_free_huge_page, which will end up calling update_and_free_page=
.
>   In update_and_free_page(), we check for the page to be poisoned.
>   If it so, we handle it as we handle gigantic pages, i.e: we break down
>   the page in order-0 pages and free them one by one.
>   Doing so, allows us for free_pages_prepare to skip poisoned pages.
>=20
> Because of the way we handle now in-use pages, we no longer need the
> put-as-isolation-migratetype dance, that was guarding for poisoned pages
> to end up in pcplists.

I ran Quan Cai's test program (https://github.com/cailca/linux-mm) on a
small (4GB memory) VM, and weiredly found that (1) the target hugepages
are not always dissolved and (2) dissovled hugetpages are still counted
in "HugePages_Total:". See below:

    $ ./random 1
    - start: migrate_huge_offline
    - use NUMA nodes 0,1.
    - mmap and free 8388608 bytes hugepages on node 0
    - mmap and free 8388608 bytes hugepages on node 1
    madvise: Cannot allocate memory

    $ cat /proc/meminfo
    MemTotal:        4026772 kB
    MemFree:          976300 kB
    MemAvailable:     892840 kB
    Buffers:           20936 kB
    Cached:            99768 kB
    SwapCached:         5904 kB
    Active:            84332 kB
    Inactive:         116328 kB
    Active(anon):      27944 kB
    Inactive(anon):    68524 kB
    Active(file):      56388 kB
    Inactive(file):    47804 kB
    Unevictable:        7532 kB
    Mlocked:               0 kB
    SwapTotal:       2621436 kB
    SwapFree:        2609844 kB
    Dirty:                56 kB
    Writeback:             0 kB
    AnonPages:         81764 kB
    Mapped:            54348 kB
    Shmem:              8948 kB
    KReclaimable:      22744 kB
    Slab:              52056 kB
    SReclaimable:      22744 kB
    SUnreclaim:        29312 kB
    KernelStack:        3888 kB
    PageTables:         2804 kB
    NFS_Unstable:          0 kB
    Bounce:                0 kB
    WritebackTmp:          0 kB
    CommitLimit:     3260612 kB
    Committed_AS:     828196 kB
    VmallocTotal:   34359738367 kB
    VmallocUsed:       19260 kB
    VmallocChunk:          0 kB
    Percpu:             5120 kB
    HardwareCorrupted:  5368 kB
    AnonHugePages:     18432 kB
    ShmemHugePages:        0 kB
    ShmemPmdMapped:        0 kB
    FileHugePages:         0 kB
    FilePmdMapped:         0 kB
    CmaTotal:              0 kB
    CmaFree:               0 kB
    HugePages_Total:    1342     // still counted as hugetlb pages.
    HugePages_Free:        0     // all hugepage are still allocated (or le=
aked?)
    HugePages_Rsvd:        0
    HugePages_Surp:      762     // some are counted in surplus.
    Hugepagesize:       2048 kB
    Hugetlb:         2748416 kB
    DirectMap4k:      112480 kB
    DirectMap2M:     4081664 kB


    $ page-types -b hwpoison
                 flags      page-count       MB  symbolic-flags            =
         long-symbolic-flags
    0x0000000000080008             421        1  ___U_______________X______=
_________________      uptodate,hwpoison
    0x00000000000a8018               1        0  ___UD__________H_G_X______=
_________________      uptodate,dirty,compound_head,huge,hwpoison
    0x00000000000a801c             920        3  __RUD__________H_G_X______=
_________________      referenced,uptodate,dirty,compound_head,huge,hwpoiso=
n
                 total            1342        5

This means that some hugepages are dissolved, but the others not,
maybe which is not desirable.
I'll dig this more later but just let me share at first.

A few minor comment below ...

>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  include/linux/page-flags.h |  5 ----
>  mm/hugetlb.c               | 60 +++++++++++++++++++++++++++++++++-----
>  mm/memory-failure.c        | 53 +++++++++++++--------------------
>  mm/migrate.c               | 11 ++-----
>  mm/page_alloc.c            | 38 +++++++-----------------
>  5 files changed, 86 insertions(+), 81 deletions(-)
>=20
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 01baf6d426ff..2ac8bfa0cf20 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -426,13 +426,8 @@ PAGEFLAG(HWPoison, hwpoison, PF_ANY)
>  TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
>  #define __PG_HWPOISON (1UL << PG_hwpoison)
>  extern bool take_page_off_buddy(struct page *page);
> -extern bool set_hwpoison_free_buddy_page(struct page *page);
>  #else
>  PAGEFLAG_FALSE(HWPoison)
> -static inline bool set_hwpoison_free_buddy_page(struct page *page)
> -{
> -	return 0;
> -}
>  #define __PG_HWPOISON 0
>  #endif
> =20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7badb01d15e3..1c6397936512 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -29,6 +29,7 @@
>  #include <linux/numa.h>
>  #include <linux/llist.h>
>  #include <linux/cma.h>
> +#include <linux/migrate.h>
> =20
>  #include <asm/page.h>
>  #include <asm/pgalloc.h>
> @@ -1209,9 +1210,26 @@ static int hstate_next_node_to_free(struct hstate =
*h, nodemask_t *nodes_allowed)
>  		((node =3D hstate_next_node_to_free(hs, mask)) || 1);	\
>  		nr_nodes--)
> =20
> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> -static void destroy_compound_gigantic_page(struct page *page,
> -					unsigned int order)
> +static inline bool PageHugePoisoned(struct page *page)
> +{
> +	if (!PageHuge(page))
> +		return false;
> +
> +	return (unsigned long)page[3].mapping =3D=3D -1U;
> +}
> +
> +static inline void SetPageHugePoisoned(struct page *page)
> +{
> +	page[3].mapping =3D (void *)-1U;
> +}
> +
> +static inline void ClearPageHugePoisoned(struct page *page)
> +{
> +	page[3].mapping =3D NULL;
> +}
> +
> +static void destroy_compound_gigantic_page(struct hstate *h, struct page=
 *page,
> +					   unsigned int order)
>  {
>  	int i;
>  	int nr_pages =3D 1 << order;
> @@ -1222,14 +1240,19 @@ static void destroy_compound_gigantic_page(struct=
 page *page,
>  		atomic_set(compound_pincount_ptr(page), 0);
> =20
>  	for (i =3D 1; i < nr_pages; i++, p =3D mem_map_next(p, page, i)) {
> +		if (!hstate_is_gigantic(h))
> +			 p->mapping =3D NULL;
>  		clear_compound_head(p);
>  		set_page_refcounted(p);
>  	}
> =20
> +	if (PageHugePoisoned(page))
> +		ClearPageHugePoisoned(page);
>  	set_compound_order(page, 0);
>  	__ClearPageHead(page);
>  }
> =20
> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>  static void free_gigantic_page(struct page *page, unsigned int order)
>  {
>  	/*
> @@ -1284,13 +1307,16 @@ static struct page *alloc_gigantic_page(struct hs=
tate *h, gfp_t gfp_mask,
>  	return NULL;
>  }
>  static inline void free_gigantic_page(struct page *page, unsigned int or=
der) { }
> -static inline void destroy_compound_gigantic_page(struct page *page,
> -						unsigned int order) { }
> +static inline void destroy_compound_gigantic_page(struct hstate *h,
> +						  struct page *page,
> +						  unsigned int order) { }
>  #endif
> =20
>  static void update_and_free_page(struct hstate *h, struct page *page)
>  {
>  	int i;
> +	bool poisoned =3D PageHugePoisoned(page);
> +	unsigned int order =3D huge_page_order(h);
> =20
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>  		return;
> @@ -1313,11 +1339,21 @@ static void update_and_free_page(struct hstate *h=
, struct page *page)
>  		 * we might block in free_gigantic_page().
>  		 */
>  		spin_unlock(&hugetlb_lock);
> -		destroy_compound_gigantic_page(page, huge_page_order(h));
> -		free_gigantic_page(page, huge_page_order(h));
> +		destroy_compound_gigantic_page(h, page, order);
> +		free_gigantic_page(page, order);
>  		spin_lock(&hugetlb_lock);
>  	} else {
> -		__free_pages(page, huge_page_order(h));
> +		if (unlikely(poisoned)) {
> +			/*
> +			 * If the hugepage is poisoned, do as we do for
> +			 * gigantic pages and free the pages as order-0.
> +			 * free_pages_prepare will skip over the poisoned ones.
> +			 */
> +			destroy_compound_gigantic_page(h, page, order);

This function is for gigantic page from its name, so shouldn't be called
for non-gigantic huge page. Maybe renaming it and/or introducing some inner
function layer to factor out common part would be better.

> +			free_contig_range(page_to_pfn(page), 1 << order);
> +		} else {
> +			__free_pages(page, huge_page_order(h));
> +		}
>  	}
>  }
> =20
> @@ -1427,6 +1463,11 @@ static void __free_huge_page(struct page *page)
>  	if (restore_reserve)
>  		h->resv_huge_pages++;
> =20
> +	if (PageHugePoisoned(page)) {
> +		spin_unlock(&hugetlb_lock);
> +		return;
> +	}
> +
>  	if (PageHugeTemporary(page)) {
>  		list_del(&page->lru);
>  		ClearPageHugeTemporary(page);
> @@ -5642,6 +5683,9 @@ void move_hugetlb_state(struct page *oldpage, struc=
t page *newpage, int reason)
>  	hugetlb_cgroup_migrate(oldpage, newpage);
>  	set_page_owner_migrate_reason(newpage, reason);
> =20
> +	if (reason =3D=3D MR_MEMORY_FAILURE)
> +		SetPageHugePoisoned(oldpage);
> +
>  	/*
>  	 * transfer temporary state of the new huge page. This is
>  	 * reverse to other transitions because the newpage is going to
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index caf012d34607..c0ebab4eed4c 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -65,9 +65,17 @@ int sysctl_memory_failure_recovery __read_mostly =3D 1=
;
> =20
>  atomic_long_t num_poisoned_pages __read_mostly =3D ATOMIC_LONG_INIT(0);
> =20
> -static void page_handle_poison(struct page *page)
> +static void page_handle_poison(struct page *page, bool release, bool set=
_flag,
> +			       bool huge_flag)
>  {
> -	SetPageHWPoison(page);
> +	if (set_flag)
> +		SetPageHWPoison(page);
> +
> +        if (huge_flag)
> +		dissolve_free_huge_page(page);
> +        else if (release)
> +		put_page(page);
> +

Indentation seems to be broken, you can run checkpatch.pl to find details.

Thanks,
Naoya Horiguchi

>  	page_ref_inc(page);
>  	num_poisoned_pages_inc();
>  }
> @@ -1717,7 +1725,7 @@ static int get_any_page(struct page *page, unsigned=
 long pfn)
> =20
>  static int soft_offline_huge_page(struct page *page)
>  {
> -	int ret;
> +	int ret =3D -EBUSY;
>  	unsigned long pfn =3D page_to_pfn(page);
>  	struct page *hpage =3D compound_head(page);
>  	LIST_HEAD(pagelist);
> @@ -1757,19 +1765,12 @@ static int soft_offline_huge_page(struct page *pa=
ge)
>  			ret =3D -EIO;
>  	} else {
>  		/*
> -		 * We set PG_hwpoison only when the migration source hugepage
> -		 * was successfully dissolved, because otherwise hwpoisoned
> -		 * hugepage remains on free hugepage list, then userspace will
> -		 * find it as SIGBUS by allocation failure. That's not expected
> -		 * in soft-offlining.
> +		 * At this point the page cannot be in-use since we do not
> +		 * let the page to go back to hugetlb freelists.
> +		 * In that case we just need to dissolve it.
> +		 * page_handle_poison will take care of it.
>  		 */
> -		ret =3D dissolve_free_huge_page(page);
> -		if (!ret) {
> -			if (set_hwpoison_free_buddy_page(page))
> -				num_poisoned_pages_inc();
> -			else
> -				ret =3D -EBUSY;
> -		}
> +		page_handle_poison(page, true, true, true);
>  	}
>  	return ret;
>  }
> @@ -1804,10 +1805,8 @@ static int __soft_offline_page(struct page *page)
>  	 * would need to fix isolation locking first.
>  	 */
>  	if (ret =3D=3D 1) {
> -		put_page(page);
>  		pr_info("soft_offline: %#lx: invalidated\n", pfn);
> -		SetPageHWPoison(page);
> -		num_poisoned_pages_inc();
> +		page_handle_poison(page, true, true, false);
>  		return 0;
>  	}
> =20
> @@ -1838,7 +1837,9 @@ static int __soft_offline_page(struct page *page)
>  		list_add(&page->lru, &pagelist);
>  		ret =3D migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
>  					MIGRATE_SYNC, MR_MEMORY_FAILURE);
> -		if (ret) {
> +		if (!ret) {
> +			page_handle_poison(page, true, true, false);
> +		} else {
>  			if (!list_empty(&pagelist))
>  				putback_movable_pages(&pagelist);
> =20
> @@ -1857,37 +1858,25 @@ static int __soft_offline_page(struct page *page)
>  static int soft_offline_in_use_page(struct page *page)
>  {
>  	int ret;
> -	int mt;
>  	struct page *hpage =3D compound_head(page);
> =20
>  	if (!PageHuge(page) && PageTransHuge(hpage))
>  		if (try_to_split_thp_page(page, "soft offline") < 0)
>  			return -EBUSY;
> =20
> -	/*
> -	 * Setting MIGRATE_ISOLATE here ensures that the page will be linked
> -	 * to free list immediately (not via pcplist) when released after
> -	 * successful page migration. Otherwise we can't guarantee that the
> -	 * page is really free after put_page() returns, so
> -	 * set_hwpoison_free_buddy_page() highly likely fails.
> -	 */
> -	mt =3D get_pageblock_migratetype(page);
> -	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
>  	if (PageHuge(page))
>  		ret =3D soft_offline_huge_page(page);
>  	else
>  		ret =3D __soft_offline_page(page);
> -	set_pageblock_migratetype(page, mt);
>  	return ret;
>  }
> =20
>  static int soft_offline_free_page(struct page *page)
>  {
>  	int rc =3D -EBUSY;
> -	int rc =3D dissolve_free_huge_page(page);
> =20
>  	if (!dissolve_free_huge_page(page) && take_page_off_buddy(page)) {
> -		page_handle_poison(page);
> +		page_handle_poison(page, false, true, false);
>  		rc =3D 0;
>  	}
> =20
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 75c10d81e833..a68d81d0ae6e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1222,16 +1222,11 @@ static int unmap_and_move(new_page_t get_new_page=
,
>  	 * we want to retry.
>  	 */
>  	if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
> -		put_page(page);
> -		if (reason =3D=3D MR_MEMORY_FAILURE) {
> +		if (reason !=3D MR_MEMORY_FAILURE)
>  			/*
> -			 * Set PG_HWPoison on just freed page
> -			 * intentionally. Although it's rather weird,
> -			 * it's how HWPoison flag works at the moment.
> +			 * We handle poisoned pages in page_handle_poison.
>  			 */
> -			if (set_hwpoison_free_buddy_page(page))
> -				num_poisoned_pages_inc();
> -		}
> +			put_page(page);
>  	} else {
>  		if (rc !=3D -EAGAIN) {
>  			if (likely(!__PageMovable(page))) {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4fa0e0887c07..11df51fc2718 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1175,6 +1175,16 @@ static __always_inline bool free_pages_prepare(str=
uct page *page,
> =20
>  	trace_mm_page_free(page, order);
> =20
> +	if (unlikely(PageHWPoison(page)) && !order) {
> +		/*
> +		 * Untie memcg state and reset page's owner
> +		 */
> +		if (memcg_kmem_enabled() && PageKmemcg(page))
> +			__memcg_kmem_uncharge_page(page, order);
> +		reset_page_owner(page, order);
> +		return false;
> +	}
> +
>  	/*
>  	 * Check tail pages before head page information is cleared to
>  	 * avoid checking PageCompound for order-0 pages.
> @@ -8844,32 +8854,4 @@ bool take_page_off_buddy(struct page *page)
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  	return ret;
>  }
> -
> -/*
> - * Set PG_hwpoison flag if a given page is confirmed to be a free page. =
 This
> - * test is performed under the zone lock to prevent a race against page
> - * allocation.
> - */
> -bool set_hwpoison_free_buddy_page(struct page *page)
> -{
> -	struct zone *zone =3D page_zone(page);
> -	unsigned long pfn =3D page_to_pfn(page);
> -	unsigned long flags;
> -	unsigned int order;
> -	bool hwpoisoned =3D false;
> -
> -	spin_lock_irqsave(&zone->lock, flags);
> -	for (order =3D 0; order < MAX_ORDER; order++) {
> -		struct page *page_head =3D page - (pfn & ((1 << order) - 1));
> -
> -		if (PageBuddy(page_head) && page_order(page_head) >=3D order) {
> -			if (!TestSetPageHWPoison(page))
> -				hwpoisoned =3D true;
> -			break;
> -		}
> -	}
> -	spin_unlock_irqrestore(&zone->lock, flags);
> -
> -	return hwpoisoned;
> -}
>  #endif
> --=20
> 2.26.2
> =
