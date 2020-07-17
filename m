Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68185C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42EEB206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/eJBI5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgGQPR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgGQPRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:17:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA92C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 08:17:22 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j11so13095438ljo.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 08:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CW/vI/yK0P533Yuk2TOJkvWJ7zd6tq/CXrAzQkJnwgU=;
        b=S/eJBI5TgyhFWJJh3yQWPlfplbzkZuAg1XzXAHFByNeqxg/CJ5L/ZzmjcuOrfTRUUd
         diZEWbViW1Y0y6E36f1HGrp1ho+e72mTaoY03zoTgs8RwGYTmkcKvsKFcIt3i8rwJmON
         VbwV5N21QVoSKSH0a43Qi2GT9TNZGQFBAVThlfi9UBMrDBCqrG+P9TCkKnAHqeAbT4JY
         eRByNOJMtJ+5KJhSJtnOEkARRIICKaS0SKZqTUhnCrci7x/CbmYuj2SqAfIWiNJwrMVs
         Bg1XBa0f+bdKGBbZlEaJpF6Byt/XgvP04M5a/5LoWGeUDFY4ECBonI8/ZEX+ug/E2cQF
         YoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CW/vI/yK0P533Yuk2TOJkvWJ7zd6tq/CXrAzQkJnwgU=;
        b=RrLT10tuK7Mve57X3uf/IgLAC4+BIHe6+R4Yim9cq/OY41Ay8BbfvkG67wxUQeRoqt
         d2WG6CCeIopukGNdV9/ZyiISXpBe+qMAxl4DU4tEh/OC/egQRu3VAXxBEBB49F9dISbW
         D8TOq6OyxWO+pLHOqW7Gf7b3W+1Pb8DxFk1uScYeJ5GzzUbpjanqJoeSaUWDLhuppBMX
         15UmvLL1PrH5jho2dAWDWP5hcL+GU9tHd1uuk1amJH8UZxcTkkq8LuANvpTYU2dw6UaQ
         +HnATLx9drl5hUThB/hkbEz8ejyjtqGzfIK5YGdAy52HtCBtY7PrjCM0OGBE3Kcp6aMI
         RyNQ==
X-Gm-Message-State: AOAM530WxGE3tYOVMpNtSKuTd+4l/CSnjoiHCJVHNJhTwIhQm7Oa0fTR
        0FjH8gXpC37JQjhM3doAPSV++CjIr76161xMQI8okg==
X-Google-Smtp-Source: ABdhPJziey5oyrYePa+FU89+ldeQlFYPtdYe9O73g9psmVD/tqlhxa9TsiwuPeqqXUxiU5kaiC0zpHA28q+8vcapv5Q=
X-Received: by 2002:a2e:978c:: with SMTP id y12mr4714541lji.270.1594999040547;
 Fri, 17 Jul 2020 08:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7Cejryb6Pkh8Pktnv68MKm=OTUKbMe1Q0BjZgK1Q1RTw@mail.gmail.com>
 <20200717065313.8870-1-sjpark@amazon.com>
In-Reply-To: <20200717065313.8870-1-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 Jul 2020 08:17:09 -0700
Message-ID: <CALvZod6+kTri_Z2xeo=mVi8tvQfa6L7NSXqh_kfSxvPCd6uDVQ@mail.gmail.com>
Subject: Re: Re: [PATCH v18 06/14] mm/damon: Implement callbacks for the
 virtual memory address spaces
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        foersleo@amazon.de, Ian Rogers <irogers@google.com>,
        jolsa@redhat.com, "Kirill A. Shutemov" <kirill@shutemov.name>,
        mark.rutland@arm.com, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, rppt@kernel.org,
        sblbir@amazon.com, shuah@kernel.org, sj38.park@gmail.com,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:54 PM SeongJae Park <sjpark@amazon.com> wrote:
>
> On Thu, 16 Jul 2020 17:46:54 -0700 Shakeel Butt <shakeelb@google.com> wrote:
>
> > On Mon, Jul 13, 2020 at 1:44 AM SeongJae Park <sjpark@amazon.com> wrote:
> > >
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > This commit introduces a reference implementation of the address space
> > > specific low level primitives for the virtual address space, so that
> > > users of DAMON can easily monitor the data accesses on virtual address
> > > spaces of specific processes by simply configuring the implementation to
> > > be used by DAMON.
> > >
> > > The low level primitives for the fundamental access monitoring are
> > > defined in two parts:
> > > 1. Identification of the monitoring target address range for the address
> > > space.
> > > 2. Access check of specific address range in the target space.
> > >
> > > The reference implementation for the virtual address space provided by
> > > this commit is designed as below.
> > >
> > > PTE Accessed-bit Based Access Check
> > > -----------------------------------
> > >
> > > The implementation uses PTE Accessed-bit for basic access checks.  That
> > > is, it clears the bit for next sampling target page and checks whether
> > > it set again after one sampling period.  To avoid disturbing other
> > > Accessed bit users such as the reclamation logic, the implementation
> > > adjusts the ``PG_Idle`` and ``PG_Young`` appropriately, as same to the
> > > 'Idle Page Tracking'.
> > >
> > > VMA-based Target Address Range Construction
> > > -------------------------------------------
> > >
> > > Only small parts in the super-huge virtual address space of the
> > > processes are mapped to physical memory and accessed.  Thus, tracking
> > > the unmapped address regions is just wasteful.  However, because DAMON
> > > can deal with some level of noise using the adaptive regions adjustment
> > > mechanism, tracking every mapping is not strictly required but could
> > > even incur a high overhead in some cases.  That said, too huge unmapped
> > > areas inside the monitoring target should be removed to not take the
> > > time for the adaptive mechanism.
> > >
> > > For the reason, this implementation converts the complex mappings to
> > > three distinct regions that cover every mapped area of the address
> > > space.  Also, the two gaps between the three regions are the two biggest
> > > unmapped areas in the given address space.  The two biggest unmapped
> > > areas would be the gap between the heap and the uppermost mmap()-ed
> > > region, and the gap between the lowermost mmap()-ed region and the stack
> > > in most of the cases.  Because these gaps are exceptionally huge in
> > > usual address spacees, excluding these will be sufficient to make a
> > > reasonable trade-off.  Below shows this in detail::
> > >
> > >     <heap>
> > >     <BIG UNMAPPED REGION 1>
> > >     <uppermost mmap()-ed region>
> > >     (small mmap()-ed regions and munmap()-ed regions)
> > >     <lowermost mmap()-ed region>
> > >     <BIG UNMAPPED REGION 2>
> > >     <stack>
> > >
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > [snip]
> > > +
> > > +static void damon_mkold(struct mm_struct *mm, unsigned long addr)
> > > +{
> > > +       pte_t *pte = NULL;
> > > +       pmd_t *pmd = NULL;
> > > +       spinlock_t *ptl;
> > > +
> > > +       if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
> > > +               return;
> > > +
> > > +       if (pte) {
> > > +               if (pte_young(*pte)) {
> >
> > Any reason for skipping mmu_notifier_clear_young()? Why exclude VMs as
> > DAMON's target applications?
>
> Obviously my mistake, thank you for pointing this!  I will add the function
> call in the next spin.
>

Similarly mmu_notifier_test_young() for the damon_young(). BTW I think
we can combine ctx->prepare_access_checks() and ctx->check_accesses()
into one i.e. get the young state for the previous cycle and mkold for
the next cycle in a single step.

I am wondering if there is any advantage to having "Page Idle
Tracking" beside DAMON. I think we can make them mutually exclusive.
Once we have established that I think DAMON can steal the two page
flag bits from it and can make use of them. What do you think?
