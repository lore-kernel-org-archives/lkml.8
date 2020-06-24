Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31356C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE63206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a/6KvjXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404651AbgFXPwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404591AbgFXPvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:51:51 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5863FC06179A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JPjmskX3TJ+fKttmtORqW72sBqRx/naISZAA7IqX1Dg=; b=a/6KvjXCxK/wq5Ofb7eXEgpyzg
        8pBil1sdyeTxqcKUJqjam5rePSnKoq/QMqhxcg6uWpefmc2dSpXRa0j+MdM8W4sBkWkQpMI+ZPGF0
        eQtS8VjrHWbcYs+nuveliJMkZ+aum/qFP9re8exGF0alEugDUfhu2uC7L3hXk8NqmXr/2+oDK+mMb
        yBqPr66b5HL5khlSnpR12XoNRwH6agIx/Um+ZB7WNjzHvrViJnjKVMOnujk+75x5yeY/xwB25J3Nn
        mEuf8o9iiqTC3tf+WZGGd2P9bkYZrQvDgrKQhOMKiOEFx16I11IjG7xOT9P8P9bgfbKR7DGlpIIdS
        OxTIYaig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo7gD-0004re-8D; Wed, 24 Jun 2020 15:51:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B6C963079C2;
        Wed, 24 Jun 2020 17:51:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EC404236E7760; Wed, 24 Jun 2020 17:51:13 +0200 (CEST)
Message-ID: <20200624154157.329199841@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Jun 2020 17:30:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v5 10/17] x86/static_call: Add inline static call implementation for x86-64
References: <20200624153024.794671356@infradead.org>
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

Objtool uses the trampoline naming convention to detect all the call
sites. It then annotates those call sites in the .static_call_sites
section.

During boot (and module init), the call sites are patched to call
directly into the destination function.  The temporary trampoline is
then no longer used.

[peterz: merged trampolines, put trampoline in section]
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                        |    3 
 arch/x86/include/asm/static_call.h      |   13 +++
 arch/x86/kernel/static_call.c           |    5 +
 arch/x86/kernel/vmlinux.lds.S           |    1 
 include/asm-generic/vmlinux.lds.h       |    6 +
 tools/include/linux/static_call_types.h |   28 +++++++
 tools/objtool/check.c                   |  126 ++++++++++++++++++++++++++++++++
 tools/objtool/check.h                   |    1 
 tools/objtool/elf.c                     |    8 +-
 tools/objtool/elf.h                     |    3 
 tools/objtool/objtool.h                 |    1 
 tools/objtool/orc_gen.c                 |    4 -
 tools/objtool/sync-check.sh             |    1 
 13 files changed, 190 insertions(+), 10 deletions(-)
 create mode 100644 tools/objtool/include/linux/static_call_types.h

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -214,6 +214,7 @@ config X86
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_STATIC_CALL
+	select HAVE_STATIC_CALL_INLINE		if HAVE_STACK_VALIDATION
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
@@ -229,6 +230,7 @@ config X86
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
@@ -5,12 +5,23 @@
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
+ * Having the trampoline in a special section forces GCC to emit a JMP.d32 when
+ * it does tail-call optimization on the call; since you cannot compute the
+ * relative displacement across sections.
  */
 #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
-	asm(".pushsection .text, \"ax\"				\n"	\
+	asm(".pushsection .static_call.text, \"ax\"		\n"	\
 	    ".align 4						\n"	\
 	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
 	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -6,7 +6,7 @@
 
 static void __static_call_transform(void *insn, u8 opcode, void *func)
 {
-	const void *code = text_gen_insn(opcode, (long)insn, (long)func);
+	const void *code = text_gen_insn(opcode, insn, func);
 
 	if (WARN_ONCE(*(u8 *)insn != opcode,
 		      "unexpected static call insn opcode 0x%x at %pS\n",
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
 		ENTRY_TEXT
 		ALIGN_ENTRY_TEXT_END
 		SOFTIRQENTRY_TEXT
+		STATIC_CALL_TEXT
 		*(.fixup)
 		*(.gnu.warning)
 
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -620,6 +620,12 @@
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
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _STATIC_CALL_TYPES_H
+#define _STATIC_CALL_TYPES_H
+
+#include <linux/types.h>
+#include <linux/stringify.h>
+
+#define STATIC_CALL_KEY_PREFIX		__SCK__
+#define STATIC_CALL_KEY_PREFIX_STR	__stringify(STATIC_CALL_KEY_PREFIX)
+#define STATIC_CALL_KEY_PREFIX_LEN	(sizeof(STATIC_CALL_KEY_PREFIX_STR) - 1)
+#define STATIC_CALL_KEY(name)		__PASTE(STATIC_CALL_KEY_PREFIX, name)
+
+#define STATIC_CALL_TRAMP_PREFIX	__SCT__
+#define STATIC_CALL_TRAMP_PREFIX_STR	__stringify(STATIC_CALL_TRAMP_PREFIX)
+#define STATIC_CALL_TRAMP_PREFIX_LEN	(sizeof(STATIC_CALL_TRAMP_PREFIX_STR) - 1)
+#define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
+#define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
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
@@ -16,6 +16,7 @@
 
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
+#include <linux/static_call_types.h>
 
 #define FAKE_JUMP_OFFSET -1
 
@@ -433,6 +434,99 @@ static int add_dead_ends(struct objtool_
 	return 0;
 }
 
+static int create_static_call_sections(struct objtool_file *file)
+{
+	struct section *sec, *reloc_sec;
+	struct reloc *reloc;
+	struct static_call_site *site;
+	struct instruction *insn;
+	struct symbol *key_sym;
+	char *key_name, *tmp;
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
+	sec = elf_create_section(file->elf, ".static_call_sites", SHF_WRITE,
+				 sizeof(struct static_call_site), idx);
+	if (!sec)
+		return -1;
+
+	reloc_sec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
+	if (!reloc_sec)
+		return -1;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->static_call_list, static_call_node) {
+
+		site = (struct static_call_site *)sec->data->d_buf + idx;
+		memset(site, 0, sizeof(struct static_call_site));
+
+		/* populate reloc for 'addr' */
+		reloc = malloc(sizeof(*reloc));
+		if (!reloc) {
+			perror("malloc");
+			return -1;
+		}
+		memset(reloc, 0, sizeof(*reloc));
+		reloc->sym = insn->sec->sym;
+		reloc->addend = insn->offset;
+		reloc->type = R_X86_64_PC32;
+		reloc->offset = idx * sizeof(struct static_call_site);
+		reloc->sec = reloc_sec;
+		elf_add_reloc(file->elf, reloc);
+
+		/* find key symbol */
+		key_name = strdup(insn->call_dest->name);
+		if (strncmp(key_name, STATIC_CALL_TRAMP_PREFIX_STR,
+			    strlen(STATIC_CALL_TRAMP_PREFIX_STR))) {
+			WARN("static_call: trampoline name malformed: %s", key_name);
+			return -1;
+		}
+		tmp = key_name + STATIC_CALL_TRAMP_PREFIX_LEN - STATIC_CALL_KEY_PREFIX_LEN;
+		memcpy(tmp, STATIC_CALL_KEY_PREFIX_STR, STATIC_CALL_KEY_PREFIX_LEN);
+
+		key_sym = find_symbol_by_name(file->elf, tmp);
+		if (!key_sym) {
+			WARN("static_call: can't find static_call_key symbol: %s", tmp);
+			return -1;
+		}
+		free(key_name);
+
+		/* populate reloc for 'key' */
+		reloc = malloc(sizeof(*reloc));
+		if (!reloc) {
+			perror("malloc");
+			return -1;
+		}
+		memset(reloc, 0, sizeof(*reloc));
+		reloc->sym = key_sym;
+		reloc->addend = 0;
+		reloc->type = R_X86_64_PC32;
+		reloc->offset = idx * sizeof(struct static_call_site) + 4;
+		reloc->sec = reloc_sec;
+		elf_add_reloc(file->elf, reloc);
+
+		idx++;
+	}
+
+	if (elf_rebuild_reloc_section(file->elf, reloc_sec))
+		return -1;
+
+	return 0;
+}
+
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
@@ -1522,6 +1616,23 @@ static int read_intra_function_calls(str
 	return 0;
 }
 
+static int read_static_call_tramps(struct objtool_file *file)
+{
+	struct section *sec;
+	struct symbol *func;
+
+	for_each_sec(file, sec) {
+		list_for_each_entry(func, &sec->symbol_list, list) {
+			if (func->bind == STB_GLOBAL &&
+			    !strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
+				     strlen(STATIC_CALL_TRAMP_PREFIX_STR)))
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
@@ -1601,6 +1712,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_static_call_tramps(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -2406,6 +2521,11 @@ static int validate_branch(struct objtoo
 			if (dead_end_function(file, insn->call_dest))
 				return 0;
 
+			if (insn->type == INSN_CALL && insn->call_dest->static_call_tramp) {
+				list_add_tail(&insn->static_call_node,
+					      &file->static_call_list);
+			}
+
 			break;
 
 		case INSN_JUMP_CONDITIONAL:
@@ -2765,6 +2885,7 @@ int check(const char *_objname, bool orc
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
+	INIT_LIST_HEAD(&file.static_call_list);
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
@@ -2812,6 +2933,11 @@ int check(const char *_objname, bool orc
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
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -22,6 +22,7 @@ struct insn_state {
 struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
+	struct list_head static_call_node;
 	struct section *sec;
 	unsigned long offset;
 	unsigned int len;
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -652,7 +652,7 @@ struct elf *elf_open_read(const char *na
 }
 
 struct section *elf_create_section(struct elf *elf, const char *name,
-				   size_t entsize, int nr)
+				   unsigned int sh_flags, size_t entsize, int nr)
 {
 	struct section *sec, *shstrtab;
 	size_t size = entsize * nr;
@@ -712,7 +712,7 @@ struct section *elf_create_section(struc
 	sec->sh.sh_entsize = entsize;
 	sec->sh.sh_type = SHT_PROGBITS;
 	sec->sh.sh_addralign = 1;
-	sec->sh.sh_flags = SHF_ALLOC;
+	sec->sh.sh_flags = SHF_ALLOC | sh_flags;
 
 
 	/* Add section name to .shstrtab (or .strtab for Clang) */
@@ -767,7 +767,7 @@ static struct section *elf_create_rel_re
 	strcpy(relocname, ".rel");
 	strcat(relocname, base->name);
 
-	sec = elf_create_section(elf, relocname, sizeof(GElf_Rel), 0);
+	sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rel), 0);
 	free(relocname);
 	if (!sec)
 		return NULL;
@@ -797,7 +797,7 @@ static struct section *elf_create_rela_r
 	strcpy(relocname, ".rela");
 	strcat(relocname, base->name);
 
-	sec = elf_create_section(elf, relocname, sizeof(GElf_Rela), 0);
+	sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rela), 0);
 	free(relocname);
 	if (!sec)
 		return NULL;
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -56,6 +56,7 @@ struct symbol {
 	unsigned int len;
 	struct symbol *pfunc, *cfunc, *alias;
 	bool uaccess_safe;
+	bool static_call_tramp;
 };
 
 struct reloc {
@@ -120,7 +121,7 @@ static inline u32 reloc_hash(struct relo
 }
 
 struct elf *elf_open_read(const char *name, int flags);
-struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
+struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
 void elf_add_reloc(struct elf *elf, struct reloc *reloc);
 int elf_write_insn(struct elf *elf, struct section *sec,
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -16,6 +16,7 @@ struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 20);
+	struct list_head static_call_list;
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -177,7 +177,7 @@ int create_orc_sections(struct objtool_f
 
 
 	/* create .orc_unwind_ip and .rela.orc_unwind_ip sections */
-	sec = elf_create_section(file->elf, ".orc_unwind_ip", sizeof(int), idx);
+	sec = elf_create_section(file->elf, ".orc_unwind_ip", 0, sizeof(int), idx);
 	if (!sec)
 		return -1;
 
@@ -186,7 +186,7 @@ int create_orc_sections(struct objtool_f
 		return -1;
 
 	/* create .orc_unwind section */
-	u_sec = elf_create_section(file->elf, ".orc_unwind",
+	u_sec = elf_create_section(file->elf, ".orc_unwind", 0,
 				   sizeof(struct orc_entry), idx);
 
 	/* populate sections */
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -7,6 +7,7 @@ arch/x86/include/asm/orc_types.h
 arch/x86/include/asm/emulate_prefix.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
+include/linux/static_call_types.h
 '
 
 check_2 () {


