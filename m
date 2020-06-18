Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F8DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EE720732
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbgFRUkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:42 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:40437 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731038AbgFRUji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:38 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:34 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 29829B2656;
        Thu, 18 Jun 2020 16:39:37 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 44/51] objtool: mcount: Keep lists locations and relocations
Date:   Thu, 18 Jun 2020 13:38:30 -0700
Message-ID: <f336a494e9e679750f2924b86e4aaa0e85c8e32f.1592510545.git.mhelsley@vmware.com>
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

To reduce the need for an initial pass through the sections
we need to keep lists of mcount call locations and suitable
relocations. A subsequent patch will eliminate the need for
the first pass entirely.

Introduce a new list for the locations and reuse objtool's
relocation lists respectively.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/mcount.c | 133 +++++++++++++++++++++++------------------
 1 file changed, 75 insertions(+), 58 deletions(-)

diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index 7fbde6ce6eb8..7d7843f7cd44 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -43,9 +43,15 @@
 
 #define R_ARM_THM_CALL		10
 
+struct mcount_loc {
+	struct list_head list;
+	GElf_Addr loc;
+};
+
 extern int warn_on_notrace_sect; /* warn when section has mcount not being recorded */
 
 static struct elf *lf;
+static struct list_head mcount_locs;
 
 static const char ip_relative_call_x86[5] = { 0xe8, 0x00, 0x00, 0x00, 0x00 };
 static const char ideal_nop5_x86_64[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
@@ -294,20 +300,17 @@ static char const *has_rel_mcount(const struct section * const rels)
 	return txts->name;
 }
 
-static unsigned tot_relsize(unsigned int *rel_entsize)
+static void tot_relsize(unsigned int *rel_entsize)
 {
 	const struct section *sec;
-	unsigned totrelsz = 0;
 	char const *txtname;
 
 	list_for_each_entry(sec, &lf->sections, list) {
 		txtname = has_rel_mcount(sec);
 		if (!(txtname && is_mcounted_section_name(txtname)))
 			continue;
-		totrelsz += sec->sh.sh_size;
 		*rel_entsize = sec->sh.sh_entsize;
 	}
-	return totrelsz;
 }
 
 /* zero or a small negative offset added to get the start of the call
@@ -323,55 +326,89 @@ static size_t loc_size;
  * Accumulate the section offsets that are found, and their relocation info,
  * onto the end of the existing arrays.
  */
-static void sift_rel_mcount(GElf_Addr **mlocpp,
-			       GElf_Sxword *r_offsetp,
-			       void **const mrelpp,
+static void sift_rel_mcount(GElf_Sxword *r_offsetp,
 			       const struct section * const rels,
+			       struct section *mc_relocs,
+			       struct section *mc_locs,
 			       unsigned const recsym_index,
 			       unsigned long const recval,
 			       unsigned const reltype,
 			       bool is_rela)
 {
-	GElf_Rel *mrelp = *mrelpp;
-	GElf_Rela *mrelap = *mrelpp;
 	struct reloc *reloc;
 
 	list_for_each_entry(reloc, &rels->reloc_list, list) {
 		unsigned long addend;
+		struct mcount_loc *mc_loc;
+		struct reloc *mc_reloc;
+
+		if (reloc->sym->class != SYM_MCOUNT || is_fake_mcount(reloc))
+			continue;
 
-		if (reloc->sym->class == SYM_MCOUNT || is_fake_mcount(reloc))
+		mc_loc = malloc(sizeof(*mc_loc));
+		if (!mc_loc) {
+			perror("malloc");
 			continue;
+		}
+		mc_reloc = malloc(sizeof(*mc_reloc));
+		if (!mc_reloc) {
+			perror("malloc");
+			free(mc_loc);
+			continue;
+		}
+		memset(mc_reloc, 0, sizeof(*mc_reloc));
+		memset(mc_loc, 0, sizeof(*mc_loc));
+		mc_reloc->sec = mc_relocs;
 
 		addend = reloc->offset - recval + mcount_adjust;
 		if (is_rela) {
-			mrelap->r_offset = *r_offsetp;
-			mrelap->r_info = GELF_R_INFO(recsym_index, reltype);
-			mrelap->r_addend = addend;
-			mrelap++;
-			**mlocpp = 0;
+			mc_reloc->rela.r_offset = *r_offsetp;
+			mc_reloc->rela.r_info = GELF_R_INFO(recsym_index, reltype);
+			mc_reloc->rela.r_addend = addend;
+			mc_loc->loc = 0;
 		} else {
-			mrelp->r_offset = *r_offsetp;
-			mrelp->r_info = GELF_R_INFO(recsym_index, reltype);
-			mrelp++;
-			**mlocpp = addend;
+			mc_reloc->rel.r_offset = *r_offsetp;
+			mc_reloc->rel.r_info = GELF_R_INFO(recsym_index, reltype);
+			mc_loc->loc = addend;
 		}
-		(*mlocpp)++;
+		mc_reloc->offset = *r_offsetp;
+		mc_reloc->type = reltype;
+		mc_reloc->sec = mc_locs;
+		elf_add_reloc(lf, mc_reloc);
+
+		list_add_tail(&mc_loc->list, &mcount_locs);
 		*r_offsetp += loc_size;
 	}
-	*mrelpp = is_rela ? (void *)mrelap : (void *)mrelp;
 }
 
-/* Overall supervision for Elf32 ET_REL file. */
-static int do_mcount(unsigned const reltype, size_t rela_size)
+/* Convert list of mcount locations to an array/buffer for libelf */
+static void fill_mcount_locs(GElf_Sxword r_offset, GElf_Addr **rbuf,
+			     size_t *rsize)
 {
-	/* Upper bound on space: assume all relevant relocs are for mcount. */
-	unsigned       totrelsz;
+	GElf_Addr *buf, *loc;
+	struct mcount_loc *entry, *next;
+	size_t size = sizeof(*loc) * r_offset / loc_size;
+
+	buf = malloc(size);
+	if (!buf) {
+		perror("malloc");
+		return;
+	}
 
-	void *mrel0;
-	void *mrelp;
+	loc = buf;
+	list_for_each_entry_safe(entry, next, &mcount_locs, list) {
+		*loc = entry->loc;
+		list_del(&entry->list);
+		free(entry);
+		loc++;
+	}
+	*rbuf = buf;
+	*rsize = size;
+}
 
-	GElf_Addr *mloc0;
-	GElf_Addr *mlocp;
+/* Overall supervision for Elf32 ET_REL file. */
+static int do_mcount(unsigned const reltype, size_t rela_size)
+{
 	GElf_Sxword r_offset = 0;
 
 	struct section *sec, *mlocs, *mrels;
@@ -384,33 +421,16 @@ static int do_mcount(unsigned const reltype, size_t rela_size)
 	if (find_section_by_name(lf, "__mcount_loc") != NULL)
 		return 0;
 
-	totrelsz = tot_relsize(&rel_entsize);
-	if (totrelsz == 0)
-		return 0;
-
-	mrel0 = malloc(totrelsz);
-	mrelp = mrel0;
-	if (!mrel0)
-		return -1;
-
-	/* 2*sizeof(address) <= sizeof(Elf_Rel) */
-	mloc0 = malloc(totrelsz>>1);
-	mlocp = mloc0;
-	if (!mloc0) {
-		free(mrel0);
-		return -1;
-	}
-
+	tot_relsize(&rel_entsize);
 	is_rela = (rela_size == rel_entsize);
 
 	/* add section: __mcount_loc */
-	mlocs = elf_create_section(lf, mc_name, sizeof(*mloc0), 0);
+	mlocs = elf_create_section(lf, mc_name, sizeof(GElf_Addr), 0);
 	if (!mlocs)
 		goto out;
 	mlocs->sh.sh_link = 0;
 	mlocs->sh.sh_info = 0;
 	mlocs->sh.sh_addralign = 8;
-	mlocs->data->d_buf = mloc0;
 	mlocs->data->d_type = ELF_T_ADDR; /* elf_xlatetof() conversion */
 
 	/* add section .rel[a]__mcount_loc */
@@ -419,7 +439,6 @@ static int do_mcount(unsigned const reltype, size_t rela_size)
 	if (!mrels)
 		goto out;
 	mrels->sh.sh_flags = 0; /* clear SHF_INFO_LINK */
-	mrels->data->d_buf = mrel0;
 
 	list_for_each_entry(sec, &lf->sections, list) {
 		char const *txtname;
@@ -433,7 +452,7 @@ static int do_mcount(unsigned const reltype, size_t rela_size)
 						txtname, &recval, &recsym))
 				goto out;
 
-			sift_rel_mcount(&mlocp, &r_offset, &mrelp, sec,
+			sift_rel_mcount(&r_offset, sec, mrels, mlocs,
 				recsym, recval, reltype, is_rela);
 		} else if (txtname && (warn_on_notrace_sect || make_nop)) {
 			/*
@@ -445,25 +464,21 @@ static int do_mcount(unsigned const reltype, size_t rela_size)
 		}
 	}
 
-	if (mloc0 != mlocp) {
+	if (!list_empty(&mcount_locs)) {
+		fill_mcount_locs(r_offset, (GElf_Addr **)&mlocs->data->d_buf,
+				 &mlocs->sh.sh_size);
 		/* Update the section size and Elf_Data size */
-		mlocs->sh.sh_size = (void *)mlocp - (void *)mloc0;
 		mlocs->len = mlocs->sh.sh_size;
 		mlocs->data->d_size = mlocs->len;
 		elf_flagdata(mlocs->data, ELF_C_SET, ELF_F_DIRTY);
 
-		mrels->sh.sh_size = mrelp - mrel0;
-		mrels->len = mrels->sh.sh_size;
-		mrels->data->d_size = mrels->len;
-		elf_flagdata(mrels->data, ELF_C_SET, ELF_F_DIRTY);
+		elf_rebuild_reloc_section(lf, mrels);
 
 		/* overwrite the ELF file */
 		result = elf_write(lf);
 	} else
 		result = 0;
 out:
-	free(mrel0);
-	free(mloc0);
 	return result;
 }
 
@@ -490,6 +505,8 @@ static int do_file(char const *const fname)
 		goto out;
 	}
 
+	INIT_LIST_HEAD(&mcount_locs);
+
 	switch (lf->ehdr.e_ident[EI_DATA]) {
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
-- 
2.20.1

