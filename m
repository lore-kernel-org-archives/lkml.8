Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B43C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CAF2076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgGQBw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:52:26 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:38770 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgGQBwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:52:25 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 5B07CC5C96;
        Fri, 17 Jul 2020 09:52:22 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22085T140330059949824S1594950740444703_;
        Fri, 17 Jul 2020 09:52:21 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <cad690310766119713eafb7a4357bfcc>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     heiko@sntech.de, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kever.yang@rock-chips.com,
        david.wu@rock-chips.com, Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 05/13] pinctrl: rockchip: create irq mapping in gpio_to_irq
Date:   Fri, 17 Jul 2020 09:52:19 +0800
Message-Id: <20200717015219.14047-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717014908.13914-1-jay.xu@rock-chips.com>
References: <20200717014908.13914-1-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove totally irq mappings create in probe, the gpio irq mapping will
be created when do
    gpio_to_irq ->
        rockchip_gpio_to_irq ->
            irq_create_mapping

This patch can speed up system boot on, also abandon many unused irq
mappings' create.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index d34fada39227..1be4627f3877 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -3196,7 +3196,7 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 
 		irq = __ffs(pend);
 		pend &= ~BIT(irq);
-		virq = irq_linear_revmap(bank->domain, irq);
+		virq = irq_find_mapping(bank->domain, irq);
 
 		if (!virq) {
 			dev_err(bank->drvdata->dev, "unmapped irq %d\n", irq);
@@ -3375,7 +3375,7 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct irq_chip_generic *gc;
 	int ret;
-	int i, j;
+	int i;
 
 	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
 		if (!bank->valid) {
@@ -3402,7 +3402,7 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 
 		ret = irq_alloc_domain_generic_chips(bank->domain, 32, 1,
 					 "rockchip_gpio_irq", handle_level_irq,
-					 clr, 0, IRQ_GC_INIT_MASK_CACHE);
+					 clr, 0, 0);
 		if (ret) {
 			dev_err(&pdev->dev, "could not alloc generic chips for bank %s\n",
 				bank->name);
@@ -3411,14 +3411,6 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 			continue;
 		}
 
-		/*
-		 * Linux assumes that all interrupts start out disabled/masked.
-		 * Our driver only uses the concept of masked and always keeps
-		 * things enabled, so for us that's all masked and all enabled.
-		 */
-		writel_relaxed(0xffffffff, bank->reg_base + GPIO_INTMASK);
-		writel_relaxed(0xffffffff, bank->reg_base + GPIO_INTEN);
-
 		gc = irq_get_domain_generic_chip(bank->domain, 0);
 		gc->reg_base = bank->reg_base;
 		gc->private = bank;
@@ -3435,13 +3427,17 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 		gc->chip_types[0].chip.irq_set_type = rockchip_irq_set_type;
 		gc->wake_enabled = IRQ_MSK(bank->nr_pins);
 
+		/*
+		 * Linux assumes that all interrupts start out disabled/masked.
+		 * Our driver only uses the concept of masked and always keeps
+		 * things enabled, so for us that's all masked and all enabled.
+		 */
+		writel_relaxed(0xffffffff, bank->reg_base + GPIO_INTMASK);
+		writel_relaxed(0xffffffff, bank->reg_base + GPIO_INTEN);
+		gc->mask_cache = 0xffffffff;
+
 		irq_set_chained_handler_and_data(bank->irq,
 						 rockchip_irq_demux, bank);
-
-		/* map the gpio irqs here, when the clock is still running */
-		for (j = 0 ; j < 32 ; j++)
-			irq_create_mapping(bank->domain, j);
-
 		clk_disable(bank->clk);
 	}
 
-- 
2.17.1



