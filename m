Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C086C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0E02072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgHXQLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:11:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:59102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgHXQK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:10:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 867BCAC79;
        Mon, 24 Aug 2020 16:11:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 46C201E1316; Mon, 24 Aug 2020 18:10:54 +0200 (CEST)
Date:   Mon, 24 Aug 2020 18:10:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mm: Remove nr_entries parameter from
 pagevec_lookup_entries
Message-ID: <20200824161054.GJ24877@quack2.suse.cz>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819150555.31669-6-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 16:05:53, Matthew Wilcox (Oracle) wrote:
> All callers want to fetch the full size of the pvec.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/pagevec.h |  2 +-
>  mm/swap.c               |  4 ++--
>  mm/truncate.c           | 10 ++++------
>  3 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index 4b245592262c..ce77724a2ab7 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -27,7 +27,7 @@ void __pagevec_release(struct pagevec *pvec);
>  void __pagevec_lru_add(struct pagevec *pvec);
>  unsigned pagevec_lookup_entries(struct pagevec *pvec,
>  		struct address_space *mapping, pgoff_t start, pgoff_t end,
> -		unsigned nr_entries, pgoff_t *indices);
> +		pgoff_t *indices);
>  void pagevec_remove_exceptionals(struct pagevec *pvec);
>  unsigned pagevec_lookup_range(struct pagevec *pvec,
>  			      struct address_space *mapping,
> diff --git a/mm/swap.c b/mm/swap.c
> index b6e56a84b466..d4e3ba4c967c 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1058,9 +1058,9 @@ void __pagevec_lru_add(struct pagevec *pvec)
>   */
>  unsigned pagevec_lookup_entries(struct pagevec *pvec,
>  		struct address_space *mapping, pgoff_t start, pgoff_t end,
> -		unsigned nr_entries, pgoff_t *indices)
> +		pgoff_t *indices)
>  {
> -	pvec->nr = find_get_entries(mapping, start, end, nr_entries,
> +	pvec->nr = find_get_entries(mapping, start, end, PAGEVEC_SIZE,
>  				    pvec->pages, indices);
>  	return pagevec_count(pvec);
>  }
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 9c617291fb1e..96a45ba28042 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -327,7 +327,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  	pagevec_init(&pvec);
>  	index = start;
>  	while (pagevec_lookup_entries(&pvec, mapping, index, end - 1,
> -			PAGEVEC_SIZE, indices)) {
> +			indices)) {
>  		/*
>  		 * Pagevec array has exceptional entries and we may also fail
>  		 * to lock some pages. So we store pages that can be deleted
> @@ -411,7 +411,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  	for ( ; ; ) {
>  		cond_resched();
>  		if (!pagevec_lookup_entries(&pvec, mapping, index, end - 1,
> -				PAGEVEC_SIZE, indices)) {
> +				indices)) {
>  			/* If all gone from start onwards, we're done */
>  			if (index == start)
>  				break;
> @@ -540,8 +540,7 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
>  	int i;
>  
>  	pagevec_init(&pvec);
> -	while (pagevec_lookup_entries(&pvec, mapping, index, end,
> -			PAGEVEC_SIZE, indices)) {
> +	while (pagevec_lookup_entries(&pvec, mapping, index, end, indices)) {
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  
> @@ -680,8 +679,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>  
>  	pagevec_init(&pvec);
>  	index = start;
> -	while (pagevec_lookup_entries(&pvec, mapping, index, end,
> -			PAGEVEC_SIZE, indices)) {
> +	while (pagevec_lookup_entries(&pvec, mapping, index, end, indices)) {
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
