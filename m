Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C990C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74703206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971984;
	bh=BPdT+vTAX6b+20pGNGQv/OEbZaMm0piOs8VCTI0srpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XFtVGaL7LnsN6bdzmZThnKl73GeTRnoNxvFNWz0mtxQ3jEdLrm/TWsjGbRqXfPWM2
	 DEaaJ/eRNCaNv55dIbnrc9/f/21hYNDealMpnks1UASvtE8TFgLga0cF3856EQCCjY
	 ReuUa1EInV7vU/4Bn+n/17GYF6QGo9bdk2gyx3tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgIAOxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgIAOux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:50:53 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88456206FA;
        Tue,  1 Sep 2020 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971852;
        bh=BPdT+vTAX6b+20pGNGQv/OEbZaMm0piOs8VCTI0srpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rps4GY9gN8fybFalh9c5lnWMZwkkH1zuRtJ60pzcQjJkkonglUCe1QwZdD9BUYRm6
         4fZWMCDJErlewG6JspDzoutVDNeyYxnmYlnPn7YxEcAg2Q8iQWu6V0aKCJnLXnZttU
         2cJESJLIJcPE+LXy1UQQ8uLCI4MBKli5pMCBUIvc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD7Vf-008IQP-5D; Tue, 01 Sep 2020 15:43:43 +0100
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
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH v3 16/16] ARM: Remove custom IRQ stat accounting
Date:   Tue,  1 Sep 2020 15:43:24 +0100
Message-Id: <20200901144324.1071694-17-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200901144324.1071694-1-maz@kernel.org>
References: <20200901144324.1071694-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, saravanak@google.com, kernel-team@android.com, valentin.schneider@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's switch the arm code to the core accounting, which already
does everything we need.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/hardirq.h | 17 -----------------
 arch/arm/kernel/smp.c          | 20 ++++----------------
 2 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 7a88f160b1fb..b95848ed2bc7 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -6,29 +6,12 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
-#define NR_IPI	7
-
 typedef struct {
 	unsigned int __softirq_pending;
-#ifdef CONFIG_SMP
-	unsigned int ipi_irqs[NR_IPI];
-#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-#define __inc_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)++
-#define __get_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)
-
-#ifdef CONFIG_SMP
-u64 smp_irq_stat_cpu(unsigned int cpu);
-#else
-#define smp_irq_stat_cpu(cpu)	0
-#endif
-
-#define arch_irq_stat_cpu	smp_irq_stat_cpu
-
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
 #endif /* __ASM_HARDIRQ_H */
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d51e64955a26..aead847ac8b9 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -65,6 +65,7 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
+	NR_IPI,
 	/*
 	 * CPU_BACKTRACE is special and not included in NR_IPI
 	 * or tracable with trace_ipi_*
@@ -529,27 +530,16 @@ void show_ipi_list(struct seq_file *p, int prec)
 	unsigned int cpu, i;
 
 	for (i = 0; i < NR_IPI; i++) {
+		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
 		seq_printf(p, "%*s%u: ", prec - 1, "IPI", i);
 
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ",
-				   __get_irq_stat(cpu, ipi_irqs[i]));
+			seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
 
 		seq_printf(p, " %s\n", ipi_types[i]);
 	}
 }
 
-u64 smp_irq_stat_cpu(unsigned int cpu)
-{
-	u64 sum = 0;
-	int i;
-
-	for (i = 0; i < NR_IPI; i++)
-		sum += __get_irq_stat(cpu, ipi_irqs[i]);
-
-	return sum;
-}
-
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 {
 	smp_cross_call(mask, IPI_CALL_FUNC);
@@ -630,10 +620,8 @@ static void do_handle_IPI(int ipinr)
 {
 	unsigned int cpu = smp_processor_id();
 
-	if ((unsigned)ipinr < NR_IPI) {
+	if ((unsigned)ipinr < NR_IPI)
 		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
-		__inc_irq_stat(cpu, ipi_irqs[ipinr]);
-	}
 
 	switch (ipinr) {
 	case IPI_WAKEUP:
-- 
2.27.0

