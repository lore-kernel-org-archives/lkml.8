Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B23C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AB120825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="LRzmTpIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgH1TwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1TwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A76C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:16 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g72so125889qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5aT8gvzRTup8Zb6zdxc2wL8uOJ3bAFHBHAaX4bpjbY=;
        b=LRzmTpIctRWl+HrjNqShUViaPRLF0f83cHgEbQVo7yCLkbV8pTmQ31/zX0xILsuhSg
         GaAekyO7I1owAVWNKbx9y+7YtKwRB81CRoNhxUKNlaIQPAkZp8SDQPKgbSw+/wGZRihD
         P+Muq7g4AFDEKHI1ZdL63T3LfuRKmIRlcrcvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5aT8gvzRTup8Zb6zdxc2wL8uOJ3bAFHBHAaX4bpjbY=;
        b=bAGzgdS+++yRpiAedukO9s4CLMu8O9MM0kk0QDVM8BT15DYFRGDfLYIGrBKgLmpjcW
         E4G/tTGFYsfm3+b9RQOhXw0XLV8UE3qrCb0i4+Nzpxdc1rKbujmyCcgIPuD0FJOzSDVS
         l3jyrs/VtgcCBIDaFIyyaKPzuK5PJeGtv83d25/QW3rEWKa9g37FeGcwtlH3OA9wDw1T
         fEra2r8/5j4JsU0bfYpJN/zPfnHy52Eo0F+I9dyvF+0MJu1rPuIEOjkr2J0b6bCZ2E+c
         kcxyb61XnQtSeKKOMBCg9OCTPB0vQ+BcT8tF1mbQxo7goIQAn/fPkQtQC01R3dMq6RFv
         ADmw==
X-Gm-Message-State: AOAM5314T7HsEzZZcPZgpCyfURr4mTt/ZSIzdzPudh8UWFnWiu5uBh38
        h8VGXoPh963PcWQLha4UljOBNQ==
X-Google-Smtp-Source: ABdhPJz7ZyzeTqFwZQ9PH/FUVhVjv0XkRlygcFYUnaHU7KuyqdYbUONQXLEUuFQ6pLI+ORKtbXhEDA==
X-Received: by 2002:a37:a8d6:: with SMTP id r205mr746826qke.367.1598644335224;
        Fri, 28 Aug 2020 12:52:15 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:14 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
Subject: [RFC PATCH v7 00/23] Core scheduling v7
Date:   Fri, 28 Aug 2020 15:51:01 -0400
Message-Id: <cover.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seventh iteration of the Core-Scheduling feature.

(Note that this iteration is a repost of the combined v6 and v6+ series,
and does not include the new interface discussed at LPC).

Core scheduling is a feature that allows only trusted tasks to run
concurrently on cpus sharing compute resources (eg: hyperthreads on a
core). The goal is to mitigate the core-level side-channel attacks
without requiring to disable SMT (which has a significant impact on
performance in some situations). Core scheduling (as of v7) mitigates
user-space to user-space attacks and user to kernel attack when one of
the siblings enters the kernel via interrupts or system call.

By default, the feature doesn't change any of the current scheduler
behavior. The user decides which tasks can run simultaneously on the
same core (for now by having them in the same tagged cgroup). When a tag
is enabled in a cgroup and a task from that cgroup is running on a
hardware thread, the scheduler ensures that only idle or trusted tasks
run on the other sibling(s). Besides security concerns, this feature can
also be beneficial for RT and performance applications where we want to
control how tasks make use of SMT dynamically.

This iteration focuses on the kernel protection when kernel runs along
with untrusted user mode tasks on a core. This was a main gap in the
security aspects provided by core scheduling feature in mitigating the
side-channel attacks. In v6, we had a minimal version where kernel was
protected from untrusted tasks when a sibling enters the kernel via
irq/softirq. System calls were not protected in the v6 patch and the
implementation had corner cases.  With this iteration, user mode tasks
running on siblings in a core are paused until the last sibling exits
kernel and thus guarantees that kernel code does not run concurrently
with untrusted user mode tasks. This protects both syscalls and IRQs vs
usermode and guest. It is also based on Thomas’s x86/entry branch which
moves generic entry code out of arch/

This iteration also fixes the hotplug crash and hang issues present in
v6. In v6, previous hotplug fixes were removed as they were getting
complicated. This iteration addresses the root cause of hot plug issues
and fixes them.

In terms of performance, the active VM-based workloads are still less
impacted by core scheduling than by disabling SMT. There are corner
cases and at this stage, since we are getting closer to merger, we are
actively looking for feedback and reproducers of those so we can address
them.

Performance tests:
sysbench is used to test the performance of the patch series. Used a 8
cpu/4 Core VM and ran 2 sysbench tests in parallel. Each sysbench test
runs 4 tasks:
sysbench --test=cpu --cpu-max-prime=100000 --num-threads=4 run

Compared the performance results for various combinations as below.
The metric below is 'events per second':

1. Coresched disabled
    sysbench-1/sysbench-2 => 175.7/175.6
2. Coreched enabled, both sysbench tagged
  sysbench-1/sysbench-2 => 168.8/165.6
3. Coresched enabled, sysbench-1 tagged and sysbench-2 untagged
    sysbench-1/sysbench-2 => 96.4/176.9
4. smt off
    sysbench-1/sysbench-2 => 97.9/98.8

When both sysbench-es are tagged, there is a perf drop of ~4%. With a
tagged/untagged case, the tagged one suffers because it always gets
stalled when the sibiling enters kernel. But this is no worse than
smtoff.

Also a modified rcutorture was used to heavily stress the kernel to make
sure there is not crash or instability.

Larger scale performance tests were performed where the host is running
the core scheduling kernel, each VM is in its own tag.

With 3 12-vcpus VMs on a 36 hardware thread NUMA node running linpack
(CPU-intensive), we go from 1:1 to 2:1 vcpus to hardware threads when we
disable SMT, the performance impact of core scheduling is -9.52% whereas
it is -25.41% with nosmt.

With 2 12-vcpus VMs database servers and 192 1-vcpus semi-idle VMs
running on 2 36 hardware threads NUMA nodes (3:1), the performance
impact is -47% with core scheduling and -66% with nosmt.

More details on those tests at the end of this presentation:
https://www.linuxplumbersconf.org/event/7/contributions/648/attachments/555/981/CoreScheduling_LPC2020.pdf

v7 is rebased on 5.9-rc2(d3ac97072ec5)
https://github.com/digitalocean/linux-coresched/tree/coresched/v7-v5.9-rc

TODO
----
(Mostly same as in v6)
- MAJOR: Core wide vruntime comparison re-work
  https://lwn.net/ml/linux-kernel/20200506143506.GH5298@hirez.programming.kicks-ass.net/
  https://lwn.net/ml/linux-kernel/20200514130248.GD2940@hirez.programming.kicks-ass.net/
- MAJOR: Decide on the interfaces/API for exposing the feature to userland.
  - LPC 2020 gained consensus on a simple task level interface as a starter
  - Investigate ideas on overcoming unified hierarchy limitations with
    cgroup v2 controller
- MAJOR: Load balancing/Migration fixes for core scheduling.
  With v6, Load balancing is partially coresched aware, but has some
  issues w.r.t process/taskgroup weights:
  https://lwn.net/ml/linux-kernel/20200225034438.GA617271@ziqianlu-desktop.localdomain/
- Investigate the source of the overhead even when no tasks are tagged:
  https://lkml.org/lkml/2019/10/29/242
- Core scheduling test framework: kselftests, torture tests etc

Changes in v7
-------------
- Kernel protection from untrusted usermode tasks
  - Joel, Vineeth
- Fix for hotplug crashes and hangs
  - Joel, Vineeth

Changes in v6
-------------
- Documentation
  - Joel
- Pause siblings on entering nmi/irq/softirq
  - Joel, Vineeth
- Fix for RCU crash
  - Joel
- Fix for a crash in pick_next_task
  - Yu Chen, Vineeth
- Minor re-write of core-wide vruntime comparison
  - Aaron Lu
- Cleanup: Address Review comments
- Cleanup: Remove hotplug support (for now)
- Build fixes: 32 bit, SMT=n, AUTOGROUP=n etc
  - Joel, Vineeth

Changes in v5
-------------
- Fixes for cgroup/process tagging during corner cases like cgroup
  destroy, task moving across cgroups etc
  - Tim Chen
- Coresched aware task migrations
  - Aubrey Li
- Other minor stability fixes.

Changes in v4
-------------
- Implement a core wide min_vruntime for vruntime comparison of tasks
  across cpus in a core.
  - Aaron Lu
- Fixes a typo bug in setting the forced_idle cpu.
  - Aaron Lu

Changes in v3
-------------
- Fixes the issue of sibling picking up an incompatible task
  - Aaron Lu
  - Vineeth Pillai
  - Julien Desfossez
- Fixes the issue of starving threads due to forced idle
  - Peter Zijlstra
- Fixes the refcounting issue when deleting a cgroup with tag
  - Julien Desfossez
- Fixes a crash during cpu offline/online with coresched enabled
  - Vineeth Pillai
- Fixes a comparison logic issue in sched_core_find
  - Aaron Lu

Changes in v2
-------------
- Fixes for couple of NULL pointer dereference crashes
  - Subhra Mazumdar
  - Tim Chen
- Improves priority comparison logic for process in different cpus
  - Peter Zijlstra
  - Aaron Lu
- Fixes a hard lockup in rq locking
  - Vineeth Pillai
  - Julien Desfossez
- Fixes a performance issue seen on IO heavy workloads
  - Vineeth Pillai
  - Julien Desfossez
- Fix for 32bit build
  - Aubrey Li

--

Aaron Lu (2):
  sched/fair: wrapper for cfs_rq->min_vruntime
  sched/fair: core wide cfs task priority comparison

Aubrey Li (1):
  sched: migration changes for core scheduling

Joel Fernandes (Google) (6):
  irq_work: Add support to detect if work is pending
  entry/idle: Add a common function for activites during idle entry/exit
  arch/x86: Add a new TIF flag for untrusted tasks
  kernel/entry: Add support for core-wide protection of kernel-mode
  entry/idle: Enter and exit kernel protection during idle entry and
    exit
  Documentation: Add documentation on core scheduling

Peter Zijlstra (9):
  sched: Wrap rq::lock access
  sched: Introduce sched_class::pick_task()
  sched: Core-wide rq->lock
  sched/fair: Add a few assertions
  sched: Basic tracking of matching tasks
  sched: Add core wide task selection and scheduling.
  sched: Trivial forced-newidle balancer
  sched: cgroup tagging interface for core scheduling
  sched: Debug bits...

Vineeth Pillai (5):
  bitops: Introduce find_next_or_bit
  cpumask: Introduce a new iterator for_each_cpu_wrap_or
  sched/fair: Fix forced idle sibling starvation corner case
  entry/kvm: Protect the kernel when entering from guest
  sched/coresched: config option for kernel protection

 .../admin-guide/hw-vuln/core-scheduling.rst   |  253 ++++
 Documentation/admin-guide/hw-vuln/index.rst   |    1 +
 .../admin-guide/kernel-parameters.txt         |    9 +
 arch/x86/include/asm/thread_info.h            |    2 +
 arch/x86/kvm/x86.c                            |    3 +
 include/asm-generic/bitops/find.h             |   16 +
 include/linux/cpumask.h                       |   42 +
 include/linux/entry-common.h                  |   22 +
 include/linux/entry-kvm.h                     |   12 +
 include/linux/irq_work.h                      |    1 +
 include/linux/sched.h                         |   21 +-
 kernel/Kconfig.preempt                        |   19 +
 kernel/entry/common.c                         |   90 +-
 kernel/entry/kvm.c                            |   12 +
 kernel/irq_work.c                             |   11 +
 kernel/sched/core.c                           | 1310 +++++++++++++++--
 kernel/sched/cpuacct.c                        |   12 +-
 kernel/sched/deadline.c                       |   34 +-
 kernel/sched/debug.c                          |    4 +-
 kernel/sched/fair.c                           |  400 +++--
 kernel/sched/idle.c                           |   30 +-
 kernel/sched/pelt.h                           |    2 +-
 kernel/sched/rt.c                             |   22 +-
 kernel/sched/sched.h                          |  253 +++-
 kernel/sched/stop_task.c                      |   13 +-
 kernel/sched/topology.c                       |    4 +-
 lib/cpumask.c                                 |   53 +
 lib/find_bit.c                                |   58 +-
 28 files changed, 2381 insertions(+), 328 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst

--
2.17.1

