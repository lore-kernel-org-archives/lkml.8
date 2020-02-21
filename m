Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ADFC11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFCB207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DVvqhYQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgBUApR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:45:17 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5901 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbgBUApD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582245904; x=1613781904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IPAS6yclm5Rtrxut3fRpF0hirTRUW9g1npq5N6bdaGQ=;
  b=DVvqhYQGhzB8jCObWsJB/wrLxKVpdsCP6Ou9G03x5F+hliuqbJP540zP
   WR/cq8ymDOQBcIrIu7b6w1znvip2lIhSb08IHdEIkiqRR7g+Rc7Tb5dGZ
   WsipJp29sJUHIH42e0Pexd4+moDK9+up6zj4WDRq69gKLhs+FLXOkNCGV
   HHCEYTJF6Au2jZvTd4fUdNYZjk9cfb0He8zLyVwtThcxkkjsF5hZvDJfW
   9xT8RLXJctxZa2QyVO+4kRmlwRxOW5H4A6jCb0QZZU8/0dG+rBUzWa+VG
   Mq/UEbZNf/ppT3GMaIhjwcXTsE2PmuVzMZf7aDhUmjh8T71Mb0yEBz9i7
   g==;
IronPort-SDR: 4Giatt9VJr/m2HZTw7jGTrf6FBgQr/NKqS/ZcgWPo+ijw5ecka1O2mjYjWqv239s3jykxuiWVj
 RlZZdVyx9yVC/M4Ih/DVluSLsiM+kakqqNIYhRej6ePBjzvOjG87QiQ5mV9Tpqh4qWHou0eUJk
 qRpyAyytYZiINSbRnQG7pW6HM6t0g/j3tYnTNwrtjEcrYpPuMQFqbtWtm5BHXSe00Avl2ssFQd
 8XLGvyKSOH4bfc5Q1qRUWyvSD+d/rtu5fXHZg/agWJD/t6gZR2hZsX5/Cm0XOE2ASPF0HNDNlk
 tWs=
X-IronPort-AV: E=Sophos;i="5.70,466,1574092800"; 
   d="scan'208";a="130852797"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 08:44:49 +0800
IronPort-SDR: T9phc8jUbosHRr6XN7LmKDae9a7hD2+KG3yxI0vvJgPeLKspOlgRWWVdy9XpOuiB0cSZzv4qXq
 BtdZBDQ8ooxXMvo9So3OVoT9Pbih5wCuBnknAbtM8CqEevWCP2QwS+hG6izVo1Hns+VV/s4o8Z
 HwfSkn/dAS3I+zU9/9X4a0c+mmbAKazA/LFxQLLSVipMrBHsC1/Pq9OOEad1hzeh8k3y0fSt3l
 72jYqw9be5scOGe74J1sgIGNFceuK1atU8Q1Tuyn7CRDPpgleJxHy9Agkom0WOeg7Srwykszk5
 7E7m2VMNYz3nR9Nx0exWCMZj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:37:23 -0800
IronPort-SDR: pDNNGspifRjkaiMF3Q/w1NhhICvNWVHGZxpU8VZn1XMlWHUwdFWymlKjtnxtW2dNN4yHdRvVJz
 EQMSJ0Z65vgr5UVE/sPpAJqWyP2UOLxnTw/VGRNP92UNQasRIaVp0nxZj407zWdGUm/7w7jIcb
 saNPOp25/Ew4b4A6drvC2Qe7jQzWrsEQa5Ycr8Vg37ApRDNcsTKGBXjMu5pA9E1BRQ20uguk1S
 nn3nPmdfS8U8W19+BJcxupzP9oD3cAXmORejFQrS6u9OTf6f+vZ+padzxgLWKczmhcFFWbmQMb
 FoE=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2020 16:44:48 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v9 07/12] RISC-V: Add cpu_ops and modify default booting method
Date:   Thu, 20 Feb 2020 16:44:08 -0800
Message-Id: <20200221004413.12869-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221004413.12869-1-atish.patra@wdc.com>
References: <20200221004413.12869-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all non-booting harts start booting after the booting hart
updates the per-hart stack pointer. This is done in a way that, it's
difficult to implement any other booting method without breaking the
backward compatibility.

Define a cpu_ops method that allows to introduce other booting methods
in future. Modify the current booting method to be compatible with
cpu_ops.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/cpu_ops.h     | 34 +++++++++++++++++++
 arch/riscv/kernel/Makefile           |  2 ++
 arch/riscv/kernel/cpu_ops.c          | 38 +++++++++++++++++++++
 arch/riscv/kernel/cpu_ops_spinwait.c | 42 +++++++++++++++++++++++
 arch/riscv/kernel/smpboot.c          | 51 ++++++++++++++++------------
 5 files changed, 146 insertions(+), 21 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpu_ops.h
 create mode 100644 arch/riscv/kernel/cpu_ops.c
 create mode 100644 arch/riscv/kernel/cpu_ops_spinwait.c

diff --git a/arch/riscv/include/asm/cpu_ops.h b/arch/riscv/include/asm/cpu_ops.h
new file mode 100644
index 000000000000..daf29f70407d
--- /dev/null
+++ b/arch/riscv/include/asm/cpu_ops.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2019 Western Digital Corporation or its affiliates.
+ * Based on arch/arm64/include/asm/cpu_ops.h
+ */
+#ifndef __ASM_CPU_OPS_H
+#define __ASM_CPU_OPS_H
+
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/threads.h>
+
+/**
+ * struct cpu_operations - Callback operations for hotplugging CPUs.
+ *
+ * @name:		Name of the boot protocol.
+ * @cpu_prepare:	Early one-time preparation step for a cpu. If there
+ *			is a mechanism for doing so, tests whether it is
+ *			possible to boot the given HART.
+ * @cpu_start:		Boots a cpu into the kernel.
+ */
+struct cpu_operations {
+	const char	*name;
+	int		(*cpu_prepare)(unsigned int cpu);
+	int		(*cpu_start)(unsigned int cpu,
+				     struct task_struct *tidle);
+};
+
+extern const struct cpu_operations *cpu_ops[NR_CPUS];
+void __init cpu_set_ops(int cpu);
+void cpu_update_secondary_bootdata(unsigned int cpuid,
+				   struct task_struct *tidle);
+
+#endif /* ifndef __ASM_CPU_OPS_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f40205cb9a22..f81a6ff88005 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -32,6 +32,8 @@ obj-$(CONFIG_RISCV_M_MODE)	+= clint.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
+obj-$(CONFIG_SMP)		+= cpu_ops.o
+obj-$(CONFIG_SMP)		+= cpu_ops_spinwait.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 
diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
new file mode 100644
index 000000000000..e950ae5bee9c
--- /dev/null
+++ b/arch/riscv/kernel/cpu_ops.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/string.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <asm/cpu_ops.h>
+#include <asm/sbi.h>
+#include <asm/smp.h>
+
+const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
+
+void *__cpu_up_stack_pointer[NR_CPUS];
+void *__cpu_up_task_pointer[NR_CPUS];
+
+extern const struct cpu_operations cpu_ops_spinwait;
+
+void cpu_update_secondary_bootdata(unsigned int cpuid,
+				   struct task_struct *tidle)
+{
+	int hartid = cpuid_to_hartid_map(cpuid);
+
+	/* Make sure tidle is updated */
+	smp_mb();
+	WRITE_ONCE(__cpu_up_stack_pointer[hartid],
+		  task_stack_page(tidle) + THREAD_SIZE);
+	WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
+}
+
+void __init cpu_set_ops(int cpuid)
+{
+	cpu_ops[cpuid] = &cpu_ops_spinwait;
+}
diff --git a/arch/riscv/kernel/cpu_ops_spinwait.c b/arch/riscv/kernel/cpu_ops_spinwait.c
new file mode 100644
index 000000000000..f828e660294e
--- /dev/null
+++ b/arch/riscv/kernel/cpu_ops_spinwait.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/errno.h>
+#include <linux/of.h>
+#include <linux/string.h>
+#include <asm/cpu_ops.h>
+#include <asm/sbi.h>
+#include <asm/smp.h>
+
+const struct cpu_operations cpu_ops_spinwait;
+
+static int spinwait_cpu_prepare(unsigned int cpuid)
+{
+	if (!cpu_ops_spinwait.cpu_start) {
+		pr_err("cpu start method not defined for CPU [%d]\n", cpuid);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static int spinwait_cpu_start(unsigned int cpuid, struct task_struct *tidle)
+{
+	/*
+	 * In this protocol, all cpus boot on their own accord.  _start
+	 * selects the first cpu to boot the kernel and causes the remainder
+	 * of the cpus to spin in a loop waiting for their stack pointer to be
+	 * setup by that main cpu.  Writing to bootdata (i.e __cpu_up_stack_pointer) signals to
+	 * the spinning cpus that they can continue the boot process.
+	 */
+	cpu_update_secondary_bootdata(cpuid, tidle);
+
+	return 0;
+}
+
+const struct cpu_operations cpu_ops_spinwait = {
+	.name		= "spinwait",
+	.cpu_prepare	= spinwait_cpu_prepare,
+	.cpu_start	= spinwait_cpu_start,
+};
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 8bc01f0ca73b..e89396a2a1af 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -25,6 +25,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
 #include <asm/clint.h>
+#include <asm/cpu_ops.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -34,8 +35,6 @@
 
 #include "head.h"
 
-void *__cpu_up_stack_pointer[NR_CPUS];
-void *__cpu_up_task_pointer[NR_CPUS];
 static DECLARE_COMPLETION(cpu_running);
 
 void __init smp_prepare_boot_cpu(void)
@@ -46,6 +45,7 @@ void __init smp_prepare_boot_cpu(void)
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpuid;
+	int ret;
 
 	/* This covers non-smp usecase mandated by "nosmp" option */
 	if (max_cpus == 0)
@@ -54,6 +54,11 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for_each_possible_cpu(cpuid) {
 		if (cpuid == smp_processor_id())
 			continue;
+		if (cpu_ops[cpuid]->cpu_prepare) {
+			ret = cpu_ops[cpuid]->cpu_prepare(cpuid);
+			if (ret)
+				continue;
+		}
 		set_cpu_present(cpuid, true);
 	}
 }
@@ -65,6 +70,8 @@ void __init setup_smp(void)
 	bool found_boot_cpu = false;
 	int cpuid = 1;
 
+	cpu_set_ops(0);
+
 	for_each_of_cpu_node(dn) {
 		hart = riscv_of_processor_hartid(dn);
 		if (hart < 0)
@@ -92,36 +99,38 @@ void __init setup_smp(void)
 			cpuid, nr_cpu_ids);
 
 	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
-		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID)
+		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID) {
+			cpu_set_ops(cpuid);
 			set_cpu_possible(cpuid, true);
+		}
 	}
 }
 
+int start_secondary_cpu(int cpu, struct task_struct *tidle)
+{
+	if (cpu_ops[cpu]->cpu_start)
+		return cpu_ops[cpu]->cpu_start(cpu, tidle);
+
+	return -EOPNOTSUPP;
+}
+
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int ret = 0;
-	int hartid = cpuid_to_hartid_map(cpu);
 	tidle->thread_info.cpu = cpu;
 
-	/*
-	 * On RISC-V systems, all harts boot on their own accord.  Our _start
-	 * selects the first hart to boot the kernel and causes the remainder
-	 * of the harts to spin in a loop waiting for their stack pointer to be
-	 * setup by that main hart.  Writing __cpu_up_stack_pointer signals to
-	 * the spinning harts that they can continue the boot process.
-	 */
-	smp_mb();
-	WRITE_ONCE(__cpu_up_stack_pointer[hartid],
-		  task_stack_page(tidle) + THREAD_SIZE);
-	WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
-
-	lockdep_assert_held(&cpu_running);
-	wait_for_completion_timeout(&cpu_running,
+	ret = start_secondary_cpu(cpu, tidle);
+	if (!ret) {
+		lockdep_assert_held(&cpu_running);
+		wait_for_completion_timeout(&cpu_running,
 					    msecs_to_jiffies(1000));
 
-	if (!cpu_online(cpu)) {
-		pr_crit("CPU%u: failed to come online\n", cpu);
-		ret = -EIO;
+		if (!cpu_online(cpu)) {
+			pr_crit("CPU%u: failed to come online\n", cpu);
+			ret = -EIO;
+		}
+	} else {
+		pr_crit("CPU%u: failed to start\n", cpu);
 	}
 
 	return ret;
-- 
2.25.0

