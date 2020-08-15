Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F00C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77E22053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="q8xGIc53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgHOV51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgHOVwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:06 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68470C06136F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:23 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p4so10241768qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+mQxIpmLjVSqIIOkPOr0JGerHQ3BLNHz+qxeTdgWNQ=;
        b=q8xGIc53OcFS1omCBypZK9igPl322E1/HmESV4mqecAmkceKfJYNpTKALiUdu8/87U
         UbUJmdw4E7BqnANQWIfpZFcgz5Hg3/U1hFgweaDB6FiT1zczFJEkp8u3glYMsqbNyb7l
         yVzBnq54unSCFHHGXyBolqtM2NIXMd2+Dwkpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+mQxIpmLjVSqIIOkPOr0JGerHQ3BLNHz+qxeTdgWNQ=;
        b=BsGZ9ZBmHrXbT4IH6f/qSaaod0x3OaAwakbBA5eOx44J3Ocxa0ZPoEqQ6PvImiObN6
         7ijZW5IwZ9nSDC24U2upYm/Htbo48uNzUggO8oGAftAe9ff//5C2WIbAqyqdumWuEQyC
         nfjMiQm9PpYJh9IVpOZcP5JXMQAEpSJIq2M1Ngazyv1BsDyoA2rYvMTQOhXRO2aToHil
         LZMFqSx88PYzfUgLBgnImUZsg6EU3eljizkYI4xKnhrHto9rCBfvS3fcfnwuw8T+KvuR
         CB6zVm6E9AHD7HTlxhrKhfNei/aI9t+/w/SpJ36CX6SOa77DBja8aKc0shENQJO978/J
         PUUA==
X-Gm-Message-State: AOAM533wTI1BSV563LAuYKuqj6EXAfgRkPCbyqbZAew6m2xLcOno1McA
        1WqS3oNt7iw111EeZVCw2JcHZF+7TEIc6A==
X-Google-Smtp-Source: ABdhPJw1Mic2QqYi792f/i62OaCi2txwoXGpxV8IGTfkho/RSTWsAbFHYuy4gaO+2VdycnePmhoKrQ==
X-Received: by 2002:a05:620a:208f:: with SMTP id e15mr4721368qka.473.1597461562127;
        Fri, 14 Aug 2020 20:19:22 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p12sm10055199qkk.118.2020.08.14.20.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:19:21 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH RFC 00/12] Core-sched v6+: kernel protection and hotplug fixes
Date:   Fri, 14 Aug 2020 23:18:56 -0400
Message-Id: <20200815031908.1015049-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series is continuation of main core-sched v6 series [1] and adds support
for syscall and IRQ isolation from usermode processes and guests. It is key to
safely entering kernel mode in an HT while the other HT is in use by a user or
guest. The series also fixes CPU hotplug issues arising because of the
cpu_smt_mask changing while the next task is being picked. These hotplug fixes
are needed also for kernel protection to work correctly.

The series is based on Thomas's x86/entry tree.

[1]  https://lwn.net/Articles/824918/

Background:

Core-scheduling prevents hyperthreads in usermode from attacking each
other, but it does not do anything about one of the hyperthreads
entering the kernel for any reason. This leaves the door open for MDS
and L1TF attacks with concurrent execution sequences between
hyperthreads.

This series adds support for protecting all syscall and IRQ kernel mode entries
by cleverly tracking when any sibling in a core enter the kernel, and when all
the siblings exit the kernel. IPIs are sent to force siblings into the kernel.

Care is taken to avoid waiting in IRQ-disabled sections as Thomas suggested
thus avoiding stop_machine deadlocks. Every attempt is made to avoid
unnecessary IPIs.

Performance tests:
sysbench is used to test the performance of the patch series. Used a 8 cpu/4
Core VM and ran 2 sysbench tests in parallel. Each sysbench test runs 4 tasks:
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
stalled when the sibiling enters kernel. But this is no worse than smtoff.

Also a modified rcutorture was used to heavily stress the kernel to make sure
there is not crash or instability.

Joel Fernandes (Google) (5):
irq_work: Add support to detect if work is pending
entry/idle: Add a common function for activites during idle entry/exit
arch/x86: Add a new TIF flag for untrusted tasks
kernel/entry: Add support for core-wide protection of kernel-mode
entry/idle: Enter and exit kernel protection during idle entry and
exit

Vineeth Pillai (7):
entry/kvm: Protect the kernel when entering from guest
bitops: Introduce find_next_or_bit
cpumask: Introduce a new iterator for_each_cpu_wrap_or
sched/coresched: Use for_each_cpu(_wrap)_or for pick_next_task
sched/coresched: Make core_pick_seq per run-queue
sched/coresched: Check for dynamic changes in smt_mask
sched/coresched: rq->core should be set only if not previously set

arch/x86/include/asm/thread_info.h |   2 +
arch/x86/kvm/x86.c                 |   3 +
include/asm-generic/bitops/find.h  |  16 ++
include/linux/cpumask.h            |  42 +++++
include/linux/entry-common.h       |  22 +++
include/linux/entry-kvm.h          |  12 ++
include/linux/irq_work.h           |   1 +
include/linux/sched.h              |  12 ++
kernel/entry/common.c              |  88 +++++----
kernel/entry/kvm.c                 |  12 ++
kernel/irq_work.c                  |  11 ++
kernel/sched/core.c                | 281 ++++++++++++++++++++++++++---
kernel/sched/idle.c                |  17 +-
kernel/sched/sched.h               |  11 +-
lib/cpumask.c                      |  53 ++++++
lib/find_bit.c                     |  56 ++++--
16 files changed, 564 insertions(+), 75 deletions(-)

--
2.28.0.220.ged08abb693-goog

