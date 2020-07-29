Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83950C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B3720809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RaxgywK/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1jY2X/sV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgG2Od7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:33:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43030 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgG2Odo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:44 -0400
Date:   Wed, 29 Jul 2020 14:33:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tp8c7I9WXBDmg3WjXeTUQX5Us9P8vk0Bqm/0SX/ESWU=;
        b=RaxgywK/QhjCwyLKCgyJqEJvhy6EUoCwriXblz4P+aAosQlyzZNpAP+jcKSGzhocKVesrF
        Vi+msu0CSlAv71OnI/veQdjUQcIaze2Kf8NVKPHPF2QKKNWQusKX8eZ9zMXwo7yWVEKDxj
        KadgyrbwargFCnri29AaIacU1q0MIGYFiw4LYQ6d2tEwtezFk1OUoirKLIOyppVSFyeeEb
        TSHflmUKAWY8wM82FbG4EuUYk+9eUQlu1F9C9TIdGlvMuWVg0POOKOACrlvLDBho5J7oDf
        LlGiERioMO7CpMQkaKcAORdg3xTpYFu1tKwjqYd0Q9edcGhPXEGrLlxrXnnHOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tp8c7I9WXBDmg3WjXeTUQX5Us9P8vk0Bqm/0SX/ESWU=;
        b=1jY2X/sV4ngIk4qkPD0X4vx2Uz7vUHkYtGJ/5QjbK6wxozjeibkT5zQT1apk0GA90Ve2UO
        +JnRrkIUSJ2t0gCw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Reorder seqcount_t and seqlock_t API definitions
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-5-a.darwish@linutronix.de>
References: <20200720155530.1173732-5-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603322062.4006.1604568805077748338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f4a27cbcec90ac04ee60e04b222e1449dcdba0bd
Gitweb:        https://git.kernel.org/tip/f4a27cbcec90ac04ee60e04b222e1449dcdba0bd
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:23 +02:00

seqlock: Reorder seqcount_t and seqlock_t API definitions

The seqlock.h seqcount_t and seqlock_t API definitions are presented in
the chronological order of their development rather than the order that
makes most sense to readers. This makes it hard to follow and understand
the header file code.

Group and reorder all of the exported seqlock.h functions according to
their function.

First, group together the seqcount_t standard read path functions:

    - __read_seqcount_begin()
    - raw_read_seqcount_begin()
    - read_seqcount_begin()

since each function is implemented exactly in terms of the one above
it. Then, group the special-case seqcount_t readers on their own as:

    - raw_read_seqcount()
    - raw_seqcount_begin()

since the only difference between the two functions is that the second
one masks the sequence counter LSB while the first one does not. Note
that raw_seqcount_begin() can actually be implemented in terms of
raw_read_seqcount(), which will be done in a follow-up commit.

Then, group the seqcount_t write path functions, instead of injecting
unrelated seqcount_t latch functions between them, and order them as:

    - raw_write_seqcount_begin()
    - raw_write_seqcount_end()
    - write_seqcount_begin_nested()
    - write_seqcount_begin()
    - write_seqcount_end()
    - raw_write_seqcount_barrier()
    - write_seqcount_invalidate()

which is the expected natural order. This also isolates the seqcount_t
latch functions into their own area, at the end of the sequence counters
section, and before jumping to the next one: sequential locks
(seqlock_t).

Do a similar grouping and reordering for seqlock_t "locking" readers vs.
the "conditionally locking or lockless" ones.

No implementation code was changed in any of the reordering above.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-5-a.darwish@linutronix.de
---
 include/linux/seqlock.h | 158 +++++++++++++++++++--------------------
 1 file changed, 78 insertions(+), 80 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index d724b5e..4c14560 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -129,23 +129,6 @@ repeat:
 }
 
 /**
- * raw_read_seqcount - Read the raw seqcount
- * @s: pointer to seqcount_t
- * Returns: count to be passed to read_seqcount_retry
- *
- * raw_read_seqcount opens a read critical section of the given
- * seqcount without any lockdep checking and without checking or
- * masking the LSB. Calling code is responsible for handling that.
- */
-static inline unsigned raw_read_seqcount(const seqcount_t *s)
-{
-	unsigned ret = READ_ONCE(s->sequence);
-	smp_rmb();
-	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
-	return ret;
-}
-
-/**
  * raw_read_seqcount_begin - start seq-read critical section w/o lockdep
  * @s: pointer to seqcount_t
  * Returns: count to be passed to read_seqcount_retry
@@ -177,6 +160,23 @@ static inline unsigned read_seqcount_begin(const seqcount_t *s)
 }
 
 /**
+ * raw_read_seqcount - Read the raw seqcount
+ * @s: pointer to seqcount_t
+ * Returns: count to be passed to read_seqcount_retry
+ *
+ * raw_read_seqcount opens a read critical section of the given
+ * seqcount without any lockdep checking and without checking or
+ * masking the LSB. Calling code is responsible for handling that.
+ */
+static inline unsigned raw_read_seqcount(const seqcount_t *s)
+{
+	unsigned ret = READ_ONCE(s->sequence);
+	smp_rmb();
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
+	return ret;
+}
+
+/**
  * raw_seqcount_begin - begin a seq-read critical section
  * @s: pointer to seqcount_t
  * Returns: count to be passed to read_seqcount_retry
@@ -234,8 +234,6 @@ static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
 	return __read_seqcount_retry(s, start);
 }
 
-
-
 static inline void raw_write_seqcount_begin(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
@@ -250,6 +248,23 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 	kcsan_nestable_atomic_end();
 }
 
+static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
+{
+	raw_write_seqcount_begin(s);
+	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+}
+
+static inline void write_seqcount_begin(seqcount_t *s)
+{
+	write_seqcount_begin_nested(s, 0);
+}
+
+static inline void write_seqcount_end(seqcount_t *s)
+{
+	seqcount_release(&s->dep_map, _RET_IP_);
+	raw_write_seqcount_end(s);
+}
+
 /**
  * raw_write_seqcount_barrier - do a seq write barrier
  * @s: pointer to seqcount_t
@@ -300,6 +315,21 @@ static inline void raw_write_seqcount_barrier(seqcount_t *s)
 	kcsan_nestable_atomic_end();
 }
 
+/**
+ * write_seqcount_invalidate - invalidate in-progress read-side seq operations
+ * @s: pointer to seqcount_t
+ *
+ * After write_seqcount_invalidate, no read-side seq operations will complete
+ * successfully and see data older than this.
+ */
+static inline void write_seqcount_invalidate(seqcount_t *s)
+{
+	smp_wmb();
+	kcsan_nestable_atomic_begin();
+	s->sequence+=2;
+	kcsan_nestable_atomic_end();
+}
+
 static inline int raw_read_seqcount_latch(seqcount_t *s)
 {
 	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
@@ -395,38 +425,6 @@ static inline void raw_write_seqcount_latch(seqcount_t *s)
        smp_wmb();      /* increment "sequence" before following stores */
 }
 
-static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
-{
-	raw_write_seqcount_begin(s);
-	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
-}
-
-static inline void write_seqcount_begin(seqcount_t *s)
-{
-	write_seqcount_begin_nested(s, 0);
-}
-
-static inline void write_seqcount_end(seqcount_t *s)
-{
-	seqcount_release(&s->dep_map, _RET_IP_);
-	raw_write_seqcount_end(s);
-}
-
-/**
- * write_seqcount_invalidate - invalidate in-progress read-side seq operations
- * @s: pointer to seqcount_t
- *
- * After write_seqcount_invalidate, no read-side seq operations will complete
- * successfully and see data older than this.
- */
-static inline void write_seqcount_invalidate(seqcount_t *s)
-{
-	smp_wmb();
-	kcsan_nestable_atomic_begin();
-	s->sequence+=2;
-	kcsan_nestable_atomic_end();
-}
-
 /*
  * Sequential locks (seqlock_t)
  *
@@ -555,35 +553,6 @@ static inline void read_sequnlock_excl(seqlock_t *sl)
 	spin_unlock(&sl->lock);
 }
 
-/**
- * read_seqbegin_or_lock - begin a sequence number check or locking block
- * @lock: sequence lock
- * @seq : sequence number to be checked
- *
- * First try it once optimistically without taking the lock. If that fails,
- * take the lock. The sequence number is also used as a marker for deciding
- * whether to be a reader (even) or writer (odd).
- * N.B. seq must be initialized to an even number to begin with.
- */
-static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
-{
-	if (!(*seq & 1))	/* Even */
-		*seq = read_seqbegin(lock);
-	else			/* Odd */
-		read_seqlock_excl(lock);
-}
-
-static inline int need_seqretry(seqlock_t *lock, int seq)
-{
-	return !(seq & 1) && read_seqretry(lock, seq);
-}
-
-static inline void done_seqretry(seqlock_t *lock, int seq)
-{
-	if (seq & 1)
-		read_sequnlock_excl(lock);
-}
-
 static inline void read_seqlock_excl_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
@@ -621,6 +590,35 @@ read_sequnlock_excl_irqrestore(seqlock_t *sl, unsigned long flags)
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
+/**
+ * read_seqbegin_or_lock - begin a sequence number check or locking block
+ * @lock: sequence lock
+ * @seq : sequence number to be checked
+ *
+ * First try it once optimistically without taking the lock. If that fails,
+ * take the lock. The sequence number is also used as a marker for deciding
+ * whether to be a reader (even) or writer (odd).
+ * N.B. seq must be initialized to an even number to begin with.
+ */
+static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
+{
+	if (!(*seq & 1))	/* Even */
+		*seq = read_seqbegin(lock);
+	else			/* Odd */
+		read_seqlock_excl(lock);
+}
+
+static inline int need_seqretry(seqlock_t *lock, int seq)
+{
+	return !(seq & 1) && read_seqretry(lock, seq);
+}
+
+static inline void done_seqretry(seqlock_t *lock, int seq)
+{
+	if (seq & 1)
+		read_sequnlock_excl(lock);
+}
+
 static inline unsigned long
 read_seqbegin_or_lock_irqsave(seqlock_t *lock, int *seq)
 {
