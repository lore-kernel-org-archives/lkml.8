Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F4DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC7C2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596455681;
	bh=EI4p1BbZUxdDlpHk3GIOu2bieJCk6i9KM700Kwu7gOs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Hd9OaKyND6LDLWE7mgOW9FhXkWOrHuLJR1S22uKsIwGJBcTGdHczLX6KVLl3AaRdf
	 LR0LQRtQus6OtraTITcC52LY7PrIYNxW/Agyo0OqmoioA235pjW7oCUKg0FOb5/6JK
	 2tVGDC5cA8Z4NVU/Ru6LpzxNEizwGAcgU3mLde2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgHCLyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHCLyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:54:21 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA866C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 04:54:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a14so10025586edx.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=ARqqxqNWFoOgGhRtSFM8Pj445jNew1h1JU2Miq3Lcr0=;
        b=tKH2TFsZrIiwgrnh6ZD8YnI3Gfty9E0tAzAFQo5qsut73yX7iylrRvfr8d6cRoM1B8
         xLPdstOfJAfLUK8+Ic0KdJ4ZtbETxnLI4GQro2svU0TA8IZONwA3s77GLtAT9sQGxXVV
         AJlOo95XwbOSX9VpGzTElbyA+uun5+PzPAFEA+yddGorshSIcC6nSTf6GS/yqDb2sQqd
         r31WyZPR/TmoMlYKw6OhYEFi13VX05u750k6CVEJsApOQjnMoX0P5WH04SQPosQ1K0Vn
         /gZHMWdqzZZgLvgPlkIxPCDyTHhS4tF7eORh8l+1F1P9+hYhot1SPEVmV1bhp3atqmSa
         YfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=ARqqxqNWFoOgGhRtSFM8Pj445jNew1h1JU2Miq3Lcr0=;
        b=HxeppZ0FNYzHrYvKjdwm67woswbpqko2iOoQvRy51pjssuv+MhvrEsRQDy5QFmhDvC
         qTLNcFE7olVYwsS7P1AfGSdgiTzu/5kd2877IVP7/hRTtnMdpmq6f866vZ3FQpIL5s4Y
         UgQmwScVfXR1BkvGE+vDL6BxS/jSXsea9lq32laswz7i5oCAi6KX93kYovaAxgSvzhri
         fiXIuOc06VNfwIfRsR80QbT4LiD63oC0Tivj9RFfBTovBTQHNuBiV8LLADHgqujqN7V4
         DF5dWzGs1sDkTzYL/qplguQzPWgXbCi0D/nhs1YnZw0pOeu5T4ES2NAuXwPC5B48fbQv
         oNlQ==
X-Gm-Message-State: AOAM533TGbxEW9yR39XJ8/GIB6RvsgxzGazZGM0ZrMI7DrNIjWJmBX07
        V+K4nlotzeqcCskV+ICJv6sgQdVJ
X-Google-Smtp-Source: ABdhPJyGzerk6t5fAdmuAZyBhUAwpw0vELnoEqWaLAAKUDwxwbiz/4gHXNnDGvoQ+P7I8Agyva+JSQ==
X-Received: by 2002:a05:6402:456:: with SMTP id p22mr14982897edw.177.1596455659437;
        Mon, 03 Aug 2020 04:54:19 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e13sm15737703eds.46.2020.08.03.04.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 04:54:18 -0700 (PDT)
Date:   Mon, 3 Aug 2020 13:54:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v5.9
Message-ID: <20200803115416.GA506583@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2020-08-03

   # HEAD: 992414a18cd4de05fa3f8ff7e1c29af758bdee1a Merge branch 'locking/nmi' into locking/core, to pick up completed topic branch

These were the main changes in this cycle:

 - LKMM updates: mostly documentation changes, but also some new litmus tests for atomic ops.

 - KCSAN updates: the most important change is that GCC 11 now has all fixes in place
                  to support KCSAN, so GCC support can be enabled again. Also more annotations.

 - futex updates: minor cleanups and simplifications

 - seqlock updates: merge preparatory changes/cleanups for the 'associated locks' facilities.

 - lockdep updates:
    - simplify IRQ trace event handling
    - add various new debug checks
    - simplify header dependencies, split out <linux/lockdep_types.h>, decouple
      lockdep from other low level headers some more
    - fix NMI handling

 - misc cleanups and smaller fixes

 Thanks,

	Ingo

------------------>
Ahmed S. Darwish (8):
      Documentation: locking: Describe seqlock design and usage
      seqlock: Properly format kernel-doc code samples
      seqlock: seqcount_t latch: End read sections with read_seqcount_retry()
      seqlock: Reorder seqcount_t and seqlock_t API definitions
      seqlock: Add kernel-doc for seqcount_t and seqlock_t APIs
      seqlock: Implement raw_seqcount_begin() in terms of raw_read_seqcount()
      lockdep: Add preemption enabled/disabled assertion APIs
      seqlock: lockdep assert non-preemptibility on seqcount_t write

Akira Yokosawa (5):
      tools/memory-model: Fix reference to litmus test in recipes.txt
      Documentation/litmus-tests: Merge atomic's README into top-level one
      tools/memory-model/README: Expand dependency of klitmus7
      tools/memory-model/README: Mention herdtools7 7.56 in compatibility table
      Documentation/litmus-tests: Add note on herd7 7.56 in atomic litmus test

Alexander A. Klimov (1):
      docs: locking: Replace HTTP links with HTTPS ones

Alexey Dobriyan (1):
      rwsem: fix commas in initialisation

André Almeida (4):
      futex: Remove put_futex_key()
      futex: Remove needless goto's
      futex: Consistently use fshared as boolean
      futex: Remove unused or redundant includes

Andy Lutomirski (1):
      x86/entry: Rename idtentry_enter/exit_cond_rcu() to idtentry_enter/exit()

Boqun Feng (4):
      tools/memory-model: Add an exception for limitations on _unless() family
      Documentation/litmus-tests: Introduce atomic directory
      Documentation/litmus-tests/atomic: Add a test for atomic_set()
      Documentation/litmus-tests/atomic: Add a test for smp_mb__after_atomic()

Herbert Xu (5):
      lockdep: Split header file into lockdep and lockdep_types
      lockdep: Move list.h inclusion into lockdep.h
      lockdep: Move list.h inclusion into lockdep.h
      locking/atomic: Move ATOMIC_INIT into linux/types.h
      locking/qspinlock: Do not include atomic.h from qspinlock_types.h

Joel Fernandes (Google) (4):
      Documentation: LKMM: Add litmus test for RCU GP guarantee where updater frees object
      Documentation: LKMM: Add litmus test for RCU GP guarantee where reader stores
      MAINTAINERS: Update maintainers for new Documentation/litmus-tests
      Documentation/litmus-tests: Cite an RCU litmus test

Marco Elver (13):
      kcsan: Add test suite
      kcsan: Prefer '__no_kcsan inline' in test
      kcsan: Silence -Wmissing-prototypes warning with W=1
      kcsan: Rename test.c to selftest.c
      kcsan: Remove existing special atomic rules
      kcsan: Add jiffies test to test suite
      kcsan: Re-add GCC as a supported compiler
      kcsan: Simplify compiler flags
      kcsan: Disable branch tracing in core runtime
      tools/memory-model: Fix "conflict" definition
      kcsan: Make KCSAN compatible with new IRQ state tracking
      lockdep: Refactor IRQ trace events fields into struct
      kcsan: Improve IRQ state trace reporting

Paul E. McKenney (2):
      rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init_rcu()
      tools/memory-model: Add recent references

Peter Zijlstra (8):
      sparc64: Fix asm/percpu.h build error
      lockdep: Prepare for NMI IRQ state tracking
      powerpc64: Break asm/percpu.h vs spinlock_types.h dependency
      x86/entry: Fix NMI vs IRQ state tracking
      s390: Break cyclic percpu include
      arm: Break cyclic percpu include
      lockdep: Change hardirq{s_enabled,_context} to per-cpu variables
      lockdep: Remove lockdep_hardirq{s_enabled,_context}() argument

Qian Cai (3):
      fork: Annotate a data race in vm_area_dup()
      x86/mm/pat: Mark an intentional data race
      locking/osq_lock: Annotate a data race in osq_lock

peterz@infradead.org (1):
      locking/lockdep: Fix TRACE_IRQFLAGS vs. NMIs


 Documentation/atomic_t.txt                         |   24 +-
 Documentation/dev-tools/kcsan.rst                  |    3 +-
 Documentation/litmus-tests/README                  |   35 +
 ...b__after_atomic-is-stronger-than-acquire.litmus |   32 +
 ...Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus |   25 +
 .../litmus-tests/rcu/RCU+sync+free.litmus          |   42 +
 .../litmus-tests/rcu/RCU+sync+read.litmus          |   37 +
 Documentation/locking/index.rst                    |    1 +
 Documentation/locking/mutex-design.rst             |    2 +-
 Documentation/locking/seqlock.rst                  |  170 +++
 MAINTAINERS                                        |    2 +
 arch/alpha/include/asm/atomic.h                    |    1 -
 arch/arc/include/asm/atomic.h                      |    2 -
 arch/arm/include/asm/atomic.h                      |    2 -
 arch/arm/include/asm/percpu.h                      |    2 +-
 arch/arm/include/asm/thread_info.h                 |    5 -
 arch/arm64/include/asm/atomic.h                    |    2 -
 arch/h8300/include/asm/atomic.h                    |    2 -
 arch/hexagon/include/asm/atomic.h                  |    2 -
 arch/ia64/include/asm/atomic.h                     |    1 -
 arch/m68k/include/asm/atomic.h                     |    2 -
 arch/mips/include/asm/atomic.h                     |    1 -
 arch/parisc/include/asm/atomic.h                   |    2 -
 arch/powerpc/include/asm/atomic.h                  |    2 -
 arch/powerpc/include/asm/dtl.h                     |   52 +
 arch/powerpc/include/asm/lppaca.h                  |   44 -
 arch/powerpc/include/asm/paca.h                    |    2 +-
 arch/powerpc/kernel/time.c                         |    2 +
 arch/powerpc/kvm/book3s_hv.c                       |    1 +
 arch/powerpc/platforms/pseries/dtl.c               |    1 +
 arch/powerpc/platforms/pseries/lpar.c              |    1 +
 arch/powerpc/platforms/pseries/setup.c             |    1 +
 arch/powerpc/platforms/pseries/svm.c               |    1 +
 arch/riscv/include/asm/atomic.h                    |    2 -
 arch/s390/include/asm/atomic.h                     |    2 -
 arch/s390/include/asm/smp.h                        |    1 +
 arch/s390/include/asm/thread_info.h                |    1 -
 arch/sh/include/asm/atomic.h                       |    2 -
 arch/sparc/include/asm/atomic_32.h                 |    2 -
 arch/sparc/include/asm/atomic_64.h                 |    1 -
 arch/sparc/include/asm/percpu_64.h                 |    2 +
 arch/sparc/include/asm/trap_block.h                |    2 +
 arch/x86/Kconfig.debug                             |    3 +
 arch/x86/entry/common.c                            |   88 +-
 arch/x86/include/asm/atomic.h                      |    2 -
 arch/x86/include/asm/idtentry.h                    |   31 +-
 arch/x86/kernel/kvm.c                              |    6 +-
 arch/x86/kernel/nmi.c                              |    9 +-
 arch/x86/kernel/traps.c                            |   23 +-
 arch/x86/mm/fault.c                                |    6 +-
 arch/x86/mm/pat/set_memory.c                       |    2 +-
 arch/xtensa/include/asm/atomic.h                   |    2 -
 include/asm-generic/atomic.h                       |    2 -
 include/asm-generic/qspinlock.h                    |    1 +
 include/asm-generic/qspinlock_types.h              |    8 -
 include/linux/hardirq.h                            |   28 +-
 include/linux/irqflags.h                           |   36 +-
 include/linux/lockdep.h                            |  230 +---
 include/linux/lockdep_types.h                      |  194 ++++
 include/linux/rculist.h                            |    2 +
 include/linux/rwsem.h                              |   20 +-
 include/linux/sched.h                              |   17 +-
 include/linux/seqlock.h                            |  756 ++++++++-----
 include/linux/spinlock.h                           |    1 +
 include/linux/spinlock_types.h                     |    2 +-
 include/linux/types.h                              |    2 +
 kernel/fork.c                                      |   28 +-
 kernel/futex.c                                     |  114 +-
 kernel/kcsan/Makefile                              |    9 +-
 kernel/kcsan/atomic.h                              |    6 +-
 kernel/kcsan/core.c                                |   37 +-
 kernel/kcsan/kcsan-test.c                          | 1107 ++++++++++++++++++++
 kernel/kcsan/kcsan.h                               |    7 +
 kernel/kcsan/report.c                              |   12 +-
 kernel/kcsan/{test.c => selftest.c}                |    0
 kernel/locking/lockdep.c                           |  142 ++-
 kernel/locking/osq_lock.c                          |    6 +-
 kernel/softirq.c                                   |    8 +-
 lib/Kconfig.debug                                  |    7 +
 lib/Kconfig.kcsan                                  |   26 +-
 scripts/Makefile.kcsan                             |    2 +-
 tools/include/linux/irqflags.h                     |    4 +-
 tools/memory-model/Documentation/explanation.txt   |   83 +-
 tools/memory-model/Documentation/recipes.txt       |    2 +-
 tools/memory-model/Documentation/references.txt    |   21 +-
 tools/memory-model/README                          |   40 +-
 86 files changed, 2797 insertions(+), 854 deletions(-)
 create mode 100644 Documentation/litmus-tests/README
 create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
 create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU+sync+free.litmus
 create mode 100644 Documentation/litmus-tests/rcu/RCU+sync+read.litmus
 create mode 100644 Documentation/locking/seqlock.rst
 create mode 100644 arch/powerpc/include/asm/dtl.h
 create mode 100644 include/linux/lockdep_types.h
 create mode 100644 kernel/kcsan/kcsan-test.c
 rename kernel/kcsan/{test.c => selftest.c} (100%)
