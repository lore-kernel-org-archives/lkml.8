Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36D7C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9DA2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgBNIsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:48:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53983 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgBNIsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:48:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j2WeI-0001z5-RW; Fri, 14 Feb 2020 09:48:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 77B031C2015;
        Fri, 14 Feb 2020 09:48:34 +0100 (CET)
Date:   Fri, 14 Feb 2020 08:48:34 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/proc: Reject invalid affinity masks (again)
Cc:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <878sl8xdbm.fsf@nanos.tec.linutronix.de>
References: <878sl8xdbm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <158167011413.13786.15512225589098863919.tip-bot2@tip-bot2>
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

Commit-ID:     cba6437a1854fde5934098ec3bd0ee83af3129f5
Gitweb:        https://git.kernel.org/tip/cba6437a1854fde5934098ec3bd0ee83af3129f5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 12 Feb 2020 12:19:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 Feb 2020 09:43:17 +01:00

genirq/proc: Reject invalid affinity masks (again)

Qian Cai reported that the WARN_ON() in the x86/msi affinity setting code,
which catches cases where the affinity setting is not done on the CPU which
is the current target of the interrupt, triggers during CPU hotplug stress
testing.

It turns out that the warning which was added with the commit addressing
the MSI affinity race unearthed yet another long standing bug.

If user space writes a bogus affinity mask, i.e. it contains no online CPUs,
then it calls irq_select_affinity_usr(). This was introduced for ALPHA in

  eee45269b0f5 ("[PATCH] Alpha: convert to generic irq framework (generic part)")

and subsequently made available for all architectures in

  18404756765c ("genirq: Expose default irq affinity mask (take 3)")

which introduced the circumvention of the affinity setting restrictions for
interrupt which cannot be moved in process context.

The whole exercise is bogus in various aspects:

  1) If the interrupt is already started up then there is absolutely
     no point to honour a bogus interrupt affinity setting from user
     space. The interrupt is already assigned to an online CPU and it
     does not make any sense to reassign it to some other randomly
     chosen online CPU.

  2) If the interupt is not yet started up then there is no point
     either. A subsequent startup of the interrupt will invoke
     irq_setup_affinity() anyway which will chose a valid target CPU.

So the only correct solution is to just return -EINVAL in case user space
wrote an affinity mask which does not contain any online CPUs, except for
ALPHA which has it's own magic sauce for this.

Fixes: 18404756765c ("genirq: Expose default irq affinity mask (take 3)")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qian Cai <cai@lca.pw>
Link: https://lkml.kernel.org/r/878sl8xdbm.fsf@nanos.tec.linutronix.de


---
 kernel/irq/internals.h |  2 --
 kernel/irq/manage.c    | 18 ++----------------
 kernel/irq/proc.c      | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 3924fbe..c9d8eb7 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -128,8 +128,6 @@ static inline void unregister_handler_proc(unsigned int irq,
 
 extern bool irq_can_set_affinity_usr(unsigned int irq);
 
-extern int irq_select_affinity_usr(unsigned int irq);
-
 extern void irq_set_thread_affinity(struct irq_desc *desc);
 
 extern int irq_do_set_affinity(struct irq_data *data,
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 3089a60..7eee98c 100644
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
index 9e5783d..32c071d 100644
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
