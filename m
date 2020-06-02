Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8C1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264662072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgFBTvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:51:44 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:28096 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728426AbgFBTvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:51:10 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:51:09 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id DBE7D40BED;
        Tue,  2 Jun 2020 12:51:09 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 30/32] objtool: mcount: Remove wrapper double-include trick
Date:   Tue, 2 Jun 2020 12:50:23 -0700
Message-ID: <1e7f39d9067324844f99a9609c8e5fa2a7f2f582.1591125127.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1591125127.git.mhelsley@vmware.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We no longer need to double-include the recordmcount.h wrapper
All of the types and functions that rely on them have been converted
to using objtool's ELF code. This moves the remaining function to
recordmcount.c and changes the function name to something slightly
more descriptive while dropping the wrapped naming.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 122 ++++++++++++++++++++++++++++--
 tools/objtool/recordmcount.h | 142 -----------------------------------
 2 files changed, 116 insertions(+), 148 deletions(-)
 delete mode 100644 tools/objtool/recordmcount.h

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 096507829b0c..6980c0a8bdc3 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -441,10 +441,120 @@ static void sift_rel_mcount(GElf_Addr **mlocpp,
 	*mrelpp = is_rela ? (void *)mrelap : (void *)mrelp;
 }
 
-/* 32 bit and 64 bit are very similar */
-#include "recordmcount.h"
-#define RECORD_MCOUNT_64
-#include "recordmcount.h"
+/* Overall supervision for Elf32 ET_REL file. */
+static int do_mcount(unsigned const reltype, size_t rela_size)
+{
+	/* Upper bound on space: assume all relevant relocs are for mcount. */
+	unsigned       totrelsz;
+
+	void *mrel0;
+	void *mrelp;
+
+	GElf_Addr *mloc0;
+	GElf_Addr *mlocp;
+	GElf_Sxword r_offset; /* Used in the added relocations */
+
+	unsigned int rel_entsize = 0;
+
+	struct section *sec, *mlocs, *mrels;
+	unsigned int const old_shnum = lf->ehdr.e_shnum;
+
+	int result = -1;
+	char const *mc_name;
+	bool is_rela;
+
+	if (find_section_by_name(lf, "__mcount_loc") != NULL)
+		return 0;
+
+	totrelsz = tot_relsize(&rel_entsize);
+	if (totrelsz == 0)
+		return 0;
+
+	mrel0 = malloc(totrelsz);
+	mrelp = mrel0;
+	if (!mrel0)
+		return -1;
+
+	/* 2*sizeof(address) <= sizeof(Elf_Rel) */
+	mloc0 = malloc(totrelsz>>1);
+	mlocp = mloc0;
+	if (!mloc0) {
+		free(mrel0);
+		return -1;
+	}
+
+	is_rela = (rela_size == rel_entsize);
+	mc_name = is_rela
+			? ".rela__mcount_loc"
+			:  ".rel__mcount_loc";
+
+	/* add section: __mcount_loc */
+	mlocs = elf_create_section(lf, mc_name + (is_rela ? 1 : 0) + strlen(".rel"), sizeof(*mloc0), 0);
+	if (!mlocs)
+		goto out;
+
+	mlocs->sh.sh_link = 0;
+	mlocs->sh.sh_info = 0;
+	mlocs->sh.sh_addralign = 8;
+	mlocs->data->d_buf = mloc0;
+	mlocs->data->d_type = ELF_T_ADDR; /* elf_xlatetof() conversion */
+
+	/* add section .rel[a]__mcount_loc */
+	mrels = elf_create_section(lf, mc_name, rel_entsize, 0);
+	if (!mrels)
+		goto out;
+	/* Like elf_create_rela_section() without the name bits */
+	mrels->sh.sh_type = is_rela ? SHT_RELA : SHT_REL;
+	mrels->sh.sh_flags = 0;
+	mrels->sh.sh_link = find_section_by_name(lf, ".symtab")->idx;
+	mrels->sh.sh_info = old_shnum;
+	mrels->sh.sh_addralign = 8;
+	mrels->data->d_buf = mrel0;
+	mrels->data->d_type = is_rela ? ELF_T_RELA : ELF_T_REL; /* elf_xlatetof() conversion */
+
+	list_for_each_entry(sec, &lf->sections, list) {
+		char const *txtname;
+
+		txtname = has_rel_mcount(sec);
+		if (txtname && is_mcounted_section_name(txtname)) {
+			unsigned long recval = 0;
+			unsigned int recsym;
+
+			if (find_section_sym_index(sec->sh.sh_info,
+						txtname, &recval, &recsym))
+				goto out;
+
+			sift_rel_mcount(&mlocp, &r_offset, &mrelp, sec,
+				recsym, recval, reltype, is_rela);
+		} else if (txtname && (warn_on_notrace_sect || make_nop)) {
+			/*
+			 * This section is ignored by ftrace, but still
+			 * has mcount calls. Convert them to nops now.
+			 */
+			if (nop_mcount(sec, txtname) < 0)
+				goto out;
+		}
+	}
+
+	if (mloc0 != mlocp) {
+		/* Update the section size and Elf_Data size */
+		mlocs->sh.sh_size = (void *)mlocp - (void *)mloc0;
+		mlocs->len = mlocs->sh.sh_size;
+		mlocs->data->d_size = mlocs->len;
+
+		mrels->sh.sh_size = mrelp - mrel0;
+		mrels->len = mrels->sh.sh_size;
+		mrels->data->d_size = mrels->len;
+
+		/* overwrite the ELF file */
+		result = elf_write(lf);
+	} else
+		result = 0;
+out:
+	free(mrel0);
+	free(mloc0);
+	return result;
+}
 
 static int arm_is_fake_mcount(struct reloc const *rp)
 {
@@ -574,7 +684,7 @@ static int do_file(char const *const fname)
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
 		loc_size = 4;
-		rc = do32(reltype, sizeof(Elf32_Rela));
+		rc = do_mcount(reltype, sizeof(Elf32_Rela));
 		break;
 	case ELFCLASS64: {
 		if (lf->ehdr.e_ehsize != sizeof(Elf64_Ehdr)
@@ -592,7 +702,7 @@ static int do_file(char const *const fname)
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
 		loc_size = 8;
-		rc = do64(reltype, sizeof(Elf64_Rela));
+		rc = do_mcount(reltype, sizeof(Elf64_Rela));
 		break;
 	}
 	}  /* end switch */
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
deleted file mode 100644
index 50104d52d9bf..000000000000
--- a/tools/objtool/recordmcount.h
+++ /dev/null
@@ -1,142 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * recordmcount.h
- *
- * This code was taken out of recordmcount.c written by
- * Copyright 2009 John F. Reiser <jreiser@BitWagon.com>.  All rights reserved.
- *
- * The original code had the same algorithms for both 32bit
- * and 64bit ELF files, but the code was duplicated to support
- * the difference in structures that were used. This
- * file creates a macro of everything that is different between
- * the 64 and 32 bit code, such that by including this header
- * twice we can create both sets of functions by including this
- * header once with RECORD_MCOUNT_64 undefined, and again with
- * it defined.
- *
- * This conversion to macros was done by:
- * Copyright 2010 Steven Rostedt <srostedt@redhat.com>, Red Hat Inc.
- */
-#undef do_func
-
-#ifdef RECORD_MCOUNT_64
-# define do_func		do64
-#else
-# define do_func		do32
-#endif
-
-
-/* Overall supervision for Elf32 ET_REL file. */
-static int do_func(unsigned const reltype, size_t rela_size)
-{
-	/* Upper bound on space: assume all relevant relocs are for mcount. */
-	unsigned       totrelsz;
-
-	void *mrel0;
-	void *mrelp;
-
-	GElf_Addr *mloc0;
-	GElf_Addr *mlocp;
-	GElf_Sxword r_offset = 0;
-
-	unsigned int rel_entsize = 0;
-
-	struct section *sec, *mlocs, *mrels;
-	unsigned int const old_shnum = lf->ehdr.e_shnum;
-
-	int result = -1;
-	char const *mc_name;
-	bool is_rela;
-
-	if (find_section_by_name(lf, "__mcount_loc") != NULL)
-		return 0;
-
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
-	is_rela = (rela_size == rel_entsize);
-	mc_name = is_rela
-			? ".rela__mcount_loc"
-			:  ".rel__mcount_loc";
-
-	/* add section: __mcount_loc */
-	mlocs = elf_create_section(lf, mc_name + (is_rela ? 1 : 0) + strlen(".rel"), sizeof(*mloc0), 0);
-	if (!mlocs)
-		goto out;
-
-	mlocs->sh.sh_link = 0;
-	mlocs->sh.sh_info = 0;
-	mlocs->sh.sh_addralign = 8;
-	mlocs->data->d_buf = mloc0;
-	mlocs->data->d_type = ELF_T_ADDR; /* elf_xlatetof() conversion */
-
-	/* add section .rel[a]__mcount_loc */
-	mrels = elf_create_section(lf, mc_name, rel_entsize, 0);
-	if (!mrels)
-		goto out;
-	/* Like elf_create_rela_section() without the name bits */
-	mrels->sh.sh_type = is_rela ? SHT_RELA : SHT_REL;
-	mrels->sh.sh_flags = 0;
-	mrels->sh.sh_link = find_section_by_name(lf, ".symtab")->idx;
-	mrels->sh.sh_info = old_shnum;
-	mrels->sh.sh_addralign = 8;
-	mrels->data->d_buf = mrel0;
-	mrels->data->d_type = is_rela ? ELF_T_RELA : ELF_T_REL; /* elf_xlatetof() conversion */
-
-	list_for_each_entry(sec, &lf->sections, list) {
-		char const *txtname;
-
-		txtname = has_rel_mcount(sec);
-		if (txtname && is_mcounted_section_name(txtname)) {
-			unsigned long recval = 0;
-			unsigned int recsym;
-
-			if (find_section_sym_index(sec->sh.sh_info,
-						txtname, &recval, &recsym))
-				goto out;
-
-			sift_rel_mcount(&mlocp, &r_offset, &mrelp, sec,
-				recsym, recval, reltype, is_rela);
-		} else if (txtname && (warn_on_notrace_sect || make_nop)) {
-			/*
-			 * This section is ignored by ftrace, but still
-			 * has mcount calls. Convert them to nops now.
-			 */
-			if (nop_mcount(sec, txtname) < 0)
-				goto out;
-		}
-	}
-
-	if (mloc0 != mlocp) {
-		/* Update the section size and Elf_Data size */
-		mlocs->sh.sh_size = (void *)mlocp - (void *)mloc0;
-		mlocs->len = mlocs->sh.sh_size;
-		mlocs->data->d_size = mlocs->len;
-
-		mrels->sh.sh_size = mrelp - mrel0;
-		mrels->len = mrels->sh.sh_size;
-		mrels->data->d_size = mrels->len;
-
-		/* overwrite the ELF file */
-		result = elf_write(lf);
-	} else
-		result = 0;
-out:
-	free(mrel0);
-	free(mloc0);
-	return result;
-}
-- 
2.20.1

