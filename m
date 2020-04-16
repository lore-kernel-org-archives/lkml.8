Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC638C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A4621D91
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fo2PvDOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634123AbgDPLxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506637AbgDPLwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CC4C061A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kg55YtsJ6gD5kHbkXXyPvvIFeLGzwYJ6nx3S8CezmJ4=; b=fo2PvDOGCfomuFAnKF5v6F9ZBQ
        dMKRMt98A/sDpO5rzfVTJ98SwRHGR1ggBY8w0fGKNmEpVGwmTHs+w8LSJNEWF8B3D272tc4+cbyFG
        lU1CPjmhKR2xQ7d0zRt9Ns6sZF5ikmEJvSVvy2nfExiKhvaynBAbcqzFrH5ID1cuasmfgv65RF/1r
        WD/ddLc4axPL+kaanBaO4dBEHfE73NeJ3L9nfynxe0IZTYHWIM8se08f20Kwfi0usv2bAojzOdERj
        MiwjLZniIwWIRIV8V/y1f/Gn5m3FVN+mYdfvEf59TWC8Igemof61fm331TzVBOFCjQ24+q+dM+Dxy
        +CaW1UIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34H-0004sV-1E; Thu, 16 Apr 2020 11:52:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5902A307456;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 34F882B0DE4C7; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115118.926738768@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 07/17] objtool: Remove SAVE/RESTORE hints
References: <20200416114706.625340212@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SAVE/RESTORE hints are now unused; remove them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/orc_types.h       |    4 ---
 arch/x86/include/asm/unwind_hints.h    |   13 ----------
 tools/arch/x86/include/asm/orc_types.h |    4 ---
 tools/objtool/check.c                  |   42 ++-------------------------------
 tools/objtool/check.h                  |    2 -
 5 files changed, 7 insertions(+), 58 deletions(-)

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
@@ -118,9 +109,7 @@
 	".balign 4 \n\t"					\
 	".popsection\n\t"
 
-#define UNWIND_HINT_SAVE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_SAVE, 0)
-
-#define UNWIND_HINT_RESTORE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_RESTORE, 0)
+#define UNWIND_HINT_RET_OFFSET(offset) UNWIND_HINT(0, (offset), UNWIND_HINT_TYPE_RET_OFFSET, 0)
 
 #endif /* __ASSEMBLY__ */
 
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
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1246,15 +1246,7 @@ static int read_unwind_hints(struct objt
 
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
@@ -2070,37 +2062,9 @@ static int validate_branch(struct objtoo
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


