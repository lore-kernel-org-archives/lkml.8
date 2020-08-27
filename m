Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86B5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2A520825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="skE3NEeP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3AvQcN9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgH0H4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:56:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36668 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgH0Hy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:27 -0400
Date:   Thu, 27 Aug 2020 07:54:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYQQtXOFwo/FnJTzFjXfsGesTri4WbONWXo8+yKYZ7o=;
        b=skE3NEePSFLxg1Tl6mpcMoGye3q2YLnglgpSUIMMjHklq6mjc61+RQ/NNJO+kKh7BUcX89
        rck00zku+Di7syyaEPdF/dC7oE7A9sQUKAtr5y5svKQV1nsqGOYifpWlimirk6XX5k7c/u
        Bt4PDu6pMJO43fpsH2CttQRqWxgHL9hHSz2HUxXcL2FoTTOkAZY9HjYCURj7CSvSvQtvlQ
        YS3ZqPAWogr2xx82uouSfw4Ml9e6qxe0/yNNysjrQwB12uPeI+Mfe3+sbgwU9HIU8W0Grv
        /Jq/qw+4IoemW7nszGCv02X8dvDJGja1/vnpSeKtez4bIi4togQrRh+pqlqT+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYQQtXOFwo/FnJTzFjXfsGesTri4WbONWXo8+yKYZ7o=;
        b=3AvQcN9bM4lYM77cUKPHKp+6ToUzX6X6m+TGVm9i/3Ga/vszcTd+KMFMXLFim6O1Tiyx7p
        eHqSLv/+gzau0NAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/refcount: Provide __refcount API to
 obtain the old value
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200729111120.GA2638@hirez.programming.kicks-ass.net>
References: <20200729111120.GA2638@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159851486357.20229.16363998255260125178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a435b9a14356587cf512ea6473368a579373c74c
Gitweb:        https://git.kernel.org/tip/a435b9a14356587cf512ea6473368a579373c74c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 29 Jul 2020 13:00:57 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:02 +02:00

locking/refcount: Provide __refcount API to obtain the old value

David requested means to obtain the old/previous value from the
refcount API for tracing purposes.

Duplicate (most of) the API as __refcount*() with an additional
'int *' argument into which, if !NULL, the old value will be stored.

Requested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200729111120.GA2638@hirez.programming.kicks-ass.net
---
 include/linux/refcount.h | 65 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 8 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 0e3ee25..7fabb1a 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -165,7 +165,7 @@ static inline unsigned int refcount_read(const refcount_t *r)
  *
  * Return: false if the passed refcount is 0, true otherwise
  */
-static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
+static inline __must_check bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
 {
 	int old = refcount_read(r);
 
@@ -174,12 +174,20 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
 			break;
 	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
 
+	if (oldp)
+		*oldp = old;
+
 	if (unlikely(old < 0 || old + i < 0))
 		refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
 
 	return old;
 }
 
+static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
+{
+	return __refcount_add_not_zero(i, r, NULL);
+}
+
 /**
  * refcount_add - add a value to a refcount
  * @i: the value to add to the refcount
@@ -196,16 +204,24 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
  * cases, refcount_inc(), or one of its variants, should instead be used to
  * increment a reference count.
  */
-static inline void refcount_add(int i, refcount_t *r)
+static inline void __refcount_add(int i, refcount_t *r, int *oldp)
 {
 	int old = atomic_fetch_add_relaxed(i, &r->refs);
 
+	if (oldp)
+		*oldp = old;
+
 	if (unlikely(!old))
 		refcount_warn_saturate(r, REFCOUNT_ADD_UAF);
 	else if (unlikely(old < 0 || old + i < 0))
 		refcount_warn_saturate(r, REFCOUNT_ADD_OVF);
 }
 
+static inline void refcount_add(int i, refcount_t *r)
+{
+	__refcount_add(i, r, NULL);
+}
+
 /**
  * refcount_inc_not_zero - increment a refcount unless it is 0
  * @r: the refcount to increment
@@ -219,9 +235,14 @@ static inline void refcount_add(int i, refcount_t *r)
  *
  * Return: true if the increment was successful, false otherwise
  */
+static inline __must_check bool __refcount_inc_not_zero(refcount_t *r, int *oldp)
+{
+	return __refcount_add_not_zero(1, r, oldp);
+}
+
 static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
 {
-	return refcount_add_not_zero(1, r);
+	return __refcount_inc_not_zero(r, NULL);
 }
 
 /**
@@ -236,9 +257,14 @@ static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
  * Will WARN if the refcount is 0, as this represents a possible use-after-free
  * condition.
  */
+static inline void __refcount_inc(refcount_t *r, int *oldp)
+{
+	__refcount_add(1, r, oldp);
+}
+
 static inline void refcount_inc(refcount_t *r)
 {
-	refcount_add(1, r);
+	__refcount_inc(r, NULL);
 }
 
 /**
@@ -261,10 +287,13 @@ static inline void refcount_inc(refcount_t *r)
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
-static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
+static inline __must_check bool __refcount_sub_and_test(int i, refcount_t *r, int *oldp)
 {
 	int old = atomic_fetch_sub_release(i, &r->refs);
 
+	if (oldp)
+		*oldp = old;
+
 	if (old == i) {
 		smp_acquire__after_ctrl_dep();
 		return true;
@@ -276,6 +305,11 @@ static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
 	return false;
 }
 
+static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
+{
+	return __refcount_sub_and_test(i, r, NULL);
+}
+
 /**
  * refcount_dec_and_test - decrement a refcount and test if it is 0
  * @r: the refcount
@@ -289,9 +323,14 @@ static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
+static inline __must_check bool __refcount_dec_and_test(refcount_t *r, int *oldp)
+{
+	return __refcount_sub_and_test(1, r, oldp);
+}
+
 static inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
-	return refcount_sub_and_test(1, r);
+	return __refcount_dec_and_test(r, NULL);
 }
 
 /**
@@ -304,12 +343,22 @@ static inline __must_check bool refcount_dec_and_test(refcount_t *r)
  * Provides release memory ordering, such that prior loads and stores are done
  * before.
  */
-static inline void refcount_dec(refcount_t *r)
+static inline void __refcount_dec(refcount_t *r, int *oldp)
 {
-	if (unlikely(atomic_fetch_sub_release(1, &r->refs) <= 1))
+	int old = atomic_fetch_sub_release(1, &r->refs);
+
+	if (oldp)
+		*oldp = old;
+
+	if (unlikely(old <= 1))
 		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
 }
 
+static inline void refcount_dec(refcount_t *r)
+{
+	__refcount_dec(r, NULL);
+}
+
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
 extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock);
