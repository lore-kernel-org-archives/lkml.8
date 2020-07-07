Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E009C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F394206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEnkzz8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgGGWub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:50:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47914 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728509AbgGGWua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XG8JZ/RcRcZU8pPzQBjdYxuL7JMX3O7leErJJK2lhj0=;
        b=CEnkzz8ykGbDFUiCvedSNOb7OF1RUpyHo/f3a5ck2XLO+jLSY9QPSqaMhp+ZhTNwzZorNz
        n0pZNhqUVnNM4vN/X/RRGQ8q7HLz2DGiu5n/fF+3d7uebUkdi28HJDxUbgvZHRb29OgjGb
        /1AguLSrKkWXXSCVsf7aRwd8X1ZVPXI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-3damSYMkMjOcZPMSxVzdXQ-1; Tue, 07 Jul 2020 18:50:25 -0400
X-MC-Unique: 3damSYMkMjOcZPMSxVzdXQ-1
Received: by mail-qt1-f197.google.com with SMTP id h24so16155199qtk.18
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XG8JZ/RcRcZU8pPzQBjdYxuL7JMX3O7leErJJK2lhj0=;
        b=kT154F2k/bRIxLSXDcqbQulvUJnRZgf75BSfOsdZmE1PZXJyZEiJcyspqo6tsw8iTF
         PkilU3JLFNGjFJXVB7WRO4JzIvbAypyZR4fLyKzBPx+b3yWBIlqG5x3LhSzUcHh/EY2p
         ruof2kd5xWIx+SwjRbm1237DqYOy6N4GBVMTAJYP/sRLdWiASlOPYeqgFAKiu7mxrOD+
         uv6p63fnRPFuUyrBxOrwMe9lT9M4dLqfLj56rQK3boSmz82MJrwFCCoxG6GSMhmGR8Nj
         CC5xoOwnv2BrmLUgRVsZNP+/YE53CpAWnq4pYsSnSGQf27YmXDeV2gJDOMz+6OiLVbcM
         J7ow==
X-Gm-Message-State: AOAM533zWLGOWTaKeM94VaBZpcyt12bYdjZJWhUhf0DWs/WmCf3Amrut
        N6Ky0mT3rkeOOFIRWXZULra36DDG74CE9rnsTqyCPRv+QCcsfxZk6u7ua2bBhXmreqD0frElKNy
        pHTlNU9+W1524iJlBkd/omSmU
X-Received: by 2002:a05:620a:b1a:: with SMTP id t26mr55131580qkg.473.1594162224769;
        Tue, 07 Jul 2020 15:50:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgOu7xvthwEx0G099Jt4vnoO0GKQxi2Pl8cOAO4vYSFWN34rylzrPPHMzPoI3RRpnIY1w+pQ==
X-Received: by 2002:a05:620a:b1a:: with SMTP id t26mr55131552qkg.473.1594162224414;
        Tue, 07 Jul 2020 15:50:24 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v5 00/25] mm: Page fault accounting cleanups
Date:   Tue,  7 Jul 2020 18:49:56 -0400
Message-Id: <20200707225021.200906-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:=0D
- rebase to linux-next/akpm, add r-bs=0D
- patch 1: pass vm_fault_t into mm_account_fault() [DavidR]=0D
- patch 25: fix comment in get_user_pages() to remove the ref to task [John=
]=0D
- dropped the unicore32 patch because the arch was thrown away=0D
=0D
This is v5 of the pf accounting cleanup series.  It originates from Gerald=
=0D
Schaefer's report on an issue a week ago regarding to incorrect page fault=
=0D
accountings for retried page fault after commit 4064b9827063 ("mm: allow=0D
VM_FAULT_RETRY for multiple times"):=0D
=0D
  https://lore.kernel.org/lkml/20200610174811.44b94525@thinkpad/=0D
=0D
What this series did:=0D
=0D
  - Correct page fault accounting: we do accounting for a page fault (no ma=
tter=0D
    whether it's from #PF handling, or gup, or anything else) only with the=
 one=0D
    that completed the fault.  For example, page fault retries should not b=
e=0D
    counted in page fault counters.  Same to the perf events.=0D
=0D
  - Unify definition of PERF_COUNT_SW_PAGE_FAULTS: currently this perf even=
t is=0D
    used in an adhoc way across different archs.=0D
=0D
    Case (1): for many archs it's done at the entry of a page fault handler=
, so=0D
    that it will also cover e.g. errornous faults.=0D
=0D
    Case (2): for some other archs, it is only accounted when the page faul=
t is=0D
    resolved successfully.=0D
=0D
    Case (3): there're still quite some archs that have not enabled this pe=
rf event.=0D
=0D
    Since this series will touch merely all the archs, we unify this perf e=
vent=0D
    to always follow case (1), which is the one that makes most sense.  And=
=0D
    since we moved the accounting into handle_mm_fault, the other two MAJ/M=
IN=0D
    perf events are well taken care of naturally.=0D
=0D
  - Unify definition of "major faults": the definition of "major fault" is=
=0D
    slightly changed when used in accounting (not VM_FAULT_MAJOR).  More=0D
    information in patch 1.=0D
=0D
  - Always account the page fault onto the one that triggered the page faul=
t.=0D
    This does not matter much for #PF handlings, but mostly for gup.  More=
=0D
    information on this in patch 25.=0D
=0D
Patchset layout:=0D
=0D
Patch 1:     Introduced the accounting in handle_mm_fault(), not enabled.=0D
Patch 2-23:  Enable the new accounting for arch #PF handlers one by one.=0D
Patch 24:    Enable the new accounting for the rest outliers (gup, iommu, e=
tc.)=0D
Patch 25:    Cleanup GUP task_struct pointer since it's not needed any more=
=0D
=0D
For each of the patch that fixes a specific arch, I'm CCing the maintainers=
 and=0D
the arch list if there is.  Besides, I only lightly tested this series on x=
86.=0D
=0D
Please have a look, thanks.=0D
=0D
Peter Xu (25):=0D
  mm: Do page fault accounting in handle_mm_fault=0D
  mm/alpha: Use general page fault accounting=0D
  mm/arc: Use general page fault accounting=0D
  mm/arm: Use general page fault accounting=0D
  mm/arm64: Use general page fault accounting=0D
  mm/csky: Use general page fault accounting=0D
  mm/hexagon: Use general page fault accounting=0D
  mm/ia64: Use general page fault accounting=0D
  mm/m68k: Use general page fault accounting=0D
  mm/microblaze: Use general page fault accounting=0D
  mm/mips: Use general page fault accounting=0D
  mm/nds32: Use general page fault accounting=0D
  mm/nios2: Use general page fault accounting=0D
  mm/openrisc: Use general page fault accounting=0D
  mm/parisc: Use general page fault accounting=0D
  mm/powerpc: Use general page fault accounting=0D
  mm/riscv: Use general page fault accounting=0D
  mm/s390: Use general page fault accounting=0D
  mm/sh: Use general page fault accounting=0D
  mm/sparc32: Use general page fault accounting=0D
  mm/sparc64: Use general page fault accounting=0D
  mm/x86: Use general page fault accounting=0D
  mm/xtensa: Use general page fault accounting=0D
  mm: Clean up the last pieces of page fault accountings=0D
  mm/gup: Remove task_struct pointer for all gup code=0D
=0D
 arch/alpha/mm/fault.c                       |   8 +-=0D
 arch/arc/kernel/process.c                   |   2 +-=0D
 arch/arc/mm/fault.c                         |  18 +--=0D
 arch/arm/mm/fault.c                         |  25 +----=0D
 arch/arm64/mm/fault.c                       |  29 +----=0D
 arch/csky/mm/fault.c                        |  13 +--=0D
 arch/hexagon/mm/vm_fault.c                  |   9 +-=0D
 arch/ia64/mm/fault.c                        |   9 +-=0D
 arch/m68k/mm/fault.c                        |  14 +--=0D
 arch/microblaze/mm/fault.c                  |   9 +-=0D
 arch/mips/mm/fault.c                        |  14 +--=0D
 arch/nds32/mm/fault.c                       |  19 +---=0D
 arch/nios2/mm/fault.c                       |  14 +--=0D
 arch/openrisc/mm/fault.c                    |   9 +-=0D
 arch/parisc/mm/fault.c                      |   8 +-=0D
 arch/powerpc/mm/copro_fault.c               |   7 +-=0D
 arch/powerpc/mm/fault.c                     |  11 +-=0D
 arch/riscv/mm/fault.c                       |  16 +--=0D
 arch/s390/kvm/interrupt.c                   |   2 +-=0D
 arch/s390/kvm/kvm-s390.c                    |   2 +-=0D
 arch/s390/kvm/priv.c                        |   8 +-=0D
 arch/s390/mm/fault.c                        |  16 +--=0D
 arch/s390/mm/gmap.c                         |   4 +-=0D
 arch/sh/mm/fault.c                          |  11 +-=0D
 arch/sparc/mm/fault_32.c                    |  13 +--=0D
 arch/sparc/mm/fault_64.c                    |  11 +-=0D
 arch/um/kernel/trap.c                       |   6 +-=0D
 arch/x86/mm/fault.c                         |  17 +--=0D
 arch/xtensa/mm/fault.c                      |  15 +--=0D
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c |   2 +-=0D
 drivers/infiniband/core/umem_odp.c          |   2 +-=0D
 drivers/iommu/amd/iommu_v2.c                |   2 +-=0D
 drivers/iommu/intel/svm.c                   |   3 +-=0D
 drivers/vfio/vfio_iommu_type1.c             |   4 +-=0D
 fs/exec.c                                   |   2 +-=0D
 include/linux/mm.h                          |  16 +--=0D
 kernel/events/uprobes.c                     |   6 +-=0D
 kernel/futex.c                              |   2 +-=0D
 mm/gup.c                                    | 118 ++++++++------------=0D
 mm/hmm.c                                    |   3 +-=0D
 mm/ksm.c                                    |   3 +-=0D
 mm/memory.c                                 |  69 +++++++++++-=0D
 mm/process_vm_access.c                      |   2 +-=0D
 security/tomoyo/domain.c                    |   2 +-=0D
 virt/kvm/async_pf.c                         |   2 +-=0D
 virt/kvm/kvm_main.c                         |   2 +-=0D
 46 files changed, 219 insertions(+), 360 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

