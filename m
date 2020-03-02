Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC85BC3F2D8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7191921D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HeFIECEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgCBXN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:13:59 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21108 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgCBXNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583190832; x=1614726832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=An4QxOIbgeJWb2ziaNibTecv8A2NG8L/MhNmQAwRso4=;
  b=HeFIECEaEZs3ytn6eh01UGP3O3Ds6gcahVBYX9BEyq2GHLBYwrnk3fw1
   k6amOqRkQ2WHgrNAhEsZsWzbL7sFQYWp5u1taca1w/u86JlBteHIu4BcR
   R/KgJ+YDQNNKqkrhW5en4lkJdHOPCRELi895FYYcW4QqV6BNo41Gi0kyJ
   pteV/hITE+oO+McYSNWazhi16BbK2mv8gBaWf4Sp0PEKaVbJw0q65m3+w
   hcxRvoyUTPV8rx+JtN/9UE3RhV8yAKVCyd/H7yItgz0LVHp9nasq9VE+Y
   jSeiBaPuh2YK+rtD/WmXZG9PXqa+qhX8Wgwf7uiQT6V3HrPJatx6YFLXK
   g==;
IronPort-SDR: rHQ5drhIeJp8KeSgA59LtcsWgaCq5zhVT78MW6uHBDBKZiI42XbTRWav6gByMVRLa0qEIa8xW0
 RlddbJ+pwbjwMuIny3wldmch791wdNcwnaSQ7GMSTmN33h2x6q8j04P3/jdMY7JQmNV1wl4+Bp
 xsBLfo6Wk5APYFb/6/NKqwZ9sv0mQCnVm5DPnVqDmu4z4JqKXEkRIQ6zkXZNOvumB64uG0Zvyp
 xhbscB81tQmpQltZR5le3WwcIjj6sTLpacizqtCYydcOW44RSZnzN0MzCy2kEecZEhVAgJ6kXm
 Jh8=
X-IronPort-AV: E=Sophos;i="5.70,508,1574092800"; 
   d="scan'208";a="131708411"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2020 07:13:52 +0800
IronPort-SDR: X+6nxLzjcNGx1EMrX6NrVNFhZWFQbKUoTwuIPbAlu2dHYXy/cSFsBCjbgECsxTcWSSAknefZeR
 ZeXY7BuZ6XyGbbHxA83s4gErfhUcdQPgmcHNaRxokfSQcbkoRSzEVrI26OIGJU2uIq5YzMZtU5
 IZvH6WgNw0oMUow+VusJs/9arRjj21/vvyKasQC/gdcNBsk0bNW1T2euTpTLZGu1lv1S/9ybXJ
 +zZ50mgoom8hLRjM5kd1ORc/MaCkOK6Hd9G+CK6n2VXQX/7lCDU7QYJppe5L3y1tXVTnx9kXye
 ywkST0mW4WHvnUEKCcZCwbJZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 15:06:07 -0800
IronPort-SDR: NEpdmUaJ9bZcwWy8DsNyzAMLJ6giCXg883z2OrKbGpn9zhr9ixzPWVF5akUozek7BXnM+Tz9d3
 8gygzaSLUuJyrBukLook9gUK02xsKRSGqMqA19E3jQTahWs+ae7F/JTc+QkvxmbS/qF3T4+6nQ
 DgwvnMaMA4pSBim38e/x7ZC7M5CgWn0rrkpqbzTaRF/phSsdctlNEh73vT8pN1+AR1E2njw/yr
 cezushU2p0XEvaZ1K+hzmBMR9FGhYEZvNp8Aor64A32FMAzPtVprZQyfUoM9CdjCgeL3skoV5+
 w9I=
WDCIronportException: Internal
Received: from usa002267.ad.shared (HELO yoda.hgst.com) ([10.86.54.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Mar 2020 15:13:51 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Anup Patel <anup.patel@wdc.com>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Price <steven.price@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v3 1/2] irqchip/sifive-plic: Enable/Disable external interrupts upon cpu online/offline
Date:   Mon,  2 Mar 2020 15:11:45 -0800
Message-Id: <20200302231146.15530-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200302231146.15530-1-atish.patra@wdc.com>
References: <20200302231146.15530-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/traps.c         |  2 +-
 drivers/irqchip/irq-sifive-plic.c | 38 +++++++++++++++++++++++++++----
 include/linux/cpuhotplug.h        |  1 +
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index ffb3d94bf0cc..55ea614d89bf 100644
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

