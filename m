Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12FCC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9861420721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578675425;
	bh=0k7VgPScxJeX9whj0Bu0g5XbpteKzsxBW68Oja5cOvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W+bFVp6WcXytYuJ9iHqCrJkbHl8/NOZ5t1KxkiVlMhNdicdB3mvYejzhpH9shC3cU
	 x7WaxJ0Izgt9qmSxFgwBqhiWhF6fka5lUoxvqwTPTXToffElaq0ODJKpcelwuc1NoE
	 y9I122ZtQ8yusZHmIHOXbR0f0lWsLVsEuGBmQ83g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgAJQ5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728811AbgAJQ5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:57:02 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93EAD20673;
        Fri, 10 Jan 2020 16:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578675421;
        bh=0k7VgPScxJeX9whj0Bu0g5XbpteKzsxBW68Oja5cOvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CszWS772nS7OJBIqH9FPMIq/C4RcfcJFkE1tZY3d+CvUZPiCnwlFju7o4pQ0CwNgQ
         NoMcGkbxY3WVuLMdJQWLL7JbK0P73nVA0essiXtjjCtvOhAvTH9AT/gYzOe0ksXIei
         UK0ZVmTD2xD5g90es6okkdLAOSofWywX/+XNLl2Y=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 8/8] arm64: barrier: Use '__unqual_scalar_typeof' for acquire/release macros
Date:   Fri, 10 Jan 2020 16:56:36 +0000
Message-Id: <20200110165636.28035-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
References: <20200110165636.28035-1-will@kernel.org>
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

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
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
2.25.0.rc1.283.g88dfdc4193-goog

