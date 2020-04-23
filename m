Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED662C55193
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F4121927
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgDWHtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgDWHtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B04C03C1AB;
        Thu, 23 Apr 2020 00:49:45 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWc6-0008NI-J9; Thu, 23 Apr 2020 09:49:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2BFEB1C0244;
        Thu, 23 Apr 2020 09:49:38 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:37 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Implement noinstr validation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115119.106268040@infradead.org>
References: <20200416115119.106268040@infradead.org>
MIME-Version: 1.0
Message-ID: <158762817766.28353.14956833448401569914.tip-bot2@tip-bot2>
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

Commit-ID:     c4a33939a7eb396acbb05569e57eebe4374cc57c
Gitweb:        https://git.kernel.org/tip/c4a33939a7eb396acbb05569e57eebe4374cc57c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 Mar 2020 18:57:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:50 +02:00

objtool: Implement noinstr validation

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
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115119.106268040@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/builtin-check.c | 11 +++-
 tools/objtool/builtin.h       |  2 +-
 tools/objtool/check.c         | 98 ++++++++++++++++++++++++++++++++++-
 tools/objtool/check.h         |  3 +-
 tools/objtool/elf.h           |  2 +-
 5 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 10fbe75..be42b71 100644
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
 
@@ -46,5 +49,9 @@ int cmd_check(int argc, const char **argv)
 
 	objname = argv[0];
 
+	s = strstr(objname, "vmlinux.o");
+	if (s && !s[9])
+		vmlinux = true;
+
 	return check(objname, false);
 }
diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
index 0b90790..85c979c 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -8,7 +8,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index abf9715..87e528c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -257,6 +257,9 @@ static int decode_instructions(struct objtool_file *file)
 		    strncmp(sec->name, ".discard.", 9))
 			sec->text = true;
 
+		if (!strcmp(sec->name, ".noinstr.text"))
+			sec->noinstr = true;
+
 		for (offset = 0; offset < sec->len; offset += insn->len) {
 			insn = malloc(sizeof(*insn));
 			if (!insn) {
@@ -1340,6 +1343,53 @@ static int read_retpoline_hints(struct objtool_file *file)
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
@@ -1411,6 +1461,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_instr_hints(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -2007,6 +2061,13 @@ static inline const char *call_dest_name(struct instruction *insn)
 
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
@@ -2035,6 +2096,12 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
 
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
@@ -2115,6 +2182,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return 0;
 		}
 
+		if (state.noinstr)
+			state.instr += insn->instr;
+
 		if (insn->hint)
 			state.cfi = insn->cfi;
 		else
@@ -2422,6 +2492,14 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 	struct insn_state state;
 	int ret, warnings = 0;
 
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
@@ -2456,6 +2534,17 @@ static int validate_section(struct objtool_file *file, struct section *sec)
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
@@ -2513,6 +2602,15 @@ int check(const char *_objname, bool orc)
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
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 99413d4..12a9660 100644
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
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 0b79c23..eb79cb9 100644
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
