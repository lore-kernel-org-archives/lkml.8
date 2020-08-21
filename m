Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAB2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73624207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgHUQIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:08:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:36440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgHUQIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:08:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 779ADB705;
        Fri, 21 Aug 2020 16:08:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 38E851E1312; Fri, 21 Aug 2020 18:07:59 +0200 (CEST)
Date:   Fri, 21 Aug 2020 18:07:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mm: Add an 'end' parameter to find_get_entries
Message-ID: <20200821160759.GE3432@quack2.suse.cz>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819150555.31669-4-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 16:05:51, Matthew Wilcox (Oracle) wrote:
> This simplifies the callers and leads to a more efficient implementation
> since the XArray has this functionality already.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

The patch looks good to me. Just I'd note that you could drop some:

	if (index >= end)
		break;

checks in shmem_undo_range() as well.

In the past I was considering moving find_get_entries() to the same API as
find_get_pages_range() has (which is essentially what you do now, but I
also had 'start' to be a pgoff_t * so that we can return there where the
iteration ended in the range). But in the end I've decided the churn is not
worth the few removed lines and didn't push the patch in the end. What you
did in this patch seems to be a reasonable middle-ground :)

								Honza
> ---
>  include/linux/pagemap.h |  4 ++--
>  mm/filemap.c            |  9 +++++----
>  mm/shmem.c              | 10 ++++------
>  mm/swap.c               |  2 +-
>  4 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 7de11dcd534d..3f0dc8d00f2a 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -387,8 +387,8 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
>  struct page *find_get_entry(struct address_space *mapping, pgoff_t offset);
>  struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset);
>  unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
> -			  unsigned int nr_entries, struct page **entries,
> -			  pgoff_t *indices);
> +		pgoff_t end, unsigned int nr_entries, struct page **entries,
> +		pgoff_t *indices);
>  unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
>  			pgoff_t end, unsigned int nr_pages,
>  			struct page **pages);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1aaea26556cc..159cf3d6f1ae 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1742,6 +1742,7 @@ EXPORT_SYMBOL(pagecache_get_page);
>   * find_get_entries - gang pagecache lookup
>   * @mapping:	The address_space to search
>   * @start:	The starting page cache index
> + * @end:	The highest page cache index to return.
>   * @nr_entries:	The maximum number of entries
>   * @entries:	Where the resulting entries are placed
>   * @indices:	The cache indices corresponding to the entries in @entries
> @@ -1765,9 +1766,9 @@ EXPORT_SYMBOL(pagecache_get_page);
>   *
>   * Return: the number of pages and shadow entries which were found.
>   */
> -unsigned find_get_entries(struct address_space *mapping,
> -			  pgoff_t start, unsigned int nr_entries,
> -			  struct page **entries, pgoff_t *indices)
> +unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
> +		pgoff_t end, unsigned int nr_entries, struct page **entries,
> +		pgoff_t *indices)
>  {
>  	XA_STATE(xas, &mapping->i_pages, start);
>  	struct page *page;
> @@ -1777,7 +1778,7 @@ unsigned find_get_entries(struct address_space *mapping,
>  		return 0;
>  
>  	rcu_read_lock();
> -	xas_for_each(&xas, page, ULONG_MAX) {
> +	xas_for_each(&xas, page, end) {
>  		if (xas_retry(&xas, page))
>  			continue;
>  		/*
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0f9f149f4b5e..abdbe61a1aa7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -906,9 +906,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  	pagevec_init(&pvec);
>  	index = start;
>  	while (index < end) {
> -		pvec.nr = find_get_entries(mapping, index,
> -			min(end - index, (pgoff_t)PAGEVEC_SIZE),
> -			pvec.pages, indices);
> +		pvec.nr = find_get_entries(mapping, index, end - 1,
> +				PAGEVEC_SIZE, pvec.pages, indices);
>  		if (!pvec.nr)
>  			break;
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
> @@ -977,9 +976,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  	while (index < end) {
>  		cond_resched();
>  
> -		pvec.nr = find_get_entries(mapping, index,
> -				min(end - index, (pgoff_t)PAGEVEC_SIZE),
> -				pvec.pages, indices);
> +		pvec.nr = find_get_entries(mapping, index, end - 1,
> +				PAGEVEC_SIZE, pvec.pages, indices);
>  		if (!pvec.nr) {
>  			/* If all gone or hole-punch or unfalloc, we're done */
>  			if (index == start || end != -1)
> diff --git a/mm/swap.c b/mm/swap.c
> index d16d65d9b4e0..fcf6ccb94b09 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1060,7 +1060,7 @@ unsigned pagevec_lookup_entries(struct pagevec *pvec,
>  				pgoff_t start, unsigned nr_entries,
>  				pgoff_t *indices)
>  {
> -	pvec->nr = find_get_entries(mapping, start, nr_entries,
> +	pvec->nr = find_get_entries(mapping, start, ULONG_MAX, nr_entries,
>  				    pvec->pages, indices);
>  	return pagevec_count(pvec);
>  }
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
