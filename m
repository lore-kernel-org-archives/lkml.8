Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC13BC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA94D20732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NrftJe2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgCTMAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:00:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=48pbbTSIt7drl3nclPw/S2svZezo2KqXiudRpg34TKk=; b=NrftJe2uiM/eRbtUm9v31Bp1c2
        BNCrs3nazjRTflfZ6/FSIdWd1cgQ6c4K4mN/sKq/Reufea786w2Lem8NdWtr6vzANS/u2oumyQQy5
        nXP178oBVzempQyURC5eaZxQYPoskQGzfJyP/JvtaQEufG6ahC/uIuhsCM1qRBTi5/0VUcsVy/OWv
        b2susMYOSMXxDflV9pvJZwve7/NB9yh5D9baSAWu9CC8Y3to/IRhuP/7ZviUfm5wtMtVRfJh6sVxi
        wBhGT3UXBFIYXI2ZsIzjff61HHKZz+u8D49qDFjKCrLR3H8R+omDmhJs1cS2vHigyITcxw/W+4WAh
        QMNPuaTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFGK8-0004CM-62; Fri, 20 Mar 2020 12:00:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC546305BD3;
        Fri, 20 Mar 2020 13:00:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 83ECC2858D592; Fri, 20 Mar 2020 13:00:21 +0100 (CET)
Message-Id: <20200320115859.178626842@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 12:56:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, rostedt@goodmis.org, mingo@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, will@kernel.org, peterz@infradead.org
Subject: [PATCH 4/4] lockdep: Rename trace_{hard,soft}{irq_context,irqs_enabled}()
References: <20200320115638.737385408@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continue what commit:

  d820ac4c2fa8 ("locking: rename trace_softirq_[enter|exit] => lockdep_softirq_[enter|exit]")

started, rename these to avoid confusing them with tracepoints.

git grep -l "trace_\(soft\|hard\)\(irq_context\|irqs_enabled\)" | while read file;
do
	sed -ie 's/trace_\(soft\|hard\)\(irq_context\|irqs_enabled\)/lockdep_\1\2/g' $file;
done

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/irqflags.h       |   16 ++++++++--------
 kernel/locking/lockdep.c       |    8 ++++----
 kernel/softirq.c               |    2 +-
 tools/include/linux/irqflags.h |    8 ++++----
 4 files changed, 17 insertions(+), 17 deletions(-)

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -31,10 +31,10 @@
 #ifdef CONFIG_TRACE_IRQFLAGS
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
-# define trace_hardirq_context(p)	((p)->hardirq_context)
-# define trace_softirq_context(p)	((p)->softirq_context)
-# define trace_hardirqs_enabled(p)	((p)->hardirqs_enabled)
-# define trace_softirqs_enabled(p)	((p)->softirqs_enabled)
+# define lockdep_hardirq_context(p)	((p)->hardirq_context)
+# define lockdep_softirq_context(p)	((p)->softirq_context)
+# define lockdep_hardirqs_enabled(p)	((p)->hardirqs_enabled)
+# define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
 # define lockdep_hardirq_enter()		\
 do {						\
 	current->hardirq_context++;		\
@@ -54,10 +54,10 @@ do {						\
 #else
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
-# define trace_hardirq_context(p)	0
-# define trace_softirq_context(p)	0
-# define trace_hardirqs_enabled(p)	0
-# define trace_softirqs_enabled(p)	0
+# define lockdep_hardirq_context(p)	0
+# define lockdep_softirq_context(p)	0
+# define lockdep_hardirqs_enabled(p)	0
+# define lockdep_softirqs_enabled(p)	0
 # define lockdep_hardirq_enter()	do { } while (0)
 # define lockdep_hardirq_exit()		do { } while (0)
 # define lockdep_softirq_enter()	do { } while (0)
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3081,10 +3081,10 @@ print_usage_bug(struct task_struct *curr
 
 	pr_warn("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] takes:\n",
 		curr->comm, task_pid_nr(curr),
-		trace_hardirq_context(curr), hardirq_count() >> HARDIRQ_SHIFT,
-		trace_softirq_context(curr), softirq_count() >> SOFTIRQ_SHIFT,
-		trace_hardirqs_enabled(curr),
-		trace_softirqs_enabled(curr));
+		lockdep_hardirq_context(curr), hardirq_count() >> HARDIRQ_SHIFT,
+		lockdep_softirq_context(curr), softirq_count() >> SOFTIRQ_SHIFT,
+		lockdep_hardirqs_enabled(curr),
+		lockdep_softirqs_enabled(curr));
 	print_lock(this);
 
 	pr_warn("{%s} state was registered at:\n", usage_str[prev_bit]);
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -224,7 +224,7 @@ static inline bool lockdep_softirq_start
 {
 	bool in_hardirq = false;
 
-	if (trace_hardirq_context(current)) {
+	if (lockdep_hardirq_context(current)) {
 		in_hardirq = true;
 		lockdep_hardirq_exit();
 	}
--- a/tools/include/linux/irqflags.h
+++ b/tools/include/linux/irqflags.h
@@ -2,10 +2,10 @@
 #ifndef _LIBLOCKDEP_LINUX_TRACE_IRQFLAGS_H_
 #define _LIBLOCKDEP_LINUX_TRACE_IRQFLAGS_H_
 
-# define trace_hardirq_context(p)	0
-# define trace_softirq_context(p)	0
-# define trace_hardirqs_enabled(p)	0
-# define trace_softirqs_enabled(p)	0
+# define lockdep_hardirq_context(p)	0
+# define lockdep_softirq_context(p)	0
+# define lockdep_hardirqs_enabled(p)	0
+# define lockdep_softirqs_enabled(p)	0
 # define lockdep_hardirq_enter()	do { } while (0)
 # define lockdep_hardirq_exit()		do { } while (0)
 # define lockdep_softirq_enter()	do { } while (0)


