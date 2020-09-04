Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43C8C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29FF2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLzyzlMf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fHh5xmSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIDPca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:32:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33728 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgIDPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:32:16 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599233533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5xKGogf2jBVbNZKgg8XxOTzz40y6C5I533fxnyVr5Q=;
        b=NLzyzlMfwnEkQyVqWxqrJDkvCIRv28z3J0R8/WHnRQfIDkaiTVZRArlAlIwZQ1XN2oCK0a
        RCiVcR0q4+bK4+/fn4WjkPetc0muQibd4NOpIdzNVDTfYDggU93D1Ui/UpTvekMDRzOHMO
        Dp6jEgaWHmU+h8SXgVPwdF01MYUDVG4dXWDjPGZpBzYF1uQHEUA/ypFSdqwjgp9j+/QPlK
        8VXleGPUBf1mFMlcraoSt+A+2aCGTP+q+4qt1ZkryBj1k/l/Ot/ffTJYZ7wEb8noqrjpgC
        HojS7afa4A8zV4erUMFmsJIH87KdlIVBuBLrKDfKSI1g0T21GMWERNOL9laQxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599233533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5xKGogf2jBVbNZKgg8XxOTzz40y6C5I533fxnyVr5Q=;
        b=fHh5xmSwZpKu67Km5unTGgh5R4xJmzbraM2YEFPoepTiZEoLVpdIfDiVJlSZCez/seZjcH
        jqZb3cObc5s/pSDw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v2 2/5] seqlock: Use unique prefix for seqcount_t property accessors
Date:   Fri,  4 Sep 2020 17:32:28 +0200
Message-Id: <20200904153231.11994-3-a.darwish@linutronix.de>
In-Reply-To: <20200904153231.11994-1-a.darwish@linutronix.de>
References: <20200904153231.11994-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At seqlock.h, the following set of functions:

    - __seqcount_ptr()
    - __seqcount_preemptible()
    - __seqcount_assert()

act as plain seqcount_t "property" accessors. Meanwhile, the following
group:

    - __seqcount_ptr()
    - __seqcount_lock_preemptible()
    - __seqcount_assert_lock_held()

act as the equivalent set, but in the generic form, taking either
seqcount_t or any of the seqcount_LOCKNAME_t variants.

This is quite confusing, especially the first member where it is called
exactly the same in both groups.

Differentiate the first group by using "__seqprop" as prefix, and also
use that same prefix for all of seqcount_LOCKNAME_t property accessors.

While at it, constify the property accessors first parameter when
appropriate.

References: 55f3560df975 ("seqlock: Extend seqcount API with associated locks")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 4f219df659b1..96198da7debc 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -157,7 +157,9 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  */
 
 /*
- * SEQCOUNT_LOCKNAME() - Instantiate seqcount_LOCKNAME_t and helpers
+ * SEQCOUNT_LOCKNAME()           - Instantiate seqcount_LOCKNAME_t and helpers
+ * seqprop_seqcount_LOCKNAME_*() - Property accessors for seqcount_LOCKNAME_t
+ *
  * @lockname:		"LOCKNAME" part of seqcount_LOCKNAME_t
  * @locktype:		LOCKNAME canonical C data type
  * @preemptible:	preemptibility of above lockname
@@ -177,19 +179,19 @@ seqcount_##lockname##_init(seqcount_##lockname##_t *s, locktype *lock)	\
 }									\
 									\
 static __always_inline seqcount_t *					\
-__seqcount_##lockname##_ptr(seqcount_##lockname##_t *s)			\
+__seqprop_seqcount_##lockname##_ptr(seqcount_##lockname##_t *s)		\
 {									\
 	return &s->seqcount;						\
 }									\
 									\
 static __always_inline bool						\
-__seqcount_##lockname##_preemptible(seqcount_##lockname##_t *s)		\
+__seqprop_seqcount_##lockname##_preemptible(const seqcount_##lockname##_t *s)\
 {									\
 	return preemptible;						\
 }									\
 									\
 static __always_inline void						\
-__seqcount_##lockname##_assert(seqcount_##lockname##_t *s)		\
+__seqprop_seqcount_##lockname##_assert(const seqcount_##lockname##_t *s)\
 {									\
 	__SEQ_LOCK(lockdep_assert_held(lockmember));			\
 }
@@ -198,17 +200,17 @@ __seqcount_##lockname##_assert(seqcount_##lockname##_t *s)		\
  * __seqprop() for seqcount_t
  */
 
-static inline seqcount_t *__seqcount_ptr(seqcount_t *s)
+static inline seqcount_t *__seqprop_seqcount_ptr(seqcount_t *s)
 {
 	return s;
 }
 
-static inline bool __seqcount_preemptible(seqcount_t *s)
+static inline bool __seqprop_seqcount_preemptible(const seqcount_t *s)
 {
 	return false;
 }
 
-static inline void __seqcount_assert(seqcount_t *s)
+static inline void __seqprop_seqcount_assert(const seqcount_t *s)
 {
 	lockdep_assert_preemption_disabled();
 }
@@ -237,10 +239,10 @@ SEQCOUNT_LOCKNAME(ww_mutex,	struct ww_mutex,	true,	&s->lock->base)
 #define SEQCNT_WW_MUTEX_ZERO(name, lock) 	SEQCOUNT_LOCKNAME_ZERO(name, lock)
 
 #define __seqprop_case(s, lockname, prop)				\
-	seqcount_##lockname##_t: __seqcount_##lockname##_##prop((void *)(s))
+	seqcount_##lockname##_t: __seqprop_seqcount_##lockname##_##prop((void *)(s))
 
 #define __seqprop(s, prop) _Generic(*(s),				\
-	seqcount_t:		__seqcount_##prop((void *)(s)),		\
+	seqcount_t:		__seqprop_seqcount_##prop((void *)(s)),	\
 	__seqprop_case((s),	raw_spinlock,	prop),			\
 	__seqprop_case((s),	spinlock,	prop),			\
 	__seqprop_case((s),	rwlock,		prop),			\
-- 
2.28.0

