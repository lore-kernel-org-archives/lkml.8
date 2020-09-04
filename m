Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B297C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F183C2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lb5idtPG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RVZyYI6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgIDPce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgIDPcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:32:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316BEC061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:32:20 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599233538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yp9dwmMJBr+rDaAM4mVaM092dzRDmUwjo2wkkSXS5Sk=;
        b=Lb5idtPGC+AHpNTcXVFogvwFGU+Ft/ptAqdM9rfVkIUfr8/mFjlHQqmTKVbl9OIaiERe9s
        bXimza4efawtLoYhs2l17ysnO+iiaITF3K8TbEEjGhLJzMFIN2rD3wTKLp1dfcdtnUFI2o
        UK5c/xNUoLfuy3qaIhwhely1ayoMIB4xRUOvJzIoThv514IKG+/iKht0kJWlxRUKUrY8tl
        UVAy+PmiU5QGOX/SASWol1pvUCtZWig5V5jYHTRfjGmMyKNcPc8jl1ilADvmUgtkv45Eu4
        /YNhmyM2vPr7O5m4t1qkWurIrrcElwd+aaJc8wNthiZE9J22gxEnwI7CWmZ88Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599233538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yp9dwmMJBr+rDaAM4mVaM092dzRDmUwjo2wkkSXS5Sk=;
        b=RVZyYI6gcNjVeDjxmGEyKVVeO9+ljXTxguUt4WOrfh+ajA5AsHtxi8RzKIw/A8dlhluYS8
        oruA4y0hThFmrxDA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v2 3/5] seqlock: seqcount_t: Implement all read APIs as statement expressions
Date:   Fri,  4 Sep 2020 17:32:29 +0200
Message-Id: <20200904153231.11994-4-a.darwish@linutronix.de>
In-Reply-To: <20200904153231.11994-1-a.darwish@linutronix.de>
References: <20200904153231.11994-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sequence counters read APIs are implemented as CPP macros, so they
can take either seqcount_t or any of the seqcount_LOCKNAME_t variants.
Such macros then get *directly* transformed to internal C functions that
only take plain seqcount_t.

Further commits need access to seqcount_LOCKNAME_t inside of the actual
read APIs code. Thus transform all of the seqcount read APIs to pure GCC
statement expressions instead.

This will not break type-safety: all of the transformed APIs resolve to
a _Generic() selection that does not have a "default" case.

This will also not affect the transformed APIs readability: previously
added kernel-doc above all of seqlock.h functions makes the expectations
quite clear for call-site developers.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 94 ++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 49 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 96198da7debc..ed1c6c0ff8bb 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -184,6 +184,12 @@ __seqprop_seqcount_##lockname##_ptr(seqcount_##lockname##_t *s)		\
 	return &s->seqcount;						\
 }									\
 									\
+static __always_inline unsigned						\
+__seqprop_seqcount_##lockname##_sequence(const seqcount_##lockname##_t *s)\
+{									\
+	return READ_ONCE(s->seqcount.sequence);				\
+}									\
+									\
 static __always_inline bool						\
 __seqprop_seqcount_##lockname##_preemptible(const seqcount_##lockname##_t *s)\
 {									\
@@ -205,6 +211,11 @@ static inline seqcount_t *__seqprop_seqcount_ptr(seqcount_t *s)
 	return s;
 }
 
+static inline unsigned __seqprop_seqcount_sequence(const seqcount_t *s)
+{
+	return READ_ONCE(s->sequence);
+}
+
 static inline bool __seqprop_seqcount_preemptible(const seqcount_t *s)
 {
 	return false;
@@ -250,6 +261,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,	struct ww_mutex,	true,	&s->lock->base)
 	__seqprop_case((s),	ww_mutex,	prop))
 
 #define __seqcount_ptr(s)		__seqprop(s, ptr)
+#define __seqcount_sequence(s)		__seqprop(s, sequence)
 #define __seqcount_lock_preemptible(s)	__seqprop(s, preemptible)
 #define __seqcount_assert_lock_held(s)	__seqprop(s, assert)
 
@@ -268,21 +280,15 @@ SEQCOUNT_LOCKNAME(ww_mutex,	struct ww_mutex,	true,	&s->lock->base)
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
+	while ((seq = __seqcount_sequence(s)) & 1)			\
+		cpu_relax();						\
+									\
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
+	seq;								\
+})
 
 /**
  * raw_read_seqcount_begin() - begin a seqcount_t read section w/o lockdep
@@ -291,14 +297,12 @@ static inline unsigned __read_seqcount_t_begin(const seqcount_t *s)
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
@@ -307,13 +311,10 @@ static inline unsigned raw_read_seqcount_t_begin(const seqcount_t *s)
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
@@ -327,15 +328,13 @@ static inline unsigned read_seqcount_t_begin(const seqcount_t *s)
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
@@ -355,16 +354,13 @@ static inline unsigned raw_read_seqcount_t(const seqcount_t *s)
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

