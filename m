Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CD6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4816020727
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590197664;
	bh=iQA3+sV9xEGHDhH86hIZeaDTSY4Ccpq9K37OB1XQOPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vtdI2Q6B3jThS55kPJHL5yq3CN+KJ4t+0A9zD7W7sVeUhM/creW84KSCJnvUkSLSK
	 5rpzY2KtSqn4V2VdYTfD8fqXUu/ZJFOeuSpJs9t1aNam/wrYz5xbgR0tx0LlJln6jm
	 cKd/36T4ywtDuh6uU2963ZP4Wwtd4M331gO99gbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbgEWBeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 21:34:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387418AbgEWBeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 21:34:22 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7638206DD;
        Sat, 23 May 2020 01:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590197662;
        bh=iQA3+sV9xEGHDhH86hIZeaDTSY4Ccpq9K37OB1XQOPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OX085bb/DXJF53o8HWB2n4tDxwKFCM87nTz9V4MKvGArIf9//eO66j0OGDomN20yZ
         mqm9gmsha+R4PPEjKkkTXf/nfJqdQgqmjwk0buDNt8EeXher0Muem5H3QfuqkzPM7G
         ATw+R8ppgSHSsa/Or5aOhzBKGMWjBQlKO+YmR+HE=
Date:   Fri, 22 May 2020 18:34:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] mm/compaction: avoid VM_BUG_ON(PageSlab()) in
 page_mapcount()
Message-Id: <20200522183421.7c52ba9650a2ad11cec2be8d@linux-foundation.org>
In-Reply-To: <158937872515.474360.5066096871639561424.stgit@buzz>
References: <158937872515.474360.5066096871639561424.stgit@buzz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 17:05:25 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> Function isolate_migratepages_block() runs some checks out of lru_lock
> when choose pages for migration. After checking PageLRU() it checks extra
> page references by comparing page_count() and page_mapcount(). Between
> these two checks page could be removed from lru, freed and taken by slab.
> 
> As a result this race triggers VM_BUG_ON(PageSlab()) in page_mapcount().
> Race window is tiny. For certain workload this happens around once a year.
> 
> 
>  page:ffffea0105ca9380 count:1 mapcount:0 mapping:ffff88ff7712c180 index:0x0 compound_mapcount: 0
>  flags: 0x500000000008100(slab|head)
>  raw: 0500000000008100 dead000000000100 dead000000000200 ffff88ff7712c180
>  raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
>  page dumped because: VM_BUG_ON_PAGE(PageSlab(page))
>  ------------[ cut here ]------------
>  kernel BUG at ./include/linux/mm.h:628!
>  invalid opcode: 0000 [#1] SMP NOPTI
>  CPU: 77 PID: 504 Comm: kcompactd1 Tainted: G        W         4.19.109-27 #1
>  Hardware name: Yandex T175-N41-Y3N/MY81-EX0-Y3N, BIOS R05 06/20/2019
>  RIP: 0010:isolate_migratepages_block+0x986/0x9b0
> 
> 
> To fix just opencode page_mapcount() in racy check for 0-order case and
> recheck carefully under lru_lock when page cannot escape from lru.
> 
> Also add checking extra references for file pages and swap cache.

I dunno, this code looks quite nasty.  I'm more thinking we should
revert and rethink David's 119d6d59dcc0980dcd58 ("mm, compaction: avoid
isolating pinned pages").

> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -935,12 +935,16 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		}
>  
>  		/*
> -		 * Migration will fail if an anonymous page is pinned in memory,
> +		 * Migration will fail if an page is pinned in memory,
>  		 * so avoid taking lru_lock and isolating it unnecessarily in an
> -		 * admittedly racy check.
> +		 * admittedly racy check simplest case for 0-order pages.
> +		 *
> +		 * Open code page_mapcount() to avoid VM_BUG_ON(PageSlab(page)).
> +		 * Page could have extra reference from mapping or swap cache.
>  		 */
> -		if (!page_mapping(page) &&
> -		    page_count(page) > page_mapcount(page))
> +		if (!PageCompound(page) &&
> +		    page_count(page) > atomic_read(&page->_mapcount) + 1 +
> +				(!PageAnon(page) || PageSwapCache(page)))
>  			goto isolate_fail;

OK, we happened to notice this because we happened to trigger a
!PageSlab assertion.  But if this page has been freed and reused for
slab, it could have been reused for *anything*?  Perhaps it was reused
as a migratable page which we'll go ahead and migrate even though we no
longer should.  There are various whacky parts of the kernel which
(ab)use surprising struct page fields in surprising ways - how do we
know it isn't one of those which now happens to look like a migratable
page?

I also worry about the next test:

		/*
		 * Only allow to migrate anonymous pages in GFP_NOFS context
		 * because those do not depend on fs locks.
		 */
		if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
			goto isolate_fail;

This page isn't PageLocked(), is it?  It could be a recycled page which
is will be getting its ->mapping set one nanosecond hence.


>  		/*
> @@ -975,6 +979,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  				low_pfn += compound_nr(page) - 1;
>  				goto isolate_fail;
>  			}
> +
> +			/* Recheck page extra references under lock */
> +			if (page_count(page) > page_mapcount(page) +
> +				    (!PageAnon(page) || PageSwapCache(page)))
> +				goto isolate_fail;
>  		}
>  
>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> 
