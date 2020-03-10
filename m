Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE4FC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1A32464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GRH1ja5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgCJLyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:54:05 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:37380 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgCJLyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583841245; x=1615377245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=cEO6B2zoUX3o5zZBIn4kHVPe4ZydoyJnq/OuRSRvQzE=;
  b=GRH1ja5Pfjl4OECSNmhW4J2Vi7DHIvBkH3B0FDNgJWUM440jnRNndgy2
   7KdZJYOg3w3hmOxcWT5/0TssXYIHrszaE1Ll8AWSotpRNYOtL85Z/xzM3
   bqqJabwU56IqUlOrcyMhjKN02vwV2kXTCkkmaWpFu6valPX9RKNPM0RQr
   Q=;
IronPort-SDR: C8b11fHP0Abw2gjRpvgZA1QYpBVNPK8JVIYF8HfkLJo1vNbmbmzh/j4Ri4m/Djt0Pmetjt9l38
 Dz6SolDhTthg==
X-IronPort-AV: E=Sophos;i="5.70,536,1574121600"; 
   d="scan'208";a="21950836"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 Mar 2020 11:54:02 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id 6DA28A186F;
        Tue, 10 Mar 2020 11:53:51 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 10 Mar 2020 11:53:51 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.67) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 10 Mar 2020 11:53:39 +0000
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
Subject: Re: Re: [PATCH v6 03/14] mm/damon: Adaptively adjust regions
Date:   Tue, 10 Mar 2020 12:53:24 +0100
Message-ID: <20200310115324.23715-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310085747.000018ad@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.67]
X-ClientProxiedBy: EX13D27UWB004.ant.amazon.com (10.43.161.101) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 08:57:47 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 24 Feb 2020 13:30:36 +0100
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
> Really minor comments inline.

Very helpful comments for me.  You are indeed making this much better!  Will
apply whole your comments below in the next spin.

> 
> > ---
> >  mm/damon.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 144 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/damon.c b/mm/damon.c
> > index 6bdeb84d89af..1c8bb71bbce9 100644
> > --- a/mm/damon.c
> > +++ b/mm/damon.c
[...]
> > +/*
> > + * Merge adjacent regions having similar access frequencies
> > + *
> > + * t		task that merge operation will make change
> > + * thres	merge regions having '->nr_accesses' diff smaller than this
> > + */
> > +static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
> > +{
> > +	struct damon_region *r, *prev = NULL, *next;
> > +
> > +	damon_for_each_region_safe(r, next, t) {
> > +		if (!prev || prev->vm_end != r->vm_start)
> > +			goto next;
> > +		if (diff_of(prev->nr_accesses, r->nr_accesses) > thres) 
> > +			goto next;
> 
> 		if (!prev || prev->vm_end != r->vm_start ||
> 		    diff_of(prev->nr_accesses, r->nr_accesses) > thres) {
> 			prev = r;
> 			continue;
> 		}
> 
> Seems more logical to my head.  Maybe it's just me though.  A goto inside a
> loop isn't pretty to my mind.

Yes, your version seems much prettier to me, either :)

> 
> > +		damon_merge_two_regions(prev, r);
> > +		continue;
> > +next:
> > +		prev = r;
> > +	}
> > +}
> > +
[...]
> > @@ -590,21 +711,29 @@ static int kdamond_fn(void *data)
> >  	struct damon_task *t;
> >  	struct damon_region *r, *next;
> >  	struct mm_struct *mm;
> > +	unsigned long max_nr_accesses;
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
> > +				if (r->nr_accesses > max_nr_accesses)
> > +					max_nr_accesses = r->nr_accesses;
> 
> max_nr_accesses = max(r->nr_accesses, max_nr_accesses)

Good point!


Thanks,
SeongJae Park

[...]
