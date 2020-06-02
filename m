Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C35C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4B4205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591100040;
	bh=G3shmAvC/JvoxhRooWJ/NoPGmXLDXZL4OwOUhQFMNbY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=dDzJoDHf8tZKcwyAKBMbpcd91h29w3ynx0jH03T6pkW1sOvHNNWYrI3GgBZwB3IfD
	 pR1o+o3IloRe/xZ1S097gU5nmJqDqQCKvnJSDP4f+jLm7P9qZ6k2l0O/b0Va8AG9M3
	 hiczFeWzliHFfJwTRIxIERkW7tl8OR6DvVZKIN2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgFBMN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:13:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BE6C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 05:13:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y17so3132975wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 05:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xBI9buERWWZFDqQu66Y6GGKgz5PW2Y7HFNFgr8Aut3A=;
        b=PPVzWHWevmaffS7eMfTUr1eJgFbd0UlOJOClvlDKCzHFysuTvKrJxkpV8sBok/O2vy
         30BazPDNyRvO8PzO/GS5g5uTQ0fbx2asG4zpSxj4dZ4yldz8I5Vm5e/xwHvvLZJojys8
         7XKuzTA3WY+k6DU5sDy971xib2efLSuvKuiWV8bMd0xYGqNChcQj7JbYBXkLhUw7KWbT
         NBNggVcX2pBzUI7yO+Ewv1+HPIeYiCtK4h7X8ebf53PQIE4csB2nDy1nV7dLDtvpp5Xm
         zVgPI9uiSSvUq79tiPcjjAHTX79wegMPpfWGfjokZ6QQ7e5r3K62y9r61cID86ResmQx
         TQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=xBI9buERWWZFDqQu66Y6GGKgz5PW2Y7HFNFgr8Aut3A=;
        b=myfYXTEmq6lB6HywyjyJQqm1HmMmuHGK/AzCTy/br/ydDxxxx9PaeeppnAGKJNK/Ds
         /3lxp0ymSZ6Vh+ouUuO7Mc4qRyQVx0oB/OFJqNHWhUCc+UK/dMwB9KmidouKBfmI8umh
         6UA3/fH2iCcs3fK2AWYAY71X/Ih+uvu+U8KRWm4/7wXnuk48YxiMeVcI92+OO1wLB++p
         SWaTzpJbR9W+LDQbNxz3o76Yc8u0wdvj3EBNrgl0C+z1EDAzyJ67mByZrzFIiKVpCNp3
         Le+BvgZlsFR1bKaIsMr/DAKW7QtVzewGlrx29c//JtI1naiH2ad9cKu7soxCGmMpuO+3
         802g==
X-Gm-Message-State: AOAM532QrBRWw1HzRrypjt5Cm0oj1sFNxhJFcEXl9oSlATEmPc5ZZpXP
        0txLzJ5vG4vJUS0tMyq746zTEn2T
X-Google-Smtp-Source: ABdhPJzYq1eZn+zdAEY44HfhIhzu6xrFRUXW/dnkrFGoRtqml/eOy+HeZoe+0EvQSNP3pLdNc1XmJA==
X-Received: by 2002:a5d:6b85:: with SMTP id n5mr25961771wrx.11.1591100036585;
        Tue, 02 Jun 2020 05:13:56 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id z6sm3437008wrh.79.2020.06.02.05.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 05:13:55 -0700 (PDT)
Date:   Tue, 2 Jun 2020 14:13:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler changes for v5.8
Message-ID: <20200602121352.GA3812351@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2020-06-02

   # HEAD: 25de110d148666752dc0e0da7a0b69de31cd7098 irq_work: Define irq_work_single() on !CONFIG_IRQ_WORK too

The changes in this cycle are:

 - Optimize the task wakeup CPU selection logic, to improve scalability and
   reduce wakeup latency spikes

 - PELT enhancements

 - CFS bandwidth handling fixes

 - Optimize the wakeup path by remove rq->wake_list and replacing it with ->ttwu_pending

 - Optimize IPI cross-calls by making flush_smp_call_function_queue()
   process sync callbacks first.

 - Misc fixes and enhancements.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Chen Yu (2):
      sched: Make newidle_balance() static again
      sched: Extract the task putting code from pick_next_task()

Davidlohr Bueso (1):
      sched/swait: Reword some of the main description

Gustavo A. R. Silva (1):
      sched/fair: Replace zero-length array with flexible-array

Huaixin Chang (2):
      sched/fair: Refill bandwidth before scaling
      sched: Defend cfs and rt bandwidth quota against overflow

Ingo Molnar (4):
      Merge branch 'sched/urgent' into sched/core, to pick up fix
      Merge branch 'core/rcu' into sched/core, to pick up dependency
      sched/headers: Split out open-coded prototypes into kernel/sched/smp.h
      irq_work: Define irq_work_single() on !CONFIG_IRQ_WORK too

Jann Horn (1):
      exit: Move preemption fixup up, move blocking operations down

Josh Don (1):
      sched/fair: Remove distribute_running from CFS bandwidth

Mel Gorman (1):
      sched/core: Offload wakee task activation if it the wakee is descheduling

Muchun Song (4):
      sched/fair: Mark sched_init_granularity __init
      sched/fair: Use __this_cpu_read() in wake_wide()
      sched/cpuacct: Use __this_cpu_add() instead of this_cpu_ptr()
      sched/cpuacct: Fix charge cpuacct.usage_sys

Paul Turner (1):
      sched/fair: Eliminate bandwidth race between throttling and distribution

Peng Wang (1):
      sched/fair: Simplify the code of should_we_balance()

Peter Zijlstra (10):
      sched/core: Fix illegal RCU from offline CPUs
      Merge branch 'sched/urgent'
      sched/core: Optimize ttwu() spinning on p->on_cpu
      sched: Fix smp_call_function_single_async() usage for ILB
      smp: Optimize flush_smp_call_function_queue()
      smp: Move irq_work_run() out of flush_smp_call_function_queue()
      smp: Optimize send_call_function_single_ipi()
      irq_work, smp: Allow irq_work on call_single_queue
      sched: Add rq::ttwu_pending
      sched: Replace rq::wake_list

Peter Zijlstra (Intel) (1):
      sched: Clean up scheduler_ipi()

Thomas Gleixner (1):
      sched: Make scheduler_ipi inline

Valentin Schneider (4):
      sched/fair: find_idlest_group(): Remove unused sd_flag parameter
      sched/debug: Make sd->flags sysctl read-only
      sched: Remove checks against SD_LOAD_BALANCE
      sched/topology: Kill SD_LOAD_BALANCE

Vincent Guittot (2):
      sched/fair: Optimize enqueue_task_fair()
      sched/pelt: Sync util/runnable_sum with PELT window when propagating

Wei Yang (1):
      sched/core: Simplify sched_init()

Xie XiuQi (1):
      sched/debug: Fix trival print_task() format

 arch/powerpc/platforms/powernv/smp.c |   1 -
 include/linux/irq_work.h             |   9 +++++++-
 include/linux/sched.h                |  11 +++++++++-
 include/linux/sched/mm.h             |   2 ++
 include/linux/sched/topology.h       |  29 +++++++++++++-------------
 include/linux/smp.h                  |  24 +++++++++++++++++++++-
 include/linux/swait.h                |  23 +++++----------------
 kernel/cpu.c                         |  18 +++++++++++++++-
 kernel/exit.c                        |  25 +++++++++++++++--------
 kernel/irq_work.c                    |  53 +++++++++++++++++++++++++----------------------
 kernel/sched/core.c                  | 248 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------------------------------------------------
 kernel/sched/cpuacct.c               |   7 ++++---
 kernel/sched/debug.c                 |   9 ++++----
 kernel/sched/fair.c                  | 259 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------------------------------------------
 kernel/sched/idle.c                  |   6 +++++-
 kernel/sched/pelt.c                  |  24 ++++++++++++++++++++++
 kernel/sched/rt.c                    |  12 ++++++++++-
 kernel/sched/sched.h                 |  36 +++++++++++++++-----------------
 kernel/sched/smp.h                   |   9 ++++++++
 kernel/sched/topology.c              |  31 +++++++++-------------------
 kernel/smp.c                         | 175 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------
 21 files changed, 603 insertions(+), 408 deletions(-)
 create mode 100644 kernel/sched/smp.h
