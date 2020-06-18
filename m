Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA9AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1551208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbgFRUjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:39:41 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731011AbgFRUjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:11 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:03 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id F069AB2656;
        Thu, 18 Jun 2020 16:39:06 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 11/51] objtool: mcount: Use symbol structs to find mcount relocations
Date:   Thu, 18 Jun 2020 13:37:57 -0700
Message-ID: <c5df8d864f7a13833668556070c2d57fe628bf90.1592510545.git.mhelsley@vmware.com>
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

Rather than open coding symbol name lookups in get_sym_and_*()
we rename the structure and use objtool's lookup function to
get the symbol name for a relocation. We also change the name
of the function to better reflect its purpose.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/elf.c          |  2 +-
 tools/objtool/elf.h          |  1 +
 tools/objtool/recordmcount.h | 54 ++++++++++--------------------------
 3 files changed, 17 insertions(+), 40 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 17e39b3a1719..8dcdea8020a5 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -196,7 +196,7 @@ struct section *find_section_by_index(const struct elf *elf, unsigned int idx)
 	return NULL;
 }
 
-static struct symbol *find_symbol_by_index(struct elf *elf, unsigned int idx)
+struct symbol *find_symbol_by_index(const struct elf *elf, unsigned int idx)
 {
 	struct symbol *sym;
 
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 60eb44661658..09fa0d085341 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -135,6 +135,7 @@ struct section *find_section_by_index(const struct elf *elf, unsigned int idx);
 struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
+struct symbol *find_symbol_by_index(const struct elf *elf, unsigned int idx);
 struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset);
 struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, unsigned long offset);
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index b10f7fcd33c3..3dae878f11a8 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -31,7 +31,7 @@
 #undef get_shnum
 #undef set_shnum
 #undef get_shstrndx
-#undef get_sym_str_and_relp
+#undef get_relp
 #undef do_func
 #undef Elf_Addr
 #undef Elf_Ehdr
@@ -62,7 +62,7 @@
 # define get_shnum		get_shnum64
 # define set_shnum		set_shnum64
 # define get_shstrndx		get_shstrndx64
-# define get_sym_str_and_relp	get_sym_str_and_relp_64
+# define get_relp		get_relp_64
 # define do_func		do64
 # define get_mcountsym		get_mcountsym_64
 # define is_fake_mcount		is_fake_mcount64
@@ -97,7 +97,7 @@
 # define get_shnum		get_shnum32
 # define set_shnum		set_shnum32
 # define get_shstrndx		get_shstrndx32
-# define get_sym_str_and_relp	get_sym_str_and_relp_32
+# define get_relp		get_relp_32
 # define do_func		do32
 # define get_mcountsym		get_mcountsym_32
 # define is_fake_mcount		is_fake_mcount32
@@ -298,15 +298,10 @@ static int append_func(Elf_Ehdr *const ehdr,
 	return elf_write(lf);
 }
 
-static unsigned get_mcountsym(Elf_Sym const *const sym0,
-			      Elf_Rel const *relp,
-			      char const *const str0)
+static unsigned get_mcountsym(Elf_Rel const *relp)
 {
-	unsigned mcountsym = 0;
-
-	Elf_Sym const *const symp =
-		&sym0[Elf_r_sym(relp)];
-	char const *symname = &str0[w(symp->st_name)];
+	struct symbol *sym = find_symbol_by_index(lf, Elf_r_sym(relp));
+	char const *symname = sym->name;
 	char const *mcount = gpfx == '_' ? "_mcount" : "mcount";
 	char const *fentry = "__fentry__";
 
@@ -315,31 +310,16 @@ static unsigned get_mcountsym(Elf_Sym const *const sym0,
 	if (strcmp(mcount, symname) == 0 ||
 	    (altmcount && strcmp(altmcount, symname) == 0) ||
 	    (strcmp(fentry, symname) == 0))
-		mcountsym = Elf_r_sym(relp);
-
-	return mcountsym;
+		return Elf_r_sym(relp);
+	return 0;
 }
 
-static void get_sym_str_and_relp(const struct section * const rels,
-				 Elf_Ehdr const *const ehdr,
-				 Elf_Sym const **sym0,
-				 char const **str0,
-				 Elf_Rel const **relp)
+static void get_relp(const struct section * const rels,
+			Elf_Ehdr const *const ehdr,
+			Elf_Rel const **relp)
 {
-	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
-		+ (void *)ehdr);
-	unsigned const symsec_sh_link = rels->sh.sh_link;
-	Elf_Shdr const *const symsec = &shdr0[symsec_sh_link];
-	Elf_Shdr const *const strsec = &shdr0[w(symsec->sh_link)];
 	Elf_Rel const *const rel0 = (Elf_Rel const *)(rels->sh.sh_offset
 		+ (void *)ehdr);
-
-	*sym0 = (Elf_Sym const *)(_w(symsec->sh_offset)
-				  + (void *)ehdr);
-
-	*str0 = (char const *)(_w(strsec->sh_offset)
-			       + (void *)ehdr);
-
 	*relp = rel0;
 }
 
@@ -359,19 +339,17 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 {
 	uint_t *const mloc0 = mlocp;
 	Elf_Rel *mrelp = *mrelpp;
-	Elf_Sym const *sym0;
-	char const *str0;
 	Elf_Rel const *relp;
 	unsigned int rel_entsize = rels->sh.sh_entsize;
 	unsigned const nrel = rels->sh.sh_size / rel_entsize;
 	unsigned mcountsym = 0;
 	unsigned t;
 
-	get_sym_str_and_relp(rels, ehdr, &sym0, &str0, &relp);
+	get_relp(rels, ehdr, &relp);
 
 	for (t = nrel; t; --t) {
 		if (!mcountsym)
-			mcountsym = get_mcountsym(sym0, relp, str0);
+			mcountsym = get_mcountsym(relp);
 
 		if (mcountsym && mcountsym == Elf_r_sym(relp) &&
 				!is_fake_mcount(relp)) {
@@ -405,8 +383,6 @@ static int nop_mcount(const struct section * const rels,
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
-	Elf_Sym const *sym0;
-	char const *str0;
 	Elf_Rel const *relp;
 	Elf_Shdr const *const shdr = &shdr0[rels->sh.sh_info];
 	unsigned rel_entsize = rels->sh.sh_entsize;
@@ -415,13 +391,13 @@ static int nop_mcount(const struct section * const rels,
 	unsigned t;
 	int once = 0;
 
-	get_sym_str_and_relp(rels, ehdr, &sym0, &str0, &relp);
+	get_relp(rels, ehdr, &relp);
 
 	for (t = nrel; t; --t) {
 		int ret = -1;
 
 		if (!mcountsym)
-			mcountsym = get_mcountsym(sym0, relp, str0);
+			mcountsym = get_mcountsym(relp);
 
 		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
 			if (make_nop)
-- 
2.20.1

