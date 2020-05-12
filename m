Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A4AC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4724206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgELOhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgELOhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:37:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE3CC061A0C;
        Tue, 12 May 2020 07:37:00 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYW1f-0005nH-V4; Tue, 12 May 2020 16:36:56 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8D3551C0475;
        Tue, 12 May 2020 16:36:55 +0200 (CEST)
Date:   Tue, 12 May 2020 14:36:55 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] locking/barriers: Use '__unqual_scalar_typeof'
 for load-acquire macros
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511204150.27858-14-will@kernel.org>
References: <20200511204150.27858-14-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158929421549.390.12460097997822377133.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     0229d80867ef27b3e41585a784d5f78695a58f95
Gitweb:        https://git.kernel.org/tip/0229d80867ef27b3e41585a784d5f78695a58f95
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 11 May 2020 21:41:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 11:04:15 +02:00

locking/barriers: Use '__unqual_scalar_typeof' for load-acquire macros

Passing volatile-qualified pointers to the asm-generic implementations of
the load-acquire macros results in a re-load from the stack due to the
temporary result variable inheriting the volatile semantics thanks to the
use of 'typeof()'.

Define these temporary variables using 'unqual_scalar_typeof' to drop
the volatile qualifier in the case that they are scalar types.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20200511204150.27858-14-will@kernel.org

---
 include/asm-generic/barrier.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 85b28eb..2eacaf7 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -128,10 +128,10 @@ do {									\
 #ifndef __smp_load_acquire
 #define __smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
+	__unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);		\
 	compiletime_assert_atomic_type(*p);				\
 	__smp_mb();							\
-	___p1;								\
+	(typeof(*p))___p1;						\
 })
 #endif
 
@@ -183,10 +183,10 @@ do {									\
 #ifndef smp_load_acquire
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
+	__unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);		\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
-	___p1;								\
+	(typeof(*p))___p1;						\
 })
 #endif
 
@@ -229,14 +229,14 @@ do {									\
 #ifndef smp_cond_load_relaxed
 #define smp_cond_load_relaxed(ptr, cond_expr) ({		\
 	typeof(ptr) __PTR = (ptr);				\
-	typeof(*ptr) VAL;					\
+	__unqual_scalar_typeof(*ptr) VAL;			\
 	for (;;) {						\
 		VAL = READ_ONCE(*__PTR);			\
 		if (cond_expr)					\
 			break;					\
 		cpu_relax();					\
 	}							\
-	VAL;							\
+	(typeof(*ptr))VAL;					\
 })
 #endif
 
@@ -250,10 +250,10 @@ do {									\
  */
 #ifndef smp_cond_load_acquire
 #define smp_cond_load_acquire(ptr, cond_expr) ({		\
-	typeof(*ptr) _val;					\
+	__unqual_scalar_typeof(*ptr) _val;			\
 	_val = smp_cond_load_relaxed(ptr, cond_expr);		\
 	smp_acquire__after_ctrl_dep();				\
-	_val;							\
+	(typeof(*ptr))_val;					\
 })
 #endif
 
