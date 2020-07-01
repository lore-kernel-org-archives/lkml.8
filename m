Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BE3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1C0207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgGACQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:16:56 -0400
Received: from mail.loongson.cn ([114.242.206.163]:47690 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726754AbgGACQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:16:37 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2r68fteU2dNAA--.5801S6;
        Wed, 01 Jul 2020 10:16:28 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v4 04/14] irqchip/davinci-aintc: Fix potential resource leaks
Date:   Wed,  1 Jul 2020 10:16:16 +0800
Message-Id: <1593569786-11500-5-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxz2r68fteU2dNAA--.5801S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW5KF1kGrW8CF4xGryUZFb_yoW5JF17pF
        W5Cw4a9r48tF45XwsxCFyYgFy3Cw1vkFWxC347Kas7ArsYy34v9r15GFZrZFyUGw48X3Wj
        yF4fJa48WF1UZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWx
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4UMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0DKItUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function davinci_aintc_init(), system resources "config->reg.start",
"davinci_aintc_base", "irq_base" and "davinci_aintc_irq_domain" were not
released in a few error cases. Thus add jump targets for the completion of
the desired exception handling.

Fixes: 0145beed9d26 ("irqchip: davinci-aintc: move the driver to drivers/irqchip")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/irqchip/irq-davinci-aintc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-davinci-aintc.c b/drivers/irqchip/irq-davinci-aintc.c
index 810ccc4..2a96dc9 100644
--- a/drivers/irqchip/irq-davinci-aintc.c
+++ b/drivers/irqchip/irq-davinci-aintc.c
@@ -96,7 +96,7 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 				     resource_size(&config->reg));
 	if (!davinci_aintc_base) {
 		pr_err("%s: unable to ioremap register range\n", __func__);
-		return;
+		goto err_release;
 	}
 
 	/* Clear all interrupt requests */
@@ -133,7 +133,7 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 	if (irq_base < 0) {
 		pr_err("%s: unable to allocate interrupt descriptors: %d\n",
 		       __func__, irq_base);
-		return;
+		goto err_iounmap;
 	}
 
 	davinci_aintc_irq_domain = irq_domain_add_legacy(NULL,
@@ -141,7 +141,7 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 						&irq_domain_simple_ops, NULL);
 	if (!davinci_aintc_irq_domain) {
 		pr_err("%s: unable to create interrupt domain\n", __func__);
-		return;
+		goto err_free_descs;
 	}
 
 	ret = irq_alloc_domain_generic_chips(davinci_aintc_irq_domain, 32, 1,
@@ -150,7 +150,7 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 	if (ret) {
 		pr_err("%s: unable to allocate generic irq chips for domain\n",
 		       __func__);
-		return;
+		goto err_domain_remove;
 	}
 
 	for (irq_off = 0, reg_off = 0;
@@ -160,4 +160,14 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 				       irq_base + irq_off, 32);
 
 	set_handle_irq(davinci_aintc_handle_irq);
+	return;
+
+err_domain_remove:
+	irq_domain_remove(davinci_aintc_irq_domain);
+err_free_descs:
+	irq_free_descs(irq_base, config->num_irqs);
+err_iounmap:
+	iounmap(davinci_aintc_base);
+err_release:
+	release_mem_region(config->reg.start, resource_size(&config->reg));
 }
-- 
2.1.0

