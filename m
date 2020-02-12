Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7810C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872822082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TywLaxWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgBLBwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 20:52:07 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60368 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbgBLBwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581472320; x=1613008320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/GlgOKcxd7uoN0nxIQqstOE4PEIJ6PWJbqedHD+Oytw=;
  b=TywLaxWtcawEJiUG1zujYJLEMn16/vo6Y4K4qCagzhSX0mX4HwN7dgSH
   Dhicc72BTEdsBjZZYeQSEu/15ePua4ld5NOlP9hP/LdC+2G7nSHe89QbS
   3c3iMOUNqrAXK9CZGyuNjCHahwho/1JfD9lziUggcwZbn6YsPF4YYxvL3
   HnBGKcW2XzMtrGoqjmoYHf6OhDpgOfeZ+PMbUoMHhqLDHIydwwjs/tKGg
   hpon37c5ND1mFmOinfwAvFzd+U1yRTb1HCHUaVk0h4i+zNPF4HALPUtXd
   dDUMrJizD1hqdLVLSFLxLZLpiwHbYLl1AV0y5A/S2MkDzsakcbzFNtRkw
   A==;
IronPort-SDR: J3hiKazOrAZydERvu8BzxWIusauk9431jGDNOYju4OGLA5Ql5gjOfcgS88V1Bra+WQtH0Z07Xv
 h49ZYwoMq6tF0GIrPmvKmb0Ji+cc0FfsKGfQkeHF3qb+BjUXDrRtMKUmq/p+gTLY19WtlpXH+r
 FR4HX8G7lIDyufFy21V65eg3UUBycdWKeNVPu0Oy8aSdbQRX37OO78RhCUHrhAdvVB/XbzWIni
 3L+6CjKMwuPp1ODOq+NGHyanoCwW/RplJ3lzYM5K68qjcZlxLVkTvbRxdtWctwwvmsve+9NiSo
 QCs=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="237648958"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 09:51:57 +0800
IronPort-SDR: b4vxK2MFEYY3X80xe5nZZcekA+0kCJnVNxmzLVQkvLQCvpL0seR+YhKshwzFjl4/Fk8+mD/MWm
 6WuLHPfThZay9ryyetPXDFNMve8OooZJBJpd+ZiIR7U2H1JLmm05vuWLQNsDkN8SdftxcJvYPs
 GucdLRBOoIZQDwT5aEoDWl0a5/ceXvbuc+XeZ3jK8LoG6HGyKScTy48nXVMdbi0tGd25dbHDjz
 l1n5/yV142qBcPkEZm3wpeaskFg1uzW+ojOjBn9FofR/9J3zitzyoUINbBXqidX+vw9aaS7E1Q
 y2K6y7JWM/KDTu2gMj17t8Qc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 17:44:47 -0800
IronPort-SDR: XZ75HwAnE+P9lENVdrLEHufZnVd6QXvw4PlHcN8S93gGExvO48x/WJUDn7MTDuO4bI3wHgW50H
 MHBVvZ/q9OyOCP1bQeXi05EnwfKB2KyHKZKc8L3G4TR/jKpXN79tL6Th63k3XWkQeBpFt9AOF3
 SEIe85g8xUgf3X3SwO0AgKgB+dvhbSnLE6NyLtvSL9DVjs1hzxGRjW5TV9KKZ8sAmq97ysAaPm
 /GVm534nwwLYp7sxcnV8n7047rUNFyaBfryyFT4r6L036dFrzNANTj2QC4QSg1gVrFbdZg1suP
 SNU=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 17:51:57 -0800
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
Subject: [PATCH v8 10/11] irqchip/sifive-plic: Initialize the plic handler when cpu comes online
Date:   Tue, 11 Feb 2020 17:48:21 -0800
Message-Id: <20200212014822.28684-11-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212014822.28684-1-atish.patra@wdc.com>
References: <20200212014822.28684-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, plic threshold and priority are only initialized once in the
beginning. However, threshold can be set to disabled if cpu is marked
offline with cpu hotplug feature. This will not allow to change the
irq affinity to a cpu that just came online.

Add plic specific cpu hotplug callback and initialize the per cpu handler
when cpu comes online.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/irqchip/irq-sifive-plic.c | 34 ++++++++++++++++++++++++-------
 include/linux/cpuhotplug.h        |  1 +
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 0aca5807a119..9b564b19f4bf 100644
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
@@ -55,6 +56,8 @@
 #define     CONTEXT_THRESHOLD		0x00
 #define     CONTEXT_CLAIM		0x04
 
+#define	PLIC_DISABLE_THRESHOLD		0xffffffff
+
 static void __iomem *plic_regs;
 
 struct plic_handler {
@@ -208,6 +211,26 @@ static int plic_find_hart_id(struct device_node *node)
 	return -1;
 }
 
+static void plic_handler_init(struct plic_handler *handler, u32 threshold)
+{
+	irq_hw_number_t hwirq;
+
+	/* priority must be > threshold to trigger an interrupt */
+	writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
+	for (hwirq = 1; hwirq < plic_irqdomain->hwirq_max; hwirq++)
+		plic_toggle(handler, hwirq, 0);
+}
+
+static int plic_starting_cpu(unsigned int cpu)
+{
+	u32 threshold = 0;
+	struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
+
+	plic_handler_init(handler, threshold);
+
+	return 0;
+}
+
 static int __init plic_init(struct device_node *node,
 		struct device_node *parent)
 {
@@ -243,9 +266,7 @@ static int __init plic_init(struct device_node *node,
 	for (i = 0; i < nr_contexts; i++) {
 		struct of_phandle_args parent;
 		struct plic_handler *handler;
-		irq_hw_number_t hwirq;
 		int cpu, hartid;
-		u32 threshold = 0;
 
 		if (of_irq_parse_one(node, i, &parent)) {
 			pr_err("failed to parse parent for context %d.\n", i);
@@ -279,7 +300,7 @@ static int __init plic_init(struct device_node *node,
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		if (handler->present) {
 			pr_warn("handler already present for context %d.\n", i);
-			threshold = 0xffffffff;
+			plic_handler_init(handler, PLIC_DISABLE_THRESHOLD);
 			goto done;
 		}
 
@@ -291,13 +312,12 @@ static int __init plic_init(struct device_node *node,
 			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
 
 done:
-		/* priority must be > threshold to trigger an interrupt */
-		writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
-		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
-			plic_toggle(handler, hwirq, 0);
 		nr_handlers++;
 	}
 
+	cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+				  "irqchip/sifive/plic:starting",
+				  plic_starting_cpu, NULL);
 	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
 		nr_irqs, nr_handlers, nr_contexts);
 	set_handle_irq(plic_handle_irq);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index e51ee772b9f5..5360e03db08c 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -100,6 +100,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
+	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_MICROCODE_LOADER,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
-- 
2.24.0

