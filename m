Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5415AC2BA17
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1855720BED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s32rDEO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390621AbgDCKbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:31:34 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:62523 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585909894; x=1617445894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=W+Mk9Tz3acbW2EaatLr6OxnTB4VwVERiqP6QezBJjbs=;
  b=s32rDEO/CP0bprC4WI2TNduNskjIIw8n4rprzvgKPMlOOfr+9D5V0E2b
   2V8IwgK0yXSVH79zVsllf5tmYL1O//RsDLoibSANciyAbU7mJe5n00L7g
   HPDjduoygpRLCxO+tnzgg/UYcBZjcwWr7FndzoPiEYLUJotAExzan5swO
   w=;
IronPort-SDR: OX+31wBz9sK6p2/Fs71Q+DLcvCemPzEc6lB6NkAlEWY/kb56W2x7/DSlhoknm1iYgyaRy5ZyEK
 EoyNDm9UvYpA==
X-IronPort-AV: E=Sophos;i="5.72,339,1580774400"; 
   d="scan'208";a="35060697"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 03 Apr 2020 10:31:31 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 38310A0714;
        Fri,  3 Apr 2020 10:31:29 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 3 Apr 2020 10:31:28 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.241) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 3 Apr 2020 10:31:14 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH v7 04/15] mm/damon: Implement region based sampling
Date:   Fri, 3 Apr 2020 12:30:59 +0200
Message-ID: <20200403103059.12762-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402180022.32671-1-sj38.park@gmail.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.241]
X-ClientProxiedBy: EX13D02UWB002.ant.amazon.com (10.43.161.160) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Apr 2020 20:00:22 +0200 SeongJae Park <sj38.park@gmail.com> wrote:

> On Thu, 2 Apr 2020 18:24:01 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Thu, 2 Apr 2020 15:59:59 +0200
> > SeongJae Park <sjpark@amazon.com> wrote:
> > 
> > > On Wed, 1 Apr 2020 10:22:22 +0200 SeongJae Park <sjpark@amazon.com> wrote:
> > > 
> > > > On Tue, 31 Mar 2020 17:02:33 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > > >   
> > > > > On Wed, 18 Mar 2020 12:27:11 +0100
> > > > > SeongJae Park <sjpark@amazon.com> wrote:
> > > > >   
> > > > > > From: SeongJae Park <sjpark@amazon.de>
[...]
> > > > > > +static void damon_pte_pmd_mkold(pte_t *pte, pmd_t *pmd)
> > > > > > +{
> > > > > > +	if (pte) {
> > > > > > +		if (pte_young(*pte)) {
> > > > > > +			clear_page_idle(pte_page(*pte));
> > > > > > +			set_page_young(pte_page(*pte));
> > > > > > +		}
> > > > > > +		*pte = pte_mkold(*pte);
> > > > > > +		return;
> > > > > > +	}
> > > > > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > > > > +	if (pmd) {
> > > > > > +		if (pmd_young(*pmd)) {
> > > > > > +			clear_page_idle(pmd_page(*pmd));
> > > > > > +			set_page_young(pmd_page(*pmd));
> > > > > > +		}
> > > > > > +		*pmd = pmd_mkold(*pmd);
> > > > > > +	}
> > > > > > +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */  
> > > > > 
> > > > > No need to flush the TLBs?  
> > > > 
> > > > Good point!
> > > > 
> > > > I have intentionally skipped TLB flushing here to minimize the performance
> > > > effect to the target workload.  I also thought this might not degrade the
> > > > monitoring accuracy so much because we are targetting for the DRAM level
> > > > accesses of memory-intensive workloads, which might make TLB flood frequently.
> > > > 
> > > > However, your comment makes me thinking differently now.  By flushing the TLB
> > > > here, we will increase up to `number_of_regions` TLB misses for sampling
> > > > interval.  This might be not a huge overhead.  Also, improving the monitoring
> > > > accuracy makes no harm at all.  I even didn't measured the overhead.
> > > > 
> > > > I will test the overhead and if it is not significant, I will make this code to
> > > > flush TLB, in the next spin.  
> > > 
> > > Hmm, it seems like 'page_idle.c' is also modifying the Accessed bit but doesn't
> > > flush related TLB entries.  If I'm not missing something here, I would like to
> > > leave this part as is to make the behavior consistent.
> > 
> > Interesting.  In that usecase, the risk is that the MMU believes
> > the page still has the accessed bit set when we have cleared it and hence
> > the accessed bit is not written out to the table in memory.
> > 
> > That will give them a wrong decision so not great and would lead to them
> > thinking more pages are idle than are.
> > 
> > Here we could have a particular TLB entry for a huge page in which
> > a region lies entirely.  Because we don't flush the TLB each time
> > we could end with a count of 0 accesses when it should be the maximum.
> > A very frequently accessed page might well sit in the TLB for a very
> > long time (particularly if the TLB is running a clever eviction
> > strategy).
> > 
> > I think we would want to be test this and see if we get that
> > pathological case sometimes.  Also worth benchmarking if it actually
> > costs us very much to do the flushes.
> 
> Agreed, it wouldn't be late to make a decision after measuring the real cost.
> I will share the measurement results soon.  Meanwhile, it would be helpful if
> anyone could confirm whether page_idle.c is skipping TLB flushing and explain
> why such decision has made.

I just finished implementing TLB flushing in straightforward way (the diff for
this change is at the bottom of this mail) on the version I applied your
recommended changes and my one bug fix (setting 'last_accessed' false).

It shows monitoring accuracy improvement as expected, though it is not so big.
I compared the visualized access patterns of each test workload to check this.
There is no big difference, but the visualized pattern of TLB flushing version
seems a little bit more clear to my human eye.

However, the overhead is clear and significant to some workloads including
parsec3/streamcluster, splash2x/barnes, splash2x/lu_ncb and splash2x/volrend.
The CPU utilization of kdamond, the deamon monitoring the access pattern, never
exceeds 2% of single CPU time for the 4 workloads before the change is applied,
but it frequently exceeds 30% of single CPU time with the TLB flushing.  The
runtimes of the monitoring target workloads also increased.  In case of
parsec3/streamcluster, the TLB flushing changed its runtime from 320 seconds to
470 seconds.

So, it seems the benefit of TLB flushing is smaller than the cost in some
cases.  Thus, I think enabling TLB flushes by default wouldn't be a good
decision.  Rather than that, it could be better to allow users to manually do
TLB flushing for their specific workloads.  This will be easily available by
using the DAMON's sampling callback functions.  Also, I am planning to let
users to configure DAMON with their own access check / sampling setup functions
in future, to support not only virtual memory but also physical memory and some
other special cases.

If I'm missing something or you have other thinking, please let me know.


Thanks,
SeongJae Park

=============================== >8 ============================================

Below is the essential diff for the TLB flushing I implemented.  To double
check the overhead is really from the TLB flushing, I also measured the
overhead of the additional works including the vma searching by commenting out
the 'flush_tlb_range()' call.  After commenting out it, the CPU utilization of
kdamond and runtime of target workloads has restored back.  So, the overhead
seems really came from the TLB flushing.

@@ -408,6 +411,9 @@ static void kdamond_prepare_sampling(struct damon_ctx *ctx,
        pte_t *pte = NULL;
        pmd_t *pmd = NULL;
        spinlock_t *ptl;
+       struct vm_area_struct *vma;
+       unsigned long tlb_start;
+       unsigned long tlb_size = PAGE_SIZE;

        r->sampling_addr = damon_rand(ctx, r->vm_start, r->vm_end);

@@ -420,18 +426,29 @@ static void kdamond_prepare_sampling(struct damon_ctx *ctx,
                        set_page_young(pte_page(*pte));
                }
                *pte = pte_mkold(*pte);
-               return;
        }
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-       if (pmd) {
+       else if (pmd) {
                if (pmd_young(*pmd)) {
                        clear_page_idle(pmd_page(*pmd));
                        set_page_young(pmd_page(*pmd));
                }
                *pmd = pmd_mkold(*pmd);
+               tlb_size = ((1UL) << HPAGE_PMD_SHIFT);
        }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
        spin_unlock(ptl);
+
+       tlb_start = ALIGN(r->sampling_addr, tlb_size);
+
+       down_read(&mm->mmap_sem);
+       vma = find_vma(mm, r->sampling_addr);
+       if (!vma || (r->sampling_addr < vma->vm_start))
+               goto out;
+       flush_tlb_range(vma, tlb_start, tlb_start + tlb_size);
+
+out:
+       up_read(&mm->mmap_sem);
 }


Thanks,
SeongJae Park
