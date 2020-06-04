Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE407C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83BE20823
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v5DiGFHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgFDPwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:52:46 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:22272 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbgFDPwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591285963; x=1622821963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=rro1dCA8mdvzB4YEq6Fx6hbHgop/UXVIZ3C9s/pEFCo=;
  b=v5DiGFHpBcZeZXeMrNwH5aG1t61d/uJ6hCEXdhs903A26sJiwNcO27by
   M7QDevAtMQoy/ZSD7v4dOsEOcSfDYugbQy5TdfHK7WJlaXZu7VdDMULO9
   +Na155Ngw98D7gtoh1xwjubAOlootS1FTO8MCg7VKdZyS1agzQsKZmJ4l
   U=;
IronPort-SDR: zYWnJkbK7SrzTlpSN/+YveACT537t7WhauBSro6JA/BMM8JPSQsKT0ytojDET1nE5hRqg0huPj
 VzqZrPC0y1PA==
X-IronPort-AV: E=Sophos;i="5.73,472,1583193600"; 
   d="scan'208";a="48520380"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 04 Jun 2020 15:52:41 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 71FF7A2518;
        Thu,  4 Jun 2020 15:52:30 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 4 Jun 2020 15:52:30 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 4 Jun 2020 15:52:12 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     David Hildenbrand <david@redhat.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: [RFC v2 7/9] mm/damon: Implement callbacks for physical memory monitoring
Date:   Thu, 4 Jun 2020 17:51:58 +0200
Message-ID: <20200604155158.12760-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3be79702-2ac5-5c5b-b913-3c93aadf0aec@redhat.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D44UWC004.ant.amazon.com (10.43.162.209) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 17:39:49 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 04.06.20 17:23, SeongJae Park wrote:
> > On Thu, 4 Jun 2020 16:58:13 +0200 David Hildenbrand <david@redhat.com> wrote:
> > 
> >> On 04.06.20 09:26, SeongJae Park wrote:
> >>> On Wed, 3 Jun 2020 18:09:21 +0200 David Hildenbrand <david@redhat.com> wrote:
> >>>
> >>>> On 03.06.20 16:11, SeongJae Park wrote:
> >>>>> From: SeongJae Park <sjpark@amazon.de>
> >>>>>
> >>>>> This commit implements the four callbacks (->init_target_regions,
> >>>>> ->update_target_regions, ->prepare_access_check, and ->check_accesses)
> >>>>> for the basic access monitoring of the physical memory address space.
> >>>>> By setting the callback pointers to point those, users can easily
> >>>>> monitor the accesses to the physical memory.
> >>>>>
> >>>>> Internally, it uses the PTE Accessed bit, as similar to that of the
> >>>>> virtual memory support.  Also, it supports only page frames that
> >>>>> supported by idle page tracking.  Acutally, most of the code is stollen
> >>>>> from idle page tracking.  Users who want to use other access check
> >>>>> primitives and monitor the frames that not supported with this
> >>>>> implementation could implement their own callbacks on their own.
> >>>>>
> >>>>> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> >>>>> ---
> >>>>>  include/linux/damon.h |   5 ++
> >>>>>  mm/damon.c            | 184 ++++++++++++++++++++++++++++++++++++++++++
> >>>>>  2 files changed, 189 insertions(+)
> >>>>>
> >>>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
> >>>>> index 1a788bfd1b4e..f96503a532ea 100644
> >>>>> --- a/include/linux/damon.h
> >>>>> +++ b/include/linux/damon.h
> >>>>> @@ -216,6 +216,11 @@ void kdamond_update_vm_regions(struct damon_ctx *ctx);
> >>>>>  void kdamond_prepare_vm_access_checks(struct damon_ctx *ctx);
> >>>>>  unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx);
> >>>>>  
> >>>>> +void kdamond_init_phys_regions(struct damon_ctx *ctx);
> >>>>> +void kdamond_update_phys_regions(struct damon_ctx *ctx);
> >>>>> +void kdamond_prepare_phys_access_checks(struct damon_ctx *ctx);
> >>>>> +unsigned int kdamond_check_phys_accesses(struct damon_ctx *ctx);
> >>>>> +
> >>>>>  int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
> >>>>>  int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> >>>>>  		unsigned long aggr_int, unsigned long regions_update_int,
> >>>>> diff --git a/mm/damon.c b/mm/damon.c
> >>>>> index f5cbc97a3bbc..6a5c6d540580 100644
> >>>>> --- a/mm/damon.c
> >>>>> +++ b/mm/damon.c
> >>>>> @@ -19,7 +19,9 @@
> >>>>>  #include <linux/mm.h>
> >>>>>  #include <linux/module.h>
> >>>>>  #include <linux/page_idle.h>
> >>>>> +#include <linux/pagemap.h>
> >>>>>  #include <linux/random.h>
> >>>>> +#include <linux/rmap.h>
> >>>>>  #include <linux/sched/mm.h>
> >>>>>  #include <linux/sched/task.h>
> >>>>>  #include <linux/slab.h>
> >>>>> @@ -480,6 +482,11 @@ void kdamond_init_vm_regions(struct damon_ctx *ctx)
> >>>>>  	}
> >>>>>  }
> >>>>>  
> >>>>> +/* Do nothing.  Users should set the initial regions by themselves */
> >>>>> +void kdamond_init_phys_regions(struct damon_ctx *ctx)
> >>>>> +{
> >>>>> +}
> >>>>> +
> >>>>>  static void damon_mkold(struct mm_struct *mm, unsigned long addr)
> >>>>>  {
> >>>>>  	pte_t *pte = NULL;
> >>>>> @@ -611,6 +618,178 @@ unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx)
> >>>>>  	return max_nr_accesses;
> >>>>>  }
> >>>>>  
> >>>>> +/* access check functions for physical address based regions */
> >>>>> +
> >>>>> +/* This code is stollen from page_idle.c */
> >>>>> +static struct page *damon_phys_get_page(unsigned long pfn)
> >>>>> +{
> >>>>> +	struct page *page;
> >>>>> +	pg_data_t *pgdat;
> >>>>> +
> >>>>> +	if (!pfn_valid(pfn))
> >>>>> +		return NULL;
> >>>>> +
> >>>>
> >>>> Who provides these pfns? Can these be random pfns, supplied unchecked by
> >>>> user space? Or are they at least mapped into some user space process?
> >>>
> >>> Your guess is right, users can give random physical address and that will be
> >>> translated into pfn.
> >>>
> >>
> >> Note the difference to idle tracking: "Idle page tracking only considers
> >> user memory pages", this is very different to your use case. Note that
> >> this is why there is no pfn_to_online_page() check in page idle code.
> > 
> > My use case is same to that of idle page.  I also ignore non-user pages.
> > Actually, this function is for filtering of the non-user pages, which is simply
> > stollen from the page_idle.
> 
> Okay, that is valuable information, I missed that. The comment in
> page_idle.c is actually pretty valuable.
> 
> In both cases, user space can provide random physical address but you
> will only care about user pages. Understood.
> 
> That turns things less dangerous. :)

Glad to hear this.  I will refine this point in the next spin! :)

> 
> >>>> IOW, do we need a pfn_to_online_page() to make sure the memmap even was
> >>>> initialized?
> >>>
> >>> Thank you for pointing out this!  I will use it in the next spin.  Also, this
> >>> code is stollen from page_idle_get_page().  Seems like it should also be
> >>> modified to use it.  I will send the patch for it, either.
> >>
> >> pfn_to_online_page() will only succeed for system RAM pages, not
> >> dax/pmem (ZONE_DEVICE). dax/pmem needs special care.
> >>
> >> I can spot that you are taking references to random struct pages. This
> >> looks dangerous to me and might mess in complicated ways with page
> >> migration/isolation/onlining/offlining etc. I am not sure if we want that.
> > 
> > AFAIU, page_idle users can also pass random pfns by randomly accessing the
> > bitmap file.  Am I missing something?
> 
> I am definitely no expert on page idle tracking. If that is the case,
> then we'll also need pfn_to_online_page() handling (and might have to
> care about ZONE_DEVICE, not hard but needs some extra LOCs).

Agree, I will post the patch soon.  That said, if you get any doubt, please
don't hesitate yelling.

> 
> I am still not sure if grabbing references on theoretically isolated
> pageblocks is okay, but that's just complicated stuff and as you state,
> is already performed. At least I can read "With such an indicator of
> user pages we can skip isolated pages". So isolated pages during page
> migration are properly handled.
> 
> 
> Instead of stealing, factor out, document, and reuse? That makes it
> clearer that you are not inventing the wheel, and if we have to fix
> something, we only have to fix at a single point.

Good point, I will consider reusing the code instead of stealing in the next
spin.


Thanks,
SeongJae Park

> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
