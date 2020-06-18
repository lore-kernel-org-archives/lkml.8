Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF44CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0042208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbgFRUji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:39:38 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:3944 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730973AbgFRUjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:09 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:02 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 6FE29B265B;
        Thu, 18 Jun 2020 16:39:05 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 09/51] objtool: mcount: Use libelf for section header names
Date:   Thu, 18 Jun 2020 13:37:55 -0700
Message-ID: <882a2a5754e3a6541fb0d1ef2bd5ea64c51e7904.1592510545.git.mhelsley@vmware.com>
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

Rather than passing in the string table contents as a parameter,
pass in the section index of the string table and rely on libelf
string table accessor functions to look up section names.

Note that modifying the string table with libelf will come later
so append_func() is unchanged.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/elf.c          |  3 +-
 tools/objtool/elf.h          |  1 +
 tools/objtool/recordmcount.c |  2 +-
 tools/objtool/recordmcount.h | 89 ++++++++++++++----------------------
 4 files changed, 37 insertions(+), 58 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 6812cf74be9a..17e39b3a1719 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -185,8 +185,7 @@ struct section *find_section_by_name(const struct elf *elf, const char *name)
 	return NULL;
 }
 
-static struct section *find_section_by_index(struct elf *elf,
-					     unsigned int idx)
+struct section *find_section_by_index(const struct elf *elf, unsigned int idx)
 {
 	struct section *sec;
 
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 6cc80a075166..60eb44661658 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -131,6 +131,7 @@ int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 
 struct section *find_section_by_name(const struct elf *elf, const char *name);
+struct section *find_section_by_index(const struct elf *elf, unsigned int idx);
 struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 9941683b3f60..f20582ac99e2 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -177,7 +177,7 @@ static void *mmap_file(char const *fname)
 	file_updated = 0;
 	sb.st_size = 0;
 
-	lf = elf_open_read(fname, O_RDONLY);
+	lf = elf_open_read(fname, O_RDWR);
 	if (!lf) {
 		perror(fname);
 		return NULL;
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 53abfd49a537..30f8913aa841 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -25,7 +25,6 @@
 #undef sift_rel_mcount
 #undef nop_mcount
 #undef find_secsym_ndx
-#undef __has_rel_mcount
 #undef has_rel_mcount
 #undef tot_relsize
 #undef get_mcountsym
@@ -60,7 +59,6 @@
 # define sift_rel_mcount	sift64_rel_mcount
 # define nop_mcount		nop_mcount_64
 # define find_secsym_ndx	find64_secsym_ndx
-# define __has_rel_mcount	__has64_rel_mcount
 # define has_rel_mcount		has64_rel_mcount
 # define tot_relsize		tot64_relsize
 # define find_symtab		find_symtab64
@@ -98,7 +96,6 @@
 # define sift_rel_mcount	sift32_rel_mcount
 # define nop_mcount		nop_mcount_32
 # define find_secsym_ndx	find32_secsym_ndx
-# define __has_rel_mcount	__has32_rel_mcount
 # define has_rel_mcount		has32_rel_mcount
 # define tot_relsize		tot32_relsize
 # define find_symtab		find_symtab32
@@ -276,6 +273,7 @@ static int append_func(Elf_Ehdr *const ehdr,
 
 	shstr->sh_size = _w(t);
 	shstr->sh_offset = _w(sb.st_size);
+
 	t += sb.st_size;
 	t += (_align & -t);  /* word-byte align */
 	new_e_shoff = t;
@@ -340,7 +338,7 @@ static int append_func(Elf_Ehdr *const ehdr,
 		return -1;
 	if (uwrite(ehdr, sizeof(*ehdr)) < 0)
 		return -1;
-	return 0;
+	return elf_write(lf);
 }
 
 static unsigned get_mcountsym(Elf_Sym const *const sym0,
@@ -365,7 +363,7 @@ static unsigned get_mcountsym(Elf_Sym const *const sym0,
 	return mcountsym;
 }
 
-static void get_sym_str_and_relp(GElf_Shdr const *const relhdr,
+static void get_sym_str_and_relp(const struct section * const rels,
 				 Elf_Ehdr const *const ehdr,
 				 Elf_Sym const **sym0,
 				 char const **str0,
@@ -373,10 +371,10 @@ static void get_sym_str_and_relp(GElf_Shdr const *const relhdr,
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
-	unsigned const symsec_sh_link = relhdr->sh_link;
+	unsigned const symsec_sh_link = rels->sh.sh_link;
 	Elf_Shdr const *const symsec = &shdr0[symsec_sh_link];
 	Elf_Shdr const *const strsec = &shdr0[w(symsec->sh_link)];
-	Elf_Rel const *const rel0 = (Elf_Rel const *)(relhdr->sh_offset
+	Elf_Rel const *const rel0 = (Elf_Rel const *)(rels->sh.sh_offset
 		+ (void *)ehdr);
 
 	*sym0 = (Elf_Sym const *)(_w(symsec->sh_offset)
@@ -396,7 +394,7 @@ static void get_sym_str_and_relp(GElf_Shdr const *const relhdr,
 static uint_t *sift_rel_mcount(uint_t *mlocp,
 			       unsigned const offbase,
 			       Elf_Rel **const mrelpp,
-			       GElf_Shdr const *const relhdr,
+			       const struct section * const rels,
 			       Elf_Ehdr const *const ehdr,
 			       unsigned const recsym_index,
 			       uint_t const recval,
@@ -407,12 +405,12 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 	Elf_Sym const *sym0;
 	char const *str0;
 	Elf_Rel const *relp;
-	unsigned int rel_entsize = relhdr->sh_entsize;
-	unsigned const nrel = relhdr->sh_size / rel_entsize;
+	unsigned int rel_entsize = rels->sh.sh_entsize;
+	unsigned const nrel = rels->sh.sh_size / rel_entsize;
 	unsigned mcountsym = 0;
 	unsigned t;
 
-	get_sym_str_and_relp(relhdr, ehdr, &sym0, &str0, &relp);
+	get_sym_str_and_relp(rels, ehdr, &sym0, &str0, &relp);
 
 	for (t = nrel; t; --t) {
 		if (!mcountsym)
@@ -444,7 +442,7 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
  * that are not going to be traced. The mcount calls here will be converted
  * into nops.
  */
-static int nop_mcount(GElf_Shdr const *const relhdr,
+static int nop_mcount(const struct section * const rels,
 		      Elf_Ehdr const *const ehdr,
 		      const char *const txtname)
 {
@@ -453,14 +451,14 @@ static int nop_mcount(GElf_Shdr const *const relhdr,
 	Elf_Sym const *sym0;
 	char const *str0;
 	Elf_Rel const *relp;
-	Elf_Shdr const *const shdr = &shdr0[relhdr->sh_info];
-	unsigned int rel_entsize = relhdr->sh_entsize;
-	unsigned const nrel = relhdr->sh_size / rel_entsize;
+	Elf_Shdr const *const shdr = &shdr0[rels->sh.sh_info];
+	unsigned rel_entsize = rels->sh.sh_entsize;
+	unsigned const nrel = rels->sh.sh_size / rel_entsize;
 	unsigned mcountsym = 0;
 	unsigned t;
 	int once = 0;
 
-	get_sym_str_and_relp(relhdr, ehdr, &sym0, &str0, &relp);
+	get_sym_str_and_relp(rels, ehdr, &sym0, &str0, &relp);
 
 	for (t = nrel; t; --t) {
 		int ret = -1;
@@ -545,40 +543,27 @@ static int find_secsym_ndx(unsigned const txtndx,
 	return -1;
 }
 
-/* Evade ISO C restriction: no declaration after statement in has_rel_mcount. */
-static char const * __has_rel_mcount(GElf_Shdr const *const relhdr, /* reltype */
-				     Elf_Shdr const *const shdr0,
-				     char const *const shstrtab)
+static char const *has_rel_mcount(const struct section * const rels)
 {
-	/* .sh_info depends on .sh_type == SHT_REL[,A] */
-	Elf_Shdr const *const txthdr = &shdr0[relhdr->sh_info];
-	char const *const txtname = &shstrtab[w(txthdr->sh_name)];
-
-	if (w(txthdr->sh_type) != SHT_PROGBITS ||
-	    !(_w(txthdr->sh_flags) & SHF_EXECINSTR))
+	const struct section *txts;
+	if (rels->sh.sh_type != SHT_REL && rels->sh.sh_type != SHT_RELA)
 		return NULL;
-	return txtname;
-}
-
-static char const *has_rel_mcount(GElf_Shdr const *const relhdr,
-				  Elf_Shdr const *const shdr0,
-				  char const *const shstrtab)
-{
-	if (relhdr->sh_type != SHT_REL && relhdr->sh_type != SHT_RELA)
+	txts = find_section_by_index(lf, rels->sh.sh_info);
+	if ((txts->sh.sh_type != SHT_PROGBITS) ||
+	    !(txts->sh.sh_flags & SHF_EXECINSTR))
 		return NULL;
-	return __has_rel_mcount(relhdr, shdr0, shstrtab);
+	return txts->name;
 }
 
 
-static unsigned tot_relsize(Elf_Shdr const *const shdr0,
-			    const char *const shstrtab)
+static unsigned tot_relsize(void)
 {
-	struct section *sec;
+	const struct section *sec;
 	unsigned totrelsz = 0;
 	char const *txtname;
 
 	list_for_each_entry(sec, &lf->sections, list) {
-		txtname = has_rel_mcount(&sec->sh, shdr0, shstrtab);
+		txtname = has_rel_mcount(sec);
 		if (txtname && is_mcounted_section_name(txtname))
 			totrelsz += sec->sh.sh_size;
 	}
@@ -591,11 +576,6 @@ static int do_func(Elf_Ehdr *const ehdr,
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
-	Elf_Shdr *const shstr = &shdr0[get_shstrndx(ehdr, shdr0)];
-	char const *const shstrtab = (char const *)(_w(shstr->sh_offset)
-		+ (void *)ehdr);
-
-	GElf_Shdr const *relhdr;
 
 	Elf32_Word *symtab;
 	Elf32_Word *symtab_shndx;
@@ -612,14 +592,14 @@ static int do_func(Elf_Ehdr *const ehdr,
 	unsigned rel_entsize = 0;
 	unsigned symsec_sh_link = 0;
 
-	struct section *sec;
+	const struct section *sec;
 
 	int result = 0;
 
 	if (find_section_by_name(lf, "__mcount_loc") != NULL)
 		return 0;
 
-	totrelsz = tot_relsize(shdr0, shstrtab);
+	totrelsz = tot_relsize();
 	if (totrelsz == 0)
 		return 0;
 	mrel0 = umalloc(totrelsz);
@@ -640,15 +620,13 @@ static int do_func(Elf_Ehdr *const ehdr,
 	list_for_each_entry(sec, &lf->sections, list) {
 		char const *txtname;
 
-		relhdr = &sec->sh;
-		txtname = has_rel_mcount(relhdr, shdr0,
-			shstrtab);
+		txtname = has_rel_mcount(sec);
 		if (txtname && is_mcounted_section_name(txtname)) {
 			unsigned int recsym;
 			uint_t recval = 0;
 
-			symsec_sh_link = relhdr->sh_link;
-			result = find_secsym_ndx(relhdr->sh_info, txtname,
+			symsec_sh_link = sec->sh.sh_link;
+			result = find_secsym_ndx(sec->sh.sh_info, txtname,
 						&recval, &recsym,
 						&shdr0[symsec_sh_link],
 						symtab, symtab_shndx,
@@ -656,23 +634,24 @@ static int do_func(Elf_Ehdr *const ehdr,
 			if (result)
 				goto out;
 
-			rel_entsize = relhdr->sh_entsize;
+			rel_entsize = sec->sh.sh_entsize;
 			mlocp = sift_rel_mcount(mlocp,
 				(void *)mlocp - (void *)mloc0, &mrelp,
-				relhdr, ehdr, recsym, recval, reltype);
+				sec, ehdr, recsym, recval, reltype);
 		} else if (txtname && (warn_on_notrace_sect || make_nop)) {
 			/*
 			 * This section is ignored by ftrace, but still
 			 * has mcount calls. Convert them to nops now.
 			 */
-			if (nop_mcount(relhdr, ehdr, txtname) < 0) {
+			if (nop_mcount(sec, ehdr, txtname) < 0) {
 				result = -1;
 				goto out;
 			}
 		}
 	}
 	if (!result && mloc0 != mlocp)
-		result = append_func(ehdr, shstr, mloc0, mlocp, mrel0, mrelp,
+		result = append_func(ehdr, &shdr0[get_shstrndx(ehdr, shdr0)],
+				     mloc0, mlocp, mrel0, mrelp,
 				     rel_entsize, symsec_sh_link);
 out:
 	free(mrel0);
-- 
2.20.1

