Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB08C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B65020C09
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K14+9/Sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgFZWbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:31:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53161 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725866AbgFZWbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6x/m22vLH3eEyRQboy/3NjalJn5cZPkkagnVGM9ijxA=;
        b=K14+9/SkiW1qEyaZC94BbaHF50CR1HgB1USVITKZbXBQkjpf0PiwFAHXEGb07sD3/fcCuC
        S0rZvs3n6rvfI2lFnWxbIr9gmV9hD+EohsvhVIPFY+Hwd6s7BJ32/Y0OsUTUDo2u+HivuD
        P7KyG5iZeRGCLNO0hnCnL5WGZvKaWPo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-3hGYmpcxOH-ZTEyzvDgSow-1; Fri, 26 Jun 2020 18:31:33 -0400
X-MC-Unique: 3hGYmpcxOH-ZTEyzvDgSow-1
Received: by mail-qk1-f200.google.com with SMTP id j16so7661564qka.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6x/m22vLH3eEyRQboy/3NjalJn5cZPkkagnVGM9ijxA=;
        b=cDYCJRO+YKcHt7PHYF6U+ew4tR2M5Kuvay9EOKGVPskx8RgNBpYNvWvHTlzJu5Rhm+
         MWV5ktUYzW+YFNi5uEfKpKu0EKc5oQBSdWuL4A2xoZZ2DGOTLYdmz5vBSvVdwz6TMduq
         8Ho8396VhFvPP+OXIs2/cHRM0Y2M8TrcqMAHjkldd7G75gC/tFkt+CwYXgq+7TFG9xAA
         puDgoGzlioqsN/ORLxLmcQxcdOC09EYKepH2DaewUxHUKyE1/Ogq/2uAnoe1ky87Ye4G
         6mvy0ncI1KiLBzrDYGzMuX56I1TVvexNEXb7xqOZdW0SKVKNzFVy9vLiR2GTr8RPWQST
         vmYA==
X-Gm-Message-State: AOAM5336sK3Hh619jZ5xY9e/6XIVS9IiPLrNbsXHxesgxKHoJLWTWFfm
        MOhBdWX0D8jihAVUYmpoXCeqyQjLxZNQr4Pcut9h2thoZvIX9EpPtvRFSB2cD7binKiNAvkZnwq
        wt3DLdHyMF7CdT1RRGESW7Za3
X-Received: by 2002:ac8:4d5d:: with SMTP id x29mr5223532qtv.358.1593210692633;
        Fri, 26 Jun 2020 15:31:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwroaD/HeLQ0iKgIfzQJszueUyajUkqJINM3Lp4dWWUtrmn1Cn0mhNqXhxIjin9TlGVWdKEEA==
X-Received: by 2002:ac8:4d5d:: with SMTP id x29mr5223507qtv.358.1593210692342;
        Fri, 26 Jun 2020 15:31:32 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:31 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 00/26] mm: Page fault accounting cleanups
Date:   Fri, 26 Jun 2020 18:31:04 -0400
Message-Id: <20200626223130.199227-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- comment fixes [Gerald]
- check VM_FAULT_ERROR too [Gerald]
- collect r-b

==================== cover letter for v2 =============================

This is v2 of the pf accounting cleanup series.  It originates from Gerald
Schaefer's report on an issue a week ago regarding to incorrect page fault
accountings for retried page fault after commit 4064b9827063 ("mm: allow
VM_FAULT_RETRY for multiple times"):

  https://lore.kernel.org/lkml/20200610174811.44b94525@thinkpad/

This version used a better approach suggested by Linus so that we do accounting
directly in handle_mm_fault().  Moreover, we'll cover some special accounting
too like gup or IOMMU fault requests on process page tables.  The outcome of
this series is to keep all the pf accountings in handle_mm_fault() (besides
PERF_COUNT_SW_PAGE_FAULTS, which is still done in per-arch #pf handlers).

Since v2 changed quite a lot from v1, changelog is omitted, and I also didn't
have a chance to pick up any r-b in previous version.  I really appreciate
anyone who has looked at v1.  V1 for reference:

  https://lore.kernel.org/lkml/20200615221607.7764-1-peterx@redhat.com/

What this series did:

  - Correct page fault accounting: we do accounting for a page fault (no matter
    whether it's from #PF handling, or gup, or anything else) only with the one
    that completed the fault.  For example, page fault retries should not be
    counted in page fault counters.  Same to the perf events.

  - Unify definition of PERF_COUNT_SW_PAGE_FAULTS: currently this perf event is
    used in an adhoc way across different archs.

    Case (1): for many archs it's done at the entry of a page fault handler, so
    that it will also cover e.g. errornous faults.

    Case (2): for some other archs, it is only accounted when the page fault is
    resolved successfully.

    Case (3): there're still quite some archs that have not enabled this perf event.

    Since this series will touch merely all the archs, we unify this perf event
    to always follow case (1), which is the one that makes most sense.  And
    since we moved the accounting into handle_mm_fault, the other two MAJ/MIN
    perf events are well taken care of naturally.

  - Unify definition of "major faults": the definition of "major fault" is
    slightly changed when used in accounting (not VM_FAULT_MAJOR).  More
    information in patch 1.

  - Always account the page fault onto the one that triggered the page fault.
    This does not matter much for #PF handlings, but mostly for gup.  More
    information on this in patch 25.

Patchset layout:

Patch 1:     Introduced the accounting in handle_mm_fault(), not enabled.
Patch 2-24:  Enable the new accounting for arch #PF handlers one by one.
Patch 25:    Enable the new accounting for the rest outliers (gup, iommu, etc.)
Patch 26:    Cleanup GUP task_struct pointer since it's not needed any more

For each of the patch that fixes a specific arch, I'm CCing the maintainers and
the arch list if there is.  Besides, I only lightly tested this series on x86.

Please have a look, thanks.

Peter Xu (26):
  mm: Do page fault accounting in handle_mm_fault
  mm/alpha: Use general page fault accounting
  mm/arc: Use general page fault accounting
  mm/arm: Use general page fault accounting
  mm/arm64: Use general page fault accounting
  mm/csky: Use general page fault accounting
  mm/hexagon: Use general page fault accounting
  mm/ia64: Use general page fault accounting
  mm/m68k: Use general page fault accounting
  mm/microblaze: Use general page fault accounting
  mm/mips: Use general page fault accounting
  mm/nds32: Use general page fault accounting
  mm/nios2: Use general page fault accounting
  mm/openrisc: Use general page fault accounting
  mm/parisc: Use general page fault accounting
  mm/powerpc: Use general page fault accounting
  mm/riscv: Use general page fault accounting
  mm/s390: Use general page fault accounting
  mm/sh: Use general page fault accounting
  mm/sparc32: Use general page fault accounting
  mm/sparc64: Use general page fault accounting
  mm/unicore32: Use general page fault accounting
  mm/x86: Use general page fault accounting
  mm/xtensa: Use general page fault accounting
  mm: Clean up the last pieces of page fault accountings
  mm/gup: Remove task_struct pointer for all gup code

 arch/alpha/mm/fault.c                       |   8 +-
 arch/arc/kernel/process.c                   |   2 +-
 arch/arc/mm/fault.c                         |  18 +---
 arch/arm/mm/fault.c                         |  25 ++---
 arch/arm64/mm/fault.c                       |  29 ++----
 arch/csky/mm/fault.c                        |  13 +--
 arch/hexagon/mm/vm_fault.c                  |   9 +-
 arch/ia64/mm/fault.c                        |   9 +-
 arch/m68k/mm/fault.c                        |  14 +--
 arch/microblaze/mm/fault.c                  |   9 +-
 arch/mips/mm/fault.c                        |  14 +--
 arch/nds32/mm/fault.c                       |  19 +---
 arch/nios2/mm/fault.c                       |  14 +--
 arch/openrisc/mm/fault.c                    |   9 +-
 arch/parisc/mm/fault.c                      |   8 +-
 arch/powerpc/mm/copro_fault.c               |   7 +-
 arch/powerpc/mm/fault.c                     |  11 +-
 arch/riscv/mm/fault.c                       |  16 +--
 arch/s390/kvm/interrupt.c                   |   2 +-
 arch/s390/kvm/kvm-s390.c                    |   2 +-
 arch/s390/kvm/priv.c                        |   8 +-
 arch/s390/mm/fault.c                        |  16 +--
 arch/s390/mm/gmap.c                         |   4 +-
 arch/sh/mm/fault.c                          |  11 +-
 arch/sparc/mm/fault_32.c                    |  13 +--
 arch/sparc/mm/fault_64.c                    |  11 +-
 arch/um/kernel/trap.c                       |   6 +-
 arch/unicore32/mm/fault.c                   |  14 +--
 arch/x86/mm/fault.c                         |  17 +---
 arch/xtensa/mm/fault.c                      |  15 +--
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c |   2 +-
 drivers/infiniband/core/umem_odp.c          |   2 +-
 drivers/iommu/amd_iommu_v2.c                |   2 +-
 drivers/iommu/intel-svm.c                   |   2 +-
 drivers/vfio/vfio_iommu_type1.c             |   2 +-
 fs/exec.c                                   |   2 +-
 include/linux/mm.h                          |  16 +--
 kernel/events/uprobes.c                     |   6 +-
 kernel/futex.c                              |   2 +-
 mm/gup.c                                    | 107 +++++++-------------
 mm/hmm.c                                    |   3 +-
 mm/ksm.c                                    |   3 +-
 mm/memory.c                                 |  69 ++++++++++++-
 mm/process_vm_access.c                      |   2 +-
 security/tomoyo/domain.c                    |   2 +-
 virt/kvm/async_pf.c                         |   2 +-
 virt/kvm/kvm_main.c                         |   2 +-
 47 files changed, 219 insertions(+), 360 deletions(-)

-- 
2.26.2

