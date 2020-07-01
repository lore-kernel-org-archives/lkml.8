Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859A8C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682EA2073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgGACWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:22:40 -0400
Received: from mail.loongson.cn ([114.242.206.163]:49148 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbgGACWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:22:40 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2r68fteU2dNAA--.5801S15;
        Wed, 01 Jul 2020 10:16:31 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v4 13/14] irqchip/s3c24xx: Fix potential resource leaks
Date:   Wed,  1 Jul 2020 10:16:25 +0800
Message-Id: <1593569786-11500-14-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxz2r68fteU2dNAA--.5801S15
X-Coremail-Antispam: 1UD129KBjvJXoWxJr18KFW8Xw47CFWxWw4rXwb_yoW8ZFy5pF
        W8G390gr48GF47Wr4fKw4DZFyaka48KrWUK34SkasF9FnxWryktFy8ZFyqvr1rC3yxGFyr
        JF47Za1jkF1UC3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBvb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
        x4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWx
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4UMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr6p9UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function s3c_init_intc_of(), system resource "reg_base", "domain"
and "intc" were not released in a few error cases. Thus add jump targets
for the completion of the desired exception handling.

Fixes: f0774d41da0e ("irqchip: s3c24xx: add devicetree support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/irqchip/irq-s3c24xx.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index d2031fe..166c27b 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -1227,7 +1227,7 @@ static int __init s3c_init_intc_of(struct device_node *np,
 	struct s3c24xx_irq_of_ctrl *ctrl;
 	struct irq_domain *domain;
 	void __iomem *reg_base;
-	int i;
+	int i, ret;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -1239,7 +1239,8 @@ static int __init s3c_init_intc_of(struct device_node *np,
 						     &s3c24xx_irq_ops_of, NULL);
 	if (!domain) {
 		pr_err("irq: could not create irq-domain\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_iounmap;
 	}
 
 	for (i = 0; i < num_ctrl; i++) {
@@ -1248,15 +1249,17 @@ static int __init s3c_init_intc_of(struct device_node *np,
 		pr_debug("irq: found controller %s\n", ctrl->name);
 
 		intc = kzalloc(sizeof(struct s3c_irq_intc), GFP_KERNEL);
-		if (!intc)
-			return -ENOMEM;
+		if (!intc) {
+			ret = -ENOMEM;
+			goto out_domain_remove;
+		}
 
 		intc->domain = domain;
 		intc->irqs = kcalloc(32, sizeof(struct s3c_irq_data),
 				     GFP_KERNEL);
 		if (!intc->irqs) {
-			kfree(intc);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out_free;
 		}
 
 		if (ctrl->parent) {
@@ -1285,6 +1288,14 @@ static int __init s3c_init_intc_of(struct device_node *np,
 	set_handle_irq(s3c24xx_handle_irq);
 
 	return 0;
+
+out_free:
+	kfree(intc);
+out_domain_remove:
+	irq_domain_remove(domain);
+out_iounmap:
+	iounmap(reg_base);
+	return ret;
 }
 
 static struct s3c24xx_irq_of_ctrl s3c2410_ctrl[] = {
-- 
2.1.0

