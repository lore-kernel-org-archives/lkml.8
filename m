Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69CDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C0F206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JNo1WdGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgHCOdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCOdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:33:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D651C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MQm5KBxfsva4yRPN/kLNSRO/7YlnpPiEdEdDUTsBjzM=; b=JNo1WdGE4NuZQRSIxtR3q+YxuA
        dnymcgjXafRlec3I8qPSLlEIzWrxAemNuh0F8m7FCo8ikod5GvBtLfmT3MQ8VTR3Lb6+Om+CPATb6
        V927bLglRaGqmqIcMT7yE9/q86IKUagTqrV6GLXRXlU6rrOcfY+o87f4uRAe4uH8w+Z7sCyFTFQ0F
        6AqarAQraNKNDkiq8ZmgbIKyUS0MpQA/aKcW9oYw6w5lIrIQRUP9pYpbNwK5mZAykpN117551M9/Q
        iggQ+G44U474nL6YpEAAXBg4TQO/zyILhk+VxiSQ0MdmFCcDnB6AjoF12WpbX4xNkL6/+KQmdJFAZ
        I5jQnZlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2bVx-00040m-ST; Mon, 03 Aug 2020 14:33:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFCF0306CEE;
        Mon,  3 Aug 2020 16:32:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF70B2149384E; Mon,  3 Aug 2020 16:32:31 +0200 (CEST)
Date:   Mon, 3 Aug 2020 16:32:31 +0200
From:   peterz@infradead.org
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mbenes@suse.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        jgross@suse.com
Subject: [RFC][PATCH] objtool,x86_64,paravirt: Add pv_ops[] support
Message-ID: <20200803143231.GE2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas wanted paramuck vs noinstr, here goes. Very rough, very nasty,
mostly works.

It requires call sites are the normal indirect call, and not mangled
retpoison (slow_down_io() had those), it also requires pv_ops[]
assignments are single instructions and not laundered through some
pointless intermediate helper (hyperv).

It doesn't warn when you get any of that wrong.

But if you have it all lined up right, it will warn about noinstr
violations due to paramuck:

$ ./objtool check -afl ../../defconfig-build/vmlinux.o
../../defconfig-build/vmlinux.o: warning: objtool: xen_pv_evtchn_do_upcall()+0x69: return with instrumentation enabled
../../defconfig-build/vmlinux.o: warning: objtool: exc_double_fault()+0x15: call pv_ops[48] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: pv_op[48]: xen_read_cr2
../../defconfig-build/vmlinux.o: warning: objtool: exc_double_fault()+0x15: call to {dynamic}() leaves .noinstr.text section
../../defconfig-build/vmlinux.o: warning: objtool: exc_debug()+0x29: call pv_ops[4] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: pv_op[4]: native_get_debugreg
../../defconfig-build/vmlinux.o: warning: objtool: exc_debug()+0x29: call to {dynamic}() leaves .noinstr.text section
../../defconfig-build/vmlinux.o: warning: objtool: noist_exc_debug()+0x26: call pv_ops[4] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: pv_op[4]: native_get_debugreg
../../defconfig-build/vmlinux.o: warning: objtool: noist_exc_debug()+0x26: call to {dynamic}() leaves .noinstr.text section
../../defconfig-build/vmlinux.o: warning: objtool: exc_nmi()+0x3a: call pv_ops[48] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: pv_op[48]: xen_read_cr2
../../defconfig-build/vmlinux.o: warning: objtool: exc_nmi()+0x3a: call to {dynamic}() leaves .noinstr.text section
../../defconfig-build/vmlinux.o: warning: objtool: mce_setup()+0x80: call pv_ops[25] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: pv_op[25]: native_cpuid
../../defconfig-build/vmlinux.o: warning: objtool: mce_setup()+0x80: call to {dynamic}() leaves .noinstr.text section
../../defconfig-build/vmlinux.o: warning: objtool: do_machine_check()+0x46: call to mce_rdmsrl() leaves .noinstr.text section
../../defconfig-build/vmlinux.o: warning: objtool: exc_machine_check()+0x24: call pv_ops[4] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: pv_op[4]: native_get_debugreg
../../defconfig-build/vmlinux.o: warning: objtool: exc_machine_check()+0x24: call to {dynamic}() leaves .noinstr.text section
../../defconfig-build/vmlinux.o: warning: objtool: noist_exc_machine_check()+0x24: call pv_ops[4] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: pv_op[4]: native_get_debugreg
../../defconfig-build/vmlinux.o: warning: objtool: noist_exc_machine_check()+0x24: call to {dynamic}() leaves .noinstr.text section
../../defconfig-build/vmlinux.o: warning: objtool: exc_page_fault()+0xe: call pv_ops[48] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: pv_op[48]: xen_read_cr2
../../defconfig-build/vmlinux.o: warning: objtool: exc_page_fault()+0xe: call to {dynamic}() leaves .noinstr.text section
../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0xf17: call pv_ops[32] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x12f1: call pv_ops[35] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0xf5a: call pv_ops[32] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x1002: call pv_ops[32] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x1186: call pv_ops[32] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x12ba: call pv_ops[32] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x12a7: call pv_ops[32] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x124c: call pv_ops[32] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x14f0: call pv_ops[32] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: .entry.text+0x1683: call pv_ops[32] from noinstr

[ funny that, WTH does x86_64 have IRET pv_ops... ]

Requested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h    |   8 +--
 arch/x86/kernel/cpu/mshyperv.c     |   7 ---
 drivers/clocksource/hyperv_timer.c |   7 +++
 include/asm-generic/mshyperv.h     |   1 -
 lib/Kconfig.debug                  |   2 +-
 tools/objtool/Makefile             |   2 +-
 tools/objtool/arch.h               |   2 +-
 tools/objtool/arch/x86/decode.c    |  30 ++++++++-
 tools/objtool/builtin-check.c      |  10 +--
 tools/objtool/builtin-orc.c        |  10 +--
 tools/objtool/check.c              | 126 ++++++++++++++++++++++++++++++++++---
 tools/objtool/elf.h                |   1 +
 tools/objtool/objtool.c            |  46 ++++++++++++++
 tools/objtool/objtool.h            |   9 +++
 14 files changed, 218 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 3d2afecde50c..db30b35f0d59 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -39,11 +39,11 @@ static inline u64 paravirt_steal_clock(int cpu)
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
-	pv_ops.cpu.io_delay();
+	PVOP_VCALL0(cpu.io_delay);
 #ifdef REALLY_SLOW_IO
-	pv_ops.cpu.io_delay();
-	pv_ops.cpu.io_delay();
-	pv_ops.cpu.io_delay();
+	PVOP_VCALL0(cpu.io_delay);
+	PVOP_VCALL0(cpu.io_delay);
+	PVOP_VCALL0(cpu.io_delay);
 #endif
 }
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index af94f05a5c66..31125448b174 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -361,13 +361,6 @@ static void __init ms_hyperv_init_platform(void)
 #endif
 }
 
-void hv_setup_sched_clock(void *sched_clock)
-{
-#ifdef CONFIG_PARAVIRT
-	pv_ops.time.sched_clock = sched_clock;
-#endif
-}
-
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.name			= "Microsoft Hyper-V",
 	.detect			= ms_hyperv_platform,
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 09aa44cb8a91..bed769a84637 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -418,6 +418,13 @@ static struct clocksource hyperv_cs_msr = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static __always_inline void hv_setup_sched_clock(void *sched_clock)
+{
+#ifdef CONFIG_PARAVIRT
+	pv_ops.time.sched_clock = sched_clock;
+#endif
+}
+
 static bool __init hv_init_tsc_clocksource(void)
 {
 	u64		tsc_msr;
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 1c4fd950f091..c5edc5e08b94 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -168,7 +168,6 @@ void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
 void hyperv_cleanup(void);
-void hv_setup_sched_clock(void *sched_clock);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline bool hv_is_hibernation_supported(void) { return false; }
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3e64a8a809f9..b52957d964a2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -399,7 +399,7 @@ config STACK_VALIDATION
 
 config VMLINUX_VALIDATION
 	bool
-	depends on STACK_VALIDATION && DEBUG_ENTRY && !PARAVIRT
+	depends on STACK_VALIDATION && DEBUG_ENTRY
 	default y
 
 config DEBUG_FORCE_WEAK_PER_CPU
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 7770edcda3a0..d41bfa2130d8 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -38,7 +38,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
-CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
+CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -ggdb3 $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 2e2ce089b0e9..41c3c1d75887 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -72,7 +72,7 @@ struct instruction;
 
 void arch_initial_func_cfi_state(struct cfi_init_state *state);
 
-int arch_decode_instruction(const struct elf *elf, const struct section *sec,
+int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate,
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 1967370440b3..285efbc4e9be 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -15,6 +15,7 @@
 #include "../../elf.h"
 #include "../../arch.h"
 #include "../../warn.h"
+#include "../../objtool.h"
 
 static unsigned char op_to_cfi_reg[][2] = {
 	{CFI_AX, CFI_R8},
@@ -82,12 +83,13 @@ unsigned long arch_jump_destination(struct instruction *insn)
 		return -1; \
 	else for (list_add_tail(&op->list, ops_list); op; op = NULL)
 
-int arch_decode_instruction(const struct elf *elf, const struct section *sec,
+int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate,
 			    struct list_head *ops_list)
 {
+	const struct elf *elf = file->elf;
 	struct insn insn;
 	int x86_64, sign;
 	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
@@ -469,6 +471,32 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		*type = INSN_RETURN;
 		break;
 
+	case 0xc7: /* mov imm, r/m */
+		if (insn.length == 3+4+4 && !strcmp(sec->name, ".init.text")) {
+//		if (rex == 48 && modrm == 0x05) { /* movq $imm32, disp32(%rip) */
+			struct reloc *imm, *disp;
+			struct symbol *func;
+
+			imm = find_reloc_by_dest(elf, (void *)sec, offset+3);
+			disp = find_reloc_by_dest(elf, (void *)sec, offset+7);
+
+			if (imm && !strcmp(imm->sym->name, "pv_ops")) {
+				int idx = (imm->addend + sizeof(void *)) / sizeof(void *);
+
+				func = disp->sym;
+				if (disp->sym->type == STT_SECTION) {
+					func = find_symbol_by_offset(disp->sym->sec, disp->addend);
+					if (!func) {
+						WARN("FAIL %s+%d", disp->sym->name, disp->addend);
+						return -1;
+					}
+				}
+
+				file_pv_add(file, idx, func);
+			}
+		}
+		break;
+
 	case 0xcf: /* iret */
 		/*
 		 * Handle sync_core(), which has an IRET to self.
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 7a44174967b5..1109dd69f953 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -40,18 +40,10 @@ const struct option check_options[] = {
 
 int cmd_check(int argc, const char **argv)
 {
-	const char *objname, *s;
-
 	argc = parse_options(argc, argv, check_options, check_usage, 0);
 
 	if (argc != 1)
 		usage_with_options(check_usage, check_options);
 
-	objname = argv[0];
-
-	s = strstr(objname, "vmlinux.o");
-	if (s && !s[9])
-		vmlinux = true;
-
-	return check(objname, false);
+	return check(argv[0], false);
 }
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index b1dfe2007962..acb5d3d63c3f 100644
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -24,8 +24,6 @@ static const char *orc_usage[] = {
 
 int cmd_orc(int argc, const char **argv)
 {
-	const char *objname;
-
 	argc--; argv++;
 	if (argc <= 0)
 		usage_with_options(orc_usage, check_options);
@@ -35,18 +33,14 @@ int cmd_orc(int argc, const char **argv)
 		if (argc != 1)
 			usage_with_options(orc_usage, check_options);
 
-		objname = argv[0];
-
-		return check(objname, true);
+		return check(argv[0], true);
 	}
 
 	if (!strcmp(argv[0], "dump")) {
 		if (argc != 2)
 			usage_with_options(orc_usage, check_options);
 
-		objname = argv[1];
-
-		return orc_dump(objname);
+		return orc_dump(argv[1]);
 	}
 
 	usage_with_options(orc_usage, check_options);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e034a8f24f46..1aa2d7e4eccd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -296,7 +296,7 @@ static int decode_instructions(struct objtool_file *file)
 			insn->sec = sec;
 			insn->offset = offset;
 
-			ret = arch_decode_instruction(file->elf, sec, offset,
+			ret = arch_decode_instruction(file, sec, offset,
 						      sec->len - offset,
 						      &insn->len, &insn->type,
 						      &insn->immediate,
@@ -334,6 +334,47 @@ static int decode_instructions(struct objtool_file *file)
 	return ret;
 }
 
+/*
+ * Read the pv_ops[] .data table to find the static initialized values.
+ */
+static int add_pv_ops(struct objtool_file *file)
+{
+	unsigned long off, end;
+	struct symbol *sym;
+	int idx;
+
+	if (!vmlinux)
+		return 0;
+
+	sym = find_symbol_by_name(file->elf, "pv_ops");
+	if (!sym)
+		return 0;
+
+	off = sym->offset;
+	end = off + sym->len;
+	for (;;) {
+		struct reloc *rel = find_reloc_by_dest_range(file->elf, sym->sec, off, end - off);
+		struct symbol *func;
+
+		if (!rel)
+			break;
+
+		func = rel->sym;
+		if (func->type == STT_SECTION)
+			func = find_symbol_by_offset(rel->sym->sec, rel->addend);
+
+		idx = (rel->offset - sym->offset) / sizeof(unsigned long);
+
+		file_pv_add(file, idx, func);
+
+		off = rel->offset + 1;
+		if (off > end)
+			break;
+	}
+
+	return 0;
+}
+
 static struct instruction *find_last_insn(struct objtool_file *file,
 					  struct section *sec)
 {
@@ -1548,16 +1589,54 @@ static void mark_rodata(struct objtool_file *file)
 	file->rodata = found;
 }
 
+/* 
+ * allocate and initialize objtool_file::pv_ops based on the presence and size
+ * of the 'pv_ops' symbol
+ */
+static int init_pv_ops(struct objtool_file *file)
+{
+	struct symbol *sym;
+	int idx, nr;
+
+	if (!vmlinux)
+		return 0;
+
+	file->pv_ops = NULL;
+
+	sym = find_symbol_by_name(file->elf, "pv_ops");
+	if (!sym)
+		return 0;
+
+	nr = sym->len / sizeof(unsigned long);
+	file->pv_ops = calloc(sizeof(struct pv_state), nr);
+	if (!file->pv_ops)
+		return -1;
+
+	for (idx = 0; idx < nr; idx++) {
+		INIT_LIST_HEAD(&file->pv_ops[idx].targets);
+	}
+
+	return 0;
+}
+
 static int decode_sections(struct objtool_file *file)
 {
 	int ret;
 
 	mark_rodata(file);
 
+	ret = init_pv_ops(file);
+	if (ret)
+		return ret;
+
 	ret = decode_instructions(file);
 	if (ret)
 		return ret;
 
+	ret = add_pv_ops(file);
+	if (ret)
+		return ret;
+
 	ret = add_dead_ends(file);
 	if (ret)
 		return ret;
@@ -2209,14 +2288,41 @@ static inline const char *call_dest_name(struct instruction *insn)
 	return "{dynamic}";
 }
 
-static inline bool noinstr_call_dest(struct symbol *func)
+static inline bool noinstr_call_dest(struct objtool_file *file, struct instruction *insn, struct symbol *func)
 {
 	/*
 	 * We can't deal with indirect function calls at present;
 	 * assume they're instrumented.
 	 */
-	if (!func)
+	if (!func) {
+		/*
+		 * Special case: callq *pv_ops+disp
+		 */
+		struct reloc *rel = find_reloc_by_dest_range(file->elf, insn->sec, insn->offset, insn->len);
+
+		if (rel && !strcmp(rel->sym->name, "pv_ops")) {
+			int idx = rel->addend / sizeof(void *);
+
+			WARN_FUNC("call pv_ops[%d] from noinstr", insn->sec, insn->offset, idx);
+
+			if (!file->pv_ops[idx].clean) {
+				struct symbol *target;
+
+				list_for_each_entry(target, &file->pv_ops[idx].targets, pv_target) {
+					if (!target->sec->noinstr) {
+						WARN("pv_op[%d]: %s", idx, target->name);
+						return false;
+					}
+				}
+
+				file->pv_ops[idx].clean = true;
+			}
+
+			return true; /* assume for now; warn later */
+		}
+
 		return false;
+	}
 
 	/*
 	 * If the symbol is from a noinstr section; we good.
@@ -2235,10 +2341,10 @@ static inline bool noinstr_call_dest(struct symbol *func)
 	return false;
 }
 
-static int validate_call(struct instruction *insn, struct insn_state *state)
+static int validate_call(struct objtool_file *file, struct instruction *insn, struct insn_state *state)
 {
 	if (state->noinstr && state->instr <= 0 &&
-	    !noinstr_call_dest(insn->call_dest)) {
+	    !noinstr_call_dest(file, insn, insn->call_dest)) {
 		WARN_FUNC("call to %s() leaves .noinstr.text section",
 				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
@@ -2259,7 +2365,7 @@ static int validate_call(struct instruction *insn, struct insn_state *state)
 	return 0;
 }
 
-static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
+static int validate_sibling_call(struct objtool_file *file, struct instruction *insn, struct insn_state *state)
 {
 	if (has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack frame",
@@ -2267,7 +2373,7 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
 		return 1;
 	}
 
-	return validate_call(insn, state);
+	return validate_call(file, insn, state);
 }
 
 static int validate_return(struct symbol *func, struct instruction *insn, struct insn_state *state)
@@ -2418,7 +2524,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_CALL:
 		case INSN_CALL_DYNAMIC:
-			ret = validate_call(insn, &state);
+			ret = validate_call(file, insn, &state);
 			if (ret)
 				return ret;
 
@@ -2437,7 +2543,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
 			if (func && is_sibling_call(insn)) {
-				ret = validate_sibling_call(insn, &state);
+				ret = validate_sibling_call(file, insn, &state);
 				if (ret)
 					return ret;
 
@@ -2459,7 +2565,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		case INSN_JUMP_DYNAMIC:
 		case INSN_JUMP_DYNAMIC_CONDITIONAL:
 			if (func && is_sibling_call(insn)) {
-				ret = validate_sibling_call(insn, &state);
+				ret = validate_sibling_call(file, insn, &state);
 				if (ret)
 					return ret;
 			}
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 6cc80a075166..f6d9cb90b976 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -56,6 +56,7 @@ struct symbol {
 	unsigned int len;
 	struct symbol *pfunc, *cfunc, *alias;
 	bool uaccess_safe;
+	struct list_head pv_target;
 };
 
 struct reloc {
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 58fdda510653..f7d435f00ab3 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -21,7 +21,9 @@
 #include <subcmd/pager.h>
 #include <linux/kernel.h>
 
+#include "warn.h"
 #include "builtin.h"
+#include "objtool.h"
 
 struct cmd_struct {
 	const char *name;
@@ -122,3 +124,47 @@ int main(int argc, const char **argv)
 
 	return 0;
 }
+
+void file_pv_add(struct objtool_file *file, int idx, struct symbol *func)
+{
+	if (!vmlinux)
+		return;
+
+	if (!file->pv_ops) {
+		WARN("paravirt confused\n");
+		return;
+	}
+
+	/*
+	 * These functions will be patched into native code,
+	 * see paravirt_patch_default().
+	 */
+	if (!strcmp(func->name, "_paravirt_nop") ||
+	    !strcmp(func->name, "_paravirt_ident_64"))
+		return;
+
+//	WARN("pv_ops[%d]: = %s", idx, func->name);
+
+	/*
+	 * These functions will be patched into native code,
+	 * see native_patch().
+	 */
+	if (!strcmp(func->name, "native_restore_fl") ||
+	    !strcmp(func->name, "native_save_fl") ||
+	    !strcmp(func->name, "native_irq_disable") ||
+	    !strcmp(func->name, "native_irq_enable") ||
+	    !strcmp(func->name, "native_read_cr2") ||
+	    !strcmp(func->name, "__native_read_cr3") ||
+	    !strcmp(func->name, "native_write_cr3") ||
+	    !strcmp(func->name, "native_usergs_sysret64") ||
+	    !strcmp(func->name, "native_swapgs") ||
+	    !strcmp(func->name, "native_wbinvd") ||
+	    !strcmp(func->name, "__native_queued_spin_unlock") ||
+	    !strcmp(func->name, "__native_vcpu_is_preempted"))
+		return;
+
+
+	list_add(&func->pv_target, &file->pv_ops[idx].targets);
+	file->pv_ops[idx].clean = false;
+}
+
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index 528028a66816..73f4087c286e 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -12,13 +12,22 @@
 
 #include "elf.h"
 
+struct pv_state {
+	bool clean;
+	struct list_head targets;
+};
+
 struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 20);
 	bool ignore_unreachables, c_file, hints, rodata;
+
+	struct pv_state *pv_ops;
 };
 
+void file_pv_add(struct objtool_file *file, int idx, struct symbol *func);
+
 int check(const char *objname, bool orc);
 int orc_dump(const char *objname);
 int create_orc(struct objtool_file *file);
