Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2551FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB24E20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmC/61DI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ARU/wUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgIAL6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:58:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39762 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgIALt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:28 -0400
Date:   Tue, 01 Sep 2020 11:48:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGQjeWf1hLiLciva78HOycNG8H6yPpz+kQHneI4zQlA=;
        b=NmC/61DIfhzPPaifQEOqZBA/ffqstDwFKmHM5QD51RZnj2ST+8I0ltuZ6acdEbdPaW5lin
        spIho4DZV2AqlxXinAI4fIIzidNUohA3RyVOGlrqdqvAp4bqJ21hsE10vpcayXYNL9HieO
        0ZXVgBLJoQ+DVvaQRckm6D8meYwt+P5pZAgSUpHJIOQNGWI5e7g+2/0PQZDm4l/Lf5ESkF
        j6GNb+YrmdNqeaAsrwAGQx1buC/MX2dSGjBMJWAkQkh6Y7jW/Cc9T7f+1JEaDSa1R8tyXZ
        oMkVnRO0QxB9cgArB7ZkxMhT99PczZh4wsVQ5RhfqiA61LVPNexKCZuU1kZbYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGQjeWf1hLiLciva78HOycNG8H6yPpz+kQHneI4zQlA=;
        b=0ARU/wUdFWYaxIQ0v4uIs1GvQxwckGI1z9cswUWt55BBht3T1aLGe7HzsxYmHDCtGy3lR9
        96o+oWx4nog93pAA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] x86/static_call: Add inline static call
 implementation for x86-64
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135804.864271425@infradead.org>
References: <20200818135804.864271425@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088526.20229.3949504518078094725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     1e7e47883830aae5e8246a22ca2fc6883c61acdf
Gitweb:        https://git.kernel.org/tip/1e7e47883830aae5e8246a22ca2fc6883c61acdf
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Tue, 18 Aug 2020 15:57:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:05 +02:00

x86/static_call: Add inline static call implementation for x86-64

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20200818135804.864271425@infradead.org
---
 arch/x86/Kconfig                        |   3 +-
 arch/x86/include/asm/static_call.h      |  13 +-
 arch/x86/kernel/static_call.c           |   3 +-
 arch/x86/kernel/vmlinux.lds.S           |   1 +-
 include/asm-generic/vmlinux.lds.h       |   6 +-
 tools/include/linux/static_call_types.h |  28 +++++-
 tools/objtool/check.c                   | 130 +++++++++++++++++++++++-
 tools/objtool/check.h                   |   1 +-
 tools/objtool/elf.c                     |   8 +-
 tools/objtool/elf.h                     |   3 +-
 tools/objtool/objtool.h                 |   1 +-
 tools/objtool/orc_gen.c                 |   4 +-
 tools/objtool/sync-check.sh             |   1 +-
 13 files changed, 193 insertions(+), 9 deletions(-)
 create mode 100644 tools/include/linux/static_call_types.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 595c06b..8a48d3e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -216,6 +216,7 @@ config X86
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_STATIC_CALL
+	select HAVE_STATIC_CALL_INLINE		if HAVE_STACK_VALIDATION
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
@@ -231,6 +232,7 @@ config X86
 	select RTC_MC146818_LIB
 	select SPARSE_IRQ
 	select SRCU
+	select STACK_VALIDATION			if HAVE_STACK_VALIDATION && (HAVE_STATIC_CALL_INLINE || RETPOLINE)
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select USER_STACKTRACE_SUPPORT
@@ -452,7 +454,6 @@ config GOLDFISH
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
 	default y
-	select STACK_VALIDATION if HAVE_STACK_VALIDATION
 	help
 	  Compile kernel with the retpoline compiler options to guard against
 	  kernel-to-user data leaks by avoiding speculative indirect
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 07aa879..33469ae 100644
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
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 0565825..5ff2b63 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -26,6 +26,9 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
 	if (tramp)
 		__static_call_transform(tramp, JMP32_INSN_OPCODE, func);
 
+	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
+		__static_call_transform(site, CALL_INSN_OPCODE, func);
+
 	mutex_unlock(&text_mutex);
 }
 EXPORT_SYMBOL_GPL(arch_static_call_transform);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9a03e5b..2568f4c 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -136,6 +136,7 @@ SECTIONS
 		ENTRY_TEXT
 		ALIGN_ENTRY_TEXT_END
 		SOFTIRQENTRY_TEXT
+		STATIC_CALL_TEXT
 		*(.fixup)
 		*(.gnu.warning)
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0088a5c..0502087 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -642,6 +642,12 @@
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
 
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
new file mode 100644
index 0000000..408d345
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
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e034a8f..f8f7a40 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -16,6 +16,7 @@
 
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
+#include <linux/static_call_types.h>
 
 #define FAKE_JUMP_OFFSET -1
 
@@ -433,6 +434,103 @@ reachable:
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
+		if (!key_name) {
+			perror("strdup");
+			return -1;
+		}
+		if (strncmp(key_name, STATIC_CALL_TRAMP_PREFIX_STR,
+			    STATIC_CALL_TRAMP_PREFIX_LEN)) {
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
@@ -1522,6 +1620,23 @@ static int read_intra_function_calls(struct objtool_file *file)
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
@@ -1601,6 +1716,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_static_call_tramps(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -2432,6 +2551,11 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (dead_end_function(file, insn->call_dest))
 				return 0;
 
+			if (insn->type == INSN_CALL && insn->call_dest->static_call_tramp) {
+				list_add_tail(&insn->static_call_node,
+					      &file->static_call_list);
+			}
+
 			break;
 
 		case INSN_JUMP_CONDITIONAL:
@@ -2791,6 +2915,7 @@ int check(const char *_objname, bool orc)
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
+	INIT_LIST_HEAD(&file.static_call_list);
 	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
@@ -2838,6 +2963,11 @@ int check(const char *_objname, bool orc)
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
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 061aa96..36d38b9 100644
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
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3ddbd66..4e1d746 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -652,7 +652,7 @@ err:
 }
 
 struct section *elf_create_section(struct elf *elf, const char *name,
-				   size_t entsize, int nr)
+				   unsigned int sh_flags, size_t entsize, int nr)
 {
 	struct section *sec, *shstrtab;
 	size_t size = entsize * nr;
@@ -712,7 +712,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	sec->sh.sh_entsize = entsize;
 	sec->sh.sh_type = SHT_PROGBITS;
 	sec->sh.sh_addralign = 1;
-	sec->sh.sh_flags = SHF_ALLOC;
+	sec->sh.sh_flags = SHF_ALLOC | sh_flags;
 
 
 	/* Add section name to .shstrtab (or .strtab for Clang) */
@@ -767,7 +767,7 @@ static struct section *elf_create_rel_reloc_section(struct elf *elf, struct sect
 	strcpy(relocname, ".rel");
 	strcat(relocname, base->name);
 
-	sec = elf_create_section(elf, relocname, sizeof(GElf_Rel), 0);
+	sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rel), 0);
 	free(relocname);
 	if (!sec)
 		return NULL;
@@ -797,7 +797,7 @@ static struct section *elf_create_rela_reloc_section(struct elf *elf, struct sec
 	strcpy(relocname, ".rela");
 	strcat(relocname, base->name);
 
-	sec = elf_create_section(elf, relocname, sizeof(GElf_Rela), 0);
+	sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rela), 0);
 	free(relocname);
 	if (!sec)
 		return NULL;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 6cc80a0..807f8c6 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -56,6 +56,7 @@ struct symbol {
 	unsigned int len;
 	struct symbol *pfunc, *cfunc, *alias;
 	bool uaccess_safe;
+	bool static_call_tramp;
 };
 
 struct reloc {
@@ -120,7 +121,7 @@ static inline u32 reloc_hash(struct reloc *reloc)
 }
 
 struct elf *elf_open_read(const char *name, int flags);
-struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
+struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
 void elf_add_reloc(struct elf *elf, struct reloc *reloc);
 int elf_write_insn(struct elf *elf, struct section *sec,
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index 528028a..9a7cd0b 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -16,6 +16,7 @@ struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 20);
+	struct list_head static_call_list;
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 968f55e..e6b2363 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -177,7 +177,7 @@ int create_orc_sections(struct objtool_file *file)
 
 
 	/* create .orc_unwind_ip and .rela.orc_unwind_ip sections */
-	sec = elf_create_section(file->elf, ".orc_unwind_ip", sizeof(int), idx);
+	sec = elf_create_section(file->elf, ".orc_unwind_ip", 0, sizeof(int), idx);
 	if (!sec)
 		return -1;
 
@@ -186,7 +186,7 @@ int create_orc_sections(struct objtool_file *file)
 		return -1;
 
 	/* create .orc_unwind section */
-	u_sec = elf_create_section(file->elf, ".orc_unwind",
+	u_sec = elf_create_section(file->elf, ".orc_unwind", 0,
 				   sizeof(struct orc_entry), idx);
 
 	/* populate sections */
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 2a1261b..aa099b2 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -7,6 +7,7 @@ arch/x86/include/asm/orc_types.h
 arch/x86/include/asm/emulate_prefix.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
+include/linux/static_call_types.h
 '
 
 check_2 () {
