Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94551C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729BF207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vrj1JX0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgGJNoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgGJNob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:44:31 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7A3C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=fcdJT8N8GdztKJah2wyn17vwCuhVL8UOOyzx90UFUnM=; b=vrj1JX0x6lt7p1TKszTKHx9Po+
        iADINmOOHGrfU/S0HYMQTWlwWU1qmXhZj6WKhCUL9nSjIP9bnlBLWN4niTZ1KhwwHFOdOQMG8pwww
        OqyUQEHATQmj79WoaiINHLuEDX9MeKp50bb3LSwrj0IWkJdIW6z7OC+ucE+yiH6Uof6qEoyqUC/b0
        oQDEsooroO7ZMVZ2cHFfQdrYWvY6cdsE0a3LcBKdn3zbmmZCW1at2zULZ3Urla4JyMSIqH2mEbJvZ
        OzWX1ZQBJSPBETNUl80rVuBv03MRlwfT0PuQbj88kYTRDsQ7DJ3MhGnAuYcXuYZ/VYNDGglfAIBWk
        t2ciBZJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jttK2-000183-2G; Fri, 10 Jul 2020 13:44:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D8E99307983;
        Fri, 10 Jul 2020 15:44:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1214E2B7A733C; Fri, 10 Jul 2020 15:44:10 +0200 (CEST)
Message-ID: <20200710134336.858484214@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Jul 2020 15:38:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v6 12/17] x86/alternatives: Teach text_poke_bp() to emulate RET
References: <20200710133831.943894387@infradead.org>
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


