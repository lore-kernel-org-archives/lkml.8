Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2523FC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC41120738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k+c31AJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCQRMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45150 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgCQRMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=45Xo/TmasC9qOkZu0sDykjqCmXsv5HUiCFqsj+46Aqg=; b=k+c31AJL8iGbp091UIKzLLtsuD
        7OcQAXLsCYNk4i5wnGBQsee97SgGMQqkK3EQf+Sxiv/1LLunAyXRYQFv7TXem05xp12QYi2Bltz8X
        KVEV60A8LtYInqoTvBNwTrFAF0s0Ce3VrIhXygGeFV1ARy15//foPmnHt1Q9Gi5RaNCRcw2qoxd2U
        C+LI2HpC4XUh3VoffiImnAaSzM4qMjH/XhC/4lxdP7Vwm6IQ/4OJMM2fEp7QkKbp2tLcwx0bbdY19
        RGx4ZCt59+I92jRHAyMcO0T2+UEII3iKHCQRWI2V0lrGV0g5dOuBpOg48rpbvtuL6d8zXm3Lier/L
        73RevkUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFl0-0003j2-1m; Tue, 17 Mar 2020 17:11:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D3D63073F7;
        Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1EA3E264FDB16; Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Message-Id: <20200317170910.730949374@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 16/19] objtool: Implement noinstr validation
References: <20200317170234.897520633@infradead.org>
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
---
 tools/objtool/builtin-check.c |   11 ++-
 tools/objtool/builtin.h       |    2 
 tools/objtool/check.c         |  153 +++++++++++++++++++++++++++++++++++-------
 tools/objtool/check.h         |    3 
 tools/objtool/elf.h           |    2 
 5 files changed, 145 insertions(+), 26 deletions(-)

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
@@ -252,6 +252,9 @@ static int decode_instructions(struct ob
 		    strncmp(sec->name, ".discard.", 9))
 			sec->text = true;
 
+		if (!strcmp(sec->name, ".noinstr.text"))
+			sec->noinstr = true;
+
 		for (offset = 0; offset < sec->len; offset += insn->len) {
 			insn = malloc(sizeof(*insn));
 			if (!insn) {
@@ -1350,6 +1353,53 @@ static int read_retpoline_hints(struct o
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
@@ -1421,6 +1471,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_instr_hints(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1972,6 +2026,14 @@ static inline const char *call_dest_name
 
 static int validate_call(struct instruction *insn, struct insn_state *state)
 {
+	if (state->noinstr && state->instr <= 0 &&
+	    (!insn->call_dest || insn->call_dest->sec != insn->sec)) {
+		WARN_FUNC("call to %s() leaves .noinstr.text section",
+				insn->sec, insn->offset, call_dest_name(insn));
+		return 1;
+	}
+
+
 	if (state->uaccess && !func_uaccess_safe(insn->call_dest)) {
 		WARN_FUNC("call to %s() with UACCESS enabled",
 				insn->sec, insn->offset, call_dest_name(insn));
@@ -2000,6 +2062,12 @@ static int validate_sibling_call(struct
 
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
@@ -2081,6 +2149,9 @@ static int validate_branch(struct objtoo
 				return 0;
 		}
 
+		if (state.noinstr)
+			state.instr += insn->instr;
+
 		if (insn->hint) {
 			if (insn->restore) {
 				struct instruction *save_insn, *i;
@@ -2413,9 +2484,8 @@ static bool ignore_unreachable_insn(stru
 	return false;
 }
 
-static int validate_functions(struct objtool_file *file)
+static int validate_sec_functions(struct objtool_file *file, struct section *sec)
 {
-	struct section *sec;
 	struct symbol *func;
 	struct instruction *insn;
 	struct insn_state state;
@@ -2428,33 +2498,63 @@ static int validate_functions(struct obj
 	       CFI_NUM_REGS * sizeof(struct cfi_reg));
 	state.stack_size = initial_func_cfi.cfa.offset;
 
-	for_each_sec(file, sec) {
-		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC)
-				continue;
+	/*
+	 * We need the full vmlinux for noinstr validation, otherwise we can
+	 * not correctly determine insn->call_dest->sec (external symbols do
+	 * not have a section).
+	 */
+	if (vmlinux)
+		state.noinstr = sec->noinstr;
 
-			if (!func->len) {
-				WARN("%s() is missing an ELF size annotation",
-				     func->name);
-				warnings++;
-			}
+	list_for_each_entry(func, &sec->symbol_list, list) {
+		if (func->type != STT_FUNC)
+			continue;
 
-			if (func->pfunc != func || func->alias != func)
-				continue;
+		if (!func->len) {
+			WARN("%s() is missing an ELF size annotation",
+					func->name);
+			warnings++;
+		}
 
-			insn = find_insn(file, sec, func->offset);
-			if (!insn || insn->ignore || insn->visited)
-				continue;
+		if (func->pfunc != func || func->alias != func)
+			continue;
 
-			state.uaccess = func->uaccess_safe;
+		insn = find_insn(file, sec, func->offset);
+		if (!insn || insn->ignore || insn->visited)
+			continue;
 
-			ret = validate_branch(file, func, insn, state);
-			if (ret && backtrace)
-				BT_FUNC("<=== (func)", insn);
-			warnings += ret;
-		}
+		state.uaccess = func->uaccess_safe;
+
+		ret = validate_branch(file, func, insn, state);
+		if (ret && backtrace)
+			BT_FUNC("<=== (func)", insn);
+		warnings += ret;
+	}
+
+	return warnings;
+}
+
+static int validate_vmlinux_functions(struct objtool_file *file)
+{
+	struct section *sec;
+
+	sec = find_section_by_name(file->elf, ".noinstr.text");
+	if (!sec) {
+		WARN("No .noinstr.text section");
+		return -1;
 	}
 
+	return validate_sec_functions(file, sec);
+}
+
+static int validate_functions(struct objtool_file *file)
+{
+	struct section *sec;
+	int warnings = 0;
+
+	for_each_sec(file, sec)
+		warnings += validate_sec_functions(file, sec);
+
 	return warnings;
 }
 
@@ -2504,6 +2604,15 @@ int check(const char *_objname, bool orc
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
@@ -20,6 +20,8 @@ struct insn_state {
 	unsigned char type;
 	bool bp_scratch;
 	bool drap, end, uaccess, df;
+	bool noinstr;
+	s8 instr;
 	unsigned int uaccess_stack;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];
@@ -35,6 +37,7 @@ struct instruction {
 	unsigned long immediate;
 	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
 	bool retpoline_safe;
+	s8 instr;
 	u8 visited;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
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


