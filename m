Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BA0C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8137324654
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="ds2gCVke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbgCDRBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:01:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33300 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbgCDRAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:00:08 -0500
Received: by mail-qt1-f196.google.com with SMTP id d22so1907702qtn.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZcWqV6JD+NpCxVyUMWr25+OOQvCNBSUoF3Hhx9DhCSI=;
        b=ds2gCVke6rgnscwflfWsWa4/02xZE9rlbG0jpAqRtttP303WSpmGc5u+Leh2MJeIvY
         NLmAFZf2U12ZCqTKqF1yQ1OLbpOfhM9T0yI8PW+eWfdAMfk0+6XlCk+BRcv92NyjtTay
         gNlpaHjzcxXhsVFTX7lc64B713pIOAwPfXFrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZcWqV6JD+NpCxVyUMWr25+OOQvCNBSUoF3Hhx9DhCSI=;
        b=BpFFwE3RO3TzjqWs8lVPifNvIfANw2ZOqdNkAvouF7B0KkZaftwV03NDhx2M8BrgUK
         AT2YJmJ81jLkkzC4BB8FsvYLfkYwpW2zul4B9kPFxLcgImcPKFkTcKp+9fh0gib1yT6N
         R/Mxmo9VUlnK8JoUnvfTgAnDGM1vkn8iPHKJ1p81O8YxvGXWlsx9krNvTmbXtabPYIY2
         lrgzQIPTZtL5N2KM4Bu5la76LgzI9nf61NJoNZFHmfPF+KvRizH0sl858Z8MfiGCONGU
         oZtrgU4dzQmV9GmU/5jX05d+JJ5UdgLTOG+0Uu4kmgeHo9H7AtyPM3txdE25nEPDN9DX
         40og==
X-Gm-Message-State: ANhLgQ1k+7zj88ezoKyEeFkvfc6nkusSuRu46TFrYYXXNArJzP53NJl8
        zsFjSvAJybYFodkUrfSXsrjl75s1S0I=
X-Google-Smtp-Source: ADFU+vuXyZvSjd61Q2etCVeeIdxusnGaaWXDBPmDBEDG1oaiT00o4qyyknz+6JUPLG1cEDdYU+ewEw==
X-Received: by 2002:aed:2a5c:: with SMTP id k28mr3316939qtf.132.1583341206525;
        Wed, 04 Mar 2020 09:00:06 -0800 (PST)
Received: from s2r5node9 ([162.243.188.99])
        by smtp.gmail.com with ESMTPSA id o6sm3506117qkj.96.2020.03.04.09.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:00:05 -0800 (PST)
From:   vpillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     vpillai <vpillai@digitalocean.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org
Subject: [RFC PATCH 00/13] Core scheduling v5
Date:   Wed,  4 Mar 2020 16:59:50 +0000
Message-Id: <cover.1583332764.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fifth iteration of the Core-Scheduling feature.

Core scheduling is a feature that only allows trusted tasks to run
concurrently on cpus sharing compute resources(eg: hyperthreads on a
core). The goal is to mitigate the core-level side-channel attacks
without requiring to disable SMT (which has a significant impact on
performance in some situations). So far, the feature mitigates user-space
to user-space attacks but not user-space to kernel attack, when one of
the hardware thread enters the kernel (syscall, interrupt etc).

By default, the feature doesn't change any of the current scheduler
behavior. The user decides which tasks can run simultaneously on the
same core (for now by having them in the same tagged cgroup). When
a tag is enabled in a cgroup and a task from that cgroup is running
on a hardware thread, the scheduler ensures that only idle or trusted
tasks run on the other sibling(s). Besides security concerns, this
feature can also be beneficial for RT and performance applications
where we want to control how tasks make use of SMT dynamically.

This version was focusing on performance and stability. Couple of
crashes related to task tagging and cpu hotplug path were fixed.
This version also improves the performance considerably by making
task migration and load balancing coresched aware.

In terms of performance, the major difference since the last iteration
is that now even IO-heavy and mixed-resources workloads are less
impacted by core-scheduling than by disabling SMT. Both host-level and
VM-level benchmarks were performed. Details in:
https://lkml.org/lkml/2020/2/12/1194
https://lkml.org/lkml/2019/11/1/269

v5 is rebased on top of 5.5.5(449718782a46)
https://github.com/digitalocean/linux-coresched/tree/coresched/v5-v5.5.y

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
  to starve.
- Joel(ChromeOS) found an issue where RT task may be preempted by a
  lower class task.
- Joel(ChromeOS) found a deadlock and crash on PREEMPT kernel in the
  coreshed idle balance logic

TODO
----
- Work on merging patches that are ready to be merged
- Decide on the API for exposing the feature to userland
- Experiment with adding synchronization points in VMEXIT to mitigate
  the VM-to-host-kernel leaking
- Investigate the source of the overhead even when no tasks are tagged:
  https://lkml.org/lkml/2019/10/29/242

---

Aaron Lu (2):
  sched/fair: wrapper for cfs_rq->min_vruntime
  sched/fair: core wide vruntime comparison

Aubrey Li (1):
  sched: migration changes for core scheduling

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

Tim Chen (1):
  sched: Update core scheduler queue when taking cpu online/offline

 include/linux/sched.h    |    9 +-
 kernel/Kconfig.preempt   |    6 +
 kernel/sched/core.c      | 1037 +++++++++++++++++++++++++++++++++++++-
 kernel/sched/cpuacct.c   |   12 +-
 kernel/sched/deadline.c  |   69 ++-
 kernel/sched/debug.c     |    4 +-
 kernel/sched/fair.c      |  387 +++++++++++---
 kernel/sched/idle.c      |   11 +-
 kernel/sched/pelt.h      |    2 +-
 kernel/sched/rt.c        |   65 ++-
 kernel/sched/sched.h     |  248 +++++++--
 kernel/sched/stop_task.c |   13 +-
 kernel/sched/topology.c  |    4 +-
 13 files changed, 1672 insertions(+), 195 deletions(-)

-- 
2.17.1

