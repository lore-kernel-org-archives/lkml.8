Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBDBC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 14:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAFA206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 14:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kWTBYxtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgC2OVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:21:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44324 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbgC2OVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 10:21:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id x16so12878870qts.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nXUC1MVbi+z6Rv23uiR8EhlUtj/t8HhT3DxP1bbv+sY=;
        b=kWTBYxtSorIDi0Gjbxl8w6CE7EK26WlBnDsV5QzvSDziachQHDyhY9j+1iKfZ+2IlW
         2T/D2q+3siRYHTKHO/XPWDsjrWerPjUVnu4NpJ5wv/egCgIkPE9+ff+d4MJ7JGxnz0x7
         111BjcMN46sG8gi0sK1Fgkg1Q3tyc5i72SEDxxE3AvirboRxV9kQjOFDW6Dce33/ZjnM
         aGrDyiZIubaX2zavD/W++zoO55+njgoDKWlSppzeTbjjYNptRStrRqDcqzins4HuSFqb
         2r49O6yxslPHzWsghy7PEQd+Oi+9DzlCpf26zbjMfgUGMfG9+en+pNvdXe6lKuj4QNZG
         PHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nXUC1MVbi+z6Rv23uiR8EhlUtj/t8HhT3DxP1bbv+sY=;
        b=Ct11853d3PykPymvPSQzPL1mhaBLe1gf1PJxQ4M82HdyjulM+rwhKLk7WaSuxYnPxX
         2VRRlSkx5sKsxNsQUuzkqMP/oq1U2j4G17JPkgx5QNj/10FxchElX8FsBOk6eBybY/Kh
         rv1QW4a3AsXiVCpfXfY70mMauT/nMsv/2zYro5xEHOXy/c2ls47Yg9OXBsAPxgauk4qU
         tis0SI+lpZgtBrRKdBe/wqO94JkatBf7j0NaYx5olkmCPyAR4OdzpwZN2u99Cx2uo+CV
         rLKitZwqhMxyi+XY5UcFvfW6ILJrsix01N0/o6AcSuu160yxJk/b6o8RVhcQsYDarCkt
         VpXQ==
X-Gm-Message-State: ANhLgQ36YT0WUSWsxqOfZndmC3RBWsAWzylWVFTWY52cstppufS+Bmr5
        zeM+zjtctwrtci1m0QiBzPi11A==
X-Google-Smtp-Source: ADFU+vuWYDMBZLdoGp6yvSuVcivv0AwVNsM2YeqQCzXbT01OYT7J+Y/nL/DYweoz/gHDas2EkhQVmQ==
X-Received: by 2002:ac8:748d:: with SMTP id v13mr7904876qtq.390.1585491679676;
        Sun, 29 Mar 2020 07:21:19 -0700 (PDT)
Received: from ovpn-66-196.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 60sm8515717qtb.95.2020.03.29.07.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 07:21:19 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, rjw@rjwysocki.net, lenb@kernel.org,
        peterz@infradead.org, linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] x86/acpi: fix a deadlock with cpu hotplug
Date:   Sun, 29 Mar 2020 10:21:09 -0400
Message-Id: <20200329142109.1501-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the commit 0266d81e9bf5 ("acpi/processor: Prevent cpu hotplug
deadlock") except this is for acpi_processor_ffh_cstate_probe():

"The problem is that the work is scheduled on the current CPU from the
hotplug thread associated with that CPU.

It's not required to invoke these functions via the workqueue because
the hotplug thread runs on the target CPU already.

Check whether current is a per cpu thread pinned on the target CPU and
invoke the function directly to avoid the workqueue."

Since CONFIG_ACPI_PROCESSOR (for cstate.c) selects
CONFIG_ACPI_CPU_FREQ_PSS (for processor_throttling.c) on x86, just
make call_on_cpu() a static inline function from processor_throttling.c
and use it in cstate.c.

 WARNING: possible circular locking dependency detected
 ------------------------------------------------------
 cpuhp/1/15 is trying to acquire lock:
 ffffc90003447a28 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: __flush_work+0x4c6/0x630

 but task is already holding lock:
 ffffffffafa1c0e8 (cpuidle_lock){+.+.}-{3:3}, at: cpuidle_pause_and_lock+0x17/0x20

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #1 (cpu_hotplug_lock){++++}-{0:0}:
 cpus_read_lock+0x3e/0xc0
 irq_calc_affinity_vectors+0x5f/0x91
 __pci_enable_msix_range+0x10f/0x9a0
 pci_alloc_irq_vectors_affinity+0x13e/0x1f0
 pci_alloc_irq_vectors_affinity at drivers/pci/msi.c:1208
 pqi_ctrl_init+0x72f/0x1618 [smartpqi]
 pqi_pci_probe.cold.63+0x882/0x892 [smartpqi]
 local_pci_probe+0x7a/0xc0
 work_for_cpu_fn+0x2e/0x50
 process_one_work+0x57e/0xb90
 worker_thread+0x363/0x5b0
 kthread+0x1f4/0x220
 ret_from_fork+0x27/0x50

 -> #0 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
 __lock_acquire+0x2244/0x32a0
 lock_acquire+0x1a2/0x680
 __flush_work+0x4e6/0x630
 work_on_cpu+0x114/0x160
 acpi_processor_ffh_cstate_probe+0x129/0x250
 acpi_processor_evaluate_cst+0x4c8/0x580
 acpi_processor_get_power_info+0x86/0x740
 acpi_processor_hotplug+0xc3/0x140
 acpi_soft_cpu_online+0x102/0x1d0
 cpuhp_invoke_callback+0x197/0x1120
 cpuhp_thread_fun+0x252/0x2f0
 smpboot_thread_fn+0x255/0x440
 kthread+0x1f4/0x220
 ret_from_fork+0x27/0x50

 other info that might help us debug this:

 Chain exists of:
 (work_completion)(&wfc.work) --> cpuhp_state-up --> cpuidle_lock

 Possible unsafe locking scenario:

 CPU0                    CPU1
 ----                    ----
 lock(cpuidle_lock);
                         lock(cpuhp_state-up);
                         lock(cpuidle_lock);
 lock((work_completion)(&wfc.work));

 *** DEADLOCK ***

 3 locks held by cpuhp/1/15:
 #0: ffffffffaf51ab10 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x69/0x2f0
 #1: ffffffffaf51ad40 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x69/0x2f0
 #2: ffffffffafa1c0e8 (cpuidle_lock){+.+.}-{3:3}, at: cpuidle_pause_and_lock+0x17/0x20

 Call Trace:
 dump_stack+0xa0/0xea
 print_circular_bug.cold.52+0x147/0x14c
 check_noncircular+0x295/0x2d0
 __lock_acquire+0x2244/0x32a0
 lock_acquire+0x1a2/0x680
 __flush_work+0x4e6/0x630
 work_on_cpu+0x114/0x160
 acpi_processor_ffh_cstate_probe+0x129/0x250
 acpi_processor_evaluate_cst+0x4c8/0x580
 acpi_processor_get_power_info+0x86/0x740
 acpi_processor_hotplug+0xc3/0x140
 acpi_soft_cpu_online+0x102/0x1d0
 cpuhp_invoke_callback+0x197/0x1120
 cpuhp_thread_fun+0x252/0x2f0
 smpboot_thread_fn+0x255/0x440
 kthread+0x1f4/0x220
 ret_from_fork+0x27/0x50

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2:
Make call_on_cpu() a static inline function to avoid a compilation
error when ACPI_PROCESSOR=m thanks to lkp@intel.com.

 arch/x86/kernel/acpi/cstate.c       |  3 ++-
 drivers/acpi/processor_throttling.c |  7 -------
 include/acpi/processor.h            | 10 ++++++++++
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index caf2edccbad2..49ae4e1ac9cd 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -161,7 +161,8 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 
 	/* Make sure we are running on right CPU */
 
-	retval = work_on_cpu(cpu, acpi_processor_ffh_cstate_probe_cpu, cx);
+	retval = call_on_cpu(cpu, acpi_processor_ffh_cstate_probe_cpu, cx,
+			     false);
 	if (retval == 0) {
 		/* Use the hint in CST */
 		percpu_entry->states[cx->index].eax = cx->address;
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 532a1ae3595a..a0bd56ece3ff 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -897,13 +897,6 @@ static long __acpi_processor_get_throttling(void *data)
 	return pr->throttling.acpi_processor_get_throttling(pr);
 }
 
-static int call_on_cpu(int cpu, long (*fn)(void *), void *arg, bool direct)
-{
-	if (direct || (is_percpu_thread() && cpu == smp_processor_id()))
-		return fn(arg);
-	return work_on_cpu(cpu, fn, arg);
-}
-
 static int acpi_processor_get_throttling(struct acpi_processor *pr)
 {
 	if (!pr)
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 47805172e73d..770d226b22f2 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -297,6 +297,16 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 }
 #endif
 
+#ifdef CONFIG_ACPI_CPU_FREQ_PSS
+static inline int call_on_cpu(int cpu, long (*fn)(void *), void *arg,
+			      bool direct)
+{
+	if (direct || (is_percpu_thread() && cpu == smp_processor_id()))
+		return fn(arg);
+	return work_on_cpu(cpu, fn, arg);
+}
+#endif
+
 /* in processor_perflib.c */
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.21.0 (Apple Git-122.2)

