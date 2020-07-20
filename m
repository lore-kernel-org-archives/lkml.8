Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E255C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D754F206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HOLvJQfP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6384ay2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbgGTP4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:56:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58724 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731731AbgGTPzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:55:53 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoUJnr4URy+0EwDgNtGsLyT4yoY91spHNMewIh6xqZU=;
        b=HOLvJQfPfaARhiarvOeloF1vEAChe6B+hY8/1EYC1w8Mfoqv35NnG8DB13uYYFrRlAMP9F
        l9qYuVrAUM5riuh8n1SehtJyikNWwP1uM1UUxUFeQyGzVTXGYN9R8H9ET8R5+jyyDwsaRr
        yYIkXaQN96KbW3kmHuJrDdrRXW6t74gHRx4zZLtURswOZQ9S7sfbaxrOR1x+xNtErlOfNt
        8lrsb+Cf366+lDokSdkeHaBMEK6bgptR2io5m0ZAQdswcr3ZxY0/GBUpYcxMFMMcKHAPVn
        kWCgYKqDbqkAYi8oo5PAFrtmG8tIAW3dPfc5E2na5662RxvYDBxkxc/wCuTrZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoUJnr4URy+0EwDgNtGsLyT4yoY91spHNMewIh6xqZU=;
        b=6384ay2/3CWYlLnOcoi/UrWoRythVAzuDmZ3Dn5x4ARbXYak+K21ZU9RkjcwChZ3Zqr6Z0
        y2SP+NlNWeLOcsAg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v4 04/24] seqlock: Reorder seqcount_t and seqlock_t API definitions
Date:   Mon, 20 Jul 2020 17:55:10 +0200
Message-Id: <20200720155530.1173732-5-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 include/linux/seqlock.h | 174 ++++++++++++++++++++--------------------
 1 file changed, 86 insertions(+), 88 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index d724b5e5408d..4c1456008d89 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -128,23 +128,6 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 	return ret;
 }
 
-/**
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
 /**
  * raw_read_seqcount_begin - start seq-read critical section w/o lockdep
  * @s: pointer to seqcount_t
@@ -176,6 +159,23 @@ static inline unsigned read_seqcount_begin(const seqcount_t *s)
 	return raw_read_seqcount_begin(s);
 }
 
+/**
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
 /**
  * raw_seqcount_begin - begin a seq-read critical section
  * @s: pointer to seqcount_t
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
@@ -555,6 +553,43 @@ static inline void read_sequnlock_excl(seqlock_t *sl)
 	spin_unlock(&sl->lock);
 }
 
+static inline void read_seqlock_excl_bh(seqlock_t *sl)
+{
+	spin_lock_bh(&sl->lock);
+}
+
+static inline void read_sequnlock_excl_bh(seqlock_t *sl)
+{
+	spin_unlock_bh(&sl->lock);
+}
+
+static inline void read_seqlock_excl_irq(seqlock_t *sl)
+{
+	spin_lock_irq(&sl->lock);
+}
+
+static inline void read_sequnlock_excl_irq(seqlock_t *sl)
+{
+	spin_unlock_irq(&sl->lock);
+}
+
+static inline unsigned long __read_seqlock_excl_irqsave(seqlock_t *sl)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sl->lock, flags);
+	return flags;
+}
+
+#define read_seqlock_excl_irqsave(lock, flags)				\
+	do { flags = __read_seqlock_excl_irqsave(lock); } while (0)
+
+static inline void
+read_sequnlock_excl_irqrestore(seqlock_t *sl, unsigned long flags)
+{
+	spin_unlock_irqrestore(&sl->lock, flags);
+}
+
 /**
  * read_seqbegin_or_lock - begin a sequence number check or locking block
  * @lock: sequence lock
@@ -584,43 +619,6 @@ static inline void done_seqretry(seqlock_t *lock, int seq)
 		read_sequnlock_excl(lock);
 }
 
-static inline void read_seqlock_excl_bh(seqlock_t *sl)
-{
-	spin_lock_bh(&sl->lock);
-}
-
-static inline void read_sequnlock_excl_bh(seqlock_t *sl)
-{
-	spin_unlock_bh(&sl->lock);
-}
-
-static inline void read_seqlock_excl_irq(seqlock_t *sl)
-{
-	spin_lock_irq(&sl->lock);
-}
-
-static inline void read_sequnlock_excl_irq(seqlock_t *sl)
-{
-	spin_unlock_irq(&sl->lock);
-}
-
-static inline unsigned long __read_seqlock_excl_irqsave(seqlock_t *sl)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&sl->lock, flags);
-	return flags;
-}
-
-#define read_seqlock_excl_irqsave(lock, flags)				\
-	do { flags = __read_seqlock_excl_irqsave(lock); } while (0)
-
-static inline void
-read_sequnlock_excl_irqrestore(seqlock_t *sl, unsigned long flags)
-{
-	spin_unlock_irqrestore(&sl->lock, flags);
-}
-
 static inline unsigned long
 read_seqbegin_or_lock_irqsave(seqlock_t *lock, int *seq)
 {
-- 
2.20.1

