Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7E5C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 13:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CAE20780
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 13:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gorani.run header.i=@gorani.run header.b="Wp7XIFjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCUNkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 09:40:39 -0400
Received: from mout-u-107.mailbox.org ([91.198.250.252]:25472 "EHLO
        mout-u-107.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgCUNki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 09:40:38 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 48l1xJ4ySSzKpBh;
        Sat, 21 Mar 2020 14:40:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1584798035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6gUTnyBd+wF4DcNE7R2+NzsCS2Cnj7qei4GbwrUoBsU=;
        b=Wp7XIFjG6vsHM2RFsi/R75ByN0PxJkmTChTRZvcA+95nlBCKmnP4g7OSuMA+ZS2VpR+ISZ
        7Atuz113Kb5RaHrkzhR61DmpN+ggZqWjOdqQZdgV7ChSvSJCaao6aWwFLXWBSQLt5WL9yX
        gBV+5eHxP880JVPNiKZqrJ05hmDGThEySDr/3gRb9RQABUoqYt9FMZB5uneBp//M2o5SUg
        OGI+qnmtISB7gtviyrw37VajKO7QRZgjsf2e7TkOv0zsfphv4E/+4HGsW7rvenPcSqIbg8
        iEffaHuAVBQMe6o7j+iDeT5+PcvCKryZAAOEvSY1YxqFy9j+btbl7H1FzQjrNQ==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id Gpg7pxJw-UWe; Sat, 21 Mar 2020 14:40:33 +0100 (CET)
From:   Sungbo Eo <mans0n@gorani.run>
To:     linux-oxnas@groups.io, Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sungbo Eo <mans0n@gorani.run>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH] irqchip/versatile-fpga: Apply clear-mask earlier
Date:   Sat, 21 Mar 2020 22:38:42 +0900
Message-Id: <20200321133842.2408823-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear its own IRQs before the parent IRQ get enabled, so that the
remaining IRQs do not accidentally interrupt the parent IRQ controller.

This patch also fixes a reboot bug on OX820 SoC, where the remaining
rps-timer IRQ raises a GIC interrupt that is left pending. After that,
the rps-timer IRQ is cleared during driver initialization, and there's
no IRQ left in rps-irq when local_irq_enable() is called, which evokes
an error message "unexpected IRQ trap".

Fixes: bdd272cbb97a ("irqchip: versatile FPGA: support cascaded interrupts from DT")
Signed-off-by: Sungbo Eo <mans0n@gorani.run>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Daniel Golle <daniel@makrotopia.org>
---
 drivers/irqchip/irq-versatile-fpga.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 70e2cfff8175..f1386733d3bc 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -212,6 +212,9 @@ int __init fpga_irq_of_init(struct device_node *node,
 	if (of_property_read_u32(node, "valid-mask", &valid_mask))
 		valid_mask = 0;
 
+	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
+	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
+
 	/* Some chips are cascaded from a parent IRQ */
 	parent_irq = irq_of_parse_and_map(node, 0);
 	if (!parent_irq) {
@@ -221,9 +224,6 @@ int __init fpga_irq_of_init(struct device_node *node,
 
 	fpga_irq_init(base, node->name, 0, parent_irq, valid_mask, node);
 
-	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
-	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
-
 	/*
 	 * On Versatile AB/PB, some secondary interrupts have a direct
 	 * pass-thru to the primary controller for IRQs 20 and 22-31 which need
-- 
2.25.2

