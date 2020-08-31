Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FB3C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8056720678
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjPv+EQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgHaRmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHaRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:42:00 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FBFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:41:59 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h4so6899738ioe.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ewFGJB7Yo/8GFDwyV3N5XMzE2CDy3u6mUf+bWLFImZM=;
        b=pjPv+EQfSUL4TQJ85behcq0hYhbTAd2A7UCL4kMzn7UDMblEYODN0vboVBSIQGNZxj
         voNnsRL/xIvF+Mkor0PqmFzqKtSOVCJEo6K3tAdESXeZhyI2GNVY2NQXtU27P+IXKO3G
         6LOnvkM+BzOU4HzKuKpA8SF9Z1gd9FyEmzufJWI6YWEZMN2fhSV6HoZq0USLidpwHIuo
         Ha53wSY3MzLYX3pyaXmbhjyTnJjKEy9i8+TI7NNO4AafTVc9kZ5aw8nV8JNTs3EFWVVF
         /PWksbyPSYED4Y/2a4rIE6YUGQbxNKl63CgRk38r+Zyj7qrClLim0VIm2bRJRkIlpCKc
         IHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ewFGJB7Yo/8GFDwyV3N5XMzE2CDy3u6mUf+bWLFImZM=;
        b=G91SbAXMmFM5fWEzYbyh6f6c+D+v4VW4OjcjWqwMJwIb+9HbWdQQ0HGju3jds5Q3kT
         2hhL9f26EqgC9iYDQ2r1URFO3k0TT3Xu6FPWlNhr6KrgZQ2Hl7HhMUknEJ+G4d43SO9G
         xLYBnsGXWTeC0LGpmveVZqau0MRfr0XppTvpXElJqPGosNgJGevJgd5h4QrjRuti6dR5
         P7CTpWGLIcbdVaIn0GID0YW0uCNgAeCOPvW9dNwbfOUNwWmwuulrRzz21MQmcdeYe2XK
         p445oTegQz8zU4Kf1DeCXMWU125RcSv1xlnwP8QAqmQlhWvUKE6BLqyw6GG3Fev47m0H
         vnOQ==
X-Gm-Message-State: AOAM53206GQkADQkW5EP97in/3YcWmYLR8+2Vw37mbdB5NgeH3uqrCW2
        rXixrOhzpDBlNcKeluYA3kiA79wmZvcFkA==
X-Google-Smtp-Source: ABdhPJxhLWcWjK8Kv6fr+z1o4nPE9GMBHeliT4bo4kKEx6yjVgtbi+WL+P8R0c9ggr+eoXd/RUBa0g==
X-Received: by 2002:a05:6638:1393:: with SMTP id w19mr2191811jad.113.1598895719012;
        Mon, 31 Aug 2020 10:41:59 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id 2sm2157550ilj.24.2020.08.31.10.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 10:41:58 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:41:54 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm: use
 add_page_to_lru_list()/page_lru()/page_off_lru()
Message-ID: <20200831174154.GA3428138@google.com>
References: <20200827234202.4027996-1-yuzhao@google.com>
 <20200829181213.GA838419@google.com>
 <fd72fd71-e049-f3e1-9e51-52eab6088cd4@linux.alibaba.com>
 <20200830234404.GA3192017@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200830234404.GA3192017@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 05:44:04PM -0600, Yu Zhao wrote:
> On Sun, Aug 30, 2020 at 04:31:38PM +0800, Alex Shi wrote:
> > 
> > 
> > 在 2020/8/30 上午2:12, Yu Zhao 写道:
> > > On Thu, Aug 27, 2020 at 05:42:01PM -0600, Yu Zhao wrote:
> > >> This is a trivial but worth having clean-up patch. There should be
> > >> no side effects except page->lru is temporarily poisoned after it's
> > >> deleted but before it's added to the new list in move_pages_to_lru()
> > >> (which is not a problem).
> > >>
> > >> Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > 
> > > Hi Alex, I just realized your
> > >   [v18,08/32] mm/vmscan: remove unnecessary lruvec adding
> > > at
> > >   https://patchwork.kernel.org/patch/11733123/
> > > also touches move_pages_to_lru(). I agree it's better not to add
> > > a page we are going to free to the list in the first place. The
> > > rest in this patch would be too trivial to be a separate one (on
> > > top of yours).
> > > 
> > > So would you mind taking of the clean-up too in your series? I'll
> > > drop this one then. Thanks.
> 
> Ok, maybe I wasn't clear before. Please see what exactly I'm asking
> you to consider below.
> 
> > >> diff --git a/mm/swap.c b/mm/swap.c
> > >> index 40bf20a75278..2735ecf0f566 100644
> > >> --- a/mm/swap.c
> > >> +++ b/mm/swap.c
> > >> @@ -597,11 +597,9 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
> > >>  {
> > >>  	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
> > >>  	    !PageSwapCache(page) && !PageUnevictable(page)) {
> > >> -		bool active = PageActive(page);
> > >>  		int nr_pages = thp_nr_pages(page);
> > >>  
> > >> -		del_page_from_lru_list(page, lruvec,
> > >> -				       LRU_INACTIVE_ANON + active);
> > >> +		del_page_from_lru_list(page, lruvec, page_lru(page));
> > >>  		ClearPageActive(page);
> > >>  		ClearPageReferenced(page);
> > >>  		/*
> 
> 1) The above has no conflict with your series and therefore can go
> separately. Feel free to include it.
> 
> > >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> > >> index 99e1796eb833..b479ced26cd3 100644
> > >> --- a/mm/vmscan.c
> > >> +++ b/mm/vmscan.c
> > >> @@ -1845,13 +1845,12 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> > >>  	int nr_pages, nr_moved = 0;
> > >>  	LIST_HEAD(pages_to_free);
> > >>  	struct page *page;
> > >> -	enum lru_list lru;
> > >>  
> > >>  	while (!list_empty(list)) {
> > >>  		page = lru_to_page(list);
> > >>  		VM_BUG_ON_PAGE(PageLRU(page), page);
> > >> +		list_del(&page->lru);
> > >>  		if (unlikely(!page_evictable(page))) {
> > >> -			list_del(&page->lru);
> > >>  			spin_unlock_irq(&pgdat->lru_lock);
> > >>  			putback_lru_page(page);
> > >>  			spin_lock_irq(&pgdat->lru_lock);
> 
> 2) The above is the same change you've made.
> 
> > >> @@ -1860,16 +1859,10 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> > >>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> > >>  
> > >>  		SetPageLRU(page);
> > >> -		lru = page_lru(page);
> > >> -
> > >> -		nr_pages = thp_nr_pages(page);
> > >> -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> > >> -		list_move(&page->lru, &lruvec->lists[lru]);
> > >> +		add_page_to_lru_list(page, lruvec, page_lru(page));
> > >>  
> > >>  		if (put_page_testzero(page)) {
> > >> -			__ClearPageLRU(page);
> > 
> > it's interesting to know the PageLRU left has no bad impact in real life. 
> > it justs seems a path confliction with my that patch. 
> 
> (No, we can't leave PG_lru uncleared. It's done by the page_off_lru()
> right below).

Sorry about this false claim. You are right: we need to keep
__ClearPageLRU() here. page_off_lru() doesn't do it for us.

I'll fix this in v2. Thanks.
