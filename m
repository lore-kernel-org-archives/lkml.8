Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F603C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3456320848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="OOx3LgAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgBLIkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:40:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39334 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbgBLIkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:40:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so1120686wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DJl9GCcO4mEWyRrTF90UKga2x2vqBOpYU34Ub2CR2M=;
        b=OOx3LgAYagkCcZOvOZgg3jnVlIP+iInKjA/8vzzVtNSD79JwDxv0JtKc6caJJ0mOkN
         1o4XdekgdN3815BeioyAkXqvWsE94aQpaA4SAM+T7fOaY/j1enWukajmAa1tBFq51/C4
         ksoCjUHiQx62twnK2bwXRN2pLOxGETiQUGzZfblDU7y75NSqvwwaOGB6/W0Xz24jFr/V
         M//DPJc4ONqEkBC7QTYrVCNyea9T45dC7Vaoxyi3IJ63QzMG4yXo0jrfMVM5YWJ1r4Sp
         2F9t5RenTsB/TMBjGsfx5g5vNU4qFwwCh2wYive8PRYdnb0Argtjdn/KChsBLJF1cYsj
         eqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9DJl9GCcO4mEWyRrTF90UKga2x2vqBOpYU34Ub2CR2M=;
        b=iQZTfBpcYyOqT2ge+gSndIZNwcc2r02LpqHRYr1YiYlSmE9Ry/GV1F72RUXNdqoNBl
         4NkwmDuUYaNjwSfByqKizyFY3kQY6e4cL26LMUZOKNJ6n70YLe9StJaMPzHR3Gqxxoz4
         0LJK14qR7i3QCA8vDGCSigG9okv/rseFWVljq4eJTeRCu1TfplXZtaWZYvjWW9cVLIwk
         5S24uksJgYw6I8e6BhX/F6FuzpVTc2t6sYtJ1Ok9s3HXN7SUU4kQDmYzkzNR9y9ezb7q
         aT5eRUFg0lAwPq7MqBXA/waxSbgVHmmK/FdqNstqHmOG3tcDedoQMXjVtV3qm/ncuyZU
         xxOQ==
X-Gm-Message-State: APjAAAVIevYi36vwSqe5sJgE9UqVHgkwdjUXNL2MvT3kOvSxDLUfoPNN
        1L64n0vUoJh628GsRxZ8e0W5xIdwpINOWQ==
X-Google-Smtp-Source: APXvYqzp2ys9j1IYE4oAaX1GOLnq/T+bZWI4c4aFjaPILm75tmPRqP+VgxZi6KvFiZ8hLir/kSZqTg==
X-Received: by 2002:adf:aadb:: with SMTP id i27mr14785757wrc.105.1581496805371;
        Wed, 12 Feb 2020 00:40:05 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a22sm7414139wmd.20.2020.02.12.00.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:40:04 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] irqchip: xilinx: Use handle_domain_irq()
Date:   Wed, 12 Feb 2020 09:39:58 +0100
Message-Id: <49c5a093d7ba1f20930c7433ed632e7c9bc7a2cb.1581496793.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581496793.git.michal.simek@xilinx.com>
References: <cover.1581496793.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call generic domain specific irq handler which does the most of things
self. Also get rid of concurrent_irq counting which hasn't been exported
anywhere.
Based on this loop was also optimized by using do/while loop instead of
goto loop.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

 arch/microblaze/Kconfig           |  1 +
 arch/microblaze/kernel/irq.c      |  5 ----
 drivers/irqchip/irq-xilinx-intc.c | 44 +++++++++++--------------------
 3 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 3a314aa2efa1..242f58ec086b 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -48,6 +48,7 @@ config MICROBLAZE
 	select MMU_GATHER_NO_RANGE if MMU
 	select SPARSE_IRQ
 	select GENERIC_IRQ_MULTI_HANDLER
+	select HANDLE_DOMAIN_IRQ
 
 # Endianness selection
 choice
diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
index 1f8cb4c4f74f..0b37dde60a1e 100644
--- a/arch/microblaze/kernel/irq.c
+++ b/arch/microblaze/kernel/irq.c
@@ -22,13 +22,8 @@
 
 void __irq_entry do_IRQ(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	trace_hardirqs_off();
-
-	irq_enter();
 	handle_arch_irq(regs);
-	irq_exit();
-	set_irq_regs(old_regs);
 	trace_hardirqs_on();
 }
 
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index ad9e678c24ac..fa468e618762 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -125,20 +125,6 @@ static unsigned int xintc_get_irq_local(struct xintc_irq_chip *irqc)
 	return irq;
 }
 
-static unsigned int xintc_get_irq(void)
-{
-	u32 hwirq;
-	unsigned int irq = -1;
-
-	hwirq = xintc_read(primary_intc, IVR);
-	if (hwirq != -1U)
-		irq = irq_find_mapping(primary_intc->root_domain, hwirq);
-
-	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
-
-	return irq;
-}
-
 static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
 	struct xintc_irq_chip *irqc = d->host_data;
@@ -178,23 +164,23 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static u32 concurrent_irq;
-
 static void xil_intc_handle_irq(struct pt_regs *regs)
 {
-	unsigned int irq;
-
-	irq = xintc_get_irq();
-next_irq:
-	BUG_ON(!irq);
-	generic_handle_irq(irq);
-
-	irq = xintc_get_irq();
-	if (irq != -1U) {
-		pr_debug("next irq: %d\n", irq);
-		++concurrent_irq;
-		goto next_irq;
-	}
+	u32 hwirq;
+	struct xintc_irq_chip *irqc = primary_intc;
+
+	do {
+		hwirq = xintc_read(irqc, IVR);
+		if (hwirq != -1U) {
+			int ret;
+
+			ret = handle_domain_irq(irqc->root_domain, hwirq, regs);
+			WARN_ONCE(ret, "Unhandled HWIRQ %d\n", hwirq);
+			continue;
+		}
+
+		break;
+	} while (1);
 }
 
 static int __init xilinx_intc_of_init(struct device_node *intc,
-- 
2.25.0

