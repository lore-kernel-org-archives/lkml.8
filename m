Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758C3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FED62077D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WnzST6NS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgFDH1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:27:06 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:39602 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgFDH1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591255624; x=1622791624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=+aJnrbUqvIFf7ohzedUN3gFIX2zz4KmsEL9w8+oGKN4=;
  b=WnzST6NSZtPmoQZ4DcOQPA7mnUK2a7XFRjYsi/mRneofh6PyBWGbhxOt
   d+36W7kEEZmx4ed7s/ex0uKD2THxzb+212VahwvGxIinthhJZdnF7JpVB
   v1aCxPlBi1esF1TKDzFOlEKXzgmMDrePuwnVMwD+2Osc2D9u6kAOct+Cz
   U=;
IronPort-SDR: J426QVX8oEfi7sc+ZPTlCCdn2WttshPkHh3eyOgQx47XJSmAizil8O2vjaFySFbrmJzpkfYb28
 Pt2T5fDVQU2Q==
X-IronPort-AV: E=Sophos;i="5.73,471,1583193600"; 
   d="scan'208";a="34436999"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 04 Jun 2020 07:26:47 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 9A103A25A5;
        Thu,  4 Jun 2020 07:26:44 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 4 Jun 2020 07:26:44 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 4 Jun 2020 07:26:26 +0000
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
Date:   Thu, 4 Jun 2020 09:26:11 +0200
Message-ID: <20200604072611.11049-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <bd640661-143f-882f-ed92-3d2791b173aa@redhat.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D10UWA002.ant.amazon.com (10.43.160.228) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 18:09:21 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 03.06.20 16:11, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit implements the four callbacks (->init_target_regions,
> > ->update_target_regions, ->prepare_access_check, and ->check_accesses)
> > for the basic access monitoring of the physical memory address space.
> > By setting the callback pointers to point those, users can easily
> > monitor the accesses to the physical memory.
> > 
> > Internally, it uses the PTE Accessed bit, as similar to that of the
> > virtual memory support.  Also, it supports only page frames that
> > supported by idle page tracking.  Acutally, most of the code is stollen
> > from idle page tracking.  Users who want to use other access check
> > primitives and monitor the frames that not supported with this
> > implementation could implement their own callbacks on their own.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  include/linux/damon.h |   5 ++
> >  mm/damon.c            | 184 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 189 insertions(+)
> > 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 1a788bfd1b4e..f96503a532ea 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -216,6 +216,11 @@ void kdamond_update_vm_regions(struct damon_ctx *ctx);
> >  void kdamond_prepare_vm_access_checks(struct damon_ctx *ctx);
> >  unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx);
> >  
> > +void kdamond_init_phys_regions(struct damon_ctx *ctx);
> > +void kdamond_update_phys_regions(struct damon_ctx *ctx);
> > +void kdamond_prepare_phys_access_checks(struct damon_ctx *ctx);
> > +unsigned int kdamond_check_phys_accesses(struct damon_ctx *ctx);
> > +
> >  int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
> >  int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> >  		unsigned long aggr_int, unsigned long regions_update_int,
> > diff --git a/mm/damon.c b/mm/damon.c
> > index f5cbc97a3bbc..6a5c6d540580 100644
> > --- a/mm/damon.c
> > +++ b/mm/damon.c
> > @@ -19,7 +19,9 @@
> >  #include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/page_idle.h>
> > +#include <linux/pagemap.h>
> >  #include <linux/random.h>
> > +#include <linux/rmap.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/sched/task.h>
> >  #include <linux/slab.h>
> > @@ -480,6 +482,11 @@ void kdamond_init_vm_regions(struct damon_ctx *ctx)
> >  	}
> >  }
> >  
> > +/* Do nothing.  Users should set the initial regions by themselves */
> > +void kdamond_init_phys_regions(struct damon_ctx *ctx)
> > +{
> > +}
> > +
> >  static void damon_mkold(struct mm_struct *mm, unsigned long addr)
> >  {
> >  	pte_t *pte = NULL;
> > @@ -611,6 +618,178 @@ unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx)
> >  	return max_nr_accesses;
> >  }
> >  
> > +/* access check functions for physical address based regions */
> > +
> > +/* This code is stollen from page_idle.c */
> > +static struct page *damon_phys_get_page(unsigned long pfn)
> > +{
> > +	struct page *page;
> > +	pg_data_t *pgdat;
> > +
> > +	if (!pfn_valid(pfn))
> > +		return NULL;
> > +
> 
> Who provides these pfns? Can these be random pfns, supplied unchecked by
> user space? Or are they at least mapped into some user space process?

Your guess is right, users can give random physical address and that will be
translated into pfn.

> 
> IOW, do we need a pfn_to_online_page() to make sure the memmap even was
> initialized?

Thank you for pointing out this!  I will use it in the next spin.  Also, this
code is stollen from page_idle_get_page().  Seems like it should also be
modified to use it.  I will send the patch for it, either.


Thanks,
SeongJae Park

> 
> -- 
> Thanks,
> 
> David / dhildenb
