Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA22C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB3C22CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EPvgIDG4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E+EEEr90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgG2OfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgG2Od2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B455C061794;
        Wed, 29 Jul 2020 07:33:28 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:33:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033207;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=W+LO8S02e6ATM8Kauoun2lP4TdXfzKA5Qwi6t91T4tU=;
        b=EPvgIDG4UlYhD8bu+eiOJM27Mp8RojPjb2dZpt9kiV6Yw8rL4At2PkFe8pXS8QtxRI7NtZ
        k7AU0lcW4JpnJ4jflb08wqzM0ZbnZGbfuImCo5UL6RT2GV00dV5eN0JrFHymZjhPrMZQMg
        vJV1LaR86mztM+jKBDYJDe9rTLAfTVe/zqlVXlHaQEaeRenRtUz+Nzh5dqhnWjfZXKdhSW
        9KHS5KJUnB/2flHjwNc0CQYT6GNXZYC3r1oYo8hGA2pHzfTVndjGlEusXjdQ6Xh4/NBter
        lnWxdLORAaF1beZ8DBtVvkfvyZDo/graNLAZLR0Mmx9kYDFZXEAZvdhBQT3FyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033207;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=W+LO8S02e6ATM8Kauoun2lP4TdXfzKA5Qwi6t91T4tU=;
        b=E+EEEr90NSHOfp30P0TO1comVPOuJKjv1bvZ5Ll+gggUgPzIDBx9a5K61cQThjU+x1aJPu
        PdMj7ngp6uK+0jBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: s/__SEQ_LOCKDEP/__SEQ_LOCK/g
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159603320649.4006.16915985526825590187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e55687fe5c1e4849e5559a0a49199c9ca3fff36e
Gitweb:        https://git.kernel.org/tip/e55687fe5c1e4849e5559a0a49199c9ca3fff36e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Jul 2020 11:56:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:29 +02:00

seqlock: s/__SEQ_LOCKDEP/__SEQ_LOCK/g

__SEQ_LOCKDEP() is an expression gate for the
seqcount_LOCKNAME_t::lock member. Rename it to be about the member,
not the gate condition.

Later (PREEMPT_RT) patches will make the member available for !LOCKDEP
configs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/seqlock.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index b487299..c689aba 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -133,20 +133,20 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  */
 
 #ifdef CONFIG_LOCKDEP
-#define __SEQ_LOCKDEP(expr)	expr
+#define __SEQ_LOCK(expr)	expr
 #else
-#define __SEQ_LOCKDEP(expr)
+#define __SEQ_LOCK(expr)
 #endif
 
 #define SEQCOUNT_LOCKTYPE_ZERO(seq_name, assoc_lock) {			\
 	.seqcount		= SEQCNT_ZERO(seq_name.seqcount),	\
-	__SEQ_LOCKDEP(.lock	= (assoc_lock))				\
+	__SEQ_LOCK(.lock	= (assoc_lock))				\
 }
 
 #define seqcount_locktype_init(s, assoc_lock)				\
 do {									\
 	seqcount_init(&(s)->seqcount);					\
-	__SEQ_LOCKDEP((s)->lock = (assoc_lock));			\
+	__SEQ_LOCK((s)->lock = (assoc_lock));				\
 } while (0)
 
 /**
@@ -161,7 +161,7 @@ do {									\
  */
 typedef struct seqcount_spinlock {
 	seqcount_t	seqcount;
-	__SEQ_LOCKDEP(spinlock_t	*lock);
+	__SEQ_LOCK(spinlock_t	*lock);
 } seqcount_spinlock_t;
 
 /**
@@ -192,7 +192,7 @@ typedef struct seqcount_spinlock {
  */
 typedef struct seqcount_raw_spinlock {
 	seqcount_t      seqcount;
-	__SEQ_LOCKDEP(raw_spinlock_t	*lock);
+	__SEQ_LOCK(raw_spinlock_t	*lock);
 } seqcount_raw_spinlock_t;
 
 /**
@@ -223,7 +223,7 @@ typedef struct seqcount_raw_spinlock {
  */
 typedef struct seqcount_rwlock {
 	seqcount_t      seqcount;
-	__SEQ_LOCKDEP(rwlock_t		*lock);
+	__SEQ_LOCK(rwlock_t		*lock);
 } seqcount_rwlock_t;
 
 /**
@@ -257,7 +257,7 @@ typedef struct seqcount_rwlock {
  */
 typedef struct seqcount_mutex {
 	seqcount_t      seqcount;
-	__SEQ_LOCKDEP(struct mutex	*lock);
+	__SEQ_LOCK(struct mutex	*lock);
 } seqcount_mutex_t;
 
 /**
@@ -291,7 +291,7 @@ typedef struct seqcount_mutex {
  */
 typedef struct seqcount_ww_mutex {
 	seqcount_t      seqcount;
-	__SEQ_LOCKDEP(struct ww_mutex	*lock);
+	__SEQ_LOCK(struct ww_mutex	*lock);
 } seqcount_ww_mutex_t;
 
 /**
@@ -329,7 +329,7 @@ __seqcount_##locktype##_preemptible(seqcount_##locktype##_t *s)		\
 static inline void							\
 __seqcount_##locktype##_assert(seqcount_##locktype##_t *s)		\
 {									\
-	__SEQ_LOCKDEP(lockdep_assert_held(lockmember));			\
+	__SEQ_LOCK(lockdep_assert_held(lockmember));			\
 }
 
 /*
