Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20135C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E7520772
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kHVNSAsv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v8Ek/F4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIDPc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:32:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33754 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIDPca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:32:30 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599233547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3aTXUWOFUY6rMm9X7d1EuCalQEcR/WTioCR4C7q4F8=;
        b=kHVNSAsvvteInNP5oNANH57rTRn36oQ/5zodjwhLfpDeIqhmzg2kRUK87iBeOKqn16zvcC
        I/aWwvBv048I09iPKWK0tOonrB60UfJQyjQyOoj6dBXNZuxTZDZhRv/B/XRqnwj4CAsJJu
        uLELOxWRiVAmGmVu1XFGjYvjHZ8uT73KuHnQDOBqYTIg2A+LrW7d2yn41tVhVUKHW1o2dx
        8vXDd6cb/BrOorv2/GbLDnr4wZ3eEeCZXXO1rJjB6xye7bnzzLxIVJc+/thp3BOaAfqkPV
        0IrIbe0FNMxwTkSAx/LlMVxkGPvOTEYKijnW3SYAnT3X2/kr8aftiiw8J+hGgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599233548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3aTXUWOFUY6rMm9X7d1EuCalQEcR/WTioCR4C7q4F8=;
        b=v8Ek/F4lB/eyVfaLzdCxREoKbWISzJ7xACajorteCh1heIv2M0H3+o0UveCs+DR3qJOfz+
        9te4GHzFirp0k/AA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v2 5/5] seqlock: PREEMPT_RT: Do not starve seqlock_t writers
Date:   Fri,  4 Sep 2020 17:32:31 +0200
Message-Id: <20200904153231.11994-6-a.darwish@linutronix.de>
In-Reply-To: <20200904153231.11994-1-a.darwish@linutronix.de>
References: <20200904153231.11994-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PREEMPT_RT, seqlock_t is transformed to a sleeping lock that do not
disable preemption. A seqlock_t reader can thus preempt its write side
section and spin for the enter scheduler tick. If that reader belongs to
a real-time scheduling class, it can spin forever and the kernel will
livelock.

To break this livelock possibility on PREEMPT_RT, implement seqlock_t in
terms of "seqcount_spinlock_t" instead of plain "seqcount_t".

Beside its pure annotational value, this will leverage the existing
seqcount_LOCKNAME_T PREEMPT_RT anti-livelock mechanisms, without adding
any extra code.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 6ac5a63fc536..06a339355c3a 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -757,13 +757,17 @@ static inline void raw_write_seqcount_t_latch(seqcount_t *s)
  *    - Documentation/locking/seqlock.rst
  */
 typedef struct {
-	struct seqcount seqcount;
+	/*
+	 * Make sure that readers don't starve writers on PREEMPT_RT: use
+	 * seqcount_spinlock_t instead of seqcount_t. Check __SEQ_LOCK().
+	 */
+	seqcount_spinlock_t seqcount;
 	spinlock_t lock;
 } seqlock_t;
 
 #define __SEQLOCK_UNLOCKED(lockname)					\
 	{								\
-		.seqcount = SEQCNT_ZERO(lockname),			\
+		.seqcount = SEQCNT_SPINLOCK_ZERO(lockname, &(lockname).lock), \
 		.lock =	__SPIN_LOCK_UNLOCKED(lockname)			\
 	}
 
@@ -773,8 +777,8 @@ typedef struct {
  */
 #define seqlock_init(sl)						\
 	do {								\
-		seqcount_init(&(sl)->seqcount);				\
 		spin_lock_init(&(sl)->lock);				\
+		seqcount_spinlock_init(&(sl)->seqcount, &(sl)->lock);	\
 	} while (0)
 
 /**
@@ -821,6 +825,12 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 	return read_seqcount_retry(&sl->seqcount, start);
 }
 
+/*
+ * For all seqlock_t write side functions, use write_seqcount_*t*_begin()
+ * instead of the generic write_seqcount_begin(). This way, no redundant
+ * lockdep_assert_held() checks are added.
+ */
+
 /**
  * write_seqlock() - start a seqlock_t write side critical section
  * @sl: Pointer to seqlock_t
@@ -837,7 +847,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -849,7 +859,7 @@ static inline void write_seqlock(seqlock_t *sl)
  */
 static inline void write_sequnlock(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount.seqcount);
 	spin_unlock(&sl->lock);
 }
 
@@ -863,7 +873,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -876,7 +886,7 @@ static inline void write_seqlock_bh(seqlock_t *sl)
  */
 static inline void write_sequnlock_bh(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount.seqcount);
 	spin_unlock_bh(&sl->lock);
 }
 
@@ -890,7 +900,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -902,7 +912,7 @@ static inline void write_seqlock_irq(seqlock_t *sl)
  */
 static inline void write_sequnlock_irq(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount.seqcount);
 	spin_unlock_irq(&sl->lock);
 }
 
@@ -911,7 +921,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_t_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount.seqcount);
 	return flags;
 }
 
@@ -940,7 +950,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 static inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
-	write_seqcount_t_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount.seqcount);
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
-- 
2.28.0

