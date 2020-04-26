Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1DAC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE332071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgDZGr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 02:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbgDZGrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 02:47:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AB6C09B052;
        Sat, 25 Apr 2020 23:47:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSb4m-0008Qr-5W; Sun, 26 Apr 2020 08:47:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 697091C0178;
        Sun, 26 Apr 2020 08:47:39 +0200 (CEST)
Date:   Sun, 26 Apr 2020 06:47:38 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind/orc: Fix premature unwind stoppage due
 to IRET frames
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Dave Jones <dsj@fb.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <97a408167cc09f1cfa0de31a7b70dd88868d743f.1587808742.git.jpoimboe@redhat.com>
References: <97a408167cc09f1cfa0de31a7b70dd88868d743f.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158788365893.28353.8688775010486782294.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     81b67439d147677d844d492fcbd03712ea438f42
Gitweb:        https://git.kernel.org/tip/81b67439d147677d844d492fcbd03712ea438f42
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Sat, 25 Apr 2020 05:06:14 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Apr 2020 12:22:29 +02:00

x86/unwind/orc: Fix premature unwind stoppage due to IRET frames

The following execution path is possible:

  fsnotify()
    [ realign the stack and store previous SP in R10 ]
    <IRQ>
      [ only IRET regs saved ]
      common_interrupt()
        interrupt_entry()
	  <NMI>
	    [ full pt_regs saved ]
	    ...
	    [ unwind stack ]

When the unwinder goes through the NMI and the IRQ on the stack, and
then sees fsnotify(), it doesn't have access to the value of R10,
because it only has the five IRET registers.  So the unwind stops
prematurely.

However, because the interrupt_entry() code is careful not to clobber
R10 before saving the full regs, the unwinder should be able to read R10
from the previously saved full pt_regs associated with the NMI.

Handle this case properly.  When encountering an IRET regs frame
immediately after a full pt_regs frame, use the pt_regs as a backup
which can be used to get the C register values.

Also, note that a call frame resets the 'prev_regs' value, because a
function is free to clobber the registers.  For this fix to work, the
IRET and full regs frames must be adjacent, with no FUNC frames in
between.  So replace the FUNC hint in interrupt_entry() with an
IRET_REGS hint.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Jones <dsj@fb.com>
Cc: Jann Horn <jannh@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lore.kernel.org/r/97a408167cc09f1cfa0de31a7b70dd88868d743f.1587808742.git.jpoimboe@redhat.com
---
 arch/x86/entry/entry_64.S     |  4 +--
 arch/x86/include/asm/unwind.h |  2 +-
 arch/x86/kernel/unwind_orc.c  | 51 ++++++++++++++++++++++++++--------
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9fe0d5c..3063aa9 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -511,7 +511,7 @@ SYM_CODE_END(spurious_entries_start)
  * +----------------------------------------------------+
  */
 SYM_CODE_START(interrupt_entry)
-	UNWIND_HINT_FUNC
+	UNWIND_HINT_IRET_REGS offset=16
 	ASM_CLAC
 	cld
 
@@ -543,9 +543,9 @@ SYM_CODE_START(interrupt_entry)
 	pushq	5*8(%rdi)		/* regs->eflags */
 	pushq	4*8(%rdi)		/* regs->cs */
 	pushq	3*8(%rdi)		/* regs->ip */
+	UNWIND_HINT_IRET_REGS
 	pushq	2*8(%rdi)		/* regs->orig_ax */
 	pushq	8(%rdi)			/* return address */
-	UNWIND_HINT_FUNC
 
 	movq	(%rdi), %rdi
 	jmp	2f
diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 499578f..70fc159 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -19,7 +19,7 @@ struct unwind_state {
 #if defined(CONFIG_UNWINDER_ORC)
 	bool signal, full_regs;
 	unsigned long sp, bp, ip;
-	struct pt_regs *regs;
+	struct pt_regs *regs, *prev_regs;
 #elif defined(CONFIG_UNWINDER_FRAME_POINTER)
 	bool got_irq;
 	unsigned long *bp, *orig_sp, ip;
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 33b80a7..0ebc11a 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -384,9 +384,38 @@ static bool deref_stack_iret_regs(struct unwind_state *state, unsigned long addr
 	return true;
 }
 
+/*
+ * If state->regs is non-NULL, and points to a full pt_regs, just get the reg
+ * value from state->regs.
+ *
+ * Otherwise, if state->regs just points to IRET regs, and the previous frame
+ * had full regs, it's safe to get the value from the previous regs.  This can
+ * happen when early/late IRQ entry code gets interrupted by an NMI.
+ */
+static bool get_reg(struct unwind_state *state, unsigned int reg_off,
+		    unsigned long *val)
+{
+	unsigned int reg = reg_off/8;
+
+	if (!state->regs)
+		return false;
+
+	if (state->full_regs) {
+		*val = ((unsigned long *)state->regs)[reg];
+		return true;
+	}
+
+	if (state->prev_regs) {
+		*val = ((unsigned long *)state->prev_regs)[reg];
+		return true;
+	}
+
+	return false;
+}
+
 bool unwind_next_frame(struct unwind_state *state)
 {
-	unsigned long ip_p, sp, orig_ip = state->ip, prev_sp = state->sp;
+	unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
 	enum stack_type prev_type = state->stack_info.type;
 	struct orc_entry *orc;
 	bool indirect = false;
@@ -448,39 +477,35 @@ bool unwind_next_frame(struct unwind_state *state)
 		break;
 
 	case ORC_REG_R10:
-		if (!state->regs || !state->full_regs) {
+		if (!get_reg(state, offsetof(struct pt_regs, r10), &sp)) {
 			orc_warn_current("missing R10 value at %pB\n",
 					 (void *)state->ip);
 			goto err;
 		}
-		sp = state->regs->r10;
 		break;
 
 	case ORC_REG_R13:
-		if (!state->regs || !state->full_regs) {
+		if (!get_reg(state, offsetof(struct pt_regs, r13), &sp)) {
 			orc_warn_current("missing R13 value at %pB\n",
 					 (void *)state->ip);
 			goto err;
 		}
-		sp = state->regs->r13;
 		break;
 
 	case ORC_REG_DI:
-		if (!state->regs || !state->full_regs) {
+		if (!get_reg(state, offsetof(struct pt_regs, di), &sp)) {
 			orc_warn_current("missing RDI value at %pB\n",
 					 (void *)state->ip);
 			goto err;
 		}
-		sp = state->regs->di;
 		break;
 
 	case ORC_REG_DX:
-		if (!state->regs || !state->full_regs) {
+		if (!get_reg(state, offsetof(struct pt_regs, dx), &sp)) {
 			orc_warn_current("missing DX value at %pB\n",
 					 (void *)state->ip);
 			goto err;
 		}
-		sp = state->regs->dx;
 		break;
 
 	default:
@@ -507,6 +532,7 @@ bool unwind_next_frame(struct unwind_state *state)
 
 		state->sp = sp;
 		state->regs = NULL;
+		state->prev_regs = NULL;
 		state->signal = false;
 		break;
 
@@ -518,6 +544,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		}
 
 		state->regs = (struct pt_regs *)sp;
+		state->prev_regs = NULL;
 		state->full_regs = true;
 		state->signal = true;
 		break;
@@ -529,6 +556,8 @@ bool unwind_next_frame(struct unwind_state *state)
 			goto err;
 		}
 
+		if (state->full_regs)
+			state->prev_regs = state->regs;
 		state->regs = (void *)sp - IRET_FRAME_OFFSET;
 		state->full_regs = false;
 		state->signal = true;
@@ -543,8 +572,8 @@ bool unwind_next_frame(struct unwind_state *state)
 	/* Find BP: */
 	switch (orc->bp_reg) {
 	case ORC_REG_UNDEFINED:
-		if (state->regs && state->full_regs)
-			state->bp = state->regs->bp;
+		if (get_reg(state, offsetof(struct pt_regs, bp), &tmp))
+			state->bp = tmp;
 		break;
 
 	case ORC_REG_PREV_SP:
