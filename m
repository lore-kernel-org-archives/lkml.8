Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B40BC2D0E8
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 01:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1779620663
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 01:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jjW3f74k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgC2BG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 21:06:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45589 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbgC2BG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 21:06:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id t17so12095157qtn.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 18:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C0JtGXgMIsMvmmMbEBYZYxeET3jm62qllfdtyYybW84=;
        b=jjW3f74kOzt8y63INFJ1B3nvRWc/5TGCiFqhGjWsv1kkflAXNDkDmqd1GuNIenGLNg
         xHe6zdfBgzEL6zsP+M0hIZEsrfP5O7aDm1qTAh97iMcx8c3P0LWaIbRfG2TylWYYss2k
         RY8+0VxVgD93kqH8KgqEfmCz6NroQAadUGQS1813LUUGLQd9SHJiVqopDNIHCGJv5u9m
         2HP/vuR+TQCPBL3yylxo9heDvn3xe+lCYIXN5tyBvKMNzq2KLxgSvD2RldtB6uksScmU
         NIn+F4jBQTLaSMY8IGF0BviqbdWtFK+6twQFN2D98fa/qyornXwhzLlMrgJ8oB9ZaWf6
         yGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C0JtGXgMIsMvmmMbEBYZYxeET3jm62qllfdtyYybW84=;
        b=fzvmNLSrbD3UCC/DnFWqHyKHvBBc4V8xz5BUvuU9wRfOeY7606glPkg9UvR1Y6YAzh
         Pkol30/aa+HCTOeShYvJcqkOwWOKqXf3MBLxLGD9BnYOzOSD8kvdkQwpHNXQIj7QlbWt
         kVsmg5/wPjVV5dwdnwwBCbh2RGhHaL5PoKKaG1zsKDfkqRSN8kvoPkDYbDhI8vwVJq4M
         AsNNIDdm3HmvdjhX+e8wv5WKiYb3ie/lFjToukEcMUGMzbRe7n1v3gvfJc1mcdIE1dkZ
         WYabagOzzoIHkhHF0rxkZQRS0VJcEKbrmEYbLnuE8SvoUkhyvv9QDmAF5FDD1TKgA/W6
         NkcQ==
X-Gm-Message-State: ANhLgQ1HtvXb7kP9NATmRW+BjIBi2CefkwYtICVhP3KPeF916zkUfz1T
        SMDDzG0pYq51t1kNunJxoXqaKQ==
X-Google-Smtp-Source: ADFU+vu7NpbY3mk9CKOtjO9LFoyn8hdX9MbVxvt9pXFYfUXgjNwObn0l9ANYrYHUqxHS1fqpFuYuEA==
X-Received: by 2002:aed:3244:: with SMTP id y62mr6122525qtd.242.1585444016781;
        Sat, 28 Mar 2020 18:06:56 -0700 (PDT)
Received: from ovpn-66-71.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n21sm7693768qtn.17.2020.03.28.18.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 18:06:55 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, rjw@rjwysocki.net, lenb@kernel.org,
        peterz@infradead.org, linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] x86/acpi: fix a deadlock with cpu hotplug
Date:   Sat, 28 Mar 2020 21:06:40 -0400
Message-Id: <20200329010640.14251-1-cai@lca.pw>
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
declare call_on_cpu() from for processor_throttling.c as an external
function and use it in cstate.c.

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
 arch/x86/kernel/acpi/cstate.c       | 3 ++-
 drivers/acpi/processor_throttling.c | 2 +-
 include/acpi/processor.h            | 3 +++
 3 files changed, 6 insertions(+), 2 deletions(-)

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
index 532a1ae3595a..122f63cacd86 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -897,7 +897,7 @@ static long __acpi_processor_get_throttling(void *data)
 	return pr->throttling.acpi_processor_get_throttling(pr);
 }
 
-static int call_on_cpu(int cpu, long (*fn)(void *), void *arg, bool direct)
+int call_on_cpu(int cpu, long (*fn)(void *), void *arg, bool direct)
 {
 	if (direct || (is_percpu_thread() && cpu == smp_processor_id()))
 		return fn(arg);
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 47805172e73d..9569b3467553 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -297,6 +297,9 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 }
 #endif
 
+/* in processor_throttling.c */
+int call_on_cpu(int cpu, long (*fn)(void *), void *arg, bool direct);
+
 /* in processor_perflib.c */
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.21.0 (Apple Git-122.2)

