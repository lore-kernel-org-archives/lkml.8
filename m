Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883AEC47259
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE32216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z4/+YRmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgEAUbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgEAUbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:31:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162FEC061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 13:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OjO00YM2Md44fVL94Oy1xH4I2ZWHGuVcC8cNk5w0ThA=; b=Z4/+YRmKzA6CCRVHPBQwr8sg7l
        Old6KavPBdTxbVNVEfSxOXd/MfFUDv+7cEBsAwtfn4huP51YdZJ5tvUbO3HZy144tgouI4ZLHCkre
        2qGtqwoTF8+VDm05DWwVXMvCpPJeEMFx5I90VKhEtA3aZ/PbgCoSxudfONXWjiDQI/KjydZigtWmZ
        EsJLO227v8eP41EkragpQQNeRud9h+pFtgR09jZNvu2yqcKnWuY+Tm+rlpsM1oTqrfltDwj4DxvMm
        IitNHfIH0sk+4UOlJzFKIN41Q07PEJZn6BMEM/mNHAuv+fCBmUWRInzmnrI2tEidkrt5fQSlwtzCT
        Z5wjcU3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUcJO-0002kx-F9; Fri, 01 May 2020 20:31:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 989F9307616;
        Fri,  1 May 2020 22:31:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 04E8929BF6268; Fri,  1 May 2020 22:31:01 +0200 (CEST)
Message-Id: <20200501202944.593400184@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 01 May 2020 22:29:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: [PATCH v4 14/18] static_call: Add static_cond_call()
References: <20200501202849.647891881@infradead.org>
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

NOTE: this is 'obviously' limited to functions with a 'void' return type.

NOTE: DEFINE_STATIC_COND_CALL() only requires a typename, as opposed
      to a full function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/static_call.h |   10 ++++++++
 arch/x86/kernel/static_call.c      |   42 ++++++++++++++++++++++++++++---------
 include/linux/static_call.h        |   29 +++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -30,4 +30,14 @@
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
-	const void *code = text_gen_insn(opcode, insn, func);
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
@@ -16,7 +16,9 @@
  *
  *   DECLARE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL(name, func);
+ *   DEFINE_STATIC_COND_CALL(name, typename);
  *   static_call(name)(args...);
+ *   static_cond_call(name)(args...)
  *   static_call_update(name, func);
  *
  * Usage example:
@@ -120,7 +122,16 @@ extern int static_call_text_reserved(voi
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
+#define DEFINE_STATIC_COND_CALL(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = NULL,						\
+		.type = 1,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_RETTRAMP(name)
+
 #define static_call(name)	__static_call(name)
+#define static_cond_call(name)	(void)__static_call(name)
 
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
@@ -143,7 +154,15 @@ struct static_call_key {
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
+#define DEFINE_STATIC_COND_CALL(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = NULL,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_RETTRAMP(name)
+
 #define static_call(name)	__static_call(name)
+#define static_cond_call(name)	(void)__static_call(name)
 
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
@@ -179,9 +198,19 @@ struct static_call_key {
 		.func = _func,						\
 	}
 
+#define DEFINE_STATIC_COND_CALL(name, _func)				\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = NULL,						\
+	}
+
 #define static_call(name)						\
 	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
 
+#define static_cond_call(name)						\
+	if (STATIC_CALL_KEY(name).func)					\
+		((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
+
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {


