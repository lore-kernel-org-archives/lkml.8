Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCC4C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4AD20730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586276594;
	bh=CxAykIymKOfgnioY5PXeRYyjZoEWZIbSRWfQ+4yYBNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UYTluIirVYbtaR0iNaEa6uwk8BjsAVx3oNNRQMgMqfqXxxPKRwaXM0jCPe3up0mVR
	 lNlxehZ0ERfyNHgZwmi4NKuBWH0cAQE+MiJ7fOHBvyFAjoIhdzsiica+NtypRnwUwb
	 MQolHbyUm+aiJr0LLDdOQV/Y37MPg6ZEjocDPm9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgDGQXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:23:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39078 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgDGQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:23:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id y20so2465879wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 09:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iRxjSGWcZyYWwiQMDLABZSQrM6r+qM7MeBaqDIWZ3rQ=;
        b=KNT1tXIwibt+gQV3Y4w/xFGc7RmaEu0i6xUTLf0qjFm1M+SZwdM0az3j5XpIZD9UZT
         lbSExj9Y8Oa2eA0c0BbJHhyxR1Th77i4lz86Yw0WEYKeQbkK+M9h3r7IVY6lvkjO7zt+
         7vspBW7Y/AkrGj3JP7Ofx108drrkf1lm6577KcwGVVPdgkEF2BYzeUosOPn2Y1L/IQVR
         LwRx3rOpjGEw+B2m+NtUe9X/0TAqo4fVqxZ5gU+KO8YuGfi9yoCOHkZQ9f313025+gvz
         vGbhzzsGbSfT2fR2XVJ+UzCJQ5jzLbiwRU3GZumGAmeXXUTV4W/vYsL4meomNJYNm74N
         ePFg==
X-Gm-Message-State: AGi0PuaKLccQYRjHFg9LhnPUUa4dCDMlQoq0CGGcRg/AFx3o53KyWr8J
        hBW89qTomT6+boR1oam3pL8=
X-Google-Smtp-Source: APiQypK/nFC5NAkO5bmx7aoJSG2ICsl6LKrOSSKSJm7mdxaEDWVe0v5LnPDVxnMQ9oUoQ9PwoOZqNw==
X-Received: by 2002:a1c:2d10:: with SMTP id t16mr69186wmt.155.1586276589553;
        Tue, 07 Apr 2020 09:23:09 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id d13sm4717480wrg.21.2020.04.07.09.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 09:23:08 -0700 (PDT)
Date:   Tue, 7 Apr 2020 18:23:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Aslan Bakirov <aslan@fb.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <js1304@gmail.com>
Subject: Re: [PATCH v4 2/2] mm: hugetlb: optionally allocate gigantic
 hugepages using cma
Message-ID: <20200407162307.GU18914@dhcp22.suse.cz>
References: <20200407010431.1286488-1-guro@fb.com>
 <20200407010431.1286488-3-guro@fb.com>
 <20200407070331.GD18914@dhcp22.suse.cz>
 <20200407152544.GA9557@carbon.lan>
 <20200407154005.GT18914@dhcp22.suse.cz>
 <20200407160640.GA11920@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407160640.GA11920@carbon.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-04-20 09:06:40, Roman Gushchin wrote:
> On Tue, Apr 07, 2020 at 05:40:05PM +0200, Michal Hocko wrote:
> > On Tue 07-04-20 08:25:44, Roman Gushchin wrote:
> > > On Tue, Apr 07, 2020 at 09:03:31AM +0200, Michal Hocko wrote:
> > > > On Mon 06-04-20 18:04:31, Roman Gushchin wrote:
> > > > [...]
> > > > My ack still applies but I have only noticed two minor things now.
> > > 
> > > Hello, Michal!
> > > 
> > > > 
> > > > [...]
> > > > > @@ -1281,8 +1308,14 @@ static void update_and_free_page(struct hstate *h, struct page *page)
> > > > >  	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> > > > >  	set_page_refcounted(page);
> > > > >  	if (hstate_is_gigantic(h)) {
> > > > > +		/*
> > > > > +		 * Temporarily drop the hugetlb_lock, because
> > > > > +		 * we might block in free_gigantic_page().
> > > > > +		 */
> > > > > +		spin_unlock(&hugetlb_lock);
> > > > >  		destroy_compound_gigantic_page(page, huge_page_order(h));
> > > > >  		free_gigantic_page(page, huge_page_order(h));
> > > > > +		spin_lock(&hugetlb_lock);
> > > > 
> > > > This is OK with the current code because existing paths do not have to
> > > > revalidate the state AFAICS but it is a bit subtle. I have checked the
> > > > cma_free path and it can only sleep on the cma->lock unless I am missing
> > > > something. This lock is only used for cma bitmap manipulation and the
> > > > mutex sounds like an overkill there and it can be replaced by a
> > > > spinlock.
> > > > 
> > > > Sounds like a follow up patch material to me.
> > > 
> > > I had the same idea and even posted a patch:
> > > https://lore.kernel.org/linux-mm/20200403174559.GC220160@carbon.lan/T/#m87be98bdacda02cea3dd6759b48a28bd23f29ff0
> > > 
> > > However, Joonsoo pointed out that in some cases the bitmap operation might
> > > be too long for a spinlock.
> > 
> > I was not aware of this email thread. I will have a look. Thanks!
> >  
> > > Alternatively, we can implement an asynchronous delayed release on the cma side,
> > > I just don't know if it's worth it (I mean adding code/complexity).
> > > 
> > > > 
> > > > [...]
> > > > > +	for_each_node_state(nid, N_ONLINE) {
> > > > > +		int res;
> > > > > +
> > > > > +		size = min(per_node, hugetlb_cma_size - reserved);
> > > > > +		size = round_up(size, PAGE_SIZE << order);
> > > > > +
> > > > > +		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
> > > > > +						 0, false, "hugetlb",
> > > > > +						 &hugetlb_cma[nid], nid);
> > > > > +		if (res) {
> > > > > +			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
> > > > > +				res, nid);
> > > > > +			break;
> > > > 
> > > > Do we really have to break out after a single node failure? There might
> > > > be other nodes that can satisfy the allocation. You are not cleaning up
> > > > previous allocations so there is a partial state and then it would make
> > > > more sense to me to simply s@break@continue@ here.
> > > 
> > > But then we should iterate over all nodes in alloc_gigantic_page()?
> > 
> > OK, I've managed to miss the early break on hugetlb_cma[node] == NULL
> > there as well. I do not think this makes much sense. Just consider a
> > setup with one node much smaller than others (not unseen on LPAR
> > configurations) and then you are potentially using CMA areas on some
> > nodes without a good reason.
> > 
> > > Currently if hugetlb_cma[0] is NULL it will immediately switch back
> > > to the fallback approach.
> > > 
> > > Actually, Idk how realistic are use cases with complex node configuration,
> > > so that we can hugetlb_cma areas can be allocated only on some of them.
> > > I'd leave it up to the moment when we'll have a real world example.
> > > Then we probably want something more sophisticated anyway...
> > 
> > I do not follow. Isn't the s@break@continue@ in this and
> > alloc_gigantic_page path enough to make it work?
> 
> Well, of course it will. But for a highly asymmetrical configuration
> there is probably not much sense to try allocate cma areas of a similar
> size on each node and rely on allocation failures on some of them.
> 
> But, again, if you strictly prefer s/break/continue, I can send a v5.
> Just let me know.

There is no real reason to have such a restriction. I can follow up with
a separate patch if you want me but it should be "fixed".

Thanks

-- 
Michal Hocko
SUSE Labs
