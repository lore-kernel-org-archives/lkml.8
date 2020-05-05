Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133AAC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB8420675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgEEOUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729994AbgEEOQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133F1C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:04 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMM-0001ni-6q; Tue, 05 May 2020 16:15:46 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 7F25CFFC8D;
        Tue,  5 May 2020 16:15:45 +0200 (CEST)
Message-Id: <20200505135313.410702173@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:27 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V4 part 4 01/24] x86/int3: Ensure that poke_int3_handler() is
 not traced
References: <20200505134926.578885807@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

In order to ensure poke_int3_handler() is completely self contained -- this
is called while modifying other text, imagine the fun of hitting another
INT3 -- ensure that everything it uses is not traced.

The primary means here is to force inlining; bsearch() is notrace because
all of lib/ is.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/ptrace.h        |    2 +-
 arch/x86/include/asm/text-patching.h |   11 +++++++----
 arch/x86/kernel/alternative.c        |   13 ++++++-------
 3 files changed, 14 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -123,7 +123,7 @@ static inline void regs_set_return_value
  * On x86_64, vm86 mode is mercifully nonexistent, and we don't need
  * the extra check.
  */
-static inline int user_mode(struct pt_regs *regs)
+static __always_inline int user_mode(struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_32
 	return ((regs->cs & SEGMENT_RPL_MASK) | (regs->flags & X86_VM_MASK)) >= USER_RPL;
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -64,7 +64,7 @@ extern void text_poke_finish(void);
 
 #define DISP32_SIZE		4
 
-static inline int text_opcode_size(u8 opcode)
+static __always_inline int text_opcode_size(u8 opcode)
 {
 	int size = 0;
 
@@ -118,12 +118,14 @@ extern __ro_after_init struct mm_struct
 extern __ro_after_init unsigned long poking_addr;
 
 #ifndef CONFIG_UML_X86
-static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
+static __always_inline
+void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
 {
 	regs->ip = ip;
 }
 
-static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
+static __always_inline
+void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 {
 	/*
 	 * The int3 handler in entry_64.S adds a gap between the
@@ -138,7 +140,8 @@ static inline void int3_emulate_push(str
 	*(unsigned long *)regs->sp = val;
 }
 
-static inline void int3_emulate_call(struct pt_regs *regs, unsigned long func)
+static __always_inline
+void int3_emulate_call(struct pt_regs *regs, unsigned long func)
 {
 	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);
 	int3_emulate_jmp(regs, func);
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -957,7 +957,8 @@ struct bp_patching_desc {
 
 static struct bp_patching_desc *bp_desc;
 
-static inline struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
+static __always_inline
+struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
 {
 	struct bp_patching_desc *desc = READ_ONCE(*descp); /* rcu_dereference */
 
@@ -967,18 +968,18 @@ static inline struct bp_patching_desc *t
 	return desc;
 }
 
-static inline void put_desc(struct bp_patching_desc *desc)
+static __always_inline void put_desc(struct bp_patching_desc *desc)
 {
 	smp_mb__before_atomic();
 	atomic_dec(&desc->refs);
 }
 
-static inline void *text_poke_addr(struct text_poke_loc *tp)
+static __always_inline void *text_poke_addr(struct text_poke_loc *tp)
 {
 	return _stext + tp->rel_addr;
 }
 
-static int notrace patch_cmp(const void *key, const void *elt)
+static int noinstr patch_cmp(const void *key, const void *elt)
 {
 	struct text_poke_loc *tp = (struct text_poke_loc *) elt;
 
@@ -988,9 +989,8 @@ static int notrace patch_cmp(const void
 		return 1;
 	return 0;
 }
-NOKPROBE_SYMBOL(patch_cmp);
 
-int notrace poke_int3_handler(struct pt_regs *regs)
+int noinstr poke_int3_handler(struct pt_regs *regs)
 {
 	struct bp_patching_desc *desc;
 	struct text_poke_loc *tp;
@@ -1064,7 +1064,6 @@ int notrace poke_int3_handler(struct pt_
 	put_desc(desc);
 	return ret;
 }
-NOKPROBE_SYMBOL(poke_int3_handler);
 
 #define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
 static struct text_poke_loc tp_vec[TP_VEC_MAX];

