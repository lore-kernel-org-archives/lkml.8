Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7884BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BCF20890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbgFRUmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:42:31 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731104AbgFRUj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:27 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:18 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id CAE67B2656;
        Thu, 18 Jun 2020 16:39:21 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 29/51] objtool: mcount: Pre-allocate new ELF sections
Date:   Thu, 18 Jun 2020 13:38:15 -0700
Message-ID: <91a5637dc04aa586ca68914e7036fe47190db300.1592510545.git.mhelsley@vmware.com>
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

Rather than allocating the ELF sections after collecting the
mcount locations and building the relocation entries, create
the empty sections beforehand. This has the benefit of
removing the memcpy() and just using the resulting libelf
buffers directly.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.h | 122 +++++++++++++++--------------------
 1 file changed, 53 insertions(+), 69 deletions(-)

diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index e2c8b9d4725d..ce88f0c2f79b 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -17,7 +17,6 @@
  * This conversion to macros was done by:
  * Copyright 2010 Steven Rostedt <srostedt@redhat.com>, Red Hat Inc.
  */
-#undef append_func
 #undef sift_rel_mcount
 #undef do_func
 #undef Elf_Shdr
@@ -31,7 +30,6 @@
 #undef _size
 
 #ifdef RECORD_MCOUNT_64
-# define append_func		append64
 # define sift_rel_mcount	sift64_rel_mcount
 # define do_func		do64
 # define Elf_Rel		Elf64_Rel
@@ -43,7 +41,6 @@
 # define _w			w8
 # define _size			8
 #else
-# define append_func		append32
 # define sift_rel_mcount	sift32_rel_mcount
 # define do_func		do32
 # define Elf_Rel		Elf32_Rel
@@ -62,57 +59,6 @@ static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
 }
 static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
 
-/* Append the new  __mcount_loc and its relocations. */
-static int append_func(uint_t const *const mloc0,
-			uint_t const *const mlocp,
-			Elf_Rel const *const mrel0,
-			Elf_Rel const *const mrelp,
-			unsigned int const loc_size,
-			unsigned int const rel_entsize,
-			unsigned int const symsec_sh_link)
-{
-	/* Begin constructing output file */
-	struct section *mcount_loc_sec, *reloc_sec;
-	char const *mc_name = (sizeof(Elf_Rela) == rel_entsize)
-		? ".rela__mcount_loc"
-		:  ".rel__mcount_loc";
-
-	/* add section: __mcount_loc */
-	mcount_loc_sec = elf_create_section(lf,
-		mc_name + (sizeof(Elf_Rela) == rel_entsize) + strlen(".rel"),
-		loc_size, mlocp - mloc0);
-	if (!mcount_loc_sec)
-		return -1;
-	// created mcount_loc_sec->sh.sh_size = (void *)mlocp - (void *)mloc0;
-	mcount_loc_sec->sh.sh_link = 0;
-	mcount_loc_sec->sh.sh_info = 0;
-	mcount_loc_sec->sh.sh_addralign = loc_size;
-	// created mcount_loc_sec->sh.sh_entsize = loc_size;
-
-	// assert mcount_loc_sec->data->d_size == (void *)mlocp - (void *)mloc0
-	memcpy(mcount_loc_sec->data->d_buf, mloc0,
-	       mcount_loc_sec->data->d_size);
-	elf_flagdata(mcount_loc_sec->data, ELF_C_SET, ELF_F_DIRTY);
-
-	/* add section .rel[a]__mcount_loc */
-	reloc_sec = elf_create_section(lf, mc_name, rel_entsize,
-					      mrelp - mrel0);
-	if (!reloc_sec)
-		return -1;
-	reloc_sec->sh.sh_type = (sizeof(Elf_Rela) == rel_entsize) ?
-						SHT_RELA : SHT_REL;
-	reloc_sec->sh.sh_flags = 0; /* clear SHF_ALLOC */
-	reloc_sec->sh.sh_link = find_section_by_name(lf, ".symtab")->idx;
-	reloc_sec->sh.sh_info = mcount_loc_sec->idx;
-	reloc_sec->sh.sh_addralign = loc_size;
-
-	// assert reloc_sec->data->d_size == (void *)mrelp - (void *)mrel0
-	memcpy(reloc_sec->data->d_buf, mrel0, reloc_sec->data->d_size);
-	elf_flagdata(reloc_sec->data, ELF_C_SET, ELF_F_DIRTY);
-
-	return elf_write(lf);
-}
-
 /*
  * Look at the relocations in order to find the calls to mcount.
  * Accumulate the section offsets that are found, and their relocation info,
@@ -167,12 +113,12 @@ static int do_func(unsigned const reltype)
 	uint_t *      mloc0;
 	uint_t *      mlocp;
 
-	unsigned int rel_entsize = 0;
-	unsigned symsec_sh_link = 0;
-
-	struct section *sec;
+	struct section *sec, *mlocs, *mrels;
+	char const *mc_name;
 
-	int result = 0;
+	unsigned int rel_entsize = 0;
+	int result = -1;
+	bool is_rela;
 
 	if (find_section_by_name(lf, "__mcount_loc") != NULL)
 		return 0;
@@ -180,6 +126,7 @@ static int do_func(unsigned const reltype)
 	totrelsz = tot_relsize(&rel_entsize);
 	if (totrelsz == 0)
 		return 0;
+
 	mrel0 = malloc(totrelsz);
 	mrelp = mrel0;
 	if (!mrel0)
@@ -193,6 +140,31 @@ static int do_func(unsigned const reltype)
 		return -1;
 	}
 
+	is_rela = (sizeof(Elf_Rela) == rel_entsize);
+	mc_name = is_rela
+			? ".rela__mcount_loc"
+			:  ".rel__mcount_loc";
+
+	/* add section: __mcount_loc */
+	mlocs = elf_create_section(lf, mc_name + (is_rela ? 1 : 0) + strlen(".rel"), _size, 0);
+	if (!mlocs)
+		goto out;
+	mlocs->sh.sh_link = 0;
+	mlocs->sh.sh_info = 0;
+	mlocs->sh.sh_addralign = _size;
+
+	/* add section .rel[a]__mcount_loc */
+	mrels = elf_create_section(lf, mc_name, rel_entsize, 0);
+	if (!mrels)
+		goto out;
+	mrels->sh.sh_type = is_rela
+				? SHT_RELA
+				: SHT_REL;
+	mrels->sh.sh_flags = 0; /* clear SHF_ALLOC */
+	mrels->sh.sh_link = find_section_by_name(lf, ".symtab")->idx;
+	mrels->sh.sh_info = mlocs->idx;
+	mrels->sh.sh_addralign = _size;
+
 	list_for_each_entry(sec, &lf->sections, list) {
 		char const *txtname;
 
@@ -201,10 +173,8 @@ static int do_func(unsigned const reltype)
 			unsigned long recval = 0;
 			unsigned int recsym;
 
-			symsec_sh_link = sec->sh.sh_link;
-			result = find_section_sym_index(sec->sh.sh_info,
-						txtname, &recval, &recsym);
-			if (result)
+			if (find_section_sym_index(sec->sh.sh_info,
+						txtname, &recval, &recsym))
 				goto out;
 
 			mlocp = sift_rel_mcount(mlocp,
@@ -215,15 +185,29 @@ static int do_func(unsigned const reltype)
 			 * This section is ignored by ftrace, but still
 			 * has mcount calls. Convert them to nops now.
 			 */
-			if (nop_mcount(sec, txtname) < 0) {
-				result = -1;
+			if (nop_mcount(sec, txtname) < 0)
 				goto out;
-			}
 		}
 	}
-	if (!result && mloc0 != mlocp)
-		result = append_func(mloc0, mlocp, mrel0, mrelp,
-				     _size, rel_entsize, symsec_sh_link);
+
+	if (mloc0 != mlocp) {
+		/* Update the section sizes */
+		mlocs->sh.sh_size = (void *)mlocp - (void *)mloc0;
+		mlocs->len = mlocs->sh.sh_size;
+		mlocs->data->d_size = mlocs->len;
+		mlocs->data->d_buf = mloc0;
+		elf_flagdata(mlocs->data, ELF_C_SET, ELF_F_DIRTY);
+
+		mrels->sh.sh_size = (void *)mrelp - (void *)mrel0;
+		mrels->len = mrels->sh.sh_size;
+		mrels->data->d_size = mrels->len;
+		mrels->data->d_buf = mrel0;
+		elf_flagdata(mrels->data, ELF_C_SET, ELF_F_DIRTY);
+
+		/* overwrite the ELF file */
+		result = elf_write(lf);
+	} else
+		result = 0;
 out:
 	free(mrel0);
 	free(mloc0);
-- 
2.20.1

