Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CB4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8815D20771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgGFB0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:26:55 -0400
Received: from mail.loongson.cn ([114.242.206.163]:48962 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728494AbgGFB0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:26:52 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn2oefAJfl2VQAA--.1722S9;
        Mon, 06 Jul 2020 09:19:30 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v5 07/14] irqchip/dw-apb-ictl: Fix potential resource leaks
Date:   Mon,  6 Jul 2020 09:19:18 +0800
Message-Id: <1593998365-25910-8-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
References: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxn2oefAJfl2VQAA--.1722S9
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW8Jr1fWrWrJrW7WryfJFb_yoW8AF4kpF
        4rW39akryfJF17XFn5CrWUX3say3W8tay7C3yIkan3Zr9xC34DCr1rtFyjyF15AFWxGa1a
        9F4vyFy8Ca1DJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVWkMxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU80tC5UUUUU==
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

