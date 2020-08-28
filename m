Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC164C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A522080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vZkjjk8J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqZrJT3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgH1BHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1BHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:07:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47923C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 18:07:00 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598576818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iNNXSlfXZDxUzeu1VN6dH2yYhBohpnCB4yaxuullQIQ=;
        b=vZkjjk8JM9xIrW4/dn3cVQFw8P3/zvuoKEAlx+EguFj7HGcYp3gp4PUiBtTuZ+wCdRwZNe
        gaCxGBiaw/+BSeq064etwl+hCUf/yZ6EEYoLRUsDdTvo+880/AcguvnaGa5YJ99xCVI0rc
        5/tOQBkPd1FqYmDBIcJ28vPZjiOPLxmhZREidSF9exix6AsrgWBgV42JoO01ZjdncUwPl1
        cI2pfS6q14zL7sDAEe/JlQVi4WJCmVGKRkH8/GvWQEBCgzrmSxLCyAZjfRc1y3OatuaVjh
        XJfdbAQmwwJ+ksZzod9JgoJalgNsdFsJbgToNyKkWrW2aGQZTmujs6CzgBmM9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598576818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iNNXSlfXZDxUzeu1VN6dH2yYhBohpnCB4yaxuullQIQ=;
        b=aqZrJT3PWdLpg1FMScIRV7vjbnfmNUJ6f26kSVvDhTWe7hSUtXszGXr7LMsOBTHuYZJx4z
        BkPOP95psvmYTzDA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 2/5] seqlock: Use unique prefix for seqcount_t property accessors
Date:   Fri, 28 Aug 2020 03:07:07 +0200
Message-Id: <20200828010710.5407-3-a.darwish@linutronix.de>
In-Reply-To: <20200828010710.5407-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
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
seqcount_t or any of the seqcount_LOCKTYPE_t variants.

This is quite confusing, especially the first member where it is called
exactly the same in both groups.

Differentiate the first group by using "__seqcount_t_" as prefix. This
also conforms with the rest of seqlock.h naming conventions.

While at it, also constify the property accessors first parameter where
appropriate.

References: 55f3560df975 ("seqlock: Extend seqcount API with associated locks")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 598af597f74e..5470e9cd52ce 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -183,13 +183,13 @@ __seqcount_##locktype##_ptr(seqcount_##locktype##_t *s)			\
 }									\
 									\
 static __always_inline bool						\
-__seqcount_##locktype##_preemptible(seqcount_##locktype##_t *s)		\
+__seqcount_##locktype##_preemptible(const seqcount_##locktype##_t *s)	\
 {									\
 	return preemptible;						\
 }									\
 									\
 static __always_inline void						\
-__seqcount_##locktype##_assert(seqcount_##locktype##_t *s)		\
+__seqcount_##locktype##_assert(const seqcount_##locktype##_t *s)	\
 {									\
 	__SEQ_LOCK(lockdep_assert_held(lockmember));			\
 }
@@ -198,17 +198,17 @@ __seqcount_##locktype##_assert(seqcount_##locktype##_t *s)		\
  * __seqprop() for seqcount_t
  */
 
-static inline seqcount_t *__seqcount_ptr(seqcount_t *s)
+static inline seqcount_t *__seqcount_t_ptr(seqcount_t *s)
 {
 	return s;
 }
 
-static inline bool __seqcount_preemptible(seqcount_t *s)
+static inline bool __seqcount_t_preemptible(const seqcount_t *s)
 {
 	return false;
 }
 
-static inline void __seqcount_assert(seqcount_t *s)
+static inline void __seqcount_t_assert(const seqcount_t *s)
 {
 	lockdep_assert_preemption_disabled();
 }
@@ -236,12 +236,11 @@ SEQCOUNT_LOCKTYPE(ww_mutex,	struct ww_mutex,	true,	&s->lock->base)
 #define SEQCNT_MUTEX_ZERO(name, lock)		SEQCOUNT_LOCKTYPE_ZERO(name, lock)
 #define SEQCNT_WW_MUTEX_ZERO(name, lock) 	SEQCOUNT_LOCKTYPE_ZERO(name, lock)
 
-
 #define __seqprop_case(s, locktype, prop)				\
 	seqcount_##locktype##_t: __seqcount_##locktype##_##prop((void *)(s))
 
 #define __seqprop(s, prop) _Generic(*(s),				\
-	seqcount_t:		__seqcount_##prop((void *)(s)),		\
+	seqcount_t:		__seqcount_t_##prop((void *)(s)),	\
 	__seqprop_case((s),	raw_spinlock,	prop),			\
 	__seqprop_case((s),	spinlock,	prop),			\
 	__seqprop_case((s),	rwlock,		prop),			\
-- 
2.28.0

