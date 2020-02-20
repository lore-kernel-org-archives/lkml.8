Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D88C11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7989924670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVbFrzns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgBTOyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:54:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30874 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728288AbgBTOyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582210482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qAEo6uU0h6TrnB+AzJl8drGs8IaXdhtJTL4N71C1gc8=;
        b=MVbFrznsF+XzBm1HUD2ewzIHDz2w2zVMlhb2iL+8pbuB75cYDNCkgdBG2afAsUZYjNUoLA
        V9AvJnPOLSsodjgOqucvx/l4azIe/FfuEk7ZibK8YoxE4cz1/x1+iF/ofPcdj6FRGr6e/k
        3nmXa/NdSCyHGsYYPnY+cmgqjNAkU44=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-0b6N7j7MOcKh96VvGimqCQ-1; Thu, 20 Feb 2020 09:54:36 -0500
X-MC-Unique: 0b6N7j7MOcKh96VvGimqCQ-1
Received: by mail-qv1-f72.google.com with SMTP id s5so2694378qvr.15
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qAEo6uU0h6TrnB+AzJl8drGs8IaXdhtJTL4N71C1gc8=;
        b=eaitS9jB8wdvwvv83N8qIKjWqPZwAEmUp+16VKUO2WlSiVC+tlrCoktajVGZLf8jgk
         XteAwW6Ah85xAN8RP3sw6UmnhH4oIw1a9N5qEke4Oxwsgc3C8VTpftvQ5zt/mj9CG+FB
         6CCzFxek9gPeRTHxVT7FFQpCsU7LUyXkYkHsJVcIX+74xu/3tpsGPu08bvV/6MWgIz/m
         MY4kuIopguDPA0WY0eF8QzaEhllBb+mY6Mp7yPtXLZrYjBMJRSOED63OOq8HDoGm/uzU
         EgDaWpTyh4gdnJX078JYzjfoqMfBUJpneSYwNHim2Lavj+3WMcRcNsExxLhn6Wow/1RR
         UNFQ==
X-Gm-Message-State: APjAAAW4/HzvlQLwxnJ2USNhYMl2VlL79tqg7oxmOVBSOegONrStAynj
        Mz/icg3H/Dpa7SErOWP/ZoKurhq+KK3PaudSxJMr9uDTcHHPhi8oquCRR0ELCdc4srqwQV3yDV1
        0PGhIWM/v02bpY7TmU6frLh4F
X-Received: by 2002:ac8:7352:: with SMTP id q18mr26316187qtp.125.1582210475695;
        Thu, 20 Feb 2020 06:54:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzWsFS82ySidjbVlfdT63ypLLaoFMuctN0YET94MVG1TOfbG3OuA7PvkPxiht5byTbrB0g3mg==
X-Received: by 2002:ac8:7352:: with SMTP id q18mr26316150qtp.125.1582210475282;
        Thu, 20 Feb 2020 06:54:35 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id v82sm1725109qka.51.2020.02.20.06.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:54:34 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Martin Cracauer <cracauer@cons.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Brian Geffon <bgeffon@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH v6 00/16] mm: Page fault enhancements
Date:   Thu, 20 Feb 2020 09:54:16 -0500
Message-Id: <20200220145432.4561-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v6 of the series.  It is majorly a rebase to 5.6-rc2, nothing
else to be expected (plus some tests after the rebase).  Instead of
rewrite the cover letter I decided to use what we have for v5.

Adding extra CCs for both Bobby Powers <bobbypowers@gmail.com> and
Brian Geffon <bgeffon@google.com>.

Any review comment is appreciated.  Thanks,

=============== v5 cover letter ==================

This is v5 of the series.  As Matthew suggested, I split the previous
patch "mm: Return faster for non-fatal signals in user mode faults"
into a few smaller ones:

  1. One patch to introduce fatal_signal_pending(), and use it in
     archs that can directly apply

  2. A few more patches to let the rest archs to use the new helper.
     With that we can have an unified entry for signal detection

  3. One last patch to change fatal_signal_pending() to detect
     userspace non-fatal signal

Nothing should have changed in the rest patches.  Because the fault
retry patches will depend on the previous ones, I decided to simply
repost all the patches.

Here's the new patchset layout:

Patch 1-2:      cleanup, and potential bugfix of hugetlbfs on fault retry

Patch 3-9:      let page fault to respond to non-fatal signals faster

Patch 10:       remove the userfaultfd NOPAGE emulation

Patch 11-14:    allow page fault to retry more than once

Patch 15-16:    let gup code to use FAULT_FLAG_KILLABLE too

I would really appreciate any review comments for the series,
especially for the first two patches which IMHO are even not related
to this patchset and they should either cleanup or fix things.

Smoke tested on x86 only.

Thanks,

v5:
- split "mm: Return faster for non-fatal signals in user mode faults"
  into a few more patches, let all archs to use an unified entry for
  fast signal handling (fatal_signal_pending)

v4:
- use lore.kernel.org for all the links in commit messages [Kirill]
- one more patch ("mm/gup: Fix __get_user_pages() on fault retry of
  hugetlb") to fix hugetlb path on fault retry
- one more patch ("mm/gup: Allow to react to fatal signals") to:
  - use down_read_killable() properly [Linus]
  - pass in FAULT_FLAG_KILLABLE for all GUP [Linus]
- one more patch ("mm/userfaultfd: Honor FAULT_FLAG_KILLABLE in fault
  path") to let handle_userfaultfd() respect FAULT_FLAG_KILLABLE.
  Should have no functional change after previous two new patches.

v3:
- check fatal signals in __get_user_page_locked() [Linus]
- add r-bs

v2:
- resent previous version, rebase only

=============== v1 cover letter ==================

This series is split out of userfaultfd-wp series to only cover the
general page fault changes, since it seems to make sense itself.

Basically it does two things:

  (a) Allows the page fault handlers to be more interactive on not
      only SIGKILL, but also the rest of userspace signals (especially
      for user-mode faults), and,

  (b) Allows the page fault retry (VM_FAULT_RETRY) to happen for more
      than once.

I'm keeping the CC list as in uffd-wp v5, hopefully I'm not sending
too much spams...

And, instead of writting again the cover letter, I'm just copy-pasting
my previous link here which has more details on why we do this:

  https://patchwork.kernel.org/cover/10691991/

The major change from that latest version should be that we introduced
a new page fault flag FAULT_FLAG_INTERRUPTIBLE as suggested by Linus
[1] to represents that we would like the fault handler to respond to
non-fatal signals.  Also, we're more careful now on when to do the
immediate return of the page fault for such signals.  For example, now
we'll only check against signal_pending() for user-mode page faults
and we keep the kernel-mode page fault patch untouched for it.  More
information can be found in separate patches.

The patchset is only lightly tested on x86.

All comments are greatly welcomed.  Thanks,

[1] https://lkml.org/lkml/2019/6/25/1382

Peter Xu (16):
  mm/gup: Rename "nonblocking" to "locked" where proper
  mm/gup: Fix __get_user_pages() on fault retry of hugetlb
  mm: Introduce fault_signal_pending()
  x86/mm: Use helper fault_signal_pending()
  arc/mm: Use helper fault_signal_pending()
  arm64/mm: Use helper fault_signal_pending()
  powerpc/mm: Use helper fault_signal_pending()
  sh/mm: Use helper fault_signal_pending()
  mm: Return faster for non-fatal signals in user mode faults
  userfaultfd: Don't retake mmap_sem to emulate NOPAGE
  mm: Introduce FAULT_FLAG_DEFAULT
  mm: Introduce FAULT_FLAG_INTERRUPTIBLE
  mm: Allow VM_FAULT_RETRY for multiple times
  mm/gup: Allow VM_FAULT_RETRY for multiple times
  mm/gup: Allow to react to fatal signals
  mm/userfaultfd: Honor FAULT_FLAG_KILLABLE in fault path

 arch/alpha/mm/fault.c           |  6 +--
 arch/arc/mm/fault.c             | 35 +++++--------
 arch/arm/mm/fault.c             |  7 +--
 arch/arm64/mm/fault.c           | 26 +++------
 arch/hexagon/mm/vm_fault.c      |  5 +-
 arch/ia64/mm/fault.c            |  5 +-
 arch/m68k/mm/fault.c            |  7 +--
 arch/microblaze/mm/fault.c      |  5 +-
 arch/mips/mm/fault.c            |  5 +-
 arch/nds32/mm/fault.c           |  5 +-
 arch/nios2/mm/fault.c           |  7 +--
 arch/openrisc/mm/fault.c        |  5 +-
 arch/parisc/mm/fault.c          |  8 ++-
 arch/powerpc/mm/fault.c         | 20 ++-----
 arch/riscv/mm/fault.c           |  9 +---
 arch/s390/mm/fault.c            | 10 ++--
 arch/sh/mm/fault.c              | 13 +++--
 arch/sparc/mm/fault_32.c        |  5 +-
 arch/sparc/mm/fault_64.c        |  5 +-
 arch/um/kernel/trap.c           |  3 +-
 arch/unicore32/mm/fault.c       |  8 ++-
 arch/x86/mm/fault.c             | 30 +++++------
 arch/xtensa/mm/fault.c          |  5 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 12 +++--
 fs/userfaultfd.c                | 62 ++++++++++------------
 include/linux/mm.h              | 81 ++++++++++++++++++++++++----
 include/linux/sched/signal.h    | 14 +++++
 mm/filemap.c                    |  2 +-
 mm/gup.c                        | 93 +++++++++++++++++++++------------
 mm/hugetlb.c                    | 17 +++---
 mm/internal.h                   |  6 +--
 31 files changed, 281 insertions(+), 240 deletions(-)

-- 
2.24.1

