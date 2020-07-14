Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D351C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6FB22510
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGNOMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:12:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33884 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbgGNOMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:12:52 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2947372FCC856207FD9F;
        Tue, 14 Jul 2020 22:12:50 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Jul 2020 22:12:42 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] irqchip: mips-gic: Make some symbols static
Date:   Tue, 14 Jul 2020 22:22:45 +0800
Message-ID: <20200714142245.16124-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/irqchip/irq-mips-gic.c:49:1: warning:
 symbol '__pcpu_scope_pcpu_masks' was not declared. Should it be static?
drivers/irqchip/irq-mips-gic.c:620:6: warning:
 symbol 'gic_ipi_domain_free' was not declared. Should it be static?
drivers/irqchip/irq-mips-gic.c:634:5: warning:
 symbol 'gic_ipi_domain_match' was not declared. Should it be static?

Those symbols are not used outside of irq-mips-gic.c, so marks
them static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/irqchip/irq-mips-gic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index d70507133c1d..aacfa012c082 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -46,7 +46,7 @@
 
 void __iomem *mips_gic_base;
 
-DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
+static DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
 
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
@@ -617,8 +617,8 @@ static int gic_ipi_domain_alloc(struct irq_domain *d, unsigned int virq,
 	return ret;
 }
 
-void gic_ipi_domain_free(struct irq_domain *d, unsigned int virq,
-			 unsigned int nr_irqs)
+static void gic_ipi_domain_free(struct irq_domain *d, unsigned int virq,
+				unsigned int nr_irqs)
 {
 	irq_hw_number_t base_hwirq;
 	struct irq_data *data;
@@ -631,8 +631,8 @@ void gic_ipi_domain_free(struct irq_domain *d, unsigned int virq,
 	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 }
 
-int gic_ipi_domain_match(struct irq_domain *d, struct device_node *node,
-			 enum irq_domain_bus_token bus_token)
+static int gic_ipi_domain_match(struct irq_domain *d, struct device_node *node,
+				enum irq_domain_bus_token bus_token)
 {
 	bool is_ipi;
 

