Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23112C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008572072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgAKPBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 10:01:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33352 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbgAKPBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 10:01:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iqIGb-0004an-4o; Sat, 11 Jan 2020 16:01:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AAC4A1C1944;
        Sat, 11 Jan 2020 16:01:32 +0100 (CET)
Date:   Sat, 11 Jan 2020 15:01:32 -0000
From:   "tip-bot2 for Changbin Du" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/nmi: Remove irq_work from the long duration NMI handler
Cc:     Changbin Du <changbin.du@gmail.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200111125427.15662-1-changbin.du@gmail.com>
References: <20200111125427.15662-1-changbin.du@gmail.com>
MIME-Version: 1.0
Message-ID: <157875489248.30329.781797148985800902.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     248ed51048c40d36728e70914e38bffd7821da57
Gitweb:        https://git.kernel.org/tip/248ed51048c40d36728e70914e38bffd7821da57
Author:        Changbin Du <changbin.du@gmail.com>
AuthorDate:    Sat, 11 Jan 2020 20:54:27 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 11 Jan 2020 15:55:39 +01:00

x86/nmi: Remove irq_work from the long duration NMI handler

First, printk() is NMI-context safe now since the safe printk() has been
implemented and it already has an irq_work to make NMI-context safe.

Second, this NMI irq_work actually does not work if a NMI handler causes
panic by watchdog timeout. It has no chance to run in such case, while
the safe printk() will flush its per-cpu buffers before panicking.

While at it, repurpose the irq_work callback into a function which
concentrates the NMI duration checking and makes the code easier to
follow.

 [ bp: Massage. ]

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200111125427.15662-1-changbin.du@gmail.com
---
 arch/x86/include/asm/nmi.h |  1 -
 arch/x86/kernel/nmi.c      | 20 +++++++++-----------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 75ded1d..9d5d949 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -41,7 +41,6 @@ struct nmiaction {
 	struct list_head	list;
 	nmi_handler_t		handler;
 	u64			max_duration;
-	struct irq_work		irq_work;
 	unsigned long		flags;
 	const char		*name;
 };
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index e676a99..54c21d6 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -104,18 +104,22 @@ static int __init nmi_warning_debugfs(void)
 }
 fs_initcall(nmi_warning_debugfs);
 
-static void nmi_max_handler(struct irq_work *w)
+static void nmi_check_duration(struct nmiaction *action, u64 duration)
 {
-	struct nmiaction *a = container_of(w, struct nmiaction, irq_work);
+	u64 whole_msecs = READ_ONCE(action->max_duration);
 	int remainder_ns, decimal_msecs;
-	u64 whole_msecs = READ_ONCE(a->max_duration);
+
+	if (duration < nmi_longest_ns || duration < action->max_duration)
+		return;
+
+	action->max_duration = duration;
 
 	remainder_ns = do_div(whole_msecs, (1000 * 1000));
 	decimal_msecs = remainder_ns / 1000;
 
 	printk_ratelimited(KERN_INFO
 		"INFO: NMI handler (%ps) took too long to run: %lld.%03d msecs\n",
-		a->handler, whole_msecs, decimal_msecs);
+		action->handler, whole_msecs, decimal_msecs);
 }
 
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
@@ -142,11 +146,7 @@ static int nmi_handle(unsigned int type, struct pt_regs *regs)
 		delta = sched_clock() - delta;
 		trace_nmi_handler(a->handler, (int)delta, thishandled);
 
-		if (delta < nmi_longest_ns || delta < a->max_duration)
-			continue;
-
-		a->max_duration = delta;
-		irq_work_queue(&a->irq_work);
+		nmi_check_duration(a, delta);
 	}
 
 	rcu_read_unlock();
@@ -164,8 +164,6 @@ int __register_nmi_handler(unsigned int type, struct nmiaction *action)
 	if (!action->handler)
 		return -EINVAL;
 
-	init_irq_work(&action->irq_work, nmi_max_handler);
-
 	raw_spin_lock_irqsave(&desc->lock, flags);
 
 	/*
