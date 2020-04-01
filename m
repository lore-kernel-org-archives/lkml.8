Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07187C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C805E208E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ClFLhGm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbgDAIXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:23:36 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:35257 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbgDAIXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585729416; x=1617265416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=aq3bWriBLQql0BndeSu53xWecGPtWYNKWQvYWVyRjRU=;
  b=ClFLhGm7G2oaGe91kr03It5oY9EldQ08Pt3sQ3PidOFFdc83cyma2Jm3
   g6aFp8TDRCMo8xgbgSuzkp6Ct+f1Y1wjL/ovBEJkS7fss1dPATYHFyMPL
   vxEDIHNzNgY/5dKS6a9CVMkWTA0CBYGlRGEFqXuYth5j8uqeoLCH1EkcS
   w=;
IronPort-SDR: 4SflCQgY22B5d62QR6UUROTKgfTsuxQh+AubpVF14xOq2OhLG1NA7fyz/7CIZ3/txiP3ZkocMf
 ym0kMjbqBpvQ==
X-IronPort-AV: E=Sophos;i="5.72,331,1580774400"; 
   d="scan'208";a="36012011"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 01 Apr 2020 08:23:33 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 0B274A333B;
        Wed,  1 Apr 2020 08:23:22 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 1 Apr 2020 08:23:22 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.8) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 1 Apr 2020 08:23:08 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v7 05/15] mm/damon: Adaptively adjust regions
Date:   Wed, 1 Apr 2020 10:22:53 +0200
Message-ID: <20200401082253.21405-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331170855.0000024f@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.8]
X-ClientProxiedBy: EX13D29UWC002.ant.amazon.com (10.43.162.254) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 17:08:55 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 18 Mar 2020 12:27:12 +0100
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > At the beginning of the monitoring, DAMON constructs the initial regions
> > by evenly splitting the memory mapped address space of the process into
> > the user-specified minimal number of regions.  In this initial state,
> > the assumption of the regions (pages in same region have similar access
> > frequencies) is normally not kept and thus the monitoring quality could
> > be low.  To keep the assumption as much as possible, DAMON adaptively
> > merges and splits each region.
> > 
> > For each ``aggregation interval``, it compares the access frequencies of
> > adjacent regions and merges those if the frequency difference is small.
> > Then, after it reports and clears the aggregated access frequency of
> > each region, it splits each region into two regions if the total number
> > of regions is smaller than the half of the user-specified maximum number
> > of regions.
> > 
> > In this way, DAMON provides its best-effort quality and minimal overhead
> > while keeping the bounds users set for their trade-off.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> A few more edge cases in here, and a suggestion that might be more costly
> but lead to simpler code.

Thank you for finding those!

> 
> Jonathan
> 
> > ---
> >  include/linux/damon.h |   6 +-
> >  mm/damon.c            | 148 ++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 145 insertions(+), 9 deletions(-)
> > 
[...]
> > diff --git a/mm/damon.c b/mm/damon.c
> > index 018016793555..23c0de3b502e 100644
> > --- a/mm/damon.c
> > +++ b/mm/damon.c
[...]
> > +
> > +/*
> > + * Split a region into two small regions
> > + *
> > + * r		the region to be split
> > + * sz_r		size of the first sub-region that will be made
> > + */
> > +static void damon_split_region_at(struct damon_ctx *ctx,
> > +		struct damon_region *r, unsigned long sz_r)
> > +{
> > +	struct damon_region *new;
> > +
> > +	new = damon_new_region(ctx, r->vm_start + sz_r, r->vm_end);
> > +	r->vm_end = new->vm_start;
> 
> We may well have a sampling address that is in the wrong region.
> It should have little effect on the stats as will fix on next sample
> but in my view still worth cleaning up.

Good catch!  I will fix this in next spin.

> 
> > +
> > +	damon_insert_region(new, r, damon_next_region(r));
> > +}
> > +
[...]
> > @@ -571,21 +689,29 @@ static int kdamond_fn(void *data)
> >  	struct damon_task *t;
> >  	struct damon_region *r, *next;
> >  	struct mm_struct *mm;
> > +	unsigned int max_nr_accesses;
> >  
> >  	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
> >  	kdamond_init_regions(ctx);
> >  	while (!kdamond_need_stop(ctx)) {
> > +		max_nr_accesses = 0;
> >  		damon_for_each_task(ctx, t) {
> >  			mm = damon_get_mm(t);
> >  			if (!mm)
> >  				continue;
> > -			damon_for_each_region(r, t)
> > +			damon_for_each_region(r, t) {
> >  				kdamond_check_access(ctx, mm, r);
> > +				max_nr_accesses = max(r->nr_accesses,
> > +						max_nr_accesses);
> > +			}
> >  			mmput(mm);
> >  		}
> >  
> > -		if (kdamond_aggregate_interval_passed(ctx))
> > +		if (kdamond_aggregate_interval_passed(ctx)) {
> > +			kdamond_merge_regions(ctx, max_nr_accesses / 10);
> >  			kdamond_reset_aggregated(ctx);
> > +			kdamond_split_regions(ctx);
> > +		}
> 
> I wonder if it would be simpler to split the sampling address setup and
> mkold from the access check.  We would have to walk regions twice,
> but not have to bother separately dealing with updating some regions
> if they are modified in the above block.
> 
> Also, the above has some overhead, so will bias that first sample each
> time the block above runs.  If we do the mkold afterwards it will make
> much less difference.

Agreed, it will make code much more simple and easy to read.  However, I'm not
sure how much of the overhead will be biased because 'aggregate interval' is
usually larger than 'sampling interval'.  Anyway, Will change so in the next
spin!


Thanks,
SeongJae Park

[...]
