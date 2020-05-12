Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B657AC54E8F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9265F2137B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgELOhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730381AbgELOhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:37:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D777DC061A0C;
        Tue, 12 May 2020 07:37:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYW1g-0005nm-Be; Tue, 12 May 2020 16:36:56 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EB8141C02FC;
        Tue, 12 May 2020 16:36:55 +0200 (CEST)
Date:   Tue, 12 May 2020 14:36:55 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511204150.27858-13-will@kernel.org>
References: <20200511204150.27858-13-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158929421588.390.634536033679985583.tip-bot2@tip-bot2>
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

Commit-ID:     7b364f0949ae2dd205d5e9afa4b82ee17030d928
Gitweb:        https://git.kernel.org/tip/7b364f0949ae2dd205d5e9afa4b82ee17030d928
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 11 May 2020 21:41:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 11:04:14 +02:00

READ_ONCE: Drop pointer qualifiers when reading from scalar types

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

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20200511204150.27858-13-will@kernel.org

---
 include/linux/compiler.h       |  6 +++---
 include/linux/compiler_types.h | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 733605f..548294e 100644
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
index e970f97..6ed0612 100644
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
