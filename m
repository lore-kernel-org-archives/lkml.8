Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5775CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 08:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34AFF208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 08:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d5ZZXnbh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="da4eSMxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGDIFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 04:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgGDIFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 04:05:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A98EC061794;
        Sat,  4 Jul 2020 01:05:33 -0700 (PDT)
Date:   Sat, 04 Jul 2020 08:05:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593849930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+moIGIKYJVwatsVQD7vLig3tLNpQ2Jk+3mP4pHFJy2c=;
        b=d5ZZXnbhPZgOrGq3xRmAfaKse4pzFoWD5maaYq6Oi9MBOKoat8goBYYRKmzqOGzVB1BdSf
        mmqq/sETn33w46miGJY5l5H+NBwBecf25OVTzP3byruEmDIWzgpXwOxvsKLgIag0KSxBoV
        TKs1FKA4t9hcWMiFgZktqtEkjlZzChM5gQkAX6/P9HYhtZ8RGy/vKJJ8J3uwKGRUhJRjKg
        LRvxAvOKiaEHtK/jrZU/wff5VrNl5hak4VtAh2FNt+YlrbSfsYYPJVgbfJtDNUumgaK+S3
        y+IHtiBoQJtpsHAhvx3SP12Z5OpErvqTfdf3RyOZaEVOV62fByeEh84PXDsCyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593849930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+moIGIKYJVwatsVQD7vLig3tLNpQ2Jk+3mP4pHFJy2c=;
        b=da4eSMxMdCi8CTMJt080kMLgJg+R9Pnf2Lbu7En/M7WxZ8ufUOBazT5nmbSH60qgVNvfA3
        fDhR5nMW+S7dbkBA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove preflow handler support
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200703155645.29703-3-valentin.schneider@arm.com>
References: <20200703155645.29703-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159384992905.4006.562597036625104261.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8fa88a88d573093868565a1afba43b5ae5b3a316
Gitweb:        https://git.kernel.org/tip/8fa88a88d573093868565a1afba43b5ae5b3a316
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Fri, 03 Jul 2020 16:56:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 04 Jul 2020 10:02:06 +02:00

genirq: Remove preflow handler support

That was put in place for sparc64, and blackfin also used it for some time;
sparc64 no longer uses those, and blackfin is dead.

As there are no more users, remove preflow handlers.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200703155645.29703-3-valentin.schneider@arm.com

---
 include/linux/irqdesc.h    | 15 ---------------
 include/linux/irqhandler.h |  1 -
 kernel/irq/Kconfig         |  4 ----
 kernel/irq/chip.c          | 13 -------------
 4 files changed, 33 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 8f2820c..5745491 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -22,7 +22,6 @@ struct pt_regs;
  * @irq_common_data:	per irq and chip data passed down to chip functions
  * @kstat_irqs:		irq stats per cpu
  * @handle_irq:		highlevel irq-events handler
- * @preflow_handler:	handler called before the flow handler (currently used by sparc)
  * @action:		the irq action chain
  * @status_use_accessors: status information
  * @core_internal_state__do_not_mess_with_it: core internal status information
@@ -58,9 +57,6 @@ struct irq_desc {
 	struct irq_data		irq_data;
 	unsigned int __percpu	*kstat_irqs;
 	irq_flow_handler_t	handle_irq;
-#ifdef CONFIG_IRQ_PREFLOW_FASTEOI
-	irq_preflow_handler_t	preflow_handler;
-#endif
 	struct irqaction	*action;	/* IRQ action list */
 	unsigned int		status_use_accessors;
 	unsigned int		core_internal_state__do_not_mess_with_it;
@@ -268,15 +264,4 @@ irq_set_lockdep_class(unsigned int irq, struct lock_class_key *lock_class,
 	}
 }
 
-#ifdef CONFIG_IRQ_PREFLOW_FASTEOI
-static inline void
-__irq_set_preflow_handler(unsigned int irq, irq_preflow_handler_t handler)
-{
-	struct irq_desc *desc;
-
-	desc = irq_to_desc(irq);
-	desc->preflow_handler = handler;
-}
-#endif
-
 #endif
diff --git a/include/linux/irqhandler.h b/include/linux/irqhandler.h
index 1e6f4e7..c30f454 100644
--- a/include/linux/irqhandler.h
+++ b/include/linux/irqhandler.h
@@ -10,6 +10,5 @@
 struct irq_desc;
 struct irq_data;
 typedef	void (*irq_flow_handler_t)(struct irq_desc *desc);
-typedef	void (*irq_preflow_handler_t)(struct irq_data *data);
 
 #endif
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 2051225..10a5aff 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -51,10 +51,6 @@ config GENERIC_IRQ_INJECTION
 config HARDIRQS_SW_RESEND
        bool
 
-# Preflow handler support for fasteoi (sparc64)
-config IRQ_PREFLOW_FASTEOI
-       bool
-
 # Edge style eoi based handler (cell)
 config IRQ_EDGE_EOI_HANDLER
        bool
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 41e7e37..75bbaa8 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -656,16 +656,6 @@ out_unlock:
 }
 EXPORT_SYMBOL_GPL(handle_level_irq);
 
-#ifdef CONFIG_IRQ_PREFLOW_FASTEOI
-static inline void preflow_handler(struct irq_desc *desc)
-{
-	if (desc->preflow_handler)
-		desc->preflow_handler(&desc->irq_data);
-}
-#else
-static inline void preflow_handler(struct irq_desc *desc) { }
-#endif
-
 static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 {
 	if (!(desc->istate & IRQS_ONESHOT)) {
@@ -721,7 +711,6 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 	if (desc->istate & IRQS_ONESHOT)
 		mask_irq(desc);
 
-	preflow_handler(desc);
 	handle_irq_event(desc);
 
 	cond_unmask_eoi_irq(desc, chip);
@@ -1231,7 +1220,6 @@ void handle_fasteoi_ack_irq(struct irq_desc *desc)
 	/* Start handling the irq */
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
-	preflow_handler(desc);
 	handle_irq_event(desc);
 
 	cond_unmask_eoi_irq(desc, chip);
@@ -1281,7 +1269,6 @@ void handle_fasteoi_mask_irq(struct irq_desc *desc)
 	if (desc->istate & IRQS_ONESHOT)
 		mask_irq(desc);
 
-	preflow_handler(desc);
 	handle_irq_event(desc);
 
 	cond_unmask_eoi_irq(desc, chip);
