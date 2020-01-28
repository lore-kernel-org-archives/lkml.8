Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D59DC33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B1E24682
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LIgLV08R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgA1C2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:28:20 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43178 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgA1C2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 21:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580178492; x=1611714492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9/4+D4chKrcwV4CoOuuG7G2FPWLBcuIllOhB7t6PGOY=;
  b=LIgLV08RLif9JE0H93kY2We98+YoxLzVFujVeFq0YB+kYIkYqC1h2zqj
   zZxdbve8d96zpTFskLWZmdbSEMCnlyBhXeegW3Y8QBkjD0O1jR+Aj06Vr
   gue9Y2CQbRDfGTqyYH5GVBdUII5heZ6wsWTs37BsFQjLBVY34X7aJS/jF
   M8k64LHkGRkRPUG4G/7D/tGFaqr8gVRL7paQYA94RiddhN2xaKjhDb5x5
   OKMQrW1Oo2CXLzT7RTh0bHClI8zIB9op4HLQsbOK2SlHMou0PmgNbzFRS
   ysEoVnHBQKX0b9Y4ZOdP40vhuU47g4MXV5umhogxMs9qbbBoa8UN0H6CU
   A==;
IronPort-SDR: lgKogYmfC9p241VSpCU37QIJHQdtL0TaW8Wig5cLJ8XKriC+zNKGhBVBNV4PGJobZCy+NEw7Hu
 psmH63nc0l57VO2j4G4BsYVlo4WTuLW6ASMzPpdkno7F90/gk9uwe9r3Xt0rp2MOvGR0VV/xKH
 bFpn9B1YROXvidnLDnxElsk3ASfK3PYlqbSqns+eNch3VLuIe9sdapJtR+julgqV+GxnZUWvv6
 y5UvMqlc04jjE1KFMprqfxw+5u+GQ8EfRMQlNBu7h8/1DVTyveKZPUCmRK5jrDJS/wpIU/Le9S
 j+8=
X-IronPort-AV: E=Sophos;i="5.70,372,1574092800"; 
   d="scan'208";a="132899438"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2020 10:28:11 +0800
IronPort-SDR: kEY1WUG8xzEten53ulog+TmXOJZ2laQgPfK0qGtfeWW8f4YZIHgj0Xfzd6TBv2Pu/BrCzFyp9L
 gOcCihyvq6HK1JX8m9QhmtxMI2Fs+kqG3Gt/fX51PtpinzvRwbSg/6aT8pkaNp/yEe81TNLKaS
 FGTrE62RU2tBNOSfPcy3V4g6QbwOGzHvmQZbhZXqhT/VQu58ehYoe7RMjQghBFZCdhZUsAIpX/
 fFdadgubR9R12+Oikpa6INiDLED+OZO3O27OjFgX3UfiGd9vG+aFl9/RY4ILmQ2jAHgCPStdoZ
 E+5l5VUqEQ++gB+MjQF9vdmQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 18:21:26 -0800
IronPort-SDR: L5w45/D70nhTLbCM68m93MH+z7Ithd6pTtaen98yHchkqQi1Gb85CnBL37T4Fz9F+NWCEKWau3
 sUqYKhIm3odCScr0S2X6l0gd85Wu+yoH7/4dgR+IT98AMMlG8k0o39O9PrMgSQQ7/j2C8cXvC4
 wCwoxxOOfpx67v+lqZVry+RAIEoJdQXjIi3P7ZTB1+xj9S/1eh9K3kbuYSyxVsca78WL7QL4m9
 HXLNJl3heH8wnvMNj4p3SnJuSnJ3vI0w+CQoYY+QFz2oyA2bXbgtxVpoA4PAMAplG2duuc8Dis
 OH8=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2020 18:28:11 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>, abner.chang@hpe.com,
        clin@suse.com, nickhu@andestech.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v7 09/10] RISC-V: Add supported for ordered booting method using HSM
Date:   Mon, 27 Jan 2020 18:27:36 -0800
Message-Id: <20200128022737.15371-10-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200128022737.15371-1-atish.patra@wdc.com>
References: <20200128022737.15371-1-atish.patra@wdc.com>
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
 arch/riscv/kernel/cpu_ops.c | 41 ++++++++++++++++++++++++++++++++++++-
 arch/riscv/kernel/head.S    | 25 ++++++++++++++++++++++
 arch/riscv/kernel/smpboot.c |  2 +-
 arch/riscv/kernel/traps.c   |  2 +-
 4 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
index 099dbb6ff9f0..454df032066f 100644
--- a/arch/riscv/kernel/cpu_ops.c
+++ b/arch/riscv/kernel/cpu_ops.c
@@ -17,9 +17,13 @@ const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
 
 void *__cpu_up_stack_pointer[NR_CPUS];
 void *__cpu_up_task_pointer[NR_CPUS];
+extern char secondary_start_sbi[];
 
+const struct cpu_operations cpu_sbi_ops;
 const struct cpu_operations cpu_spinwait_ops;
 
+#define RISCV_HART_FIRMWARE_STOPPED 0
+
 static int spinwait_cpu_prepare(unsigned int cpuid)
 {
 	if (!cpu_spinwait_ops.cpu_start) {
@@ -29,6 +33,32 @@ static int spinwait_cpu_prepare(unsigned int cpuid)
 	return 0;
 }
 
+static int sbi_cpu_prepare(unsigned int cpuid)
+{
+	if (!cpu_sbi_ops.cpu_start) {
+		pr_err("cpu start method not defined for CPU [%d]\n", cpuid);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
+{
+	int rc;
+	int hartid = cpuid_to_hartid_map(cpuid);
+	unsigned long boot_addr = __pa_symbol(secondary_start_sbi);
+
+	/* Make sure tidle is updated */
+	smp_mb();
+	WRITE_ONCE(__cpu_up_stack_pointer[hartid],
+		  task_stack_page(tidle) + THREAD_SIZE);
+	WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
+
+	rc = sbi_hsm_hart_start(hartid, boot_addr, 0);
+
+	return rc;
+}
+
 static int spinwait_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 {
 	int hartid = cpuid_to_hartid_map(cpuid);
@@ -48,6 +78,12 @@ static int spinwait_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 	return 0;
 }
 
+const struct cpu_operations cpu_sbi_ops = {
+	.name		= "sbi",
+	.cpu_prepare	= sbi_cpu_prepare,
+	.cpu_start	= sbi_cpu_start,
+};
+
 const struct cpu_operations cpu_spinwait_ops = {
 	.name		= "spinwait",
 	.cpu_prepare	= spinwait_cpu_prepare,
@@ -56,6 +92,9 @@ const struct cpu_operations cpu_spinwait_ops = {
 
 int __init cpu_set_ops(int cpuid)
 {
-	cpu_ops[cpuid] = &cpu_spinwait_ops;
+	if (sbi_hsm_is_available())
+		cpu_ops[cpuid] = &cpu_sbi_ops;
+	else
+		cpu_ops[cpuid] = &cpu_spinwait_ops;
 	return 0;
 }
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 9d7f084a50cc..3c93973667c8 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -210,11 +210,36 @@ relocate:
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
 	.global secondary_start_common
 secondary_start_common:
 
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index f2cf541bc895..8ac9115001b9 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -144,7 +144,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 /*
  * C entry point for a secondary processor.
  */
-asmlinkage __visible void __init smp_callin(void)
+asmlinkage __visible void smp_callin(void)
 {
 	struct mm_struct *mm = &init_mm;
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f4cad5163bf2..0063dd7318d6 100644
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
2.24.0

