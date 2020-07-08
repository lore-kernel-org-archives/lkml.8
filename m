Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF8EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681B1206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvPJgtyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgGHHMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729931AbgGHHMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:12:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66156C061755
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:12:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so21226136pgk.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sPFWrim1n2HfpF7LAfR1J1MGchFDYkKkiwmqOTBD0vY=;
        b=dvPJgtyh0DJfiuG9929mt+5YDExeaEJY8Q5kng6EXfjIEKjfdCQYypBOBETMFI+SzN
         ytNqUVDtZOgAvDQVLLngOwiiS24OF1ECkahuwZOrs7SNWiUWTCcBJJwrxDeLVdUJmTie
         QsX6Mzo7kkbLwgq/cyVCbaNF53W1Wf55Qd9GjglTW06CplqvkM5nPGdNm/kPxiuaVjRK
         PnYppvMOh2a9evKkYarQZvHf4s3yZ+tPVM7HLak3pjBSjm8Kxrvd/o0mXKavBnrrrzJj
         lKNbe0oLq2h8pcsGz9pozjzAlVgqPnvXdKaDWtAELqbw1Lc94md9Lc8W0h0xmraT7afl
         tJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sPFWrim1n2HfpF7LAfR1J1MGchFDYkKkiwmqOTBD0vY=;
        b=kuqG1oBHztc90gqH23ImWx6hT7wBCJ7qIsRUFq4cDGnsAXyhpE/mt2hIA+keKnI27c
         L+xU29hT+oZ/MGrW1nccF8L8GNpP8SjiWhskv+Bev43Iabx68jB/v0e/YG8VbRED9D0A
         Fseru0wbgda7Ix5OyR4GwuSpotqYvqvJS/PJeQ4WFsgNfVKMjelxH6PQde+pasRJR/jH
         ZHcs+HNbtF3Ddszx8nAG6tr2GkdrVfhNMb9gXD71WI58TMLmtSq4Ja+4XCmWRoPCxaDK
         UQmeyM8EjhiWtJ8Q6ifMQjXqW6eq8XMYPV81IJNsKMEK6cge64+yRCySyqzPAA7WdVHN
         53+Q==
X-Gm-Message-State: AOAM530C9QFlMN7ZIlRt3WZzYqkR1lH5yec6EeCtCE2aq75z6Y7/IKWB
        uNIp6tZSOhnevnn+jnDsg5o=
X-Google-Smtp-Source: ABdhPJxLLU7hapgbBeIwrjluUgFLxWVGq0r3iVK5keXzxMD6TUCgH5KEk0RvMhayJxqzmu51gvr0Pg==
X-Received: by 2002:a65:6799:: with SMTP id e25mr50425571pgr.364.1594192367848;
        Wed, 08 Jul 2020 00:12:47 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id c12sm24703482pfn.162.2020.07.08.00.12.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 00:12:47 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:12:40 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH v4 04/11] mm/hugetlb: make hugetlb migration callback CMA
 aware
Message-ID: <20200708071224.GA16543@js1304-desktop>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
 <20200707113116.GH5913@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707113116.GH5913@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:31:16PM +0200, Michal Hocko wrote:
> On Tue 07-07-20 16:44:42, Joonsoo Kim wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > 
> > new_non_cma_page() in gup.c which try to allocate migration target page
> > requires to allocate the new page that is not on the CMA area.
> > new_non_cma_page() implements it by removing __GFP_MOVABLE flag.  This way
> > works well for THP page or normal page but not for hugetlb page.
> > 
> > hugetlb page allocation process consists of two steps.  First is dequeing
> > from the pool.  Second is, if there is no available page on the queue,
> > allocating from the page allocator.
> > 
> > new_non_cma_page() can control allocation from the page allocator by
> > specifying correct gfp flag.  However, dequeing cannot be controlled until
> > now, so, new_non_cma_page() skips dequeing completely.  It is a suboptimal
> > since new_non_cma_page() cannot utilize hugetlb pages on the queue so this
> > patch tries to fix this situation.
> > 
> > This patch makes the deque function on hugetlb CMA aware and skip CMA
> > pages if newly added skip_cma argument is passed as true.
> 
> I really dislike this as already mentioned in the previous version of
> the patch. You are making hugetlb and only one part of its allocator a
> special snowflake which is almost always a bad idea. Your changelog
> lacks any real justification for this inconsistency.
> 
> Also by doing so you are keeping an existing bug that the hugetlb
> allocator doesn't respect scope gfp flags as I have mentioned when
> reviewing the previous version. That bug likely doesn't matter now but
> it might in future and as soon as it is fixed all this is just a
> pointless exercise.
> 
> I do not have energy and time to burn to repeat that argumentation to I
> will let Mike to have a final word. Btw. you are keeping his acks even
> after considerable changes to patches which I am not really sure he is
> ok with.

As you replied a minute ago, Mike acked.

> > Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> To this particular patch.
> [...]
> 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 5daadae..2c3dab4 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1630,11 +1630,12 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
> >  #ifdef CONFIG_HUGETLB_PAGE
> >  	if (PageHuge(page)) {
> >  		struct hstate *h = page_hstate(page);
> > +
> >  		/*
> >  		 * We don't want to dequeue from the pool because pool pages will
> >  		 * mostly be from the CMA region.
> >  		 */
> > -		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
> > +		return alloc_huge_page_nodemask(h, nid, NULL, gfp_mask, true);
> 
> Let me repeat that this whole thing is running under
> memalloc_nocma_save. So additional parameter is bogus.

As Vlasimil said in other reply, we are not under
memalloc_nocma_save(). Anyway, now, I also think that additional parameter
isn't need.

> [...]
> > -static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> > +static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid, bool skip_cma)
> 
> If you really insist on an additional parameter at this layer than it
> should be checking for the PF_MEMALLOC_NOCMA instead.

I will change the patch to check PF_MEMALLOC_NOCMA instead of
introducing and checking skip_cma.

> [...]
> > @@ -1971,21 +1977,29 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
> >  
> >  /* page migration callback function */
> >  struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> > -		nodemask_t *nmask, gfp_t gfp_mask)
> > +		nodemask_t *nmask, gfp_t gfp_mask, bool skip_cma)
> >  {
> > +	unsigned int flags = 0;
> > +	struct page *page = NULL;
> > +
> > +	if (skip_cma)
> > +		flags = memalloc_nocma_save();
> 
> This is pointless for a scope that is already defined up in the call
> chain and fundamentally this is breaking the expected use of the scope
> API. The primary reason for that API to exist is to define the scope and
> have it sticky for _all_ allocation contexts. So if you have to use it
> deep in the allocator then you are doing something wrong.

As mentioned above, we are not under memalloc_nocma_save(). Anyway, I
will rework the patch and attach it to Vlasimil's reply. It's appreciate
if you check it again.

Thanks.
