Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1907C4BA2C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7449624679
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q7Xgcw58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgBZWCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:02:34 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45048 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgBZWC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582754548; x=1614290548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rQpWeai3GBbIb6BkBx8DbAEiU0Kg2MIkEVW4P65W++w=;
  b=q7Xgcw58brgBgrrPCbTqw1rZlSur6AMrZsJg5IHfz7IwDd1BhCkz/s/w
   YtMc22TOc16nG7XG6427w2bPu0PrO4HXU9g20o3Cut7T4U46lLNPe7CCG
   eTTstOcR5IeIVwRStVgFYj+h2dMYcg4EoT06YyLItKS548YDPD44DNP/L
   x/9+fqNZjyj0aAfv9gaWBzn2kPxEaKQ5p+TyHqdKkXc93+mt0xWebErxn
   mqg42XRNJ2jVHAuk9BkQEwixa6X3DC7G1rkON0DgBIdTqKI6APxMJX7I1
   /o/C8+8DOvLv3IF4jnoc+iFjp4XOouczAjdezo5uqSefsJIgdJTi4rHg1
   Q==;
IronPort-SDR: nQ1DSxlH3ZbDb0EQBxc2XChjgQbZTEpKuAGQVOInCbZQPojbCApmMM4B3FThiBCu8IFl0IXaq7
 T//Ed/r0pI5bU5zID+ZT7LZToTg9RjAPy+xzK7hZEJADUP1MhWkiBlfx7lozUJ3XuEgtwhzyA6
 y96W/wyFLU9CsFfc2aIS37Un6Q8BxlcTfqJMHalmUkF46n/4ipK1yUBHS5PD7w1BcH6EhkHFSC
 yWSWNR/RFV3Uuwl2GGGw9nSPrc28ox4uKoheZSmI3NNLSJGN/ykedbysT7clF7TVfPyIxG4v+Q
 GL8=
X-IronPort-AV: E=Sophos;i="5.70,489,1574092800"; 
   d="scan'208";a="132290758"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 06:02:27 +0800
IronPort-SDR: 27pk1iXbBxCSCXTk/rqvV6EtD/00S9L3eDlj6Ai3ASKApOo1D+XWmaE4j6w11ed6eeF/wq/1Xw
 vaIj8lwezHM+3fyBqucH+yOJN5VHOzJuvmv5JGiabD06FILbj76AVz6LNmFFDY7qZga1dq6D8q
 3koAMbMIs8IUBRRip6PvRDR8bKHDRxknpYHSv1InWz8MqHgnvtolZo8478alj+15Q09NbcJPim
 Fde8LTTkBUYlCQdzoheiOWgD2hegSMti5TZeb/0OsBrOVd+qQTf8GblcZYeRdYzGcJW5ACWqJP
 7moS1+S/oSc4D9AM8U10tAWs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:54:52 -0800
IronPort-SDR: SGkEvRNXKfIFdxe2v5grLyGhwf6sIXYzVfN+QHIvGkbE2LH5zW1s43qb9In+JL4NcrtlVUrP/n
 4MtgAqBiufdOJ9+Q1OPtPalllTq55OdRNNtMjbxrSSDfks0aCnx01frZNYtmM8CQDzI11GAHon
 AeUFw/+ApDXvEMUJXv7XVuoenG7qvLnumo0ttt8hszR3Xx8W4UTdiGCBGjtMkRRREwPUuATaNs
 nYYDQ2Fh1IdxjrIh1V3VsYR1etLdHwrBgV8FK+PT0ZpcKNF419nacFYlKVcDFW8kCFeAsu4zhE
 MOI=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.80])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2020 14:02:27 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Gary Guo <gary@garyguo.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v10 12/12] irqchip/sifive-plic: Initialize the plic handler when cpu comes online
Date:   Wed, 26 Feb 2020 14:02:13 -0800
Message-Id: <20200226220213.27423-13-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226220213.27423-1-atish.patra@wdc.com>
References: <20200226220213.27423-1-atish.patra@wdc.com>
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
Reviewed-by: Anup Patel <anup@brainfault.org>
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

