Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429CFC2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDBF207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XUcD+AzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgCYRsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:48:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgCYRrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=O+hMw6k16uCx6Z0yE65dNJqru6M+QlZ2xoJj9XOUwa0=; b=XUcD+AzAjOt2QAuLezLePaHz2g
        Yz3nTL8Na53sZYkdO028ibHMkNuxmzIcEH83Pje2HX7ApD7SBXwUVqS3n1NCVtWGT8rC2BfrXAF0G
        YwsbK/kRNgHQqyXxiyBS+t1/uMdZkwY+a0wQVvPEaIH1AFFfkqULSdmwfY3NFTqJMuEV8n+NkH+9C
        axFKUeMgAgdp20tCAfCFrc1ayEswLvj9JflwTc139Acuvf8Rtqn9GxXRI32SZYd58LthuevJq/q0Y
        13vufXWr2fHg/N2p87tk71PEq/4Kad53oxyGX+7IpCUy1UgWlbwA8gIOqJFYgq6sxPDzbYkbVYPbv
        U+i4UKAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHA82-0008RI-Np; Wed, 25 Mar 2020 17:47:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DFE4A306DD7;
        Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D16CB29BD8A2C; Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Message-Id: <20200325174606.286244886@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 25 Mar 2020 18:45:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: [PATCH v4 12/13] objtool: Add STT_NOTYPE noinstr validation
References: <20200325174525.772641599@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to also check STT_NOTYPE symbols for noinstr violations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -248,10 +248,18 @@ static void init_cfi_state(struct cfi_st
 	cfi->drap_offset = -1;
 }
 
-static void clear_insn_state(struct insn_state *state)
+static void init_insn_state(struct insn_state *state, struct section *sec)
 {
 	memset(state, 0, sizeof(*state));
 	init_cfi_state(&state->cfi);
+
+	/*
+	 * We need the full vmlinux for noinstr validation, otherwise we can
+	 * not correctly determine insn->call_dest->sec (external symbols do
+	 * not have a section).
+	 */
+	if (vmlinux && sec)
+		state->noinstr = sec->noinstr;
 }
 
 /*
@@ -2422,24 +2430,34 @@ static int validate_branch(struct objtoo
 	return 0;
 }
 
-static int validate_unwind_hints(struct objtool_file *file)
+static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 {
 	struct instruction *insn;
-	int ret, warnings = 0;
 	struct insn_state state;
+	int ret, warnings = 0;
 
 	if (!file->hints)
 		return 0;
 
-	clear_insn_state(&state);
+	init_insn_state(&state, sec);
 
-	for_each_insn(file, insn) {
+	if (sec) {
+		insn = find_insn(file, sec, 0);
+		if (!insn)
+			return 0;
+	} else {
+		insn = list_first_entry(&file->insn_list, typeof(*insn), list);
+	}
+
+	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
 		if (insn->hint && !insn->visited) {
 			ret = validate_branch(file, insn->func, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
 		}
+
+		insn = list_next_entry(insn, list);
 	}
 
 	return warnings;
@@ -2592,21 +2610,13 @@ static int validate_section(struct objto
 	struct symbol *func;
 	int warnings = 0;
 
-	clear_insn_state(&state);
+	init_insn_state(&state, sec);
 
 	state.cfi.cfa = initial_func_cfi.cfa;
 	memcpy(&state.cfi.regs, &initial_func_cfi.regs,
 	       CFI_NUM_REGS * sizeof(struct cfi_reg));
 	state.cfi.stack_size = initial_func_cfi.cfa.offset;
 
-	/*
-	 * We need the full vmlinux for noinstr validation, otherwise we can
-	 * not correctly determine insn->call_dest->sec (external symbols do
-	 * not have a section).
-	 */
-	if (vmlinux)
-		state.noinstr = sec->noinstr;
-
 	if (state.noinstr)
 		prepare_insn_rela(file, sec);
 
@@ -2623,12 +2633,16 @@ static int validate_section(struct objto
 static int validate_vmlinux_functions(struct objtool_file *file)
 {
 	struct section *sec;
+	int warnings = 0;
 
 	sec = find_section_by_name(file->elf, ".noinstr.text");
 	if (!sec)
 		return 0;
 
-	return validate_section(file, sec);
+	warnings += validate_section(file, sec);
+	warnings += validate_unwind_hints(file, sec);
+
+	return warnings;
 }
 
 static int validate_functions(struct objtool_file *file)
@@ -2713,7 +2727,7 @@ int check(const char *_objname, bool orc
 		goto out;
 	warnings += ret;
 
-	ret = validate_unwind_hints(&file);
+	ret = validate_unwind_hints(&file, NULL);
 	if (ret < 0)
 		goto out;
 	warnings += ret;


