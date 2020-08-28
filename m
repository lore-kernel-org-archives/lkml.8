Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1552EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE84220848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KvABK9A0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XxD44Cug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgH1BHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:07:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1BHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:07:15 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598576832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydZeQds0CoVLgDYVJunHzvoIHp7wMgdPzt53fEtD/gQ=;
        b=KvABK9A0yj1skW/WK6AxTySTi/fRVLMUeqor4b1GacStGqyCtZeuVYxKAAS+6qjB2dev8l
        T9c/GNpzfp86d7DWWMjZtBAXd78OkSz9zcPxkrcNlzGKusawh1PVlIKU3qpCN9uk5sTX8a
        dBsYWFbsuqxtBNm3vZgRnY6ygVFPh3Ojdo5Hgq3HdGu4WWi3EAmBb+njndmLfR6hrdkK9M
        EDB8lp11EjyZSCYXF/tGm/br9xz3WkmkfEeX6NxdCp4RGcZIio2rIMEf2wVpSOdkgy20/h
        7QQql/SOX4rSzi7FgrhnUVyq26mcRyludhe8WTH0RrsCNrypK4mEEyVpz6Gjfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598576832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydZeQds0CoVLgDYVJunHzvoIHp7wMgdPzt53fEtD/gQ=;
        b=XxD44CuguPXlutzxvM7gn2Zq4bQ16Bln9V74Zbv1Rq5ddqgKet61hdS3F7xRE0P91oI1bm
        g/+T7IDyJWtZIHCA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 5/5] seqlock: PREEMPT_RT: Do not starve seqlock_t writers
Date:   Fri, 28 Aug 2020 03:07:10 +0200
Message-Id: <20200828010710.5407-6-a.darwish@linutronix.de>
In-Reply-To: <20200828010710.5407-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PREEMPT_RT, seqlock_t is transformed to a sleeping lock that do not
disable preemption. A seqlock_t reader can thus preempt the write side
section and spin for the enter scheduler tick. If that reader belongs to
a real-time scheduling class, it can spin forever and the kernel will
livelock.

To break such a possible livelock on PREEMPT_RT, implement seqlock_t in
terms of "seqcount_spinlock_t" instead of plain "seqcount_t".

Beside the pure annotational value, this will leverage the already
existing seqcount_LOCKTYPE_T anti-livelock mechanisms -- without adding
any extra code.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 8d4bf12272ba..151e7a18fd7b 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -761,13 +761,17 @@ static inline void raw_write_seqcount_t_latch(seqcount_t *s)
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
 
@@ -777,8 +781,8 @@ typedef struct {
  */
 #define seqlock_init(sl)						\
 	do {								\
-		seqcount_init(&(sl)->seqcount);				\
 		spin_lock_init(&(sl)->lock);				\
+		seqcount_spinlock_init(&(sl)->seqcount, &(sl)->lock);	\
 	} while (0)
 
 /**
@@ -825,6 +829,12 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
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
@@ -841,7 +851,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -853,7 +863,7 @@ static inline void write_seqlock(seqlock_t *sl)
  */
 static inline void write_sequnlock(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount.seqcount);
 	spin_unlock(&sl->lock);
 }
 
@@ -867,7 +877,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -880,7 +890,7 @@ static inline void write_seqlock_bh(seqlock_t *sl)
  */
 static inline void write_sequnlock_bh(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount.seqcount);
 	spin_unlock_bh(&sl->lock);
 }
 
@@ -894,7 +904,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -906,7 +916,7 @@ static inline void write_seqlock_irq(seqlock_t *sl)
  */
 static inline void write_sequnlock_irq(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount.seqcount);
 	spin_unlock_irq(&sl->lock);
 }
 
@@ -915,7 +925,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_t_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount.seqcount);
 	return flags;
 }
 
@@ -944,7 +954,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 static inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
-	write_seqcount_t_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount.seqcount);
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
-- 
2.28.0

