Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37193C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1802520890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbgFRUnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:43:01 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731143AbgFRUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:12 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:04 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id D116EB2656;
        Thu, 18 Jun 2020 16:39:07 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 12/51] objtool: mcount: Walk relocation lists
Date:   Thu, 18 Jun 2020 13:37:58 -0700
Message-ID: <b5c817aa15613c4e00cfbd3b2c0cd807015536ab.1592510545.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1592510545.git.mhelsley@vmware.com>
References: <cover.1592510545.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than walk the section tables using the old recordmcount mapping
of the ELF file, walk the section list provided by objtool's ELF code.
This removes the last use of of the Elf_r_sym wrapper so we remove
that too.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c |  10 +---
 tools/objtool/recordmcount.h | 103 +++++++++--------------------------
 2 files changed, 28 insertions(+), 85 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 843027a46e1b..dafa6dd10d04 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -429,9 +429,9 @@ static const unsigned int missing_sym = (unsigned int)-1;
 #define RECORD_MCOUNT_64
 #include "recordmcount.h"
 
-static int arm_is_fake_mcount(Elf32_Rel const *rp)
+static int arm_is_fake_mcount(struct reloc const *rp)
 {
-	switch (ELF32_R_TYPE(w(rp->r_info))) {
+	switch (rp->type) {
 	case R_ARM_THM_CALL:
 	case R_ARM_CALL:
 	case R_ARM_PC24:
@@ -462,11 +462,6 @@ union mips_r_info {
 	} r_mips;
 };
 
-static uint64_t MIPS64_r_sym(Elf64_Rel const *rp)
-{
-	return w(((union mips_r_info){ .r_info = rp->r_info }).r_mips.r_sym);
-}
-
 static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
 {
 	rp->r_info = ((union mips_r_info){
@@ -605,7 +600,6 @@ static int do_file(char const *const fname)
 		}
 		if (w2(ghdr->e_machine) == EM_MIPS) {
 			reltype = R_MIPS_64;
-			Elf64_r_sym = MIPS64_r_sym;
 			Elf64_r_info = MIPS64_r_info;
 			is_fake_mcount64 = MIPS64_is_fake_mcount;
 		}
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 3dae878f11a8..df8384f8e9e7 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -31,21 +31,14 @@
 #undef get_shnum
 #undef set_shnum
 #undef get_shstrndx
-#undef get_relp
 #undef do_func
 #undef Elf_Addr
 #undef Elf_Ehdr
 #undef Elf_Shdr
 #undef Elf_Rel
 #undef Elf_Rela
-#undef Elf_Sym
-#undef ELF_R_SYM
-#undef Elf_r_sym
 #undef ELF_R_INFO
 #undef Elf_r_info
-#undef ELF_ST_BIND
-#undef ELF_ST_TYPE
-#undef fn_ELF_R_SYM
 #undef fn_ELF_R_INFO
 #undef uint_t
 #undef _w
@@ -62,7 +55,6 @@
 # define get_shnum		get_shnum64
 # define set_shnum		set_shnum64
 # define get_shstrndx		get_shstrndx64
-# define get_relp		get_relp_64
 # define do_func		do64
 # define get_mcountsym		get_mcountsym_64
 # define is_fake_mcount		is_fake_mcount64
@@ -74,14 +66,8 @@
 # define Elf_Shdr		Elf64_Shdr
 # define Elf_Rel		Elf64_Rel
 # define Elf_Rela		Elf64_Rela
-# define Elf_Sym		Elf64_Sym
-# define ELF_R_SYM		ELF64_R_SYM
-# define Elf_r_sym		Elf64_r_sym
 # define ELF_R_INFO		ELF64_R_INFO
 # define Elf_r_info		Elf64_r_info
-# define ELF_ST_BIND		ELF64_ST_BIND
-# define ELF_ST_TYPE		ELF64_ST_TYPE
-# define fn_ELF_R_SYM		fn_ELF64_R_SYM
 # define fn_ELF_R_INFO		fn_ELF64_R_INFO
 # define uint_t			uint64_t
 # define _w			w8
@@ -97,7 +83,6 @@
 # define get_shnum		get_shnum32
 # define set_shnum		set_shnum32
 # define get_shstrndx		get_shstrndx32
-# define get_relp		get_relp_32
 # define do_func		do32
 # define get_mcountsym		get_mcountsym_32
 # define is_fake_mcount		is_fake_mcount32
@@ -109,14 +94,8 @@
 # define Elf_Shdr		Elf32_Shdr
 # define Elf_Rel		Elf32_Rel
 # define Elf_Rela		Elf32_Rela
-# define Elf_Sym		Elf32_Sym
-# define ELF_R_SYM		ELF32_R_SYM
-# define Elf_r_sym		Elf32_r_sym
 # define ELF_R_INFO		ELF32_R_INFO
 # define Elf_r_info		Elf32_r_info
-# define ELF_ST_BIND		ELF32_ST_BIND
-# define ELF_ST_TYPE		ELF32_ST_TYPE
-# define fn_ELF_R_SYM		fn_ELF32_R_SYM
 # define fn_ELF_R_INFO		fn_ELF32_R_INFO
 # define uint_t			uint32_t
 # define _w			w
@@ -125,17 +104,11 @@
 #endif
 
 /* Functions and pointers that do_file() may override for specific e_machine. */
-static int fn_is_fake_mcount(Elf_Rel const *rp)
+static int fn_is_fake_mcount(struct reloc const *reloc)
 {
 	return 0;
 }
-static int (*is_fake_mcount)(Elf_Rel const *rp) = fn_is_fake_mcount;
-
-static uint_t fn_ELF_R_SYM(Elf_Rel const *rp)
-{
-	return ELF_R_SYM(_w(rp->r_info));
-}
-static uint_t (*Elf_r_sym)(Elf_Rel const *rp) = fn_ELF_R_SYM;
+static int (*is_fake_mcount)(struct reloc const *reloc) = fn_is_fake_mcount;
 
 static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
 {
@@ -166,10 +139,10 @@ static int mcount_adjust = 0;
  */
 #define MIPS_FAKEMCOUNT_OFFSET	4
 
-static int MIPS_is_fake_mcount(Elf_Rel const *rp)
+static int MIPS_is_fake_mcount(struct reloc const *reloc)
 {
 	static Elf_Addr old_r_offset = ~(Elf_Addr)0;
-	Elf_Addr current_r_offset = _w(rp->r_offset);
+	Elf_Addr current_r_offset = reloc->offset;
 	int is_fake;
 
 	is_fake = (old_r_offset != ~(Elf_Addr)0) &&
@@ -298,9 +271,9 @@ static int append_func(Elf_Ehdr *const ehdr,
 	return elf_write(lf);
 }
 
-static unsigned get_mcountsym(Elf_Rel const *relp)
+static unsigned get_mcountsym(struct reloc *reloc)
 {
-	struct symbol *sym = find_symbol_by_index(lf, Elf_r_sym(relp));
+	struct symbol *sym = reloc->sym;
 	char const *symname = sym->name;
 	char const *mcount = gpfx == '_' ? "_mcount" : "mcount";
 	char const *fentry = "__fentry__";
@@ -310,19 +283,10 @@ static unsigned get_mcountsym(Elf_Rel const *relp)
 	if (strcmp(mcount, symname) == 0 ||
 	    (altmcount && strcmp(altmcount, symname) == 0) ||
 	    (strcmp(fentry, symname) == 0))
-		return Elf_r_sym(relp);
+		return GELF_R_INFO(reloc->sym->idx, reloc->type);
 	return 0;
 }
 
-static void get_relp(const struct section * const rels,
-			Elf_Ehdr const *const ehdr,
-			Elf_Rel const **relp)
-{
-	Elf_Rel const *const rel0 = (Elf_Rel const *)(rels->sh.sh_offset
-		+ (void *)ehdr);
-	*relp = rel0;
-}
-
 /*
  * Look at the relocations in order to find the calls to mcount.
  * Accumulate the section offsets that are found, and their relocation info,
@@ -332,29 +296,23 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 			       unsigned const offbase,
 			       Elf_Rel **const mrelpp,
 			       const struct section * const rels,
-			       Elf_Ehdr const *const ehdr,
 			       unsigned const recsym_index,
 			       uint_t const recval,
 			       unsigned const reltype)
 {
 	uint_t *const mloc0 = mlocp;
 	Elf_Rel *mrelp = *mrelpp;
-	Elf_Rel const *relp;
 	unsigned int rel_entsize = rels->sh.sh_entsize;
-	unsigned const nrel = rels->sh.sh_size / rel_entsize;
 	unsigned mcountsym = 0;
-	unsigned t;
-
-	get_relp(rels, ehdr, &relp);
+	struct reloc *reloc;
 
-	for (t = nrel; t; --t) {
+	list_for_each_entry(reloc, &rels->reloc_list, list) {
 		if (!mcountsym)
-			mcountsym = get_mcountsym(relp);
+			mcountsym = get_mcountsym(reloc);
 
-		if (mcountsym && mcountsym == Elf_r_sym(relp) &&
-				!is_fake_mcount(relp)) {
+		if (mcountsym == GELF_R_INFO(reloc->sym->idx, reloc->type) && !is_fake_mcount(reloc)) {
 			uint_t const addend =
-				_w(_w(relp->r_offset) - recval + mcount_adjust);
+				_w(reloc->offset - recval + mcount_adjust);
 			mrelp->r_offset = _w(offbase
 				+ ((void *)mlocp - (void *)mloc0));
 			Elf_r_info(mrelp, recsym_index, reltype);
@@ -366,7 +324,6 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 
 			mrelp = (Elf_Rel *)(rel_entsize + (void *)mrelp);
 		}
-		relp = (Elf_Rel const *)(rel_entsize + (void *)relp);
 	}
 	*mrelpp = mrelp;
 	return mlocp;
@@ -377,31 +334,29 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
  * that are not going to be traced. The mcount calls here will be converted
  * into nops.
  */
-static int nop_mcount(const struct section * const rels,
+static int nop_mcount(struct section * const rels,
 		      Elf_Ehdr const *const ehdr,
 		      const char *const txtname)
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
-	Elf_Rel const *relp;
+	struct reloc *reloc;
 	Elf_Shdr const *const shdr = &shdr0[rels->sh.sh_info];
-	unsigned rel_entsize = rels->sh.sh_entsize;
-	unsigned const nrel = rels->sh.sh_size / rel_entsize;
 	unsigned mcountsym = 0;
-	unsigned t;
 	int once = 0;
 
-	get_relp(rels, ehdr, &relp);
-
-	for (t = nrel; t; --t) {
+	list_for_each_entry(reloc, &rels->reloc_list, list) {
 		int ret = -1;
 
 		if (!mcountsym)
-			mcountsym = get_mcountsym(relp);
+			mcountsym = get_mcountsym(reloc);
 
-		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
-			if (make_nop)
-				ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + _w(relp->r_offset));
+		if (mcountsym == GELF_R_INFO(reloc->sym->idx, reloc->type) && !is_fake_mcount(reloc)) {
+			if (make_nop) {
+				ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + reloc->offset);
+				if (ret < 0)
+					return -1;
+			}
 			if (warn_on_notrace_sect && !once) {
 				printf("Section %s has mcount callers being ignored\n",
 				       txtname);
@@ -417,15 +372,9 @@ static int nop_mcount(const struct section * const rels,
 		 * as a nop (don't do anything with it).
 		 */
 		if (!ret) {
-			Elf_Rel rel;
-			rel = *(Elf_Rel *)relp;
-			Elf_r_info(&rel, Elf_r_sym(relp), rel_type_nop);
-			if (ulseek((void *)relp - (void *)ehdr, SEEK_SET) < 0)
-				return -1;
-			if (uwrite(&rel, sizeof(rel)) < 0)
-				return -1;
+			reloc->type = rel_type_nop;
+			rels->changed = true;
 		}
-		relp = (Elf_Rel const *)(rel_entsize + (void *)relp);
 	}
 	return 0;
 }
@@ -519,7 +468,7 @@ static int do_func(Elf_Ehdr *const ehdr,
 	unsigned rel_entsize = 0;
 	unsigned symsec_sh_link = 0;
 
-	const struct section *sec;
+	struct section *sec;
 
 	int result = 0;
 
@@ -559,7 +508,7 @@ static int do_func(Elf_Ehdr *const ehdr,
 			rel_entsize = sec->sh.sh_entsize;
 			mlocp = sift_rel_mcount(mlocp,
 				(void *)mlocp - (void *)mloc0, &mrelp,
-				sec, ehdr, recsym, recval, reltype);
+				sec, recsym, recval, reltype);
 		} else if (txtname && (warn_on_notrace_sect || make_nop)) {
 			/*
 			 * This section is ignored by ftrace, but still
-- 
2.20.1

