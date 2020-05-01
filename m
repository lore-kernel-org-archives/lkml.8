Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD7AC47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDA4214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="qrIcrvdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgEAHEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAHEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 03:04:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F341DC035494
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 00:04:14 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y3so3268900lfy.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 00:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qCLOpkksHkdYh4ykPVpJ06w/keNadYsgtn64kTqCr0o=;
        b=qrIcrvdjsOXbi4j/UHEuFriKwEvCA1iz+1e5OHIsiMuxukviKMoDZ9q/XG+IB7TnXu
         YnTGDXvPjY1CCk2TOdW3lrUN5Yt3VPgopQlt6DuW9SzzG+U8NP6eajswUZpK+4Bxw2tM
         s7O0yx5TUoSu1W1pRRHV4XhioJpnaO4/mbyM2M11A2u6SyXqodQppBwV76aCqYQEILRP
         WCKGUGvtxQQgeL0T2VMLMGdBepdugEqueqimopqNV/x5fdSHH44e8fF20rfmOjRKl4V5
         1n6sEsiZ9BCmeLt753BnsYVWmU4mU8NhTvg5/mggcDc72QWy9D1KTbAwcqTnv9Y5Xuix
         +5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qCLOpkksHkdYh4ykPVpJ06w/keNadYsgtn64kTqCr0o=;
        b=bLGADgyvva7at7BpiaIoRy0EfVp9oXW0/YQjF83JUrBMr9c3VnnNpaiKuVu1GYbFD0
         dAberFcXJIi4Ifrei+6qbRsvTP5sKNW6poxmLN0AxC1nuxAezAOS8s0jOfrc4YLzMD7P
         Z0yu785TIVzQmG397mArmWljXCToCAE86jLmn/cEWvfd8SHDbAXyTznPJJ//whePfg8z
         0zHhoHrc84c1rtrVgyQWclwld+++6wl4j/AxrsD3B7WKwZKFtPeG30fiBS3Yez3CdVOb
         iLdRd+Kb8KAKRDoQiQAPWtrJU0+F2XWdmjs0/HMKlKbEekbL/umU4bMxnFIubRexsXv9
         ECkw==
X-Gm-Message-State: AGi0PuZtJqFtuviLU8PXwKOu04xUZljHA6++NcU1Y30iU+VonMHM8WMe
        UJyKFgLo993rG/a5/GapQBhvy5/ulYw=
X-Google-Smtp-Source: APiQypKJIrgmF/BqPWAQ31tqddSJmsLtNFzezH7xZgekAp+cPvl7IaOvC17MAI9Swc7MSl0zffkcHg==
X-Received: by 2002:ac2:530e:: with SMTP id c14mr1724785lfh.154.1588316653320;
        Fri, 01 May 2020 00:04:13 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r14sm1444367ljn.4.2020.05.01.00.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 00:04:12 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id ECFC910241E; Fri,  1 May 2020 10:04:24 +0300 (+03)
Date:   Fri, 1 May 2020 10:04:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 linux-next PATCH 2/2] mm: khugepaged: don't have to put
 being freed page back to lru
Message-ID: <20200501070424.a5uugk7am2yzzx4v@box>
References: <1588279279-61908-1-git-send-email-yang.shi@linux.alibaba.com>
 <1588279279-61908-2-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588279279-61908-2-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 04:41:19AM +0800, Yang Shi wrote:
> When khugepaged successfully isolated and copied data from old page to
> collapsed THP, the old page is about to be freed if its last mapcount
> is gone.  So putting the page back to lru sounds not that productive in
> this case since the page might be isolated by vmscan but it can't be
> reclaimed by vmscan since it can't be unmapped by try_to_unmap() at all.
> 
> Actually if khugepaged is the last user of this page so it can be freed
> directly.  So, clearing active and unevictable flags, unlocking and
> dropping refcount from isolate instead of calling putback_lru_page().

Any reason putback_lru_page() cannot do it internally? I mean if it is
page_count() == 1, free the page.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> v2: Check mapcount and skip putback lru if the last mapcount is gone
> 
>  mm/khugepaged.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 0c8d30b..1fdd677 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -559,10 +559,18 @@ void __khugepaged_exit(struct mm_struct *mm)
>  static void release_pte_page(struct page *page)
>  {
>  	mod_node_page_state(page_pgdat(page),
> -			NR_ISOLATED_ANON + page_is_file_lru(page),
> -			-compound_nr(page));
> -	unlock_page(page);
> -	putback_lru_page(page);
> +		NR_ISOLATED_ANON + page_is_file_lru(page), -compound_nr(page));
> +
> +	if (total_mapcount(page)) {
> +		unlock_page(page);
> +		putback_lru_page(page);
> +	} else {
> +		ClearPageActive(page);
> +		ClearPageUnevictable(page);
> +		unlock_page(page);
> +		/* Drop refcount from isolate */
> +		put_page(page);
> +	}
>  }
>  
>  static void release_pte_pages(pte_t *pte, pte_t *_pte,
> @@ -771,8 +779,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>  		} else {
>  			src_page = pte_page(pteval);
>  			copy_user_highpage(page, src_page, address, vma);
> -			if (!PageCompound(src_page))
> -				release_pte_page(src_page);
>  			/*
>  			 * ptl mostly unnecessary, but preempt has to
>  			 * be disabled to update the per-cpu stats
> @@ -786,6 +792,8 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>  			pte_clear(vma->vm_mm, address, _pte);
>  			page_remove_rmap(src_page, false);
>  			spin_unlock(ptl);
> +			if (!PageCompound(src_page))
> +				release_pte_page(src_page);
>  			free_page_and_swap_cache(src_page);
>  		}
>  	}
> -- 
> 1.8.3.1
> 
> 

-- 
 Kirill A. Shutemov
