Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BDFC35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CAA2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bnl29Hun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgBLBwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 20:52:10 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60376 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgBLBv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581472317; x=1613008317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zJTVe1D9nhTrVxWl9u6c1zknXKl4UCVgI0tm6GTnV40=;
  b=bnl29HuniPqUC1Ce9zaDTXjGWK1d31Xcg1+AHJdErlAOaXkSIehRAUNz
   mVPYbZADLot+3ailByIKiAVKzx6uCjkdlYDhYV+V7sVpnfWI39wVWJ2us
   XNcQGriul+f2mwoIC7jRfiBUKdqHyw17ILvq4IIyeIZ6cpHE7bVUlblpu
   Z+TQiLBIPSTwcBOWqiL+ngEtCAbJOz6g68JjSXYbPfGfeJ+Glu84PCebA
   onodF4VlBCU/a9OvuodyEW009Ux0jXJU9BAQqgRAAXA4SKc1qBER8xQes
   LmtkFGQpkpbVyXMHatgA7WMXHKFrLpLgh5LSWmQyJ9eUn0vluuu1hAYrR
   g==;
IronPort-SDR: hXBu5XONY31lkDk85WO6nb2HGbquyQLzy/1yH0j/nfdH6xb8H+oBMlvvd0zS0As1wjUmEM5Ppm
 zJjdTOqYiq1UO9ANk5iio72sTV2X2VecST5QSCiEN/bPned9b7H1hlkW27UI5PGDTnaeEg8yJX
 QZIangAXE+AHm1cRjyxh/QcI2vUiSp+PTH0uozgjU8RTtzd07+boafjrlH56Ql1gTSdy41Z9aD
 IGOSeUVoNBnlLZGUQ8dcjwagMaU+c+mhySGElL6nr6cJc7RbOLxEB8kVWvycVJbzjNGpH9o2o/
 ABs=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="237648956"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 09:51:56 +0800
IronPort-SDR: SiLiav9B1OmHqpie8v52hHJRvc4dn6D40TXiXHqQHdmx7A+UfLdWz1u9u+9zReevhLLdUcfRLo
 HZWLqKsBI6chcmqa6IV87CJY9yNToIeYOitgZ51Rrsxa7ZDHiAA0CLuqIk6j5bExRqB/hH3Wbw
 3TqQPyjxO8e4Srb6IcinLm32hlbzPytZYMpIQjDwiOUdMiBxQ6AcJrBt0dAYEGlJ0Ko/VH6skR
 SESMOQY2BBZ4y9+ms0L6sB2UlAZWUdH18bUxILB6dKSUDMNH3J33loChcGMYXXtPqump095irn
 Szvl/U/rGqnNmdodosSGss9y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 17:44:46 -0800
IronPort-SDR: NcODoFZall0iSabbvf4O22W8dEzev9T0ZY7Y2FevX58TgGpsx2zpOM1vHyMO9N/SrOMWsXhzLv
 PcJrAJpmWRe+TS56JR0Eniyhith87XooDhdnpt8HSS9ok2doXBDD4bNVh/yZ188WEIiGSPMgTY
 AIy2cFhXSpfpVufN0uT+eIp/JUyqnhVGu3G9v+uDlxDUcVxGlfqPmdZEgKQKyrsZk8n6y0MHCw
 g3PXyPtmdECYGlwzAN0g+2MlzXYFC/IurqEQfH8dT1tv8C0rgBy81gj36PVv9Tc9e2lt/TAcSt
 SDg=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 17:51:56 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v8 09/11] RISC-V: Add supported for ordered booting method using HSM
Date:   Tue, 11 Feb 2020 17:48:20 -0800
Message-Id: <20200212014822.28684-10-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212014822.28684-1-atish.patra@wdc.com>
References: <20200212014822.28684-1-atish.patra@wdc.com>
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
 arch/riscv/kernel/cpu_ops.c     | 10 +++++++++-
 arch/riscv/kernel/cpu_ops_sbi.c | 31 +++++++++++++++++++++++++++++++
 arch/riscv/kernel/head.S        | 26 ++++++++++++++++++++++++++
 arch/riscv/kernel/smpboot.c     |  2 +-
 arch/riscv/kernel/traps.c       |  2 +-
 5 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
index 1085def3735a..6221bbedaea4 100644
--- a/arch/riscv/kernel/cpu_ops.c
+++ b/arch/riscv/kernel/cpu_ops.c
@@ -18,6 +18,7 @@ const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
 void *__cpu_up_stack_pointer[NR_CPUS];
 void *__cpu_up_task_pointer[NR_CPUS];
 
+extern const struct cpu_operations cpu_ops_sbi;
 extern const struct cpu_operations cpu_ops_spinwait;
 
 void cpu_update_secondary_bootdata(unsigned int cpuid,
@@ -34,7 +35,14 @@ void cpu_update_secondary_bootdata(unsigned int cpuid,
 
 int __init cpu_set_ops(int cpuid)
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
 
 	return 0;
 }
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index 9bdb60e0a4df..31487a80c3b8 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -7,9 +7,13 @@
 
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <asm/cpu_ops.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
 
+extern char secondary_start_sbi[];
+const struct cpu_operations cpu_ops_sbi;
+
 static int sbi_hsm_hart_stop(void)
 {
 	struct sbiret ret;
@@ -46,3 +50,30 @@ static int sbi_hsm_hart_get_status(unsigned long hartid)
 	else
 		return ret.value;
 }
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
index c1be597d22a1..8386cfafba98 100644
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
index 2ee41c779a16..2c56ac70e64d 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -146,7 +146,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
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

