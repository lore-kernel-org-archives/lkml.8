Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8F1C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 531ED206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVtVx9ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgH2SMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2SMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:12:20 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36685C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 11:12:20 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y2so3356611ilp.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 11:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IJFlO1KaP8bA4JdDTNS+T/rpIDsvfCq55jCXcUwH5DE=;
        b=tVtVx9juPVqEzlJ0Yxbif910H/KAlpmQCYAmqo3IiETs75gckanPGZjypoL+Uq2NGe
         pa6zf3dbDdD+FdtTxIVYrMrOiX9qzBHBixe2sGY0fGKE6dExleXTvWa1Cj16t+QH/Tg7
         KneNcl681+u0xo7+XuJd+ZgcSLvgnv093gvEgLmfNI+oAjHN1gWFCxyuBeUtBSxwoxER
         KmQTvk92M+0QX0+L/9PYAUI00a6B1HSoIlP444hdXpDykeRpkjsJOISwy5uvoLA66cyP
         WaEZ0uB9ONU1t+xkFiPzBzF2541FbrVZci97GybQK0n8IxfW2L0wlSD5m/HOxFNBzTwo
         /2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IJFlO1KaP8bA4JdDTNS+T/rpIDsvfCq55jCXcUwH5DE=;
        b=l53p+aD0P8CMAsgvWgyLyczc/nCP+fiXf9Mt9kjU4OxYc5UwvH6Cm//nkvhF95iP6+
         VUoA0zp25GMQx4suRKXCub8FyA2G78c6T/WKHrbJdyKNfAXCSgatixRY6C5llEH6Xw7w
         8Vj/sM3b2TRrKMnMGq0KQjsG6OxUg2twjoR/CwGNYsGUpEGAO48qv+QfVgY5RKZF24y9
         kuGo7yl9I+q7EEfIs5wGLqQ22H2EY+GzxKQ0O9ZrM/VLL+KQ94aCa/Crs9NosFxkxVTK
         KgEV90qbkJ5ROV0FLN4xzCMJGZ5riEJ8Nzfpgxs4wUIV/nctJY1/a4/Bxy5sgNoIAOvT
         TnEw==
X-Gm-Message-State: AOAM533w1oNJGneuXbL65MPF/eeaqu0QUCjbINf2LqJvlOtBf/ySpmXD
        ZUm1jRI3SeQ4oFy1jLeuZKjdzd1eIGI1jw==
X-Google-Smtp-Source: ABdhPJxfKvaWT5fXv2yygU0zY24+xxqLhNYvkhnVppYnLViuF0amvMNi380mdxeKTL9MFNIgF4A8JQ==
X-Received: by 2002:a92:c7ae:: with SMTP id f14mr3606405ilk.39.1598724738246;
        Sat, 29 Aug 2020 11:12:18 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id e28sm935533ill.79.2020.08.29.11.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 11:12:17 -0700 (PDT)
Date:   Sat, 29 Aug 2020 12:12:13 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm: use
 add_page_to_lru_list()/page_lru()/page_off_lru()
Message-ID: <20200829181213.GA838419@google.com>
References: <20200827234202.4027996-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827234202.4027996-1-yuzhao@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 05:42:01PM -0600, Yu Zhao wrote:
> This is a trivial but worth having clean-up patch. There should be
> no side effects except page->lru is temporarily poisoned after it's
> deleted but before it's added to the new list in move_pages_to_lru()
> (which is not a problem).
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Hi Alex, I just realized your
  [v18,08/32] mm/vmscan: remove unnecessary lruvec adding
at
  https://patchwork.kernel.org/patch/11733123/
also touches move_pages_to_lru(). I agree it's better not to add
a page we are going to free to the list in the first place. The
rest in this patch would be too trivial to be a separate one (on
top of yours).

So would you mind taking of the clean-up too in your series? I'll
drop this one then. Thanks.

> ---
>  mm/swap.c   |  4 +---
>  mm/vmscan.c | 14 ++++----------
>  2 files changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 40bf20a75278..2735ecf0f566 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -597,11 +597,9 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
>  {
>  	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
>  	    !PageSwapCache(page) && !PageUnevictable(page)) {
> -		bool active = PageActive(page);
>  		int nr_pages = thp_nr_pages(page);
>  
> -		del_page_from_lru_list(page, lruvec,
> -				       LRU_INACTIVE_ANON + active);
> +		del_page_from_lru_list(page, lruvec, page_lru(page));
>  		ClearPageActive(page);
>  		ClearPageReferenced(page);
>  		/*
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 99e1796eb833..b479ced26cd3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1845,13 +1845,12 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  	int nr_pages, nr_moved = 0;
>  	LIST_HEAD(pages_to_free);
>  	struct page *page;
> -	enum lru_list lru;
>  
>  	while (!list_empty(list)) {
>  		page = lru_to_page(list);
>  		VM_BUG_ON_PAGE(PageLRU(page), page);
> +		list_del(&page->lru);
>  		if (unlikely(!page_evictable(page))) {
> -			list_del(&page->lru);
>  			spin_unlock_irq(&pgdat->lru_lock);
>  			putback_lru_page(page);
>  			spin_lock_irq(&pgdat->lru_lock);
> @@ -1860,16 +1859,10 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  
>  		SetPageLRU(page);
> -		lru = page_lru(page);
> -
> -		nr_pages = thp_nr_pages(page);
> -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> -		list_move(&page->lru, &lruvec->lists[lru]);
> +		add_page_to_lru_list(page, lruvec, page_lru(page));
>  
>  		if (put_page_testzero(page)) {
> -			__ClearPageLRU(page);
> -			__ClearPageActive(page);
> -			del_page_from_lru_list(page, lruvec, lru);
> +			del_page_from_lru_list(page, lruvec, page_off_lru(page));
>  
>  			if (unlikely(PageCompound(page))) {
>  				spin_unlock_irq(&pgdat->lru_lock);
> @@ -1878,6 +1871,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  			} else
>  				list_add(&page->lru, &pages_to_free);
>  		} else {
> +			nr_pages = thp_nr_pages(page);
>  			nr_moved += nr_pages;
>  			if (PageActive(page))
>  				workingset_age_nonresident(lruvec, nr_pages);
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 
