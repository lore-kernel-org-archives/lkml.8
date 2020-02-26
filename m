Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857FAC4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4399D2467A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QSI63F2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgBZWC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:02:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45037 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgBZWCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582754544; x=1614290544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ppdd/KmLP3L/YfNatyXwLu2cXwjc99cL+VCNoHNDlAU=;
  b=QSI63F2mBPIEzqZhi98PiUqp7Byp2p5yz30gB2NKeCvU3Gdmu8PlcLSd
   SZJBMOjWjJS07ZY5+5xwo+MJKKqpcTNtBzRjw4W5dvNq3MIWvlyzPTw30
   M+/foA/t6pxJpEUT9LU3jnaqbEjjGs0Y68GVQgNoDs2vkudaYyr7GVKeV
   t3RinuEqfQ0abYpCSToKq3aGdqCEey29ODc2ljHSmh9502r+XPxixgjWJ
   zFLtwSn6dAsbw4HEuNVNCBszIaD3lgJ6cbU/7FoStpsFQKhIw/iJ0KIBT
   6c2x7vDkVW7piuxBYxP2yDY3CJg2uScdl5S0RoabWXqdK3X1/JrVlifiZ
   w==;
IronPort-SDR: vRsneTESHlZl7cxDjWNRPrIhBqIbudIDkACQU9ISroI6lwh6Zv88jISor4taVedUf2gPC5E4Cp
 qlqFDW88IZuiin285vjH/DPzfjFDKr+Pemw58vH3D19z1aIX98tKSxfrp1hV86qw3R5XoiFqU+
 P9T9cOuMtwFWtUXw47AlT3hdazzYSBnxmk7HG/Ds1qIeI2DfMxWfjQ01NDqO9mpKPdsaOnZz7T
 DgO8A0BaHIWGUC8eNZK5MdWmULudvp8sHv21YV4ZxZuNyKXhxK9BDfxgS48RGssBOVh6C+p9Vk
 FCA=
X-IronPort-AV: E=Sophos;i="5.70,489,1574092800"; 
   d="scan'208";a="132290735"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 06:02:24 +0800
IronPort-SDR: DSNnLcr0ANAhP7HTusmmuL4KbjJaskOEYnwRWH+IFrpnekw41qKnjDkkJR/rsJzomkon2yZR3q
 FIQwn4llTfg0q0GVq7rDuXUQMw9KFoA/ZNTViZ8dVSFUj9TFDjh7gGYDFWpZ670F0JE5JF6J6y
 wmij00DPu5MGb2oqVwB8lWlMV13TmLvWGLl50t22Dsjd20i9K2pSmsT0RixvDNxameV/B58E1C
 mPp8H16Jx5Y2FFvY9hXTSrK+n+ayBBs6aN8YDmeOe4kGq00hDp0VJyL9oRy5J1MGFoATPJXown
 J0MZ8/QBw4VW+qJsMWY4bTh2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:54:48 -0800
IronPort-SDR: +ESXG76l/zzWesS2B+VNsorTSBhBeD3jA5+RBRZYMn/GIacwH12JttYoY3HlWnAwFQt6+3O+Mi
 a6jsJD1vwLtwRqw9qEpOQue9OzHsYPmh12u12gl0LMmfV/3CssI0gOCQ6uk5W4BErJR5Kuabrr
 SUcV0q6tF+1ELVJbrkyNTHynr8W61MnKqcdWh6JYz6HGkUGwZIJppJsw0+y+0gQWrJ4uPpSn+i
 By9Z+eAuB/ypokXwhewrwhsko6GnbFBP7E6lkPL4YtvaYe/V1xPDKGptIVQyZgIudgLTN/pqrH
 2AI=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2020 14:02:23 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Gary Guo <gary@garyguo.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v10 07/12] RISC-V: Add cpu_ops and modify default booting method
Date:   Wed, 26 Feb 2020 14:02:08 -0800
Message-Id: <20200226220213.27423-8-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226220213.27423-1-atish.patra@wdc.com>
References: <20200226220213.27423-1-atish.patra@wdc.com>
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
index 000000000000..5ce81a28e1d9
--- /dev/null
+++ b/arch/riscv/include/asm/cpu_ops.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
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

