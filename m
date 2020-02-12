Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578F1C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6F020848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5SSauM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgBLIER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:04:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43921 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgBLIER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:04:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id p11so647960plq.10;
        Wed, 12 Feb 2020 00:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7AIHJ7j1EEobB8zZTvtJAkT0p5VwQeFcI7NkRJU/t0Q=;
        b=q5SSauM13DrzscQWb8ZkGyOBuZ1Vmrmr9mUv6Qdet2InfRK5EjYE1zceP0XWRRG6M1
         5dR0Rafft2wMdkRO9PLU3vvSjRZpHy+qCWYas0jOwRcxJAmLrtfGnqQK3F9HinWk7hnc
         2/IPB7axnFjdlgqtkVOqcbAhWv76Lhk7m992nwFg7nN8paJCkgEOdRkEp7ILG6ce5wzH
         Bn58dfHBzj1/jMgDi+qF6Q3AoM6impQNA6YfdRGnVdesGujZ1FPHEAFBxEaylg+z4HNN
         mbAKYN1KEpm0JZO8NJhF31T7GNy3y5EtsvRMnZyZkvgxuY5Ps0FBgeyfvj/k3MLNwluF
         nXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7AIHJ7j1EEobB8zZTvtJAkT0p5VwQeFcI7NkRJU/t0Q=;
        b=TJuGl3nuCnZ3evpzamaSpIZcnDEw6OOy4zm45mcEgUnMGDuWOYDGhP1bOuNb40Zb+7
         SH/oftqOS8b8uKAJMael8Gkxp+bJMc7URMk8w2iTXO0PJ7tyz5YPHeOHRiwJaCmbU1Ji
         kbvWvV6iDLKOMntOUddR82TPrGRWFKrHNmEcZ5Xttgq7TjqfQrO2jm2DTIlQ/1DDkGO+
         6r18UdIG/JZPYxOaQPC36uEPbwyv84IrOkp1C7liXkJ2+fbjnQPAvGqgRjVgME2bZFbC
         CiuRX7yL7VUmYn8ThduylSS05KTeeWwvVKx2EvhIRGmpnTlpkhFo8/vqq8Y6tPeSlC0q
         jFJA==
X-Gm-Message-State: APjAAAXMfOIhlQ+rmdB6SJTYgkY2+anm4Rqg1ynJ8Faz3W+FY3PrvxEz
        weKlEXbPcBpCsVbBQrkTu/sElICOV1U=
X-Google-Smtp-Source: APXvYqyO7GVGVB77AJIpJXGLm4LOrCcRzAFK+DAo2r7xUZ6KayXCIdYgKFVg10nm5pyQe2PgPOW/3A==
X-Received: by 2002:a17:90a:21c7:: with SMTP id q65mr8703896pjc.8.1581494656192;
        Wed, 12 Feb 2020 00:04:16 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id y197sm7126036pfc.79.2020.02.12.00.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:04:15 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:34:14 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 09/18] parisc: Replace setup_irq() by request_irq()
Message-ID: <ce37741c4606e3b86b2b1db51c42e68e61d43563.1581478324.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Existing callers of
setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Since cc'ing cover letter to all maintainers/reviewers would be too
many, refer for cover letter,
 https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

 arch/parisc/kernel/irq.c | 21 +++++----------------
 drivers/parisc/eisa.c    |  8 ++------
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index e5fcfb70cc7c..b8fd4ae6b2cf 100644
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
+		pr_err("request_irq() on %s failed\n", "timer");
 #ifdef CONFIG_SMP
 	irq_set_handler(IPI_IRQ, handle_percpu_irq);
-	setup_irq(IPI_IRQ, &ipi_action);
+	if (request_irq(IPI_IRQ, ipi_interrupt, IRQF_PERCPU, "IPI", NULL))
+		pr_err("request_irq() on %s failed\n", "IPI");
 #endif
 }
 
diff --git a/drivers/parisc/eisa.c b/drivers/parisc/eisa.c
index 9d00a24277aa..fa75e6740de2 100644
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
+		pr_err("request_irq() on %s failed\n", "cascade");
 	for (i = 0; i < 16; i++) {
 		irq_set_chip_and_handler(i, &eisa_interrupt_type,
 					 handle_simple_irq);
-- 
2.24.1

