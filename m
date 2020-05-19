Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D09C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 390742075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589905132;
	bh=Z/8rE9knOR8VChmENUebS2xixgsDnEFY7lqcRpg4rjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TB4iD8Smn/PzHskc592N9rvlgKyHS3q124j8la3m5h4rpbcFbo6lVPmZA5FZe74nz
	 /P8n0o13RB+A+A7ANekOgi8UrwCS1vNCHKOHREJrMVvNtfxI67ojFoo3XC8ugsW9aw
	 xntLUgGHaxl46vTnvzabcCELxrG8KCDf/bV5CtNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgESQSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729370AbgESQSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:18:24 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E4820826;
        Tue, 19 May 2020 16:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905103;
        bh=Z/8rE9knOR8VChmENUebS2xixgsDnEFY7lqcRpg4rjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCIVoLNV4+2Gf+Ph0JsDrAIVLD30nfcCvQHNRkxPvV9yuqdXPmJkJlG9BqK7pxLum
         rH+A4umrrpBUGGRXvtJ7vBHamxEExvdiW7GEjMk+JTr5VpXChiJTQjCHpNNvjnMIn5
         MeiErQmwHM+OFQZKmD+egGCoJdh8r+dL9V3XK4Z8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jb4wg-00Decy-2x; Tue, 19 May 2020 17:18:22 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: [PATCH 03/11] arm64: Allow IPIs to be handled as normal interrupts
Date:   Tue, 19 May 2020 17:17:47 +0100
Message-Id: <20200519161755.209565-4-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519161755.209565-1-maz@kernel.org>
References: <20200519161755.209565-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to deal with IPIs as normal interrupts, let's add
a new way to register them with the architecture code.

set_smp_ipi_range() takes a range of interrupts, and allows
the arch code to request them as if the were normal interrupts.
A standard handler is then called by the core IRQ code to deal
with the IPI.

This means that we don't need to call irq_enter/irq_exit, and
that we don't need to deal with set_irq_regs either. So let's
move the dispatcher into its own function, and leave handle_IPI()
as a compatibility function.

On the sending side, let's make use of ipi_send_mask, which
already exists for this purpose.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/smp.h |  5 ++
 arch/arm64/kernel/smp.c      | 92 +++++++++++++++++++++++++++++++-----
 3 files changed, 86 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d513f461957..6a6271281016 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -99,6 +99,7 @@ config ARM64
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 40d5ba029615..42f366ba88bf 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -82,6 +82,11 @@ extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
 
 extern void (*__smp_cross_call)(const struct cpumask *, unsigned int);
 
+/*
+ * Register IPI interrupts with the arch SMP code
+ */
+extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
+
 /*
  * Called from the secondary holding pen, this is the secondary CPU entry point.
  */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 061f60fe452f..93ba0025e7b9 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -67,6 +67,13 @@ struct secondary_data secondary_data;
 /* Number of CPUs which aren't online, but looping in kernel text. */
 int cpus_stuck_in_kernel;
 
+static int ipi_irq_base;
+static int nr_ipi = NR_IPI;
+static struct irq_desc *ipi_desc[NR_IPI];
+
+static void ipi_setup(int cpu);
+static void ipi_teardown(int cpu);
+
 enum ipi_msg_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
@@ -247,6 +254,8 @@ asmlinkage notrace void secondary_start_kernel(void)
 	 */
 	notify_cpu_starting(cpu);
 
+	ipi_setup(cpu);
+
 	store_cpu_topology(cpu);
 	numa_add_cpu(cpu);
 
@@ -374,6 +383,8 @@ void cpu_die(void)
 
 	local_daif_mask();
 
+	ipi_teardown(cpu);
+
 	/* Tell __cpu_die() that this CPU is now safe to dispose of */
 	(void)cpu_report_death();
 
@@ -900,10 +911,9 @@ static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 /*
  * Main handler for inter-processor interrupts
  */
-void handle_IPI(int ipinr, struct pt_regs *regs)
+static void do_handle_IPI(int ipinr)
 {
 	unsigned int cpu = smp_processor_id();
-	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	if ((unsigned)ipinr < NR_IPI) {
 		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
@@ -916,21 +926,16 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 
 	case IPI_CALL_FUNC:
-		irq_enter();
 		generic_smp_call_function_interrupt();
-		irq_exit();
 		break;
 
 	case IPI_CPU_STOP:
-		irq_enter();
 		local_cpu_stop();
-		irq_exit();
 		break;
 
 	case IPI_CPU_CRASH_STOP:
 		if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
-			irq_enter();
-			ipi_cpu_crash_stop(cpu, regs);
+			ipi_cpu_crash_stop(cpu, get_irq_regs());
 
 			unreachable();
 		}
@@ -938,17 +943,13 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	case IPI_TIMER:
-		irq_enter();
 		tick_receive_broadcast();
-		irq_exit();
 		break;
 #endif
 
 #ifdef CONFIG_IRQ_WORK
 	case IPI_IRQ_WORK:
-		irq_enter();
 		irq_work_run();
-		irq_exit();
 		break;
 #endif
 
@@ -967,9 +968,76 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 	if ((unsigned)ipinr < NR_IPI)
 		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
+}
+
+/* Legacy version, should go away once all irqchips have been converted */
+void handle_IPI(int ipinr, struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	irq_enter();
+	do_handle_IPI(ipinr);
+	irq_exit();
+
 	set_irq_regs(old_regs);
 }
 
+static irqreturn_t ipi_handler(int irq, void *data)
+{
+	do_handle_IPI(irq - ipi_irq_base);
+	return IRQ_HANDLED;
+}
+
+static void ipi_send(const struct cpumask *target, unsigned int ipi)
+{
+	__ipi_send_mask(ipi_desc[ipi], target);
+}
+
+static void ipi_setup(int cpu)
+{
+	if (ipi_irq_base) {
+		int i;
+
+		for (i = 0; i < nr_ipi; i++)
+			enable_percpu_irq(ipi_irq_base + i, 0);
+	}
+}
+
+static void ipi_teardown(int cpu)
+{
+	if (ipi_irq_base) {
+		int i;
+
+		for (i = 0; i < nr_ipi; i++)
+			disable_percpu_irq(ipi_irq_base + i);
+	}
+}
+
+void __init set_smp_ipi_range(int ipi_base, int n)
+{
+	int i;
+
+	WARN_ON(n < NR_IPI);
+	nr_ipi = min(n, NR_IPI);
+
+	for (i = 0; i < nr_ipi; i++) {
+		int err;
+
+		err = request_percpu_irq(ipi_base + i, ipi_handler,
+					 "IPI", &irq_stat);
+		WARN_ON(err);
+
+		ipi_desc[i] = irq_to_desc(ipi_base + i);
+		irq_set_status_flags(ipi_base + i, IRQ_NO_ACCOUNTING);
+	}
+
+	ipi_irq_base = ipi_base;
+	__smp_cross_call = ipi_send;
+
+	/* Setup the boot CPU immediately */
+	ipi_setup(smp_processor_id());
+}
+
 void smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
-- 
2.26.2

