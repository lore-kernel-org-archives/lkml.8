Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D7C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45DD4206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436682AbgDNIYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436525AbgDNIVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:21:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A314C0A3BE2;
        Tue, 14 Apr 2020 01:21:03 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOGoW-0006L4-HP; Tue, 14 Apr 2020 10:21:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 35F121C0086;
        Tue, 14 Apr 2020 10:21:00 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:20:59 -0000
From:   "tip-bot2 for afzal mohammed" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq: Remove setup_irq() and remove_irq()
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C0aa8771ada1ac8e1312f6882980c9c08bd023148=2E15853?=
 =?utf-8?q?20721=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C0aa8771ada1ac8e1312f6882980c9c08bd023148=2E158532?=
 =?utf-8?q?0721=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <158685245979.28353.320778403882789166.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     07d8350ede4c4c29634b26c163a1eecdf39dfcfb
Gitweb:        https://git.kernel.org/tip/07d8350ede4c4c29634b26c163a1eecdf39dfcfb
Author:        afzal mohammed <afzal.mohd.ma@gmail.com>
AuthorDate:    Fri, 27 Mar 2020 21:41:16 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Apr 2020 10:08:50 +02:00

genirq: Remove setup_irq() and remove_irq()

Now that all the users of setup_irq() & remove_irq() have been replaced by
request_irq() & free_irq() respectively, delete them.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lkml.kernel.org/r/0aa8771ada1ac8e1312f6882980c9c08bd023148.1585320721.git.afzal.mohd.ma@gmail.com

---
 include/linux/irq.h |  2 +--
 kernel/irq/manage.c | 44 +--------------------------------------------
 2 files changed, 46 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 9315fbb..c63c2aa 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -573,8 +573,6 @@ enum {
 #define IRQ_DEFAULT_INIT_FLAGS	ARCH_IRQ_INIT_FLAGS
 
 struct irqaction;
-extern int setup_irq(unsigned int irq, struct irqaction *new);
-extern void remove_irq(unsigned int irq, struct irqaction *act);
 extern int setup_percpu_irq(unsigned int irq, struct irqaction *new);
 extern void remove_percpu_irq(unsigned int irq, struct irqaction *act);
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index fe40c65..453a8a0 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1690,34 +1690,6 @@ out_mput:
 	return ret;
 }
 
-/**
- *	setup_irq - setup an interrupt
- *	@irq: Interrupt line to setup
- *	@act: irqaction for the interrupt
- *
- * Used to statically setup interrupts in the early boot process.
- */
-int setup_irq(unsigned int irq, struct irqaction *act)
-{
-	int retval;
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	if (!desc || WARN_ON(irq_settings_is_per_cpu_devid(desc)))
-		return -EINVAL;
-
-	retval = irq_chip_pm_get(&desc->irq_data);
-	if (retval < 0)
-		return retval;
-
-	retval = __setup_irq(irq, desc, act);
-
-	if (retval)
-		irq_chip_pm_put(&desc->irq_data);
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(setup_irq);
-
 /*
  * Internal function to unregister an irqaction - used to free
  * regular and special interrupts that are part of the architecture.
@@ -1859,22 +1831,6 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 }
 
 /**
- *	remove_irq - free an interrupt
- *	@irq: Interrupt line to free
- *	@act: irqaction for the interrupt
- *
- * Used to remove interrupts statically setup by the early boot process.
- */
-void remove_irq(unsigned int irq, struct irqaction *act)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	if (desc && !WARN_ON(irq_settings_is_per_cpu_devid(desc)))
-		__free_irq(desc, act->dev_id);
-}
-EXPORT_SYMBOL_GPL(remove_irq);
-
-/**
  *	free_irq - free an interrupt allocated with request_irq
  *	@irq: Interrupt line to free
  *	@dev_id: Device identity to free
