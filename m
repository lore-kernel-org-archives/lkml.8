Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4DEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6E520890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgFRUnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:43:16 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730971AbgFRUjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:08 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:03 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 2DCEDB2656;
        Thu, 18 Jun 2020 16:39:06 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 10/51] objtool: mcount: Walk objtool Elf structs in find_secsym_ndx
Date:   Thu, 18 Jun 2020 13:37:56 -0700
Message-ID: <d2adb98b53978f1ec5895f94e1cd69ea7245ab82.1592510545.git.mhelsley@vmware.com>
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

Rather than using indices into raw ELF32/64 tables mapped for the
wrapper, use the objtool functions to find the suitable symbol
in the given text section. This also removes all callers to
find_symtab() and get_symindex() so we can remove them as well.

Also take advantage of this commit to rename the function to
something that reads more easily.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c |  2 +
 tools/objtool/recordmcount.h | 94 ++++++++----------------------------
 2 files changed, 22 insertions(+), 74 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index f20582ac99e2..843027a46e1b 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -422,6 +422,8 @@ static int is_mcounted_section_name(char const *const txtname)
 		strcmp(".cpuidle.text", txtname) == 0;
 }
 
+static const unsigned int missing_sym = (unsigned int)-1;
+
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 30f8913aa841..b10f7fcd33c3 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -24,15 +24,13 @@
 #undef mcount_adjust
 #undef sift_rel_mcount
 #undef nop_mcount
-#undef find_secsym_ndx
+#undef find_section_sym_index
 #undef has_rel_mcount
 #undef tot_relsize
 #undef get_mcountsym
-#undef find_symtab
 #undef get_shnum
 #undef set_shnum
 #undef get_shstrndx
-#undef get_symindex
 #undef get_sym_str_and_relp
 #undef do_func
 #undef Elf_Addr
@@ -58,14 +56,12 @@
 # define append_func		append64
 # define sift_rel_mcount	sift64_rel_mcount
 # define nop_mcount		nop_mcount_64
-# define find_secsym_ndx	find64_secsym_ndx
+# define find_section_sym_index	find64_section_sym_index
 # define has_rel_mcount		has64_rel_mcount
 # define tot_relsize		tot64_relsize
-# define find_symtab		find_symtab64
 # define get_shnum		get_shnum64
 # define set_shnum		set_shnum64
 # define get_shstrndx		get_shstrndx64
-# define get_symindex		get_symindex64
 # define get_sym_str_and_relp	get_sym_str_and_relp_64
 # define do_func		do64
 # define get_mcountsym		get_mcountsym_64
@@ -95,14 +91,12 @@
 # define append_func		append32
 # define sift_rel_mcount	sift32_rel_mcount
 # define nop_mcount		nop_mcount_32
-# define find_secsym_ndx	find32_secsym_ndx
+# define find_section_sym_index	find32_section_sym_index
 # define has_rel_mcount		has32_rel_mcount
 # define tot_relsize		tot32_relsize
-# define find_symtab		find_symtab32
 # define get_shnum		get_shnum32
 # define set_shnum		set_shnum32
 # define get_shstrndx		get_shstrndx32
-# define get_symindex		get_symindex32
 # define get_sym_str_and_relp	get_sym_str_and_relp_32
 # define do_func		do32
 # define get_mcountsym		get_mcountsym_32
@@ -185,21 +179,6 @@ static int MIPS_is_fake_mcount(Elf_Rel const *rp)
 	return is_fake;
 }
 
-static unsigned int get_symindex(Elf_Sym const *sym, Elf32_Word const *symtab,
-				 Elf32_Word const *symtab_shndx)
-{
-	unsigned long offset;
-	int index;
-
-	if (sym->st_shndx != SHN_XINDEX)
-		return w2(sym->st_shndx);
-
-	offset = (unsigned long)sym - (unsigned long)symtab;
-	index = offset / sizeof(*sym);
-
-	return w(symtab_shndx[index]);
-}
-
 static unsigned int get_shnum(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
 {
 	if (shdr0 && !ehdr->e_shnum)
@@ -225,28 +204,6 @@ static int get_shstrndx(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
 	return w(shdr0->sh_link);
 }
 
-static void find_symtab(Elf_Ehdr *const ehdr, Elf_Shdr const *shdr0,
-			Elf32_Word **symtab,
-			Elf32_Word **symtab_shndx)
-{
-	unsigned const nhdr = get_shnum(ehdr, shdr0);
-	Elf_Shdr const *relhdr;
-	unsigned k;
-
-	*symtab = NULL;
-	*symtab_shndx = NULL;
-
-	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
-		if (relhdr->sh_type == SHT_SYMTAB)
-			*symtab = (void *)ehdr + relhdr->sh_offset;
-		else if (relhdr->sh_type == SHT_SYMTAB_SHNDX)
-			*symtab_shndx = (void *)ehdr + relhdr->sh_offset;
-
-		if (*symtab && *symtab_shndx)
-			break;
-	}
-}
-
 /* Append the new shstrtab, Elf_Shdr[], __mcount_loc and its relocations. */
 static int append_func(Elf_Ehdr *const ehdr,
 			Elf_Shdr *const shstr,
@@ -507,40 +464,37 @@ static int nop_mcount(const struct section * const rels,
  *    Num:    Value  Size Type    Bind   Vis      Ndx Name
  *      2: 00000000     0 SECTION LOCAL  DEFAULT    1
  */
-static int find_secsym_ndx(unsigned const txtndx,
+static int find_section_sym_index(unsigned const txtndx,
 				char const *const txtname,
 				uint_t *const recvalp,
 				unsigned int *sym_index,
-				Elf_Shdr const *const symhdr,
-				Elf32_Word const *symtab,
-				Elf32_Word const *symtab_shndx,
 				Elf_Ehdr const *const ehdr)
 {
-	Elf_Sym const *const sym0 = (Elf_Sym const *)(_w(symhdr->sh_offset)
-		+ (void *)ehdr);
-	unsigned const nsym = _w(symhdr->sh_size) / _w(symhdr->sh_entsize);
-	Elf_Sym const *symp;
-	unsigned t;
+	struct symbol *sym;
+	struct section *txts = find_section_by_index(lf, txtndx);
 
-	for (symp = sym0, t = nsym; t; --t, ++symp) {
-		unsigned int const st_bind = ELF_ST_BIND(symp->st_info);
+	if (!txts) {
+		fprintf(stderr, "Cannot find section %u: %s.\n",
+			txtndx, txtname);
+		return missing_sym;
+	}
 
-		if (txtndx == get_symindex(symp, symtab, symtab_shndx)
-			/* avoid STB_WEAK */
-		    && (STB_LOCAL == st_bind || STB_GLOBAL == st_bind)) {
+	list_for_each_entry(sym, &txts->symbol_list, list) {
+		/* avoid symbols with weak binding */
+		if ((sym->bind == STB_LOCAL) || (sym->bind == STB_GLOBAL)) {
 			/* function symbols on ARM have quirks, avoid them */
 			if (w2(ehdr->e_machine) == EM_ARM
-			    && ELF_ST_TYPE(symp->st_info) == STT_FUNC)
+			    && sym->type == STT_FUNC)
 				continue;
 
-			*recvalp = _w(symp->st_value);
-			*sym_index = symp - sym0;
+			*recvalp = sym->sym.st_value;
+			*sym_index = sym->idx;
 			return 0;
 		}
 	}
 	fprintf(stderr, "Cannot find symbol for section %u: %s.\n",
 		txtndx, txtname);
-	return -1;
+	return missing_sym;
 }
 
 static char const *has_rel_mcount(const struct section * const rels)
@@ -577,9 +531,6 @@ static int do_func(Elf_Ehdr *const ehdr,
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
 
-	Elf32_Word *symtab;
-	Elf32_Word *symtab_shndx;
-
 	/* Upper bound on space: assume all relevant relocs are for mcount. */
 	unsigned       totrelsz;
 
@@ -615,8 +566,6 @@ static int do_func(Elf_Ehdr *const ehdr,
 		return -1;
 	}
 
-	find_symtab(ehdr, shdr0, &symtab, &symtab_shndx);
-
 	list_for_each_entry(sec, &lf->sections, list) {
 		char const *txtname;
 
@@ -626,11 +575,8 @@ static int do_func(Elf_Ehdr *const ehdr,
 			uint_t recval = 0;
 
 			symsec_sh_link = sec->sh.sh_link;
-			result = find_secsym_ndx(sec->sh.sh_info, txtname,
-						&recval, &recsym,
-						&shdr0[symsec_sh_link],
-						symtab, symtab_shndx,
-						ehdr);
+			result = find_section_sym_index(sec->sh.sh_info,
+						txtname, &recval, &recsym, ehdr);
 			if (result)
 				goto out;
 
-- 
2.20.1

