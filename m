Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B968AC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F69A2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TjFgHUnh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a4TSuQah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgH1BHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:07:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41876 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1BHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:07:05 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598576823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5IsFEQ2Eog5P+tP1GO7w5qYzNlrjSXGVQKMj3BCXPpI=;
        b=TjFgHUnh91oXg8QkHtGOBI8E6nRwxWRVh1CeJ1lkf5Tyvio04ULx654s6OROxuobtXVjAM
        6V90iaHLrYfWfCt6gI5jtcdCK71I5kmr2sut4PZT7++CzqqEyjmqt1n0FTsF3FYK22h5D0
        iKQZDQAlxINNNeWSbal9IhGYBKcCCqqiRWoV2AhFlnzspHfAEzOofr6wwbnmaC4GxSbWg/
        S8/L78Rh8fvGxg5aVWjHtstKCKe05Ha17a2gyl2nkK78xwWEJlYr41dljPh43nRgPN/Hhj
        myAF7VvuHQJWsdlcrAyXOT5YWWhB3N+QnvuD+oX/mwoTZC5OrmtUKTWaiddjIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598576823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5IsFEQ2Eog5P+tP1GO7w5qYzNlrjSXGVQKMj3BCXPpI=;
        b=a4TSuQahA4c8tb+Y3+kNa+5/7mWU4NSgttfbyqS4LiJDGWsZL3+jpPYX+GWby1f+5Wb7o5
        LSzeczoTNZMPakDw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 3/5] seqlock: seqcount_t: Implement all read APIs as statement expressions
Date:   Fri, 28 Aug 2020 03:07:08 +0200
Message-Id: <20200828010710.5407-4-a.darwish@linutronix.de>
In-Reply-To: <20200828010710.5407-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sequence counters read APIs are implemented as CPP macros, so they
can take either seqcount_t or any of the seqcount_LOCKTYPE_t variants.
Such macros then get *directly* transformed to internal C functions that
only take plain seqcount_t.

Further commits need access to seqcount_LOCKTYPE_t inside of the actual
read APIs code. Thus transform all of the seqcount read APIs to pure GCC
statement expressions instead.

This will not break type-safety: all of the transformed APIs resolve to
a _Generic() selection that does not have a "default" case.

This will also not affect the transformed APIs readability: previously
added kernel-doc above all of seqlock.h functions makes the expectations
quite clear for call-site developers.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 98 ++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5470e9cd52ce..d114a9f4e9d9 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -182,6 +182,12 @@ __seqcount_##locktype##_ptr(seqcount_##locktype##_t *s)			\
 	return &s->seqcount;						\
 }									\
 									\
+static __always_inline unsigned						\
+__seqcount_##locktype##_sequence(const seqcount_##locktype##_t *s)	\
+{									\
+	return READ_ONCE(s->seqcount.sequence);				\
+}									\
+									\
 static __always_inline bool						\
 __seqcount_##locktype##_preemptible(const seqcount_##locktype##_t *s)	\
 {									\
@@ -203,6 +209,11 @@ static inline seqcount_t *__seqcount_t_ptr(seqcount_t *s)
 	return s;
 }
 
+static inline unsigned __seqcount_t_sequence(const seqcount_t *s)
+{
+	return READ_ONCE(s->sequence);
+}
+
 static inline bool __seqcount_t_preemptible(const seqcount_t *s)
 {
 	return false;
@@ -248,6 +259,7 @@ SEQCOUNT_LOCKTYPE(ww_mutex,	struct ww_mutex,	true,	&s->lock->base)
 	__seqprop_case((s),	ww_mutex,	prop))
 
 #define __seqcount_ptr(s)		__seqprop(s, ptr)
+#define __seqcount_sequence(s)		__seqprop(s, sequence)
 #define __seqcount_lock_preemptible(s)	__seqprop(s, preemptible)
 #define __seqcount_assert_lock_held(s)	__seqprop(s, assert)
 
@@ -266,21 +278,19 @@ SEQCOUNT_LOCKTYPE(ww_mutex,	struct ww_mutex,	true,	&s->lock->base)
  * Return: count to be passed to read_seqcount_retry()
  */
 #define __read_seqcount_begin(s)					\
-	__read_seqcount_t_begin(__seqcount_ptr(s))
-
-static inline unsigned __read_seqcount_t_begin(const seqcount_t *s)
-{
-	unsigned ret;
-
-repeat:
-	ret = READ_ONCE(s->sequence);
-	if (unlikely(ret & 1)) {
-		cpu_relax();
-		goto repeat;
-	}
-	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
-	return ret;
-}
+({									\
+	unsigned seq;							\
+									\
+	do {								\
+		seq = __seqcount_sequence(s);				\
+		if (likely(! (seq & 1)))				\
+			break;						\
+		cpu_relax();						\
+	} while (true);							\
+									\
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
+	seq;								\
+})
 
 /**
  * raw_read_seqcount_begin() - begin a seqcount_t read section w/o lockdep
@@ -289,14 +299,12 @@ static inline unsigned __read_seqcount_t_begin(const seqcount_t *s)
  * Return: count to be passed to read_seqcount_retry()
  */
 #define raw_read_seqcount_begin(s)					\
-	raw_read_seqcount_t_begin(__seqcount_ptr(s))
-
-static inline unsigned raw_read_seqcount_t_begin(const seqcount_t *s)
-{
-	unsigned ret = __read_seqcount_t_begin(s);
-	smp_rmb();
-	return ret;
-}
+({									\
+	unsigned seq = __read_seqcount_begin(s);			\
+									\
+	smp_rmb();							\
+	seq;								\
+})
 
 /**
  * read_seqcount_begin() - begin a seqcount_t read critical section
@@ -305,13 +313,10 @@ static inline unsigned raw_read_seqcount_t_begin(const seqcount_t *s)
  * Return: count to be passed to read_seqcount_retry()
  */
 #define read_seqcount_begin(s)						\
-	read_seqcount_t_begin(__seqcount_ptr(s))
-
-static inline unsigned read_seqcount_t_begin(const seqcount_t *s)
-{
-	seqcount_lockdep_reader_access(s);
-	return raw_read_seqcount_t_begin(s);
-}
+({									\
+	seqcount_lockdep_reader_access(__seqcount_ptr(s));		\
+	raw_read_seqcount_begin(s);					\
+})
 
 /**
  * raw_read_seqcount() - read the raw seqcount_t counter value
@@ -325,15 +330,13 @@ static inline unsigned read_seqcount_t_begin(const seqcount_t *s)
  * Return: count to be passed to read_seqcount_retry()
  */
 #define raw_read_seqcount(s)						\
-	raw_read_seqcount_t(__seqcount_ptr(s))
-
-static inline unsigned raw_read_seqcount_t(const seqcount_t *s)
-{
-	unsigned ret = READ_ONCE(s->sequence);
-	smp_rmb();
-	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
-	return ret;
-}
+({									\
+	unsigned seq = __seqcount_sequence(s);				\
+									\
+	smp_rmb();							\
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
+	seq;								\
+})
 
 /**
  * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
@@ -353,16 +356,13 @@ static inline unsigned raw_read_seqcount_t(const seqcount_t *s)
  * Return: count to be passed to read_seqcount_retry()
  */
 #define raw_seqcount_begin(s)						\
-	raw_seqcount_t_begin(__seqcount_ptr(s))
-
-static inline unsigned raw_seqcount_t_begin(const seqcount_t *s)
-{
-	/*
-	 * If the counter is odd, let read_seqcount_retry() fail
-	 * by decrementing the counter.
-	 */
-	return raw_read_seqcount_t(s) & ~1;
-}
+({									\
+	/*								\
+	 * If the counter is odd, let read_seqcount_retry() fail	\
+	 * by decrementing the counter.					\
+	 */								\
+	raw_read_seqcount(s) & ~1;					\
+})
 
 /**
  * __read_seqcount_retry() - end a seqcount_t read section w/o barrier
-- 
2.28.0

