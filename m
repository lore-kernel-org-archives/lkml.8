Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180C6C54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCC6208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EHqc1dMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgCXOY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:24:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53638 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgCXOYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=j+Q40xn03UikqdPjSb5wUXZtgGMXd63RWB6qfws9VXo=; b=EHqc1dMsLkmHQp5HSf5TOtleNC
        KXQIVd2EHkOhsheiHtd/eAX4cBU2rkP49auWpgIKMYSTCE2hVa2rud/sn7wdK4ARhgGqodkVHyDQi
        EYTwJ7IDUORI9SWLAElpuP/UgoGPX6I62skQf1wY9nXD9u4UmLb3zPO9sg/NT8hxHW+sEK5cfr0+G
        dUsgCRv9FJT0JVCus6YB/g+SemDmvjM90IL0/cPyQTZez3zNyZJRuLkmsB4bOGIEE/+8NsWHqhnHI
        cfS6iz5nGVIzz9xAW7tO3oG6Zr+HK42SpPgPmU2ETTB7ERmuKKEYJKW1OqVKV3EZuCzG/qCxtKWQn
        NItCB2kQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGkTv-0003on-3v; Tue, 24 Mar 2020 14:24:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F522307964;
        Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 18E04286C13B7; Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Message-Id: <20200324142245.880990363@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 14:56:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [RESEND][PATCH v3 10/17] x86/static_call: Add inline static call implementation for x86-64
References: <20200324135603.483964896@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Add the inline static call implementation for x86-64. The generated code
is identical to the out-of-line case, except we move the trampoline into
it's own section.

Then objtool uses the trampoline section to detect all the call sites,
which it writes into the .static_call_sites section.

During boot (and module init), the call sites are patched to call
directly into the destination function.  The temporary trampoline is
then no longer used.

[peterz: merged trampolines, put trampoline in section]
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                        |    3 
 arch/x86/include/asm/static_call.h      |   15 +++
 arch/x86/kernel/static_call.c           |    3 
 arch/x86/kernel/vmlinux.lds.S           |    1 
 include/asm-generic/vmlinux.lds.h       |    6 +
 tools/include/linux/static_call_types.h |   25 ++++++
 tools/objtool/check.c                   |  128 +++++++++++++++++++++++++++++++-
 tools/objtool/check.h                   |    2 
 tools/objtool/elf.h                     |    1 
 tools/objtool/sync-check.sh             |    1 
 10 files changed, 182 insertions(+), 3 deletions(-)
 create mode 100644 tools/objtool/include/linux/static_call_types.h

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -210,6 +210,7 @@ config X86
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_STATIC_CALL
+	select HAVE_STATIC_CALL_INLINE		if HAVE_STACK_VALIDATION
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
@@ -225,6 +226,7 @@ config X86
 	select RTC_MC146818_LIB
 	select SPARSE_IRQ
 	select SRCU
+	select STACK_VALIDATION			if HAVE_STACK_VALIDATION && (HAVE_STATIC_CALL_INLINE || RETPOLINE)
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select USER_STACKTRACE_SUPPORT
@@ -450,7 +452,6 @@ config GOLDFISH
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
 	default y
-	select STACK_VALIDATION if HAVE_STACK_VALIDATION
 	help
 	  Compile kernel with the retpoline compiler options to guard against
 	  kernel-to-user data leaks by avoiding speculative indirect
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -5,12 +5,25 @@
 #include <asm/text-patching.h>
 
 /*
+ * For CONFIG_HAVE_STATIC_CALL_INLINE, this is a temporary trampoline which
+ * uses the current value of the key->func pointer to do an indirect jump to
+ * the function.  This trampoline is only used during boot, before the call
+ * sites get patched by static_call_update().  The name of this trampoline has
+ * a magical aspect: objtool uses it to find static call sites so it can create
+ * the .static_call_sites section.
+ *
  * For CONFIG_HAVE_STATIC_CALL, this is a permanent trampoline which
  * does a direct jump to the function.  The direct jump gets patched by
  * static_call_update().
+ *
+ * Having the trampoline in a special section has two benefits:
+ *  - it makes it 'easy' for objtool to find all the call-sites;
+ *  - it forces GCC to emit a JMP.d32 when it does tail-call optimization on
+ *    the call; since you cannot compute the relative displacement across
+ *    sections.
  */
 #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
-	asm(".pushsection .text, \"ax\"				\n"	\
+	asm(".pushsection .static_call.text, \"ax\"		\n"	\
 	    ".align 4						\n"	\
 	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
 	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -26,6 +26,9 @@ void arch_static_call_transform(void *si
 	if (tramp)
 		__static_call_transform(tramp, JMP32_INSN_OPCODE, func);
 
+	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
+		__static_call_transform(site, CALL_INSN_OPCODE, func);
+
 	mutex_unlock(&text_mutex);
 }
 EXPORT_SYMBOL_GPL(arch_static_call_transform);
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -136,6 +136,7 @@ SECTIONS
 		IRQENTRY_TEXT
 		ALIGN_ENTRY_TEXT_END
 		SOFTIRQENTRY_TEXT
+		STATIC_CALL_TEXT
 		*(.fixup)
 		*(.gnu.warning)
 
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -609,6 +609,12 @@
 		*(.softirqentry.text)					\
 		__softirqentry_text_end = .;
 
+#define STATIC_CALL_TEXT						\
+		ALIGN_FUNCTION();					\
+		__static_call_text_start = .;				\
+		*(.static_call.text)					\
+		__static_call_text_end = .;
+
 /* Section used for early init (in .S files) */
 #define HEAD_TEXT  KEEP(*(.head.text))
 
--- /dev/null
+++ b/tools/include/linux/static_call_types.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _STATIC_CALL_TYPES_H
+#define _STATIC_CALL_TYPES_H
+
+#include <linux/types.h>
+#include <linux/stringify.h>
+
+#define STATIC_CALL_PREFIX	__SC__
+#define STATIC_CALL_PREFIX_STR	__stringify(STATIC_CALL_PREFIX)
+
+#define STATIC_CALL_NAME(name)	__PASTE(STATIC_CALL_PREFIX, name)
+
+#define STATIC_CALL_TRAMP(name)	    STATIC_CALL_NAME(name##_tramp)
+#define STATIC_CALL_TRAMP_STR(name) __stringify(STATIC_CALL_TRAMP(name))
+
+/*
+ * The static call site table needs to be created by external tooling (objtool
+ * or a compiler plugin).
+ */
+struct static_call_site {
+	s32 addr;
+	s32 key;
+};
+
+#endif /* _STATIC_CALL_TYPES_H */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -15,6 +15,7 @@
 
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
+#include <linux/static_call_types.h>
 
 #define FAKE_JUMP_OFFSET -1
 
@@ -1345,6 +1346,21 @@ static int read_retpoline_hints(struct o
 	return 0;
 }
 
+static int read_static_call_tramps(struct objtool_file *file)
+{
+	struct section *sec, *sc_sec = find_section_by_name(file->elf, ".static_call.text");
+	struct symbol *func;
+
+	for_each_sec(file, sec) {
+		list_for_each_entry(func, &sec->symbol_list, list) {
+			if (func->sec == sc_sec)
+				func->static_call_tramp = true;
+		}
+	}
+
+	return 0;
+}
+
 static void mark_rodata(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1416,6 +1432,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_static_call_tramps(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -2143,6 +2163,12 @@ static int validate_branch(struct objtoo
 			if (ret)
 				return ret;
 
+			if (insn->type == INSN_CALL && insn->call_dest->static_call_tramp) {
+				list_add_tail(&insn->static_call_node,
+					      &file->static_call_list);
+			}
+
+
 			if (!no_fp && func && !is_fentry_call(insn) &&
 			    !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
@@ -2463,6 +2489,98 @@ static int validate_reachable_instructio
 	return 0;
 }
 
+static int create_static_call_sections(struct objtool_file *file)
+{
+	struct section *sec, *rela_sec;
+	struct rela *rela;
+	struct static_call_site *site;
+	struct instruction *insn;
+	char *key_name, *tmp;
+	struct symbol *key_sym;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".static_call_sites");
+	if (sec) {
+		INIT_LIST_HEAD(&file->static_call_list);
+		WARN("file already has .static_call_sites section, skipping");
+		return 0;
+	}
+
+	if (list_empty(&file->static_call_list))
+		return 0;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->static_call_list, static_call_node)
+		idx++;
+
+	sec = elf_create_section(file->elf, ".static_call_sites",
+				 sizeof(struct static_call_site), idx);
+	if (!sec)
+		return -1;
+
+	rela_sec = elf_create_rela_section(file->elf, sec);
+	if (!rela_sec)
+		return -1;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->static_call_list, static_call_node) {
+
+		site = (struct static_call_site *)sec->data->d_buf + idx;
+		memset(site, 0, sizeof(struct static_call_site));
+
+		/* populate rela for 'addr' */
+		rela = malloc(sizeof(*rela));
+		if (!rela) {
+			perror("malloc");
+			return -1;
+		}
+		memset(rela, 0, sizeof(*rela));
+		rela->sym = insn->sec->sym;
+		rela->addend = insn->offset;
+		rela->type = R_X86_64_PC32;
+		rela->offset = idx * sizeof(struct static_call_site);
+		list_add_tail(&rela->list, &rela_sec->rela_list);
+		hash_add(rela_sec->rela_hash, &rela->hash, rela->offset);
+
+		/* find key symbol */
+		key_name = strdup(insn->call_dest->name);
+		tmp = strstr(key_name, "_tramp");
+		if (!tmp) {
+			WARN("static_call: trampoline name malformed: %s", key_name);
+			return -1;
+		}
+		*tmp = 0;
+
+		key_sym = find_symbol_by_name(file->elf, key_name);
+		if (!key_sym) {
+			WARN("static_call: can't find static_call_key symbol: %s", key_name);
+			return -1;
+		}
+		free(key_name);
+
+		/* populate rela for 'key' */
+		rela = malloc(sizeof(*rela));
+		if (!rela) {
+			perror("malloc");
+			return -1;
+		}
+		memset(rela, 0, sizeof(*rela));
+		rela->sym = key_sym;
+		rela->addend = 0;
+		rela->type = R_X86_64_PC32;
+		rela->offset = idx * sizeof(struct static_call_site) + 4;
+		list_add_tail(&rela->list, &rela_sec->rela_list);
+		hash_add(rela_sec->rela_hash, &rela->hash, rela->offset);
+
+		idx++;
+	}
+
+	if (elf_rebuild_rela_section(rela_sec))
+		return -1;
+
+	return 0;
+}
+
 static void cleanup(struct objtool_file *file)
 {
 	struct instruction *insn, *tmpinsn;
@@ -2488,12 +2606,13 @@ int check(const char *_objname, bool orc
 
 	objname = _objname;
 
-	file.elf = elf_read(objname, orc ? O_RDWR : O_RDONLY);
+	file.elf = elf_read(objname, O_RDWR);
 	if (!file.elf)
 		return 1;
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
+	INIT_LIST_HEAD(&file.static_call_list);
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
@@ -2532,6 +2651,11 @@ int check(const char *_objname, bool orc
 		warnings += ret;
 	}
 
+	ret = create_static_call_sections(&file);
+	if (ret < 0)
+		goto out;
+	warnings += ret;
+
 	if (orc) {
 		ret = create_orc(&file);
 		if (ret < 0)
@@ -2540,7 +2664,9 @@ int check(const char *_objname, bool orc
 		ret = create_orc_sections(&file);
 		if (ret < 0)
 			goto out;
+	}
 
+	if (orc || !list_empty(&file.static_call_list)) {
 		ret = elf_write(file.elf);
 		if (ret < 0)
 			goto out;
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -28,6 +28,7 @@ struct insn_state {
 struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
+	struct list_head static_call_node;
 	struct section *sec;
 	unsigned long offset;
 	unsigned int len;
@@ -51,6 +52,7 @@ struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 16);
+	struct list_head static_call_list;
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -51,6 +51,7 @@ struct symbol {
 	unsigned int len;
 	struct symbol *pfunc, *cfunc, *alias;
 	bool uaccess_safe;
+	bool static_call_tramp;
 };
 
 struct rela {
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -7,6 +7,7 @@ arch/x86/include/asm/orc_types.h
 arch/x86/include/asm/emulate_prefix.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
+include/linux/static_call_types.h
 '
 
 check_2 () {


