Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC020C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6360214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgDSN5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgDSN5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:57:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F2C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:57:50 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQASC-0002n1-Ok; Sun, 19 Apr 2020 15:57:48 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 48876FFBA2;
        Sun, 19 Apr 2020 15:57:48 +0200 (CEST)
Date:   Sun, 19 Apr 2020 13:56:44 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.7-rc2
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
Message-ID: <158730460462.31269.9837303049447973264.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-04-19

up to:  8b9a18a9f249: x86/split_lock: Add Tremont family CPU models


A set of fixes for x86 and objtool:

 objtool:
 
  - Ignore the double UD2 which is emitted in BUG() when CONFIG_UBSAN_TRAP
    is enabled.

  - Support clang non-section symbols in objtool ORC dump

  - Fix switch table detection in .text.unlikely

  - Make the BP scratch register warning more robust.

 x86:

  - Increase microcode maximum patch size for AMD to cope with new CPUs
    which have a larger patch size.

  - Fix a crash in the resource control filesystem when the removal of the
    default resource group is attempted.

  - Preserve Code and Data Prioritization enabled state accross CPU
    hotplug.

  - Update split lock cpu matching to use the new X86_MATCH macros.

  - Change the split lock enumeration as Intel finaly decided that the
    IA32_CORE_CAPABILITIES bits are not architectural contrary to what
    the SDM claims. !@#%$^!

  - Add Tremont CPU models to the split lock detection cpu match.

  - Add a missing static attribute to make sparse happy.

Thanks,

	tglx

------------------>
James Morse (1):
      x86/resctrl: Preserve CDP enable over CPU hotplug

Jason Yan (1):
      x86/umip: Make umip_insns static

John Allen (1):
      x86/microcode/AMD: Increase microcode PATCH_MAX_SIZE

Josh Poimboeuf (5):
      objtool: Fix CONFIG_UBSAN_TRAP unreachable warnings
      objtool: Support Clang non-section symbols in ORC dump
      objtool: Support Clang non-section symbols in ORC generation
      objtool: Fix switch table detection in .text.unlikely
      objtool: Make BP scratch register warning more robust

Reinette Chatre (1):
      x86/resctrl: Fix invalid attempt at removing the default resource group

Tony Luck (3):
      x86/split_lock: Update to use X86_MATCH_INTEL_FAM6_MODEL()
      x86/split_lock: Bits in IA32_CORE_CAPABILITIES are not architectural
      x86/split_lock: Add Tremont family CPU models


 arch/x86/include/asm/microcode_amd.h   |  2 +-
 arch/x86/kernel/cpu/intel.c            | 54 ++++++++++++++++++++++------------
 arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++++++-
 arch/x86/kernel/umip.c                 |  2 +-
 tools/objtool/check.c                  | 26 +++++++++++-----
 tools/objtool/orc_dump.c               | 44 ++++++++++++++++-----------
 tools/objtool/orc_gen.c                | 33 ++++++++++++++++-----
 9 files changed, 127 insertions(+), 53 deletions(-)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index 6685e1218959..7063b5a43220 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -41,7 +41,7 @@ struct microcode_amd {
 	unsigned int			mpb[0];
 };
 
-#define PATCH_MAX_SIZE PAGE_SIZE
+#define PATCH_MAX_SIZE (3 * PAGE_SIZE)
 
 #ifdef CONFIG_MICROCODE_AMD
 extern void __init load_ucode_amd_bsp(unsigned int family);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index bf08d4508ecb..a19a680542ce 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1119,35 +1119,53 @@ void switch_to_sld(unsigned long tifn)
 	sld_update_msr(!(tifn & _TIF_SLD));
 }
 
-#define SPLIT_LOCK_CPU(model) {X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY}
-
 /*
- * The following processors have the split lock detection feature. But
- * since they don't have the IA32_CORE_CAPABILITIES MSR, the feature cannot
- * be enumerated. Enable it by family and model matching on these
- * processors.
+ * Bits in the IA32_CORE_CAPABILITIES are not architectural, so they should
+ * only be trusted if it is confirmed that a CPU model implements a
+ * specific feature at a particular bit position.
+ *
+ * The possible driver data field values:
+ *
+ * - 0: CPU models that are known to have the per-core split-lock detection
+ *	feature even though they do not enumerate IA32_CORE_CAPABILITIES.
+ *
+ * - 1: CPU models which may enumerate IA32_CORE_CAPABILITIES and if so use
+ *      bit 5 to enumerate the per-core split-lock detection feature.
  */
 static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
-	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_X),
-	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_L),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		0),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		0),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	1),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	1),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),
 	{}
 };
 
 void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
 {
-	u64 ia32_core_caps = 0;
+	const struct x86_cpu_id *m;
+	u64 ia32_core_caps;
+
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return;
 
-	if (c->x86_vendor != X86_VENDOR_INTEL)
+	m = x86_match_cpu(split_lock_cpu_ids);
+	if (!m)
 		return;
-	if (cpu_has(c, X86_FEATURE_CORE_CAPABILITIES)) {
-		/* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
+
+	switch (m->driver_data) {
+	case 0:
+		break;
+	case 1:
+		if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
+			return;
 		rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
-	} else if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
-		/* Enumerate split lock detection by family and model. */
-		if (x86_match_cpu(split_lock_cpu_ids))
-			ia32_core_caps |= MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT;
+		if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT))
+			return;
+		break;
+	default:
+		return;
 	}
 
-	if (ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
-		split_lock_setup();
+	split_lock_setup();
 }
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 89049b343c7a..d8cc5223b7ce 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -578,6 +578,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	d->id = id;
 	cpumask_set_cpu(cpu, &d->cpu_mask);
 
+	rdt_domain_reconfigure_cdp(r);
+
 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
 		kfree(d);
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 181c992f448c..3dd13f3a8b23 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -601,5 +601,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
 bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
+void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 064e9ef44cd6..5a359d9fcc05 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1859,6 +1859,19 @@ static int set_cache_qos_cfg(int level, bool enable)
 	return 0;
 }
 
+/* Restore the qos cfg state when a domain comes online */
+void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
+{
+	if (!r->alloc_capable)
+		return;
+
+	if (r == &rdt_resources_all[RDT_RESOURCE_L2DATA])
+		l2_qos_cfg_update(&r->alloc_enabled);
+
+	if (r == &rdt_resources_all[RDT_RESOURCE_L3DATA])
+		l3_qos_cfg_update(&r->alloc_enabled);
+}
+
 /*
  * Enable or disable the MBA software controller
  * which helps user specify bandwidth in MBps.
@@ -3072,7 +3085,8 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 	 * If the rdtgroup is a mon group and parent directory
 	 * is a valid "mon_groups" directory, remove the mon group.
 	 */
-	if (rdtgrp->type == RDTCTRL_GROUP && parent_kn == rdtgroup_default.kn) {
+	if (rdtgrp->type == RDTCTRL_GROUP && parent_kn == rdtgroup_default.kn &&
+	    rdtgrp != &rdtgroup_default) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
 		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
 			ret = rdtgroup_ctrl_remove(kn, rdtgrp);
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 4d732a444711..8d5cbe1bbb3b 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -81,7 +81,7 @@
 #define	UMIP_INST_SLDT  3       /* 0F 00 /0 */
 #define	UMIP_INST_STR   4       /* 0F 00 /1 */
 
-const char * const umip_insns[5] = {
+static const char * const umip_insns[5] = {
 	[UMIP_INST_SGDT] = "SGDT",
 	[UMIP_INST_SIDT] = "SIDT",
 	[UMIP_INST_SMSW] = "SMSW",
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8dd01f986fbb..4b170fd08a28 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1050,10 +1050,7 @@ static struct rela *find_jump_table(struct objtool_file *file,
 	 * it.
 	 */
 	for (;
-	     &insn->list != &file->insn_list &&
-	     insn->sec == func->sec &&
-	     insn->offset >= func->offset;
-
+	     &insn->list != &file->insn_list && insn->func && insn->func->pfunc == func;
 	     insn = insn->first_jump_src ?: list_prev_entry(insn, list)) {
 
 		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)
@@ -2008,8 +2005,8 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 	}
 
 	if (state->bp_scratch) {
-		WARN("%s uses BP as a scratch register",
-		     func->name);
+		WARN_FUNC("BP used as a scratch register",
+			  insn->sec, insn->offset);
 		return 1;
 	}
 
@@ -2364,14 +2361,27 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 	    !strcmp(insn->sec->name, ".altinstr_aux"))
 		return true;
 
+	if (!insn->func)
+		return false;
+
+	/*
+	 * CONFIG_UBSAN_TRAP inserts a UD2 when it sees
+	 * __builtin_unreachable().  The BUG() macro has an unreachable() after
+	 * the UD2, which causes GCC's undefined trap logic to emit another UD2
+	 * (or occasionally a JMP to UD2).
+	 */
+	if (list_prev_entry(insn, list)->dead_end &&
+	    (insn->type == INSN_BUG ||
+	     (insn->type == INSN_JUMP_UNCONDITIONAL &&
+	      insn->jump_dest && insn->jump_dest->type == INSN_BUG)))
+		return true;
+
 	/*
 	 * Check if this (or a subsequent) instruction is related to
 	 * CONFIG_UBSAN or CONFIG_KASAN.
 	 *
 	 * End the search at 5 instructions to avoid going into the weeds.
 	 */
-	if (!insn->func)
-		return false;
 	for (i = 0; i < 5; i++) {
 
 		if (is_kasan_insn(insn) || is_ubsan_insn(insn))
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 13ccf775a83a..ba4cbb1cdd63 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -66,7 +66,7 @@ int orc_dump(const char *_objname)
 	char *name;
 	size_t nr_sections;
 	Elf64_Addr orc_ip_addr = 0;
-	size_t shstrtab_idx;
+	size_t shstrtab_idx, strtab_idx = 0;
 	Elf *elf;
 	Elf_Scn *scn;
 	GElf_Shdr sh;
@@ -127,6 +127,8 @@ int orc_dump(const char *_objname)
 
 		if (!strcmp(name, ".symtab")) {
 			symtab = data;
+		} else if (!strcmp(name, ".strtab")) {
+			strtab_idx = i;
 		} else if (!strcmp(name, ".orc_unwind")) {
 			orc = data->d_buf;
 			orc_size = sh.sh_size;
@@ -138,7 +140,7 @@ int orc_dump(const char *_objname)
 		}
 	}
 
-	if (!symtab || !orc || !orc_ip)
+	if (!symtab || !strtab_idx || !orc || !orc_ip)
 		return 0;
 
 	if (orc_size % sizeof(*orc) != 0) {
@@ -159,21 +161,29 @@ int orc_dump(const char *_objname)
 				return -1;
 			}
 
-			scn = elf_getscn(elf, sym.st_shndx);
-			if (!scn) {
-				WARN_ELF("elf_getscn");
-				return -1;
-			}
-
-			if (!gelf_getshdr(scn, &sh)) {
-				WARN_ELF("gelf_getshdr");
-				return -1;
-			}
-
-			name = elf_strptr(elf, shstrtab_idx, sh.sh_name);
-			if (!name || !*name) {
-				WARN_ELF("elf_strptr");
-				return -1;
+			if (GELF_ST_TYPE(sym.st_info) == STT_SECTION) {
+				scn = elf_getscn(elf, sym.st_shndx);
+				if (!scn) {
+					WARN_ELF("elf_getscn");
+					return -1;
+				}
+
+				if (!gelf_getshdr(scn, &sh)) {
+					WARN_ELF("gelf_getshdr");
+					return -1;
+				}
+
+				name = elf_strptr(elf, shstrtab_idx, sh.sh_name);
+				if (!name) {
+					WARN_ELF("elf_strptr");
+					return -1;
+				}
+			} else {
+				name = elf_strptr(elf, strtab_idx, sym.st_name);
+				if (!name) {
+					WARN_ELF("elf_strptr");
+					return -1;
+				}
 			}
 
 			printf("%s+%llx:", name, (unsigned long long)rela.r_addend);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 41e4a2754da4..4c0dabd28000 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -88,11 +88,6 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 	struct orc_entry *orc;
 	struct rela *rela;
 
-	if (!insn_sec->sym) {
-		WARN("missing symbol for section %s", insn_sec->name);
-		return -1;
-	}
-
 	/* populate ORC data */
 	orc = (struct orc_entry *)u_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
@@ -105,8 +100,32 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 	}
 	memset(rela, 0, sizeof(*rela));
 
-	rela->sym = insn_sec->sym;
-	rela->addend = insn_off;
+	if (insn_sec->sym) {
+		rela->sym = insn_sec->sym;
+		rela->addend = insn_off;
+	} else {
+		/*
+		 * The Clang assembler doesn't produce section symbols, so we
+		 * have to reference the function symbol instead:
+		 */
+		rela->sym = find_symbol_containing(insn_sec, insn_off);
+		if (!rela->sym) {
+			/*
+			 * Hack alert.  This happens when we need to reference
+			 * the NOP pad insn immediately after the function.
+			 */
+			rela->sym = find_symbol_containing(insn_sec,
+							   insn_off - 1);
+		}
+		if (!rela->sym) {
+			WARN("missing symbol for insn at offset 0x%lx\n",
+			     insn_off);
+			return -1;
+		}
+
+		rela->addend = insn_off - rela->sym->offset;
+	}
+
 	rela->type = R_X86_64_PC32;
 	rela->offset = idx * sizeof(int);
 	rela->sec = ip_relasec;

