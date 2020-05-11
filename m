Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C21C54E8F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6DF2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589229777;
	bh=hzvMaW2SSTvV/8f7MU63L7H08XB628Ws8TlF80gIhyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d6KvAQtjOHy95d3WNammk6SnNaz6kKCtmGJlPL5n/sI6G7ckrnOp2R8Pnx1ZABUEm
	 0c0A4ZfWn43ZD/MUkXtv1Fklm7eDe0JNL0yCpclEa9Pv0vJ5HxfP6jOnGBdJO8Nmn7
	 Jy4i1i7BNoghPjDUd0RNA5jOmE40K4EZvYGvXO3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbgEKUm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731852AbgEKUmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:53 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C560206A3;
        Mon, 11 May 2020 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229772;
        bh=hzvMaW2SSTvV/8f7MU63L7H08XB628Ws8TlF80gIhyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OLLeKPpf2Xf4ULx4PXN5k0XTyaJu19XbR+mDVmIw8ObnU4DzpQ63MpUhdYUV64QdQ
         KZ+t1fsSVWnqxw+NZX2nyhfBZTDJfA5BDtJbTAkA8xG48jrOaoGohZHRnOlXB//Kti
         drsJTd7uBrDryz3wVRhyYcrykPI+X/tz9UZWkoyY=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 12/18] READ_ONCE: Drop pointer qualifiers when reading from scalar types
Date:   Mon, 11 May 2020 21:41:44 +0100
Message-Id: <20200511204150.27858-13-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing a volatile-qualified pointer to READ_ONCE() is an absolute
trainwreck for code generation: the use of 'typeof()' to define a
temporary variable inside the macro means that the final evaluation in
macro scope ends up forcing a read back from the stack. When stack
protector is enabled (the default for arm64, at least), this causes
the compiler to vomit up all sorts of junk.

Unfortunately, dropping pointer qualifiers inside the macro poses quite
a challenge, especially since the pointed-to type is permitted to be an
aggregate, and this is relied upon by mm/ code accessing things like
'pmd_t'. Based on numerous hacks and discussions on the mailing list,
this is the best I've managed to come up with.

Introduce '__unqual_scalar_typeof()' which takes an expression and, if
the expression is an optionally qualified 8, 16, 32 or 64-bit scalar
type, evaluates to the unqualified type. Other input types, including
aggregates, remain unchanged. Hopefully READ_ONCE() on volatile aggregate
pointers isn't something we do on a fast-path.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/compiler.h       |  6 +++---
 include/linux/compiler_types.h | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index e1b839e42563..0caced170a8a 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -204,7 +204,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * atomicity or dependency ordering guarantees. Note that this may result
  * in tears!
  */
-#define __READ_ONCE(x)	(*(const volatile typeof(x) *)&(x))
+#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
 
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
@@ -212,10 +212,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	kcsan_check_atomic_read(__xp, sizeof(*__xp));			\
 	__kcsan_disable_current();					\
 	({								\
-		typeof(x) __x = __READ_ONCE(*__xp);			\
+		__unqual_scalar_typeof(x) __x = __READ_ONCE(*__xp);	\
 		__kcsan_enable_current();				\
 		smp_read_barrier_depends();				\
-		__x;							\
+		(typeof(x))__x;						\
 	});								\
 })
 
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e970f97a7fcb..6ed0612bc143 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -210,6 +210,32 @@ struct ftrace_likely_data {
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
+/*
+ * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
+ *			       non-scalar types unchanged.
+ *
+ * We build this out of a couple of helper macros in a vain attempt to
+ * help you keep your lunch down while reading it.
+ */
+#define __pick_scalar_type(x, type, otherwise)					\
+	__builtin_choose_expr(__same_type(x, type), (type)0, otherwise)
+
+/*
+ * 'char' is not type-compatible with either 'signed char' or 'unsigned char',
+ * so we include the naked type here as well as the signed/unsigned variants.
+ */
+#define __pick_integer_type(x, type, otherwise)					\
+	__pick_scalar_type(x, type,						\
+		__pick_scalar_type(x, unsigned type,				\
+			__pick_scalar_type(x, signed type, otherwise)))
+
+#define __unqual_scalar_typeof(x) typeof(					\
+	__pick_integer_type(x, char,						\
+		__pick_integer_type(x, short,					\
+			__pick_integer_type(x, int,				\
+				__pick_integer_type(x, long,			\
+					__pick_integer_type(x, long long, x))))))
+
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
 	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
-- 
2.26.2.645.ge9eca65c58-goog

