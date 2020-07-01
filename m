Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29CDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B593B207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGACRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:17:12 -0400
Received: from mail.loongson.cn ([114.242.206.163]:47648 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726734AbgGACQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:16:37 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2r68fteU2dNAA--.5801S12;
        Wed, 01 Jul 2020 10:16:30 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v4 10/14] irqchip/nvic: Fix potential resource leaks
Date:   Wed,  1 Jul 2020 10:16:22 +0800
Message-Id: <1593569786-11500-11-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxz2r68fteU2dNAA--.5801S12
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyxArW5GFW5JFy7ArWUJwb_yoW8XF4DpF
        WUW39I9r4fJF1xurykCw4UZryYyrW0krWxK3yfKwn7Zrn5A3yDCF10kF1qvF1YkFWxCF47
        ZF4kJFyrCF4UAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

In the function nvic_of_init(), system resource "nvic_base" and
"nvic_irq_domain" were not released in a few error cases. Thus add
jump targets for the completion of the desired exception handling.

Fixes: 292ec080491d ("irqchip: Add support for ARMv7-M NVIC")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/irqchip/irq-nvic.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index f747e22..cd17f5d 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -94,7 +94,8 @@ static int __init nvic_of_init(struct device_node *node,
 
 	if (!nvic_irq_domain) {
 		pr_warn("Failed to allocate irq domain\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_iounmap;
 	}
 
 	ret = irq_alloc_domain_generic_chips(nvic_irq_domain, 32, 1,
@@ -102,8 +103,7 @@ static int __init nvic_of_init(struct device_node *node,
 					     clr, 0, IRQ_GC_INIT_MASK_CACHE);
 	if (ret) {
 		pr_warn("Failed to allocate irq chips\n");
-		irq_domain_remove(nvic_irq_domain);
-		return ret;
+		goto err_domain_remove;
 	}
 
 	for (i = 0; i < numbanks; ++i) {
@@ -129,5 +129,11 @@ static int __init nvic_of_init(struct device_node *node,
 		writel_relaxed(0, nvic_base + NVIC_IPR + i);
 
 	return 0;
+
+err_domain_remove:
+	irq_domain_remove(nvic_irq_domain);
+err_iounmap:
+	iounmap(nvic_base);
+	return ret;
 }
 IRQCHIP_DECLARE(armv7m_nvic, "arm,armv7m-nvic", nvic_of_init);
-- 
2.1.0

