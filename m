Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15115C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C488920728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="pvoJqtb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbgAPVw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:52:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34442 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731354AbgAPVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:52:27 -0500
Received: by mail-qt1-f196.google.com with SMTP id 5so20231740qtz.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 13:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1EPeaAWRHa3RqqVLE9V4P9RIEcd6DQc7GzxP/f3LSY8=;
        b=pvoJqtb58UypA494k7e14Z/xF8dKTjCFQB5xrlRUEpMWeAvPGdidXZ3yHaXcT0YpKu
         v2V/e0BD9I8DY8puJ2BDqEqX1ja8rDobR9dLaheJPHxT4kHLBYfzbLa9mzRR5IUwpF8g
         Q3by2hhrdMs233i0rjpLcHSobd+mwy1pPHZHrnJWx5YXCTRCp8TXO7RO25gKDbg3XCFT
         37sWyUI7eYw7asc4Ydg04fWVmbfWhMhPsx1G83m87eBEjno02m/tQ8faZ8RAWUixevG8
         Kbsg6XSwa/9JLxJDte8JUiODB4Puy4/a3z0aYgt9LotNGmjGkAupnUIL+b4bgLewYoAe
         hprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1EPeaAWRHa3RqqVLE9V4P9RIEcd6DQc7GzxP/f3LSY8=;
        b=UPZHbjLMlRS2rz/Hj9l+BFOcr2zWdM14giMLHbLPTlds7b0mdTPhrQARl9SdHN46z2
         DZgk641GWO1D93ZnVpwADtSyASxlk3QZnob5AKntIfGZ1oaiUZ9VGb/QAH+MWExvQZ9t
         FQ9FyLOU/Kwwu2eTYmdn0AohOUpnwxHUw3KGC8suTZClmXPI9+Zxe6d6wbtkaXa1DH+3
         9uMKjW5nkxwk+XfiHBR907P329VwFNBSlHGZdbVZ4PhBhaDDJBGG1ACf/lPgMB/1QEwE
         RvU/mFwXpZNIsns7LE22TVhQdOv6ributHvu8hKIEu/+ojuleZNMWIp8V+YTygL9pE5x
         BvPA==
X-Gm-Message-State: APjAAAVSUMjlTXXSoYqn7d27OBY84CJ8ua+LddC0C3z0xtKigFjdUkQv
        KWh3fNXyS7dEWTytl1wjbEqOJQ==
X-Google-Smtp-Source: APXvYqwdiK5kPAwKKwtquFeHOhHDxJ/ciVj0Toj/HU7dSRU5hDED+afwb10tRc0rfRHmciYc+V3+fg==
X-Received: by 2002:ac8:4050:: with SMTP id j16mr4499483qtl.171.1579211545067;
        Thu, 16 Jan 2020 13:52:25 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::ae73])
        by smtp.gmail.com with ESMTPSA id h1sm12179841qte.42.2020.01.16.13.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 13:52:23 -0800 (PST)
Date:   Thu, 16 Jan 2020 16:52:22 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v8 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20200116215222.GA64230@cmpxchg.org>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:05:02AM +0800, Alex Shi wrote:
> @@ -948,10 +956,20 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  		if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
>  			goto isolate_fail;
>  
> +		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +
>  		/* If we already hold the lock, we can skip some rechecking */
> -		if (!locked) {
> -			locked = compact_lock_irqsave(&pgdat->lru_lock,
> -								&flags, cc);
> +		if (lruvec != locked_lruvec) {
> +			struct mem_cgroup *memcg = lock_page_memcg(page);
> +
> +			if (locked_lruvec) {
> +				unlock_page_lruvec_irqrestore(locked_lruvec, flags);
> +				locked_lruvec = NULL;
> +			}
> +			/* reget lruvec with a locked memcg */
> +			lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
> +			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
> +			locked_lruvec = lruvec;
>  
>  			/* Try get exclusive access under lock */
>  			if (!skip_updated) {

In a previous review, I pointed out the following race condition
between page charging and compaction:

compaction:				generic_file_buffered_read:

					page_cache_alloc()

!PageBuddy()

lock_page_lruvec(page)
  lruvec = mem_cgroup_page_lruvec()
  spin_lock(&lruvec->lru_lock)
  if lruvec != mem_cgroup_page_lruvec()
    goto again

					add_to_page_cache_lru()
					  mem_cgroup_commit_charge()
					    page->mem_cgroup = foo
					  lru_cache_add()
					    __pagevec_lru_add()
					      SetPageLRU()

if PageLRU(page):
  __isolate_lru_page()

As far as I can see, you have not addressed this. You have added
lock_page_memcg(), but that prevents charged pages from moving between
cgroups, it does not prevent newly allocated pages from being charged.

It doesn't matter how many times you check the lruvec before and after
locking - if you're looking at a free page, it might get allocated,
charged and put on a new lruvec after you're done checking, and then
you isolate a page from an unlocked lruvec.

You simply cannot serialize on page->mem_cgroup->lruvec when
page->mem_cgroup isn't stable. You need to serialize on the page
itself, one way or another, to make this work.


So here is a crazy idea that may be worth exploring:

Right now, pgdat->lru_lock protects both PageLRU *and* the lruvec's
linked list.

Can we make PageLRU atomic and use it to stabilize the lru_lock
instead, and then use the lru_lock only serialize list operations?

I.e. in compaction, you'd do

	if (!TestClearPageLRU(page))
		goto isolate_fail;
	/*
	 * We isolated the page's LRU state and thereby locked out all
	 * other isolators, including cgroup page moving, page reclaim,
	 * page freeing etc. That means page->mem_cgroup is now stable
	 * and we can safely look up the correct lruvec and take the
	 * page off its physical LRU list.
	 */
	lruvec = mem_cgroup_page_lruvec(page);
	spin_lock_irq(&lruvec->lru_lock);
	del_page_from_lru_list(page, lruvec, page_lru(page));

Putback would mostly remain the same (although you could take the
PageLRU setting out of the list update locked section, as long as it's
set after the page is physically linked):

	/* LRU isolation pins page->mem_cgroup */
	lruvec = mem_cgroup_page_lruvec(page)
	spin_lock_irq(&lruvec->lru_lock);
	add_page_to_lru_list(...);
	spin_unlock_irq(&lruvec->lru_lock);

	SetPageLRU(page);

And you'd have to carefully review and rework other sites that rely on
PageLRU: reclaim, __page_cache_release(), __activate_page() etc.

Especially things like activate_page(), which used to only check
PageLRU to shuffle the page on the LRU list would now have to briefly
clear PageLRU and then set it again afterwards.

However, aside from a bit more churn in those cases, and the
unfortunate additional atomic operations, I currently can't think of a
fundamental reason why this wouldn't work.

Hugh, what do you think?
