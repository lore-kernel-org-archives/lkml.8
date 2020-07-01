Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EE5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96FB207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgGACRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:17:14 -0400
Received: from mail.loongson.cn ([114.242.206.163]:47694 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbgGACQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:16:36 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2r68fteU2dNAA--.5801S9;
        Wed, 01 Jul 2020 10:16:29 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v4 07/14] irqchip/dw-apb-ictl: Fix potential resource leaks
Date:   Wed,  1 Jul 2020 10:16:19 +0800
Message-Id: <1593569786-11500-8-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxz2r68fteU2dNAA--.5801S9
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW8Jr1fWrWrJrW7WryfJFb_yoW8AF4kpF
        4rW39akryfJF17XFn5CrWUX3say3W8tay7C3yIkan3Zr9xC34DCr1rtFyjyF15AFWxGa1a
        9F4vyFy8Ca1DJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
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
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4eMKDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function dw_apb_ictl_init(), system resources "irq" and "domain"
were not released in a few error cases. Thus add jump targets for the
completion of the desired exception handling.

Fixes: 350d71b94fc9 ("irqchip: add DesignWare APB ICTL interrupt controller")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/irqchip/irq-dw-apb-ictl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index e4550e9..bc9b750 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -86,12 +86,13 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	ret = of_address_to_resource(np, 0, &r);
 	if (ret) {
 		pr_err("%pOF: unable to get resource\n", np);
-		return ret;
+		goto err_irq_dispose;
 	}
 
 	if (!request_mem_region(r.start, resource_size(&r), np->full_name)) {
 		pr_err("%pOF: unable to request mem region\n", np);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_irq_dispose;
 	}
 
 	iobase = ioremap(r.start, resource_size(&r));
@@ -133,7 +134,7 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 					     IRQ_GC_INIT_MASK_CACHE);
 	if (ret) {
 		pr_err("%pOF: unable to alloc irq domain gc\n", np);
-		goto err_unmap;
+		goto err_domain_remove;
 	}
 
 	for (i = 0; i < DIV_ROUND_UP(nrirqs, 32); i++) {
@@ -150,10 +151,14 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 
 	return 0;
 
+err_domain_remove:
+	irq_domain_remove(domain);
 err_unmap:
 	iounmap(iobase);
 err_release:
 	release_mem_region(r.start, resource_size(&r));
+err_irq_dispose:
+	irq_dispose_mapping(irq);
 	return ret;
 }
 IRQCHIP_DECLARE(dw_apb_ictl,
-- 
2.1.0

