Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48F0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C88206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdlVXHPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgETF3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgETF3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:29:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D7BC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d7so794966ybp.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gkl/kkv7JdkaIYfmbxOIDg8OTSOYQUfRWXmSeBrQL3g=;
        b=FdlVXHPqZKNZ13ebdilMvxemnhQhTaUwklpy969T978tBtnkOyggb9UIuO6PelEVaG
         DCheaeN6ZNdkSyWSMEVH5mMFsJrSzwK0DX+URyuy/nK69al4X8/bIY5gIy2J6iWTL37a
         peQqra0gQIaL/gd8M4xbSIM/dIZQx4RrOGGwFUaSFLPrSAzopEh4SRVPEiO31g3T2GgG
         YWXik84df2W3UPgcASdT7tbLaWXVmoGme2+17hSc1pnzOkDDlniULcNbvnJEAH9v9t2d
         /DooiLKYtiSNEvzYoUd++NnBtMlb7ChMGJXo5gDxUFYuYny4/EcfTxtFTfJU/CN5Rfzl
         S33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gkl/kkv7JdkaIYfmbxOIDg8OTSOYQUfRWXmSeBrQL3g=;
        b=JXP9jXAzdoORzKBGeX0uVs0IsDzym2zrSUetNYAPF2eemLZ5e5byBXgfHA4p902940
         rRJTaSr6bovL+nJ7ZYp+g9ivpb1pJyM91mumgChdKR5++YZz70vmIFdb5wgU1XMX7Ox/
         HSg/GruR9sG/KBKW1Zlm54kr44py68uIbxRYrzmkfoQsD804w0JQqvjUpAASdfFRt4W6
         Kds8s/bZMBunCXhNTGBi6dajKIctqE8o+Wc4Ua0oON57W2ps4TOCY45XHQwKDc+VMZoi
         r7W38rhd6uYFm/Hqj+R0gLkzEcduWQpP7gWMFycP4c4jytuZiF0udRP7jwDF/nP+Q/EP
         cNPA==
X-Gm-Message-State: AOAM5337v8R2JWcUPCPlOjaof94dpfYUDiBm7gqZle5RLYZeWpTHH0ML
        +dTM8bI9+DHwyPZYJU/oho6tpkUKz+Y=
X-Google-Smtp-Source: ABdhPJzIpcDbn0PAHnzPc1AqDrIi+b4oFSTWKbIp+S8uR76YGxiO2FNKgc6LEvcBb1/mj6INfN7PRa3l1SQ=
X-Received: by 2002:a25:ce88:: with SMTP id x130mr4647374ybe.523.1589952550973;
 Tue, 19 May 2020 22:29:10 -0700 (PDT)
Date:   Tue, 19 May 2020 22:28:56 -0700
Message-Id: <20200520052908.204642-1-walken@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v6 00/12] Add a new mmap locking API wrapping mmap_sem calls
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
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reposting this patch series on top of v5.7-rc6. I think this is ready
for inclusion into the -mm tree; however there were some minor points
of feedback to address and also it was easier to regenerate a full
version after the v5.5 (only updating patches 09/10 and 10/10) caused
some confusion.


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


Changes since v5.5 of the patchset:

- Applied the changes on top of v5.7-rc6. This was a straight rebase
  except for the changes noted here.

- Re-generated the coccinelle changes (patch 04/12).

- Patch 08/12: use (name) in the MMAP_LOCK_INITIALIZER macro.

- Patch 09/12: use lockdep_assert_held() / lockdep_assert_held_write()
  so that mmap_assert_locked() and mmap_assert_write_locked() get better
  coverage when lockdep is enabled but CONFIG_DEBUG_VM is not.

- Added patches 11 and 12, converting comments that referenced mmap_sem
  rwsem calls or the mmap_sem lock itself, to reference the corresponding
  mmap locking APIs or the mmap_lock itself.


Changes since v5 of the patchset:

- Patch 09/10: Add both mmap_assert_locked() and mmap_assert_write_locked();
  convert some call sites that were using lockdep assertions to use these
  new APIs instead.


Changes since v4 of the patchset:

- Applied the changes on top of v5.7-rc2. This was a straight rebase
  except for changes noted here.

- Patch 01/10: renamed the mmap_write_downgrade API
  (as suggested by Davidlohr Bueso).

- Patch 05/10: added arch/riscv/mm/pageattr.c changes that had been
  previously missed, as found by the kbuild bot.

- Patch 06/10: use SINGLE_DEPTH_NESTING as suggested by Matthew Wilcox.

- Patch 08/10: change MMAP_LOCK_INITIALIZER definition
  as suggested by Matthew Wilcox.

- Patch 09/10: add mm_assert_locked API as suggested by Matthew Wilcox.


Changes since v3 of the patchset:

- The changes now apply on top of v5.7-rc1. This was a straight rebase
  except for changes noted here.

- Re-generated the coccinelle changes (patch 04/10).

- Patch 06/10: removed the mmap_write_unlock_nested API;
  mmap_write_lock_nested() calls now pair with the regular mmap_write_unlock()
  as was suggested by many people.

- Patch 07/10: removed the mmap_read_release API; this is replaced with
  mmap_read_trylock_non_owner() which pairs with mmap_read_unlock_non_owner()
  Thanks to Peter Zijlstra for the suggestion.


Changes since v2 of the patchset:

- Removed the mmap_is_locked API - v2 had removed all uses of it,
  but the actual function definition was still there unused.
  Thanks to Jason Gunthorpe for noticing the unused mmap_is_locked function.


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
  Thanks to Jason Gunthorpe and Matthew Wilcox for the suggestion.


The changes apply on top of v5.7-rc6.

I think these changes are ready for integration into the -mm tree now
(for integration into v5.8). The coccinelle part of the change is
relatively invasive, but can be skipped over on a file by file basis
if it causes any conflicts with other pending changes. The new mmap
locking API can interoperate with new code that is still using direct
rwsem calls, until the last patch in the series which renames mmap_sem
to enforce using the new API. Maybe that last patch could be delayed for
a bit, so that we'd get a chance to convert any new code that locks
mmap_sem in the -rc1 release before applying that last patch.


Michel Lespinasse (12):
  mmap locking API: initial implementation as rwsem wrappers
  MMU notifier: use the new mmap locking API
  DMA  reservations: use the new mmap locking API
  mmap locking API: use coccinelle to convert mmap_sem rwsem call sites
  mmap locking API: convert mmap_sem call sites missed by coccinelle
  mmap locking API: convert nested write lock sites
  mmap locking API: add mmap_read_trylock_non_owner()
  mmap locking API: add MMAP_LOCK_INITIALIZER
  mmap locking API: add mmap_assert_locked() and
    mmap_assert_write_locked()
  mmap locking API: rename mmap_sem to mmap_lock
  mmap locking API: convert mmap_sem API comments
  mmap locking API: convert mmap_sem comments

 .../admin-guide/mm/numa_memory_policy.rst     | 10 +--
 Documentation/admin-guide/mm/userfaultfd.rst  |  2 +-
 Documentation/filesystems/locking.rst         |  2 +-
 Documentation/vm/hmm.rst                      |  6 +-
 Documentation/vm/transhuge.rst                |  4 +-
 arch/alpha/kernel/traps.c                     |  4 +-
 arch/alpha/mm/fault.c                         | 12 +--
 arch/arc/kernel/process.c                     |  4 +-
 arch/arc/kernel/troubleshoot.c                |  4 +-
 arch/arc/mm/fault.c                           |  6 +-
 arch/arm/kernel/process.c                     |  4 +-
 arch/arm/kernel/swp_emulate.c                 |  4 +-
 arch/arm/kernel/vdso.c                        |  2 +-
 arch/arm/lib/uaccess_with_memcpy.c            | 16 ++--
 arch/arm/mm/fault.c                           |  8 +-
 arch/arm64/kernel/traps.c                     |  4 +-
 arch/arm64/kernel/vdso.c                      |  8 +-
 arch/arm64/mm/fault.c                         |  8 +-
 arch/csky/kernel/vdso.c                       |  4 +-
 arch/csky/mm/fault.c                          |  8 +-
 arch/hexagon/kernel/vdso.c                    |  4 +-
 arch/hexagon/mm/vm_fault.c                    |  8 +-
 arch/ia64/kernel/perfmon.c                    |  8 +-
 arch/ia64/mm/fault.c                          | 16 ++--
 arch/ia64/mm/init.c                           | 12 +--
 arch/m68k/kernel/sys_m68k.c                   | 14 +--
 arch/m68k/mm/fault.c                          | 10 +--
 arch/microblaze/mm/fault.c                    | 16 ++--
 arch/mips/kernel/traps.c                      |  4 +-
 arch/mips/kernel/vdso.c                       |  4 +-
 arch/mips/mm/fault.c                          | 12 +--
 arch/nds32/kernel/vdso.c                      |  6 +-
 arch/nds32/mm/fault.c                         | 16 ++--
 arch/nios2/mm/fault.c                         | 14 +--
 arch/nios2/mm/init.c                          |  4 +-
 arch/openrisc/mm/fault.c                      | 12 +--
 arch/parisc/kernel/traps.c                    |  6 +-
 arch/parisc/mm/fault.c                        | 10 +--
 arch/powerpc/include/asm/pkeys.h              |  2 +-
 arch/powerpc/kernel/vdso.c                    |  6 +-
 arch/powerpc/kvm/book3s_hv.c                  |  6 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c            | 18 ++--
 arch/powerpc/kvm/e500_mmu_host.c              |  4 +-
 arch/powerpc/mm/book3s32/tlb.c                |  2 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c       |  4 +-
 arch/powerpc/mm/book3s64/iommu_api.c          |  4 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       | 14 +--
 arch/powerpc/mm/copro_fault.c                 |  4 +-
 arch/powerpc/mm/fault.c                       | 20 ++---
 arch/powerpc/mm/pgtable.c                     |  2 +-
 arch/powerpc/oprofile/cell/spu_task_sync.c    |  6 +-
 arch/powerpc/platforms/cell/spufs/file.c      | 10 +--
 arch/riscv/kernel/vdso.c                      |  4 +-
 arch/riscv/mm/fault.c                         | 14 +--
 arch/riscv/mm/pageattr.c                      |  4 +-
 arch/s390/kernel/uv.c                         |  4 +-
 arch/s390/kernel/vdso.c                       |  4 +-
 arch/s390/kvm/gaccess.c                       |  4 +-
 arch/s390/kvm/interrupt.c                     |  4 +-
 arch/s390/kvm/kvm-s390.c                      | 28 +++---
 arch/s390/kvm/priv.c                          | 34 +++----
 arch/s390/mm/fault.c                          | 16 ++--
 arch/s390/mm/gmap.c                           | 76 ++++++++--------
 arch/s390/mm/pgalloc.c                        |  2 +-
 arch/s390/pci/pci_mmio.c                      |  4 +-
 arch/sh/kernel/sys_sh.c                       |  6 +-
 arch/sh/kernel/vsyscall/vsyscall.c            |  4 +-
 arch/sh/mm/cache-sh4.c                        |  2 +-
 arch/sh/mm/fault.c                            | 14 +--
 arch/sparc/mm/fault_32.c                      | 20 ++---
 arch/sparc/mm/fault_64.c                      | 16 ++--
 arch/sparc/vdso/vma.c                         |  4 +-
 arch/um/include/asm/mmu_context.h             |  5 +-
 arch/um/kernel/skas/mmu.c                     |  2 +-
 arch/um/kernel/tlb.c                          |  4 +-
 arch/um/kernel/trap.c                         |  6 +-
 arch/unicore32/mm/fault.c                     |  8 +-
 arch/x86/entry/vdso/vma.c                     | 14 +--
 arch/x86/events/core.c                        |  4 +-
 arch/x86/include/asm/mmu.h                    |  2 +-
 arch/x86/include/asm/pgtable-3level.h         |  8 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |  6 +-
 arch/x86/kernel/ldt.c                         |  2 +-
 arch/x86/kernel/tboot.c                       |  2 +-
 arch/x86/kernel/vm86_32.c                     |  4 +-
 arch/x86/kvm/mmu/paging_tmpl.h                |  8 +-
 arch/x86/mm/fault.c                           | 22 ++---
 arch/x86/um/vdso/vma.c                        |  4 +-
 arch/xtensa/mm/fault.c                        | 12 +--
 drivers/android/binder_alloc.c                | 14 +--
 drivers/char/mspec.c                          |  2 +-
 drivers/dma-buf/dma-resv.c                    |  5 +-
 drivers/firmware/efi/efi.c                    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 10 +--
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  4 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c         |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c      |  4 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   | 14 +--
 drivers/gpu/drm/i915/i915_perf.c              |  2 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c         | 22 ++---
 drivers/gpu/drm/radeon/radeon_cs.c            |  4 +-
 drivers/gpu/drm/radeon/radeon_gem.c           |  6 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c               | 10 +--
 drivers/infiniband/core/umem_odp.c            |  4 +-
 drivers/infiniband/core/uverbs_main.c         |  6 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c           |  2 +-
 drivers/infiniband/hw/mlx4/mr.c               |  4 +-
 drivers/infiniband/hw/qib/qib_user_pages.c    |  6 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c      |  4 +-
 drivers/infiniband/sw/siw/siw_mem.c           |  4 +-
 drivers/iommu/amd_iommu_v2.c                  |  4 +-
 drivers/iommu/intel-svm.c                     |  4 +-
 drivers/media/v4l2-core/videobuf-core.c       |  4 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c |  4 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c     |  6 +-
 drivers/misc/cxl/cxllib.c                     |  6 +-
 drivers/misc/cxl/fault.c                      |  4 +-
 drivers/misc/sgi-gru/grufault.c               | 24 ++---
 drivers/misc/sgi-gru/grufile.c                |  4 +-
 drivers/oprofile/buffer_sync.c                | 12 +--
 drivers/staging/android/ashmem.c              |  4 +-
 drivers/staging/comedi/comedi_fops.c          |  2 +-
 drivers/staging/kpc2000/kpc_dma/fileops.c     |  4 +-
 drivers/tee/optee/call.c                      |  4 +-
 drivers/tty/vt/consolemap.c                   |  2 +-
 drivers/vfio/vfio_iommu_type1.c               |  8 +-
 drivers/vhost/vdpa.c                          |  4 +-
 drivers/xen/gntdev.c                          |  6 +-
 drivers/xen/privcmd.c                         | 14 +--
 fs/aio.c                                      |  4 +-
 fs/coredump.c                                 |  8 +-
 fs/exec.c                                     | 18 ++--
 fs/ext2/file.c                                |  2 +-
 fs/ext4/super.c                               |  6 +-
 fs/hugetlbfs/inode.c                          |  2 +-
 fs/io_uring.c                                 |  4 +-
 fs/kernfs/file.c                              |  4 +-
 fs/proc/base.c                                | 24 ++---
 fs/proc/task_mmu.c                            | 34 +++----
 fs/proc/task_nommu.c                          | 18 ++--
 fs/userfaultfd.c                              | 46 +++++-----
 fs/xfs/xfs_file.c                             |  2 +-
 fs/xfs/xfs_inode.c                            | 14 +--
 fs/xfs/xfs_iops.c                             |  4 +-
 include/asm-generic/pgtable.h                 |  6 +-
 include/linux/fs.h                            |  4 +-
 include/linux/huge_mm.h                       |  2 +-
 include/linux/mempolicy.h                     |  2 +-
 include/linux/mm.h                            | 11 +--
 include/linux/mm_types.h                      |  4 +-
 include/linux/mmap_lock.h                     | 90 +++++++++++++++++++
 include/linux/mmu_notifier.h                  | 13 +--
 include/linux/pagemap.h                       |  2 +-
 include/linux/rmap.h                          |  2 +-
 include/linux/sched/mm.h                      | 10 +--
 ipc/shm.c                                     |  8 +-
 kernel/acct.c                                 |  6 +-
 kernel/bpf/stackmap.c                         | 17 ++--
 kernel/cgroup/cpuset.c                        |  4 +-
 kernel/events/core.c                          | 10 +--
 kernel/events/uprobes.c                       | 20 ++---
 kernel/exit.c                                 | 10 +--
 kernel/fork.c                                 | 14 +--
 kernel/futex.c                                |  4 +-
 kernel/relay.c                                |  2 +-
 kernel/sched/fair.c                           |  4 +-
 kernel/sys.c                                  | 22 ++---
 kernel/trace/trace_output.c                   |  4 +-
 lib/test_lockup.c                             | 16 ++--
 mm/filemap.c                                  | 46 +++++-----
 mm/frame_vector.c                             |  6 +-
 mm/gup.c                                      | 70 +++++++--------
 mm/hmm.c                                      |  2 +-
 mm/huge_memory.c                              |  8 +-
 mm/hugetlb.c                                  |  2 +-
 mm/init-mm.c                                  |  2 +-
 mm/internal.h                                 |  6 +-
 mm/khugepaged.c                               | 72 +++++++--------
 mm/ksm.c                                      | 48 +++++-----
 mm/maccess.c                                  |  4 +-
 mm/madvise.c                                  | 40 ++++-----
 mm/memcontrol.c                               | 10 +--
 mm/memory.c                                   | 60 ++++++-------
 mm/mempolicy.c                                | 36 ++++----
 mm/migrate.c                                  | 16 ++--
 mm/mincore.c                                  |  4 +-
 mm/mlock.c                                    | 22 ++---
 mm/mmap.c                                     | 74 +++++++--------
 mm/mmu_gather.c                               |  2 +-
 mm/mmu_notifier.c                             | 22 ++---
 mm/mprotect.c                                 | 20 ++---
 mm/mremap.c                                   | 14 +--
 mm/msync.c                                    |  8 +-
 mm/nommu.c                                    | 22 ++---
 mm/oom_kill.c                                 | 14 +--
 mm/pagewalk.c                                 | 12 +--
 mm/process_vm_access.c                        |  4 +-
 mm/ptdump.c                                   |  4 +-
 mm/rmap.c                                     | 12 +--
 mm/shmem.c                                    |  4 +-
 mm/swap_state.c                               |  4 +-
 mm/swapfile.c                                 |  4 +-
 mm/userfaultfd.c                              | 26 +++---
 mm/util.c                                     | 12 +--
 net/ipv4/tcp.c                                |  8 +-
 net/xdp/xdp_umem.c                            |  4 +-
 security/keys/keyctl.c                        |  2 +-
 sound/core/oss/pcm_oss.c                      |  2 +-
 virt/kvm/arm/mmu.c                            | 14 +--
 virt/kvm/async_pf.c                           |  4 +-
 virt/kvm/kvm_main.c                           |  8 +-
 216 files changed, 1178 insertions(+), 1091 deletions(-)
 create mode 100644 include/linux/mmap_lock.h


base-commit: b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce

-- 
2.26.2.761.g0e0b3e54be-goog

