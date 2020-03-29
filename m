Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0EEC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B2820781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgC2U1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:27:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57043 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgC2U0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVn-0001Uu-Bs; Sun, 29 Mar 2020 22:26:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1282C1C07F8;
        Sun, 29 Mar 2020 22:26:22 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:21 -0000
From:   "tip-bot2 for Atish Patra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/sifive-plic: Enable/Disable external
 interrupts upon cpu online/offline
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200302231146.15530-2-atish.patra@wdc.com>
References: <20200302231146.15530-2-atish.patra@wdc.com>
MIME-Version: 1.0
Message-ID: <158551358168.28353.9864458380650988997.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ccbe80bad571c2f967ad42b25bbb3ef7a4a24705
Gitweb:        https://git.kernel.org/tip/ccbe80bad571c2f967ad42b25bbb3ef7a4a24705
Author:        Atish Patra <atish.patra@wdc.com>
AuthorDate:    Mon, 02 Mar 2020 15:11:45 -08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 16 Mar 2020 15:48:54 

irqchip/sifive-plic: Enable/Disable external interrupts upon cpu online/offline

Currently, PLIC threshold is only initialized once in the beginning.
However, threshold can be set to disabled if a CPU is marked offline with
CPU hotplug feature. This will not allow to change the irq affinity to a
CPU that just came online.

Add PLIC specific CPU hotplug callbacks and enable the threshold when a CPU
comes online. Take this opportunity to move the external interrupt enable
code from trap init to PLIC driver as well. On cpu offline path, the driver
performs the exact opposite operations i.e. disable the interrupt and
the threshold.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20200302231146.15530-2-atish.patra@wdc.com
---
 arch/riscv/kernel/traps.c         |  2 +-
 drivers/irqchip/irq-sifive-plic.c | 38 ++++++++++++++++++++++++++----
 include/linux/cpuhotplug.h        |  1 +-
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index ffb3d94..55ea614 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -157,5 +157,5 @@ void __init trap_init(void)
 	/* Set the exception vector address */
 	csr_write(CSR_TVEC, &handle_exception);
 	/* Enable interrupts */
-	csr_write(CSR_IE, IE_SIE | IE_EIE);
+	csr_write(CSR_IE, IE_SIE);
 }
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index aa4af88..7c7f373 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2018 Christoph Hellwig
  */
 #define pr_fmt(fmt) "plic: " fmt
+#include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -55,6 +56,9 @@
 #define     CONTEXT_THRESHOLD		0x00
 #define     CONTEXT_CLAIM		0x04
 
+#define	PLIC_DISABLE_THRESHOLD		0xf
+#define	PLIC_ENABLE_THRESHOLD		0
+
 static void __iomem *plic_regs;
 
 struct plic_handler {
@@ -230,6 +234,32 @@ static int plic_find_hart_id(struct device_node *node)
 	return -1;
 }
 
+static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
+{
+	/* priority must be > threshold to trigger an interrupt */
+	writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
+}
+
+static int plic_dying_cpu(unsigned int cpu)
+{
+	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+
+	csr_clear(CSR_IE, IE_EIE);
+	plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
+
+	return 0;
+}
+
+static int plic_starting_cpu(unsigned int cpu)
+{
+	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+
+	csr_set(CSR_IE, IE_EIE);
+	plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
+
+	return 0;
+}
+
 static int __init plic_init(struct device_node *node,
 		struct device_node *parent)
 {
@@ -267,7 +297,6 @@ static int __init plic_init(struct device_node *node,
 		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
 		int cpu, hartid;
-		u32 threshold = 0;
 
 		if (of_irq_parse_one(node, i, &parent)) {
 			pr_err("failed to parse parent for context %d.\n", i);
@@ -301,7 +330,7 @@ static int __init plic_init(struct device_node *node,
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		if (handler->present) {
 			pr_warn("handler already present for context %d.\n", i);
-			threshold = 0xffffffff;
+			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
 			goto done;
 		}
 
@@ -313,13 +342,14 @@ static int __init plic_init(struct device_node *node,
 			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
 
 done:
-		/* priority must be > threshold to trigger an interrupt */
-		writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
 			plic_toggle(handler, hwirq, 0);
 		nr_handlers++;
 	}
 
+	cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+				  "irqchip/sifive/plic:starting",
+				  plic_starting_cpu, plic_dying_cpu);
 	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
 		nr_irqs, nr_handlers, nr_contexts);
 	set_handle_irq(plic_handle_irq);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index d37c17e..77d70b6 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -102,6 +102,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
+	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_MICROCODE_LOADER,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
