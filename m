Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36089C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 109C021D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jBN9TUCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634368AbgDPLy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633966AbgDPLwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:53 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82DC061A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BhhaxP5U9sQq+T5+G+gjPjpkNIlEa4KD4OjhWC7DNSU=; b=jBN9TUCFw114dygvLBuFMwABy4
        9DfWWt7BgSymMSoRwMoElTJcXRNy/m5kasPWM7NSbtrY60uTrs1g5YfwnDlexud4AaOk/R5T7yott
        iI51eW4emHBZNvvidU8qMbREjNMr5ZHAtjdhlKCqT62ZVuCNfSIoUVPBRi8dWdK3FvqFHkWvmuvmv
        aaZCLVVE4Qoayej6FHuhBmc1xJPSMDBtfG5gSHf2KDIT8vYijCJLZ55teY44+QBxuRSJxFKeDs/kf
        c7eYL1iCefi9pcedHmEL8uaCdcMeoR3P/56p5z1O1jCexgIOOHFNUGv0oE777SU6fLjxD4fCMvCl/
        e8NWQJBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34G-0006je-Ph; Thu, 16 Apr 2020 11:52:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6FFF3307891;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 60A292B0DE4CA; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115119.465335884@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 16/17] objtool: Add STT_NOTYPE noinstr validation
References: <20200416114706.625340212@infradead.org>
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
@@ -229,10 +229,18 @@ static void init_cfi_state(struct cfi_st
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
@@ -2328,24 +2336,34 @@ static int validate_branch(struct objtoo
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
@@ -2479,21 +2497,13 @@ static int validate_section(struct objto
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
 	list_for_each_entry(func, &sec->symbol_list, list) {
 		if (func->type != STT_FUNC)
 			continue;
@@ -2507,12 +2517,16 @@ static int validate_section(struct objto
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
@@ -2597,7 +2611,7 @@ int check(const char *_objname, bool orc
 		goto out;
 	warnings += ret;
 
-	ret = validate_unwind_hints(&file);
+	ret = validate_unwind_hints(&file, NULL);
 	if (ret < 0)
 		goto out;
 	warnings += ret;


