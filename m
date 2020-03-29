Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE6CC2D0EE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 19:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60962076A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 19:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgC2TGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 15:06:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56831 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgC2TGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 15:06:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIdGT-0000m2-An; Sun, 29 Mar 2020 21:06:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C763E1C0470;
        Sun, 29 Mar 2020 21:06:32 +0200 (CEST)
Date:   Sun, 29 Mar 2020 19:06:32 -0000
From:   "tip-bot2 for afzal mohammed" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] c6x: Replace setup_irq() by request_irq()
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C56e991e920ce5806771fab892574cba89a3d413f=2E15853?=
 =?utf-8?q?20721=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C56e991e920ce5806771fab892574cba89a3d413f=2E158532?=
 =?utf-8?q?0721=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <158550879239.28353.15958424103561179531.tip-bot2@tip-bot2>
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

Commit-ID:     e13b99f3005829acc64287271fa6cacec6e3aeab
Gitweb:        https://git.kernel.org/tip/e13b99f3005829acc64287271fa6cacec6e3aeab
Author:        afzal mohammed <afzal.mohd.ma@gmail.com>
AuthorDate:    Fri, 27 Mar 2020 21:39:32 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 29 Mar 2020 21:03:42 +02:00

c6x: Replace setup_irq() by request_irq()

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

setup_irq() was required in older kernels as the memory allocator was not
available during early boot.

Hence replace setup_irq() by request_irq().

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/56e991e920ce5806771fab892574cba89a3d413f.1585320721.git.afzal.mohd.ma@gmail.com

---
 arch/c6x/platforms/timer64.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/c6x/platforms/timer64.c b/arch/c6x/platforms/timer64.c
index d98d943..661f4c7 100644
--- a/arch/c6x/platforms/timer64.c
+++ b/arch/c6x/platforms/timer64.c
@@ -165,13 +165,6 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction timer_iact = {
-	.name		= "timer",
-	.flags		= IRQF_TIMER,
-	.handler	= timer_interrupt,
-	.dev_id		= &t64_clockevent_device,
-};
-
 void __init timer64_init(void)
 {
 	struct clock_event_device *cd = &t64_clockevent_device;
@@ -238,7 +231,9 @@ void __init timer64_init(void)
 	cd->cpumask		= cpumask_of(smp_processor_id());
 
 	clockevents_register_device(cd);
-	setup_irq(cd->irq, &timer_iact);
+	if (request_irq(cd->irq, timer_interrupt, IRQF_TIMER, "timer",
+			&t64_clockevent_device))
+		pr_err("Failed to request irq %d (timer)\n", cd->irq);
 
 out:
 	of_node_put(np);
