Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A62C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C4520882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dhVKATyq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tDP5e/b0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgIJT1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731419AbgIJPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B94C06134C;
        Thu, 10 Sep 2020 08:08:27 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:08:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599750505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VXlAMEQlQ/7yWi7KPpGqX8AqwvRcq3LnrgUlTuNVad4=;
        b=dhVKATyqF9+RppPF31jhZrCuKFR5brDDP9o+38a6culVXEZq6+VRebKmYwK1NTeMCmRHVC
        XlpM9R3Em5YDozkNKUBVQMNMVnubnpGomPOrk2uq4645OKSMLQyN5iwLSdY4Rm4gTZQbFs
        zwttJ04eFFOqfXSKLzYsxQKopTWjlExgbkONOQT7ZYNDf92qMrySaaftTDFIPbpU5OyFzy
        P/1FpkOHA7hFgE5fQ3dC1wsTVginyHuI2W8m9QGL03UVI2027C0KHAfEpMs2Hm/4Cpa86l
        E64DCOWX4btGNaN53tJV7Fzz9myEnUkZg27c7v10vKuG0uzM9v8rFQzhMSVV0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599750505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VXlAMEQlQ/7yWi7KPpGqX8AqwvRcq3LnrgUlTuNVad4=;
        b=tDP5e/b0DUUef+gdOn6QLlbogIR2xKUPNUVN33Bts1OzOlEeEgt0M47kgSbahhn2V6/OhI
        gl5LK5z0cQ7Ri+CQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Use unique prefix for seqcount_t
 property accessors
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200904153231.11994-3-a.darwish@linutronix.de>
References: <20200904153231.11994-3-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159975050505.20229.14341854260520683075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5cdd25572a29e46f932d3e6eedbd07429de66431
Gitweb:        https://git.kernel.org/tip/5cdd25572a29e46f932d3e6eedbd07429de66431
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Fri, 04 Sep 2020 17:32:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:30 +02:00

seqlock: Use unique prefix for seqcount_t property accessors

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200904153231.11994-3-a.darwish@linutronix.de
---
 include/linux/seqlock.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 820ace2..0b4a22f 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -157,7 +157,9 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  */
 
 /*
- * SEQCOUNT_LOCKNAME() - Instantiate seqcount_LOCKNAME_t and helpers
+ * SEQCOUNT_LOCKNAME()	- Instantiate seqcount_LOCKNAME_t and helpers
+ * seqprop_LOCKNAME_*()	- Property accessors for seqcount_LOCKNAME_t
+ *
  * @lockname:		"LOCKNAME" part of seqcount_LOCKNAME_t
  * @locktype:		LOCKNAME canonical C data type
  * @preemptible:	preemptibility of above lockname
@@ -177,19 +179,19 @@ seqcount_##lockname##_init(seqcount_##lockname##_t *s, locktype *lock)	\
 }									\
 									\
 static __always_inline seqcount_t *					\
-__seqcount_##lockname##_ptr(seqcount_##lockname##_t *s)			\
+__seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 {									\
 	return &s->seqcount;						\
 }									\
 									\
 static __always_inline bool						\
-__seqcount_##lockname##_preemptible(seqcount_##lockname##_t *s)		\
+__seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
 {									\
 	return preemptible;						\
 }									\
 									\
 static __always_inline void						\
-__seqcount_##lockname##_assert(seqcount_##lockname##_t *s)		\
+__seqprop_##lockname##_assert(const seqcount_##lockname##_t *s)		\
 {									\
 	__SEQ_LOCK(lockdep_assert_held(lockmember));			\
 }
@@ -198,17 +200,17 @@ __seqcount_##lockname##_assert(seqcount_##lockname##_t *s)		\
  * __seqprop() for seqcount_t
  */
 
-static inline seqcount_t *__seqcount_ptr(seqcount_t *s)
+static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
 {
 	return s;
 }
 
-static inline bool __seqcount_preemptible(seqcount_t *s)
+static inline bool __seqprop_preemptible(const seqcount_t *s)
 {
 	return false;
 }
 
-static inline void __seqcount_assert(seqcount_t *s)
+static inline void __seqprop_assert(const seqcount_t *s)
 {
 	lockdep_assert_preemption_disabled();
 }
@@ -237,10 +239,10 @@ SEQCOUNT_LOCKNAME(ww_mutex,	struct ww_mutex,	true,	&s->lock->base)
 #define SEQCNT_WW_MUTEX_ZERO(name, lock) 	SEQCOUNT_LOCKNAME_ZERO(name, lock)
 
 #define __seqprop_case(s, lockname, prop)				\
-	seqcount_##lockname##_t: __seqcount_##lockname##_##prop((void *)(s))
+	seqcount_##lockname##_t: __seqprop_##lockname##_##prop((void *)(s))
 
 #define __seqprop(s, prop) _Generic(*(s),				\
-	seqcount_t:		__seqcount_##prop((void *)(s)),		\
+	seqcount_t:		__seqprop_##prop((void *)(s)),		\
 	__seqprop_case((s),	raw_spinlock,	prop),			\
 	__seqprop_case((s),	spinlock,	prop),			\
 	__seqprop_case((s),	rwlock,		prop),			\
