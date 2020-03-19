Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93F6C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B26020724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gorani.run header.i=@gorani.run header.b="pNO+MQyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCSIPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:15:39 -0400
Received: from mout-u-107.mailbox.org ([91.198.250.252]:57542 "EHLO
        mout-u-107.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgCSIPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:15:38 -0400
Received: by mout-u-107.mailbox.org (Postfix, from userid 51)
        id 48jfdc5ZhdzKnvC; Thu, 19 Mar 2020 09:06:40 +0100 (CET)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 48jWJW00Y7zKp7s;
        Thu, 19 Mar 2020 03:36:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1584585417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ERpvMrK/UaDTvkIoSj6AknzdzJX6Ereus6KjymOIMWM=;
        b=pNO+MQySdvo4EMik8yKPyOgZHetMjJNsxtHde2yGeduT9VXjz3KNh93+mPFISbax4He/fL
        ZyJNhfGD+77JFfTfGUQWtXAuUFj7taiIpA4lkGtmjSxWabkKeG+ykH4ofktMsmIbLi4Hre
        /weoS3vN1K1u/n68+F/Dedma7U42fE7CjWLO89sPcn3U0YoWfgy98LlhcJ1MLDnFzkGSdw
        XW02TIknUddGC1O1q5QgIAl3DzOtyIiggGR7U6nQBF59SpjPK9J4phcXuKYnnq855MWq2n
        7tevK0bCqdk2b1wA9kVPVpSLc2S7LRx1Gni9+SR7Va9rzFDH8BCvqWZYZgQP/Q==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id yN29WkZ56Jih; Thu, 19 Mar 2020 03:36:55 +0100 (CET)
From:   Sungbo Eo <mans0n@gorani.run>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-oxnas@groups.io
Cc:     Sungbo Eo <mans0n@gorani.run>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2] irqchip/versatile-fpga: Handle chained IRQs properly
Date:   Thu, 19 Mar 2020 11:34:48 +0900
Message-Id: <20200319023448.1479701-1-mans0n@gorani.run>
In-Reply-To: <002b72cab9896fa5ac76a52e0cb503ff@kernel.org>
References: <002b72cab9896fa5ac76a52e0cb503ff@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclose the chained handler with chained_irq_{enter,exit}(), so that the
muxed interrupts get properly acked.

This patch also fixes a reboot bug on OX820 SoC, where the jiffies timer
interrupt is never acked. The kernel waits a clock tick forever in
calibrate_delay_converge(), which leads to a boot hang.

Fixes: c41b16f8c9d9 ("ARM: integrator/versatile: consolidate FPGA IRQ handling code")
Signed-off-by: Sungbo Eo <mans0n@gorani.run>
Cc: Neil Armstrong <narmstrong@baylibre.com>
---
v2: moved readl below chained_irq_enter()
    added Fixes tag

 drivers/irqchip/irq-versatile-fpga.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 928858dada75..70e2cfff8175 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -6,6 +6,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/versatile-fpga.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
@@ -68,12 +69,16 @@ static void fpga_irq_unmask(struct irq_data *d)
 
 static void fpga_irq_handle(struct irq_desc *desc)
 {
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct fpga_irq_data *f = irq_desc_get_handler_data(desc);
-	u32 status = readl(f->base + IRQ_STATUS);
+	u32 status;
+
+	chained_irq_enter(chip, desc);
 
+	status = readl(f->base + IRQ_STATUS);
 	if (status == 0) {
 		do_bad_IRQ(desc);
-		return;
+		goto out;
 	}
 
 	do {
@@ -82,6 +87,9 @@ static void fpga_irq_handle(struct irq_desc *desc)
 		status &= ~(1 << irq);
 		generic_handle_irq(irq_find_mapping(f->domain, irq));
 	} while (status);
+
+out:
+	chained_irq_exit(chip, desc);
 }
 
 /*
-- 
2.25.1

