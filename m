Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64E0C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5CB2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="MWL8x5y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCSAM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:12:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43481 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgCSAM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 20:12:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id u15so142188lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 17:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lPrGEwKRXyO9yXOFR59fcYZi9g17e4yyfNBd9nprDqQ=;
        b=MWL8x5y6FCR54ZVgurHR1a4U2f2qAK+jQbBFBpVG0ZAaTwG4qeq2SzJdTWmYih0deb
         3io78o73rd2gFvbgv8y2FL8afylt+4D3TknLuqgJ2aXvT5n/jFG40Nk1Pv4aGYJzvb2W
         z+9DCbkj5orhMg0Mxl3d5ao7TfDm0L+8xh/MB/XsEC073kHS04Zh7xiLeBINBy5Tsm7d
         dJgioQToL/CjHmVind6OINoE6sxkGVAvEcbd/yBwWdgzJFSHvGtN0GvHEJ9ZVnwu4wpa
         qJWJiEaYh9Rne96GtYsMYZFDkGVXKfF/QBZuu/m7W1eC0yAjoYAGiUfqyT7i6eD42KkM
         0dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lPrGEwKRXyO9yXOFR59fcYZi9g17e4yyfNBd9nprDqQ=;
        b=rWLY+gt8kSO9cKyk/1i08jy6ozeW9qNGuQkKPBSTvb/GQ882mbzJefdrU5X6bmpde0
         PLwc4DxA+mb/L620qjM9qoQL8WxDTD6aO+ttMtZPQXrfDgE98OxviOu9XlajAcd1Qs9L
         F8xSDJaK3LxX6vup9rZedG24FxKjQVNThQXIhy7vuFPnQCQApV6lr/HKWdYkLJ892HpN
         N8Jo+GHmjAiR4B1dYWRFrKJT3s5VYy5AQtAQCY7QXLRm8xZg/mDQ5z00QkrZiYfRkGtr
         Liw3bKR1QNFhl6MLPzc208yEJFjX+v1BwjncXI+pL6shcdgkx4xCXPIpmrShjXDM/FVX
         uhzw==
X-Gm-Message-State: ANhLgQ3fkTW2UsZ4aqGgROWmA4FRtC/NOse0+oin52FA3fJTTvWQhOJr
        t+kd/JQFURPVZHFlCooOlTAq7g==
X-Google-Smtp-Source: ADFU+vu5tKNdJ9YZUqehURNqjhJh3Yv8MtI6Yf+YXJFfbrRf0fgmxZiKyfLhCqNfc7ljD8Z8N0UuvQ==
X-Received: by 2002:a05:651c:110b:: with SMTP id d11mr349708ljo.52.1584576777458;
        Wed, 18 Mar 2020 17:12:57 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q4sm138647lfd.82.2020.03.18.17.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 17:12:56 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 080D71025D1; Thu, 19 Mar 2020 03:12:59 +0300 (+03)
Date:   Thu, 19 Mar 2020 03:12:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: fix potential page state corruption
Message-ID: <20200319001258.creziw6ffw4jvwl3@box>
References: <1584573582-116702-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584573582-116702-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 07:19:42AM +0800, Yang Shi wrote:
> When khugepaged collapses anonymous pages, the base pages would be freed
> via pagevec or free_page_and_swap_cache().  But, the anonymous page may
> be added back to LRU, then it might result in the below race:
> 
> 	CPU A				CPU B
> khugepaged:
>   unlock page
>   putback_lru_page
>     add to lru
> 				page reclaim:
> 				  isolate this page
> 				  try_to_unmap
>   page_remove_rmap <-- corrupt _mapcount
> 
> It looks nothing would prevent the pages from isolating by reclaimer.

Hm. Why should it?

try_to_unmap() doesn't exclude parallel page unmapping. _mapcount is
protected by ptl. And this particular _mapcount pin is reachable for
reclaim as it's not part of usual page table tree. Basically
try_to_unmap() will never succeeds until we give up the _mapcount on
khugepaged side.

I don't see the issue right away.

> The other problem is the page's active or unevictable flag might be
> still set when freeing the page via free_page_and_swap_cache().

So what?

> The putback_lru_page() would not clear those two flags if the pages are
> released via pagevec, it sounds nothing prevents from isolating active
> or unevictable pages.

Again, why should it? vmscan is equipped to deal with this.

> However I didn't really run into these problems, just in theory by visual
> inspection.
> 
> And, it also seems unnecessary to have the pages add back to LRU again since
> they are about to be freed when reaching this point.  So, clearing active
> and unevictable flags, unlocking and dropping refcount from isolate
> instead of calling putback_lru_page() as what page cache collapse does.

Hm? But we do call putback_lru_page() on the way out. I do not follow.

> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  mm/khugepaged.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b679908..f42fa4e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -673,7 +673,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>  			src_page = pte_page(pteval);
>  			copy_user_highpage(page, src_page, address, vma);
>  			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
> -			release_pte_page(src_page);
>  			/*
>  			 * ptl mostly unnecessary, but preempt has to
>  			 * be disabled to update the per-cpu stats
> @@ -687,6 +686,15 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>  			pte_clear(vma->vm_mm, address, _pte);
>  			page_remove_rmap(src_page, false);
>  			spin_unlock(ptl);
> +
> +			dec_node_page_state(src_page,
> +				NR_ISOLATED_ANON + page_is_file_cache(src_page));
> +			ClearPageActive(src_page);
> +			ClearPageUnevictable(src_page);
> +			unlock_page(src_page);
> +			/* Drop refcount from isolate */
> +			put_page(src_page);
> +
>  			free_page_and_swap_cache(src_page);
>  		}
>  	}
> -- 
> 1.8.3.1
> 
> 

-- 
 Kirill A. Shutemov
