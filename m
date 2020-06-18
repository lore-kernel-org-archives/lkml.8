Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C876C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559AD2100A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgFRUkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:35 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36734 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731351AbgFRUjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:32 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:23 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 33939B2656;
        Thu, 18 Jun 2020 16:39:26 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 34/51] objtool: mcount: Remove wrapper double-include trick
Date:   Thu, 18 Jun 2020 13:38:20 -0700
Message-ID: <ed6129e5918b201b21464e320c5e525fa573c47f.1592510545.git.mhelsley@vmware.com>
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

We no longer need to double-include the recordmcount.h wrapper
All of the types and functions that rely on them have been converted
to using objtool's ELF code. This moves the remaining function to
recordmcount.c and changes the function name to something slightly
more descriptive while dropping the wrapped naming.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 113 ++++++++++++++++++++++++++++--
 tools/objtool/recordmcount.h | 132 -----------------------------------
 2 files changed, 107 insertions(+), 138 deletions(-)
 delete mode 100644 tools/objtool/recordmcount.h

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 6db035252b6c..7f4d18e83e24 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -442,10 +442,111 @@ static void sift_rel_mcount(GElf_Addr **mlocpp,
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
+	GElf_Sxword r_offset = 0;
+
+	struct section *sec, *mlocs, *mrels;
+	const char * const mc_name =  "__mcount_loc";
+
+	unsigned int rel_entsize = 0;
+	int result = -1;
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
+
+	/* add section: __mcount_loc */
+	mlocs = elf_create_section(lf, mc_name, sizeof(*mloc0), 0);
+	if (!mlocs)
+		goto out;
+	mlocs->sh.sh_link = 0;
+	mlocs->sh.sh_info = 0;
+	mlocs->sh.sh_addralign = 8;
+	mlocs->data->d_buf = mloc0;
+	mlocs->data->d_type = ELF_T_ADDR; /* elf_xlatetof() conversion */
+
+	/* add section .rel[a]__mcount_loc */
+	mrels = elf_create_reloc_section(lf, mlocs,
+					 is_rela ? SHT_RELA : SHT_REL);
+	if (!mrels)
+		goto out;
+	mrels->sh.sh_flags = 0; /* clear SHF_INFO_LINK */
+	mrels->data->d_buf = mrel0;
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
+		elf_flagdata(mlocs->data, ELF_C_SET, ELF_F_DIRTY);
+
+		mrels->sh.sh_size = mrelp - mrel0;
+		mrels->len = mrels->sh.sh_size;
+		mrels->data->d_size = mrels->len;
+		elf_flagdata(mrels->data, ELF_C_SET, ELF_F_DIRTY);
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
@@ -575,7 +676,7 @@ static int do_file(char const *const fname)
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
 		loc_size = 4;
-		rc = do32(reltype, sizeof(Elf32_Rela));
+		rc = do_mcount(reltype, sizeof(Elf32_Rela));
 		break;
 	case ELFCLASS64: {
 		if (lf->ehdr.e_ehsize != sizeof(Elf64_Ehdr)
@@ -593,7 +694,7 @@ static int do_file(char const *const fname)
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
index 07fc93917736..000000000000
--- a/tools/objtool/recordmcount.h
+++ /dev/null
@@ -1,132 +0,0 @@
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
-	struct section *sec, *mlocs, *mrels;
-	const char * const mc_name =  "__mcount_loc";
-
-	unsigned int rel_entsize = 0;
-	int result = -1;
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
-
-	/* add section: __mcount_loc */
-	mlocs = elf_create_section(lf, mc_name, sizeof(*mloc0), 0);
-	if (!mlocs)
-		goto out;
-	mlocs->sh.sh_link = 0;
-	mlocs->sh.sh_info = 0;
-	mlocs->sh.sh_addralign = 8;
-	mlocs->data->d_buf = mloc0;
-	mlocs->data->d_type = ELF_T_ADDR; /* elf_xlatetof() conversion */
-
-	/* add section .rel[a]__mcount_loc */
-	mrels = elf_create_reloc_section(lf, mlocs,
-					 is_rela ? SHT_RELA : SHT_REL);
-	if (!mrels)
-		goto out;
-	mrels->sh.sh_flags = 0; /* clear SHF_INFO_LINK */
-	mrels->data->d_buf = mrel0;
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
-		elf_flagdata(mlocs->data, ELF_C_SET, ELF_F_DIRTY);
-
-		mrels->sh.sh_size = mrelp - mrel0;
-		mrels->len = mrels->sh.sh_size;
-		mrels->data->d_size = mrels->len;
-		elf_flagdata(mrels->data, ELF_C_SET, ELF_F_DIRTY);
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

