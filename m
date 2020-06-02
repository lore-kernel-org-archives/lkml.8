Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983A1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A54E2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgFBTwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:52:45 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36862 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728259AbgFBTu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:50:56 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:50:50 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 6FA5440BF1;
        Tue,  2 Jun 2020 12:50:50 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 05/32] objtool: recordmcount: Convert do_func() relhdrs
Date:   Tue, 2 Jun 2020 12:49:58 -0700
Message-ID: <c4bff7ea22c0cf9c9c0fbe7f253ae5efa95fc969.1591125127.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1591125127.git.mhelsley@vmware.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use objtool's ELF data structures to visit the relocation
sections in the top-level ELF file walking function, do_func().
This means we can pass pointers to the relocation header structures
into nested functions and avoid the indexing patterns for them.

These conversions don't use libelf/objtool to modify the ELF
file -- it only changes the way we walk the ELF sections and do
lookups to find the relocations.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.h | 62 +++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 1a848b8104c8..3c4807dca3d0 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -285,7 +285,7 @@ static unsigned get_mcountsym(Elf_Sym const *const sym0,
 	return mcountsym;
 }
 
-static void get_sym_str_and_relp(Elf_Shdr const *const relhdr,
+static void get_sym_str_and_relp(GElf_Shdr const *const relhdr,
 				 Elf_Ehdr const *const ehdr,
 				 Elf_Sym const **sym0,
 				 char const **str0,
@@ -293,10 +293,10 @@ static void get_sym_str_and_relp(Elf_Shdr const *const relhdr,
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
-	unsigned const symsec_sh_link = w(relhdr->sh_link);
+	unsigned const symsec_sh_link = relhdr->sh_link;
 	Elf_Shdr const *const symsec = &shdr0[symsec_sh_link];
 	Elf_Shdr const *const strsec = &shdr0[w(symsec->sh_link)];
-	Elf_Rel const *const rel0 = (Elf_Rel const *)(_w(relhdr->sh_offset)
+	Elf_Rel const *const rel0 = (Elf_Rel const *)(relhdr->sh_offset
 		+ (void *)ehdr);
 
 	*sym0 = (Elf_Sym const *)(_w(symsec->sh_offset)
@@ -316,9 +316,9 @@ static void get_sym_str_and_relp(Elf_Shdr const *const relhdr,
 static uint_t *sift_rel_mcount(uint_t *mlocp,
 			       unsigned const offbase,
 			       Elf_Rel **const mrelpp,
-			       Elf_Shdr const *const relhdr,
+			       GElf_Shdr const *const relhdr,
 			       Elf_Ehdr const *const ehdr,
-			       unsigned const recsym,
+			       unsigned const recsym_index,
 			       uint_t const recval,
 			       unsigned const reltype)
 {
@@ -327,8 +327,8 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 	Elf_Sym const *sym0;
 	char const *str0;
 	Elf_Rel const *relp;
-	unsigned rel_entsize = _w(relhdr->sh_entsize);
-	unsigned const nrel = _w(relhdr->sh_size) / rel_entsize;
+	unsigned int rel_entsize = relhdr->sh_entsize;
+	unsigned const nrel = relhdr->sh_size / rel_entsize;
 	unsigned mcountsym = 0;
 	unsigned t;
 
@@ -344,7 +344,7 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 				_w(_w(relp->r_offset) - recval + mcount_adjust);
 			mrelp->r_offset = _w(offbase
 				+ ((void *)mlocp - (void *)mloc0));
-			Elf_r_info(mrelp, recsym, reltype);
+			Elf_r_info(mrelp, recsym_index, reltype);
 			if (rel_entsize == sizeof(Elf_Rela)) {
 				((Elf_Rela *)mrelp)->r_addend = addend;
 				*mlocp++ = 0;
@@ -364,7 +364,7 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
  * that are not going to be traced. The mcount calls here will be converted
  * into nops.
  */
-static int nop_mcount(Elf_Shdr const *const relhdr,
+static int nop_mcount(GElf_Shdr const *const relhdr,
 		      Elf_Ehdr const *const ehdr,
 		      const char *const txtname)
 {
@@ -373,9 +373,9 @@ static int nop_mcount(Elf_Shdr const *const relhdr,
 	Elf_Sym const *sym0;
 	char const *str0;
 	Elf_Rel const *relp;
-	Elf_Shdr const *const shdr = &shdr0[w(relhdr->sh_info)];
-	unsigned rel_entsize = _w(relhdr->sh_entsize);
-	unsigned const nrel = _w(relhdr->sh_size) / rel_entsize;
+	Elf_Shdr const *const shdr = &shdr0[relhdr->sh_info];
+	unsigned int rel_entsize = relhdr->sh_entsize;
+	unsigned const nrel = relhdr->sh_size / rel_entsize;
 	unsigned mcountsym = 0;
 	unsigned t;
 	int once = 0;
@@ -464,13 +464,13 @@ static int find_secsym_ndx(unsigned const txtndx,
 }
 
 /* Evade ISO C restriction: no declaration after statement in has_rel_mcount. */
-static char const * __has_rel_mcount(Elf_Shdr const *const relhdr, /* reltype */
+static char const * __has_rel_mcount(GElf_Shdr const *const relhdr, /* reltype */
 				     Elf_Shdr const *const shdr0,
 				     char const *const shstrtab,
 				     char const *const fname)
 {
 	/* .sh_info depends on .sh_type == SHT_REL[,A] */
-	Elf_Shdr const *const txthdr = &shdr0[w(relhdr->sh_info)];
+	Elf_Shdr const *const txthdr = &shdr0[relhdr->sh_info];
 	char const *const txtname = &shstrtab[w(txthdr->sh_name)];
 
 	if (w(txthdr->sh_type) != SHT_PROGBITS ||
@@ -479,30 +479,29 @@ static char const * __has_rel_mcount(Elf_Shdr const *const relhdr, /* reltype */
 	return txtname;
 }
 
-static char const *has_rel_mcount(Elf_Shdr const *const relhdr,
+static char const *has_rel_mcount(GElf_Shdr const *const relhdr,
 				  Elf_Shdr const *const shdr0,
 				  char const *const shstrtab,
 				  char const *const fname)
 {
-	if (w(relhdr->sh_type) != SHT_REL && w(relhdr->sh_type) != SHT_RELA)
+	if (relhdr->sh_type != SHT_REL && relhdr->sh_type != SHT_RELA)
 		return NULL;
 	return __has_rel_mcount(relhdr, shdr0, shstrtab, fname);
 }
 
 
 static unsigned tot_relsize(Elf_Shdr const *const shdr0,
-			    unsigned nhdr,
 			    const char *const shstrtab,
 			    const char *const fname)
 {
+	struct section *sec;
 	unsigned totrelsz = 0;
-	Elf_Shdr const *shdrp = shdr0;
 	char const *txtname;
 
-	for (; nhdr; --nhdr, ++shdrp) {
-		txtname = has_rel_mcount(shdrp, shdr0, shstrtab, fname);
+	list_for_each_entry(sec, &lf->sections, list) {
+		txtname = has_rel_mcount(&sec->sh, shdr0, shstrtab, fname);
 		if (txtname && is_mcounted_section_name(txtname))
-			totrelsz += _w(shdrp->sh_size);
+			totrelsz += sec->sh.sh_size;
 	}
 	return totrelsz;
 }
@@ -514,13 +513,11 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
-	unsigned const nhdr = w2(ehdr->e_shnum);
 	Elf_Shdr *const shstr = &shdr0[w2(ehdr->e_shstrndx)];
 	char const *const shstrtab = (char const *)(_w(shstr->sh_offset)
 		+ (void *)ehdr);
 
-	Elf_Shdr const *relhdr;
-	unsigned k;
+	GElf_Shdr const *relhdr;
 
 	/* Upper bound on space: assume all relevant relocs are for mcount. */
 	unsigned       totrelsz;
@@ -534,12 +531,14 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 	unsigned rel_entsize = 0;
 	unsigned symsec_sh_link = 0;
 
+	struct section *sec;
+
 	int result = 0;
 
 	if (find_section_by_name(lf, "__mcount_loc") != NULL)
 		return 0;
 
-	totrelsz = tot_relsize(shdr0, nhdr, shstrtab, fname);
+	totrelsz = tot_relsize(shdr0, shstrtab, fname);
 	if (totrelsz == 0)
 		return 0;
 	mrel0 = umalloc(totrelsz);
@@ -555,22 +554,25 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 		return -1;
 	}
 
-	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
-		char const *const txtname = has_rel_mcount(relhdr, shdr0,
+	list_for_each_entry(sec, &lf->sections, list) {
+		char const *txtname;
+
+		relhdr = &sec->sh;
+		txtname = has_rel_mcount(relhdr, shdr0,
 			shstrtab, fname);
 		if (txtname && is_mcounted_section_name(txtname)) {
 			unsigned int recsym;
 			uint_t recval = 0;
 
-			symsec_sh_link = w(relhdr->sh_link);
-			result = find_secsym_ndx(w(relhdr->sh_info), txtname,
+			symsec_sh_link = relhdr->sh_link;
+			result = find_secsym_ndx(relhdr->sh_info, txtname,
 						&recval, &recsym,
 						&shdr0[symsec_sh_link],
 						ehdr);
 			if (result)
 				goto out;
 
-			rel_entsize = _w(relhdr->sh_entsize);
+			rel_entsize = relhdr->sh_entsize;
 			mlocp = sift_rel_mcount(mlocp,
 				(void *)mlocp - (void *)mloc0, &mrelp,
 				relhdr, ehdr, recsym, recval, reltype);
-- 
2.20.1

