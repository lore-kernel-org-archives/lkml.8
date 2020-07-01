Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B737EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8E1207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgGACRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:17:17 -0400
Received: from mail.loongson.cn ([114.242.206.163]:47672 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726724AbgGACQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:16:36 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2r68fteU2dNAA--.5801S7;
        Wed, 01 Jul 2020 10:16:28 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v4 05/14] irqchip/davinci-cp-intc: Fix potential resource leaks
Date:   Wed,  1 Jul 2020 10:16:17 +0800
Message-Id: <1593569786-11500-6-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxz2r68fteU2dNAA--.5801S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXw17Xw13Xw4kGry3Ww4fAFb_yoW5Gr45pr
        4rA3y3Gr48Jr1rXrs3AFyrWF9Ikw1qkrW2krW7Cas7CrsYyryjkr15KFnrZFyUua1UZr1U
        Aa1fG3W09Fy5Zw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBqb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWx
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4UMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Gii3UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function davinci_cp_intc_do_init(), system resources
"config->reg.start", "davinci_cp_intc_base" and "irq_base"
were not released in a few error cases. Thus add jump targets
for the completion of the desired exception handling.

Fixes: 0fc3d74cf946 ("irqchip: davinci-cp-intc: move the driver to drivers/irqchip")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/irqchip/irq-davinci-cp-intc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-davinci-cp-intc.c b/drivers/irqchip/irq-davinci-cp-intc.c
index 276da277..2c2e115 100644
--- a/drivers/irqchip/irq-davinci-cp-intc.c
+++ b/drivers/irqchip/irq-davinci-cp-intc.c
@@ -162,6 +162,7 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 	unsigned int num_regs = BITS_TO_LONGS(config->num_irqs);
 	int offset, irq_base;
 	void __iomem *req;
+	int ret;
 
 	req = request_mem_region(config->reg.start,
 				 resource_size(&config->reg),
@@ -175,7 +176,8 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 				       resource_size(&config->reg));
 	if (!davinci_cp_intc_base) {
 		pr_err("%s: unable to ioremap register range\n", __func__);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_release;
 	}
 
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_GLOBAL_ENABLE);
@@ -210,7 +212,8 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 	if (irq_base < 0) {
 		pr_err("%s: unable to allocate interrupt descriptors: %d\n",
 		       __func__, irq_base);
-		return irq_base;
+		ret = irq_base;
+		goto err_iounmap;
 	}
 
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
@@ -219,7 +222,8 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 
 	if (!davinci_cp_intc_irq_domain) {
 		pr_err("%s: unable to create an interrupt domain\n", __func__);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_free_descs;
 	}
 
 	set_handle_irq(davinci_cp_intc_handle_irq);
@@ -228,6 +232,14 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_GLOBAL_ENABLE);
 
 	return 0;
+
+err_free_descs:
+	irq_free_descs(irq_base, config->num_irqs);
+err_iounmap:
+	iounmap(davinci_cp_intc_base);
+err_release:
+	release_mem_region(config->reg.start, resource_size(&config->reg));
+	return ret;
 }
 
 int __init davinci_cp_intc_init(const struct davinci_cp_intc_config *config)
-- 
2.1.0

