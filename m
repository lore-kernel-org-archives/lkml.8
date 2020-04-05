Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21B6C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 13:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CFB206F5
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 13:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgDENnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 09:43:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42642 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgDENnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 09:43:09 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jL5YH-000422-SB; Sun, 05 Apr 2020 15:43:06 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id ABC9A1001FC;
        Sun,  5 Apr 2020 15:43:04 +0200 (CEST)
Date:   Sun, 05 Apr 2020 13:41:49 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 5.7-rc1
Message-ID: <158609410988.4266.5816311298811487752.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent fixes from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-04-05

up to:  a67cd1fb660d: Merge tag 'irqchip-fixes-5.7-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core


Two reverts addressing regressions of the Xilinx interrupt controller
driver which affected the PPC users.

Thanks,

	tglx

------------------>
Marc Zyngier (2):
      Revert "irqchip/xilinx: Do not call irq_set_default_host()"
      Revert "irqchip/xilinx: Enable generic irq multi handler"


 arch/microblaze/Kconfig           |  2 --
 arch/microblaze/include/asm/irq.h |  3 +++
 arch/microblaze/kernel/irq.c      | 21 ++++++++++++++++++++-
 drivers/irqchip/irq-xilinx-intc.c | 35 +++++++++++++++--------------------
 4 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 242f58ec086b..6a331bd57ea8 100644
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
index 5166f0893e2b..eac2fb4b3fb9 100644
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
index 0b37dde60a1e..903dad822fad 100644
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
index 7f811fe5bf69..1d3d273309bd 100644
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
@@ -250,7 +245,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		}
 	} else {
 		primary_intc = irqc;
-		set_handle_irq(xil_intc_handle_irq);
+		irq_set_default_host(primary_intc->root_domain);
 	}
 
 	return 0;

