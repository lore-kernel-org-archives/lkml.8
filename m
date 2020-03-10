Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39686C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE79215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCJPzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:55:18 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2542 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbgCJPzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:55:17 -0400
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 8A3E3C6E21A78A430E07;
        Tue, 10 Mar 2020 15:55:13 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 15:55:13 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 15:55:12 +0000
Date:   Tue, 10 Mar 2020 15:55:10 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <aarcange@redhat.com>, <yang.shi@linux.alibaba.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/14] mm/damon: Implement region based sampling
Message-ID: <20200310155510.000025d2@Huawei.com>
In-Reply-To: <20200310115233.23246-1-sjpark@amazon.com>
References: <20200310085721.00000a0f@Huawei.com>
        <20200310115233.23246-1-sjpark@amazon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 12:52:33 +0100
SeongJae Park <sjpark@amazon.com> wrote:

> Added replies to your every comment in line below.  I agree to your whole
> opinions, will apply those in next spin! :)
> 

One additional question inline that came to mind.  Using a single statistic
to monitor huge page and normal page hits is going to give us problems
I think.

Perhaps I'm missing something?

> > > +/*
> > > + * Check whether the given region has accessed since the last check  
> > 
> > Should also make clear that this sets us up for the next access check at
> > a different memory address it the region.
> > 
> > Given the lack of connection between activities perhaps just split this into
> > two functions that are always called next to each other.  
> 
> Will make the description more clearer as suggested.
> 
> Also, I found that I'm not clearing *pte and *pmd before going 'mkold', thanks
> to this comment.  Will fix it, either.
> 
> >   
> > > + *
> > > + * mm	'mm_struct' for the given virtual address space
> > > + * r	the region to be checked
> > > + */
> > > +static void kdamond_check_access(struct damon_ctx *ctx,
> > > +			struct mm_struct *mm, struct damon_region *r)
> > > +{
> > > +	pte_t *pte = NULL;
> > > +	pmd_t *pmd = NULL;
> > > +	spinlock_t *ptl;
> > > +
> > > +	if (follow_pte_pmd(mm, r->sampling_addr, NULL, &pte, &pmd, &ptl))
> > > +		goto mkold;
> > > +
> > > +	/* Read the page table access bit of the page */
> > > +	if (pte && pte_young(*pte))
> > > +		r->nr_accesses++;
> > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE  
> > 
> > Is it worth having this protection?  Seems likely to have only a very small
> > influence on performance and makes it a little harder to reason about the code.  
> 
> It was necessary for addressing 'implicit declaration' problem of 'pmd_young()'
> and 'pmd_mkold()' for build of DAMON on several architectures including User
> Mode Linux.
> 
> Will modularize the code for better readability.
> 
> >   
> > > +	else if (pmd && pmd_young(*pmd))
> > > +		r->nr_accesses++;

So we increment a region count by one if we have an access in a huge page, or
in a normal page.

If we get a region that has a mixture of the two, this seems likely to give a
bad approximation.

Assume the region is accessed 'evenly' but each " 4k page" is only hit 10% of the time
(where a hit is in one check period)

If our address in a page, then we'll hit 10% of the time, but if it is in a 2M
huge page then we'll hit a much higher percentage of the time.
1 - (0.9^512) ~= 1

Should we look to somehow account for this?

> > > +#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
> > > +
> > > +	spin_unlock(ptl);
> > > +
> > > +mkold:
> > > +	/* mkold next target */
> > > +	r->sampling_addr = damon_rand(ctx, r->vm_start, r->vm_end);
> > > +
> > > +	if (follow_pte_pmd(mm, r->sampling_addr, NULL, &pte, &pmd, &ptl))
> > > +		return;
> > > +
> > > +	if (pte) {
> > > +		if (pte_young(*pte)) {
> > > +			clear_page_idle(pte_page(*pte));
> > > +			set_page_young(pte_page(*pte));
> > > +		}
> > > +		*pte = pte_mkold(*pte);
> > > +	}
> > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > +	else if (pmd) {
> > > +		if (pmd_young(*pmd)) {
> > > +			clear_page_idle(pmd_page(*pmd));
> > > +			set_page_young(pmd_page(*pmd));
> > > +		}
> > > +		*pmd = pmd_mkold(*pmd);
> > > +	}
> > > +#endif
> > > +
> > > +	spin_unlock(ptl);
> > > +}
> > > +



