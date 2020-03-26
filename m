Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B678C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED806206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hi6vwbex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgCZT5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:57:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgCZT5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=npXztQNsueHlShWJd1lOnCg5QbqP/9CD5NFcbhBoQwQ=; b=hi6vwbexGa7OxE3FSXG0Ir++zO
        jCSpro7RRA6yK0bIRcAhkB7OlbPG58vBocYxwn5RFQqminyMEVfCHZw3pvXE3pMBI9dangfXgXQBw
        V9s4dFfca+mC2hDJ/EP4Phi0l+svuhjenaOK3+ZB5Zf8x36GywqIh977G3q+j+xy1COPAiDM6bfb6
        fCyYDf1B2+r/ubKEH5LY4ZQeYVntusBrk7/jXJjcF6rslCbUSTC5oMhUJbWuUTLPNCG+M6hdje7CF
        gdZ8d4a5c4TIypERmQTPbKuHC8CX/pLsqos2yfzXCbDcYlsIXCGoVAcV7FXm549cBNmpByGosnpuJ
        srn4aalQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHYcz-00075z-1S; Thu, 26 Mar 2020 19:57:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41579983531; Thu, 26 Mar 2020 20:57:18 +0100 (CET)
Date:   Thu, 26 Mar 2020 20:57:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200326195718.GD2452@worktop.programming.kicks-ass.net>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
 <20200326135620.tlmof5fa7p5wct62@treble>
 <20200326154938.GO20713@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326154938.GO20713@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 04:49:38PM +0100, Peter Zijlstra wrote:
> > The 'insn == first' check isn't ideal, but at least it works (I think?).
> 
> It works, yes, for exactly this one case.

How's this? Ignore the ignore_cfi bits, that's a 'failed' experiment.

---
 arch/x86/include/asm/orc_types.h       |   2 +
 arch/x86/include/asm/processor.h       |   6 +-
 arch/x86/include/asm/unwind_hints.h    |   4 ++
 tools/arch/x86/include/asm/orc_types.h |   2 +
 tools/objtool/check.c                  | 109 +++++++++++++++++++--------------
 tools/objtool/check.h                  |   3 +-
 6 files changed, 75 insertions(+), 51 deletions(-)

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 6e060907c163..82b5c685341a 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -60,6 +60,8 @@
 #define ORC_TYPE_REGS_IRET		2
 #define UNWIND_HINT_TYPE_SAVE		3
 #define UNWIND_HINT_TYPE_RESTORE	4
+#define UNWIND_HINT_TYPE_IGNORE		5
+#define UNWIND_HINT_TYPE_IRET_CONT	6

 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 94789db550df..45c74cbc0a83 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -728,8 +728,8 @@ static inline void sync_core(void)
 	unsigned int tmp;

 	asm volatile (
-		UNWIND_HINT_SAVE
 		"mov %%ss, %0\n\t"
+		UNWIND_HINT_SAVE
 		"pushq %q0\n\t"
 		"pushq %%rsp\n\t"
 		"addq $8, (%%rsp)\n\t"
@@ -737,9 +737,9 @@ static inline void sync_core(void)
 		"mov %%cs, %0\n\t"
 		"pushq %q0\n\t"
 		"pushq $1f\n\t"
+		UNWIND_HINT_IRET_CONT
 		"iretq\n\t"
-		UNWIND_HINT_RESTORE
-		"1:"
+		"1:\n\t"
 		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
 #endif
 }
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index f5e2eb12cb71..d8a07749c323 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -112,6 +112,10 @@

 #define UNWIND_HINT_RESTORE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_RESTORE, 0)

+#define UNWIND_HINT_IGNORE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_IGNORE, 0)
+
+#define UNWIND_HINT_IRET_CONT UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_IRET_CONT, 0)
+
 #endif /* __ASSEMBLY__ */

 #endif /* _ASM_X86_UNWIND_HINTS_H */
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index 6e060907c163..82b5c685341a 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -60,6 +60,8 @@
 #define ORC_TYPE_REGS_IRET		2
 #define UNWIND_HINT_TYPE_SAVE		3
 #define UNWIND_HINT_TYPE_RESTORE	4
+#define UNWIND_HINT_TYPE_IGNORE		5
+#define UNWIND_HINT_TYPE_IRET_CONT	6

 #ifndef __ASSEMBLY__
 /*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e637a4a38d2a..03bac6cb313c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1259,14 +1259,25 @@ static int read_unwind_hints(struct objtool_file *file)

 		cfa = &insn->state.cfa;

-		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
+		switch (hint->type) {
+		case UNWIND_HINT_TYPE_SAVE:
 			insn->save = true;
 			continue;

-		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
+		case UNWIND_HINT_TYPE_RESTORE:
 			insn->restore = true;
-			insn->hint = true;
 			continue;
+
+		case UNWIND_HINT_TYPE_IGNORE:
+			insn->ignore_cfi = true;
+			continue;
+
+		case UNWIND_HINT_TYPE_IRET_CONT:
+			insn->iret_cont = true;
+			continue;
+
+		default:
+			break;
 		}

 		insn->hint = true;
@@ -1558,6 +1569,9 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 	struct cfi_reg *cfa = &state->cfa;
 	struct cfi_reg *regs = state->regs;

+	if (insn->ignore_cfi)
+		return 0;
+
 	/* stack operations don't make sense with an undefined CFA */
 	if (cfa->base == CFI_UNDEFINED) {
 		if (insn->func) {
@@ -1993,6 +2007,37 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
 	return validate_call(insn, state);
 }

+static int insn_hint_restore(struct objtool_file *file, struct section *sec,
+			     struct symbol *func, struct instruction *insn,
+			     struct insn_state *state)
+{
+	struct instruction *save_insn, *i;
+
+	i = insn;
+	save_insn = NULL;
+	func_for_each_insn_continue_reverse(file, func, i) {
+		if (i->save) {
+			save_insn = i;
+			break;
+		}
+	}
+
+	if (!save_insn) {
+		WARN_FUNC("no corresponding CFI save for CFI restore",
+			  sec, insn->offset);
+		return 1;
+	}
+
+	if (!save_insn->visited) {
+		WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
+			  sec, insn->offset);
+		return 1;
+	}
+
+	*state = save_insn->state;
+	return 0;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -2000,15 +2045,14 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
  * tools/objtool/Documentation/stack-validation.txt.
  */
 static int validate_branch(struct objtool_file *file, struct symbol *func,
-			   struct instruction *first, struct insn_state state)
+			   struct instruction *insn, struct insn_state state)
 {
+	struct instruction *next_insn;
 	struct alternative *alt;
-	struct instruction *insn, *next_insn;
 	struct section *sec;
 	u8 visited;
 	int ret;

-	insn = first;
 	sec = insn->sec;

 	if (insn->alt_group && list_empty(&insn->alts)) {
@@ -2034,7 +2078,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,

 		visited = 1 << state.uaccess;
 		if (insn->visited) {
-			if (!insn->hint && !insn_state_match(insn, &state))
+			if ((!insn->hint && !insn->restore) && !insn_state_match(insn, &state))
 				return 1;

 			if (insn->visited & visited)
@@ -2042,47 +2086,12 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		}

 		if (insn->hint) {
-			if (insn->restore) {
-				struct instruction *save_insn, *i;
-
-				i = insn;
-				save_insn = NULL;
-				func_for_each_insn_continue_reverse(file, func, i) {
-					if (i->save) {
-						save_insn = i;
-						break;
-					}
-				}
-
-				if (!save_insn) {
-					WARN_FUNC("no corresponding CFI save for CFI restore",
-						  sec, insn->offset);
-					return 1;
-				}
-
-				if (!save_insn->visited) {
-					/*
-					 * Oops, no state to copy yet.
-					 * Hopefully we can reach this
-					 * instruction from another branch
-					 * after the save insn has been
-					 * visited.
-					 */
-					if (insn == first)
-						return 0;
-
-					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
-						  sec, insn->offset);
-					return 1;
-				}
-
-				insn->state = save_insn->state;
-			}
-
 			state = insn->state;
-
-		} else
+		} else {
+			if (insn->restore)
+				insn_hint_restore(file, sec, func, insn, &state);
 			insn->state = state;
+		}

 		insn->visited |= visited;

@@ -2191,11 +2200,17 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;

 		case INSN_CONTEXT_SWITCH:
-			if (func && (!next_insn || !next_insn->hint)) {
+			if (insn->iret_cont) {
+				insn_hint_restore(file, sec, func, insn, &state);
+				break;
+			}
+
+			if (func) {
 				WARN_FUNC("unsupported instruction in callable function",
 					  sec, insn->offset);
 				return 1;
 			}
+
 			return 0;

 		case INSN_STACK:
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 6d875ca6fce0..f2b6172e119b 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -33,7 +33,8 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
+	bool alt_group, dead_end, ignore, ignore_alts;
+	bool hint, save, restore, ignore_cfi, iret_cont;
 	bool retpoline_safe;
 	u8 visited;
 	struct symbol *call_dest;

