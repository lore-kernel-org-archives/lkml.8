Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC0BC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A7A20752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589229781;
	bh=MsXDoRW4QQuYfoU20QPS/5DN0hxByqMnH2Le+nmgh9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LJIkieYK/4xOH8zpGhILVnTGxCLX9Ny2hHmkSUgGh13YSMtiZLkFvkk9/OKK9/5Cz
	 HO6nxINdVvNiD1zyIRVHrWxcAhZLu+3Ef6A6p7Tb3zh0Hc7Ss/Ke/1m/PxuMEyet5D
	 lggLhPwQJR0CLVjHn+PfRgEVz5KYUCPbd3/Rends=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbgEKUnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731878AbgEKUm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:56 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B21720661;
        Mon, 11 May 2020 20:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229775;
        bh=MsXDoRW4QQuYfoU20QPS/5DN0hxByqMnH2Le+nmgh9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q35aAc4L7LgaVe2Ko6nA4e5fryYOtzAABtX/5MjjzuSzTLofLnGoOxXydGkqzuRO4
         4XAAjm8FWhlnWCZWyIsCqVE232qpMSB5XM/bS3uW+zwZ5RaigSjNXcSlCAxuoYRmfv
         NZlX+cQgEfltNFETru9Mswx0GmBiEMRsUkJ22GIQ=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 14/18] arm64: barrier: Use '__unqual_scalar_typeof' for acquire/release macros
Date:   Mon, 11 May 2020 21:41:46 +0100
Message-Id: <20200511204150.27858-15-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing volatile-qualified pointers to the arm64 implementations of the
load-acquire/store-release macros results in a re-load from the stack
and a bunch of associated stack-protector churn due to the temporary
result variable inheriting the volatile semantics thanks to the use of
'typeof()'.

Define these temporary variables using 'unqual_scalar_typeof' to drop
the volatile qualifier in the case that they are scalar types.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/barrier.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 7d9cc5ec4971..fb4c27506ef4 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -76,8 +76,8 @@ static inline unsigned long array_index_mask_nospec(unsigned long idx,
 #define __smp_store_release(p, v)					\
 do {									\
 	typeof(p) __p = (p);						\
-	union { typeof(*p) __val; char __c[1]; } __u =			\
-		{ .__val = (__force typeof(*p)) (v) };			\
+	union { __unqual_scalar_typeof(*p) __val; char __c[1]; } __u =	\
+		{ .__val = (__force __unqual_scalar_typeof(*p)) (v) };	\
 	compiletime_assert_atomic_type(*p);				\
 	kasan_check_write(__p, sizeof(*p));				\
 	switch (sizeof(*p)) {						\
@@ -110,7 +110,7 @@ do {									\
 
 #define __smp_load_acquire(p)						\
 ({									\
-	union { typeof(*p) __val; char __c[1]; } __u;			\
+	union { __unqual_scalar_typeof(*p) __val; char __c[1]; } __u;	\
 	typeof(p) __p = (p);						\
 	compiletime_assert_atomic_type(*p);				\
 	kasan_check_read(__p, sizeof(*p));				\
@@ -136,33 +136,33 @@ do {									\
 			: "Q" (*__p) : "memory");			\
 		break;							\
 	}								\
-	__u.__val;							\
+	(typeof(*p))__u.__val;						\
 })
 
 #define smp_cond_load_relaxed(ptr, cond_expr)				\
 ({									\
 	typeof(ptr) __PTR = (ptr);					\
-	typeof(*ptr) VAL;						\
+	__unqual_scalar_typeof(*ptr) VAL;				\
 	for (;;) {							\
 		VAL = READ_ONCE(*__PTR);				\
 		if (cond_expr)						\
 			break;						\
 		__cmpwait_relaxed(__PTR, VAL);				\
 	}								\
-	VAL;								\
+	(typeof(*ptr))VAL;						\
 })
 
 #define smp_cond_load_acquire(ptr, cond_expr)				\
 ({									\
 	typeof(ptr) __PTR = (ptr);					\
-	typeof(*ptr) VAL;						\
+	__unqual_scalar_typeof(*ptr) VAL;				\
 	for (;;) {							\
 		VAL = smp_load_acquire(__PTR);				\
 		if (cond_expr)						\
 			break;						\
 		__cmpwait_relaxed(__PTR, VAL);				\
 	}								\
-	VAL;								\
+	(typeof(*ptr))VAL;						\
 })
 
 #include <asm-generic/barrier.h>
-- 
2.26.2.645.ge9eca65c58-goog

