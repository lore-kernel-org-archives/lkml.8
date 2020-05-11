Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56466C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F19620661
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589229791;
	bh=FflFqiph+WZlaKnd5UBEHJ5vRO3iUzWcn5PVAjl+C6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iDNNF2ZqUqt8GwLg5PCpqTkFNEFenUM4cku5XpNNuc0DAsS4BNH37eDJoXlWh2n5M
	 DZCk2PA6TJU8QISL5BhhRP6AhlMH3b5yv6p+wV1Gpytv+oBk3H1UP896etg3WojRZp
	 Y6cIuPT1vtb/OFLfcJiLiHcqo2rxd9Q7rogg2f/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbgEKUm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731867AbgEKUmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:54 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDF03208D5;
        Mon, 11 May 2020 20:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229774;
        bh=FflFqiph+WZlaKnd5UBEHJ5vRO3iUzWcn5PVAjl+C6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoBCCEuHyUXBwosjY7pxKL7MDIgzkhPNM4ZQb9TJSIWn8i1vD4dLDGmaFtHmG3uzi
         j3h+yTsCTqEgY/Mfbq+4wVOti6VCmcGFE24+v9YONl45JJlRxaVuGqUJYCatcgOzPK
         MDeKqL+KqQa9G/3WBwHMNthRHW0dItS5tpCDSZd8=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 13/18] locking/barriers: Use '__unqual_scalar_typeof' for load-acquire macros
Date:   Mon, 11 May 2020 21:41:45 +0100
Message-Id: <20200511204150.27858-14-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing volatile-qualified pointers to the asm-generic implementations of
the load-acquire macros results in a re-load from the stack due to the
temporary result variable inheriting the volatile semantics thanks to the
use of 'typeof()'.

Define these temporary variables using 'unqual_scalar_typeof' to drop
the volatile qualifier in the case that they are scalar types.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/barrier.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 85b28eb80b11..2eacaf7d62f6 100644
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
 
-- 
2.26.2.645.ge9eca65c58-goog

