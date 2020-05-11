Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6ECC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E18920882
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589229757;
	bh=qgN70zVmcGfRw/D2t3Nj/SkzDqrrL4QsN2ZVTKK73gY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TtySuM/LET5/tBh3/dv6bfbqwuzchHdXhPdMexSd+s8zOaKT/PdN8pMhGzCj0mpyZ
	 zGw7A0ICW5pFPExsgzdypAZ0klEpfp4o0oW7QwjXZ6ofcX/hUn97ZFjQdGOvspqYpI
	 0dyDhUK0lhTVLnKpclaX+/FFUbPygFonOrwiN7pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbgEKUme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729842AbgEKUmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:32 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3B4E20661;
        Mon, 11 May 2020 20:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229752;
        bh=qgN70zVmcGfRw/D2t3Nj/SkzDqrrL4QsN2ZVTKK73gY=;
        h=From:To:Cc:Subject:Date:From;
        b=N7KUSjM3xKHtF+AGgrDQ460HMdYLs/8nqJ2Cwy7wJJQISA1YiedoQ+VtoWy40T1hU
         jW/OXAF4N3Up3dwu0VO0Helui/+tfEENMR+bmxVbXUnaXllJn2/uaIJL29GJx3dcok
         AguCdtZesS/WIdgX23kp1goGy3DNnSaBp6q67l8w=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Date:   Mon, 11 May 2020 21:41:32 +0100
Message-Id: <20200511204150.27858-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

(trimmed CC list since v4 since this is largely just a rebase)

This is version five of the READ_ONCE() codegen improvement series that
I've previously posted here:

RFC: https://lore.kernel.org/lkml/20200110165636.28035-1-will@kernel.org
v2:  https://lore.kernel.org/lkml/20200123153341.19947-1-will@kernel.org
v3:  https://lore.kernel.org/lkml/20200415165218.20251-1-will@kernel.org
v4:  https://lore.kernel.org/lkml/20200421151537.19241-1-will@kernel.org

The main change since v4 is that this is now based on top of the KCSAN
changes queued in -tip (locking/kcsan) and therefore contains the patches
necessary to avoid breaking sparc32 as well as some cleanups to
consolidate {READ,WRITE}_ONCE() and data_race().

Other changes include:

  * Treat 'char' as distinct from 'signed char' and 'unsigned char' for
    __builtin_types_compatible_p()

  * Add a compile-time assertion that the argument to READ_ONCE_NOCHECK()
    points at something the same size as 'unsigned long'

I'm happy for all of this to go via -tip, or I can take it via arm64.

Please let me know.

Cheers,

Will

Cc: Marco Elver <elver@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>

--->8

Will Deacon (18):
  sparc32: mm: Fix argument checking in __srmmu_get_nocache()
  sparc32: mm: Restructure sparc32 MMU page-table layout
  sparc32: mm: Change pgtable_t type to pte_t * instead of struct page *
  sparc32: mm: Reduce allocation size for PMD and PTE tables
  compiler/gcc: Raise minimum GCC version for kernel builds to 4.8
  netfilter: Avoid assigning 'const' pointer to non-const pointer
  net: tls: Avoid assigning 'const' pointer to non-const pointer
  fault_inject: Don't rely on "return value" from WRITE_ONCE()
  arm64: csum: Disable KASAN for do_csum()
  READ_ONCE: Simplify implementations of {READ,WRITE}_ONCE()
  READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses
  READ_ONCE: Drop pointer qualifiers when reading from scalar types
  locking/barriers: Use '__unqual_scalar_typeof' for load-acquire macros
  arm64: barrier: Use '__unqual_scalar_typeof' for acquire/release
    macros
  gcov: Remove old GCC 3.4 support
  kcsan: Rework data_race() so that it can be used by READ_ONCE()
  READ_ONCE: Use data_race() to avoid KCSAN instrumentation
  linux/compiler.h: Remove redundant '#else'

 Documentation/process/changes.rst   |   2 +-
 arch/arm/crypto/Kconfig             |  12 +-
 arch/arm64/include/asm/barrier.h    |  16 +-
 arch/arm64/lib/csum.c               |  20 +-
 arch/sparc/include/asm/page_32.h    |  12 +-
 arch/sparc/include/asm/pgalloc_32.h |  11 +-
 arch/sparc/include/asm/pgtable_32.h |  40 +-
 arch/sparc/include/asm/pgtsrmmu.h   |  36 +-
 arch/sparc/include/asm/viking.h     |   5 +-
 arch/sparc/kernel/head_32.S         |   8 +-
 arch/sparc/mm/hypersparc.S          |   3 +-
 arch/sparc/mm/srmmu.c               |  95 ++---
 arch/sparc/mm/viking.S              |   5 +-
 crypto/Kconfig                      |   1 -
 drivers/xen/time.c                  |   2 +-
 include/asm-generic/barrier.h       |  16 +-
 include/linux/compiler-gcc.h        |   5 +-
 include/linux/compiler.h            | 207 +++++-----
 include/linux/compiler_types.h      |  26 ++
 init/Kconfig                        |   1 -
 kernel/gcov/Kconfig                 |  24 --
 kernel/gcov/Makefile                |   3 +-
 kernel/gcov/gcc_3_4.c               | 573 ----------------------------
 lib/fault-inject.c                  |   4 +-
 net/netfilter/core.c                |   2 +-
 net/tls/tls_main.c                  |   2 +-
 scripts/gcc-plugins/Kconfig         |   2 +-
 27 files changed, 257 insertions(+), 876 deletions(-)
 delete mode 100644 kernel/gcov/gcc_3_4.c

-- 
2.26.2.645.ge9eca65c58-goog

