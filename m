Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9508C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A472075B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iDMkLHBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgHBLJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 07:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgHBLJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 07:09:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE60C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 04:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fS7UrW+pv4oDNEfQ8W0yuLwkQxxnptAr7nmNBLakCFo=; b=iDMkLHBjvpX76Svsbcv8/m0x3O
        w2Wb8izlLoO6ZlxO5vM2l2oFjGvcuTjQRH7Pe/GAIpeHpu1UrYM0LwlqtyJ254215tiZkc3K1AYLM
        K7nn6vnsHkJZBym4c85xQrYpHX62+8wezNVj1tqXskmQuT0Vs96f5q/ezifmEYDvUSVDEdZFcsIB5
        3Hmd3xLL+fQXSVLIRYHLTgv/BC/cJ6QGa7RoLcX9/vURhlewaTqtCuMqbTEKzjAN3CHJKqI8t26+P
        vpQKVnixso78KYITFIAe50yuCjY5P01YkPCr3mHP/gsCQNq2UFN9u1RlhSmIroCitNZbRMhUVj/rE
        LULTv+2A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2Brp-0004u2-UQ; Sun, 02 Aug 2020 11:09:25 +0000
Date:   Sun, 2 Aug 2020 12:09:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/4] mm/thp: narrow lru locking
Message-ID: <20200802110925.GW23808@casper.infradead.org>
References: <1596254957-22560-1-git-send-email-alex.shi@linux.alibaba.com>
 <1596254957-22560-4-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596254957-22560-4-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


You're playing games with separating interrupt disabling from spinlocks.
Have you got any feedback from -rt people on this?

On Sat, Aug 01, 2020 at 12:09:17PM +0800, Alex Shi wrote:
> lru_lock and page cache xa_lock have no reason with current sequence,
> put them together isn't necessary. let's narrow the lru locking, but
> left the local_irq_disable to block interrupt re-entry and statistic update.
> 
> Hugh Dickins point: split_huge_page_to_list() was already silly,to be
> using the _irqsave variant: it's just been taking sleeping locks, so
> would already be broken if entered with interrupts enabled.
> so we can save passing flags argument down to __split_huge_page().
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/huge_memory.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index dfe7378ab4be..070480e66bf4 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2398,7 +2398,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  }
>  
>  static void __split_huge_page(struct page *page, struct list_head *list,
> -		pgoff_t end, unsigned long flags)
> +			      pgoff_t end)
>  {
>  	struct page *head = compound_head(page);
>  	pg_data_t *pgdat = page_pgdat(head);
> @@ -2407,8 +2407,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	unsigned long offset = 0;
>  	int i;
>  
> -	lruvec = mem_cgroup_page_lruvec(head, pgdat);
> -
>  	/* complete memcg works before add pages to LRU */
>  	mem_cgroup_split_huge_fixup(head);
>  
> @@ -2420,6 +2418,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		xa_lock(&swap_cache->i_pages);
>  	}
>  
> +	/* prevent PageLRU to go away from under us, and freeze lru stats */
> +	spin_lock(&pgdat->lru_lock);
> +
> +	lruvec = mem_cgroup_page_lruvec(head, pgdat);
> +
>  	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
>  		__split_huge_page_tail(head, i, lruvec, list);
>  		/* Some pages can be beyond i_size: drop them from page cache */
> @@ -2439,6 +2442,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	}
>  
>  	ClearPageCompound(head);
> +	spin_unlock(&pgdat->lru_lock);
> +	/* Caller disabled irqs, so they are still disabled here */
>  
>  	split_page_owner(head, HPAGE_PMD_ORDER);
>  
> @@ -2456,8 +2461,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		page_ref_add(head, 2);
>  		xa_unlock(&head->mapping->i_pages);
>  	}
> -
> -	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +	local_irq_enable();
>  
>  	remap_page(head);
>  
> @@ -2596,12 +2600,10 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
>  int split_huge_page_to_list(struct page *page, struct list_head *list)
>  {
>  	struct page *head = compound_head(page);
> -	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
>  	struct deferred_split *ds_queue = get_deferred_split_queue(head);
>  	struct anon_vma *anon_vma = NULL;
>  	struct address_space *mapping = NULL;
>  	int count, mapcount, extra_pins, ret;
> -	unsigned long flags;
>  	pgoff_t end;
>  
>  	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
> @@ -2662,9 +2664,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  	unmap_page(head);
>  	VM_BUG_ON_PAGE(compound_mapcount(head), head);
>  
> -	/* prevent PageLRU to go away from under us, and freeze lru stats */
> -	spin_lock_irqsave(&pgdata->lru_lock, flags);
> -
> +	/* block interrupt reentry in xa_lock and spinlock */
> +	local_irq_disable();
>  	if (mapping) {
>  		XA_STATE(xas, &mapping->i_pages, page_index(head));
>  
> @@ -2694,7 +2695,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  				__dec_node_page_state(head, NR_FILE_THPS);
>  		}
>  
> -		__split_huge_page(page, list, end, flags);
> +		__split_huge_page(page, list, end);
>  		if (PageSwapCache(head)) {
>  			swp_entry_t entry = { .val = page_private(head) };
>  
> @@ -2713,7 +2714,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  		spin_unlock(&ds_queue->split_queue_lock);
>  fail:		if (mapping)
>  			xa_unlock(&mapping->i_pages);
> -		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
> +		local_irq_enable();
>  		remap_page(head);
>  		ret = -EBUSY;
>  	}
> -- 
> 1.8.3.1
> 
