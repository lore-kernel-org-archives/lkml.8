Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA5DC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DA12074D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKHaSkom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgC0CLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:11:03 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:38225 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgC0CLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:11:03 -0400
Received: by mail-pl1-f201.google.com with SMTP id r16so5942535pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 19:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iqSHG7ypiyFebpPr56P/zbjIPo9yONnqAWaL/Z9YRSU=;
        b=NKHaSkomqhoj3iexa44cq0v0BVAN18TpmyOXT9jEUHVAPLRZCcsn5MJU91WZJbeYWh
         t+LcJQ5gSyqGBm6T8fCyJfy4F8XceeJQcPourcL4gbpTzTAKVDhHB4JvJ9H0zouT5Eab
         WOnWrSPjpYpVANqmK44Pj8U1MM1m1LLvHfo+ECp6vRLDshRqsXiwyc+ILJl453oQAAU8
         TV8nT+d5xp3jRNxSmDepS0enqdAUUltylJ6wFtOiok7OygZSX+I5lWY0TEBXFFmrYsBU
         1BpqIIm9KXw9Bm5qss5Ncv3Fi/tbW2fgaYY8Ycpz5YIrKHCDmxdgtyL1YC+D34LSErxS
         r7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iqSHG7ypiyFebpPr56P/zbjIPo9yONnqAWaL/Z9YRSU=;
        b=F12kGZYbLHvW3DTJ33TLyeonfU2TfYqk/IEauV9z2uru7dcCYKDD0LRlB277IBgcrw
         FsGtEmqq8yOGiPywSGwFLwLuF+7wYyYhhkfgR3/GMxnWepQ6/mXusEnK4zQbgJyL7+PT
         O/wMVJaI7P9b5jI5sfHq9YpphGn3xb9wpArFtCY4xdIyFLcjNLFqc+wSCuOndaQ5OA86
         z0HupdkpMM0kCs2b2e5SJtc8QRcDdYp/Gku9FKfjuJsEJ8h2Jo2bXPo4fMFZexIkcbrN
         VNBqWACAJy8Ce4zhirmaMyxrfNsGFO5UdMb7kyPAX5AE4alqegMvgx0rh4imc/D6RGir
         lbuQ==
X-Gm-Message-State: ANhLgQ2k/uB4HfAysGnUYG3L5DrIGmsV2U894Lix6Thf6olaiBc1GpWb
        v85nNPQaUeNX+OFivWjt+HFWkhvgjK4=
X-Google-Smtp-Source: ADFU+vt0nkaVn+d1FBDuS8wKMYJZ++A3SLRWXClFhdEk087hXSZ1t1/jggCXu8c9W+hRo9Fn7I5tI50mmhM=
X-Received: by 2002:a17:90a:dd42:: with SMTP id u2mr3283254pjv.10.1585275060979;
 Thu, 26 Mar 2020 19:11:00 -0700 (PDT)
Date:   Thu, 26 Mar 2020 19:10:48 -0700
Message-Id: <20200327021058.221911-1-walken@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 00/10] Add a new mmap locking API wrapping mmap_sem calls
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Markus Elfring <Markus.Elfring@web.de>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a new mmap locking API replacing the existing
mmap_sem lock and unlocks. Initially the API is just implemente in terms
of inlined rwsem calls, so it doesn't provide any new functionality.

There are two justifications for the new API:

- At first, it provides an easy hooking point to instrument mmap_sem
  locking latencies independently of any other rwsems.

- In the future, it may be a starting point for replacing the rwsem
  implementation with a different one, such as range locks. This is
  something that is being explored, even though there is no wide concensus
  about this possible direction yet.
  (see https://patchwork.kernel.org/cover/11401483/)

Changes since v1 of the patchset:

- Manually convert drivers/dma-buf/dma-resv.c ahead of the automated
  coccinelle conversion as this file requires a new include statement.
  Thanks to Intel's kbuild test bot for finding the issue.

- In coccinelle automated conversion, apply a single coccinelle rule
  as suggested by Markus Elfring.

- In manual conversion of sites missed by coccinelle, fix an issue where
  I had used mm_read_unlock (from an older version of my patchset) instead
  of mmap_read_unlock in some arch/mips code.
  This was also identified by Intel's kbuild test bot.

- Do not add a new mmap_is_locked API, and use lockdep_assert_held instead.
  Thanks to Matthew Wilcox for the suggestion.

The changes apply on top of v5.6-rc7.

I think it would be feasible to push these changes towards mainline if
given sufficient approval. The coccinelle part of the change is
relatively invasive, but can be skipped over on a file by file basis
if it causes any conflicts with other pending changes. The new mmap
locking API can interoperate with new code that is still using direct
rwsem calls, until the last patch in the series which renames mmap_sem
to enforce using the new API. Maybe that last patch could be delayed for
a bit, so that we'd get a chance to convert any new code that locks
mmap_sem in the -rc1 release before applying that last patch.

Michel Lespinasse (10):
  mmap locking API: initial implementation as rwsem wrappers
  MMU notifier: use the new mmap locking API
  DMA  reservations: use the new mmap locking API
  mmap locking API: use coccinelle to convert mmap_sem rwsem call sites
  mmap locking API: convert mmap_sem call sites missed by coccinelle
  mmap locking API: convert nested write lock sites
  mmap locking API: add mmap_read_release() and
    mmap_read_unlock_non_owner()
  mmap locking API: add MMAP_LOCK_INITIALIZER
  mmap locking API: use lockdep_assert_held
  mmap locking API: rename mmap_sem to mmap_lock

 arch/alpha/kernel/traps.c                     |  4 +-
 arch/alpha/mm/fault.c                         | 10 +--
 arch/arc/kernel/process.c                     |  4 +-
 arch/arc/kernel/troubleshoot.c                |  4 +-
 arch/arc/mm/fault.c                           |  4 +-
 arch/arm/kernel/process.c                     |  4 +-
 arch/arm/kernel/swp_emulate.c                 |  4 +-
 arch/arm/lib/uaccess_with_memcpy.c            | 16 ++--
 arch/arm/mm/fault.c                           |  6 +-
 arch/arm64/kernel/traps.c                     |  4 +-
 arch/arm64/kernel/vdso.c                      |  8 +-
 arch/arm64/mm/fault.c                         |  8 +-
 arch/csky/kernel/vdso.c                       |  4 +-
 arch/csky/mm/fault.c                          |  8 +-
 arch/hexagon/kernel/vdso.c                    |  4 +-
 arch/hexagon/mm/vm_fault.c                    |  8 +-
 arch/ia64/kernel/perfmon.c                    |  8 +-
 arch/ia64/mm/fault.c                          | 12 +--
 arch/ia64/mm/init.c                           | 12 +--
 arch/m68k/kernel/sys_m68k.c                   | 14 ++--
 arch/m68k/mm/fault.c                          |  8 +-
 arch/microblaze/mm/fault.c                    | 12 +--
 arch/mips/kernel/traps.c                      |  4 +-
 arch/mips/kernel/vdso.c                       |  4 +-
 arch/mips/mm/fault.c                          | 10 +--
 arch/nds32/kernel/vdso.c                      |  6 +-
 arch/nds32/mm/fault.c                         | 12 +--
 arch/nios2/mm/fault.c                         | 12 +--
 arch/nios2/mm/init.c                          |  4 +-
 arch/openrisc/mm/fault.c                      | 10 +--
 arch/parisc/kernel/traps.c                    |  6 +-
 arch/parisc/mm/fault.c                        |  8 +-
 arch/powerpc/kernel/vdso.c                    |  6 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c           |  4 +-
 arch/powerpc/kvm/book3s_hv.c                  |  6 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c            | 12 +--
 arch/powerpc/kvm/e500_mmu_host.c              |  4 +-
 arch/powerpc/mm/book3s64/iommu_api.c          |  4 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       | 12 +--
 arch/powerpc/mm/copro_fault.c                 |  4 +-
 arch/powerpc/mm/fault.c                       | 12 +--
 arch/powerpc/oprofile/cell/spu_task_sync.c    |  6 +-
 arch/powerpc/platforms/cell/spufs/file.c      |  4 +-
 arch/riscv/kernel/vdso.c                      |  4 +-
 arch/riscv/mm/fault.c                         | 10 +--
 arch/s390/kernel/vdso.c                       |  4 +-
 arch/s390/kvm/gaccess.c                       |  4 +-
 arch/s390/kvm/kvm-s390.c                      | 24 +++---
 arch/s390/kvm/priv.c                          | 32 ++++----
 arch/s390/mm/fault.c                          |  6 +-
 arch/s390/mm/gmap.c                           | 40 ++++-----
 arch/s390/pci/pci_mmio.c                      |  4 +-
 arch/sh/kernel/sys_sh.c                       |  6 +-
 arch/sh/kernel/vsyscall/vsyscall.c            |  4 +-
 arch/sh/mm/fault.c                            | 14 ++--
 arch/sparc/mm/fault_32.c                      | 18 ++--
 arch/sparc/mm/fault_64.c                      | 12 +--
 arch/sparc/vdso/vma.c                         |  4 +-
 arch/um/include/asm/mmu_context.h             |  5 +-
 arch/um/kernel/tlb.c                          |  2 +-
 arch/um/kernel/trap.c                         |  6 +-
 arch/unicore32/mm/fault.c                     |  6 +-
 arch/x86/entry/vdso/vma.c                     | 14 ++--
 arch/x86/events/core.c                        |  4 +-
 arch/x86/kernel/tboot.c                       |  2 +-
 arch/x86/kernel/vm86_32.c                     |  4 +-
 arch/x86/kvm/mmu/paging_tmpl.h                |  8 +-
 arch/x86/mm/fault.c                           | 10 +--
 arch/x86/um/vdso/vma.c                        |  4 +-
 arch/xtensa/mm/fault.c                        | 10 +--
 drivers/android/binder_alloc.c                | 10 +--
 drivers/dma-buf/dma-resv.c                    |  5 +-
 drivers/firmware/efi/efi.c                    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 10 +--
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  4 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c         |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c      |  4 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |  8 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c         | 20 ++---
 drivers/gpu/drm/radeon/radeon_cs.c            |  4 +-
 drivers/gpu/drm/radeon/radeon_gem.c           |  6 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c               |  4 +-
 drivers/infiniband/core/umem_odp.c            |  4 +-
 drivers/infiniband/core/uverbs_main.c         |  4 +-
 drivers/infiniband/hw/mlx4/mr.c               |  4 +-
 drivers/infiniband/hw/qib/qib_user_pages.c    |  6 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c      |  4 +-
 drivers/infiniband/sw/siw/siw_mem.c           |  4 +-
 drivers/iommu/amd_iommu_v2.c                  |  4 +-
 drivers/iommu/intel-svm.c                     |  4 +-
 drivers/media/v4l2-core/videobuf-core.c       |  4 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c |  4 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c     |  4 +-
 drivers/misc/cxl/cxllib.c                     |  4 +-
 drivers/misc/cxl/fault.c                      |  4 +-
 drivers/misc/sgi-gru/grufault.c               | 16 ++--
 drivers/misc/sgi-gru/grufile.c                |  4 +-
 drivers/oprofile/buffer_sync.c                | 10 +--
 drivers/staging/kpc2000/kpc_dma/fileops.c     |  4 +-
 drivers/tee/optee/call.c                      |  4 +-
 drivers/vfio/vfio_iommu_type1.c               |  8 +-
 drivers/xen/gntdev.c                          |  4 +-
 drivers/xen/privcmd.c                         | 14 ++--
 fs/aio.c                                      |  4 +-
 fs/coredump.c                                 |  4 +-
 fs/exec.c                                     | 16 ++--
 fs/io_uring.c                                 |  4 +-
 fs/proc/base.c                                | 18 ++--
 fs/proc/task_mmu.c                            | 28 +++----
 fs/proc/task_nommu.c                          | 18 ++--
 fs/userfaultfd.c                              | 28 +++----
 include/linux/mm.h                            |  1 +
 include/linux/mm_types.h                      |  2 +-
 include/linux/mmap_lock.h                     | 82 +++++++++++++++++++
 include/linux/mmu_notifier.h                  |  5 +-
 ipc/shm.c                                     |  8 +-
 kernel/acct.c                                 |  4 +-
 kernel/bpf/stackmap.c                         | 13 ++-
 kernel/events/core.c                          |  4 +-
 kernel/events/uprobes.c                       | 16 ++--
 kernel/exit.c                                 |  8 +-
 kernel/fork.c                                 | 14 ++--
 kernel/futex.c                                |  4 +-
 kernel/sched/fair.c                           |  4 +-
 kernel/sys.c                                  | 18 ++--
 kernel/trace/trace_output.c                   |  4 +-
 mm/filemap.c                                  |  6 +-
 mm/frame_vector.c                             |  4 +-
 mm/gup.c                                      | 20 ++---
 mm/hmm.c                                      |  2 +-
 mm/init-mm.c                                  |  2 +-
 mm/internal.h                                 |  2 +-
 mm/khugepaged.c                               | 36 ++++----
 mm/ksm.c                                      | 34 ++++----
 mm/madvise.c                                  | 18 ++--
 mm/memcontrol.c                               |  8 +-
 mm/memory.c                                   | 14 ++--
 mm/mempolicy.c                                | 22 ++---
 mm/migrate.c                                  |  8 +-
 mm/mincore.c                                  |  4 +-
 mm/mlock.c                                    | 16 ++--
 mm/mmap.c                                     | 36 ++++----
 mm/mmu_notifier.c                             | 22 ++---
 mm/mprotect.c                                 | 12 +--
 mm/mremap.c                                   |  6 +-
 mm/msync.c                                    |  8 +-
 mm/nommu.c                                    | 16 ++--
 mm/oom_kill.c                                 |  4 +-
 mm/pagewalk.c                                 | 15 ++--
 mm/process_vm_access.c                        |  4 +-
 mm/ptdump.c                                   |  4 +-
 mm/swapfile.c                                 |  4 +-
 mm/userfaultfd.c                              | 14 ++--
 mm/util.c                                     | 12 +--
 net/ipv4/tcp.c                                |  4 +-
 net/xdp/xdp_umem.c                            |  4 +-
 virt/kvm/arm/mmu.c                            | 14 ++--
 virt/kvm/async_pf.c                           |  4 +-
 virt/kvm/kvm_main.c                           |  8 +-
 160 files changed, 779 insertions(+), 693 deletions(-)
 create mode 100644 include/linux/mmap_lock.h

-- 
2.26.0.rc2.310.g2932bb562d-goog

