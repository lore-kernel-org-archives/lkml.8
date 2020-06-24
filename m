Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B9DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08772080C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593028724;
	bh=g4g7Be/7qkvvbC1GDQoBFv9ejglBBih542Chh5Bvqac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gZE4aSLFzb+Zoeq/0OxW/DLvJHBe/PUH/Tbw1cCe7pkJI+6sF2yS3SEnrVo5r+bnK
	 mGxyK7Hxuo0hFkdmll5hfK42rZpYCcW86hBxOyQzmbnHmXY9GhPmWZAQi/U0kdslMO
	 kNpHzn5WrUrTjdWwGbWhGw19MApRwDOBNQztJ+hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406336AbgFXT6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406233AbgFXT6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:58:21 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221EC2084D;
        Wed, 24 Jun 2020 19:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593028700;
        bh=g4g7Be/7qkvvbC1GDQoBFv9ejglBBih542Chh5Bvqac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOSp2COxAr/gCayi7yog1NM9GANknHo4lfonPoHiXPKG3qVDsZwjSqCELQ2Ap4RAQ
         xfZpjuhcuOcTC9EZ7y9tqcoftZOqvowvTb/ON9kDjeBDB1M3RAeePp6RcmothdYW4L
         vgQxucpsZKHQZJUuzWhigxfFG9IzV9zahv7rhrNU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1joBXG-006ABu-KT; Wed, 24 Jun 2020 20:58:18 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, kernel-team@android.com
Subject: [PATCH v2 04/17] ARM: Allow IPIs to be handled as normal interrupts
Date:   Wed, 24 Jun 2020 20:57:58 +0100
Message-Id: <20200624195811.435857-5-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624195811.435857-1-maz@kernel.org>
References: <20200624195811.435857-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, kernel-team@android.com
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

One of the major difference is that we end up, in some cases
(such as when performing IRQ time accounting on the scheduler
IPI), end up with nested irq_enter()/irq_exit() pairs.
Other than the (relatively small) overhead, there should be
no consequences to it (these pairs are designed to nest
correctly, and the accounting shouldn't be off).

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/Kconfig           |  1 +
 arch/arm/include/asm/smp.h |  5 ++
 arch/arm/kernel/smp.c      | 99 ++++++++++++++++++++++++++++++++------
 3 files changed, 89 insertions(+), 16 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2ac74904a3ce..27c26d3c06f2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -48,6 +48,7 @@ config ARM
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select GENERIC_IRQ_IPI if SMP
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index a91f21e3c5b5..0e29730295ca 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -45,6 +45,11 @@ extern void smp_init_cpus(void);
  */
 extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
 
+/*
+ * Register IPI interrupts with the arch SMP code
+ */
+extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
+
 /*
  * Called from platform specific assembly code, this is the
  * secondary CPU entry point.
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 9a6432557871..269639b14259 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -70,18 +70,28 @@ enum ipi_msg_type {
 	 * CPU_BACKTRACE is special and not included in NR_IPI
 	 * or tracable with trace_ipi_*
 	 */
-	IPI_CPU_BACKTRACE,
+	IPI_CPU_BACKTRACE = NR_IPI,
 	/*
 	 * SGI8-15 can be reserved by secure firmware, and thus may
 	 * not be usable by the kernel. Please keep the above limited
 	 * to at most 8 entries.
 	 */
+	MAX_IPI
 };
 
+static int ipi_irq_base;
+static int nr_ipi = MAX_IPI;
+static struct irq_desc *ipi_desc[MAX_IPI];
+
+static void ipi_setup(int cpu);
+static void ipi_teardown(int cpu);
+
 static DECLARE_COMPLETION(cpu_running);
 
 static struct smp_operations smp_ops __ro_after_init;
 
+static void ipi_setup(int cpu);
+
 void __init smp_set_ops(const struct smp_operations *ops)
 {
 	if (ops)
@@ -248,6 +258,7 @@ int __cpu_disable(void)
 	 * and we must not schedule until we're ready to give up the cpu.
 	 */
 	set_cpu_online(cpu, false);
+	ipi_teardown(cpu);
 
 	/*
 	 * OK - migrate IRQs away from this CPU
@@ -423,6 +434,8 @@ asmlinkage void secondary_start_kernel(void)
 
 	notify_cpu_starting(cpu);
 
+	ipi_setup(cpu);
+
 	calibrate_delay();
 
 	smp_store_cpu_info(cpu);
@@ -628,10 +641,9 @@ asmlinkage void __exception_irq_entry do_IPI(int ipinr, struct pt_regs *regs)
 	handle_IPI(ipinr, regs);
 }
 
-void handle_IPI(int ipinr, struct pt_regs *regs)
+static void do_handle_IPI(int ipinr)
 {
 	unsigned int cpu = smp_processor_id();
-	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	if ((unsigned)ipinr < NR_IPI) {
 		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
@@ -644,9 +656,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	case IPI_TIMER:
-		irq_enter();
 		tick_receive_broadcast();
-		irq_exit();
 		break;
 #endif
 
@@ -655,36 +665,26 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 
 	case IPI_CALL_FUNC:
-		irq_enter();
 		generic_smp_call_function_interrupt();
-		irq_exit();
 		break;
 
 	case IPI_CPU_STOP:
-		irq_enter();
 		ipi_cpu_stop(cpu);
-		irq_exit();
 		break;
 
 #ifdef CONFIG_IRQ_WORK
 	case IPI_IRQ_WORK:
-		irq_enter();
 		irq_work_run();
-		irq_exit();
 		break;
 #endif
 
 	case IPI_COMPLETION:
-		irq_enter();
 		ipi_complete(cpu);
-		irq_exit();
 		break;
 
 	case IPI_CPU_BACKTRACE:
 		printk_nmi_enter();
-		irq_enter();
-		nmi_cpu_backtrace(regs);
-		irq_exit();
+		nmi_cpu_backtrace(get_irq_regs());
 		printk_nmi_exit();
 		break;
 
@@ -696,9 +696,76 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
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
+	WARN_ON(n < MAX_IPI);
+	nr_ipi = min(n, MAX_IPI);
+
+	for (i = 0; i < nr_ipi; i++) {
+		int err;
+
+		err = request_percpu_irq(ipi_base + i, ipi_handler,
+					 "IPI", &irq_stat);
+		WARN_ON(err);
+
+		ipi_desc[i] = irq_to_desc(ipi_base + i);
+		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
+	}
+
+	ipi_irq_base = ipi_base;
+	set_smp_cross_call(ipi_send);
+
+	/* Setup the boot CPU immediately */
+	ipi_setup(smp_processor_id());
+}
+
 void smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
-- 
2.27.0

