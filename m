Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDC5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 255CF2065D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="fB+iRVg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgF3Vcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgF3Vct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:32:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64149C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:32:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j12so9973955pfn.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vWvUZUAfjMXbFJVOM8LPNVcCU5x5laRVYaH2HGKvpHI=;
        b=fB+iRVg4yKYD0/4n5jai1dADQsSMo1DQkZ9ZOCo0RCHZa70ViwRS+St92lz1oq2DaT
         Lj4y/eNiARsjsNc6g1nuPUMrHbRib7sQezrDAufdShQkKHsdQIIMb9pOaJOD5NnZVt9X
         aolnFzs8prcjy4Ebqdycxp98/WG5UOPHhbYKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vWvUZUAfjMXbFJVOM8LPNVcCU5x5laRVYaH2HGKvpHI=;
        b=LG/N52oV7H1QOA1lvr2S2bjOVNdfB/DizLQCWIy3rw03KuPHJSOxiSzk6ddE0N2xGH
         eFqgtdTLxzciQ05OepMJnSpr7h9MwvRR57a6pZ5BRvz/uGOoNlnACxN05mDJYxdf8wcH
         4dJNTTmxW3lBoT9GsX4y37tZfwaV7Lr6cfqXT1jSnfKnGGeNKy7/qVZZn0VCCcujKq9J
         S/UTLB6AZHTuyEdp2GATLXpKxt6OiS/wD1WVnXNkC3xCByBQm41iB99alVphihxzIXpD
         uWkf1uSV+iQ3qRn2gjm5KY/JcnPwv/Q/Y41kbZ0Ksho0VkbqpPwRH7kDTP1RxuoX1YC6
         B5EA==
X-Gm-Message-State: AOAM531tmIAEbHopP+nxATbUeM+2vD3DXRfoFpV1MpKKzmxdpYuk2J9w
        ELeeIrkDQNB4XoGlesUQk1Ap9A==
X-Google-Smtp-Source: ABdhPJxM/TjTImKYB7jwVxGhywOKEHoLuvr85C5g5J09ncBqbZ5TpXemgmiYnMb4BM2JugdvazFtSw==
X-Received: by 2002:a63:d501:: with SMTP id c1mr16823702pgg.159.1593552767564;
        Tue, 30 Jun 2020 14:32:47 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id o17sm3040729pjq.6.2020.06.30.14.32.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:32:46 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        vineethrp@gmail.com, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [RFC PATCH 00/16] Core scheduling v6
Date:   Tue, 30 Jun 2020 21:32:21 +0000
Message-Id: <cover.1593530334.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sixth iteration of the Core-Scheduling feature.

Core scheduling is a feature that allows only trusted tasks to run
concurrently on cpus sharing compute resources (eg: hyperthreads on a
core). The goal is to mitigate the core-level side-channel attacks
without requiring to disable SMT (which has a significant impact on
performance in some situations). Core scheduling (as of v6) mitigates
user-space to user-space attacks and user to kernel attack when one of
the siblings enters the kernel via interrupts. It is still possible to
have a task attack the sibling thread when it enters the kernel via
syscalls.

By default, the feature doesn't change any of the current scheduler
behavior. The user decides which tasks can run simultaneously on the
same core (for now by having them in the same tagged cgroup). When a
tag is enabled in a cgroup and a task from that cgroup is running on a
hardware thread, the scheduler ensures that only idle or trusted tasks
run on the other sibling(s). Besides security concerns, this feature
can also be beneficial for RT and performance applications where we
want to control how tasks make use of SMT dynamically.

This iteration is mostly a cleanup of v5 except for a major feature of
pausing sibling when a cpu enters kernel via nmi/irq/softirq. Also
introducing documentation and includes minor crash fixes.

One major cleanup was removing the hotplug support and related code.
The hotplug related crashes were not documented and the fixes piled up
over time leading to complex code. We were not able to reproduce the
crashes in the limited testing done. But if they are reroducable, we
don't want to hide them. We should document them and design better
fixes if any.

In terms of performance, the results in this release are similar to
v5. On a x86 system with N hardware threads:
- if only N/2 hardware threads are busy, the performance is similar
  between baseline, corescheduling and nosmt
- if N hardware threads are busy with N different corescheduling
  groups, the impact of corescheduling is similar to nosmt
- if N hardware threads are busy and multiple active threads share the
  same corescheduling cookie, they gain a performance improvement over
  nosmt.
  The specific performance impact depends on the workload, but for a
  really busy database 12-vcpu VM (1 coresched tag) running on a 36
  hardware threads NUMA node with 96 mostly idle neighbor VMs (each in
  their own coresched tag), the performance drops by 54% with
  corescheduling and drops by 90% with nosmt.

v6 is rebased on 5.7.6(a06eb423367e)
https://github.com/digitalocean/linux-coresched/tree/coresched/v6-v5.7.y

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

ISSUES
------
- Aaron(Intel) found an issue with load balancing when the tasks have
  different weights(nice or cgroup shares). Task weight is not considered
  in coresched aware load balancing and causes those higher weights task
  to starve. This issue was in v5 as well and is carried over.
- Joel(ChromeOS) found an issue where RT task may be preempted by a
  lower class task. This was also in v6 and is carried over.
- Coresched RB-tree doesn't get updated when task priority changes
- Potential starvation of untagged tasks(0 cookie) - a side effect of
  0 cookie tasks not in the coresched RB-Tree

TODO
----
- MAJOR: Core wide vruntime comparison re-work
  https://lwn.net/ml/linux-kernel/20200506143506.GH5298@hirez.programming.kicks-ass.net/
  https://lwn.net/ml/linux-kernel/20200514130248.GD2940@hirez.programming.kicks-ass.net/
- MAJOR: Decide on the interfaces/API for exposing the feature to userland.
  - prctl/set_schedattr
  - A new coresched cgroup?
  - fork/clone behaviour: whether child to inherit the cookie,
                          process vs thread behaviour etc
  - Auto tagging based on user/session/process etc.
  - procfs/sysfs interface to core scheduling.
- MAJOR: Load balancing/Migration fixes for core scheduling
  With v6, Load balancing is partially coresched aware, but has some
  issues w.r.t process/taskgroup weights:
  https://lwn.net/ml/linux-kernel/20200225034438.GA617271@ziqianlu-desktop.localdomain/
- System wide trusted cookie:
  As of now, cookie value of 0 is considered special - default for tasks
  that are not explicitly tagged. Kernel threads are not tagged by
  default and hence tasks with 0 cookie is currently considered as a
  system wide trusted trusted group. IRQ pause feature assumes this.
  Discussions regarding this needs to continue and converge on a system
  wide trusted cookie.
- Investigate the source of the overhead even when no tasks are tagged:
  https://lkml.org/lkml/2019/10/29/242
- Core scheduling test framework: kselftests, torture tests etc

---

Aaron Lu (2):
  sched/fair: wrapper for cfs_rq->min_vruntime
  sched/fair: core wide cfs task priority comparison

Aubrey Li (1):
  sched: migration changes for core scheduling

Chen Yu (1):
  sched: Fix pick_next_task() race condition in core scheduling

Joel Fernandes (Google) (2):
  irq: Add support for core-wide protection of IRQ and softirq
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

vpillai (1):
  sched/fair: Fix forced idle sibling starvation corner case

 Documentation/admin-guide/hw-vuln/core-scheduling.rst   |  241 ++++
 Documentation/admin-guide/hw-vuln/index.rst             |    1 +
 Documentation/admin-guide/kernel-parameters.txt         |    9 +
 include/linux/sched.h                                   |   14 +-
 kernel/Kconfig.preempt                                  |   19 +
 kernel/sched/core.c                                     | 1076 ++++++++++++++++-
 kernel/sched/cpuacct.c                                  |   12 +-
 kernel/sched/deadline.c                                 |   34 +-
 kernel/sched/debug.c                                    |    4 +-
 kernel/sched/fair.c                                     |  409 +++++--
 kernel/sched/idle.c                                     |   13 +-
 kernel/sched/pelt.h                                     |    2 +-
 kernel/sched/rt.c                                       |   22 +-
 kernel/sched/sched.h                                    |  256 +++-
 kernel/sched/stop_task.c                                |   13 +-
 kernel/sched/topology.c                                 |    4 +-
 kernel/softirq.c                                        |   46 +
 17 files changed, 1953 insertions(+), 222 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst

-- 
2.17.1

