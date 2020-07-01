Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B47C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B334207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgGACQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:16:53 -0400
Received: from mail.loongson.cn ([114.242.206.163]:47714 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726744AbgGACQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:16:37 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2r68fteU2dNAA--.5801S8;
        Wed, 01 Jul 2020 10:16:29 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v4 06/14] irqchip/digicolor: Fix potential resource leaks
Date:   Wed,  1 Jul 2020 10:16:18 +0800
Message-Id: <1593569786-11500-7-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxz2r68fteU2dNAA--.5801S8
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW8AFW5Cr43trWruw1kAFb_yoW8uryUpF
        WUGa9IgrWIvw4xWF1vkFyUZF98Kr4xKa9ru3yxC3Z2vrn5C34qkFyUAF1j9FyrArWxZa1j
        vFs7tFy8C3WUKaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gr1l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcRwZDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function digicolor_of_init(), system resources "reg_base" and
"digicolor_irq_domain" were not released in a few error cases. Thus
add jump targets for the completion of the desired exception handling.

Fixes: 8041dfbd31cf ("irqchip: Conexant CX92755 interrupts controller driver")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/irqchip/irq-digicolor.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-digicolor.c b/drivers/irqchip/irq-digicolor.c
index fc38d2d..18c6e77 100644
--- a/drivers/irqchip/irq-digicolor.c
+++ b/drivers/irqchip/irq-digicolor.c
@@ -89,7 +89,8 @@ static int __init digicolor_of_init(struct device_node *node,
 	ucregs = syscon_regmap_lookup_by_phandle(node, "syscon");
 	if (IS_ERR(ucregs)) {
 		pr_err("%pOF: unable to map UC registers\n", node);
-		return PTR_ERR(ucregs);
+		ret = PTR_ERR(ucregs);
+		goto err_iounmap;
 	}
 	/* channel 1, regular IRQs */
 	regmap_write(ucregs, UC_IRQ_CONTROL, 1);
@@ -98,7 +99,8 @@ static int __init digicolor_of_init(struct device_node *node,
 		irq_domain_add_linear(node, 64, &irq_generic_chip_ops, NULL);
 	if (!digicolor_irq_domain) {
 		pr_err("%pOF: unable to create IRQ domain\n", node);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_iounmap;
 	}
 
 	ret = irq_alloc_domain_generic_chips(digicolor_irq_domain, 32, 1,
@@ -106,7 +108,7 @@ static int __init digicolor_of_init(struct device_node *node,
 					     clr, 0, 0);
 	if (ret) {
 		pr_err("%pOF: unable to allocate IRQ gc\n", node);
-		return ret;
+		goto err_domain_remove;
 	}
 
 	digicolor_set_gc(reg_base, 0, IC_INT0ENABLE_LO, IC_FLAG_CLEAR_LO);
@@ -115,5 +117,11 @@ static int __init digicolor_of_init(struct device_node *node,
 	set_handle_irq(digicolor_handle_irq);
 
 	return 0;
+
+err_domain_remove:
+	irq_domain_remove(digicolor_irq_domain);
+err_iounmap:
+	iounmap(reg_base);
+	return ret;
 }
 IRQCHIP_DECLARE(conexant_digicolor_ic, "cnxt,cx92755-ic", digicolor_of_init);
-- 
2.1.0

