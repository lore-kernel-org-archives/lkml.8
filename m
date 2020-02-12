Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07F3C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70B320661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="nRwmkoER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgBLIkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:40:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42783 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgBLIkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:40:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so1109989wrd.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9jZicbKMFy+RIS6pl/MmIhoSGk5p/0+4DIwC/EbIzH0=;
        b=nRwmkoERZHKD5J0eRNErsC0qWHU+FzbYU0vgIsyfoP7Yq59ubCNPkfeypsq2+oj30z
         NRQRm30wf81aaDSqMEj/KYIet+TaG3ovZcIV6M4xngNYju2oQZx4pgIaaWexR1vA4Iif
         cbu+tf3KenFBcaj8F8TVYUGbCNG1p44UbwcD66pg2vCAjRApis4H7pbSlK5coG6UCIsL
         NVDIg7T3voBRYNjlbwHX94QfqzFeEbXCtqE+ECpFHAYOLhh/2CARDT6tiPzUxOhwqIaC
         g1giMe/54wBtaE5QAr282YOnUesamiePZLkFCGHnDU3ijzS4uwOoMuQag98JFwW5lzeW
         MOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9jZicbKMFy+RIS6pl/MmIhoSGk5p/0+4DIwC/EbIzH0=;
        b=KEihpFt7FUwn7sf0ZV4weTpS50ukSdyAAvJb2TdyhkvvMUn5wjP5v94xHw6CCJWplu
         kY4xPgwQStzWzzRzQOejVmaCKwg4WyvGfvWeCbajAOUgt9Hrj6bTakl8qjDYeJTKxlQL
         1l7c6qsN2ubDXYk74DL6oQm3MYB0YtH/SoQ0A+daqBtdcC451qxdX6OgYb5gHFP21rn0
         mzw1jsVl0nJtLEbquSVpQHWMY5MFayq263K+JTgHX0CUhrOhb2MTIahvoNUoFxXQRgUO
         0HFKGbq1NcKiTCoYUj6O0/ev2YC8WwLwmwsX88bklSEkiHqQksFvsXDuCb1rfxFSulYH
         PjYg==
X-Gm-Message-State: APjAAAU2E57gPVs1OzJjcUn64j3Ha0uzwbDkQUQ1bCEtlMH5JWaTrbEz
        5K1qqaeOMq8fhfU5yGKRGnwmI01Wv5qbUQ==
X-Google-Smtp-Source: APXvYqyfmlPZwTZvsJkBok9IupLxCmiaAM77FpRfWZ4v9639Z6veM2fVq7Avk5yeySjlmJjbT6HuQA==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr14814581wrm.394.1581496803679;
        Wed, 12 Feb 2020 00:40:03 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id g15sm8928688wro.65.2020.02.12.00.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:40:03 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mubin Sayyed <mubinusm@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] irqchip: xilinx: Enable generic irq multi handler
Date:   Wed, 12 Feb 2020 09:39:57 +0100
Message-Id: <5813deafd27acf07b936ef7a2ac029b7a95ee7be.1581496793.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581496793.git.michal.simek@xilinx.com>
References: <cover.1581496793.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register default arch handler via driver instead of directly pointing to
xilinx intc controller. This patch makes architecture code more generic.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

 arch/microblaze/Kconfig           |  1 +
 arch/microblaze/include/asm/irq.h |  3 ---
 arch/microblaze/kernel/irq.c      | 16 +---------------
 drivers/irqchip/irq-xilinx-intc.c | 22 +++++++++++++++++++++-
 4 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 6a331bd57ea8..3a314aa2efa1 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -47,6 +47,7 @@ config MICROBLAZE
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE if MMU
 	select SPARSE_IRQ
+	select GENERIC_IRQ_MULTI_HANDLER
 
 # Endianness selection
 choice
diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
index eac2fb4b3fb9..5166f0893e2b 100644
--- a/arch/microblaze/include/asm/irq.h
+++ b/arch/microblaze/include/asm/irq.h
@@ -14,7 +14,4 @@
 struct pt_regs;
 extern void do_IRQ(struct pt_regs *regs);
 
-/* should be defined in each interrupt controller driver */
-extern unsigned int xintc_get_irq(void);
-
 #endif /* _ASM_MICROBLAZE_IRQ_H */
diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
index 903dad822fad..1f8cb4c4f74f 100644
--- a/arch/microblaze/kernel/irq.c
+++ b/arch/microblaze/kernel/irq.c
@@ -20,27 +20,13 @@
 #include <linux/irqchip.h>
 #include <linux/of_irq.h>
 
-static u32 concurrent_irq;
-
 void __irq_entry do_IRQ(struct pt_regs *regs)
 {
-	unsigned int irq;
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	trace_hardirqs_off();
 
 	irq_enter();
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
-
+	handle_arch_irq(regs);
 	irq_exit();
 	set_irq_regs(old_regs);
 	trace_hardirqs_on();
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index cf1bb470d7b5..ad9e678c24ac 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -125,7 +125,7 @@ static unsigned int xintc_get_irq_local(struct xintc_irq_chip *irqc)
 	return irq;
 }
 
-unsigned int xintc_get_irq(void)
+static unsigned int xintc_get_irq(void)
 {
 	u32 hwirq;
 	unsigned int irq = -1;
@@ -178,6 +178,25 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static u32 concurrent_irq;
+
+static void xil_intc_handle_irq(struct pt_regs *regs)
+{
+	unsigned int irq;
+
+	irq = xintc_get_irq();
+next_irq:
+	BUG_ON(!irq);
+	generic_handle_irq(irq);
+
+	irq = xintc_get_irq();
+	if (irq != -1U) {
+		pr_debug("next irq: %d\n", irq);
+		++concurrent_irq;
+		goto next_irq;
+	}
+}
+
 static int __init xilinx_intc_of_init(struct device_node *intc,
 					     struct device_node *parent)
 {
@@ -248,6 +267,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 	} else {
 		primary_intc = irqc;
 		irq_set_default_host(primary_intc->root_domain);
+		set_handle_irq(xil_intc_handle_irq);
 	}
 
 	return 0;
-- 
2.25.0

