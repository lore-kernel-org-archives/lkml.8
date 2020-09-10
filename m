Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9EBC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F966207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yXo/mkZC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T6o5vNnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgIJT3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731417AbgIJPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BFEC06134B;
        Thu, 10 Sep 2020 08:08:26 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:08:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599750505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mOUuPAc1Yh5ijC7AXKvsVCLku6U1/7qBfQuuPRx/PI=;
        b=yXo/mkZCdjezXKoLn795UU/z9vnZruhnfZ9MYyxtKFJfYfdVMXEbgg141eMhATNdcort0h
        cNe6PG/R0mIGuiFyKFUfb3bdkqBfGEuVrmwiE0xJahxMAv0Rqm7AiBf6tfWjIoPPnMlAyr
        LpngdCcUY1zhhkHyf0niYy5a2SFKg2Wmz5Exy0XwtkX2h13SbUOOsKWNBOJE2VQDr7Sq/T
        VTFXa+JXkDiarkrUw65ekaZbXeoRERI3BCxkH+qP5F6YPiebMLCOYzJwLWt4zoVRh1Weu0
        8vf/URzDr98/zQII2fnBHX0nOJMJq/FkPVZZAkyYmyjyKZ/jEmQKbul1tzurFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599750505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mOUuPAc1Yh5ijC7AXKvsVCLku6U1/7qBfQuuPRx/PI=;
        b=T6o5vNnfPSNcUKzfHO8vx8oRf4kJBO/soPQBfz6AL8IyL7zdEVbGWU9tlCKtuyUY4br5KR
        RTiYfQdwrLhwKcDA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: seqcount_t: Implement all read APIs as
 statement expressions
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200904153231.11994-4-a.darwish@linutronix.de>
References: <20200904153231.11994-4-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159975050461.20229.10164012380779845315.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     52ac39e5db5148f70392edb654ad882ac8da88a8
Gitweb:        https://git.kernel.org/tip/52ac39e5db5148f70392edb654ad882ac8da88a8
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Fri, 04 Sep 2020 17:32:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:31 +02:00

seqlock: seqcount_t: Implement all read APIs as statement expressions

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200904153231.11994-4-a.darwish@linutronix.de
---
 include/linux/seqlock.h | 94 +++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 49 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 0b4a22f..f3b7827 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -184,6 +184,12 @@ __seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 	return &s->seqcount;						\
 }									\
 									\
+static __always_inline unsigned						\
+__seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s)	\
+{									\
+	return READ_ONCE(s->seqcount.sequence);				\
+}									\
+									\
 static __always_inline bool						\
 __seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
 {									\
@@ -205,6 +211,11 @@ static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
 	return s;
 }
 
+static inline unsigned __seqprop_sequence(const seqcount_t *s)
+{
+	return READ_ONCE(s->sequence);
+}
+
 static inline bool __seqprop_preemptible(const seqcount_t *s)
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
@@ -291,14 +297,12 @@ repeat:
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
