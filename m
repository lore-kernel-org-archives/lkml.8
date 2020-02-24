Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF71C35677
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1701A2071C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu0g+Vg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgBXAvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:51:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41083 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXAvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:51:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so4216111pgf.8;
        Sun, 23 Feb 2020 16:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LRoHLEvFxeHDGUN+7h2HFbVrgCZ0x+nVo95Yki0romk=;
        b=Gu0g+Vg38Hw3uomVauxtXe/auYMFBCQwBriMZ96Z1ZwWUdX20ln3xh6Gch1q2QlL4R
         dzJCu6VJC4vSy02GkNA8BtdbaBvD5IupUMLrrhmXNwLW019Cpow1cmTQ0yQtVsNX96lA
         riFJHrsUdd5NTfZh0YMj/ff9t7IeyhzMRTIpM0p4HcoXCYFGSM71mP1Z7c4r8vNMMpPk
         35v8N7Tl5Hf4BnSHZw5xUNQXn8SYzSaLnxpxTmLbP9TJ61yqcMybMb3t/PDKRTvoAyAD
         dFMJCGPTHnOuYKxEQY+KC6pbmo+yLtQI0f72tA5L3Np+nlQeLzACMXvc9QNyDBmJT9am
         8W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LRoHLEvFxeHDGUN+7h2HFbVrgCZ0x+nVo95Yki0romk=;
        b=dxtA8jv5uXjxwAzMj70Vlrpx3IkzZKUa0c947TY2pj21v5BhzZPrlnEIp3bmz70e/A
         BgJ9B2Ypmv+uZlBzGAXk1aqUJharVqn1uQHVHxhaqeLL8i9YWE46xHu81LhqwAWgWmce
         5BJ/bdiMcGIiXsyT6ukIaEwv3CRUTQRh7SdG6GEGYPlGoox21SwA4ZlPGzVVcbhqBuyn
         5YTxZsp6uoOTJr6BlnOBjBtm9/qaAb8UxaES1CyWNqiM7rph5sHs2kFUjmk2myF0BELI
         KaWRDKFZUi0XtSiiA5GoDUoRfNepCqDxb+PoK23gX330VDxpxBN2mSMYG8BvkpotqlY0
         XYtA==
X-Gm-Message-State: APjAAAUP1NFK7IyrDuPzEQdPGShtwt8FXEndcMXC2Saeqh/tfxtSTvR4
        RolRsFNKLYY/1EvC3KSTrzaWrZK86Uc=
X-Google-Smtp-Source: APXvYqwCVcvCoa48rxYkJUiFfp//Cio+d5PXtZJRcrRUX8uMC0yIpQ3CtjpVuJhw3FstpJpFSv+14w==
X-Received: by 2002:aa7:8805:: with SMTP id c5mr27088026pfo.142.1582505473281;
        Sun, 23 Feb 2020 16:51:13 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id c15sm10403993pja.30.2020.02.23.16.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 16:51:12 -0800 (PST)
Date:   Mon, 24 Feb 2020 06:21:11 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 09/18] parisc: Replace setup_irq() by request_irq()
Message-ID: <2a84ed44c5523d08268547781417c8fc35de3f25.1582471508.git.afzal.mohd.ma@gmail.com>
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

 arch/parisc/kernel/irq.c | 21 +++++----------------
 drivers/parisc/eisa.c    |  8 ++------
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index e5fcfb70cc7c..cb48523e7d19 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -560,20 +560,6 @@ void do_cpu_irq_mask(struct pt_regs *regs)
 	goto out;
 }
 
-static struct irqaction timer_action = {
-	.handler = timer_interrupt,
-	.name = "timer",
-	.flags = IRQF_TIMER | IRQF_PERCPU | IRQF_IRQPOLL,
-};
-
-#ifdef CONFIG_SMP
-static struct irqaction ipi_action = {
-	.handler = ipi_interrupt,
-	.name = "IPI",
-	.flags = IRQF_PERCPU,
-};
-#endif
-
 static void claim_cpu_irqs(void)
 {
 	int i;
@@ -583,10 +569,13 @@ static void claim_cpu_irqs(void)
 	}
 
 	irq_set_handler(TIMER_IRQ, handle_percpu_irq);
-	setup_irq(TIMER_IRQ, &timer_action);
+	if (request_irq(TIMER_IRQ, timer_interrupt,
+			IRQF_TIMER | IRQF_PERCPU | IRQF_IRQPOLL, "timer", NULL))
+		pr_err("%s: request_irq() failed\n", "timer");
 #ifdef CONFIG_SMP
 	irq_set_handler(IPI_IRQ, handle_percpu_irq);
-	setup_irq(IPI_IRQ, &ipi_action);
+	if (request_irq(IPI_IRQ, ipi_interrupt, IRQF_PERCPU, "IPI", NULL))
+		pr_err("%s: request_irq() failed\n", "IPI");
 #endif
 }
 
diff --git a/drivers/parisc/eisa.c b/drivers/parisc/eisa.c
index 9d00a24277aa..213d21f228e7 100644
--- a/drivers/parisc/eisa.c
+++ b/drivers/parisc/eisa.c
@@ -243,11 +243,6 @@ static irqreturn_t dummy_irq2_handler(int _, void *dev)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction irq2_action = {
-	.handler = dummy_irq2_handler,
-	.name = "cascade",
-};
-
 static void init_eisa_pic(void)
 {
 	unsigned long flags;
@@ -335,7 +330,8 @@ static int __init eisa_probe(struct parisc_device *dev)
 	}
 
 	/* Reserve IRQ2 */
-	setup_irq(2, &irq2_action);
+	if (request_irq(2, dummy_irq2_handler, 0, "cascade", NULL))
+		pr_err("%s: request_irq() failed\n", "cascade");
 	for (i = 0; i < 16; i++) {
 		irq_set_chip_and_handler(i, &eisa_interrupt_type,
 					 handle_simple_irq);
-- 
2.25.1

