Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69293C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D83821569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgDWHvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgDWHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3661EC03C1AF;
        Thu, 23 Apr 2020 00:49:48 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWc8-0008OW-7I; Thu, 23 Apr 2020 09:49:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C2D0A1C0450;
        Thu, 23 Apr 2020 09:49:39 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:39 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove SAVE/RESTORE hints
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115118.926738768@infradead.org>
References: <20200416115118.926738768@infradead.org>
MIME-Version: 1.0
Message-ID: <158762817932.28353.13394834660818487092.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c536ed2fffd5dbf81fe2dede8ef294e0cbb08f72
Gitweb:        https://git.kernel.org/tip/c536ed2fffd5dbf81fe2dede8ef294e0cbb08f72
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 01 Apr 2020 16:54:26 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:50 +02:00

objtool: Remove SAVE/RESTORE hints

The SAVE/RESTORE hints are now unused; remove them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115118.926738768@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/orc_types.h       |  4 +--
 arch/x86/include/asm/unwind_hints.h    | 27 +----------------
 tools/arch/x86/include/asm/orc_types.h |  4 +--
 tools/objtool/check.c                  | 42 +------------------------
 tools/objtool/check.h                  |  2 +-
 5 files changed, 6 insertions(+), 73 deletions(-)

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 5f18ca7..d255349 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -58,9 +58,7 @@
 #define ORC_TYPE_CALL			0
 #define ORC_TYPE_REGS			1
 #define ORC_TYPE_REGS_IRET		2
-#define UNWIND_HINT_TYPE_SAVE		3
-#define UNWIND_HINT_TYPE_RESTORE	4
-#define UNWIND_HINT_TYPE_RET_OFFSET	5
+#define UNWIND_HINT_TYPE_RET_OFFSET	3
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index aabf7ac..7d903fd 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -86,15 +86,6 @@
 	UNWIND_HINT sp_offset=\sp_offset
 .endm
 
-.macro UNWIND_HINT_SAVE
-	UNWIND_HINT type=UNWIND_HINT_TYPE_SAVE
-.endm
-
-.macro UNWIND_HINT_RESTORE
-	UNWIND_HINT type=UNWIND_HINT_TYPE_RESTORE
-.endm
-
-
 /*
  * RET_OFFSET: Used on instructions that terminate a function; mostly RETURN
  * and sibling calls. On these, sp_offset denotes the expected offset from
@@ -104,24 +95,6 @@
 	UNWIND_HINT type=UNWIND_HINT_TYPE_RET_OFFSET sp_offset=\sp_offset
 .endm
 
-#else /* !__ASSEMBLY__ */
-
-#define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
-	"987: \n\t"						\
-	".pushsection .discard.unwind_hints\n\t"		\
-	/* struct unwind_hint */				\
-	".long 987b - .\n\t"					\
-	".short " __stringify(sp_offset) "\n\t"			\
-	".byte " __stringify(sp_reg) "\n\t"			\
-	".byte " __stringify(type) "\n\t"			\
-	".byte " __stringify(end) "\n\t"			\
-	".balign 4 \n\t"					\
-	".popsection\n\t"
-
-#define UNWIND_HINT_SAVE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_SAVE, 0)
-
-#define UNWIND_HINT_RESTORE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_RESTORE, 0)
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_UNWIND_HINTS_H */
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index 5f18ca7..d255349 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -58,9 +58,7 @@
 #define ORC_TYPE_CALL			0
 #define ORC_TYPE_REGS			1
 #define ORC_TYPE_REGS_IRET		2
-#define UNWIND_HINT_TYPE_SAVE		3
-#define UNWIND_HINT_TYPE_RESTORE	4
-#define UNWIND_HINT_TYPE_RET_OFFSET	5
+#define UNWIND_HINT_TYPE_RET_OFFSET	3
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 93c88ac..464f10c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1254,15 +1254,7 @@ static int read_unwind_hints(struct objtool_file *file)
 
 		cfa = &insn->state.cfa;
 
-		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
-			insn->save = true;
-			continue;
-
-		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
-			insn->restore = true;
-			insn->hint = true;
-
-		} else if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
+		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
 			insn->ret_offset = hint->sp_offset;
 			continue;
 		}
@@ -2113,37 +2105,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return 0;
 		}
 
-		if (insn->hint) {
-			if (insn->restore) {
-				struct instruction *save_insn, *i;
-
-				i = insn;
-				save_insn = NULL;
-				sym_for_each_insn_continue_reverse(file, func, i) {
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
-					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
-						  sec, insn->offset);
-					return 1;
-				}
-
-				insn->state = save_insn->state;
-			}
-
+		if (insn->hint)
 			state = insn->state;
-
-		} else
+		else
 			insn->state = state;
 
 		insn->visited |= visited;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 81ce27e..7c30760 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -34,7 +34,7 @@ struct instruction {
 	enum insn_type type;
 	unsigned long immediate;
 	bool alt_group, dead_end, ignore, ignore_alts;
-	bool hint, save, restore;
+	bool hint;
 	bool retpoline_safe;
 	u8 visited;
 	u8 ret_offset;
