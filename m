Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCEFC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B6020775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pb6utBGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgCYOoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:44:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37822 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgCYOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+TRDI3/LCsbvuEImHGlHYjSOOQgxHhx42bznRGg4Mro=; b=Pb6utBGye5RYo+D/P0igT8JFmy
        HpZ6LbCWkYsfhQPrvQoxk0eG15pF3fuOynEMc5CrCtXPqK/J5rRIJUx6A0mw9+oAjUjh0D56nUe2c
        XGyGuTQtmCI2LvIiZrcdewhNYCIFVUdBeqC5sX6Q7skr4ba+hcOagQyTwXdIQDPwK/3YBawmxVJwb
        FC5NWHJcscWur/g5fQEI+kCdXiXcPRktVZv/NLCDwIWorb7+BORgTKOUU+wgRs/uc8IJmR33HeWJE
        RVSDgAaGIAp2AtNbbRgBbaBPUkkAjm5QfZRSenHD89+nQFoAnIEs8TU5yAPrCsD+qAEQxjM6y1zs2
        NdpIEZRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH7Gs-0008BV-45; Wed, 25 Mar 2020 14:44:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0050F3007F2;
        Wed, 25 Mar 2020 15:44:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E647729A8F454; Wed, 25 Mar 2020 15:44:40 +0100 (CET)
Date:   Wed, 25 Mar 2020 15:44:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3.1 19/26] objtool: Implement noinstr validation
Message-ID: <20200325144440.GZ20696@hirez.programming.kicks-ass.net>
References: <20200324153113.098167666@infradead.org>
 <20200324160925.047300866@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324160925.047300866@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: objtool: Implement noinstr validation
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Mar 10 18:57:41 CET 2020

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
@@ -1355,6 +1358,53 @@ static int read_retpoline_hints(struct o
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
@@ -1426,6 +1476,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_instr_hints(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1982,6 +2036,13 @@ static inline const char *call_dest_name
 
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
@@ -2010,6 +2071,12 @@ static int validate_sibling_call(struct
 
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
@@ -2124,6 +2191,9 @@ static int validate_branch(struct objtoo
 				return 0;
 		}
 
+		if (state.noinstr)
+			state.instr += insn->instr;
+
 		if (insn->hint) {
 			ret = apply_insn_hint(file, sec, func, insn, &state.cfi);
 			if (ret)
@@ -2434,6 +2504,14 @@ static int validate_section(struct objto
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
@@ -2462,6 +2540,17 @@ static int validate_section(struct objto
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
@@ -2519,6 +2608,15 @@ int check(const char *_objname, bool orc
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
@@ -30,6 +32,7 @@ struct instruction {
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
