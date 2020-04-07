Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126B5C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC05B20730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586274011;
	bh=/Rnh0Pfcs5CnqLsGYevpLeOOAh7+Tx6Vdh/Ms8f3828=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KIUueZv0owMDLfMh7WPWDeXx75mPSHXR6h8Go1z47dlhqd3+wnI7S9Jhi5r/x/fQY
	 x1q9MxLtQd4BvMyC+gkeq9bdXSpgYvbdaI4ykTmfByWVeUjg/LfsOc55fY/nAPGRPm
	 g54ZFnPkhgV7YrCswS9FjoeKSrnMhy/z1CiZl5NE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgDGPkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:40:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45530 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgDGPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:40:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id v5so4371769wrp.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 08:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=31K7Fg+KgmJDq3v9KkcnaJQvga5kXStbwzwT5e+jrxo=;
        b=Qvol7Htalcycsu3SYwO7lmutLq1symXZPZlH+L+3dHvjv4lGymgwqVFTEGiGmJ8/TC
         8mRu/j1p0VrESimrsyeZMh52TJT1jvk54cJwRHLWhngu9cpohUfKQWnRpwDEwm7mxA0g
         9FsFSD9QoD9wmybhbhXFO/l7H1fx3UwiZR5AOGMP5o3YgqH5StAeX4gs6pRH369mkF+x
         yfLOBy7KOYWAWJ44i6WaokhMcx845jAsPM1eXzK8XKv0ZEGyN/91Z5CaKXRmrByQ5/1B
         6SnY0yUavvbAi/lNT397aLZgUOYdXGecS/yQl+4F3ZcH60weds5LeQgjMqu/8FmjdmC8
         fuyg==
X-Gm-Message-State: AGi0PuZ6Q/XvSWU8DsmOUYj7whnKJV1sMSpcrQuFE7b5RZ2mljLCpS98
        aAsvSLGb1W086qgtpK3AOP4=
X-Google-Smtp-Source: APiQypJuftDGlzx0RCt8jHDN/0GikEohvkZRwltzI/NJ2vX4UxAhLIew8jTzn2XHbVmXSXeKZnva5Q==
X-Received: by 2002:a5d:6588:: with SMTP id q8mr3435091wru.189.1586274007370;
        Tue, 07 Apr 2020 08:40:07 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id r5sm2851950wmr.15.2020.04.07.08.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 08:40:06 -0700 (PDT)
Date:   Tue, 7 Apr 2020 17:40:05 +0200
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
Message-ID: <20200407154005.GT18914@dhcp22.suse.cz>
References: <20200407010431.1286488-1-guro@fb.com>
 <20200407010431.1286488-3-guro@fb.com>
 <20200407070331.GD18914@dhcp22.suse.cz>
 <20200407152544.GA9557@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407152544.GA9557@carbon.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-04-20 08:25:44, Roman Gushchin wrote:
> On Tue, Apr 07, 2020 at 09:03:31AM +0200, Michal Hocko wrote:
> > On Mon 06-04-20 18:04:31, Roman Gushchin wrote:
> > [...]
> > My ack still applies but I have only noticed two minor things now.
> 
> Hello, Michal!
> 
> > 
> > [...]
> > > @@ -1281,8 +1308,14 @@ static void update_and_free_page(struct hstate *h, struct page *page)
> > >  	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> > >  	set_page_refcounted(page);
> > >  	if (hstate_is_gigantic(h)) {
> > > +		/*
> > > +		 * Temporarily drop the hugetlb_lock, because
> > > +		 * we might block in free_gigantic_page().
> > > +		 */
> > > +		spin_unlock(&hugetlb_lock);
> > >  		destroy_compound_gigantic_page(page, huge_page_order(h));
> > >  		free_gigantic_page(page, huge_page_order(h));
> > > +		spin_lock(&hugetlb_lock);
> > 
> > This is OK with the current code because existing paths do not have to
> > revalidate the state AFAICS but it is a bit subtle. I have checked the
> > cma_free path and it can only sleep on the cma->lock unless I am missing
> > something. This lock is only used for cma bitmap manipulation and the
> > mutex sounds like an overkill there and it can be replaced by a
> > spinlock.
> > 
> > Sounds like a follow up patch material to me.
> 
> I had the same idea and even posted a patch:
> https://lore.kernel.org/linux-mm/20200403174559.GC220160@carbon.lan/T/#m87be98bdacda02cea3dd6759b48a28bd23f29ff0
> 
> However, Joonsoo pointed out that in some cases the bitmap operation might
> be too long for a spinlock.

I was not aware of this email thread. I will have a look. Thanks!
 
> Alternatively, we can implement an asynchronous delayed release on the cma side,
> I just don't know if it's worth it (I mean adding code/complexity).
> 
> > 
> > [...]
> > > +	for_each_node_state(nid, N_ONLINE) {
> > > +		int res;
> > > +
> > > +		size = min(per_node, hugetlb_cma_size - reserved);
> > > +		size = round_up(size, PAGE_SIZE << order);
> > > +
> > > +		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
> > > +						 0, false, "hugetlb",
> > > +						 &hugetlb_cma[nid], nid);
> > > +		if (res) {
> > > +			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
> > > +				res, nid);
> > > +			break;
> > 
> > Do we really have to break out after a single node failure? There might
> > be other nodes that can satisfy the allocation. You are not cleaning up
> > previous allocations so there is a partial state and then it would make
> > more sense to me to simply s@break@continue@ here.
> 
> But then we should iterate over all nodes in alloc_gigantic_page()?

OK, I've managed to miss the early break on hugetlb_cma[node] == NULL
there as well. I do not think this makes much sense. Just consider a
setup with one node much smaller than others (not unseen on LPAR
configurations) and then you are potentially using CMA areas on some
nodes without a good reason.

> Currently if hugetlb_cma[0] is NULL it will immediately switch back
> to the fallback approach.
> 
> Actually, Idk how realistic are use cases with complex node configuration,
> so that we can hugetlb_cma areas can be allocated only on some of them.
> I'd leave it up to the moment when we'll have a real world example.
> Then we probably want something more sophisticated anyway...

I do not follow. Isn't the s@break@continue@ in this and
alloc_gigantic_page path enough to make it work?
-- 
Michal Hocko
SUSE Labs
