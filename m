Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC44C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9607B20786
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgGFBTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:19:39 -0400
Received: from mail.loongson.cn ([114.242.206.163]:46948 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728356AbgGFBTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:19:38 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn2oefAJfl2VQAA--.1722S5;
        Mon, 06 Jul 2020 09:19:28 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v5 03/14] irqchip/csky-mpintc: Fix potential resource leaks
Date:   Mon,  6 Jul 2020 09:19:14 +0800
Message-Id: <1593998365-25910-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
References: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxn2oefAJfl2VQAA--.1722S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF45KF1xCr1UZryfCFW3Wrg_yoW8try8pF
        48C3yaqrWfGr47Wr1fC3W8Xry5Cw4ft3yUK3ySkas3Jwn8Wr98CF48AF1Duwn3Ja1kJayf
        ZrsFyay5u3WDAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY
        1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
        8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCF
        s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_KwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07br2NNUUUUU=
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
 drivers/irqchip/irq-csky-mpintc.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index a1534ed..df41735 100644
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
@@ -270,12 +274,21 @@ csky_mpintc_init(struct device_node *node, struct device_node *parent)
 
 #ifdef CONFIG_SMP
 	ipi_irq = irq_create_mapping(root_domain, IPI_IRQ);
-	if (!ipi_irq)
-		return -EIO;
+	if (!ipi_irq) {
+		irq_domain_remove(root_domain);
+		ret = -EIO;
+		goto err_iounmap;
+	}
 
 	set_send_ipi(&csky_mpintc_send_ipi, ipi_irq);
 #endif
 
 	return 0;
+
+err_iounmap:
+	iounmap(INTCG_base);
+err_free:
+	kfree(__trigger);
+	return ret;
 }
 IRQCHIP_DECLARE(csky_mpintc, "csky,mpintc", csky_mpintc_init);
-- 
2.1.0

