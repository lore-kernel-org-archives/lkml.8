Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F88C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D59B6207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I72VUFoU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wNfvxVGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgG2Od1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgG2Od0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75B0C061794;
        Wed, 29 Jul 2020 07:33:26 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:33:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XuDY3hYX886DHhEPf/c48l1PDk3msnewxEipZjXo9NE=;
        b=I72VUFoUEsx4vVng91NzWvvUSf4a5LenAQnxjRNsQlpS7ZN9hakcvIZLz2beZP23K68u4J
        SiNFmOy4Vf96TavtH/lcBJ1IASBecrHea5FVhZ88kmcKvrvLG44tSpyRUk4WX95AkDfhmW
        uQ3EG5CxyJc8jjZRWXaHpcwyCrbGVY475Twq+7Pg8K/PiXwAhLM20kUmaP4YSMm7Q+w2IP
        GyZHmHR3dxQOvdhJenYTj3BML2wsDa+tEBAjJSedHMa8iOjsrQeq6cS8zc1IHKWqVEWNY+
        TnhuPjL8vlONxWV/ogiezTRQpxZMvguc9fYMZqMYVfHy4q7i6a4ltlxDnLh9LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XuDY3hYX886DHhEPf/c48l1PDk3msnewxEipZjXo9NE=;
        b=wNfvxVGik0/jGoo/djFH7kuUhgnVwAxJwyMx8iO8322u1sJE0wEYI+MhdysUayfIHa8W6t
        EWkaeo68PprKXNDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqcount: Compress SEQCNT_LOCKNAME_ZERO()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159603320456.4006.7818916218148482555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0efc94c5d15c3da0a69543d86ad2180f39256ed6
Gitweb:        https://git.kernel.org/tip/0efc94c5d15c3da0a69543d86ad2180f39256ed6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Jul 2020 12:03:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:30 +02:00

seqcount: Compress SEQCNT_LOCKNAME_ZERO()

Less is more.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/seqlock.h | 63 +++++++++++-----------------------------
 1 file changed, 18 insertions(+), 45 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 501ff47..251dcd6 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -138,51 +138,6 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 #define __SEQ_LOCK(expr)
 #endif
 
-#define SEQCOUNT_LOCKTYPE_ZERO(seq_name, assoc_lock) {			\
-	.seqcount		= SEQCNT_ZERO(seq_name.seqcount),	\
-	__SEQ_LOCK(.lock	= (assoc_lock))				\
-}
-
-/**
- * SEQCNT_SPINLOCK_ZERO - static initializer for seqcount_spinlock_t
- * @name:	Name of the seqcount_spinlock_t instance
- * @lock:	Pointer to the associated spinlock
- */
-#define SEQCNT_SPINLOCK_ZERO(name, lock)				\
-	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-
-/**
- * SEQCNT_RAW_SPINLOCK_ZERO - static initializer for seqcount_raw_spinlock_t
- * @name:	Name of the seqcount_raw_spinlock_t instance
- * @lock:	Pointer to the associated raw_spinlock
- */
-#define SEQCNT_RAW_SPINLOCK_ZERO(name, lock)				\
-	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-
-/**
- * SEQCNT_RWLOCK_ZERO - static initializer for seqcount_rwlock_t
- * @name:	Name of the seqcount_rwlock_t instance
- * @lock:	Pointer to the associated rwlock
- */
-#define SEQCNT_RWLOCK_ZERO(name, lock)					\
-	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-
-/**
- * SEQCNT_MUTEX_ZERO - static initializer for seqcount_mutex_t
- * @name:	Name of the seqcount_mutex_t instance
- * @lock:	Pointer to the associated mutex
- */
-#define SEQCNT_MUTEX_ZERO(name, lock)					\
-	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-
-/**
- * SEQCNT_WW_MUTEX_ZERO - static initializer for seqcount_ww_mutex_t
- * @name:	Name of the seqcount_ww_mutex_t instance
- * @lock:	Pointer to the associated ww_mutex
- */
-#define SEQCNT_WW_MUTEX_ZERO(name, lock)				\
-	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
-
 /**
  * typedef seqcount_LOCKNAME_t - sequence counter with LOCKTYPR associated
  * @seqcount:	The real sequence counter
@@ -263,6 +218,24 @@ SEQCOUNT_LOCKTYPE(rwlock_t,		rwlock,		false,	s->lock)
 SEQCOUNT_LOCKTYPE(struct mutex,		mutex,		true,	s->lock)
 SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
 
+/**
+ * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
+ * @name:	Name of the seqcount_LOCKNAME_t instance
+ * @lock:	Pointer to the associated LOCKTYPE
+ */
+
+#define SEQCOUNT_LOCKTYPE_ZERO(seq_name, assoc_lock) {			\
+	.seqcount		= SEQCNT_ZERO(seq_name.seqcount),	\
+	__SEQ_LOCK(.lock	= (assoc_lock))				\
+}
+
+#define SEQCNT_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+#define SEQCNT_RAW_SPINLOCK_ZERO(name, lock)	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+#define SEQCNT_RWLOCK_ZERO(name, lock)		SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+#define SEQCNT_MUTEX_ZERO(name, lock)		SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+#define SEQCNT_WW_MUTEX_ZERO(name, lock) 	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
+
+
 #define __seqprop_case(s, lockname, prop)				\
 	seqcount_##lockname##_t: __seqcount_##lockname##_##prop((void *)(s))
 
