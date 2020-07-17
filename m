Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEA2C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAA72076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rrb7gJLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGQGx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:53:59 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:41598 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgGQGx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594968839; x=1626504839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=UbdGYUcxs3f2PzsC5b1THW/4XAQ8PtwmIHoCMkMyeJk=;
  b=Rrb7gJLlTejWNjHhxPf0sop+CiHL4c3KGpf8J4E8uAMjZRzUxzamTAwb
   1ZuAZ5os1kKMFXUywS8kf1UPh7DHkmsRPiC8cbAXCy6QjejPmnDHiIscJ
   KxhoVwG/LV1Te0LxdbJxjM/K06TVSumU7MtNkMNGmHKv2Q3IsF87AW8K5
   Q=;
IronPort-SDR: jTvzNbc6LpWJ1wdVACIj01E7k7YcB0jnHfAPb0ZjxcDFQlY+r7xF67ZzlciV069UlBFd+uFpyb
 pV3oC7mKs+AQ==
X-IronPort-AV: E=Sophos;i="5.75,362,1589241600"; 
   d="scan'208";a="60527465"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 17 Jul 2020 06:53:51 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 7C722C1B5E;
        Fri, 17 Jul 2020 06:53:48 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Jul 2020 06:53:47 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.34) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Jul 2020 06:53:30 +0000
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
Subject: Re: Re: [PATCH v18 06/14] mm/damon: Implement callbacks for the virtual memory address spaces
Date:   Fri, 17 Jul 2020 08:53:13 +0200
Message-ID: <20200717065313.8870-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod7Cejryb6Pkh8Pktnv68MKm=OTUKbMe1Q0BjZgK1Q1RTw@mail.gmail.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D37UWA001.ant.amazon.com (10.43.160.61) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 17:46:54 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, Jul 13, 2020 at 1:44 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This commit introduces a reference implementation of the address space
> > specific low level primitives for the virtual address space, so that
> > users of DAMON can easily monitor the data accesses on virtual address
> > spaces of specific processes by simply configuring the implementation to
> > be used by DAMON.
> >
> > The low level primitives for the fundamental access monitoring are
> > defined in two parts:
> > 1. Identification of the monitoring target address range for the address
> > space.
> > 2. Access check of specific address range in the target space.
> >
> > The reference implementation for the virtual address space provided by
> > this commit is designed as below.
> >
> > PTE Accessed-bit Based Access Check
> > -----------------------------------
> >
> > The implementation uses PTE Accessed-bit for basic access checks.  That
> > is, it clears the bit for next sampling target page and checks whether
> > it set again after one sampling period.  To avoid disturbing other
> > Accessed bit users such as the reclamation logic, the implementation
> > adjusts the ``PG_Idle`` and ``PG_Young`` appropriately, as same to the
> > 'Idle Page Tracking'.
> >
> > VMA-based Target Address Range Construction
> > -------------------------------------------
> >
> > Only small parts in the super-huge virtual address space of the
> > processes are mapped to physical memory and accessed.  Thus, tracking
> > the unmapped address regions is just wasteful.  However, because DAMON
> > can deal with some level of noise using the adaptive regions adjustment
> > mechanism, tracking every mapping is not strictly required but could
> > even incur a high overhead in some cases.  That said, too huge unmapped
> > areas inside the monitoring target should be removed to not take the
> > time for the adaptive mechanism.
> >
> > For the reason, this implementation converts the complex mappings to
> > three distinct regions that cover every mapped area of the address
> > space.  Also, the two gaps between the three regions are the two biggest
> > unmapped areas in the given address space.  The two biggest unmapped
> > areas would be the gap between the heap and the uppermost mmap()-ed
> > region, and the gap between the lowermost mmap()-ed region and the stack
> > in most of the cases.  Because these gaps are exceptionally huge in
> > usual address spacees, excluding these will be sufficient to make a
> > reasonable trade-off.  Below shows this in detail::
> >
> >     <heap>
> >     <BIG UNMAPPED REGION 1>
> >     <uppermost mmap()-ed region>
> >     (small mmap()-ed regions and munmap()-ed regions)
> >     <lowermost mmap()-ed region>
> >     <BIG UNMAPPED REGION 2>
> >     <stack>
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> [snip]
> > +
> > +static void damon_mkold(struct mm_struct *mm, unsigned long addr)
> > +{
> > +       pte_t *pte = NULL;
> > +       pmd_t *pmd = NULL;
> > +       spinlock_t *ptl;
> > +
> > +       if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
> > +               return;
> > +
> > +       if (pte) {
> > +               if (pte_young(*pte)) {
> 
> Any reason for skipping mmu_notifier_clear_young()? Why exclude VMs as
> DAMON's target applications?

Obviously my mistake, thank you for pointing this!  I will add the function
call in the next spin.


Thanks,
SeongJae Park

> 
> > +                       clear_page_idle(pte_page(*pte));
> > +                       set_page_young(pte_page(*pte));
> > +               }
> > +               *pte = pte_mkold(*pte);
> > +               pte_unmap_unlock(pte, ptl);
> > +               return;
> > +       }
> > +
