Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8866C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9457020774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xg76fkW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgHNR12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgHNR10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:27:26 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFD8C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:26 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id v22so6504208qkg.15
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0cNgcsyuYAwNS3ucnNThPdPKsO+dwuJKPiI6RmFliVA=;
        b=Xg76fkW8M2c7cn589Bvqn4szeZLaNA2SA6S32k9aRrLPAsDykQkJ0MRoFqGRyre7my
         rEpWakxnYZIxWRwUsUc/30YkVzIWQ+T69BnOx2nvTXmeuA7reFa5uT6tNd/O0Ifow/oa
         5o70At9eIqXqDvNI38meVhkkQx+DAOiwwQcbgZeJpZsm38Q+Krwiya1dctIAHJllgV33
         xlrhFFMmkci+YzLbgz8eUQkpHFu2XiVBIiSamjonwPvLvga604RDymxQm3+QOdvexAqM
         QPPpozO0r+/IrskYJiqnGN2AoUZ4NdZu7PskxH/DHVviMMe5RI6zQNK8DQbikhFb1Czo
         PoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0cNgcsyuYAwNS3ucnNThPdPKsO+dwuJKPiI6RmFliVA=;
        b=iVtPzyws19Q9+Kkc+XZcJYQxOwPB/E8l+aPouFDkv5uRVcQF1uoiZG52KM7ExgiZa4
         ZmYy8NRN2XBXTlwO8DlFV2BPudCCYUKNYZ3yEncARRryU2Vmk/leNJ9NFxm3EOwL0TDY
         sKYVakTmWQRjRFE40qTvN3dkgs1U63wSTY+Ge9BavOK6JWkNFO5R0VQb8ujs7tvTixCi
         9W8FSEipRl/4qelQRvHN3bw2onkiJQbLch9hEt3/nbfxclTIjsgAD5n/0eTZzuohlFlH
         LYYEJqDMp+hZM6LJZmunQt3lnOpkLPABOzNdAGZ/5SiQR2UEuosEghJOya/8n50ZwLkq
         wv1g==
X-Gm-Message-State: AOAM531ZOgZnQHJQMkUsXapZGz54h0HzgycndAkpr/tZ8FhNwWw+jG21
        cKAYoFzKWbe5Zn4Q21jrXBZJDFL566Kr1jMe
X-Google-Smtp-Source: ABdhPJyJACKOly1+LVDe6Gou4x4jDxqWHURgjAjdmnX4i5puSGRaag6KUTy9s/R0iOXjyYBs7alYuVsgM/G/zkze
X-Received: by 2002:ad4:4c0a:: with SMTP id bz10mr3506370qvb.78.1597426043462;
 Fri, 14 Aug 2020 10:27:23 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:42 +0200
Message-Id: <cover.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 00/35] kasan: add hardware tag-based mode for arm64
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a new hardware tag-based mode to KASAN [1]. The new mode
is similar to the existing software tag-based KASAN, but relies on arm64
Memory Tagging Extension (MTE) [2] to perform memory and pointer tagging
(instead of shadow memory and compiler instrumentation).

This patchset is available here:

https://github.com/xairy/linux/tree/up-kasan-mte-v1

and has also been uploaded to the Linux kernel Gerrit instance:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2700

This patchset is based on the v7 of the user MTE patches [3], along with
some KASAN patches cherry-picked from the current mainline.

This patchset consists of three parts:

1. Rework KASAN code to allow easier integration of the hardware tag-based
   mode.
2. Introduce core in-kernel MTE routines.
3. Combine the two parts together and introduce the new mode.

For testing in QEMU hardware tag-based KASAN requires:

1. QEMU built from master [4] with these patches [5] on top.
2. GCC version 10.

[1] https://www.kernel.org/doc/html/latest/dev-tools/kasan.html
[2] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
[3] git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/mte
[4] https://github.com/qemu/qemu
[5] https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02677.html

====== Overview

The underlying ideas of the approach used by hardware tag-based KASAN are:

1. By relying on the Top Byte Ignore (TBI) arm64 CPU feature, pointer tags
   are stored in the top byte of each kernel pointer.

2. With the Memory Tagging Extension (MTE) arm64 CPU feature, memory tags
   for kernel memory allocations are stored in a dedicated memory not
   accessible via normal instuctions.

3. On each memory allocation, a random tag is generated, embedded it into
   the returned pointer, and the corresponding memory is tagged with the
   same tag value.

4. With MTE the CPU performs a check on each memory access to make sure
   that the pointer tag matches the memory tag.

5. On a tag mismatch the CPU generates a tag fault, and a KASAN report is
   printed.

Same as other KASAN modes, hardware tag-based KASAN is intended as a
debugging feature at this point.

====== Rationale

There are two main reasons for this new hardware tag-based mode:

1. Previously implemented software tag-based KASAN is being successfully
   used on dogfood testing devices due to its low memory overhead (as
   initially planned). The new hardware mode keeps the same low memory
   overhead, and is expected to have significantly lower performance
   impact, due to the tag checks being performed by the hardware.
   Therefore the new mode can be used as a better alternative in dogfood
   testing for hardware that supports MTE.

2. The new mode lays the groundwork for the planned in-kernel MTE-based
   memory corruption mitigation to be used in production.

====== Technical details

From the implementation perspective, hardware tag-based KASAN is almost
identical to the software mode. The key difference is using MTE for
assigning and checking tags.

Compared to the software mode, the hardware mode uses 4 bits per tag, as
dictated by MTE. Pointer tags are stored in bits [56:60), the top 4 bits
have the normal value 0xF. Having less distict tags increases the
probablity of false negatives (from ~1/256 to ~1/16) in certain cases.

Only synchronous exceptions are set up and used by hardware tag-based KASAN.

====== Benchmarks

Note: all measurements have been performed with software emulation of Memory
Tagging Extension, performance numbers for hardware tag-based KASAN on the
actual hardware are expected to be better.

Boot time [1]:
* 2.8 sec for clean kernel
* 5.7 sec for hardware tag-based KASAN
* 11.8 sec for software tag-based KASAN
* 11.6 sec for generic KASAN

Slab memory usage after boot [2]:
* 7.0 kb for clean kernel
* 9.7 kb for hardware tag-based KASAN
* 9.7 kb for software tag-based KASAN
* 41.3 kb for generic KASAN

Measurements have been performed with:
* defconfig-based configs
* Manually built QEMU master with these patches on top [3]
* QEMU arguments: -machine virt,mte=on -cpu max
* CONFIG_KASAN_STACK_ENABLE disabled
* CONFIG_KASAN_INLINE enabled
* clang-10 as the compiler and gcc-10 as the assembler
    
[1] Time before the ext4 driver is initialized.
[2] Measured as `cat /proc/meminfo | grep Slab`.
[3] https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02677.html

====== Notes

The cover letter for software tag-based KASAN patchset can be found here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0116523cfffa62aeb5aa3b85ce7419f3dae0c1b8

Andrey Konovalov (29):
  kasan: KASAN_VMALLOC depends on KASAN_GENERIC
  kasan: group vmalloc code
  kasan: shadow declarations only for software modes
  kasan: rename (un)poison_shadow to (un)poison_memory
  kasan: rename KASAN_SHADOW_* to KASAN_GRANULE_*
  kasan: only build init.c for software modes
  kasan: split out shadow.c from common.c
  kasan: rename generic/tags_report.c files
  kasan: don't duplicate config dependencies
  kasan: hide invalid free check implementation
  kasan: decode stack frame only with KASAN_STACK_ENABLE
  kasan, arm64: only init shadow for software modes
  kasan, arm64: only use kasan_depth for software modes
  kasan: rename addr_has_shadow to addr_has_metadata
  kasan: rename print_shadow_for_address to print_memory_metadata
  kasan: kasan_non_canonical_hook only for software modes
  kasan: rename SHADOW layout macros to META
  kasan: separate metadata_fetch_row for each mode
  kasan: don't allow SW_TAGS with ARM64_MTE
  kasan: introduce CONFIG_KASAN_HW_TAGS
  kasan, arm64: align allocations for HW_TAGS
  kasan: define KASAN_GRANULE_SIZE for HW_TAGS
  kasan, x86, s390: update undef CONFIG_KASAN
  kasan, arm64: expand CONFIG_KASAN checks
  kasan, arm64: implement HW_TAGS runtime
  kasan, arm64: print report from tag fault handler
  kasan, slub: reset tags when accessing metadata
  kasan, arm64: enable CONFIG_KASAN_HW_TAGS
  kasan: add documentation for hardware tag-based mode

Vincenzo Frascino (6):
  arm64: mte: Add in-kernel MTE helpers
  arm64: mte: Add in-kernel tag fault handler
  arm64: mte: Enable in-kernel MTE
  arm64: mte: Convert gcr_user into an exclude mask
  arm64: mte: Switch GCR_EL1 in kernel entry and exit
  kasan, arm64: Enable TBI EL1

 Documentation/dev-tools/kasan.rst         |  75 ++-
 arch/arm64/Kconfig                        |   3 +-
 arch/arm64/Makefile                       |   2 +-
 arch/arm64/include/asm/assembler.h        |   2 +-
 arch/arm64/include/asm/cache.h            |   3 +
 arch/arm64/include/asm/esr.h              |   1 +
 arch/arm64/include/asm/kasan.h            |   8 +-
 arch/arm64/include/asm/memory.h           |   6 +-
 arch/arm64/include/asm/mte.h              |  54 ++-
 arch/arm64/include/asm/mte_asm.h          |  10 +
 arch/arm64/include/asm/processor.h        |   2 +-
 arch/arm64/include/asm/string.h           |   5 +-
 arch/arm64/kernel/asm-offsets.c           |   3 +
 arch/arm64/kernel/cpufeature.c            |  11 +-
 arch/arm64/kernel/entry.S                 |  28 ++
 arch/arm64/kernel/head.S                  |   2 +-
 arch/arm64/kernel/image-vars.h            |   2 +-
 arch/arm64/kernel/mte.c                   |  87 +++-
 arch/arm64/kernel/setup.c                 |   1 -
 arch/arm64/lib/mte.S                      |  41 ++
 arch/arm64/mm/dump.c                      |   6 +-
 arch/arm64/mm/fault.c                     |  59 ++-
 arch/arm64/mm/kasan_init.c                |  22 +-
 arch/arm64/mm/proc.S                      |   2 +-
 arch/s390/boot/string.c                   |   1 +
 arch/x86/boot/compressed/misc.h           |   1 +
 include/linux/kasan-checks.h              |   2 +-
 include/linux/kasan.h                     | 110 +++--
 include/linux/mm.h                        |   2 +-
 include/linux/moduleloader.h              |   3 +-
 include/linux/page-flags-layout.h         |   2 +-
 include/linux/sched.h                     |   2 +-
 include/linux/string.h                    |   2 +-
 init/init_task.c                          |   2 +-
 kernel/fork.c                             |   4 +-
 lib/Kconfig.kasan                         |  60 ++-
 lib/test_kasan.c                          |   2 +-
 mm/kasan/Makefile                         |  21 +-
 mm/kasan/common.c                         | 554 ++--------------------
 mm/kasan/generic.c                        |  33 +-
 mm/kasan/generic_report.c                 | 165 -------
 mm/kasan/init.c                           |  10 +-
 mm/kasan/kasan.h                          |  45 +-
 mm/kasan/mte.c                            |  76 +++
 mm/kasan/report.c                         | 254 ++--------
 mm/kasan/report_generic.c                 | 331 +++++++++++++
 mm/kasan/report_mte.c                     |  47 ++
 mm/kasan/{tags_report.c => report_tags.c} |   7 +-
 mm/kasan/shadow.c                         | 509 ++++++++++++++++++++
 mm/kasan/tags.c                           |  14 +-
 mm/page_poison.c                          |   2 +-
 mm/ptdump.c                               |  13 +-
 mm/slab_common.c                          |   2 +-
 mm/slub.c                                 |  25 +-
 scripts/Makefile.lib                      |   2 +
 55 files changed, 1653 insertions(+), 1085 deletions(-)
 create mode 100644 arch/arm64/include/asm/mte_asm.h
 delete mode 100644 mm/kasan/generic_report.c
 create mode 100644 mm/kasan/mte.c
 create mode 100644 mm/kasan/report_generic.c
 create mode 100644 mm/kasan/report_mte.c
 rename mm/kasan/{tags_report.c => report_tags.c} (94%)
 create mode 100644 mm/kasan/shadow.c

-- 
2.28.0.220.ged08abb693-goog

