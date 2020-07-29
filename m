Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7900EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B502076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uwtzVJYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgG2GVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:21:55 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:35007 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2GVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596003714; x=1627539714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=EOsZrcI2DbHuHivAY32JN5S9Mkp+QickCr/976Dprho=;
  b=uwtzVJYUhLwpanfKHpobAUNJu51jf9DV+e7sRt3vjABvsFRn6FjznFg5
   hqEGk9hjrsppBUJgoXmorctQlx2pCInf6C5lnNOvuH5uqWuBE0XKnZQHQ
   Bp03mWh425on+JUcPOQQiHTAmlN4pnY0dYWDSZBFuCU/qkzY/PZbRYC5U
   Q=;
IronPort-SDR: RzgqiX2nL/gU1hoo7Kvw/A5K1c20F/a3+/46me7Xocorfd2CV+s37I2tRKN/2pTS5o73mF0yiq
 2pPKRkKGtZvw==
X-IronPort-AV: E=Sophos;i="5.75,409,1589241600"; 
   d="scan'208";a="55653783"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 29 Jul 2020 06:21:49 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id EF2A5A23DE;
        Wed, 29 Jul 2020 06:21:38 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 06:21:37 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.221) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 06:21:08 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David Hildenbrand" <david@redhat.com>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, Ian Rogers <irogers@google.com>,
        <jolsa@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>,
        <mark.rutland@arm.com>, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, <rppt@kernel.org>,
        <sblbir@amazon.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, <linux-damon@amazon.com>,
        Linux MM <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH v18 06/14] mm/damon: Implement callbacks for the virtual memory address spaces
Date:   Wed, 29 Jul 2020 08:20:42 +0200
Message-ID: <20200729062042.30136-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod7fsGJMKC_oKbr6z_+N_WeGXYBSnMUx7xGxG8KrjY6a0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.221]
X-ClientProxiedBy: EX13D19UWC001.ant.amazon.com (10.43.162.64) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 10:42:11 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, Jul 27, 2020 at 2:03 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > On Mon, 27 Jul 2020 00:34:54 -0700 Greg Thelen <gthelen@google.com> wrote:
> >
> > > SeongJae Park <sjpark@amazon.com> wrote:
> > >
> > > > From: SeongJae Park <sjpark@amazon.de>
> > > >
> > > > This commit introduces a reference implementation of the address space
> > > > specific low level primitives for the virtual address space, so that
> > > > users of DAMON can easily monitor the data accesses on virtual address
> > > > spaces of specific processes by simply configuring the implementation to
> > > > be used by DAMON.
> > [...]
> > > > diff --git a/mm/damon.c b/mm/damon.c
> > > > index b844924b9fdb..386780739007 100644
> > > > --- a/mm/damon.c
> > > > +++ b/mm/damon.c
> > > > @@ -9,6 +9,9 @@
> > [...]
> > > > +/*
> > > > + * Functions for the access checking of the regions
> > > > + */
> > > > +
> > > > +static void damon_mkold(struct mm_struct *mm, unsigned long addr)
> > > > +{
> > > > +   pte_t *pte = NULL;
> > > > +   pmd_t *pmd = NULL;
> > > > +   spinlock_t *ptl;
> > > > +
> > > > +   if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
> > > > +           return;
> > > > +
> > > > +   if (pte) {
> > > > +           if (pte_young(*pte)) {
> > > > +                   clear_page_idle(pte_page(*pte));
> > > > +                   set_page_young(pte_page(*pte));
> > >
> > > While this compiles without support for PG_young and PG_idle, I assume
> > > it won't work well because it'd clear pte.young without setting
> > > PG_young.  And this would mess with vmscan.
> >
> > You're right, thanks for catching this up!  This definitely need to be fixed in
> > the next spin.
> >
> > >
> > > So this code appears to depend on PG_young and PG_idle, which are
> > > currently only available via CONFIG_IDLE_PAGE_TRACKING.  DAMON could
> > > depend on CONFIG_IDLE_PAGE_TRACKING via Kconfig.  But I assume that
> > > CONFIG_IDLE_PAGE_TRACKING and CONFIG_DAMON cannot be concurrently used
> > > because they'll stomp on each other's use of pte.young, PG_young,
> > > PG_idle.
> > > So I suspect we want:
> > > 1. CONFIG_DAMON to depend on !CONFIG_IDLE_PAGE_TRACKING and vise-versa.
> > > 2. PG_young,PG_idle and related helpers to depend on
> > >    CONFIG_DAMON||CONFIG_IDLE_PAGE_TRACKING.
> >
> > Awesome insights and suggestions, thanks!
> >
> > I would like to note that DAMON could be interfered by IDLE_PAGE_TRACKING and
> > vmscan, but not vice versa, as DAMON respects PG_idle and PG_young.  This
> > design came from the weak goal of DAMON.  DAMON aims to provide not perfect
> > monitoring but only best effort accuracy that would be sufficient for
> > performance-centric DRAM level memory management.  So, at that time, I thought
> > being interfered by IDLE_PAGE_TRACKING and the reclaim logic would not be a
> > real problem but letting IDLE_PAGE_TRACKING coexist is somehow beneficial.
> > That said, I couldn't find a real benefit of the coexistance yet, and the
> > problem of being interference now seems bigger as we will support more cases
> > including the page granularity.
> >
> > Maybe we could make IDLE_PAGE_TRACKING and DAMON coexist but mutual exclusive
> > in runtime, if the beneficial of coexistance turns out big.  However, I would
> > like to make it simple first and optimize the case later if real requirement
> > found.
> 
> If you are planning to have support for tracking at page granularity
> and physical memory monitoring in DAMON then I don't see any benefit
> of coexistence of DAMON with IDLE_PAGE_TRACKING. Though I will not
> push you to go that route if the code with coexistence is simple
> enough.

Agreed, I don't see the benefit, neither.  I already selected the mutual
exclusive way :)


Thanks,
SeongJae Park
