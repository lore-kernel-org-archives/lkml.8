Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B82CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807AD206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029018;
	bh=lScSvcyhxhG6TFbVfAEZW208PC7sJRJ25m1WrXEq9Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=llgKwPa+fqIfBGiBYCFsdzRWdMrSk2R2zJkQkCWtYLdc4kZQTs0hdukNl7jDpY5Mn
	 ozET+15LuI7iJFTBtfvSK6W5z2K/hWslLUfJpDWGesUvrMkG3jzyRrk8XlJhNDEKp/
	 lq/wP6EOSXlRH56ZwSufAHwzGmYJmqjDvObJFD5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406285AbgFXUDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391438AbgFXUDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:03:34 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA7D2080C;
        Wed, 24 Jun 2020 20:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029012;
        bh=lScSvcyhxhG6TFbVfAEZW208PC7sJRJ25m1WrXEq9Ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkWYNhS0H6u7uxegwdt4pcI1cAORuoZCoVMU7p0diWeySss/WPFaujjPo+32/0Cmm
         S2GfzHw88kVorIc0OKZFJ+P12u3SkEvzQtrbq9OdUJqyYPid6uRRF9wAidq0YSMJS6
         lmlkvQT43hYoQ1FmvmyWZ96JTCWZlAwaDSAHoTOQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1joBXO-006ABu-3E; Wed, 24 Jun 2020 20:58:26 +0100
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
Subject: [PATCH v2 14/17] arm64: Kill __smp_cross_call and co
Date:   Wed, 24 Jun 2020 20:58:08 +0100
Message-Id: <20200624195811.435857-15-maz@kernel.org>
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

The old IPI registration interface is now unused on arm64, so let's
get rid of it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/irq_work.h |  4 +---
 arch/arm64/include/asm/smp.h      |  7 -------
 arch/arm64/kernel/smp.c           | 34 +++++--------------------------
 3 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/include/asm/irq_work.h b/arch/arm64/include/asm/irq_work.h
index 8a1ef1907760..a1020285ea75 100644
--- a/arch/arm64/include/asm/irq_work.h
+++ b/arch/arm64/include/asm/irq_work.h
@@ -2,11 +2,9 @@
 #ifndef __ASM_IRQ_WORK_H
 #define __ASM_IRQ_WORK_H
 
-#include <asm/smp.h>
-
 static inline bool arch_irq_work_has_interrupt(void)
 {
-	return !!__smp_cross_call;
+	return true;
 }
 
 #endif /* __ASM_IRQ_WORK_H */
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 4537a4620e3d..dd3f68ed9ac9 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -67,13 +67,6 @@ extern void handle_IPI(int ipinr, struct pt_regs *regs);
  */
 extern void smp_init_cpus(void);
 
-/*
- * Provide a function to raise an IPI cross call on CPUs in callmap.
- */
-extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
-
-extern void (*__smp_cross_call)(const struct cpumask *, unsigned int);
-
 /*
  * Register IPI interrupts with the arch SMP code
  */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index c08950cc09cc..ed8a8184e3b6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -783,13 +783,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-void (*__smp_cross_call)(const struct cpumask *, unsigned int);
-
-void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
-{
-	__smp_cross_call = fn;
-}
-
 static const char *ipi_types[NR_IPI] __tracepoint_string = {
 #define S(x,s)	[x] = s
 	S(IPI_RESCHEDULE, "Rescheduling interrupts"),
@@ -801,11 +794,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_WAKEUP, "CPU wake-up interrupts"),
 };
 
-static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-{
-	trace_ipi_raise(target, ipi_types[ipinr]);
-	__smp_cross_call(target, ipinr);
-}
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
 
 void show_ipi_list(struct seq_file *p, int prec)
 {
@@ -852,8 +841,7 @@ void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
 #ifdef CONFIG_IRQ_WORK
 void arch_irq_work_raise(void)
 {
-	if (__smp_cross_call)
-		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
+	smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
 }
 #endif
 
@@ -960,27 +948,16 @@ static void do_handle_IPI(int ipinr)
 		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
 }
 
-/* Legacy version, should go away once all irqchips have been converted */
-void handle_IPI(int ipinr, struct pt_regs *regs)
-{
-	struct pt_regs *old_regs = set_irq_regs(regs);
-
-	irq_enter();
-	do_handle_IPI(ipinr);
-	irq_exit();
-
-	set_irq_regs(old_regs);
-}
-
 static irqreturn_t ipi_handler(int irq, void *data)
 {
 	do_handle_IPI(irq - ipi_irq_base);
 	return IRQ_HANDLED;
 }
 
-static void ipi_send(const struct cpumask *target, unsigned int ipi)
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
-	__ipi_send_mask(ipi_desc[ipi], target);
+	trace_ipi_raise(target, ipi_types[ipinr]);
+	__ipi_send_mask(ipi_desc[ipinr], target);
 }
 
 static void ipi_setup(int cpu)
@@ -1022,7 +999,6 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 	}
 
 	ipi_irq_base = ipi_base;
-	__smp_cross_call = ipi_send;
 
 	/* Setup the boot CPU immediately */
 	ipi_setup(smp_processor_id());
-- 
2.27.0

