Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782EFC11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACA520828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBXP3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:29:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:49788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbgBXP3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:29:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2EF5DADBE;
        Mon, 24 Feb 2020 15:29:10 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm,thp,compaction,cma: allow THP migration for CMA
 allocations
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
        riel@fb.com
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        mhocko@kernel.org, mgorman@techsingularity.net,
        rientjes@google.com, aarcange@redhat.com
References: <cover.1582321645.git.riel@surriel.com>
 <3289dc5e6c4c3174999598d8293adf8ed3e93b57.1582321645.git.riel@surriel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 mQINBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABtCBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PokCVAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJcbbyGBQkH8VTqAAoJECJPp+fMgqZkpGoP
 /1jhVihakxw1d67kFhPgjWrbzaeAYOJu7Oi79D8BL8Vr5dmNPygbpGpJaCHACWp+10KXj9yz
 fWABs01KMHnZsAIUytVsQv35DMMDzgwVmnoEIRBhisMYOQlH2bBn/dqBjtnhs7zTL4xtqEcF
 1hoUFEByMOey7gm79utTk09hQE/Zo2x0Ikk98sSIKBETDCl4mkRVRlxPFl4O/w8dSaE4eczH
 LrKezaFiZOv6S1MUKVKzHInonrCqCNbXAHIeZa3JcXCYj1wWAjOt9R3NqcWsBGjFbkgoKMGD
 usiGabetmQjXNlVzyOYdAdrbpVRNVnaL91sB2j8LRD74snKsV0Wzwt90YHxDQ5z3M75YoIdl
 byTKu3BUuqZxkQ/emEuxZ7aRJ1Zw7cKo/IVqjWaQ1SSBDbZ8FAUPpHJxLdGxPRN8Pfw8blKY
 8mvLJKoF6i9T6+EmlyzxqzOFhcc4X5ig5uQoOjTIq6zhLO+nqVZvUDd2Kz9LMOCYb516cwS/
 Enpi0TcZ5ZobtLqEaL4rupjcJG418HFQ1qxC95u5FfNki+YTmu6ZLXy+1/9BDsPuZBOKYpUm
 3HWSnCS8J5Ny4SSwfYPH/JrtberWTcCP/8BHmoSpS/3oL3RxrZRRVnPHFzQC6L1oKvIuyXYF
 rkybPXYbmNHN+jTD3X8nRqo+4Qhmu6SHi3Vq
Message-ID: <05027092-a43e-756f-4fee-78f29a048ca1@suse.cz>
Date:   Mon, 24 Feb 2020 16:29:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3289dc5e6c4c3174999598d8293adf8ed3e93b57.1582321645.git.riel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/20 10:53 PM, Rik van Riel wrote:
> @@ -981,7 +981,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		if (__isolate_lru_page(page, isolate_mode) != 0)
>  			goto isolate_fail;
>  
> -		VM_BUG_ON_PAGE(PageCompound(page), page);
> +		/* The whole page is taken off the LRU; skip the tail pages. */
> +		if (PageCompound(page))
> +			low_pfn += compound_nr(page) - 1;
>  
>  		/* Successfully isolated */
>  		del_page_from_lru_list(page, lruvec, page_lru(page));

This continues by:
inc_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));


I think it now needs to use mod_node_page_state() with
hpage_nr_pages(page) otherwise the counter will underflow after the
migration?

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a36736812596..38c8ddfcecc8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8253,14 +8253,16 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  
>  		/*
>  		 * Hugepages are not in LRU lists, but they're movable.
> +		 * THPs are on the LRU, but need to be counted as #small pages.
>  		 * We need not scan over tail pages because we don't
>  		 * handle each tail page individually in migration.
>  		 */
> -		if (PageHuge(page)) {
> +		if (PageTransHuge(page)) {

Hmm, PageTransHuge() has VM_BUG_ON() for tail pages, while this code is
written so that it can encounter a tail page and skip the rest of the
compound page properly. So I would be worried about this.

Also PageTransHuge() is basically just a PageHead() so for each
non-hugetlbfs compound page this will assume it's a THP, while correctly
it should reach the __PageMovable() || PageLRU(page) tests below.

So probably this should do something like.

if (PageHuge(page) || PageTransCompound(page)) {
...
   if (PageHuge(page) && !hpage_migration_supported)) return page.
   if (!PageLRU(head) && !__PageMovable(head)) return page
...

>  			struct page *head = compound_head(page);
>  			unsigned int skip_pages;
>  
> -			if (!hugepage_migration_supported(page_hstate(head)))
> +			if (PageHuge(page) &&
> +			    !hugepage_migration_supported(page_hstate(head)))
>  				return page;
>  
>  			skip_pages = compound_nr(head) - (page - head);
> 

