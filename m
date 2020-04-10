Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29698C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0909920732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgDJTh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:37:28 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:17492 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbgDJTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:37:26 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:37:21 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 28B3D40BBE;
        Fri, 10 Apr 2020 12:37:25 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 13/36] objtool: mcount: Walk objtool Elf structs in find_secsym_ndx
Date:   Fri, 10 Apr 2020 12:35:36 -0700
Message-ID: <96b6c87aae0c10198640e998cb77d5c811d31db9.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
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
wrapper, use the objtool and libelf structures.

Also take advantage of this commit to rename the function to
something that reads more easily.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c |  2 ++
 tools/objtool/recordmcount.h | 42 ++++++++++++++++--------------------
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index e69d2cccce2d..5a05a08f0e28 100644
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
index b487308992ce..dba1c385106f 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -24,7 +24,7 @@
 #undef mcount_adjust
 #undef sift_rel_mcount
 #undef nop_mcount
-#undef find_secsym_ndx
+#undef find_section_sym_index
 #undef has_rel_mcount
 #undef tot_relsize
 #undef get_mcountsym
@@ -53,7 +53,7 @@
 # define append_func		append64
 # define sift_rel_mcount	sift64_rel_mcount
 # define nop_mcount		nop_mcount_64
-# define find_secsym_ndx	find64_secsym_ndx
+# define find_section_sym_index	find64_section_sym_index
 # define has_rel_mcount		has64_rel_mcount
 # define tot_relsize		tot64_relsize
 # define get_sym_str_and_relp	get_sym_str_and_relp_64
@@ -85,7 +85,7 @@
 # define append_func		append32
 # define sift_rel_mcount	sift32_rel_mcount
 # define nop_mcount		nop_mcount_32
-# define find_secsym_ndx	find32_secsym_ndx
+# define find_section_sym_index	find32_section_sym_index
 # define has_rel_mcount		has32_rel_mcount
 # define tot_relsize		tot32_relsize
 # define get_sym_str_and_relp	get_sym_str_and_relp_32
@@ -427,38 +427,36 @@ static int nop_mcount(const struct section * const rels,
  *    Num:    Value  Size Type    Bind   Vis      Ndx Name
  *      2: 00000000     0 SECTION LOCAL  DEFAULT    1
  */
-static int find_secsym_ndx(unsigned const txtndx,
+static int find_section_sym_index(unsigned const txtndx,
 				char const *const txtname,
 				uint_t *const recvalp,
 				unsigned int *sym_index,
-				Elf_Shdr const *const symhdr,
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
 
-		if (txtndx == w2(symp->st_shndx)
-			/* avoid STB_WEAK */
-		    && (STB_LOCAL == st_bind || STB_GLOBAL == st_bind)) {
+	list_for_each_entry(sym, &txts->symbol_list, list) {
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
@@ -540,10 +538,8 @@ static int do_func(Elf_Ehdr *const ehdr,
 			uint_t recval = 0;
 
 			symsec_sh_link = sec->sh.sh_link;
-			result = find_secsym_ndx(sec->sh.sh_info, txtname,
-						&recval, &recsym,
-						&shdr0[symsec_sh_link],
-						ehdr);
+			result = find_section_sym_index(sec->sh.sh_info,
+						txtname, &recval, &recsym, ehdr);
 			if (result)
 				goto out;
 
-- 
2.20.1

