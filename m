Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B361C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F90E207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgHTGSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:18:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:60524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgHTGSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:18:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6C16B585;
        Thu, 20 Aug 2020 06:18:58 +0000 (UTC)
Date:   Thu, 20 Aug 2020 08:18:27 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 3/3] mm: remove superfluous __ClearPageWaiters()
Message-ID: <20200820061652.GX5422@dhcp22.suse.cz>
References: <20200818184704.3625199-1-yuzhao@google.com>
 <20200818184704.3625199-3-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818184704.3625199-3-yuzhao@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-08-20 12:47:04, Yu Zhao wrote:
> Presumably __ClearPageWaiters() was added to follow the previously
> removed __ClearPageActive() pattern.

I do not think so. Please have a look at 62906027091f ("mm: add
PageWaiters indicating tasks are waiting for a page bit") and a
discussion when the patch has been proposed. Sorry I do not have a link
handy but I do remember that the handling was quite subtle.
 
> Only flags that are in PAGE_FLAGS_CHECK_AT_FREE needs to be properly
> cleared because otherwise we think there may be some kind of leak.
> PG_waiters is not one of those flags and leaving the clearing to
> PAGE_FLAGS_CHECK_AT_PREP is more appropriate.

What is the point of this patch in the first place? Page waiters is
quite subtle and I wouldn't touch it without having a very good reason.

> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/page-flags.h | 2 +-
>  mm/filemap.c               | 2 ++
>  mm/memremap.c              | 2 --
>  mm/swap.c                  | 3 ---
>  4 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 6be1aa559b1e..dba80a2bdfba 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -318,7 +318,7 @@ static inline int TestClearPage##uname(struct page *page) { return 0; }
>  	TESTSETFLAG_FALSE(uname) TESTCLEARFLAG_FALSE(uname)
>  
>  __PAGEFLAG(Locked, locked, PF_NO_TAIL)
> -PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
> +PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
>  PAGEFLAG(Error, error, PF_NO_TAIL) TESTCLEARFLAG(Error, error, PF_NO_TAIL)
>  PAGEFLAG(Referenced, referenced, PF_HEAD)
>  	TESTCLEARFLAG(Referenced, referenced, PF_HEAD)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1aaea26556cc..75240c7ef73f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1079,6 +1079,8 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
>  		 * other pages on it.
>  		 *
>  		 * That's okay, it's a rare case. The next waker will clear it.
> +		 * Otherwise the bit will be cleared by PAGE_FLAGS_CHECK_AT_PREP
> +		 * when the page is being freed.
>  		 */
>  	}
>  	spin_unlock_irqrestore(&q->lock, flags);
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 3a06eb91cb59..a9d02ffaf9e3 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -451,8 +451,6 @@ void free_devmap_managed_page(struct page *page)
>  		return;
>  	}
>  
> -	__ClearPageWaiters(page);
> -
>  	mem_cgroup_uncharge(page);
>  
>  	/*
> diff --git a/mm/swap.c b/mm/swap.c
> index 999a84dbe12c..40bf20a75278 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -90,7 +90,6 @@ static void __page_cache_release(struct page *page)
>  		del_page_from_lru_list(page, lruvec, page_off_lru(page));
>  		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>  	}
> -	__ClearPageWaiters(page);
>  }
>  
>  static void __put_single_page(struct page *page)
> @@ -900,8 +899,6 @@ void release_pages(struct page **pages, int nr)
>  			del_page_from_lru_list(page, lruvec, page_off_lru(page));
>  		}
>  
> -		__ClearPageWaiters(page);
> -
>  		list_add(&page->lru, &pages_to_free);
>  	}
>  	if (locked_pgdat)
> -- 
> 2.28.0.220.ged08abb693-goog
> 

-- 
Michal Hocko
SUSE Labs
