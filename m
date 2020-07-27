Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70508C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48ABD20759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YvSZb7Y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgG0JDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:03:36 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:23452 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgG0JDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595840616; x=1627376616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=oYQUjD8dm/BApSQBrI8Gg5yalczlaUdJshqRb6pjbFc=;
  b=YvSZb7Y2b+yrwvLX5yBmaw36yNlVZEVU9HhkmXeMyFiytCSldgQwZELN
   rLsqKiLNxfuvotkN8yeP7/yQ8F+cL7f8HQobVqo9wqv9kmgoXcC8VOUmz
   krqwKIJMMSfmx0zuQaS8DQzABQPRe6sJoZiiG6Ih3YJAms0qbCJJHXwCR
   c=;
IronPort-SDR: SeUBRoAaOOHBYkmwX+kFFfS0f8E2TXF9TxG1RPvIcCdkvjKgx+opOY2SaqTBlDb9GuvV29duQw
 S/y4+38llViw==
X-IronPort-AV: E=Sophos;i="5.75,402,1589241600"; 
   d="scan'208";a="63149857"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 Jul 2020 09:03:33 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id AD0E1A1E1E;
        Mon, 27 Jul 2020 09:03:30 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Jul 2020 09:03:29 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.48) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Jul 2020 09:03:13 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Greg Thelen <gthelen@google.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v18 06/14] mm/damon: Implement callbacks for the virtual memory address spaces
Date:   Mon, 27 Jul 2020 11:02:55 +0200
Message-ID: <20200727090255.24114-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <xr934kpt76n5.fsf@gthelen.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D47UWC003.ant.amazon.com (10.43.162.70) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 00:34:54 -0700 Greg Thelen <gthelen@google.com> wrote:

> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This commit introduces a reference implementation of the address space
> > specific low level primitives for the virtual address space, so that
> > users of DAMON can easily monitor the data accesses on virtual address
> > spaces of specific processes by simply configuring the implementation to
> > be used by DAMON.
[...]
> > diff --git a/mm/damon.c b/mm/damon.c
> > index b844924b9fdb..386780739007 100644
> > --- a/mm/damon.c
> > +++ b/mm/damon.c
> > @@ -9,6 +9,9 @@
[...]
> > +/*
> > + * Functions for the access checking of the regions
> > + */
> > +
> > +static void damon_mkold(struct mm_struct *mm, unsigned long addr)
> > +{
> > +	pte_t *pte = NULL;
> > +	pmd_t *pmd = NULL;
> > +	spinlock_t *ptl;
> > +
> > +	if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
> > +		return;
> > +
> > +	if (pte) {
> > +		if (pte_young(*pte)) {
> > +			clear_page_idle(pte_page(*pte));
> > +			set_page_young(pte_page(*pte));
> 
> While this compiles without support for PG_young and PG_idle, I assume
> it won't work well because it'd clear pte.young without setting
> PG_young.  And this would mess with vmscan.

You're right, thanks for catching this up!  This definitely need to be fixed in
the next spin.

> 
> So this code appears to depend on PG_young and PG_idle, which are
> currently only available via CONFIG_IDLE_PAGE_TRACKING.  DAMON could
> depend on CONFIG_IDLE_PAGE_TRACKING via Kconfig.  But I assume that
> CONFIG_IDLE_PAGE_TRACKING and CONFIG_DAMON cannot be concurrently used
> because they'll stomp on each other's use of pte.young, PG_young,
> PG_idle.
> So I suspect we want:
> 1. CONFIG_DAMON to depend on !CONFIG_IDLE_PAGE_TRACKING and vise-versa.
> 2. PG_young,PG_idle and related helpers to depend on
>    CONFIG_DAMON||CONFIG_IDLE_PAGE_TRACKING.

Awesome insights and suggestions, thanks!

I would like to note that DAMON could be interfered by IDLE_PAGE_TRACKING and
vmscan, but not vice versa, as DAMON respects PG_idle and PG_young.  This
design came from the weak goal of DAMON.  DAMON aims to provide not perfect
monitoring but only best effort accuracy that would be sufficient for
performance-centric DRAM level memory management.  So, at that time, I thought
being interfered by IDLE_PAGE_TRACKING and the reclaim logic would not be a
real problem but letting IDLE_PAGE_TRACKING coexist is somehow beneficial.
That said, I couldn't find a real benefit of the coexistance yet, and the
problem of being interference now seems bigger as we will support more cases
including the page granularity.

Maybe we could make IDLE_PAGE_TRACKING and DAMON coexist but mutual exclusive
in runtime, if the beneficial of coexistance turns out big.  However, I would
like to make it simple first and optimize the case later if real requirement
found.

So, I will implement your suggestions in the next spin.  If you have different
opinions, please feel free to comment.


Thanks,
SeongJae Park

> 
> > +		}
> > +		*pte = pte_mkold(*pte);
> > +		pte_unmap_unlock(pte, ptl);
> > +		return;
> > +	}
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +	if (pmd_young(*pmd)) {
> > +		clear_page_idle(pmd_page(*pmd));
> > +		set_page_young(pmd_page(*pmd));
> > +	}
> > +	*pmd = pmd_mkold(*pmd);
> > +	spin_unlock(ptl);
> > +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > +}
> > +
[...]
