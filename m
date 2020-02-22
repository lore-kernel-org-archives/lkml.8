Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA915C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 21:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2CF20702
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 21:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgBVVF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 16:05:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47685 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgBVVF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 16:05:59 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j5byF-0003Ad-Pu; Sat, 22 Feb 2020 22:05:55 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 10562FFC77;
        Sat, 22 Feb 2020 22:05:55 +0100 (CET)
Date:   Sat, 22 Feb 2020 21:00:04 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq fixes for 5.6-rc3
Message-ID: <158240520445.852.16454463053831663511.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-02-22

up to:  2546287c5fb3: genirq/irqdomain: Make sure all irq domain flags are distinct

Two fixes for the irq core code which are follow ups to the recent MSI
fixes:

 - The WARN_ON which was put into the MSI setaffinity callback for paranoia
   reasons actually triggered via a callchain which escaped when all the
   possible ways to reach that code were analyzed.

   The proc/irq/$N/*affinity interfaces have a quirk which came in when
   ALPHA moved to the generic interface: In case that the written affinity
   mask does not contain any online CPU it calls into ALPHAs magic auto
   affinity setting code.

   A few years later this mechanism was also made available to x86 for no
   good reasons and in a way which circumvents all sanity checks for
   interrupts which cannot have their affinity set from process context on
   X86 due to the way the X86 interrupt delivery works.

   It would be possible to make this work properly, but there is no point
   in doing so. If the interrupt is not yet started then the affinity
   setting has no effect and if it is started already then it is already
   assigned to an online CPU so there is no point to randomly move it to
   some other CPU. Just return EINVAL as the code has done before that
   change forever.

 - The new MSI quirk bit in the irq domain flags turned out to be already
   occupied, which escaped the author and the reviewers because the already
   in use bits were 0,6,2,3,4,5 listed in that order. That bit 6 was simply
   overlooked because the ordering was straight forward linear
   otherwise. So the new bit ended up being a duplicate. Fix it up by
   switching the oddball 6 to the obvious 1.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      genirq/proc: Reject invalid affinity masks (again)

Zenghui Yu (1):
      genirq/irqdomain: Make sure all irq domain flags are distinct


 include/linux/irqdomain.h |  2 +-
 kernel/irq/internals.h    |  2 --
 kernel/irq/manage.c       | 18 ++----------------
 kernel/irq/proc.c         | 22 ++++++++++++++++++++++
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b2d47571ab67..8d062e86d954 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -192,7 +192,7 @@ enum {
 	IRQ_DOMAIN_FLAG_HIERARCHY	= (1 << 0),
 
 	/* Irq domain name was allocated in __irq_domain_add() */
-	IRQ_DOMAIN_NAME_ALLOCATED	= (1 << 6),
+	IRQ_DOMAIN_NAME_ALLOCATED	= (1 << 1),
 
 	/* Irq domain is an IPI domain with virq per cpu */
 	IRQ_DOMAIN_FLAG_IPI_PER_CPU	= (1 << 2),
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 3924fbe829d4..c9d8eb7f5c02 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -128,8 +128,6 @@ static inline void unregister_handler_proc(unsigned int irq,
 
 extern bool irq_can_set_affinity_usr(unsigned int irq);
 
-extern int irq_select_affinity_usr(unsigned int irq);
-
 extern void irq_set_thread_affinity(struct irq_desc *desc);
 
 extern int irq_do_set_affinity(struct irq_data *data,
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 3089a60ea8f9..7eee98c38f25 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -481,23 +481,9 @@ int irq_setup_affinity(struct irq_desc *desc)
 {
 	return irq_select_affinity(irq_desc_get_irq(desc));
 }
-#endif
+#endif /* CONFIG_AUTO_IRQ_AFFINITY */
+#endif /* CONFIG_SMP */
 
-/*
- * Called when a bogus affinity is set via /proc/irq
- */
-int irq_select_affinity_usr(unsigned int irq)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-	unsigned long flags;
-	int ret;
-
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	ret = irq_setup_affinity(desc);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-	return ret;
-}
-#endif
 
 /**
  *	irq_set_vcpu_affinity - Set vcpu affinity for the interrupt
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 9e5783d98033..32c071d7bc03 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -111,6 +111,28 @@ static int irq_affinity_list_proc_show(struct seq_file *m, void *v)
 	return show_irq_affinity(AFFINITY_LIST, m);
 }
 
+#ifndef CONFIG_AUTO_IRQ_AFFINITY
+static inline int irq_select_affinity_usr(unsigned int irq)
+{
+	/*
+	 * If the interrupt is started up already then this fails. The
+	 * interrupt is assigned to an online CPU already. There is no
+	 * point to move it around randomly. Tell user space that the
+	 * selected mask is bogus.
+	 *
+	 * If not then any change to the affinity is pointless because the
+	 * startup code invokes irq_setup_affinity() which will select
+	 * a online CPU anyway.
+	 */
+	return -EINVAL;
+}
+#else
+/* ALPHA magic affinity auto selector. Keep it for historical reasons. */
+static inline int irq_select_affinity_usr(unsigned int irq)
+{
+	return irq_select_affinity(irq);
+}
+#endif
 
 static ssize_t write_irq_affinity(int type, struct file *file,
 		const char __user *buffer, size_t count, loff_t *pos)

