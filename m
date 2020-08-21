Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88194C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE46207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHUPx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:53:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:56492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbgHUPxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:53:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0183AC65;
        Fri, 21 Aug 2020 15:54:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7DD391E1312; Fri, 21 Aug 2020 17:53:51 +0200 (CEST)
Date:   Fri, 21 Aug 2020 17:53:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mm: Use pagevec_lookup in shmem_unlock_mapping
Message-ID: <20200821155351.GD3432@quack2.suse.cz>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819150555.31669-2-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 16:05:49, Matthew Wilcox (Oracle) wrote:
> The comment shows that the reason for using find_get_entries() is now
> stale; find_get_pages() will not return 0 if it hits a consecutive run
> of swap entries, and I don't believe it has since 2011.  pagevec_lookup()
> is a simpler function to use than find_get_pages(), so use it instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/shmem.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 271548ca20f3..a7bbc4ed9677 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -840,7 +840,6 @@ unsigned long shmem_swap_usage(struct vm_area_struct *vma)
>  void shmem_unlock_mapping(struct address_space *mapping)
>  {
>  	struct pagevec pvec;
> -	pgoff_t indices[PAGEVEC_SIZE];
>  	pgoff_t index = 0;
>  
>  	pagevec_init(&pvec);
> @@ -848,16 +847,8 @@ void shmem_unlock_mapping(struct address_space *mapping)
>  	 * Minor point, but we might as well stop if someone else SHM_LOCKs it.
>  	 */
>  	while (!mapping_unevictable(mapping)) {
> -		/*
> -		 * Avoid pagevec_lookup(): find_get_pages() returns 0 as if it
> -		 * has finished, if it hits a row of PAGEVEC_SIZE swap entries.
> -		 */
> -		pvec.nr = find_get_entries(mapping, index,
> -					   PAGEVEC_SIZE, pvec.pages, indices);
> -		if (!pvec.nr)
> +		if (!pagevec_lookup(&pvec, mapping, &index))
>  			break;
> -		index = indices[pvec.nr - 1] + 1;
> -		pagevec_remove_exceptionals(&pvec);
>  		check_move_unevictable_pages(&pvec);
>  		pagevec_release(&pvec);
>  		cond_resched();
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
