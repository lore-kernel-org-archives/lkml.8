Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B30C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5ED20897
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="E44tgBHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgH1Txv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgH1TxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:53:09 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423D9C061236
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:53:09 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id s15so203472qvv.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kqnuk9AXXBAKTcx0hh4liiEEzZugxS774eknhTnrHHw=;
        b=E44tgBHza2olgmfYteic4oiAS2GAziGhd7jDj6ZeBJlcv4QT0J2t196X5rxlcwpUQG
         vqVurdnVC2Ed+RBO/3WQVatGm2zRseHUwzzJLuLIGYvnKJXbySK5lSAUl3rwmlZtW6T8
         Rz0EJ0i6YQ6tPWalgGSr+cLFaWu+zXsfwFOjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kqnuk9AXXBAKTcx0hh4liiEEzZugxS774eknhTnrHHw=;
        b=tEYw4LarDTG5FSYiLdPR1pvzyExFY0rjqYRwwARxUpo3+6RJx+tXCDhD2/+gynafVK
         mBp0JFVmLmBS0+d5prnAXoX1IfsyBKdHxyVG27Ec6EBrNXlowYVoe8E+oTQCCtfoNkIW
         ghoxzwRzeBOTeSnPVGJJ9qBCgXrLVVnEiYW9h8VBuSDXjWxJ+jjVQsBckpYuZ9DcxMFg
         J+Riy30ki8vZB+oVlJVzltsqVh8w1F0GSSy3gVMiciv6Dx+KEyg2ZfQLT45v/Dru8h1r
         7ln8MFdT0huBifIxoRMdWNNBSt1ek2EQZ/G8ahsdC95Y1poyxWwZwL1NbgxfXT5j17bx
         OCMg==
X-Gm-Message-State: AOAM533XeEWjLG05aEMka8fJQvuA6MGpMIDnIqrM8f4K/80qvjD0SVgv
        BxNiG5wqouwK0xSy/PSlZ+9jLw==
X-Google-Smtp-Source: ABdhPJzcmOIYfwOLDySvudex6Sc3ItJEMnYotq4Kl0y1Ok+q+JmKVQlCwW3zLo2EFn2v2vwllX/P0Q==
X-Received: by 2002:ad4:4bc5:: with SMTP id l5mr149526qvw.95.1598644388175;
        Fri, 28 Aug 2020 12:53:08 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:53:07 -0700 (PDT)
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
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
Subject: [RFC PATCH v7 22/23] Documentation: Add documentation on core scheduling
Date:   Fri, 28 Aug 2020 15:51:23 -0400
Message-Id: <36608b6359cbaa46627126bc452c30adb3b97d2f.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Co-developed-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 .../admin-guide/hw-vuln/core-scheduling.rst   | 253 ++++++++++++++++++
 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 2 files changed, 254 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst

diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
new file mode 100644
index 000000000000..7ebece93f1d3
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -0,0 +1,253 @@
+Core Scheduling
+================
+MDS and L1TF mitigations do not protect from cross-HT attacks (attacker running
+on one HT with victim running on another). For proper mitigation of this,
+core scheduling support is available via the ``CONFIG_SCHED_CORE`` config option.
+Using this feature, userspace defines groups of tasks that trust each other.
+The core scheduler uses this information to make sure that tasks that do not
+trust each other will never run simultaneously on a core while still meeting
+the scheduler's requirements.
+
+Usage
+-----
+The current interface implementation is just for testing and uses CPU
+controller CGroups which will change soon. A ``cpu.tag`` file has been added to
+the CPU controller CGroup. If the content of this file is 1, then all the
+CGroup's tasks trust each other and are allowed to run concurrently on a core's
+hyperthreads (also called siblings).
+
+As mention, the interface is for testing purposes and has drawbacks. Trusted
+tasks have to be grouped into CPU CGroup which is not always possible
+depending on the system's existing CGroup configuration, where trusted tasks
+could already be in different CPU CGroups. Also, this feature will have a hard
+dependency on CGroups and systems with CGroups disabled would not be able to
+use core scheduling so another API is needed in conjunction with
+CGroups. See `Future work`_ for other API proposals.
+
+Design/Implementation
+---------------------
+Each task that is tagged is assigned a cookie internally in the kernel. As
+mentioned in `Usage`_, tasks with the same cookie value are assumed to trust
+each other and share a core.
+
+The basic idea is that, every schedule event tries to select tasks for all the
+siblings of a core such that all the selected tasks running on a core are
+trusted (same cookie) at any point in time. Kernel threads are assumed trusted.
+The idle task is considered special, in that it trusts every thing.
+
+During a schedule() event on any sibling of a core, the highest priority task for
+that core is picked and assigned to the sibling calling schedule() if it has it
+enqueued. For rest of the siblings in the core, highest priority task with the
+same cookie is selected if there is one runnable in their individual run
+queues. If a task with same cookie is not available, the idle task is selected.
+Idle task is globally trusted.
+
+Once a task has been selected for all the siblings in the core, an IPI is sent to
+siblings for whom a new task was selected. Siblings on receiving the IPI, will
+switch to the new task immediately. If an idle task is selected for a sibling,
+then the sibling is considered to be in a "forced idle" state. i.e., it may
+have tasks on its on runqueue to run, however it will still have to run idle.
+More on this in the next section.
+
+Forced-idling of tasks
+---------------------
+The scheduler tries its best to find tasks that trust each other such that all
+tasks selected to be scheduled are of the highest priority in a core.  However,
+it is possible that some runqueues had tasks that were incompatibile with the
+highest priority ones in the core. Favoring security over fairness, one or more
+siblings could be forced to select a lower priority task if the highest
+priority task is not trusted with respect to the core wide highest priority
+task.  If a sibling does not have a trusted task to run, it will be forced idle
+by the scheduler(idle thread is scheduled to run).
+
+When the highest priorty task is selected to run, a reschedule-IPI is sent to
+the sibling to force it into idle. This results in 4 cases which need to be
+considered depending on whether a VM or a regular usermode process was running
+on either HT:
+
+::
+          HT1 (attack)            HT2 (victim)
+   
+   A      idle -> user space      user space -> idle
+   
+   B      idle -> user space      guest -> idle
+   
+   C      idle -> guest           user space -> idle
+   
+   D      idle -> guest           guest -> idle
+
+Note that for better performance, we do not wait for the destination CPU
+(victim) to enter idle mode. This is because the sending of the IPI would bring
+the destination CPU immediately into kernel mode from user space, or VMEXIT
+in the case of  guests. At best, this would only leak some scheduler metadata
+which may not be worth protecting. It is also possible that the IPI is received
+too late on some architectures, but this has not been observed in the case of
+x86.
+
+Kernel protection from untrusted tasks
+--------------------------------------
+The scheduler on its own cannot protect the kernel executing concurrently with
+an untrusted task in a core. This is because the scheduler is unaware of
+interrupts/syscalls at scheduling time. To mitigate this, we send an IPI to
+siblings on kernel entry. This forces the sibling to enter kernel mode and it
+waits before returning to user until all siblings of the core has left kernel
+mode.  For good performance, we send an IPI only if it is detected that the
+core is running tasks that have been marked for core scheduling. If a sibling
+is running kernel threads or is idle, no IPI is sent.
+
+For easier testing, a temporary (not intended for mainline) patch is included
+in this series to make kernel protection configurable via a
+``CONFIG_SCHED_CORE_KERNEL_PROTECTION`` config option or a
+``sched_core_kernel_protection`` boot parameter.
+
+Other ideas for kernel protection which are
+
+1. Changing interrupt affinities to a trusted core which does not execute untrusted tasks
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+By changing the interrupt affinities to a designated safe-CPU which runs
+only trusted tasks, IRQ data can be protected. One issue is this involves
+giving up a full CPU core of the system to run safe tasks. Another is that,
+per-cpu interrupts such as the local timer interrupt cannot have their
+affinity changed. also, sensitive timer callbacks such as the random entropy timer
+can run in softirq on return from these interrupts and expose sensitive
+data. In the future, that could be mitigated by forcing softirqs into threaded
+mode by utilizing a mechanism similar to ``PREEMPT_RT``.
+
+Yet another issue with this is, for multiqueue devices with managed
+interrupts, the IRQ affinities cannot be changed however it could be
+possible to force a reduced number of queues which would in turn allow to
+shield one or two CPUs from such interrupts and queue handling for the price
+of indirection.
+
+2. Running IRQs as threaded-IRQs
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+This would result in forcing IRQs into the scheduler which would then provide
+the process-context mitigation. However, not all interrupts can be threaded.
+Also this does nothing about syscall entries.
+
+3. Kernel Address Space Isolation
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+System calls could run in a much restricted address space which is
+guarenteed not to leak any sensitive data. There are practical limitation in
+implementing this - the main concern being how to decide on an address space
+that is guarenteed to not have any sensitive data.
+
+4. Limited cookie-based protection
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+On a system call, change the cookie to the system trusted cookie and initiate a
+schedule event. This would be better than pausing all the siblings during the
+entire duration for the system call, but still would be a huge hit to the
+performance.
+
+Trust model
+-----------
+Core scheduling understands trust relationships by assignment of a cookie to
+related tasks using the above mentioned interface.  When a system with core
+scheduling boots, all tasks are considered to trust each other. This is because
+the scheduler does not have information about trust relationships. That is, all
+tasks have a default cookie value of 0. This cookie value is also considered
+the system-wide cookie value and the IRQ-pausing mitigation is avoided if
+siblings are running these cookie-0 tasks.
+
+By default, all system processes on boot are considered trusted and userspace
+has to explicitly use the interfaces mentioned above to group sets of tasks.
+Tasks within the group trust each other, but not those outside. Tasks outside
+the group don't trust the task inside.
+
+Limitations
+-----------
+Core scheduling tries to guarentee that only trusted tasks run concurrently on a
+core. But there could be small window of time during which untrusted tasks run
+concurrently or kernel could be running concurrently with a task not trusted by
+kernel.
+
+1. IPI processing delays
+^^^^^^^^^^^^^^^^^^^^^^^^
+Core scheduling selects only trusted tasks to run together. IPI is used to notify
+the siblings to switch to the new task. But there could be hardware delays in
+receiving of the IPI on some arch (on x86, this has not been observed). This may
+cause an attacker task to start running on a cpu before its siblings receive the
+IPI. Even though cache is flushed on entry to user mode, victim tasks on siblings
+may populate data in the cache and micro acrhitectural buffers after the attacker
+starts to run and this is a possibility for data leak.
+
+Open cross-HT issues that core scheduling does not solve
+--------------------------------------------------------
+1. For MDS
+^^^^^^^^^^
+Core scheduling cannot protect against MDS attacks between an HT running in
+user mode and another running in kernel mode. Even though both HTs run tasks
+which trust each other, kernel memory is still considered untrusted. Such
+attacks are possible for any combination of sibling CPU modes (host or guest mode).
+
+2. For L1TF
+^^^^^^^^^^^
+Core scheduling cannot protect against a L1TF guest attackers exploiting a
+guest or host victim. This is because the guest attacker can craft invalid
+PTEs which are not inverted due to a vulnerable guest kernel. The only
+solution is to disable EPT.
+
+For both MDS and L1TF, if the guest vCPU is configured to not trust each
+other (by tagging separately), then the guest to guest attacks would go away.
+Or it could be a system admin policy which considers guest to guest attacks as
+a guest problem.
+
+Another approach to resolve these would be to make every untrusted task on the
+system to not trust every other untrusted task. While this could reduce
+parallelism of the untrusted tasks, it would still solve the above issues while
+allowing system processes (trusted tasks) to share a core.
+
+Use cases
+---------
+The main use case for Core scheduling is mitigating the cross-HT vulnerabilities
+with SMT enabled. There are other use cases where this feature could be used:
+
+- Isolating tasks that needs a whole core: Examples include realtime tasks, tasks
+  that uses SIMD instructions etc.
+- Gang scheduling: Requirements for a group of tasks that needs to be scheduled
+  together could also be realized using core scheduling. One example is vcpus of
+  a VM.
+
+Future work
+-----------
+1. API Proposals
+^^^^^^^^^^^^^^^^
+
+As mentioned in `Usage`_ section, various API proposals are listed here:
+
+- ``prctl`` : We can pass in a tag and all tasks with same tag set by prctl forms
+  a trusted group.
+
+- ``sched_setattr`` : Similar to prctl, but has the advantage that tasks could be
+  tagged by other tasks with appropriate permissions.
+
+- ``Auto Tagging`` : Related tasks are tagged automatically. Relation could be,
+  threads of the same process, tasks by a user, group or session etc.
+
+- Dedicated CGroup or procfs/sysfs interface for grouping trusted tasks. This could
+  be combined with prctl/sched_setattr as well.
+
+2. Auto-tagging of KVM vCPU threads
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+To make configuration easier, it would be great if KVM auto-tags vCPU threads
+such that a given VM only trusts other vCPUs of the same VM. Or something more
+aggressive like assiging a vCPU thread a unique tag.
+
+3. Auto-tagging of processes by default
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Currently core scheduling does not prevent 'unconfigured' tasks from being
+co-scheduled on the same core. In other words, everything trusts everything
+else by default. If a user wants everything default untrusted, a CONFIG option
+could be added to assign every task with a unique tag by default.
+
+4. Auto-tagging on fork
+^^^^^^^^^^^^^^^^^^^^^^^
+Currently, on fork a thread is added to the same trust-domain as the parent. For
+systems which want all tasks to have a unique tag, it could be desirable to assign
+a unique tag to a task so that the parent does not trust the child by default.
+
+5. Skipping per-HT mitigations if task is trusted
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+If core scheduling is enabled, by default all tasks trust each other as
+mentioned above. In such scenario, it may be desirable to skip the same-HT
+mitigations on return to the trusted user-mode to improve performance.
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index ca4dbdd9016d..f12cda55538b 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -15,3 +15,4 @@ are configurable at compile, boot or run time.
    tsx_async_abort
    multihit.rst
    special-register-buffer-data-sampling.rst
+   core-scheduling.rst
-- 
2.17.1

