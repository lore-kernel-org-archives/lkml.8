Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B7BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945A920737
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbgDATu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:50:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35726 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732314AbgDATu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 15:50:27 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jJjNX-0000Y7-Rm; Wed, 01 Apr 2020 21:50:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0D9601C0315;
        Wed,  1 Apr 2020 21:50:23 +0200 (CEST)
Date:   Wed, 01 Apr 2020 19:50:22 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] hrtimer: Don't dereference the hrtimer pointer
 after the callback
Cc:     syzbot+62c155c276e580cfb606@syzkaller.appspotmail.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200331201849.fkp2siy3vcdqvqlz@linutronix.de>
References: <20200331201849.fkp2siy3vcdqvqlz@linutronix.de>
MIME-Version: 1.0
Message-ID: <158577062260.28353.4275523826758321524.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     73d20564e0dcae003e0d79977f044d5e57496304
Gitweb:        https://git.kernel.org/tip/73d20564e0dcae003e0d79977f044d5e57496304
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 31 Mar 2020 22:18:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Apr 2020 13:20:14 +02:00

hrtimer: Don't dereference the hrtimer pointer after the callback

A hrtimer can be released in its callback, but lockdep_hrtimer_exit()
dereferences the pointer after the callback returns, i.e. a potential use
after free.

Retrieve the context in which the hrtimer expires before the callback is
invoked and use it in lockdep_hrtimer_exit().

Fixes: 40db173965c0 ("lockdep: Add hrtimer context tracing bits")
Reported-by: syzbot+62c155c276e580cfb606@syzkaller.appspotmail.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200331201849.fkp2siy3vcdqvqlz@linutronix.de
---
 include/linux/irqflags.h | 27 ++++++++++++++++-----------
 kernel/time/hrtimer.c    |  5 +++--
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index ceca42d..61a9ced 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -58,16 +58,21 @@ do {						\
 } while (0)
 
 # define lockdep_hrtimer_enter(__hrtimer)		\
-	  do {						\
-		  if (!__hrtimer->is_hard)		\
-			current->irq_config = 1;	\
-	  } while (0)
-
-# define lockdep_hrtimer_exit(__hrtimer)		\
-	  do {						\
-		  if (!__hrtimer->is_hard)		\
+({							\
+	bool __expires_hardirq = true;			\
+							\
+	if (!__hrtimer->is_hard) {			\
+		current->irq_config = 1;		\
+		__expires_hardirq = false;		\
+	}						\
+	__expires_hardirq;				\
+})
+
+# define lockdep_hrtimer_exit(__expires_hardirq)	\
+	do {						\
+		if (!__expires_hardirq)			\
 			current->irq_config = 0;	\
-	  } while (0)
+	} while (0)
 
 # define lockdep_posixtimer_enter()				\
 	  do {							\
@@ -102,8 +107,8 @@ do {						\
 # define lockdep_hardirq_exit()		do { } while (0)
 # define lockdep_softirq_enter()	do { } while (0)
 # define lockdep_softirq_exit()		do { } while (0)
-# define lockdep_hrtimer_enter(__hrtimer)		do { } while (0)
-# define lockdep_hrtimer_exit(__hrtimer)		do { } while (0)
+# define lockdep_hrtimer_enter(__hrtimer)	false
+# define lockdep_hrtimer_exit(__context)	do { } while (0)
 # define lockdep_posixtimer_enter()		do { } while (0)
 # define lockdep_posixtimer_exit()		do { } while (0)
 # define lockdep_irq_work_enter(__work)		do { } while (0)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index d0a5ba3..d89da1c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1480,6 +1480,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 			  unsigned long flags) __must_hold(&cpu_base->lock)
 {
 	enum hrtimer_restart (*fn)(struct hrtimer *);
+	bool expires_in_hardirq;
 	int restart;
 
 	lockdep_assert_held(&cpu_base->lock);
@@ -1514,11 +1515,11 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	 */
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 	trace_hrtimer_expire_entry(timer, now);
-	lockdep_hrtimer_enter(timer);
+	expires_in_hardirq = lockdep_hrtimer_enter(timer);
 
 	restart = fn(timer);
 
-	lockdep_hrtimer_exit(timer);
+	lockdep_hrtimer_exit(expires_in_hardirq);
 	trace_hrtimer_expire_exit(timer);
 	raw_spin_lock_irq(&cpu_base->lock);
 
