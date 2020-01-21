Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22F2C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAD324656
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgAUMm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:42:56 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728898AbgAUMmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:42:53 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8B9C710EB62758289330
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 20:42:45 +0800 (CST)
Received: from huawei.com (10.175.104.245) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 21 Jan 2020
 20:42:33 +0800
From:   l00520965 <liuchao173@huawei.com>
To:     <tglx@linutronix.de>
CC:     <linfeilong@huawei.com>, <hushiyuan@huawei.com>,
        LiuChao <liuchao173@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC] irq: Skip printing irq when desc->action is null even if any_count is not zero
Date:   Tue, 21 Jan 2020 21:09:59 +0800
Message-ID: <20200121130959.22589-1-liuchao173@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.245]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: LiuChao <liuchao173@huawei.com>

When desc->action is empty, there is no need to print out the irq and its'
count in each cpu. The desc is not alloced in request_irq or freed in
free_irq. So some PCI devices, such as rtl8139, uses request_irq and
free_irq, which only modify the action of desc. So /proc/interrupts could
be like this:

           CPU0       CPU1
  2:      69397      69267     GICv3  27 Level     arch_timer
  4:          0          0     GICv3  33 Level     uart-pl011
 38:         46          0     GICv3  36 Level     ehci_hcd:usb1
 39:         66          0     GICv3  37 Level
 40:          0          0     GICv3  38 Level     virtio1
 42:          0          0     GICv3  23 Level     arm-pmu
 43:          0          0  ARMH0061:00   3 Edge      ACPI:Event
 44:          1          0   ITS-MSI 32768 Edge      PCIe PME, pciehp
 45:          0          0   ITS-MSI 32769 Edge      aerdrv

Irqbalance gets the list of interrupts according to /proc/interrupts. In
this case, irqbalance does not remove the interrupt from the balance list,
and the last string in this line,which is Level, is used as irq_name.

Or we can clear desc->kstat_irqs in each cpu in free_irq when desc->action
is null?

Signed-off-by: LiuChao <liuchao173@huawei.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 kernel/irq/proc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index cfc4f088a0e7..b27169e587f4 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -439,7 +439,7 @@ int show_interrupts(struct seq_file *p, void *v)
 {
 	static int prec;
 
-	unsigned long flags, any_count = 0;
+	unsigned long flags;
 	int i = *(loff_t *) v, j;
 	struct irqaction *action;
 	struct irq_desc *desc;
@@ -466,11 +466,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc)
 		goto outsparse;
 
-	if (desc->kstat_irqs)
-		for_each_online_cpu(j)
-			any_count |= *per_cpu_ptr(desc->kstat_irqs, j);
-
-	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
+	if (!desc->action || irq_desc_is_chained(desc))
 		goto outsparse;
 
 	seq_printf(p, "%*d: ", prec, i);
-- 
2.19.1

