Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F62CC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7605220724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gorani.run header.i=@gorani.run header.b="xESSd49P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgCSIOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:14:43 -0400
Received: from mout-u-204.mailbox.org ([91.198.250.253]:21842 "EHLO
        mout-u-204.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgCSIOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:14:40 -0400
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 04:14:39 EDT
Received: by mout-u-204.mailbox.org (Postfix, from userid 51)
        id 48jfcM4JnmzQlG0; Thu, 19 Mar 2020 08:05:18 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 48jGln33z3zQlFx;
        Wed, 18 Mar 2020 18:11:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1584551476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rjeQJtst2T6i2m2bmZKswd/k9BXvMflb7UrV/wjEqqA=;
        b=xESSd49PLCdfXlqlQWuJ+m4wfH0gYPY4nAy0F2G3ZYImoo0HugUoRXJVig5pRYeeeqrvhc
        PxKCJ6Z1g05HxUHMF6Vjh1rx9JtYgEQ6zAOqZwtqtyPhHhZ1QiNWpD2nt76YGR9HjZnc7D
        4XtPN0QmKyRe/gMmVy5m9F07e5iU/I0iqD6DaFyJJgNZf59AjByqNn+rLr5Rwneuubcp99
        Rw3S9SIaMhEAk68OmLaj5W4fHr69yhOLSVFKaTTNFJCyB0jJT9aAhUBOrkt35fFqXrvunZ
        5lPXEbqeIVegUx10nJlGqZwthV7sOP0Y1wfGnGzpX2VmT+xbiqseuVPWCOcaHQ==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id dDnmRVvElgnL; Wed, 18 Mar 2020 18:11:14 +0100 (CET)
From:   Sungbo Eo <mans0n@gorani.run>
To:     linux-oxnas@groups.io, Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sungbo Eo <mans0n@gorani.run>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] irqchip/versatile-fpga: Handle chained IRQs properly
Date:   Thu, 19 Mar 2020 02:09:04 +0900
Message-Id: <20200318170904.1461278-1-mans0n@gorani.run>
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

Signed-off-by: Sungbo Eo <mans0n@gorani.run>
Cc: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/irqchip/irq-versatile-fpga.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 928858dada75..08faab2fec3e 100644
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
@@ -68,12 +69,15 @@ static void fpga_irq_unmask(struct irq_data *d)
 
 static void fpga_irq_handle(struct irq_desc *desc)
 {
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct fpga_irq_data *f = irq_desc_get_handler_data(desc);
 	u32 status = readl(f->base + IRQ_STATUS);
 
+	chained_irq_enter(chip, desc);
+
 	if (status == 0) {
 		do_bad_IRQ(desc);
-		return;
+		goto out;
 	}
 
 	do {
@@ -82,6 +86,9 @@ static void fpga_irq_handle(struct irq_desc *desc)
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

