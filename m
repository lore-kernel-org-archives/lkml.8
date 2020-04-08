Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50CCC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA8320753
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgDHJu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:50:26 -0400
Received: from foss.arm.com ([217.140.110.172]:36266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDHJu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:50:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 700BA31B;
        Wed,  8 Apr 2020 02:50:25 -0700 (PDT)
Received: from macbook.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F8AE3F73D;
        Wed,  8 Apr 2020 02:50:22 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Capacity awareness for SCHED_DEADLINE
Date:   Wed,  8 Apr 2020 11:50:08 +0200
Message-Id: <20200408095012.3819-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCHED_DEADLINE (DL) admission control does not work correctly on
heterogeneous (asymmetric CPU capacity) systems such as Arm big.LITTLE
or DynamIQ.

Let's fix this by explicitly considering CPU capacity in DL admission
control and task migration.

The DL sched class now attempts to avoid missing task deadlines due to
smaller CPU (CPU capacity < 1024) not being capable enough to finish a
task in time. It does so by trying to place a task so that its CPU
capacity scaled deadline is not smaller than its runtime.

Changes RFC [1] -> v1:

Only use static values for CPU bandwidth (sched_dl_entity::dl_runtime,
::dl_deadline) and CPU capacity (arch_scale_cpu_capacity()) to fix DL
admission control.

Dynamic values for CPU bandwidth (sched_dl_entity::runtime, ::deadline)
and CPU capacity (capacity_of()) are considered to be more related to
energy trade-off calculations which could be later introduced using the
Energy Model.

Since the design of the DL and RT sched classes are very similar, the
implementation follows the overall design of RT capacity awareness
(commit 804d402fb6f6 ("sched/rt: Make RT capacity-aware")).

Per-patch changes:

(1) Store CPU capacity sum in the root domain during
    build_sched_domains() [patch 1/4]

(2) Adjust to RT capacity awareness design [patch 3/4]

(3) Remove CPU capacity aware placement in switched_to_dl()
    (dl_migrate callback) [RFC patch 3/6]

    Balance callbacks (push, pull) run only in schedule_tail()
    __schedule(), rt_mutex_setprio() or __sched_setscheduler().
    DL throttling leads to a call to __dequeue_task_dl() which is not a
    full task dequeue. The task is still enqueued and only removed from
    the rq.
    So a queue_balance_callback() call in update_curr_dl()->
    __dequeue_task_dl() will not be followed by a balance_callback()
    call in one of the 4 functions mentioned above.

(4) Remove 'dynamic CPU bandwidth' consideration and only support
    'static CPU bandwidth' (ratio between sched_dl_entity::dl_runtime
    and ::dl_deadline) [RFC patch 4/6]

(5) Remove modification to migration logic which tried to schedule
    small tasks on LITTLE CPUs [RFC patch 6/6]

[1] https://lore.kernel.org/r/20190506044836.2914-1-luca.abeni@santannapisa.it

The following rt-app testcase tailored to Arm64 Hikey960:

root@h960:~# cat /sys/devices/system/cpu/cpu*/cpu_capacity
462
462
462
462
1024
1024
1024
1024

shows the expected behavior.

According to the following condition in dl_task_fits_capacity()

    cap_scale(dl_deadline, arch_scale_cpu_capacity(cpu)) >= dl_runtime

thread0-[0-3] are placed on a big CPUs whereas thread1-[0-3] run on a
LITTLE CPU respectively.

...
"tasks" : {
 "thread0" : {
  "policy" : "SCHED_DEADLINE",
  "instance" : 4,
  "timer" : { "ref" : "unique0", "period" : 16000, "mode" : "absolute" },
  "run" : 10000,
  "dl-runtime" : 11000,
  "dl-period" : 16000,
  "dl-deadline" : 16000
},
 "thread1" : {
  "policy" : "SCHED_DEADLINE",
  "instance" : 4,
  "delay" : 1000,
  "timer" : { "ref" : "unique1", "period" : 16000, "mode" : "absolute" },
  "run" : 5500,
  "dl-runtime" : 6500			
  "dl-period" : 16000,
  "dl-deadline" : 16000
}
...

Tests were run with Performance CPUfreq governor so that the Schedutil
CPUfreq governor DL threads (sugov:[0,4]), necessary on a
slow-switching platform like Hikey960, do not interfere with the
rt-app test tasks. Using Schedutil would require to lower the number of
tasks to 3 instances each.

Dietmar Eggemann (1):
  sched/topology: Store root domain CPU capacity sum

Luca Abeni (3):
  sched/deadline: Improve admission control for asymmetric CPU
    capacities
  sched/deadline: Make DL capacity-aware
  sched/deadline: Implement fallback mechanism for !fit case

 kernel/sched/cpudeadline.c | 23 +++++++++++++++++++++
 kernel/sched/deadline.c    | 41 +++++++++++++++++++++++---------------
 kernel/sched/sched.h       | 33 ++++++++++++++++++++++++++++--
 kernel/sched/topology.c    | 14 +++++++++----
 4 files changed, 89 insertions(+), 22 deletions(-)

-- 
2.17.1

