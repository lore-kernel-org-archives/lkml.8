Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA05C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1615D206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9gMf5pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404683AbgFXPwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404620AbgFXPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:51:56 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89A5C061798
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=fcdJT8N8GdztKJah2wyn17vwCuhVL8UOOyzx90UFUnM=; b=Y9gMf5pjFRw97t0yTu9a0pHz0a
        x3iwwYUqz5bXdgsU7zG92rxxnolPDdqYh57yh3VUMh5wt5ONMAFqviPSmlPfnNdtrRikRo72EUwFu
        5BvfguFWU0Kcl9/C+ESZGw4+ZqQTUEWgX3qNPs1cN9Wewpi+B0sga3f02GtQsQ10bHTuLOfLIHAoW
        QkJiVkzYCy23CSvXR8dwybsDkjaaVztrMd4nIJkFU6nJoZU/MeWVn9fxEQEj3Tw1p62j46H8weI8D
        8CZyes1SRqu6nqd4h3EDwiQFyBFGf8iOKZZKaYdof0a3JBcnH9gk/YDdLzTLpBcbHdxH+KipC3bCE
        e2++hoLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo7gD-0001e7-Qu; Wed, 24 Jun 2020 15:51:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B6B6E3079A1;
        Wed, 24 Jun 2020 17:51:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F3590236E7762; Wed, 24 Jun 2020 17:51:13 +0200 (CEST)
Message-ID: <20200624154157.449643778@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Jun 2020 17:30:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v5 12/17] x86/alternatives: Teach text_poke_bp() to emulate RET
References: <20200624153024.794671356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future patches will need to poke a RET instruction, provide the
infrastructure required for this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |   19 +++++++++++++++++++
 arch/x86/kernel/alternative.c        |    5 +++++
 2 files changed, 24 insertions(+)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -53,6 +53,9 @@ extern void text_poke_finish(void);
 #define INT3_INSN_SIZE		1
 #define INT3_INSN_OPCODE	0xCC
 
+#define RET_INSN_SIZE		1
+#define RET_INSN_OPCODE		0xC3
+
 #define CALL_INSN_SIZE		5
 #define CALL_INSN_OPCODE	0xE8
 
@@ -73,6 +76,7 @@ static __always_inline int text_opcode_s
 
 	switch(opcode) {
 	__CASE(INT3);
+	__CASE(RET);
 	__CASE(CALL);
 	__CASE(JMP32);
 	__CASE(JMP8);
@@ -141,11 +145,26 @@ void int3_emulate_push(struct pt_regs *r
 }
 
 static __always_inline
+unsigned long int3_emulate_pop(struct pt_regs *regs)
+{
+	unsigned long val = *(unsigned long *)regs->sp;
+	regs->sp += sizeof(unsigned long);
+	return val;
+}
+
+static __always_inline
 void int3_emulate_call(struct pt_regs *regs, unsigned long func)
 {
 	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);
 	int3_emulate_jmp(regs, func);
 }
+
+static __always_inline
+void int3_emulate_ret(struct pt_regs *regs)
+{
+	unsigned long ip = int3_emulate_pop(regs);
+	int3_emulate_jmp(regs, ip);
+}
 #endif /* !CONFIG_UML_X86 */
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1099,6 +1099,10 @@ int noinstr poke_int3_handler(struct pt_
 		 */
 		goto out_put;
 
+	case RET_INSN_OPCODE:
+		int3_emulate_ret(regs);
+		break;
+
 	case CALL_INSN_OPCODE:
 		int3_emulate_call(regs, (long)ip + tp->rel32);
 		break;
@@ -1240,6 +1244,7 @@ static void text_poke_loc_init(struct te
 
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
+	case RET_INSN_OPCODE:
 		break;
 
 	case CALL_INSN_OPCODE:


