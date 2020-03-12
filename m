Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCE7C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0DA2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="edXimU2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCLNvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:51:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46898 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbgCLNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=A4SB7nL5A5D1rfXDQIoWf0ptdUuTjzvdOlKaEe0kkJM=; b=edXimU2BTuc/eLIwRU0iEtWYop
        BPV9oNWE/e0UB4E05O7eGUVsJRoTvE3H5tugvJYqgax1Kk2Q2DdpS34AftTtkUH3FBTAzVqnH8nmU
        furQMipX9e3InIpnNkEvjdZ/o+QmZrhRkp7MbUy49ZHi12s2UuG4st8RfTzT4DWAzIJ6Vu9fST0dS
        KaMtvhBcxGebxYoS8PTkUylQR+jFUjjSj3CqNGP7ATtPtL02JNZeuesjKjFG7+TxuJlVv9NzmPdgf
        8M3JK8l7vy3TCu2GfWZDJ/ro/u8rCsfMLSWPOJRGBli7LcfiMYxmnds5AskvCIo9l53mnOZRtR3So
        ci2X3KpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOFP-0003Aw-4B; Thu, 12 Mar 2020 13:51:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A1113070FF;
        Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4AFE12B7403A7; Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Message-Id: <20200312135042.288201372@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 12 Mar 2020 14:41:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 15/16] objtool: Implement noinstr validation
References: <20200312134107.700205216@infradead.org>
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

Add the -i "noinstr validation only" option because:

 - vmlinux.o isn't 'clean' vs the existing validations
 - skipping the other validations (which have already been done
   earlier in the build) saves around a second of runtime.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/builtin-check.c |    4 -
 tools/objtool/builtin.h       |    2 
 tools/objtool/check.c         |  155 ++++++++++++++++++++++++++++++++++++------
 tools/objtool/check.h         |    3 
 4 files changed, 140 insertions(+), 24 deletions(-)

--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -17,7 +17,7 @@
 #include "builtin.h"
 #include "check.h"
 
-bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
+bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, noinstr, vmlinux;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -32,6 +32,8 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('b', "backtrace", &backtrace, "unwind on error"),
 	OPT_BOOLEAN('a', "uaccess", &uaccess, "enable uaccess checking"),
 	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
+	OPT_BOOLEAN('i', "noinstr", &noinstr, "noinstr validation only"),
+	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
 	OPT_END(),
 };
 
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -8,7 +8,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, noinstr, vmlinux;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1292,6 +1292,53 @@ static int read_retpoline_hints(struct o
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
@@ -1363,6 +1410,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_instr_hints(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1914,6 +1965,14 @@ static inline const char *call_dest_name
 
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
@@ -1942,6 +2001,12 @@ static int validate_sibling_call(struct
 
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
@@ -2023,6 +2088,9 @@ static int validate_branch(struct objtoo
 				return 0;
 		}
 
+		if (state.noinstr)
+			state.instr += insn->instr;
+
 		if (insn->hint) {
 			if (insn->restore) {
 				struct instruction *save_insn, *i;
@@ -2355,9 +2423,8 @@ static bool ignore_unreachable_insn(stru
 	return false;
 }
 
-static int validate_functions(struct objtool_file *file)
+static int validate_sec_functions(struct objtool_file *file, struct section *sec)
 {
-	struct section *sec;
 	struct symbol *func;
 	struct instruction *insn;
 	struct insn_state state;
@@ -2370,33 +2437,68 @@ static int validate_functions(struct obj
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
+	if (vmlinux && !strcmp(sec->name, ".noinstr.text"))
+		state.noinstr = true;
 
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
+static int validate_noinstr_functions(struct objtool_file *file)
+{
+	struct section *sec;
+
+	if (!vmlinux) {
+		WARN("noinstr validation needs vmlinux\n");
+		return -1;
 	}
 
+	sec = find_section_by_name(file->elf, ".noinstr.text");
+	if (!sec) {
+		WARN("No .noinstr.text section");
+		return -1;
+	}
+
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
 
@@ -2446,6 +2548,15 @@ int check(const char *_objname, bool orc
 	if (list_empty(&file.insn_list))
 		goto out;
 
+	if (noinstr) {
+		ret = validate_noinstr_functions(&file);
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


