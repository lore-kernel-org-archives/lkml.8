Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56CAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78596207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mqMECgUw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WObvpuEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgIJT3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbgIJPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B34C061349;
        Thu, 10 Sep 2020 08:08:26 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:08:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599750504;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13k2MSnx0nJmSLqX5FucJWOQB6CkTBmHPvBZIFgl7Go=;
        b=mqMECgUwWnxjs8nY8ADe2vrYGwxmhpKkUv71STpJm/esuEiW78v79a4OKgbBGuQWw2kH6e
        0xbZm/irkuTSeVhHSpwZYbor0na6/okBJO8+FmJrMeT5FPLu85TH6Qg1or0xHB5nL4RGuo
        TbeFkK/JmWbt7oSJoqpGR77OKmBqv7ldwXnhM45zgtMi/b06YxN1wpHPR6wah1yynLH8qo
        9ArQFooGy6gU155nNB2nvjWzukyToqr7to1+WvrfmoZzQzrDhLr+psua81kqiHOEy7FHJ+
        IdYysmIQbbAipAyW8xGkT33yvrRyqfz2jVHFFjQEU7tvuhH/lepjnksUzbpLCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599750504;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13k2MSnx0nJmSLqX5FucJWOQB6CkTBmHPvBZIFgl7Go=;
        b=WObvpuEpXLlfnkw9Xp11EBmKNWmYoVW8psuG84HsMGisn/nmyJNdGrfTSVuIiumrNSObet
        Tf0uuXINfvReLfDA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: PREEMPT_RT: Do not starve seqlock_t writers
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200904153231.11994-6-a.darwish@linutronix.de>
References: <20200904153231.11994-6-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159975050367.20229.11965021456342644474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1909760f5fc3f123e47b4e24e0ccdc0fc8f3f106
Gitweb:        https://git.kernel.org/tip/1909760f5fc3f123e47b4e24e0ccdc0fc8f3f106
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Fri, 04 Sep 2020 17:32:31 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:31 +02:00

seqlock: PREEMPT_RT: Do not starve seqlock_t writers

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200904153231.11994-6-a.darwish@linutronix.de
---
 include/linux/seqlock.h | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 2bc9510..f73c7eb 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -790,13 +790,17 @@ static inline void raw_write_seqcount_latch(seqcount_latch_t *s)
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
 
@@ -806,8 +810,8 @@ typedef struct {
  */
 #define seqlock_init(sl)						\
 	do {								\
-		seqcount_init(&(sl)->seqcount);				\
 		spin_lock_init(&(sl)->lock);				\
+		seqcount_spinlock_init(&(sl)->seqcount, &(sl)->lock);	\
 	} while (0)
 
 /**
@@ -854,6 +858,12 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
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
@@ -870,7 +880,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -882,7 +892,7 @@ static inline void write_seqlock(seqlock_t *sl)
  */
 static inline void write_sequnlock(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount.seqcount);
 	spin_unlock(&sl->lock);
 }
 
@@ -896,7 +906,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -909,7 +919,7 @@ static inline void write_seqlock_bh(seqlock_t *sl)
  */
 static inline void write_sequnlock_bh(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount.seqcount);
 	spin_unlock_bh(&sl->lock);
 }
 
@@ -923,7 +933,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -935,7 +945,7 @@ static inline void write_seqlock_irq(seqlock_t *sl)
  */
 static inline void write_sequnlock_irq(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount.seqcount);
 	spin_unlock_irq(&sl->lock);
 }
 
@@ -944,7 +954,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_t_begin(&sl->seqcount);
+	write_seqcount_t_begin(&sl->seqcount.seqcount);
 	return flags;
 }
 
@@ -973,7 +983,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 static inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
-	write_seqcount_t_end(&sl->seqcount);
+	write_seqcount_t_end(&sl->seqcount.seqcount);
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
