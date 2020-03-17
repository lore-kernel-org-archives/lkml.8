Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8571CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586A620714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IhIJ7aPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCQRMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45304 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgCQRMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dU6va6Aq91cC4fGM3ILR0OQEEO08jQnCWNDmjMCoTSk=; b=IhIJ7aPSEFb+QonQ/TDU7zmeuK
        8N446oQ6mv1NoHQVsYKfl4E8qA10gjTfwD1Nv34IC7DoleR4iT2Fm46UNqEkcoQZM8mnyTypWhumO
        PH7+I1ITTrH4RQcONKTs/QfxgNqiK2qBXU7jXtIpe6YDCKLhUyMGOKCZ2JS2PIdgOcHjQUhZce+cI
        jRiv6gKc5PZ8w0kDbvxQUgO0Tio25gqM0ZJbIwdbiwpvygf+mcaeuUYThZRBZvMg4/lACBT+G+QXQ
        dmMFxIqpKrG5i/PsQgP18AzZ/hLdN8i9yZk6Ne/5Kd9h4HCii+7r0+O/jHVU0RE24fvupRtW7FjBE
        4+7ibIcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFl1-0003ja-TJ; Tue, 17 Mar 2020 17:12:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43D1A30744D;
        Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 35FA5264FDB16; Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Message-Id: <20200317170910.983729109@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 19/19] objtool: Detect loading function pointers across noinstr
References: <20200317170234.897520633@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect if noinstr text loads functions pointers from regular text,
doing so is a definite sign that indirect function calls are unsafe.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch.h  |    2 +
 tools/objtool/check.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/objtool/check.h |    2 -
 3 files changed, 71 insertions(+), 1 deletion(-)

--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -75,4 +75,6 @@ int arch_decode_instruction(struct elf *
 
 bool arch_callee_saved_reg(unsigned char reg);
 
+#define MAX_INSN_SIZE 15
+
 #endif /* _ARCH_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -42,6 +42,25 @@ struct instruction *find_insn(struct obj
 	return NULL;
 }
 
+static struct instruction *find_insn_containing(struct objtool_file *file, struct section *sec,
+					 unsigned long offset)
+{
+	struct instruction *insn;
+	unsigned long o;
+
+	for_offset_range(o, offset - MAX_INSN_SIZE - 1, offset) {
+		hash_for_each_possible(file->insn_hash, insn, hash, sec_offset_hash(sec, o)) {
+			if (insn->sec != sec)
+				continue;
+
+			if (insn->offset <= offset && insn->offset + insn->len > offset)
+				return insn;
+		}
+	}
+
+	return NULL;
+}
+
 static struct instruction *next_insn_same_sec(struct objtool_file *file,
 					      struct instruction *insn)
 {
@@ -2102,6 +2121,29 @@ static int validate_return(struct symbol
 	return 0;
 }
 
+static int validate_rela(struct instruction *insn, struct insn_state *state)
+{
+	/*
+	 * Assume that any text rela that's not a CALL or JMP is a load of a
+	 * function pointer.
+	 */
+
+	switch (insn->type) {
+	case INSN_CALL:
+	case INSN_CALL_DYNAMIC:
+	case INSN_JUMP_CONDITIONAL:
+	case INSN_JUMP_UNCONDITIONAL:
+		return 0;
+	}
+
+	if (state->noinstr && state->instr <= 0 && insn->has_text_rela) {
+		WARN_FUNC("loading non-noinstr function pointer", insn->sec, insn->offset);
+		return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -2217,6 +2259,10 @@ static int validate_branch(struct objtoo
 				return 0;
 		}
 
+		ret = validate_rela(insn, &state);
+		if (ret)
+			return ret;
+
 		switch (insn->type) {
 
 		case INSN_RETURN:
@@ -2485,6 +2531,25 @@ static bool ignore_unreachable_insn(stru
 	return false;
 }
 
+static void prepare_insn_rela(struct objtool_file *file, struct section *sec)
+{
+	struct instruction *insn;
+	struct rela *rela;
+
+	if (!sec->rela)
+		return;
+
+	list_for_each_entry(rela, &sec->rela->rela_list, list) {
+		insn = find_insn_containing(file, sec, rela->offset);
+		if (!insn)
+			continue;
+
+		insn->has_text_rela = rela->sym && rela->sym->sec &&
+				      rela->sym->sec->text &&
+				      !rela->sym->sec->noinstr;
+	}
+}
+
 static int validate_sec_functions(struct objtool_file *file, struct section *sec)
 {
 	struct symbol *func;
@@ -2507,6 +2572,9 @@ static int validate_sec_functions(struct
 	if (vmlinux)
 		state.noinstr = sec->noinstr;
 
+	if (state.noinstr)
+		prepare_insn_rela(file, sec);
+
 	list_for_each_entry(func, &sec->symbol_list, list) {
 		if (func->type != STT_FUNC)
 			continue;
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -36,7 +36,7 @@ struct instruction {
 	enum insn_type type;
 	unsigned long immediate;
 	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
-	bool retpoline_safe;
+	bool retpoline_safe, has_text_rela;
 	s8 instr;
 	u8 visited;
 	struct symbol *call_dest;


