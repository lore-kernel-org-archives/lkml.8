Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911A0C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9392098B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N4NuBvdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgH3XoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 19:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgH3XoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 19:44:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF33C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 16:44:10 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d18so4160448iop.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 16:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8G3SwPvwrOYdQW0JBf2oE6otivbpkle5n2iYsAwjng4=;
        b=N4NuBvdVYN1t73eNYsi8zTJxvjl0gLilyurQPZjU5XkLfdvKlT7AZ8+Lfe6128Hu8d
         Lk3VsF2ZtyOHXxHllPQfCP0OeYX2ZhntL6PbX3LaZxTOwSeOfPcAP0AruV8CR3l9y035
         L+q0BMf69TT3MjtI+THVtS2Y5cESBC25cWBTOcDJfzGWC+KmlVA+VYkARW9fxFT1vDxH
         zEUt2T9UaW+8pCdPp3BTcKMtBGWWd703HDPdsrthifTGYdjIt/l9Ei0n+OjOkNdacbhp
         SIApZ3t7w4NOC5ca3L3xDWh/BDv+vEIcxsV5t9Ny7+/7JhASS1XD/eOX95nqCTFHIxTy
         ScwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8G3SwPvwrOYdQW0JBf2oE6otivbpkle5n2iYsAwjng4=;
        b=rIb3ozXRJHN9Vwwd6+yRf3JKSx6gDinc7KnLpmIMQFg8a4aKazluXzDRUjJdSqnSXK
         uapd5hqUwr026zfFccSZf6+ezm342kOktT8AIq7PZRgi4UGJuYVxwvd9TkHnQvHQ7vav
         kYQDPC+thUoCRzZ/PrmQLDUZF5EVerBAUBi6OcxhLHn8vEkLTvRm8lwXlm95JclfR/8L
         +H0gL2dtE2d5dUzGq3q+KY7Oq1SDgqco7M8+7kvOoiUwJMyn/sufx21uT/UX1X2TvwmA
         NRiUm+GfGdtyF6gTefbhpWiOQYKsdPSL96PDa28lHy3vocdvKMuzln0Dk+jvYzEn7BE2
         NO9A==
X-Gm-Message-State: AOAM530zVSEsBUg5GT0X6lmZMaK4BJxx6Cf+t1iZkoLOHdj0pEgsjR98
        oq+WQzffS5x4IzPDCncMeLzSP1tKWRdgaA==
X-Google-Smtp-Source: ABdhPJzIMgaF7ZsHodltl3LsQ+UI10GDbNyWriyBQp5rio3XngZTbZP5Q/atHuB+SVI6R10/l/Z4hw==
X-Received: by 2002:a02:4b41:: with SMTP id q62mr5661962jaa.68.1598831049494;
        Sun, 30 Aug 2020 16:44:09 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id d1sm3558529ila.67.2020.08.30.16.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 16:44:08 -0700 (PDT)
Date:   Sun, 30 Aug 2020 17:44:04 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm: use
 add_page_to_lru_list()/page_lru()/page_off_lru()
Message-ID: <20200830234404.GA3192017@google.com>
References: <20200827234202.4027996-1-yuzhao@google.com>
 <20200829181213.GA838419@google.com>
 <fd72fd71-e049-f3e1-9e51-52eab6088cd4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd72fd71-e049-f3e1-9e51-52eab6088cd4@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 04:31:38PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/8/30 上午2:12, Yu Zhao 写道:
> > On Thu, Aug 27, 2020 at 05:42:01PM -0600, Yu Zhao wrote:
> >> This is a trivial but worth having clean-up patch. There should be
> >> no side effects except page->lru is temporarily poisoned after it's
> >> deleted but before it's added to the new list in move_pages_to_lru()
> >> (which is not a problem).
> >>
> >> Signed-off-by: Yu Zhao <yuzhao@google.com>
> > 
> > Hi Alex, I just realized your
> >   [v18,08/32] mm/vmscan: remove unnecessary lruvec adding
> > at
> >   https://patchwork.kernel.org/patch/11733123/
> > also touches move_pages_to_lru(). I agree it's better not to add
> > a page we are going to free to the list in the first place. The
> > rest in this patch would be too trivial to be a separate one (on
> > top of yours).
> > 
> > So would you mind taking of the clean-up too in your series? I'll
> > drop this one then. Thanks.

Ok, maybe I wasn't clear before. Please see what exactly I'm asking
you to consider below.

> >> diff --git a/mm/swap.c b/mm/swap.c
> >> index 40bf20a75278..2735ecf0f566 100644
> >> --- a/mm/swap.c
> >> +++ b/mm/swap.c
> >> @@ -597,11 +597,9 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
> >>  {
> >>  	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
> >>  	    !PageSwapCache(page) && !PageUnevictable(page)) {
> >> -		bool active = PageActive(page);
> >>  		int nr_pages = thp_nr_pages(page);
> >>  
> >> -		del_page_from_lru_list(page, lruvec,
> >> -				       LRU_INACTIVE_ANON + active);
> >> +		del_page_from_lru_list(page, lruvec, page_lru(page));
> >>  		ClearPageActive(page);
> >>  		ClearPageReferenced(page);
> >>  		/*

1) The above has no conflict with your series and therefore can go
separately. Feel free to include it.

> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 99e1796eb833..b479ced26cd3 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1845,13 +1845,12 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> >>  	int nr_pages, nr_moved = 0;
> >>  	LIST_HEAD(pages_to_free);
> >>  	struct page *page;
> >> -	enum lru_list lru;
> >>  
> >>  	while (!list_empty(list)) {
> >>  		page = lru_to_page(list);
> >>  		VM_BUG_ON_PAGE(PageLRU(page), page);
> >> +		list_del(&page->lru);
> >>  		if (unlikely(!page_evictable(page))) {
> >> -			list_del(&page->lru);
> >>  			spin_unlock_irq(&pgdat->lru_lock);
> >>  			putback_lru_page(page);
> >>  			spin_lock_irq(&pgdat->lru_lock);

2) The above is the same change you've made.

> >> @@ -1860,16 +1859,10 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> >>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> >>  
> >>  		SetPageLRU(page);
> >> -		lru = page_lru(page);
> >> -
> >> -		nr_pages = thp_nr_pages(page);
> >> -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> >> -		list_move(&page->lru, &lruvec->lists[lru]);
> >> +		add_page_to_lru_list(page, lruvec, page_lru(page));
> >>  
> >>  		if (put_page_testzero(page)) {
> >> -			__ClearPageLRU(page);
> 
> it's interesting to know the PageLRU left has no bad impact in real life. 
> it justs seems a path confliction with my that patch. 

(No, we can't leave PG_lru uncleared. It's done by the page_off_lru()
right below).

> >> -			__ClearPageActive(page);
> >> -			del_page_from_lru_list(page, lruvec, lru);
> >> +			del_page_from_lru_list(page, lruvec, page_off_lru(page));
> >>  
> >>  			if (unlikely(PageCompound(page))) {
> >>  				spin_unlock_irq(&pgdat->lru_lock);
> >> @@ -1878,6 +1871,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> >>  			} else
> >>  				list_add(&page->lru, &pages_to_free);
> >>  		} else {
> >> +			nr_pages = thp_nr_pages(page);
> >>  			nr_moved += nr_pages;
> >>  			if (PageActive(page))
> >>  				workingset_age_nonresident(lruvec, nr_pages);

3) The above is the conflict. Since we won't add and then delete a
page after your patch, we won't need it. But I do want this (you've
snipped from your reply, so I take that you already figured it out):

-		lru = page_lru(page);
-
-		nr_pages = thp_nr_pages(page);
-		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
-		list_move(&page->lru, &lruvec->lists[lru]);
+		add_page_to_lru_list(page, lruvec, page_lru(page));

No worries if you prefer this to go separately too.
