Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B42C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E82207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591017363;
	bh=/OJXmtcyoFp2YZGwwsAV03fmikGfP37v1fG8rm6v7k8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CnNv40HQCqB01GMVZ+f+Thxn/+o0Tt7GgJxB8C2IQHsJZZyVt6Tbtqmc++fRITHP3
	 UfffztYq9ORATTuIVZ5j4lqEU9h2KswJURYrhHOF7HSYlfo0Yvw+iQmAmeq8uCX/dJ
	 V1rW2WKfR8uVzVU/59CGbzAoDows/fCkOjZrkZew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgFANQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgFANQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:16:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AA9C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 06:16:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u13so10661919wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=rTSMyP3WkoqTJ64BILO9HTYati98FSWh7Wp6zAQzMnI=;
        b=GXmN+jnlN3utoFLZcIQ/doMFGNx8ZJe6fV/q1VUooF1vMxkiclkuZAHqyIyWQKeLWd
         vYjgkNi5giu/QzsGtCrkWPGTPC4AmMoALTDn2dT9PLKsZydW5cff3yretUDkzJ/WXM1g
         CIfkyYdV/zNKSFZnKCvLxGoxuosn5zh33KBX7eodLbdSy2eMjQ3gEq31yuoq4zIRWcOd
         KZGueCLwhbtxnGdbTnV8Yv4pzwx5RqiT5nVO9cwmeO9QHaTgCR1rfRX7+++Qasi1Wntc
         dXSXrWDCKRhxde5s72XEok72wkRg1zDs38cKBfr15KnS1EiR6zbHY+foU90ozW0a57yf
         P5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=rTSMyP3WkoqTJ64BILO9HTYati98FSWh7Wp6zAQzMnI=;
        b=km5KvR8TvK9lSRhANprk5O1kVAvgg3ZT2O2RHfiR5rAJUb8T5ooKQ2A7i/EDsNGK5m
         91hsyd2myQPDRUl/3ilNLdpc+0GQYZjxIrlYDxIeSh066BVV8rVN1rU0tIGQOmbYwMiz
         J///J7xDQ4d8mSZRH6L3/HHzd7oeM6cjAVqW228zjLBwu0b6ggi4cBIIgQ/gOdnwndRx
         nou3PiCmPih+oB5hjYBYZV/YIHfzxWT4B+nzgesRWWzemlEaLIt5GGIZTXwwlByQ+XSm
         9wH7Gcg3+nriwXh/s/PdJCqHAV3HVto7Vb/fOCyKKC3euk4ty8zfEHAJhSbSLuiAiaAq
         sP3g==
X-Gm-Message-State: AOAM530D2VABvARKDEGRIevwNIJqNVj7o2hvm9d5Wg9m7PlC6fAiEbYU
        gYsDikh/Nkort1MoFA1Sqnw=
X-Google-Smtp-Source: ABdhPJxToU4VrrXYSpzJcBglqR389J29PXaMZybod6ATtyTfvd2ImlIpdXrOdxpY2J9Urx3fqIZMbg==
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr21591384wme.84.1591017360395;
        Mon, 01 Jun 2020 06:16:00 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a1sm11105382wmj.29.2020.06.01.06.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 06:15:59 -0700 (PDT)
Date:   Mon, 1 Jun 2020 15:15:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RCU updates for v5.8
Message-ID: <20200601131557.GA756658@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core/rcu git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2020-06-01

   # HEAD: cb3cb6733fbd8fd8d2c716095fdca42dadba2063 Merge branch 'WIP.core/rcu' into core/rcu, to pick up two x86/entry dependencies

The RCU updates for this cycle were:

 - RCU-tasks update, including addition of RCU Tasks Trace for
   BPF use and TASKS_RUDE_RCU
 - kfree_rcu() updates.
 - Remove scheduler locking restriction
 - RCU CPU stall warning updates.
 - Torture-test updates.
 - Miscellaneous fixes and other updates.

Dependency warning/note: this tree pulled in the kprobes changes that 
I sent a couple of minutes ago.

 Thanks,

	Ingo

------------------>
Frederic Weisbecker (1):
      arm64: Prepare arch_nmi_enter() for recursion

Jason Yan (1):
      rcutorture: Make rcu_fwds and rcu_fwd_emergency_stop static

Joel Fernandes (Google) (3):
      rcuperf: Add ability to increase object allocation size
      rcu/tree: Add a shrinker to prevent OOM due to kfree_rcu() batching
      rcu/tree: Count number of batched kfree_rcu() locklessly

Jonathan Neuschäfer (1):
      Revert "rculist: Describe variadic macro argument in a Sphinx-compatible way"

Jules Irenge (2):
      rcu: Replace assigned pointer ret value by corresponding boolean value
      rcu: Replace 1 by true

Lai Jiangshan (3):
      rcu: Don't set nesting depth negative in rcu_preempt_deferred_qs()
      rcu: Remove unused ->rcu_read_unlock_special.b.deferred_qs field
      rcu: Don't use negative nesting depth in __rcu_read_unlock()

Mauro Carvalho Chehab (1):
      rcu: Get rid of some doc warnings in update.c

Paul E. McKenney (75):
      rcu: Add KCSAN stubs
      srcu: Add KCSAN stubs
      rcu: Mark rcu_state.ncpus to detect concurrent writes
      rcu: Add *_ONCE() and data_race() to rcu_node ->exp_tasks plus locking
      rcu: Add READ_ONCE and data_race() to rcu_node ->boost_tasks
      srcu: Add data_race() to ->srcu_lock_count and ->srcu_unlock_count arrays
      rcu: Add WRITE_ONCE() to rcu_node ->boost_tasks
      rcu: Use data_race() for RCU CPU stall-warning prints
      drm: Make drm_dp_mst_dsc_aux_for_port() safe for old compilers
      rcu: Expedite first two FQS scans under callback-overload conditions
      rcu: Mark rcu_state.gp_seq to detect more concurrent writes
      rcu: Convert ULONG_CMP_GE() to time_after() for jiffy comparison
      rcu: Convert rcu_initiate_boost() ULONG_CMP_GE() to time_after()
      rcu: Convert rcu_nohz_full_cpu() ULONG_CMP_LT() to time_before()
      rcu: Add rcu_gp_might_be_stalled()
      rcu: Add KCSAN stubs to update.c
      rcu: Make rcu_read_unlock_special() safe for rq/pi locks
      rcutorture: Add test of holding scheduler locks across rcu_read_unlock()
      rcu: Add comments marking transitions between RCU watching and not
      rcu-tasks: Use context-switch hook for PREEMPT=y kernels
      sched/core: Add function to sample state of locked-down task
      rcu: Add per-task state to RCU CPU stall warnings
      rcu-tasks: Move Tasks RCU to its own file
      rcu-tasks: Create struct to hold state information
      rcu: Reinstate synchronize_rcu_mult()
      rcutorture: Add a test for synchronize_rcu_mult()
      rcu-tasks: Refactor RCU-tasks to allow variants to be added
      rcu-tasks: Add an RCU-tasks rude variant
      rcutorture: Add torture tests for RCU Tasks Rude
      rcu-tasks: Use unique names for RCU-Tasks kthreads and messages
      rcu-tasks: Further refactor RCU-tasks to allow adding more variants
      rcu-tasks: Code movement to allow more Tasks RCU variants
      rcu-tasks: Add an RCU Tasks Trace to simplify protection of tracing hooks
      rcutorture: Add torture tests for RCU Tasks Trace
      rcu-tasks: Add stall warnings for RCU Tasks Trace
      rcu-tasks: Move #ifdef into tasks.h
      rcu-tasks: Add RCU tasks to rcutorture writer stall output
      rcu-tasks: Make rcutorture writer stall output include GP state
      rcu-tasks: Make RCU Tasks Trace make use of RCU scheduler hooks
      rcu-tasks: Add a grace-period start time for throttling and debug
      rcu-tasks: Provide boot parameter to delay IPIs until late in grace period
      rcu-tasks: Split ->trc_reader_need_end
      rcu-tasks: Add grace-period and IPI counts to statistics
      rcu-tasks: Add Kconfig option to mediate smp_mb() vs. IPI
      rcu-tasks: Avoid IPIing userspace/idle tasks if kernel is so built
      rcu-tasks: Allow rcu_read_unlock_trace() under scheduler locks
      rcu-tasks: Disable CPU hotplug across RCU tasks trace scans
      rcu-tasks: Handle the running-offline idle-task special case
      rcu-tasks: Make RCU tasks trace also wait for idle tasks
      rcu-tasks: Add rcu_dynticks_zero_in_eqs() effectiveness statistics
      rcu-tasks: Add count for idle tasks on offline CPUs
      rcutorture: Add TRACE02 scenario enabling RCU Tasks Trace IPIs
      rcu-tasks: Add IPI failure count to statistics
      rcu-tasks: Allow standalone use of TASKS_{TRACE_,}RCU
      ftrace: Use synchronize_rcu_tasks_rude() instead of ftrace_sync()
      rcu: Use data_race() for RCU expedited CPU stall-warning prints
      rcu: When GP kthread is starved, tag idle threads as false positives
      rcu: Remove self-stack-trace when all quiescent states seen
      rcutorture: Add KCSAN stubs
      rcutorture: Make kvm-recheck-rcu.sh handle truncated lines
      rcutorture: Mark data-race potential for rcu_barrier() test statistics
      rcutorture: Add flag to produce non-busy-wait task stalls
      rcutorture: Right-size TREE10 CPU consumption
      rcu: Allow rcutorture to starve grace-period kthread
      torture: Add --kcsan argument to top-level kvm.sh script
      torture: Make --kcsan argument also create a summary
      torture: Eliminate duplicate #CHECK# from ConfigFragment
      torture: Abstract application of additional Kconfig options
      torture: Allow --kconfig options to override --kcsan defaults
      torture: Allow scenario-specific Kconfig options to override CFcommon
      torture: Save a few lines by using config_override_param initially
      torture: Add a --kasan argument
      rcutorture: Convert ULONG_CMP_LT() to time_before()
      rcu: Make RCU IRQ enter/exit functions rely on in_nmi()
      rcu: Abstract out rcu_irq_enter_check_tick() from rcu_nmi_enter()

Peter Zijlstra (8):
      printk: Disallow instrumenting print_nmi_enter()
      hardirq/nmi: Allow nested nmi_enter()
      lockdep: Always inline lockdep_{off,on}()
      sh/ftrace: Move arch_ftrace_nmi_{enter,exit} into nmi exception
      sched,rcu,tracing: Avoid tracing before in_nmi() is correct
      x86/mce: Send #MC singal from task work
      x86: Replace ist_enter() with nmi_enter()
      rcu: Allow for smp_call_function() running callbacks from idle

Petr Mladek (1):
      printk: Prepare for nested printk_nmi_enter()

Randy Dunlap (1):
      locktorture.c: Fix if-statement empty body warnings

Thomas Gleixner (6):
      vmlinux.lds.h: Create section for protection against instrumentation
      x86/entry: Get rid of ist_begin/end_non_atomic()
      rcu/tree: Mark the idle relevant functions noinstr
      rcu: Provide rcu_irq_exit_preempt()
      rcu: Provide __rcu_is_watching()
      rcu: Provide rcu_irq_exit_check_preempt()

Zhaolong Zhang (1):
      rcu: Fix the (t=0 jiffies) false positive


 .../RCU/Design/Requirements/Requirements.rst       |   61 +-
 Documentation/admin-guide/kernel-parameters.txt    |   19 +
 Documentation/trace/ftrace-design.rst              |    8 -
 arch/arm64/include/asm/hardirq.h                   |   78 +-
 arch/arm64/kernel/sdei.c                           |   14 +-
 arch/arm64/kernel/traps.c                          |    8 +-
 arch/powerpc/kernel/traps.c                        |   22 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |    1 +
 arch/sh/Kconfig                                    |    1 -
 arch/sh/kernel/traps.c                             |   12 +
 arch/x86/include/asm/traps.h                       |    5 -
 arch/x86/kernel/cpu/mce/core.c                     |   65 +-
 arch/x86/kernel/cpu/mce/p5.c                       |    5 +-
 arch/x86/kernel/cpu/mce/winchip.c                  |    5 +-
 arch/x86/kernel/traps.c                            |  108 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |    2 +-
 include/asm-generic/sections.h                     |    3 +
 include/asm-generic/vmlinux.lds.h                  |   10 +
 include/linux/compiler.h                           |   53 +
 include/linux/compiler_types.h                     |    4 +
 include/linux/ftrace_irq.h                         |   11 -
 include/linux/hardirq.h                            |   47 +-
 include/linux/lockdep.h                            |   23 +-
 include/linux/preempt.h                            |    4 +-
 include/linux/rculist.h                            |    4 +-
 include/linux/rcupdate.h                           |   53 +-
 include/linux/rcupdate_trace.h                     |   88 ++
 include/linux/rcupdate_wait.h                      |   19 +
 include/linux/rcutiny.h                            |    6 +-
 include/linux/rcutree.h                            |    9 +
 include/linux/sched.h                              |   16 +-
 include/linux/torture.h                            |    2 +-
 include/linux/wait.h                               |    2 +
 init/init_task.c                                   |    5 +
 kernel/fork.c                                      |    5 +
 kernel/locking/lockdep.c                           |   19 -
 kernel/printk/internal.h                           |    8 +-
 kernel/printk/printk_safe.c                        |    9 +-
 kernel/rcu/Kconfig                                 |   46 +-
 kernel/rcu/Kconfig.debug                           |    4 +
 kernel/rcu/rcu.h                                   |    7 +
 kernel/rcu/rcuperf.c                               |    5 +-
 kernel/rcu/rcutorture.c                            |  155 ++-
 kernel/rcu/srcutree.c                              |   21 +-
 kernel/rcu/tasks.h                                 | 1193 ++++++++++++++++++++
 kernel/rcu/tree.c                                  |  401 +++++--
 kernel/rcu/tree.h                                  |    3 +
 kernel/rcu/tree_exp.h                              |   50 +-
 kernel/rcu/tree_plugin.h                           |   90 +-
 kernel/rcu/tree_stall.h                            |  144 ++-
 kernel/rcu/update.c                                |  397 +------
 kernel/sched/core.c                                |   48 +
 kernel/trace/Kconfig                               |   11 +-
 kernel/trace/ftrace.c                              |   17 +-
 scripts/mod/modpost.c                              |    2 +-
 .../selftests/rcutorture/bin/kcsan-collapse.sh     |   22 +
 .../selftests/rcutorture/bin/kvm-recheck-rcu.sh    |   16 +-
 .../selftests/rcutorture/bin/kvm-recheck.sh        |    9 +
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |   52 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   11 +
 .../selftests/rcutorture/configs/rcu/CFLIST        |    3 +
 .../selftests/rcutorture/configs/rcu/RUDE01        |   10 +
 .../selftests/rcutorture/configs/rcu/RUDE01.boot   |    1 +
 .../selftests/rcutorture/configs/rcu/TRACE01       |   11 +
 .../selftests/rcutorture/configs/rcu/TRACE01.boot  |    1 +
 .../selftests/rcutorture/configs/rcu/TRACE02       |   11 +
 .../selftests/rcutorture/configs/rcu/TRACE02.boot  |    1 +
 .../selftests/rcutorture/configs/rcu/TREE10        |    2 +-
 68 files changed, 2609 insertions(+), 949 deletions(-)
 create mode 100644 include/linux/rcupdate_trace.h
 create mode 100644 kernel/rcu/tasks.h
 create mode 100755 tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/RUDE01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE02
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
