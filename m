Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E735C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D472072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgHXQJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:09:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:58126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHXQJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:09:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B895FB737;
        Mon, 24 Aug 2020 16:09:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 54FB51E1316; Mon, 24 Aug 2020 18:09:14 +0200 (CEST)
Date:   Mon, 24 Aug 2020 18:09:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] mm: Add an 'end' parameter to pagevec_lookup_entries
Message-ID: <20200824160914.GI24877@quack2.suse.cz>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819150555.31669-5-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 16:05:52, Matthew Wilcox (Oracle) wrote:
> Simplifies the callers and uses the existing functionality of
> find_get_entries().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/pagevec.h |  5 ++---
>  mm/swap.c               |  8 ++++----
>  mm/truncate.c           | 36 ++++++++----------------------------
>  3 files changed, 14 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index 081d934eda64..4b245592262c 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -26,9 +26,8 @@ struct pagevec {
>  void __pagevec_release(struct pagevec *pvec);
>  void __pagevec_lru_add(struct pagevec *pvec);
>  unsigned pagevec_lookup_entries(struct pagevec *pvec,
> -				struct address_space *mapping,
> -				pgoff_t start, unsigned nr_entries,
> -				pgoff_t *indices);
> +		struct address_space *mapping, pgoff_t start, pgoff_t end,
> +		unsigned nr_entries, pgoff_t *indices);
>  void pagevec_remove_exceptionals(struct pagevec *pvec);
>  unsigned pagevec_lookup_range(struct pagevec *pvec,
>  			      struct address_space *mapping,
> diff --git a/mm/swap.c b/mm/swap.c
> index fcf6ccb94b09..b6e56a84b466 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1036,6 +1036,7 @@ void __pagevec_lru_add(struct pagevec *pvec)
>   * @pvec:	Where the resulting entries are placed
>   * @mapping:	The address_space to search
>   * @start:	The starting entry index
> + * @end:	The highest index to return (inclusive).
>   * @nr_entries:	The maximum number of pages
>   * @indices:	The cache indices corresponding to the entries in @pvec
>   *
> @@ -1056,11 +1057,10 @@ void __pagevec_lru_add(struct pagevec *pvec)
>   * found.
>   */
>  unsigned pagevec_lookup_entries(struct pagevec *pvec,
> -				struct address_space *mapping,
> -				pgoff_t start, unsigned nr_entries,
> -				pgoff_t *indices)
> +		struct address_space *mapping, pgoff_t start, pgoff_t end,
> +		unsigned nr_entries, pgoff_t *indices)
>  {
> -	pvec->nr = find_get_entries(mapping, start, ULONG_MAX, nr_entries,
> +	pvec->nr = find_get_entries(mapping, start, end, nr_entries,
>  				    pvec->pages, indices);
>  	return pagevec_count(pvec);
>  }
> diff --git a/mm/truncate.c b/mm/truncate.c
> index dd9ebc1da356..9c617291fb1e 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -326,9 +326,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  
>  	pagevec_init(&pvec);
>  	index = start;
> -	while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
> -			min(end - index, (pgoff_t)PAGEVEC_SIZE),
> -			indices)) {
> +	while (pagevec_lookup_entries(&pvec, mapping, index, end - 1,
> +			PAGEVEC_SIZE, indices)) {
>  		/*
>  		 * Pagevec array has exceptional entries and we may also fail
>  		 * to lock some pages. So we store pages that can be deleted
> @@ -342,8 +341,6 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  
>  			/* We rely upon deletion not changing page->index */
>  			index = indices[i];
> -			if (index >= end)
> -				break;
>  
>  			if (xa_is_value(page))
>  				continue;
> @@ -413,8 +410,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  	index = start;
>  	for ( ; ; ) {
>  		cond_resched();
> -		if (!pagevec_lookup_entries(&pvec, mapping, index,
> -			min(end - index, (pgoff_t)PAGEVEC_SIZE), indices)) {
> +		if (!pagevec_lookup_entries(&pvec, mapping, index, end - 1,
> +				PAGEVEC_SIZE, indices)) {
>  			/* If all gone from start onwards, we're done */
>  			if (index == start)
>  				break;
> @@ -422,23 +419,12 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  			index = start;
>  			continue;
>  		}
> -		if (index == start && indices[0] >= end) {
> -			/* All gone out of hole to be punched, we're done */
> -			pagevec_remove_exceptionals(&pvec);
> -			pagevec_release(&pvec);
> -			break;
> -		}
>  
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  
>  			/* We rely upon deletion not changing page->index */
>  			index = indices[i];
> -			if (index >= end) {
> -				/* Restart punch to make sure all gone */
> -				index = start - 1;
> -				break;
> -			}
>  
>  			if (xa_is_value(page))
>  				continue;
> @@ -554,16 +540,13 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
>  	int i;
>  
>  	pagevec_init(&pvec);
> -	while (index <= end && pagevec_lookup_entries(&pvec, mapping, index,
> -			min(end - index, (pgoff_t)PAGEVEC_SIZE - 1) + 1,
> -			indices)) {
> +	while (pagevec_lookup_entries(&pvec, mapping, index, end,
> +			PAGEVEC_SIZE, indices)) {
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  
>  			/* We rely upon deletion not changing page->index */
>  			index = indices[i];
> -			if (index > end)
> -				break;
>  
>  			if (xa_is_value(page)) {
>  				invalidate_exceptional_entry(mapping, index,
> @@ -697,16 +680,13 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>  
>  	pagevec_init(&pvec);
>  	index = start;
> -	while (index <= end && pagevec_lookup_entries(&pvec, mapping, index,
> -			min(end - index, (pgoff_t)PAGEVEC_SIZE - 1) + 1,
> -			indices)) {
> +	while (pagevec_lookup_entries(&pvec, mapping, index, end,
> +			PAGEVEC_SIZE, indices)) {
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  
>  			/* We rely upon deletion not changing page->index */
>  			index = indices[i];
> -			if (index > end)
> -				break;
>  
>  			if (xa_is_value(page)) {
>  				if (!invalidate_exceptional_entry2(mapping,
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
