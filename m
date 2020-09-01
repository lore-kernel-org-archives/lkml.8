Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B098BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81897206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971961;
	bh=s6pjwzb229K6JRSGdbVTLBQhHBJgz3WMDtVrwmLVuMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gBEdFgxcTYYwQrFvrNky2sOH9jLp0UDWXJExz+Afk5noXhgdBXKQSjTUphjdf4Mhf
	 ELuIeTk5T1Nx26QKUGcYdzbVFCGHjNzbWe3gb9gtvWdVUKjdxQNMTo8VyWCpPFcp/W
	 W55Q4AL37BFUxXTGurKBkTMaimpatdGy1d9D7UP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgIAOwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728722AbgIAOu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:50:57 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81ECE2151B;
        Tue,  1 Sep 2020 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971856;
        bh=s6pjwzb229K6JRSGdbVTLBQhHBJgz3WMDtVrwmLVuMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJayGzbzAbNjsCz5fwzme1chr228c8Tq+xAUoLTZMDTei/uLD/A6SBKbMuCKGIf1M
         c3gyKDqTHQ4H8WEm7lbupg9V2qkSsvonYrHdlgB6PL0QuYdi38beGoQ/lELBPkuyGJ
         XTqru8E9mjhwXuovduaG07xM+yfVJPF4m3v9wjBY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD7Vd-008IQP-EJ; Tue, 01 Sep 2020 15:43:41 +0100
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
Subject: [PATCH v3 14/16] arm64: Remove custom IRQ stat accounting
Date:   Tue,  1 Sep 2020 15:43:22 +0100
Message-Id: <20200901144324.1071694-15-maz@kernel.org>
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

Let's switch the arm64 code to the core accounting, which already
does everything we need.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/hardirq.h |  9 ---------
 arch/arm64/kernel/smp.c          | 24 ++++++------------------
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 985493af704b..5ffa4bacdad3 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -13,21 +13,12 @@
 #include <asm/kvm_arm.h>
 #include <asm/sysreg.h>
 
-#define NR_IPI	7
-
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int ipi_irqs[NR_IPI];
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-#define __inc_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)++
-#define __get_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)
-
-u64 smp_irq_stat_cpu(unsigned int cpu);
-#define arch_irq_stat_cpu	smp_irq_stat_cpu
-
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
 struct nmi_ctx {
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 58fb155fb0ab..07b45466e0bb 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -72,7 +72,8 @@ enum ipi_msg_type {
 	IPI_CPU_CRASH_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
-	IPI_WAKEUP
+	IPI_WAKEUP,
+	NR_IPI
 };
 
 static int ipi_irq_base __read_mostly;
@@ -800,26 +801,15 @@ void show_ipi_list(struct seq_file *p, int prec)
 	unsigned int cpu, i;
 
 	for (i = 0; i < NR_IPI; i++) {
+		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ",
-				   __get_irq_stat(cpu, ipi_irqs[i]));
+			seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
 		seq_printf(p, "      %s\n", ipi_types[i]);
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
@@ -892,10 +882,8 @@ static void do_handle_IPI(int ipinr)
 {
 	unsigned int cpu = smp_processor_id();
 
-	if ((unsigned)ipinr < NR_IPI) {
+	if ((unsigned)ipinr < NR_IPI)
 		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
-		__inc_irq_stat(cpu, ipi_irqs[ipinr]);
-	}
 
 	switch (ipinr) {
 	case IPI_RESCHEDULE:
@@ -992,7 +980,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 		int err;
 
 		err = request_percpu_irq(ipi_base + i, ipi_handler,
-					 "IPI", &irq_stat);
+					 "IPI", &cpu_number);
 		WARN_ON(err);
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
-- 
2.27.0

