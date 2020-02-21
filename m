Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA27C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B39D207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WkxLErPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgBUApJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:45:09 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5906 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbgBUApG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582245906; x=1613781906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0dyRb9zAXLp4QWHztutNURSgVdiAHA6cYNzlmqXm7d0=;
  b=WkxLErPqw96jbk+IayBBmKmubtEigYCdOT9fW2cngg2Ksnb97sq9/Vcg
   aZyAfmmaJc1kMh9nVZkZ88jT3aXtfU6HiDG9jrgu3JlcRI54uCNMRwyMt
   XTxTOjLQ0/6qKG6OtXRCAcX4mIhNbY9a64b4mAXqm4i17epQUzXIf1slr
   QZFeZjaQRP71HYXZi/EsEhcqQvhW0g6H1QRYkDRZTf3BNSXTwlvvPQ5cb
   l6WwQEVbfMfnIWXQ+KBLMg9UwsFELXpzq6ZOAGkCyLoNUlrViyW0XaFeE
   ndkMLCFdQt9I4xR2W6JEWp2SRbC24FOe+XNE1S8wr84fFi4XlfvCruOdo
   w==;
IronPort-SDR: PmRRbIvOppDzp6J0ztWQvsZUs/HteCr6l47XeIKHtIfNGfgxQa5n6AiIYT0M07gKjAoIk8LGkS
 CL/wB45mWBiGJy5xcvUNiDtjnN5Ph4oVgd6KfdRG0WaQtS0hu0PIXeq/xQxyAwi++AKW63RAYl
 VxV8KWohudtj3SUfagguH3eCktHIav3H4nGlHEYAK3TzONYdQp5/suWHiRWL+FpSXGWTJX1GEz
 SeGd4DUm9IxIOiiomY45TQ1TwKI59p/TOKWxgj6OIB0SfReceFb7yRynhQrvjGjUMSPB4dXC7K
 GOU=
X-IronPort-AV: E=Sophos;i="5.70,466,1574092800"; 
   d="scan'208";a="130852814"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 08:44:51 +0800
IronPort-SDR: 0Q8LSFGr3uURJKY7R01MPgg/sxzbIcOtn46Iep+Fz9ePOmsWyvZQMhfddGV5q1QnhMi/muhDPO
 9xi7ke5TUS12AYgSdYefNwMYU3gz+U7aeuEk7m7mV4Kie8a4qq51Tk2MQELcgAGYvecH+sdoyG
 MFXdz0pgv+8HP296DybsdtrMtziFhJH3kWktTnR4vVudnBhgwBOc85i8Nien08Xkr9sIFjAqF7
 P5Ow70rFcC4RD/Rfj5rnUSG4/ODxmT3pO1dNimvzxoqgPX7U4dgrIirO8q8x5Lb/46fle6DIyY
 Pvc3ZntobWEQGV5bYKFeWkEj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:37:24 -0800
IronPort-SDR: AMNS+57z7EiZ28OZgHP/i9KafQM6Ug6T5U78Bo6m5kcZkqacMjvG67F2bk+qWqs4FacH/encZx
 LVgH/BWn5UFtB7bnr1WFJfCXcXUKQU5CCTR6xzTUfZ38aljoFBxRr4lWempORinW9JCfIPC3rf
 9kQiEmx6g3QlJsfsWmd82r2Imi8QK2JU6f4KH92Xpwf8r8Z3tT6zK++sJd5+2aG1bgFO9ogxn2
 0+wIxLr2rne3/up1ofD+ousT8D+ve2dz7JxEeZWIe2wJXwcj9QLpVzI99LrCvJjt3kPPGfVhX0
 sbY=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2020 16:44:49 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
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
Subject: [PATCH v9 10/12] RISC-V: Add supported for ordered booting method using HSM
Date:   Thu, 20 Feb 2020 16:44:11 -0800
Message-Id: <20200221004413.12869-11-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221004413.12869-1-atish.patra@wdc.com>
References: <20200221004413.12869-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all harts have to jump Linux in RISC-V. This complicates the
multi-stage boot process as every transient stage also has to ensure all
harts enter to that stage and jump to Linux afterwards. It also obstructs
a clean Kexec implementation.

SBI HSM extension provides alternate solutions where only a single hart
need to boot and enter Linux. The booting hart can bring up secondary
harts one by one afterwards.

Add SBI HSM based cpu_ops that implements an ordered booting method in
RISC-V. This change is also backward compatible with older firmware not
implementing HSM extension. If a latest kernel is used with older
firmware, it will continue to use the default spinning booting method.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/Makefile      |  3 ++
 arch/riscv/kernel/cpu_ops.c     | 10 +++-
 arch/riscv/kernel/cpu_ops_sbi.c | 81 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/head.S        | 26 +++++++++++
 arch/riscv/kernel/smpboot.c     |  2 +-
 arch/riscv/kernel/traps.c       |  2 +-
 6 files changed, 121 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/kernel/cpu_ops_sbi.c

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f81a6ff88005..a0be34b96846 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -44,5 +44,8 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
+ifeq ($(CONFIG_RISCV_SBI), y)
+obj-$(CONFIG_SMP) += cpu_ops_sbi.o
+endif
 
 clean:
diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
index e950ae5bee9c..afa90f711a2b 100644
--- a/arch/riscv/kernel/cpu_ops.c
+++ b/arch/riscv/kernel/cpu_ops.c
@@ -18,6 +18,7 @@ const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
 void *__cpu_up_stack_pointer[NR_CPUS];
 void *__cpu_up_task_pointer[NR_CPUS];
 
+extern const struct cpu_operations cpu_ops_sbi;
 extern const struct cpu_operations cpu_ops_spinwait;
 
 void cpu_update_secondary_bootdata(unsigned int cpuid,
@@ -34,5 +35,12 @@ void cpu_update_secondary_bootdata(unsigned int cpuid,
 
 void __init cpu_set_ops(int cpuid)
 {
-	cpu_ops[cpuid] = &cpu_ops_spinwait;
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+	if (sbi_probe_extension(SBI_EXT_HSM) > 0) {
+		if (!cpuid)
+			pr_info("SBI v0.2 HSM extension detected\n");
+		cpu_ops[cpuid] = &cpu_ops_sbi;
+	} else
+#endif
+		cpu_ops[cpuid] = &cpu_ops_spinwait;
 }
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
new file mode 100644
index 000000000000..70d02dfe0ab8
--- /dev/null
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * HSM extension and cpu_ops implementation.
+ *
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <asm/cpu_ops.h>
+#include <asm/sbi.h>
+#include <asm/smp.h>
+
+extern char secondary_start_sbi[];
+const struct cpu_operations cpu_ops_sbi;
+
+static int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
+		       unsigned long priv)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_START,
+			      hartid, saddr, priv, 0, 0, 0);
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+	else
+		return 0;
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static int sbi_hsm_hart_stop(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_STOP, 0, 0, 0, 0, 0, 0);
+
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+	else
+		return 0;
+}
+
+static int sbi_hsm_hart_get_status(unsigned long hartid)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_STATUS,
+			      hartid, 0, 0, 0, 0, 0);
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+	else
+		return ret.value;
+}
+#endif
+
+static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
+{
+	int rc;
+	unsigned long boot_addr = __pa_symbol(secondary_start_sbi);
+	int hartid = cpuid_to_hartid_map(cpuid);
+
+	cpu_update_secondary_bootdata(cpuid, tidle);
+	rc = sbi_hsm_hart_start(hartid, boot_addr, 0);
+
+	return rc;
+}
+
+static int sbi_cpu_prepare(unsigned int cpuid)
+{
+	if (!cpu_ops_sbi.cpu_start) {
+		pr_err("cpu start method not defined for CPU [%d]\n", cpuid);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+const struct cpu_operations cpu_ops_sbi = {
+	.name		= "sbi",
+	.cpu_prepare	= sbi_cpu_prepare,
+	.cpu_start	= sbi_cpu_start,
+};
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index b85376d84098..ac5b0e0a02f6 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -99,11 +99,37 @@ relocate:
 	ret
 #endif /* CONFIG_MMU */
 #ifdef CONFIG_SMP
+	.global secondary_start_sbi
+secondary_start_sbi:
+	/* Mask all interrupts */
+	csrw CSR_IE, zero
+	csrw CSR_IP, zero
+
+	/* Load the global pointer */
+	.option push
+	.option norelax
+		la gp, __global_pointer$
+	.option pop
+
+	/*
+	 * Disable FPU to detect illegal usage of
+	 * floating point in kernel space
+	 */
+	li t0, SR_FS
+	csrc CSR_STATUS, t0
+
 	/* Set trap vector to spin forever to help debug */
 	la a3, .Lsecondary_park
 	csrw CSR_TVEC, a3
 
 	slli a3, a0, LGREG
+	la a4, __cpu_up_stack_pointer
+	la a5, __cpu_up_task_pointer
+	add a4, a3, a4
+	add a5, a3, a5
+	REG_L sp, (a4)
+	REG_L tp, (a5)
+
 	.global secondary_start_common
 secondary_start_common:
 
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index e89396a2a1af..4e9922790f6e 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -143,7 +143,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 /*
  * C entry point for a secondary processor.
  */
-asmlinkage __visible void __init smp_callin(void)
+asmlinkage __visible void smp_callin(void)
 {
 	struct mm_struct *mm = &init_mm;
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index ffb3d94bf0cc..8e13ad45ccaa 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -147,7 +147,7 @@ int is_valid_bugaddr(unsigned long pc)
 }
 #endif /* CONFIG_GENERIC_BUG */
 
-void __init trap_init(void)
+void trap_init(void)
 {
 	/*
 	 * Set sup0 scratch register to 0, indicating to exception vector
-- 
2.25.0

