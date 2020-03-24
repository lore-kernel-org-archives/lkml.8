Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A984C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DA920789
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TCVYQNsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgCXOZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:25:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53654 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgCXOYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VPQomJJLBbpBHwTU7FaAjpr7uF55pgGc/ipgi+cCgsw=; b=TCVYQNsacP7xmPKn0oGFtxkGin
        xpfu2558ioQZXlEWTd61LZ4l/JEqk+JdTt3BLEblLz9HtmNsY+I949doCtzfYcX4e18qy5TnwGppZ
        MrTw3ctUxpKoFDEMI6juPDfF5yQ1MGEIE3tJ9GEk24+oT/IpkIeJ1W1eM4NJV6WhXcui+LnmEnHP8
        /u1KBL2Syd4otrcfhLv0NsiWLo4hKWazxmrQNuwGxxuVfueqzYKMuiqfl93UUvEWddwid7Y7QCVqy
        RzZVdD5V+jl31v/FBqWb41cL8LJWF100bltyO4PYwb3Z5e8C0j/v0GTbFfhKuyH+GOT2kgFIVMExD
        yMmuhWyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGkTv-0003os-JX; Tue, 24 Mar 2020 14:24:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8705430796C;
        Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2B9C7286C13BB; Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Message-Id: <20200324142246.127013582@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 14:56:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [RESEND][PATCH v3 14/17] static_call: Add static_cond_call()
References: <20200324135603.483964896@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the static_call infrastructure to optimize the following common
pattern:

	if (func_ptr)
		func_ptr(args...)

For the trampoline (which is in effect a tail-call), we patch the
JMP.d32 into a RET, which then directly consumes the trampoline call.

For the in-line sites we replace the CALL with a NOP5.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/static_call.h |   10 ++++++++
 arch/x86/kernel/static_call.c      |   42 ++++++++++++++++++++++++++++---------
 include/linux/static_call.h        |   29 +++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -32,4 +32,14 @@
 	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
 	    ".popsection					\n")
 
+#define ARCH_DEFINE_STATIC_CALL_RETTRAMP(name)				\
+	asm(".pushsection .static_call.text, \"ax\"		\n"	\
+	    ".align 4						\n"	\
+	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
+	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
+	    "	ret; nop; nop; nop; nop;			\n"	\
+	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
+	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
+	    ".popsection					\n")
+
 #endif /* _ASM_STATIC_CALL_H */
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -4,19 +4,41 @@
 #include <linux/bug.h>
 #include <asm/text-patching.h>
 
-static void __static_call_transform(void *insn, u8 opcode, void *func)
+enum insn_type {
+	call = 0, /* site call */
+	nop = 1,  /* site cond-call */
+	jmp = 2,  /* tramp / site tail-call */
+	ret = 3,  /* tramp / site cond-tail-call */
+};
+
+static void __static_call_transform(void *insn, enum insn_type type, void *func)
 {
-	const void *code = text_gen_insn(opcode, (long)insn, (long)func);
+	int size = CALL_INSN_SIZE;
+	const void *code;
 
-	if (WARN_ONCE(*(u8 *)insn != opcode,
-		      "unexpected static call insn opcode 0x%x at %pS\n",
-		      opcode, insn))
-		return;
+	switch (type) {
+	case call:
+		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
+		break;
+
+	case nop:
+		code = ideal_nops[NOP_ATOMIC5];
+		break;
+
+	case jmp:
+		code = text_gen_insn(JMP32_INSN_OPCODE, insn, func);
+		break;
+
+	case ret:
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
@@ -24,10 +46,10 @@ void arch_static_call_transform(void *si
 	mutex_lock(&text_mutex);
 
 	if (tramp)
-		__static_call_transform(tramp, JMP32_INSN_OPCODE, func);
+		__static_call_transform(tramp, jmp + !func, func);
 
 	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
-		__static_call_transform(site, CALL_INSN_OPCODE, func);
+		__static_call_transform(site, !func, func);
 
 	mutex_unlock(&text_mutex);
 }
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -17,6 +17,7 @@
  *   DECLARE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL(name, func);
  *   static_call(name)(args...);
+ *   static_cond_call(name)(args...)
  *   static_call_update(name, func);
  *
  * Usage example:
@@ -107,7 +108,17 @@ extern int static_call_text_reserved(voi
 	__ADDRESSABLE(STATIC_CALL_NAME(name));				\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
+#define DEFINE_STATIC_COND_CALL(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_NAME(name) = {		\
+		.func = NULL,						\
+		.type = 1,						\
+	};								\
+	__ADDRESSABLE(STATIC_CALL_NAME(name));				\
+	ARCH_DEFINE_STATIC_CALL_RETTRAMP(name)
+
 #define static_call(name)	STATIC_CALL_TRAMP(name)
+#define static_cond_call(name)	STATIC_CALL_TRAMP(name)
 
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_NAME(name));				\
@@ -130,7 +141,15 @@ struct static_call_key {
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
+#define DEFINE_STATIC_COND_CALL(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_NAME(name) = {		\
+		.func = NULL,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_RETTRAMP(name)
+
 #define static_call(name)	STATIC_CALL_TRAMP(name)
+#define static_cond_call(name)	STATIC_CALL_TRAMP(name)
 
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
@@ -161,9 +180,19 @@ struct static_call_key {
 		.func = _func,						\
 	}
 
+#define DEFINE_STATIC_COND_CALL(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_NAME(name) = {		\
+		.func = NULL,						\
+	}
+
 #define static_call(name)						\
 	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_NAME(name).func))
 
+#define static_cond_call(name)						\
+	if (STATIC_CALL_NAME(name).func)				\
+		((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_NAME(name).func))
+
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {


