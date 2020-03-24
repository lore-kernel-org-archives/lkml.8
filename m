Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A154C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60A820789
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgCXOYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:24:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45068 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbgCXOYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGkTE-0006zA-OC; Tue, 24 Mar 2020 15:23:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 645371C0475;
        Tue, 24 Mar 2020 15:23:56 +0100 (CET)
Date:   Tue, 24 Mar 2020 14:23:56 -0000
From:   "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Add steal time clock support for VMware guests
Cc:     Alexey Makhalov <amakhalov@vmware.com>,
        Tomer Zeltzer <tomerr90@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323195707.31242-4-amakhalov@vmware.com>
References: <20200323195707.31242-4-amakhalov@vmware.com>
MIME-Version: 1.0
Message-ID: <158505983605.28353.17805135011922181422.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     ab02bb3f55f58e7608a88188000c3353398ebe3b
Gitweb:        https://git.kernel.org/tip/ab02bb3f55f58e7608a88188000c3353398ebe3b
Author:        Alexey Makhalov <amakhalov@vmware.com>
AuthorDate:    Mon, 23 Mar 2020 19:57:05 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 10:04:51 +01:00

x86/vmware: Add steal time clock support for VMware guests

Steal time is the amount of CPU time needed by a guest virtual machine
that is not provided by the host. Steal time occurs when the host
allocates this CPU time elsewhere, for example, to another guest.

Steal time can be enabled by adding the VM configuration option
stealclock.enable = "TRUE". It is supported by VMs that run hardware
version 13 or newer.

Introduce the VMware steal time infrastructure. The high level code
(such as enabling, disabling and hot-plug routines) was derived from KVM.

 [ Tomer: use READ_ONCE macros and 32bit guests support. ]
 [ bp: Massage. ]

Co-developed-by: Tomer Zeltzer <tomerr90@gmail.com>
Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Signed-off-by: Tomer Zeltzer <tomerr90@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200323195707.31242-4-amakhalov@vmware.com
---
 arch/x86/kernel/cpu/vmware.c | 197 ++++++++++++++++++++++++++++++++++-
 1 file changed, 197 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index efb22fa..cc60461 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -25,6 +25,8 @@
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/clocksource.h>
+#include <linux/cpu.h>
+#include <linux/reboot.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
@@ -47,6 +49,11 @@
 #define VMWARE_CMD_GETVCPU_INFO  68
 #define VMWARE_CMD_LEGACY_X2APIC  3
 #define VMWARE_CMD_VCPU_RESERVED 31
+#define VMWARE_CMD_STEALCLOCK    91
+
+#define STEALCLOCK_NOT_AVAILABLE (-1)
+#define STEALCLOCK_DISABLED        0
+#define STEALCLOCK_ENABLED         1
 
 #define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
 	__asm__("inl (%%dx), %%eax" :					\
@@ -86,6 +93,18 @@
 	}							\
 	} while (0)
 
+struct vmware_steal_time {
+	union {
+		uint64_t clock;	/* stolen time counter in units of vtsc */
+		struct {
+			/* only for little-endian */
+			uint32_t clock_low;
+			uint32_t clock_high;
+		};
+	};
+	uint64_t reserved[7];
+};
+
 static unsigned long vmware_tsc_khz __ro_after_init;
 static u8 vmware_hypercall_mode     __ro_after_init;
 
@@ -104,6 +123,8 @@ static unsigned long vmware_get_tsc_khz(void)
 #ifdef CONFIG_PARAVIRT
 static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
 static int vmw_sched_clock __initdata = 1;
+static DEFINE_PER_CPU_DECRYPTED(struct vmware_steal_time, vmw_steal_time) __aligned(64);
+static bool has_steal_clock;
 
 static __init int setup_vmw_sched_clock(char *s)
 {
@@ -135,6 +156,163 @@ static void __init vmware_cyc2ns_setup(void)
 	pr_info("using clock offset of %llu ns\n", d->cyc2ns_offset);
 }
 
+static int vmware_cmd_stealclock(uint32_t arg1, uint32_t arg2)
+{
+	uint32_t result, info;
+
+	asm volatile (VMWARE_HYPERCALL :
+		"=a"(result),
+		"=c"(info) :
+		"a"(VMWARE_HYPERVISOR_MAGIC),
+		"b"(0),
+		"c"(VMWARE_CMD_STEALCLOCK),
+		"d"(0),
+		"S"(arg1),
+		"D"(arg2) :
+		"memory");
+	return result;
+}
+
+static bool stealclock_enable(phys_addr_t pa)
+{
+	return vmware_cmd_stealclock(upper_32_bits(pa),
+				     lower_32_bits(pa)) == STEALCLOCK_ENABLED;
+}
+
+static int __stealclock_disable(void)
+{
+	return vmware_cmd_stealclock(0, 1);
+}
+
+static void stealclock_disable(void)
+{
+	__stealclock_disable();
+}
+
+static bool vmware_is_stealclock_available(void)
+{
+	return __stealclock_disable() != STEALCLOCK_NOT_AVAILABLE;
+}
+
+/**
+ * vmware_steal_clock() - read the per-cpu steal clock
+ * @cpu:            the cpu number whose steal clock we want to read
+ *
+ * The function reads the steal clock if we are on a 64-bit system, otherwise
+ * reads it in parts, checking that the high part didn't change in the
+ * meantime.
+ *
+ * Return:
+ *      The steal clock reading in ns.
+ */
+static uint64_t vmware_steal_clock(int cpu)
+{
+	struct vmware_steal_time *steal = &per_cpu(vmw_steal_time, cpu);
+	uint64_t clock;
+
+	if (IS_ENABLED(CONFIG_64BIT))
+		clock = READ_ONCE(steal->clock);
+	else {
+		uint32_t initial_high, low, high;
+
+		do {
+			initial_high = READ_ONCE(steal->clock_high);
+			/* Do not reorder initial_high and high readings */
+			virt_rmb();
+			low = READ_ONCE(steal->clock_low);
+			/* Keep low reading in between */
+			virt_rmb();
+			high = READ_ONCE(steal->clock_high);
+		} while (initial_high != high);
+
+		clock = ((uint64_t)high << 32) | low;
+	}
+
+	return mul_u64_u32_shr(clock, vmware_cyc2ns.cyc2ns_mul,
+			     vmware_cyc2ns.cyc2ns_shift);
+}
+
+static void vmware_register_steal_time(void)
+{
+	int cpu = smp_processor_id();
+	struct vmware_steal_time *st = &per_cpu(vmw_steal_time, cpu);
+
+	if (!has_steal_clock)
+		return;
+
+	if (!stealclock_enable(slow_virt_to_phys(st))) {
+		has_steal_clock = false;
+		return;
+	}
+
+	pr_info("vmware-stealtime: cpu %d, pa %llx\n",
+		cpu, (unsigned long long) slow_virt_to_phys(st));
+}
+
+static void vmware_disable_steal_time(void)
+{
+	if (!has_steal_clock)
+		return;
+
+	stealclock_disable();
+}
+
+static void vmware_guest_cpu_init(void)
+{
+	if (has_steal_clock)
+		vmware_register_steal_time();
+}
+
+static void vmware_pv_guest_cpu_reboot(void *unused)
+{
+	vmware_disable_steal_time();
+}
+
+static int vmware_pv_reboot_notify(struct notifier_block *nb,
+				unsigned long code, void *unused)
+{
+	if (code == SYS_RESTART)
+		on_each_cpu(vmware_pv_guest_cpu_reboot, NULL, 1);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vmware_pv_reboot_nb = {
+	.notifier_call = vmware_pv_reboot_notify,
+};
+
+#ifdef CONFIG_SMP
+static void __init vmware_smp_prepare_boot_cpu(void)
+{
+	vmware_guest_cpu_init();
+	native_smp_prepare_boot_cpu();
+}
+
+static int vmware_cpu_online(unsigned int cpu)
+{
+	local_irq_disable();
+	vmware_guest_cpu_init();
+	local_irq_enable();
+	return 0;
+}
+
+static int vmware_cpu_down_prepare(unsigned int cpu)
+{
+	local_irq_disable();
+	vmware_disable_steal_time();
+	local_irq_enable();
+	return 0;
+}
+#endif
+
+static __init int activate_jump_labels(void)
+{
+	if (has_steal_clock)
+		static_key_slow_inc(&paravirt_steal_enabled);
+
+	return 0;
+}
+arch_initcall(activate_jump_labels);
+
 static void __init vmware_paravirt_ops_setup(void)
 {
 	pv_info.name = "VMware hypervisor";
@@ -148,6 +326,25 @@ static void __init vmware_paravirt_ops_setup(void)
 	if (vmw_sched_clock)
 		pv_ops.time.sched_clock = vmware_sched_clock;
 
+	if (vmware_is_stealclock_available()) {
+		has_steal_clock = true;
+		pv_ops.time.steal_clock = vmware_steal_clock;
+
+		/* We use reboot notifier only to disable steal clock */
+		register_reboot_notifier(&vmware_pv_reboot_nb);
+
+#ifdef CONFIG_SMP
+		smp_ops.smp_prepare_boot_cpu =
+			vmware_smp_prepare_boot_cpu;
+		if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					      "x86/vmware:online",
+					      vmware_cpu_online,
+					      vmware_cpu_down_prepare) < 0)
+			pr_err("vmware_guest: Failed to install cpu hotplug callbacks\n");
+#else
+		vmware_guest_cpu_init();
+#endif
+	}
 }
 #else
 #define vmware_paravirt_ops_setup() do {} while (0)
