Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436B3C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1605A20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="nKxeR/3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBXMF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:05:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45461 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgBXMF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:05:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id g3so10049532wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 04:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DUkdsoISGF+J5hM2bCbp8OmU4IW6L/hiKVoM76E2NY0=;
        b=nKxeR/3sazX3BebnyihmFvvUyBbUVqRGNzu65qJ2GLwT3iQ5HMzfbl/FAMUqaeOwrb
         SqHqvjkeJuKgBZKemDsqvboUZGBUr1IT+NbomRhjWIv2pqu0NS7L7nDfnpjcBtVHLyhf
         q+Bm0UCoDEZSXemb8n8rB0hu1WwEAB+g0NehiwEY3A9wDMZUweDD+Y+xT1SFkQvWJt9i
         JaP6J8TyY+mkSycywI67JLYiMndwgeKNMmz3EPDBxLGf0/fAjEEBEztj/+io/PH9ewM5
         u0s4xJLR2Xh+pc7UH15BbLxGfjDXrWApIP9mO1j4c5U9Y0dW/F2aobgEY2Pwhqe7Oky8
         WODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DUkdsoISGF+J5hM2bCbp8OmU4IW6L/hiKVoM76E2NY0=;
        b=DfT+OxJ2k+87g+zfyBH9k9r5AlUzGnCVTpl0NeveE3q5TpJPPAK98C6flYLFeB+YbR
         eoD7yByRZcIURjbFw+3gJC8rKd+9lb3lSUfORf/nQSs8Yx0qRuddN6WE9gZ4Rj5Z/k+y
         IxSO4XhkfONoJwyvmc44hdaZruJYYwQk8mzPUh8q18Pnaq4dAHk6qvd1UqPjIZAH5+rE
         DAv429zUI28aYRxbUhzqveopnuJCEaaNYSl9LBPI8OXKn9j2Zqb320aeBdflvhB+u/Az
         +byTudOhsej8g/WXdlpewcLdkw7SpIPPc5Qx6lSSHLxCFza0auO9seKPnYH1hQ8PUd8B
         Byiw==
X-Gm-Message-State: APjAAAUgm9T6DZp/xYiwVJb0at94CAGj5DyWv/qMZOEHFLOwbK9I2aL4
        Q6CUUjdctx9GZmQeuEvMIs6ssvGR3u8Gcw==
X-Google-Smtp-Source: APXvYqxPiSKkSwB7S1weGEfQSj4ojhrZnGAfhByqSsMTDzpaQaPWe8GyuFl4RdsVu56FE6LaLDp3Ug==
X-Received: by 2002:adf:a746:: with SMTP id e6mr66189155wrd.329.1582545924570;
        Mon, 24 Feb 2020 04:05:24 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id p26sm17280894wmc.24.2020.02.24.04.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 04:05:23 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, maz@kernel.org
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Mubin Sayyed <mubinusm@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] irqchip: xilinx: Enable generic irq multi handler
Date:   Mon, 24 Feb 2020 13:05:14 +0100
Message-Id: <a7a2b3c2df5534dd17844472a0a3fbcffb58b133.1582545908.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1582545908.git.michal.simek@xilinx.com>
References: <cover.1582545908.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register default arch handler via driver instead of directly pointing to
xilinx intc controller. This patch makes architecture code more generic.

Driver calls generic domain specific irq handler which does the most of
things self. Also get rid of concurrent_irq counting which hasn't been
exported anywhere.
Based on this loop was also optimized by using do/while loop instead of
goto loop.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>

---

Changes in v2:
- Merge generic irq multi handler(v1 2/3) and domain irq patch (v1 3/3) from together
- Add likely() suggested by Marc

 arch/microblaze/Kconfig           |  2 ++
 arch/microblaze/include/asm/irq.h |  3 ---
 arch/microblaze/kernel/irq.c      | 21 +------------------
 drivers/irqchip/irq-xilinx-intc.c | 34 ++++++++++++++++++-------------
 4 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 6a331bd57ea8..242f58ec086b 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -47,6 +47,8 @@ config MICROBLAZE
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE if MMU
 	select SPARSE_IRQ
+	select GENERIC_IRQ_MULTI_HANDLER
+	select HANDLE_DOMAIN_IRQ
 
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
index 903dad822fad..0b37dde60a1e 100644
--- a/arch/microblaze/kernel/irq.c
+++ b/arch/microblaze/kernel/irq.c
@@ -20,29 +20,10 @@
 #include <linux/irqchip.h>
 #include <linux/of_irq.h>
 
-static u32 concurrent_irq;
-
 void __irq_entry do_IRQ(struct pt_regs *regs)
 {
-	unsigned int irq;
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	trace_hardirqs_off();
-
-	irq_enter();
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
-	irq_exit();
-	set_irq_regs(old_regs);
+	handle_arch_irq(regs);
 	trace_hardirqs_on();
 }
 
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index cf1bb470d7b5..2de573ee9764 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -125,20 +125,6 @@ static unsigned int xintc_get_irq_local(struct xintc_irq_chip *irqc)
 	return irq;
 }
 
-unsigned int xintc_get_irq(void)
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
@@ -178,6 +164,25 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static void xil_intc_handle_irq(struct pt_regs *regs)
+{
+	u32 hwirq;
+	struct xintc_irq_chip *irqc = primary_intc;
+
+	do {
+		hwirq = xintc_read(irqc, IVR);
+		if (likely(hwirq != -1U)) {
+			int ret;
+
+			ret = handle_domain_irq(irqc->root_domain, hwirq, regs);
+			WARN_ONCE(ret, "Unhandled HWIRQ %d\n", hwirq);
+			continue;
+		}
+
+		break;
+	} while (1);
+}
+
 static int __init xilinx_intc_of_init(struct device_node *intc,
 					     struct device_node *parent)
 {
@@ -248,6 +253,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 	} else {
 		primary_intc = irqc;
 		irq_set_default_host(primary_intc->root_domain);
+		set_handle_irq(xil_intc_handle_irq);
 	}
 
 	return 0;
-- 
2.25.1

