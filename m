Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AF3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87C222B48
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jO/wPANa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H1wgvFBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgG2Oda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgG2Od1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469FFC061794;
        Wed, 29 Jul 2020 07:33:27 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:33:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pzxcKLaqbW/YnK6A44TXbcRHAKldZUwWkJuYXKse4Sw=;
        b=jO/wPANaGTHQhH9gIa8+QGKbmmmmtvv96c6NZN6KAMKn67d1YCfopHnqSYTbmBRdZlKojg
        EYpueioD+lnVmd4MmwFodfXxbof/zQeZjYWzKgI/uiFUmzUuIxInqvKhhbmw5QCxrXBR/u
        daSrNlzxQGG1FoU/fZM8Pz1BGsMYOZfcM16T2lvEIhN5QzbvaL5etLmun7q3aSgrrTJ533
        zUHMXzEAtF8L+e9nrYzf/KRpDNeNEuFVT+tJJ9CftqF5zRhrGR2N9aegskO3ZEnaVo/r9q
        4IYUM6FO4UGOfaEgdf9dfQu8j0P+hjaV7BDzBU/rTQN3L21Z+9DJpF1b2Qp7hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pzxcKLaqbW/YnK6A44TXbcRHAKldZUwWkJuYXKse4Sw=;
        b=H1wgvFBFYexfei46d8/8hmZHZ4O9rM3g64z+HEu6/4mgHdAqaOJLuVFyU24Mh5mAK1XIjY
        cD9QhWaNuJaUrYCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Fold seqcount_LOCKNAME_init() definition
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159603320522.4006.9469225700144649228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e4e9ab3f9f91ad3b88d12363f890e8ad9b59b645
Gitweb:        https://git.kernel.org/tip/e4e9ab3f9f91ad3b88d12363f890e8ad9b59b645
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Jul 2020 12:00:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:30 +02:00

seqlock: Fold seqcount_LOCKNAME_init() definition

Manual repetition is boring and error prone.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/seqlock.h | 61 +++++++++-------------------------------
 1 file changed, 14 insertions(+), 47 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 4b259bb..501ff47 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -143,12 +143,6 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 	__SEQ_LOCK(.lock	= (assoc_lock))				\
 }
 
-#define seqcount_locktype_init(s, assoc_lock)				\
-do {									\
-	seqcount_init(&(s)->seqcount);					\
-	__SEQ_LOCK((s)->lock = (assoc_lock));				\
-} while (0)
-
 /**
  * SEQCNT_SPINLOCK_ZERO - static initializer for seqcount_spinlock_t
  * @name:	Name of the seqcount_spinlock_t instance
@@ -158,14 +152,6 @@ do {									\
 	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
 
 /**
- * seqcount_spinlock_init - runtime initializer for seqcount_spinlock_t
- * @s:		Pointer to the seqcount_spinlock_t instance
- * @lock:	Pointer to the associated spinlock
- */
-#define seqcount_spinlock_init(s, lock)					\
-	seqcount_locktype_init(s, lock)
-
-/**
  * SEQCNT_RAW_SPINLOCK_ZERO - static initializer for seqcount_raw_spinlock_t
  * @name:	Name of the seqcount_raw_spinlock_t instance
  * @lock:	Pointer to the associated raw_spinlock
@@ -174,14 +160,6 @@ do {									\
 	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
 
 /**
- * seqcount_raw_spinlock_init - runtime initializer for seqcount_raw_spinlock_t
- * @s:		Pointer to the seqcount_raw_spinlock_t instance
- * @lock:	Pointer to the associated raw_spinlock
- */
-#define seqcount_raw_spinlock_init(s, lock)				\
-	seqcount_locktype_init(s, lock)
-
-/**
  * SEQCNT_RWLOCK_ZERO - static initializer for seqcount_rwlock_t
  * @name:	Name of the seqcount_rwlock_t instance
  * @lock:	Pointer to the associated rwlock
@@ -190,14 +168,6 @@ do {									\
 	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
 
 /**
- * seqcount_rwlock_init - runtime initializer for seqcount_rwlock_t
- * @s:		Pointer to the seqcount_rwlock_t instance
- * @lock:	Pointer to the associated rwlock
- */
-#define seqcount_rwlock_init(s, lock)					\
-	seqcount_locktype_init(s, lock)
-
-/**
  * SEQCNT_MUTEX_ZERO - static initializer for seqcount_mutex_t
  * @name:	Name of the seqcount_mutex_t instance
  * @lock:	Pointer to the associated mutex
@@ -206,14 +176,6 @@ do {									\
 	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
 
 /**
- * seqcount_mutex_init - runtime initializer for seqcount_mutex_t
- * @s:		Pointer to the seqcount_mutex_t instance
- * @lock:	Pointer to the associated mutex
- */
-#define seqcount_mutex_init(s, lock)					\
-	seqcount_locktype_init(s, lock)
-
-/**
  * SEQCNT_WW_MUTEX_ZERO - static initializer for seqcount_ww_mutex_t
  * @name:	Name of the seqcount_ww_mutex_t instance
  * @lock:	Pointer to the associated ww_mutex
@@ -222,15 +184,7 @@ do {									\
 	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
 
 /**
- * seqcount_ww_mutex_init - runtime initializer for seqcount_ww_mutex_t
- * @s:		Pointer to the seqcount_ww_mutex_t instance
- * @lock:	Pointer to the associated ww_mutex
- */
-#define seqcount_ww_mutex_init(s, lock)					\
-	seqcount_locktype_init(s, lock)
-
-/**
- * typedef seqcount_LOCKNAME_t - sequence counter with spinlock associated
+ * typedef seqcount_LOCKNAME_t - sequence counter with LOCKTYPR associated
  * @seqcount:	The real sequence counter
  * @lock:	Pointer to the associated spinlock
  *
@@ -240,6 +194,12 @@ do {									\
  * that the write side critical section is properly serialized.
  */
 
+/**
+ * seqcount_LOCKNAME_init() - runtime initializer for seqcount_LOCKNAME_t
+ * @s:		Pointer to the seqcount_LOCKNAME_t instance
+ * @lock:	Pointer to the associated LOCKTYPE
+ */
+
 /*
  * SEQCOUNT_LOCKTYPE() - Instantiate seqcount_LOCKNAME_t and helpers
  * @locktype:		actual typename
@@ -253,6 +213,13 @@ typedef struct seqcount_##lockname {					\
 	__SEQ_LOCK(locktype	*lock);					\
 } seqcount_##lockname##_t;						\
 									\
+static __always_inline void						\
+seqcount_##lockname##_init(seqcount_##lockname##_t *s, locktype *lock)	\
+{									\
+	seqcount_init(&s->seqcount);					\
+	__SEQ_LOCK(s->lock = lock);					\
+}									\
+									\
 static __always_inline seqcount_t *					\
 __seqcount_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 {									\
