Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0A0C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02FD207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E8nHnYDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgBUApL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:45:11 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5901 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgBUApG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582245906; x=1613781906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zauByF+unia1xt0CTcHhbFkLtPm1qJJUe5iAcp7OYgY=;
  b=E8nHnYDk5iFLDBOCqiuZQ/sGAvMuiDTUBtW1bJvix5ZVwtTJk9TiFPrY
   6JvsvNdQUSnCxosczmT4Kg43+KjGzK+WxDlxW5mE4HUNAXW/QkGgreiF7
   8F+2aC/XihcvHLPLmy3NTr4/k0oAMOXfOO+MFms2lfMgFa2hNJhXJEjgd
   CeE5Pqv9B8W7GM+RxsfDespqkNytp09/fW2jKivx8hTRmj2Ygao7FVkXN
   2UnVEUJG0U1B02rlQUumb7XU8GIrPpbK8HejfMfLo9tyD7a2X4tKk60VM
   28+mm7REfBoPeMeVY5shKF8ak9EezlJNmcV8/VuowkpGY2hYpQ0hOrWQv
   w==;
IronPort-SDR: WqMvM8c9/VF/Qx1f5jXhO3Vaa+Hh/YWRLPNhYAZQHu6KzEUyf7b+FteCcclqBvOuHEFo/QWzUG
 7MZoVkdIajT8sajOV43xjIJUbRUhurkkwy7rc7v2CY7KQ2hbM0b6IEofIYLa4jHMgpq5DmG+bj
 yH7LljnsOxa9anyP4oBE3NXlFma3BXVKZeiTsxPniowd07cQphrqxKOtIVUKB4R3bVKY/g3Lf/
 rJotsOkLC0yfpyZltI+TckEh3mT5szx0h85rOBGZQHFN9i2YqJx9deUXAuYatZ9acy/5+bTCTd
 My8=
X-IronPort-AV: E=Sophos;i="5.70,466,1574092800"; 
   d="scan'208";a="130852824"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 08:44:52 +0800
IronPort-SDR: 2PHBa0EKVBYLcXgQwhBnw69v7Q52sDjdQn3m+TYcYzaVCAIwTnbRbSgGWkDmk2jBH5B2sJQno9
 j1F+t0v6HsYCYzrmko3eN0c9qmzJII8AH1bfVAoMShwm9m+e1Fq7W6ouFTVwvkOS1bwvy8MsHY
 aLzPOE0ODEhFM9RaJOD5OyVhy7TKSVZCDyqA39LqFgrgraX6vUJcgvd+B6WHZIF769C+tsKRlp
 JZ+v2IcqMMnRvOIz0pWdOnwgmBXR9cxnwGbSDqRpCo/SqC9UHY1lNx78wnNBWlzhVBUFlCC8IG
 bDrzsuR9mmPmzPkAaL3q6Vad
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 16:37:25 -0800
IronPort-SDR: mGqmtO4WvmnGdjt7Re0dJPbbwF0EOZsZXWkpQQKyaKAE7LJ7riPDNpffdnEIBg6iqbm/Yz+Qfa
 16liW72fuKinmBTP+m/9S/CLu559Adyn0/xikgQeZOzIA7Avq0Z+0GUdY2dQDO/kz3H6CqV6Sm
 YmcRpq0L0YuUwigFh7QCo74cn60YCqSg9z3G4Iy+Rp2pI2F8S+wx/k5MzKmIP3lv+0AcItFFKH
 udthT6A83YL3yxM4olbpJaqDTXEKFgA+0nZo+CpdExO3kJYDcP+m2e/ZAe+g7qa8KYTn+5fq3V
 w9Q=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2020 16:44:50 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v9 12/12] irqchip/sifive-plic: Initialize the plic handler when cpu comes online
Date:   Thu, 20 Feb 2020 16:44:13 -0800
Message-Id: <20200221004413.12869-13-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221004413.12869-1-atish.patra@wdc.com>
References: <20200221004413.12869-1-atish.patra@wdc.com>
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
 arch/riscv/kernel/traps.c         |  2 +-
 drivers/irqchip/irq-sifive-plic.c | 38 +++++++++++++++++++++++++++----
 include/linux/cpuhotplug.h        |  1 +
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8e13ad45ccaa..16c59807da6a 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -157,5 +157,5 @@ void trap_init(void)
 	/* Set the exception vector address */
 	csr_write(CSR_TVEC, &handle_exception);
 	/* Enable interrupts */
-	csr_write(CSR_IE, IE_SIE | IE_EIE);
+	csr_write(CSR_IE, IE_SIE);
 }
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index aa4af886e43a..7c7f37393f99 100644
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
index d37c17e68268..77d70b633531 100644
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
-- 
2.25.0

