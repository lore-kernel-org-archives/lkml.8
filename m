Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FE0C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2ED2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="owNfNlcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgD2Hu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:50:56 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:57134 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2Huz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588146651; x=1619682651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=teZ3schqIwk5Ur6rIRRYOq/Br+PQCbgUdMtsz5F0RnQ=;
  b=owNfNlcXXdCz3tai4xal9LQdxJxQCblo/z+WbSzFzMg18E3YsAqMrsxe
   iWoVLrmxhJU1/EI5Lg2Lb4nTCM3sm7KJs9lF3NVrw0fw4hcv4bt3FRq+a
   QRKn8cFHBM7zI6Q1QCKQ8+9zQKQVJqpKSc+KHXJ9phHAcSFEphTVf6vZO
   Q=;
IronPort-SDR: Axxlu0q2mdHirtLN5NCnlSW7d4a3iiCAI7/dz35uzlF1qRwqgbZ19L6qIrtRLL1oJu5kqG7Zjh
 V7t8VCvK2j3w==
X-IronPort-AV: E=Sophos;i="5.73,330,1583193600"; 
   d="scan'208";a="28061837"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 29 Apr 2020 07:50:36 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id E6EBEA1D52;
        Wed, 29 Apr 2020 07:50:33 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Apr 2020 07:50:33 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.203) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Apr 2020 07:50:17 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <irogers@google.com>, <jolsa@redhat.com>,
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
Subject: Re: Re: [PATCH v9 00/15] Introduce Data Access MONitor (DAMON)
Date:   Wed, 29 Apr 2020 09:49:54 +0200
Message-ID: <20200429074954.24032-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428171713.000028df@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D38UWC001.ant.amazon.com (10.43.162.170) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 17:17:13 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 28 Apr 2020 15:23:42 +0200
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > On Tue, 28 Apr 2020 13:27:04 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > 
> > > On Mon, 27 Apr 2020 14:04:27 +0200
> > > SeongJae Park <sjpark@amazon.com> wrote:
> > >   
> > > > From: SeongJae Park <sjpark@amazon.de>
> > > > 
> > > > Introduction
> > > > ============
> > > > 
> > > > Memory management decisions can be improved if finer data access information is
> > > > available.  However, because such finer information usually comes with higher
> > > > overhead, most systems including Linux forgives the potential benefit and rely
> > > > on only coarse information or some light-weight heuristics.  The pseudo-LRU and
> > > > the aggressive THP promotions are such examples.
> > > > 
> > > > A number of data access pattern awared memory management optimizations (refer
> > > > to 'Appendix A' for more details) consistently say the potential benefit is not
> > > > small.  However, none of those has successfully merged to the mainline Linux
> > > > kernel mainly due to the absence of a scalable and efficient data access
> > > > monitoring mechanism.  Refer to 'Appendix B' to see the limitations of existing
> > > > memory monitoring mechanisms.
> > > > 
> > > > DAMON is a data access monitoring subsystem for the problem.  It is 1) accurate
> > > > enough to be used for the DRAM level memory management (a straightforward
> > > > DAMON-based optimization achieved up to 2.55x speedup), 2) light-weight enough
> > > > to be applied online (compared to a straightforward access monitoring scheme,
> > > > DAMON is up to 94,242.42x lighter) and 3) keeps predefined upper-bound overhead
> > > > regardless of the size of target workloads (thus scalable).  Refer to 'Appendix
> > > > C' if you interested in how it is possible, and 'Appendix F' to know how the
> > > > numbers collected.
> > > > 
> > > > DAMON has mainly designed for the kernel's memory management mechanisms.
> > > > However, because it is implemented as a standalone kernel module and provides
> > > > several interfaces, it can be used by a wide range of users including kernel
> > > > space programs, user space programs, programmers, and administrators.  DAMON
> > > > is now supporting the monitoring only, but it will also provide simple and
> > > > convenient data access pattern awared memory managements by itself.  Refer to
> > > > 'Appendix D' for more detailed expected usages of DAMON.
> > > >   
> > [...]
> > > > 
> > > > Future Plans
> > > > ============
> > > > 
> > > > This patchset is only for the first stage of DAMON.  As soon as this patchset
> > > > is merged, official patchsets for below future plans will be posted.
> > > >   
> > [...]
> > > > 
> > > > Support Various Address Spaces
> > > > ------------------------------
> > > > 
> > > > Currently, DAMON supports virtual memory address spaces using PTE Accessed bits
> > > > as its access checking primitive.  However, the core design of DAMON is not
> > > > dependent to such implementation details.  In a future, DAMON will decouple
> > > > those and support various address spaces including physical memory.  It will
> > > > further allow users to configure and even implement the primitives by
> > > > themselves for their special usecase.  Monitoring of page cache, NUMA nodes,
> > > > specific files, or block devices would be examples of such usecases.
> > > > 
> > > > An RFC patchset for this plan is already available
> > > > (https://lore.kernel.org/linux-mm/20200409094232.29680-1-sjpark@amazon.com/).
> > > >   
> > [...]
> > > > 
> > > > Patch History
> > > > =============
> > > > 
> > > > The most biggest change in this version is support of minimal region size,
> > > > which defaults to 'PAGE_SIZE'.  This change will reduce unnecessary region
> > > > splits and thus improve the quality of the output.  In a future, we will be
> > > > able to make this configurable for support of various access check primitives
> > > > such as PMUs.  
> > > 
> > > That is a good improvement.  Might be interesting to consider taking
> > > hugepages into account as well.  
> > 
> > Thanks!  Kudos to Stefan and you for giving me the comments for the change.
> > 
> > As abovely mentioned in 'Future Plans' section, DAMON will be highly
> > configurable.  You can see the plan in more detail via the RFC patchset[1].
> > Thus, the minimal region size will also be able to configured as users want,
> > including the size of the hugepage.
> > 
> > [1] https://lore.kernel.org/linux-mm/20200409094232.29680-1-sjpark@amazon.com/
> > 
> > > 
> > > One issue I've noted is that we have a degeneracy problem with the current
> > > region merging and splitting that perhaps could do with a small tweak.
> > > 
> > > Currently we can end with a very small number of regions because there
> > > is no limit on how many regions can be merged in a give pass for merging.
> > > However, splitting only doubles the number of regions.
> > > 
> > > I've been experimenting with a few loops of the splitting algorithm to ensure
> > > we don't end up stuck with limited regions.  I think the problem we are working
> > > around can be roughly described as:
> > > 
> > > 1) Program allocates a lot of memory - not really touching much of it.
> > > 2) Damon fuses the large memory allocations in to one region because the
> > >    access counts are always near 0. 
> > > 3) Program finishes setup.
> > > 4) Program accesses a few pages in the huge reason a lot, but not that much
> > >    for most of the rest.  Taking an extreme option, the page in the middle
> > >    gets all the accesses and the other 1G on either side gets none.
> > > 5) As a split always breaks the page in two, the chances of significantly
> > >    different values for the two resulting regions is low (as we only sample
> > >    the hot page occasionally).
> > > 
> > > If we just run the splits twice if the number of regions < max regions / 4
> > > then over time we should eventually get a region with the single hot page in it.
> > > We will get there faster if we split more (keeping below max regions).
> > > 
> > > As we always remain below max regions, we are still obeying the fixed
> > > maximum overhead and actually monitoring at closer to the desired granularity.  
> > 
> > Good point.  However, as you also mentioned, DAMON will slowly, but eventually
> > adjust the regions appropriately.
> > 
> > And yes, your suggested solution will work pretty well.  Indeed, my one
> > previous colleague found this problem on a few of special workloads and tried
> > the solution you suggested.  The improvement was clear.
> > 
> > However, I didn't adopt the solution due to below reasons.
> > 
> > First, IMHO, this is an accuracy improvement, rather than bug fix.  But the
> > extent of the enhancement didn't seem very critical to me.  Most of other
> > workloads didn't show such problem (and thus improvement).  Even with the
> > workloads showing the problem, the problem was not seem so critical.
> > 
> > Second, if the low accuracy is problem, users could get higher accuracy by
> > simply adjusting the sampling interval and/or aggregation interval to lower
> > value.  This is the supposed way to trade the accuracy with the overhead.
> 
> I disagree.  There is very little chance of getting out of this situation with the
> current splitting.  Changing sampling and aggregation intervals doesn't actually help.
> 
> Let's draw out an example to discuss.
> 
> Toy state - taking just one block of memory.
> 
> 0 = not accessed page (very cold)
> X = accessed page (extremely hot)
> 
> First few cycles - no accesses
> 
> in X.Regions list average value estimated by damon.
> 
> Region C is needed to set the max and will never be aggregated.
> 
> aggregation cycle then state.
> 0.start
> 0.accessed          0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 X X X
> 0.regions (percent)|  A (0)          |   B (0)                         | C(1)|
> 0.merge            |   A                                               | C   |
> 0.split            |  A                                |     B         | C   |
> 
> After a few cycles, hot page
> 1.start
> 1.accessed          0 0 0 0 0 0 0 0 0 0 0 X 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 1.regions (acc_cnt)|  A (1/18)                         |   B (0)       | C(1)|

             ^ not count but ratio, right?

> 1.merge            |             A                                     | C   |
> 1.split            |  A                    |                 B         | C   |
> 2.start
> 2.accessed          0 0 0 0 0 0 0 0 0 0 0 X 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 2.regions (acc_cnt)|  A (1/12)             |               B (0)       | C(1)|
> 2.merge            |             A                                     | C   |
> 2.split            |  A      |                               B         | C   |
> 3.start
> 3.accessed          0 0 0 0 0 0 0 0 0 0 0 X 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 3.regions (acc_cnt)|  A (0)  |               B (1/21)                  | C(1)|
> 3.merge            |             A                                     | C   |
> 3.split            |  A                |                     B         | C   |
> 
> Now make that 1000 pages long with the hot page at page 500.
> So the average best case we will ever get is a 1/500 * number of sample period
> between aggregations.

So nice example, thank you!  Now I understand the point.

So, the problem is that we cannot find the small hot region near the _middle_
because we split each region into only two subregions.

> 
> So what are the chances of failing to aggregate on the sample after we split
> at that optimal point? We need to successfully sample that one page enough that
> we get it 10% of the time.
> 
> I 'think' this a case of where the 10% point is on the CDF of a binomial
> f(1/N, M) where N is number of bins and Mis number of samples.
> 
> Using matlab online I think the best chance you ever get is when you take 10 samples
> and need just one of them to be in the region.
> 
> p = 1 - binocdf(0,10,1/N)
> For N = 500, p = 0.0198
> For N = 1000, p = 0.0099
> 
> Someone with better maths than me can check.
> 
> Now this just got us to the point where we won't aggregate the region for one
> round of aggregation.  We may split it again and if the resulting region is small
> enough might not merge it the next aggregation cycle.
> 
> So I'd argue that allowing at least 2 repeats of splitting is well worth while.
> It is just a couple of additional lines of code.

Nice suggestion, I will apply this suggestion in the next spin.  It might be as
below:

    if (nr_regions() < nr_max_regions / 4)
            split_into_4_regions();
    else if (nr_regions() < nr_max_regions / 2)
            split_into_2_regions();

If this pseudo-code is missing some of your point, please let me know.

> 
> > 
> > Finally, I would like to keep code as simple as it can.
> > 
> > For same reasons, I would like to keep the code as currently is until real user
> > problem is reported.  If you have different opinions, please feel free to yell
> > at me.
> 
> :) 

Appreciate your explanations and suggestions.


Thanks,
SeongJae Park
