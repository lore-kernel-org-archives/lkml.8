Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3C0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCF22064B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uA+y2EN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgHCK7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:59:08 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:34828 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCK7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:59:06 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200803105900epoutp044e2d795288e57849bc34801c36ef423b~nvPH_kSiF2306923069epoutp04B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 10:59:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200803105900epoutp044e2d795288e57849bc34801c36ef423b~nvPH_kSiF2306923069epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596452340;
        bh=By/d3ifrSJ3/GAiiHamniZn2gCSczuN28nqSD7QoLj8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uA+y2EN5iLdpvvS9/6HThINVDq3B0tG0vAYANA3hNmdYG3TDa2pyKqAyaaTrcy36z
         kmGqHsptO+TfGwzLIMy4wEluMFuz6Nw8Nn6tg+xN41gZQ/tlJYcJ0KOkfJ54NaL1Jf
         Z8e78foYeyvrW8Zpim/mZ2LcRwyFzii9y55mBFsA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200803105900epcas2p36086c979d7a7ed6e2f1622f93af95c09~nvPHn9R9V2498624986epcas2p3H;
        Mon,  3 Aug 2020 10:59:00 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.191]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BKvyV0h5hzMqYkY; Mon,  3 Aug
        2020 10:58:58 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.4C.18874.1FDE72F5; Mon,  3 Aug 2020 19:58:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200803105857epcas2p48c9654ff5a25cce40e99ac652bf146f2~nvPFa3PRI2407324073epcas2p4W;
        Mon,  3 Aug 2020 10:58:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200803105857epsmtrp2784ff154d55bc994a3ee84f5056ec8cd~nvPFaWz3L0782407824epsmtrp2w;
        Mon,  3 Aug 2020 10:58:57 +0000 (GMT)
X-AuditID: b6c32a46-503ff700000049ba-25-5f27edf1d984
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.F3.08382.1FDE72F5; Mon,  3 Aug 2020 19:58:57 +0900 (KST)
Received: from KEI (unknown [12.36.155.227]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200803105857epsmtip1ef0ac36f3860cac3c63695531e90e3f3~nvPFMfHva1899718997epsmtip1J;
        Mon,  3 Aug 2020 10:58:57 +0000 (GMT)
Date:   Mon, 3 Aug 2020 19:51:28 +0900
From:   Cho KyongHo <pullip.cho@samsung.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvac.org,
        akpm@linux-foundation.org, hyesoo.yu@samsung.com,
        janghyuck.kim@samsung.com
Subject: Re: [PATCH] mm: sort freelist by rank number
Message-ID: <20200803105128.GB112174@KEI>
MIME-Version: 1.0
In-Reply-To: <5f41af0f-4593-3441-12f4-5b0f7e6999ac@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmue6nt+rxBpvWM1nMWb+GzeLr+l/M
        Fn87L7BabJ5TbHF51xw2i+sz57A7sHnc3zad0ePEjN8sHu/3XWXz6NuyitHj8ya5ANaoHJuM
        1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoAOUFMoSc0qB
        QgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWGhgV6xYm5xaV56XrJ+blWhgYGRqZAlQk5Gec7
        vjMXrMyt6Hz7mrGB8UhYFyMnh4SAicShmUcYuxi5OIQEdjBKfDi+FMr5xCix/OJsKOcbo8Sm
        8+uZYVrubjgOldjLKHHq6DYmCOcho8Tvi9PZQKpYBFQk1k6eBdbBJqAlsXouSAcnh4iAhsSm
        tg1gcWaBJkaJXRvDQWxhAVOJw52dLCA2r4CmxPNpExghbEGJkzOfgMU5Bewkjm26DRTn4BAF
        mv/qYD3IXgmBr+wSr5efY4K4zkXi4uRV7BC2sMSr41ugbCmJz+/2skE0TGeUeDf/EBtEYjOj
        xLfdghC2scSsZ+2MEMdlSJxau4AdZJmEgLLEkVssEGE+iY7Df6HCvBIdbUIQnSoSO6deY4FZ
        1bf3BpTtIdH+pJsdEj7nGCUudJ1mmsAoPwvJa7OQbIOwdSQW7P7ENgtoBbOAtMTyfxwQpqbE
        +l36CxhZVzGKpRYU56anFhsVGCHH9iZGcOrUctvBOOXtB71DjEwcjIcYJTiYlUR4//5Tjhfi
        TUmsrEotyo8vKs1JLT7EaAqMp4nMUqLJ+cDknVcSb2hqZGZmYGlqYWpmZKEkzluveCFOSCA9
        sSQ1OzW1ILUIpo+Jg1OqgWmXzH+ldwzlU30ip79/O6Xo1ps10nodLEyrDgt9+XTY9GbTHmen
        1e922nU57Io7w3w6mvnLdrFcr4aoaTx3LS3TTv+YIim4+uS2yKPh2Wv/HTeelVu4/On0y9uv
        LUr0qqxm3zej/2rbmYNnux+Lb+l9LLipc/olkbtP1H1OWtzSvj9Tb3/F+UbrK3wPJlnpHbu5
        b+eLlWd+qux/n8t5IHZtj9GhH5vF9862id0xV/PN/xlfF+zKOxB5KU5urj5L0HWDzgu+yekf
        j952VFx6ntcpt3bR0yKZy3pcE4/9un79wu0qt9fW6vOTZpUyRIvF/750beIUyVA1+xS5qMTZ
        D8q/GhnFe2xTbAm4InHtiq2inBJLcUaioRZzUXEiAFOmevUmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSnO7Ht+rxBgufKVnMWb+GzeLr+l/M
        Fn87L7BabJ5TbHF51xw2i+sz57A7sHnc3zad0ePEjN8sHu/3XWXz6NuyitHj8ya5ANYoLpuU
        1JzMstQifbsErox3O++wFbzMqri8dQNzA+PckC5GTg4JAROJuxuOM3YxcnEICexmlNj/7x0z
        REJKYl73WiYIW1jifssRVoii+4wSWxbNYQdJsAioSKydPAusgU1AS2L1XJBJnBwiAhoSm9o2
        MIM0MAu0MEp07rvOCpIQFjCVONzZyQJi8wpoSjyfNgFq9TlGiQeXVkIlBCVOznwCZjMDTb3x
        7yXQGRxAtrTE8n8cIGFOATuJY5tuM4KERYGOeHWwfgKj4CwkzbOQNM9CaF7AyLyKUTK1oDg3
        PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM48LU0dzBuX/VB7xAjEwfjIUYJDmYlEd6//5TjhXhT
        EiurUovy44tKc1KLDzFKc7AoifPeKFwYJySQnliSmp2aWpBaBJNl4uCUamBabreih+96Zoxq
        UuUZOaNWY6fZ+ycKvtx7/cHTEM35Jkq8QYaBK+ayTXpvcWurxPErLwq8I73Wzmpoln5Zm3Rs
        3tqvP25M7ardc3ue+R7NPBeDpqgWe92XiY1fA27PjtvBL3qJSWhBZCcrm+kpxn0sr93CJaaV
        nghWW/t8leVn4cB5f4ufsbct2HTzbW5D03n1n4ty3y888C586p2VXxbH/V3jxT09XXqBsmWL
        bfvZWfb3+e2a5Wuf3JjaE1K479YVkS+lER+89ViDTcX1z1xRFDL6mxy8TmJzvE/b5L3XWg6F
        XNKUTExfvfT2HaHA2nCmlzYFR5uS+FJfxFw5zRd7kKXKLaDpXcTjp81GxdFKLMUZiYZazEXF
        iQAcbOhz6wIAAA==
X-CMS-MailID: 20200803105857epcas2p48c9654ff5a25cce40e99ac652bf146f2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----0qZI4Dwa37cEfr45XGpNp.-u5Qg3LqDORztXc_4h5hVnI_uF=_6d358_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561
References: <CGME20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561@epcas2p2.samsung.com>
        <1596435031-41837-1-git-send-email-pullip.cho@samsung.com>
        <5f41af0f-4593-3441-12f4-5b0f7e6999ac@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------0qZI4Dwa37cEfr45XGpNp.-u5Qg3LqDORztXc_4h5hVnI_uF=_6d358_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi,

On Mon, Aug 03, 2020 at 09:57:10AM +0200, David Hildenbrand wrote:
> On 03.08.20 08:10, pullip.cho@samsung.com wrote:
> > From: Cho KyongHo <pullip.cho@samsung.com>
> > 
> > LPDDR5 introduces rank switch delay. If three successive DRAM accesses
> > happens and the first and the second ones access one rank and the last
> > access happens on the other rank, the latency of the last access will
> > be longer than the second one.
> > To address this panelty, we can sort the freelist so that a specific
> > rank is allocated prior to another rank. We expect the page allocator
> > can allocate the pages from the same rank successively with this
> > change. It will hopefully improves the proportion of the consecutive
> > memory accesses to the same rank.
> 
> This certainly needs performance numbers to justify ... and I am sorry,
> "hopefully improves" is not a valid justification :)
> 
Yes, I agree.
We have performance data but the data are not applicable
to other environment. Also I worry that the performance gain is only
specific to some DMA in a specific scenario. But we have observed this
patch does not degrade the other system performance.

> I can imagine that this works well initially, when there hasn't been a
> lot of memory fragmentation going on. But quickly after your system is
> under stress, I doubt this will be very useful. Proof me wrong. ;)
> 
I am happy to tell you that you told the truth.
We just expect pages allocated by consecutive order-0 allocations for an
application (or a DMA) will be grouped by the adjacent pages in the same
rank. This pattern leads the rate of rank switch during sequential
memory access becomes lower.

> ... I dislike this manual setting of "dram_rank_granule". Yet another mm
> feature that can only be enabled by a magic command line parameter where
> users have to guess the right values.
> 
I don't find a common way to find the granue of DRAM rank in a system.
That is why I introduces "dram_rank_granule".
Even though we have a way to find the granule, enabling this feature
disables freelist shuffling.

> (side note, there have been similar research approaches to improve
> energy consumption by switching off ranks when not needed).
> 
As you may noticed, this patch is not intended to save energy
consumption. To save energy by rank awareness, a rank should be unused
for some time in microseconds scale according to the DRAM controller
settings. But this patch does not restrict the use of memory amount.
> > 
> > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> > ---
> >  mm/Kconfig      |  23 +++++++++++
> >  mm/compaction.c |   6 +--
> >  mm/internal.h   |  11 ++++++
> >  mm/page_alloc.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++-------
> >  mm/shuffle.h    |   6 ++-
> >  5 files changed, 144 insertions(+), 21 deletions(-)
> > 
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 6c97488..789c02b 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -868,4 +868,27 @@ config ARCH_HAS_HUGEPD
> >  config MAPPING_DIRTY_HELPERS
> >          bool
> >  
> > +config RANK_SORTED_FREELIST
> > +	bool "Prefer allocating free pages in a half of DRAM ranks"
> > +
> > +	help
> > +	  Rank switch delay in DRAM access become larger in LPDDR5 than before.
> > +	  If two successive memory accesses happen on different ranks in LPDDR5,
> > +	  the latency of the second access becomes longer due to the rank switch
> > +	  overhead. This is a power-performance tradeoff achieved in LPDDR5.
> > +	  By default, sorting freelist by rank number is disabled even though
> > +	  RANK_SORTED_FREELIST is set to y. To enable, set "dram_rank_granule"
> > +	  boot argument to a larger or an equal value to pageblock_nr_pages. The
> > +	  values should be the exact the rank interleaving granule that your
> > +	  system is using. The rank interleaving granule is 2^(the lowest CS bit
> > +	  number). CS stands for Chip Select and is also called SS which stands
> > +	  for Slave Select.
> > +	  This is not beneficial to single rank memory system. Also this is not
> > +	  necessary to quad rank and octal rank memory systems because they are
> > +	  not in LPDDR5 specifications.
> > +
> > +	  This is marked experimental because this disables freelist shuffling
> > +	  (SHUFFLE_PAGE_ALLOCATOR). Also you should set the correct rank
> > +	  interleaving granule.
> > +
> >  endmenu
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 061dacf..bee9567 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -1218,8 +1218,7 @@ move_freelist_head(struct list_head *freelist, struct page *freepage)
> >  
> >  	if (!list_is_last(freelist, &freepage->lru)) {
> >  		list_cut_before(&sublist, freelist, &freepage->lru);
> > -		if (!list_empty(&sublist))
> > -			list_splice_tail(&sublist, freelist);
> > +		freelist_splice_tail(&sublist, freelist);
> >  	}
> >  }
> >  
> > @@ -1236,8 +1235,7 @@ move_freelist_tail(struct list_head *freelist, struct page *freepage)
> >  
> >  	if (!list_is_first(freelist, &freepage->lru)) {
> >  		list_cut_position(&sublist, freelist, &freepage->lru);
> > -		if (!list_empty(&sublist))
> > -			list_splice_tail(&sublist, freelist);
> > +		freelist_splice_tail(&sublist, freelist);
> >  	}
> >  }
> >  
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 10c6776..c945b3d 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -266,6 +266,17 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
> >  
> >  #endif
> >  
> > +#ifdef CONFIG_RANK_SORTED_FREELIST
> > +void freelist_splice_tail(struct list_head *sublist, struct list_head *freelist);
> > +#else
> > +#include <linux/list.h>
> > +static inline
> > +void freelist_splice_tail(struct list_head *sublist, struct list_head *freelist)
> > +{
> > +	if (!list_empty(sublist))
> > +		list_splice_tail(sublist, freelist);
> > +}
> > +#endif
> >  /*
> >   * This function returns the order of a free page in the buddy system. In
> >   * general, page_zone(page)->lock must be held by the caller to prevent the
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 2824e116..7823a3b 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -854,6 +854,69 @@ compaction_capture(struct capture_control *capc, struct page *page,
> >  }
> >  #endif /* CONFIG_COMPACTION */
> >  
> > +#ifdef CONFIG_RANK_SORTED_FREELIST
> > +static unsigned long dram_rank_nr_pages __read_mostly;
> > +
> > +static inline bool preferred_rank_enabled(void)
> > +{
> > +	return dram_rank_nr_pages >= pageblock_nr_pages;
> > +}
> > +
> > +static int __init dram_rank_granule(char *buf)
> > +{
> > +	unsigned long val = (unsigned long)(memparse(buf, NULL) / PAGE_SIZE);
> > +
> > +	if (val < pageblock_nr_pages) {
> > +		pr_err("too small rank granule %lu\n", val);
> > +		return -EINVAL;
> > +	}
> > +
> > +	dram_rank_nr_pages = val;
> > +
> > +	return 0;
> > +}
> > +
> > +early_param("dram_rank_granule", dram_rank_granule);
> > +
> > +static inline bool __preferred_rank(struct page *page)
> > +{
> > +	return !(page_to_pfn(page) & dram_rank_nr_pages);
> > +}
> > +
> > +static inline bool preferred_rank(struct page *page)
> > +{
> > +	return !preferred_rank_enabled() || __preferred_rank(page);
> > +}
> > +
> > +void freelist_splice_tail(struct list_head *sublist, struct list_head *freelist)
> > +{
> > +	while (!list_empty(sublist)) {
> > +		struct page *page;
> > +
> > +		page = list_first_entry(sublist, struct page, lru);
> > +		if (!preferred_rank_enabled() || !__preferred_rank(page))
> > +			list_move_tail(&page->lru, freelist);
> > +		else
> > +			list_move(&page->lru, freelist);
> > +	}
> > +}
> > +#else
> > +static inline bool __preferred_rank(struct page *page)
> > +{
> > +	return true;
> > +}
> > +
> > +static inline bool preferred_rank(struct page *page)
> > +{
> > +	return true;
> > +}
> > +
> > +static inline bool preferred_rank_enabled(void)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> >  /* Used for pages not on another list */
> >  static inline void add_to_free_list(struct page *page, struct zone *zone,
> >  				    unsigned int order, int migratetype)
> > @@ -880,7 +943,10 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
> >  {
> >  	struct free_area *area = &zone->free_area[order];
> >  
> > -	list_move(&page->lru, &area->free_list[migratetype]);
> > +	if (preferred_rank(page))
> > +		list_move(&page->lru, &area->free_list[migratetype]);
> > +	else
> > +		list_move_tail(&page->lru, &area->free_list[migratetype]);
> >  }
> >  
> >  static inline void del_page_from_free_list(struct page *page, struct zone *zone,
> > @@ -1029,7 +1095,9 @@ static inline void __free_one_page(struct page *page,
> >  done_merging:
> >  	set_page_order(page, order);
> >  
> > -	if (is_shuffle_order(order))
> > +	if (preferred_rank_enabled())
> > +		to_tail = !__preferred_rank(page);
> > +	else if (is_shuffle_order(order))
> >  		to_tail = shuffle_pick_tail();
> >  	else
> >  		to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
> > @@ -2257,20 +2325,29 @@ static __always_inline
> >  struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
> >  						int migratetype)
> >  {
> > +	int retry = preferred_rank_enabled() ? 2 : 1;
> >  	unsigned int current_order;
> >  	struct free_area *area;
> >  	struct page *page;
> >  
> > -	/* Find a page of the appropriate size in the preferred list */
> > -	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
> > -		area = &(zone->free_area[current_order]);
> > -		page = get_page_from_free_area(area, migratetype);
> > -		if (!page)
> > -			continue;
> > -		del_page_from_free_list(page, zone, current_order);
> > -		expand(zone, page, order, current_order, migratetype);
> > -		set_pcppage_migratetype(page, migratetype);
> > -		return page;
> > +	while (retry-- > 0) {
> > +		/* Find a page of the appropriate size in the preferred list */
> > +		for (current_order = order; current_order < MAX_ORDER; ++current_order) {
> > +			area = &zone->free_area[current_order];
> > +			page = get_page_from_free_area(area, migratetype);
> > +			if (!page)
> > +				continue;
> > +			/*
> > +			 * In the first try, search for a page in the preferred
> > +			 * rank upward even though a free page is found.
> > +			 */
> > +			if (retry > 0 && !preferred_rank(page))
> > +				continue;
> > +			del_page_from_free_list(page, zone, current_order);
> > +			expand(zone, page, order, current_order, migratetype);
> > +			set_pcppage_migratetype(page, migratetype);
> > +			return page;
> > +		}
> >  	}
> >  
> >  	return NULL;
> > @@ -2851,8 +2928,14 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
> >  		 * head, thus also in the physical page order. This is useful
> >  		 * for IO devices that can merge IO requests if the physical
> >  		 * pages are ordered properly.
> > +		 * However, preferred_rank_enabled() is true, we always sort
> > +		 * freelists in the buddy and the pcp in the order of rank
> > +		 * number for the performance reason.
> >  		 */
> > -		list_add_tail(&page->lru, list);
> > +		if (preferred_rank_enabled() && __preferred_rank(page))
> > +			list_add(&page->lru, list);
> > +		else
> > +			list_add_tail(&page->lru, list);
> >  		alloced++;
> >  		if (is_migrate_cma(get_pcppage_migratetype(page)))
> >  			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
> > @@ -3136,7 +3219,10 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
> >  	}
> >  
> >  	pcp = &this_cpu_ptr(zone->pageset)->pcp;
> > -	list_add(&page->lru, &pcp->lists[migratetype]);
> > +	if (preferred_rank(page))
> > +		list_add(&page->lru, &pcp->lists[migratetype]);
> > +	else
> > +		list_add_tail(&page->lru, &pcp->lists[migratetype]);
> >  	pcp->count++;
> >  	if (pcp->count >= pcp->high) {
> >  		unsigned long batch = READ_ONCE(pcp->batch);
> > @@ -8813,7 +8899,10 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
> >  			continue;
> >  
> >  		if (current_buddy != target) {
> > -			add_to_free_list(current_buddy, zone, high, migratetype);
> > +			if (preferred_rank(current_buddy))
> > +				add_to_free_list(current_buddy, zone, high, migratetype);
> > +			else
> > +				add_to_free_list_tail(current_buddy, zone, high, migratetype);
> >  			set_page_order(current_buddy, high);
> >  			page = next_page;
> >  		}
> > diff --git a/mm/shuffle.h b/mm/shuffle.h
> > index 71b784f..59cbfde 100644
> > --- a/mm/shuffle.h
> > +++ b/mm/shuffle.h
> > @@ -12,7 +12,8 @@ extern void __shuffle_free_memory(pg_data_t *pgdat);
> >  extern bool shuffle_pick_tail(void);
> >  static inline void shuffle_free_memory(pg_data_t *pgdat)
> >  {
> > -	if (!static_branch_unlikely(&page_alloc_shuffle_key))
> > +	if (!static_branch_unlikely(&page_alloc_shuffle_key) ||
> > +	    preferred_rank_enabled())
> >  		return;
> >  	__shuffle_free_memory(pgdat);
> >  }
> > @@ -20,7 +21,8 @@ static inline void shuffle_free_memory(pg_data_t *pgdat)
> >  extern void __shuffle_zone(struct zone *z);
> >  static inline void shuffle_zone(struct zone *z)
> >  {
> > -	if (!static_branch_unlikely(&page_alloc_shuffle_key))
> > +	if (!static_branch_unlikely(&page_alloc_shuffle_key) ||
> > +	    preferred_rank_enabled())
> >  		return;
> >  	__shuffle_zone(z);
> >  }
> > 
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 

------0qZI4Dwa37cEfr45XGpNp.-u5Qg3LqDORztXc_4h5hVnI_uF=_6d358_
Content-Type: text/plain; charset="utf-8"


------0qZI4Dwa37cEfr45XGpNp.-u5Qg3LqDORztXc_4h5hVnI_uF=_6d358_--
