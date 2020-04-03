Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57923C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEB32137B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GcUvroT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390861AbgDCOEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:04:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32951 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgDCOEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:04:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id v7so8065764qkc.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U37IOV9My/sXAuKgjhUoPEFREDDm1NINYe8Uc9B8Osc=;
        b=GcUvroT51pUTRFa/ZEZHhmyyF/qXdGZFB919DPh5Fkt9znyOAcEOEHMmZURLTVIkuF
         ltsn9vtrA3fydKbT5P2MX9C61ys6WULWmu5OCb/o50zfGaCdb9Kf3gAsANx/Tg1ywXK5
         zBBGyz/UqSA6ZHC0o6GvhiQilgsgsmobh/fSDT9Y2vXgU9YE+SGicEVDsGuSBCq0FhTQ
         Q8l0GXoHIrOJ0FfqgleAVye/X2njxQ7t5/tb/TCULTxh84NYRO4+XwZ9jGJcGJrP2rMU
         +aO234OHMWbC720J0Ue2RHXXid+ABJvCTRpstYjZMyqGd3+1bptw0NwOqANzBYRzTAD8
         r/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U37IOV9My/sXAuKgjhUoPEFREDDm1NINYe8Uc9B8Osc=;
        b=D9FyvskTH4G+KobAzc7kmDtzg9pQOqBIRcp1BHUmqIiGh/3l0ChogSMFCN4Nwts4vj
         Bo4G/tlAAb6SbDWpV2Y51zpBfn+J3alMQXgPpHXBGrcLfcB4D0j+lqjCJp3mVmsBRIbh
         8kECv6ciMcuMif8FqpXqSQQZriBurzWV5vZnlvOMcZSRPX+55fcH3+Ni1tSwclR8rory
         GeIshnhLZ4yYErwhkQWC8GUjau3YnTVHzwEzwU5K+fM4/h6EPFGxGYmwJo5P2zVnHYmy
         nI9acgEiez43Cao2v260SJHujpvKUOy209K9aRK8+GuSxH3j49kShP9eE/VZ0UqvDp0+
         KXLg==
X-Gm-Message-State: AGi0Pubo0gi5Jps9ZbNXaZfMDpfyAAFsTHqLaVV/HvllmU1Y3UPPJYTW
        nJllpxWleLSs3hmz8G4HKHL7lw==
X-Google-Smtp-Source: APiQypK+XL5zkFXQZAG0rBMVlDIrPZ4LhhymVrMddYD0VYC4wH3Ink1P1sUcRwdl95vG6O8DJuXkdg==
X-Received: by 2002:a37:4fc5:: with SMTP id d188mr8454370qkb.220.1585922640888;
        Fri, 03 Apr 2020 07:04:00 -0700 (PDT)
Received: from ovpn-66-203.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s26sm6192668qkm.114.2020.04.03.07.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 07:03:59 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, rjw@rjwysocki.net
Cc:     mingo@redhat.com, bp@alien8.de, lenb@kernel.org,
        peterz@infradead.org, linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v3] x86/acpi: fix a deadlock with cpu hotplug
Date:   Fri,  3 Apr 2020 10:03:45 -0400
Message-Id: <20200403140345.3828-1-cai@lca.pw>
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

v3:
Remove #ifdef since cstate.o should rather depend on ACPI_PROCESSOR_IDLE
per Rafael.

v2:
Make call_on_cpu() a static inline function to avoid a compilation
error when ACPI_PROCESSOR=m thanks to lkp@intel.com.

 arch/x86/kernel/acpi/cstate.c       | 3 ++-
 drivers/acpi/processor_throttling.c | 7 -------
 include/acpi/processor.h            | 8 ++++++++
 3 files changed, 10 insertions(+), 8 deletions(-)

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
index 47805172e73d..683e124ad517 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -297,6 +297,14 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 }
 #endif
 
+static inline int call_on_cpu(int cpu, long (*fn)(void *), void *arg,
+			      bool direct)
+{
+	if (direct || (is_percpu_thread() && cpu == smp_processor_id()))
+		return fn(arg);
+	return work_on_cpu(cpu, fn, arg);
+}
+
 /* in processor_perflib.c */
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.21.0 (Apple Git-122.2)

