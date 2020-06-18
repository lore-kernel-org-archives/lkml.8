Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F37EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6343820890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbgFRUma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:42:30 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:4380 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731227AbgFRUj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:27 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:19 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id BE48DB2656;
        Thu, 18 Jun 2020 16:39:22 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 30/51] objtool: mcount: Generic location and relocation table types
Date:   Thu, 18 Jun 2020 13:38:16 -0700
Message-ID: <9ccc55eb46061c8ab8500b2d910b4e6a3d937d0f.1592510545.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1592510545.git.mhelsley@vmware.com>
References: <cover.1592510545.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than building the exact ELF section data we need and
avoiding libelf's conversion step, use more GElf types
and then libelf's elfxx_xlatetof() functions to convert
the mcount locations (GElf_Addr) and associated relocations.

This converts sift_rel_mcount() so that it doesn't use the
recordmcount wrapper. The next patch will move it out of the
wrapper.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c |  44 +++----------
 tools/objtool/recordmcount.h | 122 ++++++++++++++---------------------
 2 files changed, 60 insertions(+), 106 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index bb53927612fb..34976f3294ac 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -210,7 +210,7 @@ static int is_mcounted_section_name(char const *const txtname)
 		strcmp(".cpuidle.text", txtname) == 0;
 }
 
-static struct symbol *get_mcountsym(struct reloc *reloc)
+static struct symbol *get_mcount_sym(struct reloc *reloc)
 {
 	struct symbol *sym = reloc->sym;
 	char const *symname = sym->name;
@@ -322,16 +322,16 @@ static int nop_mcount(struct section * const rels,
 {
 	struct reloc *reloc;
 	struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
-	struct symbol *mcountsym = NULL;
+	struct symbol *mcount_sym = NULL;
 	int once = 0;
 
 	list_for_each_entry(reloc, &rels->reloc_list, list) {
 		int ret = -1;
 
-		if (!mcountsym)
-			mcountsym = get_mcountsym(reloc);
+		if (!mcount_sym)
+			mcount_sym = get_mcount_sym(reloc);
 
-		if (mcountsym == reloc->sym && !is_fake_mcount(reloc)) {
+		if (mcount_sym == reloc->sym && !is_fake_mcount(reloc)) {
 			if (make_nop) {
 				ret = make_nop(txts, reloc->offset);
 				if (ret < 0)
@@ -392,6 +392,9 @@ static unsigned tot_relsize(unsigned int *rel_entsize)
  */
 static int mcount_adjust = 0;
 
+/* Size of an entry in __mcount_loc; 4 or 8 */
+static size_t loc_size;
+
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
@@ -409,34 +412,6 @@ static int arm_is_fake_mcount(struct reloc const *rp)
 	return 1;
 }
 
-/* 64-bit EM_MIPS has weird ELF64_Rela.r_info.
- * http://techpubs.sgi.com/library/manuals/4000/007-4658-001/pdf/007-4658-001.pdf
- * We interpret Table 29 Relocation Operation (Elf64_Rel, Elf64_Rela) [p.40]
- * to imply the order of the members; the spec does not say so.
- *	typedef unsigned char Elf64_Byte;
- * fails on MIPS64 because their <elf.h> already has it!
- */
-
-typedef uint8_t myElf64_Byte;		/* Type for a 8-bit quantity.  */
-
-union mips_r_info {
-	Elf64_Xword r_info;
-	struct {
-		Elf64_Word r_sym;		/* Symbol index.  */
-		myElf64_Byte r_ssym;		/* Special symbol.  */
-		myElf64_Byte r_type3;		/* Third relocation.  */
-		myElf64_Byte r_type2;		/* Second relocation.  */
-		myElf64_Byte r_type;		/* First relocation.  */
-	} r_mips;
-};
-
-static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
-{
-	rp->r_info = ((union mips_r_info){
-		.r_mips = { .r_sym = w(sym), .r_type = type }
-	}).r_info;
-}
-
 static int do_file(char const *const fname)
 {
 	unsigned int reltype = 0;
@@ -552,6 +527,7 @@ static int do_file(char const *const fname)
 			reltype = R_MIPS_32;
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
+		loc_size = 4;
 		rc = do32(reltype);
 		break;
 	case ELFCLASS64: {
@@ -567,9 +543,9 @@ static int do_file(char const *const fname)
 		}
 		if (lf->ehdr.e_machine == EM_MIPS) {
 			reltype = R_MIPS_64;
-			Elf64_r_info = MIPS64_r_info;
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
+		loc_size = 8;
 		rc = do64(reltype);
 		break;
 	}
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index ce88f0c2f79b..1d11dfc40d09 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -19,86 +19,63 @@
  */
 #undef sift_rel_mcount
 #undef do_func
-#undef Elf_Shdr
-#undef Elf_Rel
 #undef Elf_Rela
-#undef ELF_R_INFO
-#undef Elf_r_info
-#undef fn_ELF_R_INFO
-#undef uint_t
-#undef _w
-#undef _size
 
 #ifdef RECORD_MCOUNT_64
 # define sift_rel_mcount	sift64_rel_mcount
 # define do_func		do64
-# define Elf_Rel		Elf64_Rel
 # define Elf_Rela		Elf64_Rela
-# define ELF_R_INFO		ELF64_R_INFO
-# define Elf_r_info		Elf64_r_info
-# define fn_ELF_R_INFO		fn_ELF64_R_INFO
-# define uint_t			uint64_t
-# define _w			w8
-# define _size			8
 #else
 # define sift_rel_mcount	sift32_rel_mcount
 # define do_func		do32
-# define Elf_Rel		Elf32_Rel
 # define Elf_Rela		Elf32_Rela
-# define ELF_R_INFO		ELF32_R_INFO
-# define Elf_r_info		Elf32_r_info
-# define fn_ELF_R_INFO		fn_ELF32_R_INFO
-# define uint_t			uint32_t
-# define _w			w
-# define _size			4
 #endif
 
-static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
-{
-	rp->r_info = _w(ELF_R_INFO(sym, type));
-}
-static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
-
 /*
  * Look at the relocations in order to find the calls to mcount.
  * Accumulate the section offsets that are found, and their relocation info,
  * onto the end of the existing arrays.
  */
-static uint_t *sift_rel_mcount(uint_t *mlocp,
-			       unsigned const offbase,
-			       Elf_Rel **const mrelpp,
+static void sift_rel_mcount(GElf_Addr **mlocpp,
+			       GElf_Sxword *r_offsetp,
+			       void **const mrelpp,
 			       const struct section * const rels,
 			       unsigned const recsym_index,
 			       unsigned long const recval,
-			       unsigned const reltype)
+			       unsigned const reltype,
+			       bool is_rela)
 {
-	uint_t *const mloc0 = mlocp;
-	Elf_Rel *mrelp = *mrelpp;
-	unsigned int rel_entsize = rels->sh.sh_entsize;
-	struct symbol *mcountsym = NULL;
+	GElf_Rel *mrelp = *mrelpp;
+	GElf_Rela *mrelap = *mrelpp;
+	struct symbol *mcount_sym = NULL;
 	struct reloc *reloc;
 
 	list_for_each_entry(reloc, &rels->reloc_list, list) {
-		if (!mcountsym)
-			mcountsym = get_mcountsym(reloc);
-
-		if (mcountsym == reloc->sym && !is_fake_mcount(reloc)) {
-			uint_t const addend =
-				_w(reloc->offset - recval + mcount_adjust);
-			mrelp->r_offset = _w(offbase
-				+ ((void *)mlocp - (void *)mloc0));
-			Elf_r_info(mrelp, recsym_index, reltype);
-			if (rel_entsize == sizeof(Elf_Rela)) {
-				((Elf_Rela *)mrelp)->r_addend = addend;
-				*mlocp++ = 0;
-			} else
-				*mlocp++ = addend;
-
-			mrelp = (Elf_Rel *)(rel_entsize + (void *)mrelp);
+		unsigned long addend;
+
+		if (!mcount_sym)
+			mcount_sym = get_mcount_sym(reloc);
+
+		if (mcount_sym != reloc->sym || is_fake_mcount(reloc))
+			continue;
+
+		addend = reloc->offset - recval + mcount_adjust;
+		if (is_rela) {
+			mrelap->r_offset = *r_offsetp;
+			mrelap->r_info = GELF_R_INFO(recsym_index, reltype);
+			mrelap->r_addend = addend;
+			mrelap++;
+			**mlocpp = 0;
+		} else {
+			mrelp->r_offset = *r_offsetp;
+			mrelp->r_info = GELF_R_INFO(recsym_index, reltype);
+			mrelp++;
+			**mlocpp = addend;
 		}
+		(*mlocpp)++;
+		*r_offsetp += loc_size;
 	}
-	*mrelpp = mrelp;
-	return mlocp;
+	*mrelpp = is_rela ? (void *)mrelap : (void *)mrelp;
 }
 
 /* Overall supervision for Elf32 ET_REL file. */
@@ -107,14 +84,15 @@ static int do_func(unsigned const reltype)
 	/* Upper bound on space: assume all relevant relocs are for mcount. */
 	unsigned       totrelsz;
 
-	Elf_Rel *      mrel0;
-	Elf_Rel *      mrelp;
+	void *mrel0;
+	void *mrelp;
 
-	uint_t *      mloc0;
-	uint_t *      mlocp;
+	GElf_Addr *mloc0;
+	GElf_Addr *mlocp;
+	GElf_Sxword r_offset = 0;
 
 	struct section *sec, *mlocs, *mrels;
-	char const *mc_name;
+	const char *mc_name;
 
 	unsigned int rel_entsize = 0;
 	int result = -1;
@@ -146,24 +124,27 @@ static int do_func(unsigned const reltype)
 			:  ".rel__mcount_loc";
 
 	/* add section: __mcount_loc */
-	mlocs = elf_create_section(lf, mc_name + (is_rela ? 1 : 0) + strlen(".rel"), _size, 0);
+	mlocs = elf_create_section(lf, mc_name + (is_rela ? 1 : 0) + strlen(".rel"), sizeof(*mloc0), 0);
 	if (!mlocs)
 		goto out;
 	mlocs->sh.sh_link = 0;
 	mlocs->sh.sh_info = 0;
-	mlocs->sh.sh_addralign = _size;
+	mlocs->sh.sh_addralign = 8;
+	mlocs->data->d_buf = mloc0;
+	mlocs->data->d_type = ELF_T_ADDR; /* elf_xlatetof() conversion */
 
 	/* add section .rel[a]__mcount_loc */
 	mrels = elf_create_section(lf, mc_name, rel_entsize, 0);
 	if (!mrels)
 		goto out;
-	mrels->sh.sh_type = is_rela
-				? SHT_RELA
-				: SHT_REL;
+	/* Like elf_create_rela_section() without the name bits */
+	mrels->sh.sh_type = is_rela ? SHT_RELA : SHT_REL;
 	mrels->sh.sh_flags = 0; /* clear SHF_ALLOC */
 	mrels->sh.sh_link = find_section_by_name(lf, ".symtab")->idx;
 	mrels->sh.sh_info = mlocs->idx;
-	mrels->sh.sh_addralign = _size;
+	mrels->sh.sh_addralign = 8;
+	mrels->data->d_buf = mrel0;
+	mrels->data->d_type = is_rela ? ELF_T_RELA : ELF_T_REL; /* elf_xlatetof() conversion */
 
 	list_for_each_entry(sec, &lf->sections, list) {
 		char const *txtname;
@@ -177,9 +158,8 @@ static int do_func(unsigned const reltype)
 						txtname, &recval, &recsym))
 				goto out;
 
-			mlocp = sift_rel_mcount(mlocp,
-				(void *)mlocp - (void *)mloc0, &mrelp,
-				sec, recsym, (uint_t)recval, reltype);
+			sift_rel_mcount(&mlocp, &r_offset, &mrelp, sec,
+				recsym, recval, reltype, is_rela);
 		} else if (txtname && (warn_on_notrace_sect || make_nop)) {
 			/*
 			 * This section is ignored by ftrace, but still
@@ -191,17 +171,15 @@ static int do_func(unsigned const reltype)
 	}
 
 	if (mloc0 != mlocp) {
-		/* Update the section sizes */
+		/* Update the section size and Elf_Data size */
 		mlocs->sh.sh_size = (void *)mlocp - (void *)mloc0;
 		mlocs->len = mlocs->sh.sh_size;
 		mlocs->data->d_size = mlocs->len;
-		mlocs->data->d_buf = mloc0;
 		elf_flagdata(mlocs->data, ELF_C_SET, ELF_F_DIRTY);
 
-		mrels->sh.sh_size = (void *)mrelp - (void *)mrel0;
+		mrels->sh.sh_size = mrelp - mrel0;
 		mrels->len = mrels->sh.sh_size;
 		mrels->data->d_size = mrels->len;
-		mrels->data->d_buf = mrel0;
 		elf_flagdata(mrels->data, ELF_C_SET, ELF_F_DIRTY);
 
 		/* overwrite the ELF file */
-- 
2.20.1

