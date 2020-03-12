Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C8BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394CE2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="j8TK+EQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCLJVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:21:16 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:21505 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCLJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584004874; x=1615540874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=2uCJ+4ws4cvlEV+wb61ZNYapETdHtIGmrv87apB/d5Y=;
  b=j8TK+EQFXF/EHi+avbrNqU8NWVYDhBw09s12w/PIVns7kN2QqEwrjDXX
   9Vkvsw6FXH6cUXSM3i2PojN/4jJjlQBl1VaPlkl30aiZou5e200GATLFH
   6sHBk9WXnJdDhf0NAc5itj4sYUCLq3H/mKXFRWlPBS1FstdE+heDjlbhz
   8=;
IronPort-SDR: byhSOgQR6MQP6GXvYn18sTTUXQ1OXhL4l7uE+EVjmfFsOwkRWzCdefsL6goSsigDWavy6wQX8V
 L/f9xsbvJEUA==
X-IronPort-AV: E=Sophos;i="5.70,544,1574121600"; 
   d="scan'208";a="32157934"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Mar 2020 09:21:10 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id D137CA1D81;
        Thu, 12 Mar 2020 09:21:00 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 12 Mar 2020 09:20:59 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.152) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Mar 2020 09:20:47 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <aarcange@redhat.com>,
        <yang.shi@linux.alibaba.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v6 02/14] mm/damon: Implement region based sampling
Date:   Thu, 12 Mar 2020 10:20:30 +0100
Message-ID: <20200312092030.347-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310173938.00002af4@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.152]
X-ClientProxiedBy: EX13D15UWB003.ant.amazon.com (10.43.161.138) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 17:39:38 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 10 Mar 2020 17:22:40 +0100
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > On Tue, 10 Mar 2020 15:55:10 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > 
> > > On Tue, 10 Mar 2020 12:52:33 +0100
> > > SeongJae Park <sjpark@amazon.com> wrote:
> > >   
> > > > Added replies to your every comment in line below.  I agree to your whole
> > > > opinions, will apply those in next spin! :)
> > > >   
> > > 
> > > One additional question inline that came to mind.  Using a single statistic
> > > to monitor huge page and normal page hits is going to give us problems
> > > I think.  
> > 
> > Ah, you're right!!!  This is indeed a critical bug!
> > 
> > > 
> > > Perhaps I'm missing something?
> > >   
> > > > > > +/*
> > > > > > + * Check whether the given region has accessed since the last check    
> > > > > 
> > > > > Should also make clear that this sets us up for the next access check at
> > > > > a different memory address it the region.
> > > > > 
> > > > > Given the lack of connection between activities perhaps just split this into
> > > > > two functions that are always called next to each other.    
> > > > 
> > > > Will make the description more clearer as suggested.
> > > > 
> > > > Also, I found that I'm not clearing *pte and *pmd before going 'mkold', thanks
> > > > to this comment.  Will fix it, either.
> > > >   
> > > > >     
> > > > > > + *
> > > > > > + * mm	'mm_struct' for the given virtual address space
> > > > > > + * r	the region to be checked
> > > > > > + */
> > > > > > +static void kdamond_check_access(struct damon_ctx *ctx,
> > > > > > +			struct mm_struct *mm, struct damon_region *r)
> > > > > > +{
> > > > > > +	pte_t *pte = NULL;
> > > > > > +	pmd_t *pmd = NULL;
> > > > > > +	spinlock_t *ptl;
> > > > > > +
> > > > > > +	if (follow_pte_pmd(mm, r->sampling_addr, NULL, &pte, &pmd, &ptl))
> > > > > > +		goto mkold;
> > > > > > +
> > > > > > +	/* Read the page table access bit of the page */
> > > > > > +	if (pte && pte_young(*pte))
> > > > > > +		r->nr_accesses++;
> > > > > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE    
> > > > > 
> > > > > Is it worth having this protection?  Seems likely to have only a very small
> > > > > influence on performance and makes it a little harder to reason about the code.    
> > > > 
> > > > It was necessary for addressing 'implicit declaration' problem of 'pmd_young()'
> > > > and 'pmd_mkold()' for build of DAMON on several architectures including User
> > > > Mode Linux.
> > > > 
> > > > Will modularize the code for better readability.
> > > >   
> > > > >     
> > > > > > +	else if (pmd && pmd_young(*pmd))
> > > > > > +		r->nr_accesses++;  
> > > 
> > > So we increment a region count by one if we have an access in a huge page, or
> > > in a normal page.
> > > 
> > > If we get a region that has a mixture of the two, this seems likely to give a
> > > bad approximation.
> > > 
> > > Assume the region is accessed 'evenly' but each " 4k page" is only hit 10% of the time
> > > (where a hit is in one check period)
> > > 
> > > If our address in a page, then we'll hit 10% of the time, but if it is in a 2M
> > > huge page then we'll hit a much higher percentage of the time.
> > > 1 - (0.9^512) ~= 1
> > > 
> > > Should we look to somehow account for this?  
> > 
> > Yes, this is really critical bug and we should fix this!  Thank you so much for
> > finding this!
> > 
> > >   
> > > > > > +#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
> > > > > > +
> > > > > > +	spin_unlock(ptl);
> > > > > > +
> > > > > > +mkold:
> > > > > > +	/* mkold next target */
> > > > > > +	r->sampling_addr = damon_rand(ctx, r->vm_start, r->vm_end);
> > > > > > +
> > > > > > +	if (follow_pte_pmd(mm, r->sampling_addr, NULL, &pte, &pmd, &ptl))
> > > > > > +		return;
> > > > > > +
> > > > > > +	if (pte) {
> > > > > > +		if (pte_young(*pte)) {
> > > > > > +			clear_page_idle(pte_page(*pte));
> > > > > > +			set_page_young(pte_page(*pte));
> > > > > > +		}
> > > > > > +		*pte = pte_mkold(*pte);
> > > > > > +	}
> > > > > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > > > > +	else if (pmd) {
> > > > > > +		if (pmd_young(*pmd)) {
> > > > > > +			clear_page_idle(pmd_page(*pmd));
> > > > > > +			set_page_young(pmd_page(*pmd));
> > > > > > +		}
> > > > > > +		*pmd = pmd_mkold(*pmd);
> > > > > > +	}  
> > 
> > This is also very problematic if several regions are backed by a single huge
> > page, as only one region in the huge page will be checked as accessed.
> > 
> > Will address these problems in next spin!
> 
> Good point.  There is little point in ever having multiple regions including
> a single huge page.  Would it be possible to tweak the region splitting algorithm
> to not do this?

Yes, it would be a good solution.  However, I believe this is a problem of the
access checking mechanism, as the definition of the region is only 'memory
area having similar access frequency'.  Adding more rules such as 'it should
be aligned by HUGE PAGE size' might make things more complex.  Also, we're
currently using page table Accessed bits as the primitive for the access check,
but it could be extended to other primitives in future.   Therefore, I would
like to modify the access checking mechanism to aware the huge pages
existance.

For regions containing both regular pages and huge pages, the huge pages will
make some errorneous high access frequency as you noted before,  but the
adaptive regions adjustment will eventually split them.

If you have other concerns or opinions, please let me know.


Thanks,
SeongJae Park

> 
> Jonathan
> 
> > 
> > 
> > Thanks,
> > SeongJae Park
> > 
> > > > > > +#endif
> > > > > > +
> > > > > > +	spin_unlock(ptl);
> > > > > > +}
> > > > > > +  
> > > 
> > >   
> 
> 
