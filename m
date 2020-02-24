Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A37C35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493582067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgJT3Lu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgBXAv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:51:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33334 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgBXAv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:51:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so4238886pgk.0;
        Sun, 23 Feb 2020 16:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BfP9k/NNwFafc82qdK4A43141L4N4A8c31D/jiyN+s0=;
        b=ZgJT3Lu0BRzVIGlbYzrVqjSwYTAsbxfHvIR0AZx5AkEGbDhD+cOM30XVdjkCS7m52S
         rzMUO21YaUpToJJ0MiVCovugW1NHLq3w+6Pv4qkp1Y9HlNWDXT/wavB8No1UsC4uNp5c
         VCgifQfwD99BCYErZoOmiZ3UrUt0wNE5vU2fHKro394VcnMkPq2+O9CycL5uhTlVk/Fn
         p2KWCEG5kUfPr1iKmOvTtaItR2hRcNtpStQubCDtCQhHlpXRWnH2zUWRrSroBNFUwdxy
         yGSmkKK5aZchb7hu6zTIDGpgTnfPWYx8ZfBtiWO4JCi3bFozQ7FY7ltO1+uHdhNRyy6/
         9gIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BfP9k/NNwFafc82qdK4A43141L4N4A8c31D/jiyN+s0=;
        b=lwnb3TAVYS/bD4PCEXpfQGuCezgzYv6xeSq1gITUMT1WAsZNYxb6vJIJpud1p11Qsb
         5gtD8fUh9msBNW2jv+5pq63ReVCycUf4OlibFVPi4KAuGcqffDE0a/Tvjx7wa+oOTu4H
         neMv+kP2q8HO4grl6TXrvDevvGryqkV/eG35HeOvU+QP99GidaI3X4JrTazK4zHwtH5Z
         t/c2mSrLPM5a/5Mm60qwGrE6W09SegaswXLf7DZ6KatGavOzQhY9XeMsY6C2g2Bobife
         W7ZUu602hRul0Aml/RLWnBh5DvWr6FrdU4fcbspuP2aEP4ABUkNVZTv7h4novbLCNXYx
         sOQQ==
X-Gm-Message-State: APjAAAU2f4yphjKNVkUHTnUyCt2wP4j8gJrdI29IpuJ1RcAGVmAxXVQh
        kwpS+LPyHf/0BU3+K1JsGMROXA+Yzn4=
X-Google-Smtp-Source: APXvYqwqUAe4wxhU174z03s+4p+MA5Xb9jYgMD5OV7DQGm+g0GrvKPgncSiuMyKQ5HHyxY4gdqkJug==
X-Received: by 2002:a63:8ec9:: with SMTP id k192mr9022967pge.293.1582505518469;
        Sun, 23 Feb 2020 16:51:58 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id h10sm10165737pfo.181.2020.02.23.16.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 16:51:58 -0800 (PST)
Date:   Mon, 24 Feb 2020 06:21:56 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 12/18] sh: replace setup_irq() by request_irq()
Message-ID: <331ffab9c0b56f9c6d1b7f6afdb9c95ab285402c.1582471508.git.afzal.mohd.ma@gmail.com>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). The early boot setup_irq()
invocations happen either via 'init_IRQ()' or 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/sh/boards/mach-cayman/irq.c | 18 ++++++------------
 arch/sh/drivers/dma/dma-pvr2.c   |  9 +++------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/sh/boards/mach-cayman/irq.c b/arch/sh/boards/mach-cayman/irq.c
index 3b6ea2d99013..57d015f3c075 100644
--- a/arch/sh/boards/mach-cayman/irq.c
+++ b/arch/sh/boards/mach-cayman/irq.c
@@ -40,16 +40,6 @@ static irqreturn_t cayman_interrupt_pci2(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static struct irqaction cayman_action_smsc = {
-	.name		= "Cayman SMSC Mux",
-	.handler	= cayman_interrupt_smsc,
-};
-
-static struct irqaction cayman_action_pci2 = {
-	.name		= "Cayman PCI2 Mux",
-	.handler	= cayman_interrupt_pci2,
-};
-
 static void enable_cayman_irq(struct irq_data *data)
 {
 	unsigned int irq = data->irq;
@@ -149,6 +139,10 @@ void init_cayman_irq(void)
 	}
 
 	/* Setup the SMSC interrupt */
-	setup_irq(SMSC_IRQ, &cayman_action_smsc);
-	setup_irq(PCI2_IRQ, &cayman_action_pci2);
+	if (request_irq(SMSC_IRQ, cayman_interrupt_smsc, 0, "Cayman SMSC Mux",
+			NULL))
+		pr_err("%s: request_irq() failed\n", "Cayman SMSC Mux");
+	if (request_irq(PCI2_IRQ, cayman_interrupt_pci2, 0, "Cayman PCI2 Mux",
+			NULL))
+		pr_err("%s: request_irq() failed\n", "Cayman PCI2 Mux");
 }
diff --git a/arch/sh/drivers/dma/dma-pvr2.c b/arch/sh/drivers/dma/dma-pvr2.c
index b5dbd1f75768..0e5aa558a5f2 100644
--- a/arch/sh/drivers/dma/dma-pvr2.c
+++ b/arch/sh/drivers/dma/dma-pvr2.c
@@ -64,11 +64,6 @@ static int pvr2_xfer_dma(struct dma_channel *chan)
 	return 0;
 }
 
-static struct irqaction pvr2_dma_irq = {
-	.name		= "pvr2 DMA handler",
-	.handler	= pvr2_dma_interrupt,
-};
-
 static struct dma_ops pvr2_dma_ops = {
 	.request	= pvr2_request_dma,
 	.get_residue	= pvr2_get_dma_residue,
@@ -84,7 +79,9 @@ static struct dma_info pvr2_dma_info = {
 
 static int __init pvr2_dma_init(void)
 {
-	setup_irq(HW_EVENT_PVR2_DMA, &pvr2_dma_irq);
+	if (request_irq(HW_EVENT_PVR2_DMA, pvr2_dma_interrupt, 0,
+			"pvr2 DMA handler", NULL))
+		pr_err("%s: request_irq() failed\n", "pvr2 DMA handler");
 	request_dma(PVR2_CASCADE_CHAN, "pvr2 cascade");
 
 	return register_dmac(&pvr2_dma_info);
-- 
2.25.1

