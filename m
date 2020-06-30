Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4498C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36D92065D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="CWbPUwdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgF3VeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbgF3Vd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:33:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFECC03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so9799062pfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+w1t38b3w4AZT1Xc7eDxHzeTTLA5N812ElI9LsAJM04=;
        b=CWbPUwdTJ5g8URhIJnHeNITo0nZAednz9PBOyw+NOwDt34Tl6Dv1qG37QkcSv9uHni
         8jIYe7VVkhwY7cVmSwqUeQFMIb0QxWFtGn3RgWGBiMWw0HSxUc8+zbzK+JOF+787t1xS
         siMTK876xjOjOY5yePv1tse1Sd3CiY8Bo/k3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+w1t38b3w4AZT1Xc7eDxHzeTTLA5N812ElI9LsAJM04=;
        b=dDr+ZXyF6GvskZ6kcCMBLD8x5lv0iX2eqeUF7RM9J6zP8g4rjL+2BeE2UZ3Exu/X+U
         xC2sKF2dX7jbfxMenOHZeTLFoDvnHsJTV9d8FrPj7QB517eoTADjpBjP8mAqNIzSCXWR
         /TiR6yTsTmyyJWXodA/VihHDaU7vl4i4wiqhw4+ah8xVbwAf88QIal+KvC9hWL6B+XYZ
         2/jGPuSiMmbavQQ/0uVGz4jWIUCok4r8D00ARB50yi0O/OxvdK+81mNOHKejcITnQHEf
         Gaycf/PBVZsgwnAnNrOfXYhcZ5EZYbyL5Icd+wO/Q4RNGrFx2cW7Y2ZqytpXj0nHr/WZ
         RUnw==
X-Gm-Message-State: AOAM533JxSTNSJ3tRl5cvSIP7TuY1P9rsZZg4tzcS5oy79JhmnFDz+i/
        iP+NHwzhSFQsiplD/xQC7fWA5w==
X-Google-Smtp-Source: ABdhPJzQo06WEmHbQlIFOVFLF21yx4EtdquddIGnFn2n7lVJENb+c7lLklgXArXV0Lg06ek42CF31g==
X-Received: by 2002:aa7:98c6:: with SMTP id e6mr21195759pfm.17.1593552837673;
        Tue, 30 Jun 2020 14:33:57 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id j19sm3518695pfn.109.2020.06.30.14.33.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:33:57 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH 15/16] Documentation: Add documentation on core scheduling
Date:   Tue, 30 Jun 2020 21:32:36 +0000
Message-Id: <d56b05f13860db5cf844c6c72138b4d2d512d632.1593530334.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
---
 .../admin-guide/hw-vuln/core-scheduling.rst   | 241 ++++++++++++++++++
 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 2 files changed, 242 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst

diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
new file mode 100644
index 000000000000..275568162a74
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -0,0 +1,241 @@
+Core Scheduling
+================
+MDS and L1TF mitigations do not protect from cross-HT attacks (attacker running
+on one HT with victim running on another). For proper mitigation of this,
+core scheduling support is available via the ``CONFIG_SCHED_CORE`` config option.
+Using this feature, userspace defines groups of tasks that trust each other.
+The core scheduler uses this information to make sure that tasks that do not
+trust each other will never run simultaneously on a core while ensuring trying
+to maintain and ensure scheduler properties and requirements.
+
+Usage
+-----
+The user-interface to this feature is not yet finalized. CUrrent implementation
+uses CPU controller cgroup. Core scheduling adds a ``cpu.tag`` file to the CPU
+controller CGroup. If the content of this file is 1, then all the tasks in this
+CGroup trust each other and are allowed to run concurrently on the siblings of
+a core.
+
+This interface has drawbacks. Trusted tasks has to be grouped into one CPU CGroup
+and this is not always possible based on system's existing Cgroup configuration,
+where trusted tasks could already be in different CPU Cgroups. Also, this feature
+will have a hard dependency on CGroups and systems with CGroups disabled would not
+be able to use core scheduling. See `Future work`_ for other API proposals.
+
+Design/Implementation
+---------------------
+Tasks are grouped as mentioned in `Usage`_ and tasks that trust each other
+share the same cookie value(in task_struct).
+
+The basic idea is that, every schedule event tries to select tasks for all the
+siblings of a core such that all the selected tasks are trusted(same cookie).
+
+During a schedule event on any sibling of a core, the highest priority task for
+that core is picked and assigned to the sibling which has it enqueued. For rest of
+the siblings in the core, highest priority task with the same cookie is selected if
+there is one runnable in the run queue. If a task with same cookie is not available,
+idle task is selected. Idle task is globally trusted.
+
+Once a task has been selected for all the siblings in the core, an IPI is sent to
+all the siblings who has a new task selected. Siblings on receiving the IPI, will
+switch to the new task immediately.
+
+Force-idling of tasks
+---------------------
+The scheduler tries its best to find tasks that trust each other such that all
+tasks selected to be scheduled are of the highest priority in that runqueue.
+However, this is not always possible. Favoring security over fairness, one or
+more siblings could be forced to select a lower priority task if the highest
+priority task is not trusted with respect to the core wide highest priority task.
+If a sibling does not have a trusted task to run, it will be forced idle by the
+scheduler(idle thread is scheduled to run).
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
+(victim) to enter idle mode.  This is because the sending of the IPI would
+bring the destination CPU immediately into kernel mode from user space, or
+VMEXIT from guests. At best, this would only leak some scheduler metadata which
+may not be worth protecting.
+
+Protection against interrupts using IRQ pausing
+-----------------------------------------------
+The scheduler on its own cannot protect interrupt data. This is because the
+scheduler is unaware of interrupts at scheduling time. To mitigate this, we
+send an IPI to siblings on IRQ entry. This IPI handler busy-waits until the IRQ
+on the sending HT exits. For good performance, we send an IPI only if it is
+detected that the core is running tasks that have been marked for
+core scheduling. Both interrupts and softirqs are protected.
+
+This protection can be disabled by disabling ``CONFIG_SCHED_CORE_IRQ_PAUSE`` or
+through the ``sched_core_irq_pause`` boot parameter.
+
+If it is desired to disable IRQ pausing, other mitigation methods can be considered:
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
+2. Asynchronous Kernel entries
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+A task can switch to kernel any time due to events like irqs, system calls etc.
+Since core scheduling synchronizes only during a schedule event, kernel can run
+along with a task that it doesn't trust. The IRQ pause mechanism mentioned above,
+provides protection during nmi/irq/softirqs. But tasks could still enter kernel
+mode via system calls and this is not currently protected.
+
+There are ideas about mitigating this:
+ - Kernel Address Space Isolation: System calls could run in a much restricted
+   address space which is guarenteed not to leak any sensitive data. There are
+   practical limitation in implementing this - the main concern being how to
+   decided on an address space that is guarenteed to not have any sensitive
+   data
+ - On a system call, change the cookie to the system trusted cookie and initiate
+   a schedule event. This would be better than pausing all the siblings during
+   the entire duration for the system call, but still would be a huge hit to the
+   performance.
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
+- Dedicated cgroup or procfs/sysfs interface for grouping trusted tasks. This could
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

