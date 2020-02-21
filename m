Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC14C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14D4206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icakTwtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgBUT0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:26:43 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35783 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgBUT0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:26:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id c7so3736343edu.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xr60A1dzj1G3mLhY1jqSdwMVifVQF6aHlkkVpy0bbho=;
        b=icakTwtYl5pI7U6NFJp2r+HgbtShFbRiXPZBLmgMOx0GSuOC44mvFu8ThHgk9SSMUn
         4r5hs3AmplvrrDiQDtcZ5xX/qpDgb3/w1hcjG0sz3pZTDdQdVJA+ZV7ikcpX1vXiSl+b
         mUwQM9V88QfLiiv6ZPLxIoc3GDflxNT+mLd/QuQCZ9guGmM1vhTnoJW0LCG2u0cBBQAX
         l3uskjE5qyzoRgB1igCARjVzD1XUc23M/6gnHHB8sia6F6UBeZZm2OefqBR4zXb8lwkj
         oMwJuXGIcazxggPh+edkpIC+1qqPBxqaTfncaQonKQrVAdUjJKxUZfSp1bf0z/71AEhY
         XUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xr60A1dzj1G3mLhY1jqSdwMVifVQF6aHlkkVpy0bbho=;
        b=CMAKgL9lAKRStdc8gxYFN5Dpuj+HBcFy/7ONef3vsTxe4UIoDcyj2Z6F0NPyozJGBr
         SArgpQx43q1l8S16P7FHvfVHdituodWh+hiLGOg5qo9mOD4cg31VPlsbjGDZKSvUiIbX
         87C4D9HtPsM8WdQ88jqPTUTtnqcLjvBmuKVkigY7IjtakMlrvQjUMuNvPlBVGnyELHYv
         lkNRzZHKA8yC0hA8TBSVRqXiSASO6dvPuU+bZd1X5k95z55oeVeZp5fwUKUu8lv4OZnb
         7kM16VTT1Y08z7ZAZwJpgAJwB3LMMejmAa+D6cAOb6QlVCmLegplVJSJAAw770tNEe1W
         CRrA==
X-Gm-Message-State: APjAAAWlULhay62TrOmCMbSb3BCMYn8tC+dnsxjXZbyebkUhEZd0GLfn
        xn+z70XCsdSG8fyGIjkSaabVrLz7RhDNjjt39H8fHw==
X-Google-Smtp-Source: APXvYqy8vEdFmgXmuuacz26gihQ4SanMmW0EWiVxOCriNW08x3bQoHTba7lbgrwfZrbUhbDKzHSlvT1ampqGnakzHus=
X-Received: by 2002:a17:906:6888:: with SMTP id n8mr7946052ejr.171.1582313198670;
 Fri, 21 Feb 2020 11:26:38 -0800 (PST)
MIME-Version: 1.0
References: <20200220155353.8676-1-peterx@redhat.com>
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Fri, 21 Feb 2020 11:26:12 -0800
Message-ID: <CADyq12wFKwzUYipU4g4Ey9X9J3qY0S=PEhSMBAeLfzpETUWVWQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 00/16] mm: Page fault enhancements
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Martin Cracauer <cracauer@cons.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>, Hugh Dickins <hughd@google.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tested the entire patchset because I'm very interested in fault
retries with userfaultfd and the series has been stable and worked
well on x86.

Tested-by: Brian Geffon <bgeffon@google.com>


On Thu, Feb 20, 2020 at 7:54 AM Peter Xu <peterx@redhat.com> wrote:
>
> [Resend v6]
>
> This is v6 of the series.  It is majorly a rebase to 5.6-rc2, nothing
> else to be expected (plus some tests after the rebase).  Instead of
> rewrite the cover letter I decided to use what we have for v5.
>
> Adding extra CCs for both Bobby Powers <bobbypowers@gmail.com> and
> Brian Geffon <bgeffon@google.com>.
>
> Online repo: https://github.com/xzpeter/linux/tree/mm-pf-signal-retry
>
> Any review comment is appreciated.  Thanks,
>
> =============== v5 cover letter ==================
>
> This is v5 of the series.  As Matthew suggested, I split the previous
> patch "mm: Return faster for non-fatal signals in user mode faults"
> into a few smaller ones:
>
>   1. One patch to introduce fatal_signal_pending(), and use it in
>      archs that can directly apply
>
>   2. A few more patches to let the rest archs to use the new helper.
>      With that we can have an unified entry for signal detection
>
>   3. One last patch to change fatal_signal_pending() to detect
>      userspace non-fatal signal
>
> Nothing should have changed in the rest patches.  Because the fault
> retry patches will depend on the previous ones, I decided to simply
> repost all the patches.
>
> Here's the new patchset layout:
>
> Patch 1-2:      cleanup, and potential bugfix of hugetlbfs on fault retry
>
> Patch 3-9:      let page fault to respond to non-fatal signals faster
>
> Patch 10:       remove the userfaultfd NOPAGE emulation
>
> Patch 11-14:    allow page fault to retry more than once
>
> Patch 15-16:    let gup code to use FAULT_FLAG_KILLABLE too
>
> I would really appreciate any review comments for the series,
> especially for the first two patches which IMHO are even not related
> to this patchset and they should either cleanup or fix things.
>
> Smoke tested on x86 only.
>
> Thanks,
>
> v5:
> - split "mm: Return faster for non-fatal signals in user mode faults"
>   into a few more patches, let all archs to use an unified entry for
>   fast signal handling (fatal_signal_pending)
>
> v4:
> - use lore.kernel.org for all the links in commit messages [Kirill]
> - one more patch ("mm/gup: Fix __get_user_pages() on fault retry of
>   hugetlb") to fix hugetlb path on fault retry
> - one more patch ("mm/gup: Allow to react to fatal signals") to:
>   - use down_read_killable() properly [Linus]
>   - pass in FAULT_FLAG_KILLABLE for all GUP [Linus]
> - one more patch ("mm/userfaultfd: Honor FAULT_FLAG_KILLABLE in fault
>   path") to let handle_userfaultfd() respect FAULT_FLAG_KILLABLE.
>   Should have no functional change after previous two new patches.
>
> v3:
> - check fatal signals in __get_user_page_locked() [Linus]
> - add r-bs
>
> v2:
> - resent previous version, rebase only
>
> =============== v1 cover letter ==================
>
> This series is split out of userfaultfd-wp series to only cover the
> general page fault changes, since it seems to make sense itself.
>
> Basically it does two things:
>
>   (a) Allows the page fault handlers to be more interactive on not
>       only SIGKILL, but also the rest of userspace signals (especially
>       for user-mode faults), and,
>
>   (b) Allows the page fault retry (VM_FAULT_RETRY) to happen for more
>       than once.
>
> I'm keeping the CC list as in uffd-wp v5, hopefully I'm not sending
> too much spams...
>
> And, instead of writting again the cover letter, I'm just copy-pasting
> my previous link here which has more details on why we do this:
>
>   https://patchwork.kernel.org/cover/10691991/
>
> The major change from that latest version should be that we introduced
> a new page fault flag FAULT_FLAG_INTERRUPTIBLE as suggested by Linus
> [1] to represents that we would like the fault handler to respond to
> non-fatal signals.  Also, we're more careful now on when to do the
> immediate return of the page fault for such signals.  For example, now
> we'll only check against signal_pending() for user-mode page faults
> and we keep the kernel-mode page fault patch untouched for it.  More
> information can be found in separate patches.
>
> The patchset is only lightly tested on x86.
>
> All comments are greatly welcomed.  Thanks,
>
> [1] https://lkml.org/lkml/2019/6/25/1382
>
> Peter Xu (16):
>   mm/gup: Rename "nonblocking" to "locked" where proper
>   mm/gup: Fix __get_user_pages() on fault retry of hugetlb
>   mm: Introduce fault_signal_pending()
>   x86/mm: Use helper fault_signal_pending()
>   arc/mm: Use helper fault_signal_pending()
>   arm64/mm: Use helper fault_signal_pending()
>   powerpc/mm: Use helper fault_signal_pending()
>   sh/mm: Use helper fault_signal_pending()
>   mm: Return faster for non-fatal signals in user mode faults
>   userfaultfd: Don't retake mmap_sem to emulate NOPAGE
>   mm: Introduce FAULT_FLAG_DEFAULT
>   mm: Introduce FAULT_FLAG_INTERRUPTIBLE
>   mm: Allow VM_FAULT_RETRY for multiple times
>   mm/gup: Allow VM_FAULT_RETRY for multiple times
>   mm/gup: Allow to react to fatal signals
>   mm/userfaultfd: Honor FAULT_FLAG_KILLABLE in fault path
>
>  arch/alpha/mm/fault.c           |  6 +--
>  arch/arc/mm/fault.c             | 35 +++++--------
>  arch/arm/mm/fault.c             |  7 +--
>  arch/arm64/mm/fault.c           | 26 +++------
>  arch/hexagon/mm/vm_fault.c      |  5 +-
>  arch/ia64/mm/fault.c            |  5 +-
>  arch/m68k/mm/fault.c            |  7 +--
>  arch/microblaze/mm/fault.c      |  5 +-
>  arch/mips/mm/fault.c            |  5 +-
>  arch/nds32/mm/fault.c           |  5 +-
>  arch/nios2/mm/fault.c           |  7 +--
>  arch/openrisc/mm/fault.c        |  5 +-
>  arch/parisc/mm/fault.c          |  8 ++-
>  arch/powerpc/mm/fault.c         | 20 ++-----
>  arch/riscv/mm/fault.c           |  9 +---
>  arch/s390/mm/fault.c            | 10 ++--
>  arch/sh/mm/fault.c              | 13 +++--
>  arch/sparc/mm/fault_32.c        |  5 +-
>  arch/sparc/mm/fault_64.c        |  5 +-
>  arch/um/kernel/trap.c           |  3 +-
>  arch/unicore32/mm/fault.c       |  8 ++-
>  arch/x86/mm/fault.c             | 30 +++++------
>  arch/xtensa/mm/fault.c          |  5 +-
>  drivers/gpu/drm/ttm/ttm_bo_vm.c | 12 +++--
>  fs/userfaultfd.c                | 62 ++++++++++------------
>  include/linux/mm.h              | 81 ++++++++++++++++++++++++----
>  include/linux/sched/signal.h    | 14 +++++
>  mm/filemap.c                    |  2 +-
>  mm/gup.c                        | 93 +++++++++++++++++++++------------
>  mm/hugetlb.c                    | 17 +++---
>  mm/internal.h                   |  6 +--
>  31 files changed, 281 insertions(+), 240 deletions(-)
>
> --
> 2.24.1
>
