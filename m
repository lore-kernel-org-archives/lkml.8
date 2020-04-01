Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B64AC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2823C2080C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbgDALF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:05:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34824 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732191AbgDALFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:05:55 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jJbBt-000862-Lp; Wed, 01 Apr 2020 13:05:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1EC141C0315;
        Wed,  1 Apr 2020 13:05:49 +0200 (CEST)
Date:   Wed, 01 Apr 2020 11:05:48 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Revert "irqchip/xilinx: Enable generic irq multi handler"
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44b64be7-9240-fd52-af90-e0245220f38b@xilinx.com>
References: <44b64be7-9240-fd52-af90-e0245220f38b@xilinx.com>
MIME-Version: 1.0
Message-ID: <158573914871.28353.6675528184869876699.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     4cea749d56bec9409f3bd126d2b2f949dc6c66e2
Gitweb:        https://git.kernel.org/tip/4cea749d56bec9409f3bd126d2b2f949dc6c66e2
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 30 Mar 2020 10:43:59 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 01 Apr 2020 09:12:24 +01:00

Revert "irqchip/xilinx: Enable generic irq multi handler"

This reverts commit a0789993bf8266e62fea6b4613945ba081c71e7d, which
breaks a number of PPC platforms.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/44b64be7-9240-fd52-af90-e0245220f38b@xilinx.com
---
 arch/microblaze/Kconfig           |  2 +--
 arch/microblaze/include/asm/irq.h |  3 +++-
 arch/microblaze/kernel/irq.c      | 21 ++++++++++++++++++-
 drivers/irqchip/irq-xilinx-intc.c | 34 ++++++++++++------------------
 4 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 242f58e..6a331bd 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -47,8 +47,6 @@ config MICROBLAZE
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE if MMU
 	select SPARSE_IRQ
-	select GENERIC_IRQ_MULTI_HANDLER
-	select HANDLE_DOMAIN_IRQ
 
 # Endianness selection
 choice
diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
index 5166f08..eac2fb4 100644
--- a/arch/microblaze/include/asm/irq.h
+++ b/arch/microblaze/include/asm/irq.h
@@ -14,4 +14,7 @@
 struct pt_regs;
 extern void do_IRQ(struct pt_regs *regs);
 
+/* should be defined in each interrupt controller driver */
+extern unsigned int xintc_get_irq(void);
+
 #endif /* _ASM_MICROBLAZE_IRQ_H */
diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
index 0b37dde..903dad8 100644
--- a/arch/microblaze/kernel/irq.c
+++ b/arch/microblaze/kernel/irq.c
@@ -20,10 +20,29 @@
 #include <linux/irqchip.h>
 #include <linux/of_irq.h>
 
+static u32 concurrent_irq;
+
 void __irq_entry do_IRQ(struct pt_regs *regs)
 {
+	unsigned int irq;
+	struct pt_regs *old_regs = set_irq_regs(regs);
 	trace_hardirqs_off();
-	handle_arch_irq(regs);
+
+	irq_enter();
+	irq = xintc_get_irq();
+next_irq:
+	BUG_ON(!irq);
+	generic_handle_irq(irq);
+
+	irq = xintc_get_irq();
+	if (irq != -1U) {
+		pr_debug("next irq: %d\n", irq);
+		++concurrent_irq;
+		goto next_irq;
+	}
+
+	irq_exit();
+	set_irq_regs(old_regs);
 	trace_hardirqs_on();
 }
 
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index ea74181..1d3d273 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -124,6 +124,20 @@ static unsigned int xintc_get_irq_local(struct xintc_irq_chip *irqc)
 	return irq;
 }
 
+unsigned int xintc_get_irq(void)
+{
+	unsigned int irq = -1;
+	u32 hwirq;
+
+	hwirq = xintc_read(primary_intc, IVR);
+	if (hwirq != -1U)
+		irq = irq_find_mapping(primary_intc->root_domain, hwirq);
+
+	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
+
+	return irq;
+}
+
 static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
 	struct xintc_irq_chip *irqc = d->host_data;
@@ -163,25 +177,6 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void xil_intc_handle_irq(struct pt_regs *regs)
-{
-	u32 hwirq;
-	struct xintc_irq_chip *irqc = primary_intc;
-
-	do {
-		hwirq = xintc_read(irqc, IVR);
-		if (likely(hwirq != -1U)) {
-			int ret;
-
-			ret = handle_domain_irq(irqc->root_domain, hwirq, regs);
-			WARN_ONCE(ret, "Unhandled HWIRQ %d\n", hwirq);
-			continue;
-		}
-
-		break;
-	} while (1);
-}
-
 static int __init xilinx_intc_of_init(struct device_node *intc,
 					     struct device_node *parent)
 {
@@ -251,7 +246,6 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 	} else {
 		primary_intc = irqc;
 		irq_set_default_host(primary_intc->root_domain);
-		set_handle_irq(xil_intc_handle_irq);
 	}
 
 	return 0;
