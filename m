Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1946C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 19:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81350208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 19:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgC2TGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 15:06:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56824 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgC2TGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 15:06:36 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIdGT-0000lw-Dw; Sun, 29 Mar 2020 21:06:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 61B321C0334;
        Sun, 29 Mar 2020 21:06:31 +0200 (CEST)
Date:   Sun, 29 Mar 2020 19:06:30 -0000
From:   "tip-bot2 for afzal mohammed" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] unicore32: Replace setup_irq() by request_irq()
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C82667ae23520611b2a9d8db77e1d8aeb982f08e5=2E15853?=
 =?utf-8?q?20721=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C82667ae23520611b2a9d8db77e1d8aeb982f08e5=2E158532?=
 =?utf-8?q?0721=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <158550879084.28353.14828561956279925504.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ba947241f125b19bb6f08a78c22827b9f6a1317a
Gitweb:        https://git.kernel.org/tip/ba947241f125b19bb6f08a78c22827b9f6a1317a
Author:        afzal mohammed <afzal.mohd.ma@gmail.com>
AuthorDate:    Fri, 27 Mar 2020 21:40:44 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 29 Mar 2020 21:03:43 +02:00

unicore32: Replace setup_irq() by request_irq()

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

setup_irq() was required in older kernels as the memory allocator was not
available during early boot.

Hence replace setup_irq() by request_irq().

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/82667ae23520611b2a9d8db77e1d8aeb982f08e5.1585320721.git.afzal.mohd.ma@gmail.com

---
 arch/unicore32/kernel/time.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/unicore32/kernel/time.c b/arch/unicore32/kernel/time.c
index 8b217a7..c3a37ed 100644
--- a/arch/unicore32/kernel/time.c
+++ b/arch/unicore32/kernel/time.c
@@ -72,13 +72,6 @@ static struct clocksource cksrc_puv3_oscr = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static struct irqaction puv3_timer_irq = {
-	.name		= "ost0",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= puv3_ost0_interrupt,
-	.dev_id		= &ckevt_puv3_osmr0,
-};
-
 void __init time_init(void)
 {
 	writel(0, OST_OIER);		/* disable any timer interrupts */
@@ -94,7 +87,9 @@ void __init time_init(void)
 	ckevt_puv3_osmr0.min_delta_ticks = MIN_OSCR_DELTA * 2;
 	ckevt_puv3_osmr0.cpumask = cpumask_of(0);
 
-	setup_irq(IRQ_TIMER0, &puv3_timer_irq);
+	if (request_irq(IRQ_TIMER0, puv3_ost0_interrupt,
+			IRQF_TIMER | IRQF_IRQPOLL, "ost0", &ckevt_puv3_osmr0))
+		pr_err("Failed to register ost0 interrupt\n");
 
 	clocksource_register_hz(&cksrc_puv3_oscr, CLOCK_TICK_RATE);
 	clockevents_register_device(&ckevt_puv3_osmr0);
