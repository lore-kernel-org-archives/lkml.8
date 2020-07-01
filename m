Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3233CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CAFE207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgGACWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:22:41 -0400
Received: from mail.loongson.cn ([114.242.206.163]:49150 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgGACWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:22:40 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2r68fteU2dNAA--.5801S5;
        Wed, 01 Jul 2020 10:16:28 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v4 03/14] irqchip/csky-mpintc: Fix potential resource leaks
Date:   Wed,  1 Jul 2020 10:16:15 +0800
Message-Id: <1593569786-11500-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxz2r68fteU2dNAA--.5801S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF45KF18ZFW8JFyDCrW3Wrg_yoW8tFWrpF
        48C3yaqrWxGr17Wr1fC3W8Xry5G3yft3yUK3ySkas3Jrn8Wr98CF48AF1Duwn3Ja1rJayf
        Zrsrtay5u3WDAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
        aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4UMxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
        WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
        UYn0eJUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function csky_mpintc_init(), system resources "__trigger",
"INTCG_base" and "root_domain" were not released in a few error
cases. Thus add jump targets for the completion of the desired
exception handling. By the way, do some coding-style cleanups
suggested by Markus.

Fixes: d8a5f5f79122 ("irqchip: add C-SKY SMP interrupt controller")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/irqchip/irq-csky-mpintc.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index a1534ed..d7edc28 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -241,14 +241,16 @@ csky_mpintc_init(struct device_node *node, struct device_node *parent)
 		nr_irq = INTC_IRQS;
 
 	__trigger  = kcalloc(nr_irq, sizeof(unsigned long), GFP_KERNEL);
-	if (__trigger == NULL)
+	if (!__trigger)
 		return -ENXIO;
 
-	if (INTCG_base == NULL) {
+	if (!INTCG_base) {
 		INTCG_base = ioremap(mfcr("cr<31, 14>"),
-				     INTCL_SIZE*nr_cpu_ids + INTCG_SIZE);
-		if (INTCG_base == NULL)
-			return -EIO;
+				     INTCL_SIZE * nr_cpu_ids + INTCG_SIZE);
+		if (!INTCG_base) {
+			ret = -EIO;
+			goto err_free;
+		}
 
 		INTCL_base = INTCG_base + INTCG_SIZE;
 
@@ -257,8 +259,10 @@ csky_mpintc_init(struct device_node *node, struct device_node *parent)
 
 	root_domain = irq_domain_add_linear(node, nr_irq, &csky_irqdomain_ops,
 					    NULL);
-	if (!root_domain)
-		return -ENXIO;
+	if (!root_domain) {
+		ret = -ENXIO;
+		goto err_iounmap;
+	}
 
 	/* for every cpu */
 	for_each_present_cpu(cpu) {
@@ -270,12 +274,24 @@ csky_mpintc_init(struct device_node *node, struct device_node *parent)
 
 #ifdef CONFIG_SMP
 	ipi_irq = irq_create_mapping(root_domain, IPI_IRQ);
-	if (!ipi_irq)
-		return -EIO;
+	if (!ipi_irq) {
+		ret = -EIO;
+		goto err_domain_remove;
+	}
 
 	set_send_ipi(&csky_mpintc_send_ipi, ipi_irq);
 #endif
 
 	return 0;
+
+#ifdef CONFIG_SMP
+err_domain_remove:
+	irq_domain_remove(root_domain);
+#endif
+err_iounmap:
+	iounmap(INTCG_base);
+err_free:
+	kfree(__trigger);
+	return ret;
 }
 IRQCHIP_DECLARE(csky_mpintc, "csky,mpintc", csky_mpintc_init);
-- 
2.1.0

