Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D3FC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC2F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GiSVP7kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgCXOZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:25:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53776 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgCXOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AZ9gMrfy7tII+1yB9euI/yxsmZUgWasRxZVXQg2YzCc=; b=GiSVP7kfMWgLC/zeHSGgH+TP7s
        ADiM0paoH6+tnqE4x6ff1HnvHl/KBzMhco5ifSNH2RZgriWhzyuhoiT34w/oJutayW3Lavk25QXje
        7XCv2k48PJloQvgjW7++K22sqnZpNY9yVn6sO+mKst3NYS9RrUqZIQqjTMX5Cp+3aoL+EnYmhcsjt
        bB7XVoDLFU4Z7sBU8eRXKqUz9dZM/5Bv3BGiSvMY4FBVshw+rcBWs3D167F8YVERv1i6Wg2fIGBlT
        v2gvoDwahjv6SI5jFcQT7kvaI9abUnE2qicBZeII5rOgrnmxWL/yW/c/zEJCQEcnfRGhMF4Cyp5Rc
        5qViea8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGkTv-0003or-JQ; Tue, 24 Mar 2020 14:24:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 862C130796B;
        Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 26BF1286C13BA; Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Message-Id: <20200324142246.066152557@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 14:56:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [RESEND][PATCH v3 13/17] x86/alternatives: Teach text_poke_bp() to emulate RET
References: <20200324135603.483964896@infradead.org>
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
 arch/x86/include/asm/text-patching.h |   17 +++++++++++++++++
 arch/x86/kernel/alternative.c        |    5 +++++
 2 files changed, 22 insertions(+)

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
 
@@ -73,6 +76,7 @@ static inline int text_opcode_size(u8 op
 
 	switch(opcode) {
 	__CASE(INT3);
+	__CASE(RET);
 	__CASE(CALL);
 	__CASE(JMP32);
 	__CASE(JMP8);
@@ -138,11 +142,24 @@ static inline void int3_emulate_push(str
 	*(unsigned long *)regs->sp = val;
 }
 
+static inline unsigned long int3_emulate_pop(struct pt_regs *regs)
+{
+	unsigned long val = *(unsigned long *)regs->sp;
+	regs->sp += sizeof(unsigned long);
+	return val;
+}
+
 static inline void int3_emulate_call(struct pt_regs *regs, unsigned long func)
 {
 	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);
 	int3_emulate_jmp(regs, func);
 }
+
+static inline void int3_emulate_ret(struct pt_regs *regs)
+{
+	unsigned long ip = int3_emulate_pop(regs);
+	int3_emulate_jmp(regs, ip);
+}
 #endif /* !CONFIG_UML_X86 */
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1045,6 +1045,10 @@ int notrace poke_int3_handler(struct pt_
 		 */
 		goto out_put;
 
+	case RET_INSN_OPCODE:
+		int3_emulate_ret(regs);
+		break;
+
 	case CALL_INSN_OPCODE:
 		int3_emulate_call(regs, (long)ip + tp->rel32);
 		break;
@@ -1187,6 +1191,7 @@ void text_poke_loc_init(struct text_poke
 
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
+	case RET_INSN_OPCODE:
 		break;
 
 	case CALL_INSN_OPCODE:


