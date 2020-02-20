Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B97C11D0F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7F42467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xhy0m5rD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgBTQbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:31:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58724 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728218AbgBTQbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fKPCfFx1/RoDdtmYf2lPkKj1r1ouFDbz5lqWtJeBVHo=;
        b=Xhy0m5rDkYnZPPjFdI1L/w2ci0h6aSJDnOoRwSfHHDlUFB4X2x3wiyt4x1TitROke0EWow
        17eFSJe9uFMa306EkS4+/aYrZCJHlx9CK94YWzJFcEkS7t6x1PdKvaWo/cHhW15nfWuPOQ
        ixyapEGnC74ClZA4kRvQZ5H00XudsYQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-tNc7EXp_NaCFsm8jVeXCTg-1; Thu, 20 Feb 2020 11:31:17 -0500
X-MC-Unique: tNc7EXp_NaCFsm8jVeXCTg-1
Received: by mail-qt1-f199.google.com with SMTP id y3so2964156qti.15
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fKPCfFx1/RoDdtmYf2lPkKj1r1ouFDbz5lqWtJeBVHo=;
        b=E6XPkeSk9vRBN0ydfBHD0R7VasB0cxhjRvwfKrEuB+knWQSYsLax/Tbu4XojHb6GLN
         EDpXLInqYO0rNvzJAKzDyTndzCCHhTiCZ4FtklV8W/lIEeYRw6YochXSWXt4jqGbQBCn
         WcUZp7Ddt9KfYZIV660R3zv6UcUjGPVCKoj1Dq+GSZV4XmmBz76qBAAgP4c1OlTBoZMu
         KoEpxIr7U/AzlgBdy4V+dpDRQp4MisER22ICMy+Ofhr8fpof/kbmu3DlY8UJLBGq/E6n
         SkRmY/cWkS5AMEzfPyssPFSH74tKenIzXHu1rNTyQDXIjO4cmQtC5ZxSxjwb6y8Oujqx
         /Ihg==
X-Gm-Message-State: APjAAAWW6JVyzMF+pXPw/ZYbZXJO2rUUKa+C+JaArbuUnzJoA2ytihwS
        qq/lei0Ua8eoAcZwH0G9n9RU1AWX1ph6N2FRaOb4QlygJtZV3CJ3bkTtSTlnfblIhwdhc02pjs1
        Fgfh6kcbHMX089ncgKBnAUJLH
X-Received: by 2002:a05:6214:1923:: with SMTP id es3mr26738570qvb.49.1582216276414;
        Thu, 20 Feb 2020 08:31:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvIolzCH6TT1CIzw3iHVemfL5Q697qtjNM7vuhRafBPWC+JGDeJaSyVOvZ9CjUjKok8PLjBA==
X-Received: by 2002:a05:6214:1923:: with SMTP id es3mr26738392qvb.49.1582216274997;
        Thu, 20 Feb 2020 08:31:14 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:13 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Brian Geffon <bgeffon@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH v6 00/19] userfaultfd: write protection support
Date:   Thu, 20 Feb 2020 11:30:53 -0500
Message-Id: <20200220163112.11409-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This v6 series implements initial write protection support for
userfaultfd (heavily based on work from Andrea Arcangeli and Shaohua
Li for the initial versions, and mostly all the follow up ideas from
Andrea too).  Currently both shmem and hugetlbfs are not supported
yet, but only anonymous memory.

It's based on the fault retry series:

  https://lore.kernel.org/lkml/20200220155353.8676-1-peterx@redhat.com/

This series can also be found at (with the mm page fault retry series
applied as well):

  https://github.com/xzpeter/linux/tree/uffd-wp-merged

Previous version of this series is tested by both Marty Mcfadden
<mcfadden8@llnl.gov> and Bobby Powers <bobbypowers@gmail.com>.

My sincerely thanks to everyone who helped to move this forward even a
bit!  Any comment is welcomed.

Thanks,

v6 changelog:
- rebase
- drop patch "userfaultfd: introduce helper vma_find_uffd" because
  after rebase to 5.6-rc2 we've got find_dst_vma which does exactly
  the same thing.  Use that instead.

v5 changelog:
- rebase
- drop two patches:
    "userfaultfd: wp: handle COW properly for uffd-wp"
    "mm: introduce do_wp_page_cont()"
  instead remove the write bit always when resolving uffd-wp page
  fault in previous patch ("userfaultfd: wp: apply _PAGE_UFFD_WP bit")
  then COW will be handled correctly in the PF irq handler [Andrea]

v4 changelog:
- add r-bs
- use kernel-doc format for fault_flag_allow_retry_first [Jerome]
- drop "export wp_page_copy", add new patch to split do_wp_page(), use
  it in change_pte_range() to replace the wp_page_copy(). [Jerome] (I
  thought about different ways to do this but I still can't find a
  100% good way for all... in this version I still used the
  do_wp_page_cont naming.  We can still discuss this and how we should
  split do_wp_page)
- make sure uffd-wp will also apply to device private entries which
  HMM uses [Jerome]

v3 changelog:
- take r-bs
- patch 1: fix typo [Jerome]
- patch 2: use brackets where proper around (flags & VM_FAULT_RETRY)
  (there're three places to change, not four...) [Jerome]
- patch 4: make sure TRIED is applied correctly on all archs, add more
  comment to explain the new page fault mechanism [Jerome]
- patch 7: in do_swap_page() remove the two lines to remove
  FAULT_FLAG_WRITE flag [Jerome]
- patch 10: another brackets change like above, and in
  mfill_atomic_pte return -EINVAL when detected wp_copy==1 upon shared
  memories [Jerome]
- patch 12: move _PAGE_CHG_MASK change to patch 8 [Jerome]
- patch 14: wp_page_copy() - fix write bit; change_pte_range() -
  detect PTE change after COW [Jerome]
- patch 17: remove last paragraph of commit message, no need to drop
  the two lines in do_swap_page() since they've been directly dropped
  in patch 7; touch up remove_migration_pte() to only detect uffd-wp
  bit if it's read migration entry [Jerome]
- add patch: "userfaultfd: wp: declare _UFFDIO_WRITEPROTECT
  conditionally", which remove _UFFDIO_WRITEPROTECT bit if detected
  non-anonymous memory during REGISTER; meanwhile fixup the test case
  for shmem too for expected ioctls returned from REGISTER [Mike]
- add patch: "userfaultfd: wp: fixup swap entries in
  change_pte_range", the new patch will allow to apply the uffd-wp
  bits upon swap entries directly (e.g., when the page is during
  migration or the page was swapped out).  Please see the patch for
  detail information.

v2 changelog:
- add some r-bs
- split the patch "mm: userfault: return VM_FAULT_RETRY on signals"
  into two: one to focus on the signal behavior change, the other to
  remove the NOPAGE special path in handle_userfault().  Removing the
  ARC specific change and remove that part of commit message since
  it's fixed in 4d447455e73b already [Jerome]
- return -ENOENT when VMA is invalid for UFFDIO_WRITEPROTECT to match
  UFFDIO_COPY errno [Mike]
- add a new patch to introduce helper to find valid VMA for uffd
  [Mike]
- check against VM_MAYWRITE instead of VM_WRITE when registering UFFD
  WP [Mike]
- MM_CP_DIRTY_ACCT is used incorrectly, fix it up [Jerome]
- make sure the lock_page behavior will not be changed [Jerome]
- reorder the whole series, introduce the new ioctl last. [Jerome]
- fix up the uffdio_writeprotect() following commit df2cc96e77011cf79
  to return -EAGAIN when detected mm layout changes [Mike]

v1 can be found at: https://lkml.org/lkml/2019/1/21/130

Any comment would be greatly welcomed.   Thanks.

Overview
====================

The uffd-wp work was initialized by Shaohua Li [1], and later
continued by Andrea [2]. This series is based upon Andrea's latest
userfaultfd tree, and it is a continuous works from both Shaohua and
Andrea.  Many of the follow up ideas come from Andrea too.

Besides the old MISSING register mode of userfaultfd, the new uffd-wp
support provides another alternative register mode called
UFFDIO_REGISTER_MODE_WP that can be used to listen to not only missing
page faults but also write protection page faults, or even they can be
registered together.  At the same time, the new feature also provides
a new userfaultfd ioctl called UFFDIO_WRITEPROTECT which allows the
userspace to write protect a range or memory or fixup write permission
of faulted pages.

Please refer to the document patch "userfaultfd: wp:
UFFDIO_REGISTER_MODE_WP documentation update" for more information on
the new interface and what it can do.

The major workflow of an uffd-wp program should be:

  1. Register a memory region with WP mode using UFFDIO_REGISTER_MODE_WP

  2. Write protect part of the whole registered region using
     UFFDIO_WRITEPROTECT, passing in UFFDIO_WRITEPROTECT_MODE_WP to
     show that we want to write protect the range.

  3. Start a working thread that modifies the protected pages,
     meanwhile listening to UFFD messages.

  4. When a write is detected upon the protected range, page fault
     happens, a UFFD message will be generated and reported to the
     page fault handling thread

  5. The page fault handler thread resolves the page fault using the
     new UFFDIO_WRITEPROTECT ioctl, but this time passing in
     !UFFDIO_WRITEPROTECT_MODE_WP instead showing that we want to
     recover the write permission.  Before this operation, the fault
     handler thread can do anything it wants, e.g., dumps the page to
     a persistent storage.

  6. The worker thread will continue running with the correctly
     applied write permission from step 5.

Currently there are already two projects that are based on this new
userfaultfd feature.

QEMU Live Snapshot: The project provides a way to allow the QEMU
                    hypervisor to take snapshot of VMs without
                    stopping the VM [3].

LLNL umap library:  The project provides a mmap-like interface and
                    "allow to have an application specific buffer of
                    pages cached from a large file, i.e. out-of-core
                    execution using memory map" [4][5].

Before posting the patchset, this series was smoke tested against QEMU
live snapshot and the LLNL umap library (by doing parallel quicksort
using 128 sorting threads + 80 uffd servicing threads).  My sincere
thanks to Marty Mcfadden and Denis Plotnikov for the help along the
way.

TODO
=============

- hugetlbfs/shmem support
- performance
- more architectures
- cooperate with mprotect()-allowed processes (???)
- ...

References
==========

[1] https://lwn.net/Articles/666187/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/log/?h=userfault
[3] https://github.com/denis-plotnikov/qemu/commits/background-snapshot-kvm
[4] https://github.com/LLNL/umap
[5] https://llnl-umap.readthedocs.io/en/develop/
[6] https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?h=userfault&id=b245ecf6cf59156966f3da6e6b674f6695a5ffa5
[7] https://lkml.org/lkml/2018/11/21/370
[8] https://lkml.org/lkml/2018/12/30/64

Andrea Arcangeli (5):
  userfaultfd: wp: hook userfault handler to write protection fault
  userfaultfd: wp: add WP pagetable tracking to x86
  userfaultfd: wp: userfaultfd_pte/huge_pmd_wp() helpers
  userfaultfd: wp: add UFFDIO_COPY_MODE_WP
  userfaultfd: wp: add the writeprotect API to userfaultfd ioctl

Martin Cracauer (1):
  userfaultfd: wp: UFFDIO_REGISTER_MODE_WP documentation update

Peter Xu (10):
  mm: merge parameters for change_protection()
  userfaultfd: wp: apply _PAGE_UFFD_WP bit
  userfaultfd: wp: drop _PAGE_UFFD_WP properly when fork
  userfaultfd: wp: add pmd_swp_*uffd_wp() helpers
  userfaultfd: wp: support swap and page migration
  khugepaged: skip collapse if uffd-wp detected
  userfaultfd: wp: don't wake up when doing write protect
  userfaultfd: wp: declare _UFFDIO_WRITEPROTECT conditionally
  userfaultfd: selftests: refactor statistics
  userfaultfd: selftests: add write-protect test

Shaohua Li (3):
  userfaultfd: wp: add helper for writeprotect check
  userfaultfd: wp: support write protection for userfault vma range
  userfaultfd: wp: enabled write protection in userfaultfd API

 Documentation/admin-guide/mm/userfaultfd.rst |  51 +++++
 arch/x86/Kconfig                             |   1 +
 arch/x86/include/asm/pgtable.h               |  67 ++++++
 arch/x86/include/asm/pgtable_64.h            |   8 +-
 arch/x86/include/asm/pgtable_types.h         |  11 +-
 fs/userfaultfd.c                             | 106 +++++++--
 include/asm-generic/pgtable.h                |   1 +
 include/asm-generic/pgtable_uffd.h           |  66 ++++++
 include/linux/huge_mm.h                      |   2 +-
 include/linux/mm.h                           |  19 +-
 include/linux/swapops.h                      |   2 +
 include/linux/userfaultfd_k.h                |  42 +++-
 include/trace/events/huge_memory.h           |   1 +
 include/uapi/linux/userfaultfd.h             |  40 +++-
 init/Kconfig                                 |   5 +
 mm/huge_memory.c                             |  32 ++-
 mm/khugepaged.c                              |  23 ++
 mm/memory.c                                  |  26 ++-
 mm/mempolicy.c                               |   2 +-
 mm/migrate.c                                 |   6 +
 mm/mprotect.c                                |  74 ++++--
 mm/rmap.c                                    |   6 +
 mm/userfaultfd.c                             |  94 +++++++-
 tools/testing/selftests/vm/userfaultfd.c     | 225 +++++++++++++++----
 24 files changed, 791 insertions(+), 119 deletions(-)
 create mode 100644 include/asm-generic/pgtable_uffd.h

-- 
2.24.1

