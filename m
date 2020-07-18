Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199E4C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 02:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0412070E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 02:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G5uaZnRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgGRCwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 22:52:41 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2704 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGRCwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595040760; x=1626576760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=/6JkoobPwF5BrmIAwJMq4G3QuiQzdD9VSEAmA33e7wo=;
  b=G5uaZnRVyxMD30swHjweLG2b9hCJLXj/ZULoSjA4/3xiuibbfcqhcVNq
   2hAE17I7GIVMzdf514FXVUlzkJI8nKig3Z89NUIDjvGRQW46JQKsc4hml
   BARWjCC5CUae33svejVIHeKo/EQnN8vjRQGdx417mDPcfC806/XorG3KH
   s=;
IronPort-SDR: Vdl0QXsFVg6JMMLvM5eqebj1Y0+Jo9ZZ0lWpw7ngv40B4EPDpMa+8G/801KD/YBEUld6lRn58V
 DD40WAsSFUcA==
X-IronPort-AV: E=Sophos;i="5.75,365,1589241600"; 
   d="scan'208";a="60742406"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 18 Jul 2020 02:52:37 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id EDE25A279C;
        Sat, 18 Jul 2020 02:52:34 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 18 Jul 2020 02:52:34 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.140) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 18 Jul 2020 02:52:18 +0000
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
Subject: Re: Re: Re: Re: [PATCH v18 06/14] mm/damon: Implement callbacks for the virtual memory address spaces
Date:   Sat, 18 Jul 2020 04:51:58 +0200
Message-ID: <20200718025158.771-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod7RLDhVFyU8us2w464EsbCtA0virgn0CfOWnG3RBv8MNg@mail.gmail.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.140]
X-ClientProxiedBy: EX13D13UWB002.ant.amazon.com (10.43.161.21) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 19:23:28 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Fri, Jul 17, 2020 at 9:24 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > On Fri, 17 Jul 2020 08:17:09 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> >
> > > On Thu, Jul 16, 2020 at 11:54 PM SeongJae Park <sjpark@amazon.com> wrote:
> > > >
> > > > On Thu, 16 Jul 2020 17:46:54 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> > > >
> > > > > On Mon, Jul 13, 2020 at 1:44 AM SeongJae Park <sjpark@amazon.com> wrote:
> > > > > >
> > > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > > >
> > > > > > This commit introduces a reference implementation of the address space
> > > > > > specific low level primitives for the virtual address space, so that
> > > > > > users of DAMON can easily monitor the data accesses on virtual address
> > > > > > spaces of specific processes by simply configuring the implementation to
> > > > > > be used by DAMON.
> > > > > >
> > > > > > The low level primitives for the fundamental access monitoring are
> > > > > > defined in two parts:
> > > > > > 1. Identification of the monitoring target address range for the address
> > > > > > space.
> > > > > > 2. Access check of specific address range in the target space.
> > > > > >
> > > > > > The reference implementation for the virtual address space provided by
> > > > > > this commit is designed as below.
> > > > > >
> > > > > > PTE Accessed-bit Based Access Check
> > > > > > -----------------------------------
> > > > > >
> > > > > > The implementation uses PTE Accessed-bit for basic access checks.  That
> > > > > > is, it clears the bit for next sampling target page and checks whether
> > > > > > it set again after one sampling period.  To avoid disturbing other
> > > > > > Accessed bit users such as the reclamation logic, the implementation
> > > > > > adjusts the ``PG_Idle`` and ``PG_Young`` appropriately, as same to the
> > > > > > 'Idle Page Tracking'.
> > > > > >
> > > > > > VMA-based Target Address Range Construction
> > > > > > -------------------------------------------
> > > > > >
> > > > > > Only small parts in the super-huge virtual address space of the
> > > > > > processes are mapped to physical memory and accessed.  Thus, tracking
> > > > > > the unmapped address regions is just wasteful.  However, because DAMON
> > > > > > can deal with some level of noise using the adaptive regions adjustment
> > > > > > mechanism, tracking every mapping is not strictly required but could
> > > > > > even incur a high overhead in some cases.  That said, too huge unmapped
> > > > > > areas inside the monitoring target should be removed to not take the
> > > > > > time for the adaptive mechanism.
> > > > > >
> > > > > > For the reason, this implementation converts the complex mappings to
> > > > > > three distinct regions that cover every mapped area of the address
> > > > > > space.  Also, the two gaps between the three regions are the two biggest
> > > > > > unmapped areas in the given address space.  The two biggest unmapped
> > > > > > areas would be the gap between the heap and the uppermost mmap()-ed
> > > > > > region, and the gap between the lowermost mmap()-ed region and the stack
> > > > > > in most of the cases.  Because these gaps are exceptionally huge in
> > > > > > usual address spacees, excluding these will be sufficient to make a
> > > > > > reasonable trade-off.  Below shows this in detail::
> > > > > >
> > > > > >     <heap>
> > > > > >     <BIG UNMAPPED REGION 1>
> > > > > >     <uppermost mmap()-ed region>
> > > > > >     (small mmap()-ed regions and munmap()-ed regions)
> > > > > >     <lowermost mmap()-ed region>
> > > > > >     <BIG UNMAPPED REGION 2>
> > > > > >     <stack>
> > > > > >
> > > > > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > > > > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > > > > [snip]
> > > > > > +
> > > > > > +static void damon_mkold(struct mm_struct *mm, unsigned long addr)
> > > > > > +{
> > > > > > +       pte_t *pte = NULL;
> > > > > > +       pmd_t *pmd = NULL;
> > > > > > +       spinlock_t *ptl;
> > > > > > +
> > > > > > +       if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
> > > > > > +               return;
> > > > > > +
> > > > > > +       if (pte) {
> > > > > > +               if (pte_young(*pte)) {
> > > > >
> > > > > Any reason for skipping mmu_notifier_clear_young()? Why exclude VMs as
> > > > > DAMON's target applications?
> > > >
> > > > Obviously my mistake, thank you for pointing this!  I will add the function
> > > > call in the next spin.
> > > >
> > >
> > > Similarly mmu_notifier_test_young() for the damon_young().
> >
> > Yes, indeed.  Thanks for pointing this, either :)
> >
> > > BTW I think we can combine ctx->prepare_access_checks() and
> > > ctx->check_accesses() into one i.e. get the young state for the previous
> > > cycle and mkold for the next cycle in a single step.
> >
> > Yes, we could.  But, I'm unsure what is the advantage of doing that.  First of
> > all, if the combined implementation is required, peopld could simply implement
> > the two logics in the combined way in one of the callbacks and leave the other
> > one blank.  Also, I'm worrying if combining those could make the code a little
> > bit hard to read.  IMHO, I think separating those makes the 'kdamond_fn()' code
> > little bit easier to read.  Actually, I started from the combined approach but
> > separated the two logics since v7 after Jonathan's comment[1].
> >
> >
> > [1] https://lore.kernel.org/linux-mm/20200310085721.00000a0f@Huawei.com/
> >
> >
> > >
> > > I am wondering if there is any advantage to having "Page Idle
> > > Tracking" beside DAMON. I think we can make them mutually exclusive.
> > > Once we have established that I think DAMON can steal the two page
> > > flag bits from it and can make use of them. What do you think?
> >
> > Again, yes, I think we could.  But I don't see clear advantage of it for now.
> >
> >
> 
> Hmm, I will think more about it. Somehow I feel if we want to monitor
> at the page sized region granularity then this will be really helpful.
> Anyways, it needs more brainstorming.

Ok, I will also think about it from the perspective.

> 
> BTW I am still going over the series and my humble request would be to
> wait till I have gone through the series completely and provided the
> feedback then you can send the next version after incorporating the
> feedback.

No problem, just let me know when you finished.  Appreciate your review :)


Thanks,
SeongJae Park

> 
> Shakeel
> 
