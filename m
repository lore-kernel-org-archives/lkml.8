Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9794EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E39D20FC3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgFRX4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgFRX4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:56:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6540D207D8;
        Thu, 18 Jun 2020 23:56:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jm4Od-003lM8-Dy; Thu, 18 Jun 2020 19:56:39 -0400
Message-ID: <20200618235639.320702196@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Jun 2020 19:55:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Matt Helsley <mhelsley@vmware.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [for-linus][PATCH 01/17] recordmcount: support >64k sections
References: <20200618235556.451120786@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>

When compiling a kernel with Clang and LTO, we need to run
recordmcount on vmlinux.o with a large number of sections, which
currently fails as the program doesn't understand extended
section indexes. This change adds support for processing binaries
with >64k sections.

Link: https://lkml.kernel.org/r/20200424193046.160744-1-samitolvanen@google.com
Link: https://lore.kernel.org/lkml/CAK7LNARbZhoaA=Nnuw0=gBrkuKbr_4Ng_Ei57uafujZf7Xazgw@mail.gmail.com/

Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Matt Helsley <mhelsley@vmware.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/recordmcount.h | 98 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 74eab03e31d4..f9b19524da11 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -29,6 +29,11 @@
 #undef has_rel_mcount
 #undef tot_relsize
 #undef get_mcountsym
+#undef find_symtab
+#undef get_shnum
+#undef set_shnum
+#undef get_shstrndx
+#undef get_symindex
 #undef get_sym_str_and_relp
 #undef do_func
 #undef Elf_Addr
@@ -58,6 +63,11 @@
 # define __has_rel_mcount	__has64_rel_mcount
 # define has_rel_mcount		has64_rel_mcount
 # define tot_relsize		tot64_relsize
+# define find_symtab		find_symtab64
+# define get_shnum		get_shnum64
+# define set_shnum		set_shnum64
+# define get_shstrndx		get_shstrndx64
+# define get_symindex		get_symindex64
 # define get_sym_str_and_relp	get_sym_str_and_relp_64
 # define do_func		do64
 # define get_mcountsym		get_mcountsym_64
@@ -91,6 +101,11 @@
 # define __has_rel_mcount	__has32_rel_mcount
 # define has_rel_mcount		has32_rel_mcount
 # define tot_relsize		tot32_relsize
+# define find_symtab		find_symtab32
+# define get_shnum		get_shnum32
+# define set_shnum		set_shnum32
+# define get_shstrndx		get_shstrndx32
+# define get_symindex		get_symindex32
 # define get_sym_str_and_relp	get_sym_str_and_relp_32
 # define do_func		do32
 # define get_mcountsym		get_mcountsym_32
@@ -173,6 +188,67 @@ static int MIPS_is_fake_mcount(Elf_Rel const *rp)
 	return is_fake;
 }
 
+static unsigned int get_symindex(Elf_Sym const *sym, Elf32_Word const *symtab,
+				 Elf32_Word const *symtab_shndx)
+{
+	unsigned long offset;
+	int index;
+
+	if (sym->st_shndx != SHN_XINDEX)
+		return w2(sym->st_shndx);
+
+	offset = (unsigned long)sym - (unsigned long)symtab;
+	index = offset / sizeof(*sym);
+
+	return w(symtab_shndx[index]);
+}
+
+static unsigned int get_shnum(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
+{
+	if (shdr0 && !ehdr->e_shnum)
+		return w(shdr0->sh_size);
+
+	return w2(ehdr->e_shnum);
+}
+
+static void set_shnum(Elf_Ehdr *ehdr, Elf_Shdr *shdr0, unsigned int new_shnum)
+{
+	if (new_shnum >= SHN_LORESERVE) {
+		ehdr->e_shnum = 0;
+		shdr0->sh_size = w(new_shnum);
+	} else
+		ehdr->e_shnum = w2(new_shnum);
+}
+
+static int get_shstrndx(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
+{
+	if (ehdr->e_shstrndx != SHN_XINDEX)
+		return w2(ehdr->e_shstrndx);
+
+	return w(shdr0->sh_link);
+}
+
+static void find_symtab(Elf_Ehdr *const ehdr, Elf_Shdr const *shdr0,
+			unsigned const nhdr, Elf32_Word **symtab,
+			Elf32_Word **symtab_shndx)
+{
+	Elf_Shdr const *relhdr;
+	unsigned k;
+
+	*symtab = NULL;
+	*symtab_shndx = NULL;
+
+	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
+		if (relhdr->sh_type == SHT_SYMTAB)
+			*symtab = (void *)ehdr + relhdr->sh_offset;
+		else if (relhdr->sh_type == SHT_SYMTAB_SHNDX)
+			*symtab_shndx = (void *)ehdr + relhdr->sh_offset;
+
+		if (*symtab && *symtab_shndx)
+			break;
+	}
+}
+
 /* Append the new shstrtab, Elf_Shdr[], __mcount_loc and its relocations. */
 static int append_func(Elf_Ehdr *const ehdr,
 			Elf_Shdr *const shstr,
@@ -188,10 +264,12 @@ static int append_func(Elf_Ehdr *const ehdr,
 	char const *mc_name = (sizeof(Elf_Rela) == rel_entsize)
 		? ".rela__mcount_loc"
 		:  ".rel__mcount_loc";
-	unsigned const old_shnum = w2(ehdr->e_shnum);
 	uint_t const old_shoff = _w(ehdr->e_shoff);
 	uint_t const old_shstr_sh_size   = _w(shstr->sh_size);
 	uint_t const old_shstr_sh_offset = _w(shstr->sh_offset);
+	Elf_Shdr *const shdr0 = (Elf_Shdr *)(old_shoff + (void *)ehdr);
+	unsigned int const old_shnum = get_shnum(ehdr, shdr0);
+	unsigned int const new_shnum = 2 + old_shnum; /* {.rel,}__mcount_loc */
 	uint_t t = 1 + strlen(mc_name) + _w(shstr->sh_size);
 	uint_t new_e_shoff;
 
@@ -201,6 +279,8 @@ static int append_func(Elf_Ehdr *const ehdr,
 	t += (_align & -t);  /* word-byte align */
 	new_e_shoff = t;
 
+	set_shnum(ehdr, shdr0, new_shnum);
+
 	/* body for new shstrtab */
 	if (ulseek(sb.st_size, SEEK_SET) < 0)
 		return -1;
@@ -255,7 +335,6 @@ static int append_func(Elf_Ehdr *const ehdr,
 		return -1;
 
 	ehdr->e_shoff = _w(new_e_shoff);
-	ehdr->e_shnum = w2(2 + w2(ehdr->e_shnum));  /* {.rel,}__mcount_loc */
 	if (ulseek(0, SEEK_SET) < 0)
 		return -1;
 	if (uwrite(ehdr, sizeof(*ehdr)) < 0)
@@ -434,6 +513,8 @@ static int find_secsym_ndx(unsigned const txtndx,
 				uint_t *const recvalp,
 				unsigned int *sym_index,
 				Elf_Shdr const *const symhdr,
+				Elf32_Word const *symtab,
+				Elf32_Word const *symtab_shndx,
 				Elf_Ehdr const *const ehdr)
 {
 	Elf_Sym const *const sym0 = (Elf_Sym const *)(_w(symhdr->sh_offset)
@@ -445,7 +526,7 @@ static int find_secsym_ndx(unsigned const txtndx,
 	for (symp = sym0, t = nsym; t; --t, ++symp) {
 		unsigned int const st_bind = ELF_ST_BIND(symp->st_info);
 
-		if (txtndx == w2(symp->st_shndx)
+		if (txtndx == get_symindex(symp, symtab, symtab_shndx)
 			/* avoid STB_WEAK */
 		    && (STB_LOCAL == st_bind || STB_GLOBAL == st_bind)) {
 			/* function symbols on ARM have quirks, avoid them */
@@ -516,21 +597,23 @@ static unsigned tot_relsize(Elf_Shdr const *const shdr0,
 	return totrelsz;
 }
 
-
 /* Overall supervision for Elf32 ET_REL file. */
 static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 		   unsigned const reltype)
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
-	unsigned const nhdr = w2(ehdr->e_shnum);
-	Elf_Shdr *const shstr = &shdr0[w2(ehdr->e_shstrndx)];
+	unsigned const nhdr = get_shnum(ehdr, shdr0);
+	Elf_Shdr *const shstr = &shdr0[get_shstrndx(ehdr, shdr0)];
 	char const *const shstrtab = (char const *)(_w(shstr->sh_offset)
 		+ (void *)ehdr);
 
 	Elf_Shdr const *relhdr;
 	unsigned k;
 
+	Elf32_Word *symtab;
+	Elf32_Word *symtab_shndx;
+
 	/* Upper bound on space: assume all relevant relocs are for mcount. */
 	unsigned       totrelsz;
 
@@ -561,6 +644,8 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 		return -1;
 	}
 
+	find_symtab(ehdr, shdr0, nhdr, &symtab, &symtab_shndx);
+
 	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
 		char const *const txtname = has_rel_mcount(relhdr, shdr0,
 			shstrtab, fname);
@@ -577,6 +662,7 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 			result = find_secsym_ndx(w(relhdr->sh_info), txtname,
 						&recval, &recsym,
 						&shdr0[symsec_sh_link],
+						symtab, symtab_shndx,
 						ehdr);
 			if (result)
 				goto out;
-- 
2.26.2


