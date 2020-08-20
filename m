Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CA0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D714207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597942126;
	bh=lfa1yZPfjn3/JQsBFE7GS4+xci6+Eh/ymSOUanYtVJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fiQFDJV5d1Xdr+0RF7wwdipyumqkrlgDIoxnQNpYv3r75L0j7hV3MUkcJKvQNi8im
	 qTyGYihWMfbdtLjLHSG5A1zYzUwgUORvUHkcl4RjK47N0+cRZ94ZYr9Kz6r50/IuAf
	 c5K6KDIrTGbadpXIFfj3gAC6vRLo7oNHiHXhn0tY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgHTQsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730286AbgHTQsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:48:06 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 549722072D;
        Thu, 20 Aug 2020 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597942085;
        bh=lfa1yZPfjn3/JQsBFE7GS4+xci6+Eh/ymSOUanYtVJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COm+eYc2qcj4HirKjaLwOwt1wXPsM8CBCxxCCJa+60SuPMIQTq/yU3vn4eGu/AiJL
         4rBS8xCE86TeAATdvi9XE7b9XHqhZnJi/k/laPpbT8UP/j2GXJurrRfx1F9fwF3ZbY
         QId1F6JCA7+eZKF2bZxQDe3mjPWllad+T0Eiq4dw=
Date:   Thu, 20 Aug 2020 19:47:59 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mm: Add an 'end' parameter to find_get_entries
Message-ID: <20200820164759.GE752365@kernel.org>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819150555.31669-4-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 04:05:51PM +0100, Matthew Wilcox (Oracle) wrote:
> This simplifies the callers and leads to a more efficient implementation
> since the XArray has this functionality already.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

Maybe add here whether 'end' is inclusive or exclusive?

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
> 

-- 
Sincerely yours,
Mike.
