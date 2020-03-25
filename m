Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751E8C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51231215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ixvwX8OI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgCYRsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:48:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgCYRru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=L5N7k8zUpc0WuXXsNPEdzROZ5Q+YaTka3flmqLOhojY=; b=ixvwX8OI5bFBCxuziHLEuK6Bo4
        hm/nP1Mx2QmIARnMp4pUis4z71X4/shedKMc1A9aMaeFKlRG9eYfVxYOXYbPAcE2/ovK80jQgSert
        Li5VZbnuF9zS45YJxN5Zj6S/RVJhBimrS78pIGZ/yHeATGV6VHWNC4O4o4NIkpE7NsWk/8h4qcPA4
        QmcDygiHVwkG9nOi8RfFVV4w2CH0UPcG+0j5J86JBapXvAM2frTeTsyI1RIi5j7HybTHqlhRN0vFV
        Qivt99kr4TBeiFPdrYeRZoFKI8ZTGQuweod7kuRsVcwjBIzelfIdzYBCShzP/1uIDzGV56/rSW230
        XxfClmkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHA82-0008RC-4Y; Wed, 25 Mar 2020 17:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5FA6305BD3;
        Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C0E2D29BD8A30; Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Message-Id: <20200325174605.959837022@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 25 Mar 2020 18:45:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: [PATCH v4 08/13] objtool: Detect loading function pointers across noinstr
References: <20200325174525.772641599@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect if noinstr text loads functions pointers from regular text,
doing so is a definite sign that indirect function calls are unsafe.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/arch.h  |    2 +
 tools/objtool/check.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/objtool/check.h |    2 -
 3 files changed, 74 insertions(+), 1 deletion(-)

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
@@ -2146,6 +2165,32 @@ static int apply_insn_hint(struct objtoo
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
+
+	default:
+		break;
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
@@ -2224,6 +2269,10 @@ static int validate_branch(struct objtoo
 				return 0;
 		}
 
+		ret = validate_rela(insn, &state);
+		if (ret)
+			return ret;
+
 		switch (insn->type) {
 
 		case INSN_RETURN:
@@ -2492,6 +2541,25 @@ static bool ignore_unreachable_insn(stru
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
 static int validate_section(struct objtool_file *file, struct section *sec)
 {
 	struct symbol *func;
@@ -2514,6 +2582,9 @@ static int validate_section(struct objto
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
@@ -31,7 +31,7 @@ struct instruction {
 	enum insn_type type;
 	unsigned long immediate;
 	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
-	bool retpoline_safe;
+	bool retpoline_safe, has_text_rela;
 	s8 instr;
 	u8 visited;
 	struct symbol *call_dest;


