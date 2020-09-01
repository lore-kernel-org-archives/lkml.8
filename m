Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD23EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9373221D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="psg1OveA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w4tiHiGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgIAOtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:49:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39678 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgIALs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:28 -0400
Date:   Tue, 01 Sep 2020 11:48:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pjltpei6Tq9wjnxVqrhYpDj8TfZWi5wPzkttyxE+o6A=;
        b=psg1OveAWTfiWuxHyaCbBCClD8nrxBLH+BxdPn9yMfx+6i5dnjpJtxzZzED+tLrd8lo5bv
        kNPXhlKw1M6qryG2Rr08G/vFw8ji7HbwWAvERP/uMg6ED9zdXigPri8FyV0aWbalVfMTGl
        m5fjDmaqEIwvKMcNnGmGEgE660scjehgZSoPV3yQVat8vpl9/MSLy8f4C3PYg5xljdFFdt
        A5e3l34lHQP/uaB4ZcTKkmWQRfZv15LD4Cy1xq/dg4p+rWgi0Yq5x1nLNMf0hz4km8Rsaf
        mpKzQpFUbs/eNropHZKeq6m6ci0RGDhu7Hr7kHkJZz4zoUAY79rzye+w1bn1TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pjltpei6Tq9wjnxVqrhYpDj8TfZWi5wPzkttyxE+o6A=;
        b=w4tiHiGw2EMHigQ+ao1/RmWPTN7WpYnuVWDxh02PsiSbhdvDsblxAI7kR3i5keHF5MZHO3
        Lr2C3OiR6FV7enCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] x86/alternatives: Teach text_poke_bp() to emulate RET
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135804.982214828@infradead.org>
References: <20200818135804.982214828@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088450.20229.9636072765757896045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     c43a43e439e00ad2a4d98716895d961ade6bbbfc
Gitweb:        https://git.kernel.org/tip/c43a43e439e00ad2a4d98716895d961ade6bbbfc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Aug 2020 15:57:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:05 +02:00

x86/alternatives: Teach text_poke_bp() to emulate RET

Future patches will need to poke a RET instruction, provide the
infrastructure required for this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20200818135804.982214828@infradead.org
---
 arch/x86/include/asm/text-patching.h | 19 +++++++++++++++++++
 arch/x86/kernel/alternative.c        |  5 +++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 6593b42..b742178 100644
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
 
@@ -73,6 +76,7 @@ static __always_inline int text_opcode_size(u8 opcode)
 
 	switch(opcode) {
 	__CASE(INT3);
+	__CASE(RET);
 	__CASE(CALL);
 	__CASE(JMP32);
 	__CASE(JMP8);
@@ -141,11 +145,26 @@ void int3_emulate_push(struct pt_regs *regs, unsigned long val)
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
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index cdaab30..4adbe65 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1103,6 +1103,10 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 		 */
 		goto out_put;
 
+	case RET_INSN_OPCODE:
+		int3_emulate_ret(regs);
+		break;
+
 	case CALL_INSN_OPCODE:
 		int3_emulate_call(regs, (long)ip + tp->rel32);
 		break;
@@ -1277,6 +1281,7 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
+	case RET_INSN_OPCODE:
 		break;
 
 	case CALL_INSN_OPCODE:
