Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD044C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71B52070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgGFB04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:26:56 -0400
Received: from mail.loongson.cn ([114.242.206.163]:48950 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728471AbgGFB0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:26:52 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn2oefAJfl2VQAA--.1722S15;
        Mon, 06 Jul 2020 09:19:32 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v5 13/14] irqchip/s3c24xx: Fix potential resource leaks
Date:   Mon,  6 Jul 2020 09:19:24 +0800
Message-Id: <1593998365-25910-14-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
References: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxn2oefAJfl2VQAA--.1722S15
X-Coremail-Antispam: 1UD129KBjvJXoWxJr18KFW8Xw47CFWxWw4rXwb_yoW8ZFy5pF
        W8G39Igr48Ja17Wr4rKr48Zr9Ika48KrWUK3y2kas29FnxWryvyFy8ZFyqvr1rCrWxGF1f
        JF47ZF40kF1DC3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_KwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7VyxDUUUU
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
index d2031fe..cf48e4b 100644
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
+		goto err_iounmap;
 	}
 
 	for (i = 0; i < num_ctrl; i++) {
@@ -1248,15 +1249,17 @@ static int __init s3c_init_intc_of(struct device_node *np,
 		pr_debug("irq: found controller %s\n", ctrl->name);
 
 		intc = kzalloc(sizeof(struct s3c_irq_intc), GFP_KERNEL);
-		if (!intc)
-			return -ENOMEM;
+		if (!intc) {
+			ret = -ENOMEM;
+			goto err_domain_remove;
+		}
 
 		intc->domain = domain;
 		intc->irqs = kcalloc(32, sizeof(struct s3c_irq_data),
 				     GFP_KERNEL);
 		if (!intc->irqs) {
-			kfree(intc);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_free;
 		}
 
 		if (ctrl->parent) {
@@ -1285,6 +1288,14 @@ static int __init s3c_init_intc_of(struct device_node *np,
 	set_handle_irq(s3c24xx_handle_irq);
 
 	return 0;
+
+err_free:
+	kfree(intc);
+err_domain_remove:
+	irq_domain_remove(domain);
+err_iounmap:
+	iounmap(reg_base);
+	return ret;
 }
 
 static struct s3c24xx_irq_of_ctrl s3c2410_ctrl[] = {
-- 
2.1.0

