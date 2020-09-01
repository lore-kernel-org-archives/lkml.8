Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F72CC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC92206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kmg8uZEi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M57fo9nM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgIAOR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgIALt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8361FC061261;
        Tue,  1 Sep 2020 04:48:08 -0700 (PDT)
Date:   Tue, 01 Sep 2020 11:48:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rciemh3iKmvHfk4tyOUH/IvurFwIl9kdvm5sIi6+HEs=;
        b=kmg8uZEiCni1AwKGVYcnB2Ri2wm8hbkTo0oB+BPlDNX+Xpi9r2DH+376fqmQ8f3VKlLoUb
        H/Y0hczl4SsMxhPZ4g2t7gDw2wsuPmcnF7WT2pAXoWaDtxppGLf4gzpWiKTZUqKm1aZZUQ
        IzAEghN4S6G8IPU4wZaun9ssSB3x4GIvxGx/hG0es1k2MvF4VAnGw1CxZu7xBkQWVpU75C
        Nu0L3Yha96p7m88Hvttu20YbnijH0znmDWF7nwa3uogcc4fKXxc/DA9C6kpWb7hEpij7fN
        JsRnw+wyVjCs5LE/Fxpk854HEsq6o3Ric/f7C31K5y2OC+3HIsAroim+ZxCbCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rciemh3iKmvHfk4tyOUH/IvurFwIl9kdvm5sIi6+HEs=;
        b=M57fo9nMt7JwR0uHOATAHe1ijt7QX1F2BNpJJWbBeZ3L0Y340H4dzYecVawKG5a1flcYtT
        280d+/Xl4iGM0ZCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] static_call: Add static_call_cond()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135805.042977182@infradead.org>
References: <20200818135805.042977182@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088411.20229.15185014010281928142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     452cddbff74b6a15b9354505671011700fe03710
Gitweb:        https://git.kernel.org/tip/452cddbff74b6a15b9354505671011700fe03710
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Aug 2020 15:57:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:05 +02:00

static_call: Add static_call_cond()

Extend the static_call infrastructure to optimize the following common
pattern:

	if (func_ptr)
		func_ptr(args...)

For the trampoline (which is in effect a tail-call), we patch the
JMP.d32 into a RET, which then directly consumes the trampoline call.

For the in-line sites we replace the CALL with a NOP5.

NOTE: this is 'obviously' limited to functions with a 'void' return type.

NOTE: DEFINE_STATIC_COND_CALL() only requires a typename, as opposed
      to a full function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20200818135805.042977182@infradead.org
---
 arch/x86/include/asm/static_call.h | 12 +++-
 arch/x86/kernel/static_call.c      | 42 ++++++++++----
 include/linux/static_call.h        | 86 +++++++++++++++++++++++++++++-
 3 files changed, 127 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 33469ae..c37f119 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -20,15 +20,21 @@
  * it does tail-call optimization on the call; since you cannot compute the
  * relative displacement across sections.
  */
-#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
+
+#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, insns)			\
 	asm(".pushsection .static_call.text, \"ax\"		\n"	\
 	    ".align 4						\n"	\
 	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
 	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
-	    "	.byte 0xe9 # jmp.d32				\n"	\
-	    "	.long " #func " - (. + 4)			\n"	\
+	    insns "						\n"	\
 	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
 	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
 	    ".popsection					\n")
 
+#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, ".byte 0xe9; .long " #func " - (. + 4)")
+
+#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; nop; nop; nop; nop")
+
 #endif /* _ASM_STATIC_CALL_H */
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 5ff2b63..ead6726 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -4,19 +4,41 @@
 #include <linux/bug.h>
 #include <asm/text-patching.h>
 
-static void __static_call_transform(void *insn, u8 opcode, void *func)
+enum insn_type {
+	CALL = 0, /* site call */
+	NOP = 1,  /* site cond-call */
+	JMP = 2,  /* tramp / site tail-call */
+	RET = 3,  /* tramp / site cond-tail-call */
+};
+
+static void __static_call_transform(void *insn, enum insn_type type, void *func)
 {
-	const void *code = text_gen_insn(opcode, insn, func);
+	int size = CALL_INSN_SIZE;
+	const void *code;
 
-	if (WARN_ONCE(*(u8 *)insn != opcode,
-		      "unexpected static call insn opcode 0x%x at %pS\n",
-		      opcode, insn))
-		return;
+	switch (type) {
+	case CALL:
+		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
+		break;
+
+	case NOP:
+		code = ideal_nops[NOP_ATOMIC5];
+		break;
+
+	case JMP:
+		code = text_gen_insn(JMP32_INSN_OPCODE, insn, func);
+		break;
+
+	case RET:
+		code = text_gen_insn(RET_INSN_OPCODE, insn, func);
+		size = RET_INSN_SIZE;
+		break;
+	}
 
-	if (memcmp(insn, code, CALL_INSN_SIZE) == 0)
+	if (memcmp(insn, code, size) == 0)
 		return;
 
-	text_poke_bp(insn, code, CALL_INSN_SIZE, NULL);
+	text_poke_bp(insn, code, size, NULL);
 }
 
 void arch_static_call_transform(void *site, void *tramp, void *func)
@@ -24,10 +46,10 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
 	mutex_lock(&text_mutex);
 
 	if (tramp)
-		__static_call_transform(tramp, JMP32_INSN_OPCODE, func);
+		__static_call_transform(tramp, func ? JMP : RET, func);
 
 	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
-		__static_call_transform(site, CALL_INSN_OPCODE, func);
+		__static_call_transform(site, func ? CALL : NOP, func);
 
 	mutex_unlock(&text_mutex);
 }
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 6f62ced..0f74581 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -16,7 +16,9 @@
  *
  *   DECLARE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL(name, func);
+ *   DEFINE_STATIC_CALL_NULL(name, typename);
  *   static_call(name)(args...);
+ *   static_call_cond(name)(args...);
  *   static_call_update(name, func);
  *
  * Usage example:
@@ -52,6 +54,43 @@
  *   rather than calling through the trampoline.  This requires objtool or a
  *   compiler plugin to detect all the static_call() sites and annotate them
  *   in the .static_call_sites section.
+ *
+ *
+ * Notes on NULL function pointers:
+ *
+ *   Static_call()s support NULL functions, with many of the caveats that
+ *   regular function pointers have.
+ *
+ *   Clearly calling a NULL function pointer is 'BAD', so too for
+ *   static_call()s (although when HAVE_STATIC_CALL it might not be immediately
+ *   fatal). A NULL static_call can be the result of:
+ *
+ *     DECLARE_STATIC_CALL_NULL(my_static_call, void (*)(int));
+ *
+ *   which is equivalent to declaring a NULL function pointer with just a
+ *   typename:
+ *
+ *     void (*my_func_ptr)(int arg1) = NULL;
+ *
+ *   or using static_call_update() with a NULL function. In both cases the
+ *   HAVE_STATIC_CALL implementation will patch the trampoline with a RET
+ *   instruction, instead of an immediate tail-call JMP. HAVE_STATIC_CALL_INLINE
+ *   architectures can patch the trampoline call to a NOP.
+ *
+ *   In all cases, any argument evaluation is unconditional. Unlike a regular
+ *   conditional function pointer call:
+ *
+ *     if (my_func_ptr)
+ *         my_func_ptr(arg1)
+ *
+ *   where the argument evaludation also depends on the pointer value.
+ *
+ *   When calling a static_call that can be NULL, use:
+ *
+ *     static_call_cond(name)(arg1);
+ *
+ *   which will include the required value tests to avoid NULL-pointer
+ *   dereferences.
  */
 
 #include <linux/types.h>
@@ -120,7 +159,16 @@ extern int static_call_text_reserved(void *start, void *end);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
+#define DEFINE_STATIC_CALL_NULL(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = NULL,						\
+		.type = 1,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
+
 #define static_call(name)	__static_call(name)
+#define static_call_cond(name)	(void)__static_call(name)
 
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
@@ -143,7 +191,15 @@ struct static_call_key {
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
+#define DEFINE_STATIC_CALL_NULL(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = NULL,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
+
 #define static_call(name)	__static_call(name)
+#define static_call_cond(name)	(void)__static_call(name)
 
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
@@ -179,9 +235,39 @@ struct static_call_key {
 		.func = _func,						\
 	}
 
+#define DEFINE_STATIC_CALL_NULL(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = NULL,						\
+	}
+
 #define static_call(name)						\
 	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
 
+static inline void __static_call_nop(void) { }
+
+/*
+ * This horrific hack takes care of two things:
+ *
+ *  - it ensures the compiler will only load the function pointer ONCE,
+ *    which avoids a reload race.
+ *
+ *  - it ensures the argument evaluation is unconditional, similar
+ *    to the HAVE_STATIC_CALL variant.
+ *
+ * Sadly current GCC/Clang (10 for both) do not optimize this properly
+ * and will emit an indirect call for the NULL case :-(
+ */
+#define __static_call_cond(name)					\
+({									\
+	void *func = READ_ONCE(STATIC_CALL_KEY(name).func);		\
+	if (!func)							\
+		func = &__static_call_nop;				\
+	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
+})
+
+#define static_call_cond(name)	(void)__static_call_cond(name)
+
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
