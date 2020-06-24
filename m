Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514F8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FDF20885
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029010;
	bh=QCKebLfZBsKNDmu9wfCINEEwpjrlkSmpFQvg9J6/DkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=194Vc/hBEPLCGtlDMxgdW2XCSA9UfhKOzcOUxziuN1MsQXqtVDuWAwqJQ4tY2A56d
	 kraGfUgLVKv2+u4LlChpX0x6s9u1cb2dSdXkFMvYbCxgZ6jPXhm8LCcdjQofG2TBkm
	 ctlp2QOrTnJt6w7Z0veFpOyuoVz42lscrrAuKh1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391413AbgFXUD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391316AbgFXUDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:03:24 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E612080C;
        Wed, 24 Jun 2020 20:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029004;
        bh=QCKebLfZBsKNDmu9wfCINEEwpjrlkSmpFQvg9J6/DkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRGsIQG9XVBqJuSERK7T8Fu7VPutT2TIs9xRhIA1dvYzOLJnD5w2k+Hdb1ZsvykEL
         +Hantm1dZqFZn/fABCYO5wVbn3nZxV36NM8QD+aBgEt5csorj1fqXbpmJ+mYxUPLIe
         TrHVUk7kQwltsgKV3jMz7+LaMfltwR8CMTyJU8DE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1joBXP-006ABu-L6; Wed, 24 Jun 2020 20:58:27 +0100
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
Subject: [PATCH v2 16/17] ARM: Kill __smp_cross_call and co
Date:   Wed, 24 Jun 2020 20:58:10 +0100
Message-Id: <20200624195811.435857-17-maz@kernel.org>
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

The old IPI registration interface is now unused on arm, so let's
get rid of it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/smp.h |  6 ------
 arch/arm/kernel/smp.c      | 22 +++++-----------------
 2 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 0e29730295ca..0ca55a607d0a 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -39,12 +39,6 @@ void handle_IPI(int ipinr, struct pt_regs *regs);
  */
 extern void smp_init_cpus(void);
 
-
-/*
- * Provide a function to raise an IPI cross call on CPUs in callmap.
- */
-extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
-
 /*
  * Register IPI interrupts with the arch SMP code
  */
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 269639b14259..285980c2a437 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -514,14 +514,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-static void (*__smp_cross_call)(const struct cpumask *, unsigned int);
-
-void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
-{
-	if (!__smp_cross_call)
-		__smp_cross_call = fn;
-}
-
 static const char *ipi_types[NR_IPI] __tracepoint_string = {
 #define S(x,s)	[x] = s
 	S(IPI_WAKEUP, "CPU wakeup interrupts"),
@@ -533,11 +525,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_COMPLETION, "completion interrupts"),
 };
 
-static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-{
-	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
-	__smp_cross_call(target, ipinr);
-}
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
 
 void show_ipi_list(struct seq_file *p, int prec)
 {
@@ -716,9 +704,10 @@ static irqreturn_t ipi_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void ipi_send(const struct cpumask *target, unsigned int ipi)
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
-	__ipi_send_mask(ipi_desc[ipi], target);
+	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
+	__ipi_send_mask(ipi_desc[ipinr], target);
 }
 
 static void ipi_setup(int cpu)
@@ -760,7 +749,6 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 	}
 
 	ipi_irq_base = ipi_base;
-	set_smp_cross_call(ipi_send);
 
 	/* Setup the boot CPU immediately */
 	ipi_setup(smp_processor_id());
@@ -873,7 +861,7 @@ core_initcall(register_cpufreq_notifier);
 
 static void raise_nmi(cpumask_t *mask)
 {
-	__smp_cross_call(mask, IPI_CPU_BACKTRACE);
+	__ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
-- 
2.27.0

