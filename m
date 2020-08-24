Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA51C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0361F20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHXQQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:16:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:39552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgHXQQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:16:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20928AC4C;
        Mon, 24 Aug 2020 16:16:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C654A1E1316; Mon, 24 Aug 2020 18:16:20 +0200 (CEST)
Date:   Mon, 24 Aug 2020 18:16:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mm: Pass pvec directly to find_get_entries
Message-ID: <20200824161620.GK24877@quack2.suse.cz>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819150555.31669-7-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 16:05:54, Matthew Wilcox (Oracle) wrote:
> All callers of find_get_entries() use a pvec, so pass it directly
> instead of manipulating it in the caller.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Rather than passing pvec to find_get_entries() and then making everybody
use it, won't it more consistent WRT the naming to make everybody use
pagevec_lookup_entries() (which is trivial at this point in the series) and
then rename find_get_entries() to pagevec_lookup_entries()? I.e., I'd prefer
if the final function was called pagevec_lookup_entries() because that is
IMO more consistent with how other functions are named in this area...

								Honza

> ---
>  include/linux/pagemap.h |  3 +--
>  mm/filemap.c            | 14 ++++++--------
>  mm/shmem.c              | 11 +++--------
>  mm/swap.c               |  4 +---
>  4 files changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 3f0dc8d00f2a..9d465dd8b379 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -387,8 +387,7 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
>  struct page *find_get_entry(struct address_space *mapping, pgoff_t offset);
>  struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset);
>  unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
> -		pgoff_t end, unsigned int nr_entries, struct page **entries,
> -		pgoff_t *indices);
> +		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
>  unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
>  			pgoff_t end, unsigned int nr_pages,
>  			struct page **pages);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 159cf3d6f1ae..892c7beef392 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1743,8 +1743,7 @@ EXPORT_SYMBOL(pagecache_get_page);
>   * @mapping:	The address_space to search
>   * @start:	The starting page cache index
>   * @end:	The highest page cache index to return.
> - * @nr_entries:	The maximum number of entries
> - * @entries:	Where the resulting entries are placed
> + * @pvec:	Where the resulting entries are placed
>   * @indices:	The cache indices corresponding to the entries in @entries
>   *
>   * find_get_entries() will search for and return a group of up to
> @@ -1767,15 +1766,12 @@ EXPORT_SYMBOL(pagecache_get_page);
>   * Return: the number of pages and shadow entries which were found.
>   */
>  unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
> -		pgoff_t end, unsigned int nr_entries, struct page **entries,
> -		pgoff_t *indices)
> +		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
>  {
>  	XA_STATE(xas, &mapping->i_pages, start);
>  	struct page *page;
>  	unsigned int ret = 0;
> -
> -	if (!nr_entries)
> -		return 0;
> +	unsigned nr_entries = PAGEVEC_SIZE;
>  
>  	rcu_read_lock();
>  	xas_for_each(&xas, page, end) {
> @@ -1806,7 +1802,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
>  		}
>  export:
>  		indices[ret] = xas.xa_index;
> -		entries[ret] = page;
> +		pvec->pages[ret] = page;
>  		if (++ret == nr_entries)
>  			break;
>  		continue;
> @@ -1816,6 +1812,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
>  		xas_reset(&xas);
>  	}
>  	rcu_read_unlock();
> +
> +	pvec->nr = ret;
>  	return ret;
>  }
>  
> diff --git a/mm/shmem.c b/mm/shmem.c
> index abdbe61a1aa7..e73c0b2ba99c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -905,11 +905,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  
>  	pagevec_init(&pvec);
>  	index = start;
> -	while (index < end) {
> -		pvec.nr = find_get_entries(mapping, index, end - 1,
> -				PAGEVEC_SIZE, pvec.pages, indices);
> -		if (!pvec.nr)
> -			break;
> +	while (find_get_entries(mapping, index, end - 1, &pvec, indices)) {
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  
> @@ -976,9 +972,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  	while (index < end) {
>  		cond_resched();
>  
> -		pvec.nr = find_get_entries(mapping, index, end - 1,
> -				PAGEVEC_SIZE, pvec.pages, indices);
> -		if (!pvec.nr) {
> +		if (!find_get_entries(mapping, index, end - 1, &pvec,
> +				indices)) {
>  			/* If all gone or hole-punch or unfalloc, we're done */
>  			if (index == start || end != -1)
>  				break;
> diff --git a/mm/swap.c b/mm/swap.c
> index d4e3ba4c967c..40b23300d353 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1060,9 +1060,7 @@ unsigned pagevec_lookup_entries(struct pagevec *pvec,
>  		struct address_space *mapping, pgoff_t start, pgoff_t end,
>  		pgoff_t *indices)
>  {
> -	pvec->nr = find_get_entries(mapping, start, end, PAGEVEC_SIZE,
> -				    pvec->pages, indices);
> -	return pagevec_count(pvec);
> +	return find_get_entries(mapping, start, end, pvec, indices);
>  }
>  
>  /**
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
