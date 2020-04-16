Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB87C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFF421D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kZn37W+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634159AbgDPLx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506557AbgDPLwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5423CC061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=eKdKxZLe1ml1iZXmUqfvZuVOV0adCE7/IAD1HguFGuw=; b=kZn37W+3iTdq18nSQbMWkIFx44
        HELm5NgmZsJnzQ4X4uCV9pR91qBTRV0MYwo/ItboE1+N4afDQWKPhooietS6OV9Sj7VUFPbuaIoBi
        vQ37kv/YTorK78ifUcGQTgj9IczA8iDlX8TvCcpqEJVM+VlIuSCMlMbcWvzQxCQhqKc54MYkar30/
        QHQq3U4rkUfNllO7DHKQjvZvsAYfLul4Flk7zO+CULtY2PqPYQTp4MlU51F1Fy+WY8QbX6bn5+Bqw
        9IeJ4E1BO8HH5XIOLSsmCZcDHlN2M7MQ7c3+uN7uJTjHi0WR7XAJWDzed1UF4225WQ5l65meStFWY
        9QSRNsKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34F-0004sF-QX; Thu, 16 Apr 2020 11:52:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61EBA307865;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 426982B0DE4CB; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115119.106268040@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 10/17] objtool: Implement noinstr validation
References: <20200416114706.625340212@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validate that any call out of .noinstr.text is in between
instr_begin() and instr_end() annotations.

This annotation is useful to ensure correct behaviour wrt tracing
sensitive code like entry/exit and idle code. When we run code in a
sensitive context we want a guarantee no unknown code is ran.

Since this validation relies on knowing the section of call
destination symbols, we must run it on vmlinux.o instead of on
individual object files.

Add two options:

 -d/--duplicate "duplicate validation for vmlinux"
 -l/--vmlinux "vmlinux.o validation"

Where the latter auto-detects when objname ends with "vmlinux.o" and
the former will force all validations, also those already done on
!vmlinux object files.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/builtin-check.c |   11 +++-
 tools/objtool/builtin.h       |    2 
 tools/objtool/check.c         |   98 ++++++++++++++++++++++++++++++++++++++++++
 tools/objtool/check.h         |    3 +
 tools/objtool/elf.h           |    2 
 5 files changed, 112 insertions(+), 4 deletions(-)

--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -14,10 +14,11 @@
  */
 
 #include <subcmd/parse-options.h>
+#include <string.h>
 #include "builtin.h"
 #include "check.h"
 
-bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
+bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -32,12 +33,14 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('b', "backtrace", &backtrace, "unwind on error"),
 	OPT_BOOLEAN('a', "uaccess", &uaccess, "enable uaccess checking"),
 	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
+	OPT_BOOLEAN('d', "duplicate", &validate_dup, "duplicate validation for vmlinux.o"),
+	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
 	OPT_END(),
 };
 
 int cmd_check(int argc, const char **argv)
 {
-	const char *objname;
+	const char *objname, *s;
 
 	argc = parse_options(argc, argv, check_options, check_usage, 0);
 
@@ -46,5 +49,9 @@ int cmd_check(int argc, const char **arg
 
 	objname = argv[0];
 
+	s = strstr(objname, "vmlinux.o");
+	if (s && !s[9])
+		vmlinux = true;
+
 	return check(objname, false);
 }
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -8,7 +8,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -257,6 +257,9 @@ static int decode_instructions(struct ob
 		    strncmp(sec->name, ".discard.", 9))
 			sec->text = true;
 
+		if (!strcmp(sec->name, ".noinstr.text"))
+			sec->noinstr = true;
+
 		for (offset = 0; offset < sec->len; offset += insn->len) {
 			insn = malloc(sizeof(*insn));
 			if (!insn) {
@@ -1332,6 +1335,53 @@ static int read_retpoline_hints(struct o
 	return 0;
 }
 
+static int read_instr_hints(struct objtool_file *file)
+{
+	struct section *sec;
+	struct instruction *insn;
+	struct rela *rela;
+
+	sec = find_section_by_name(file->elf, ".rela.discard.instr_end");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s", sec->name);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("bad .discard.instr_end entry");
+			return -1;
+		}
+
+		insn->instr--;
+	}
+
+	sec = find_section_by_name(file->elf, ".rela.discard.instr_begin");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s", sec->name);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("bad .discard.instr_begin entry");
+			return -1;
+		}
+
+		insn->instr++;
+	}
+
+	return 0;
+}
+
 static void mark_rodata(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1403,6 +1453,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_instr_hints(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1966,6 +2020,13 @@ static inline const char *call_dest_name
 
 static int validate_call(struct instruction *insn, struct insn_state *state)
 {
+	if (state->noinstr && state->instr <= 0 &&
+	    (!insn->call_dest || insn->call_dest->sec != insn->sec)) {
+		WARN_FUNC("call to %s() leaves .noinstr.text section",
+				insn->sec, insn->offset, call_dest_name(insn));
+		return 1;
+	}
+
 	if (state->uaccess && !func_uaccess_safe(insn->call_dest)) {
 		WARN_FUNC("call to %s() with UACCESS enabled",
 				insn->sec, insn->offset, call_dest_name(insn));
@@ -1994,6 +2055,12 @@ static int validate_sibling_call(struct
 
 static int validate_return(struct symbol *func, struct instruction *insn, struct insn_state *state)
 {
+	if (state->noinstr && state->instr > 0) {
+		WARN_FUNC("return with instrumentation enabled",
+			  insn->sec, insn->offset);
+		return 1;
+	}
+
 	if (state->uaccess && !func_uaccess_safe(func)) {
 		WARN_FUNC("return with UACCESS enabled",
 			  insn->sec, insn->offset);
@@ -2075,6 +2142,9 @@ static int validate_branch(struct objtoo
 				return 0;
 		}
 
+		if (state.noinstr)
+			state.instr += insn->instr;
+
 		if (insn->hint)
 			state.cfi = insn->cfi;
 		else
@@ -2390,6 +2460,14 @@ static int validate_section(struct objto
 	       CFI_NUM_REGS * sizeof(struct cfi_reg));
 	state.cfi.stack_size = initial_func_cfi.cfa.offset;
 
+	/*
+	 * We need the full vmlinux for noinstr validation, otherwise we can
+	 * not correctly determine insn->call_dest->sec (external symbols do
+	 * not have a section).
+	 */
+	if (vmlinux)
+		state.noinstr = sec->noinstr;
+
 	list_for_each_entry(func, &sec->symbol_list, list) {
 		if (func->type != STT_FUNC)
 			continue;
@@ -2418,6 +2496,17 @@ static int validate_section(struct objto
 	return warnings;
 }
 
+static int validate_vmlinux_functions(struct objtool_file *file)
+{
+	struct section *sec;
+
+	sec = find_section_by_name(file->elf, ".noinstr.text");
+	if (!sec)
+		return 0;
+
+	return validate_section(file, sec);
+}
+
 static int validate_functions(struct objtool_file *file)
 {
 	struct section *sec;
@@ -2475,6 +2564,15 @@ int check(const char *_objname, bool orc
 	if (list_empty(&file.insn_list))
 		goto out;
 
+	if (vmlinux && !validate_dup) {
+		ret = validate_vmlinux_functions(&file);
+		if (ret < 0)
+			goto out;
+
+		warnings += ret;
+		goto out;
+	}
+
 	if (retpoline) {
 		ret = validate_retpoline(&file);
 		if (ret < 0)
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -18,6 +18,8 @@ struct insn_state {
 	unsigned int uaccess_stack;
 	bool uaccess;
 	bool df;
+	bool noinstr;
+	s8 instr;
 };
 
 struct instruction {
@@ -31,6 +33,7 @@ struct instruction {
 	bool alt_group, dead_end, ignore, ignore_alts;
 	bool hint;
 	bool retpoline_safe;
+	s8 instr;
 	u8 visited;
 	u8 ret_offset;
 	struct symbol *call_dest;
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -39,7 +39,7 @@ struct section {
 	char *name;
 	int idx;
 	unsigned int len;
-	bool changed, text, rodata;
+	bool changed, text, rodata, noinstr;
 };
 
 struct symbol {


