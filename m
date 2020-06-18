Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2295EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDEA20732
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgFRUkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:33 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731123AbgFRUja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:30 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:21 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 67C1AB2656;
        Thu, 18 Jun 2020 16:39:24 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 32/51] objtool: mcount: Move sift_rel_mcount out of wrapper file
Date:   Thu, 18 Jun 2020 13:38:18 -0700
Message-ID: <ba2f5976c5030763c9d552da1775a66a663cda29.1592510545.git.mhelsley@vmware.com>
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

Now that this function no longer uses any of the old recordmcount
wrapper code we can move it out of the wrapper too.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 47 +++++++++++++++++++++++++++++++++
 tools/objtool/recordmcount.h | 50 ------------------------------------
 2 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 34976f3294ac..b9f15fc1f40e 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -395,6 +395,53 @@ static int mcount_adjust = 0;
 /* Size of an entry in __mcount_loc; 4 or 8 */
 static size_t loc_size;
 
+/*
+ * Look at the relocations in order to find the calls to mcount.
+ * Accumulate the section offsets that are found, and their relocation info,
+ * onto the end of the existing arrays.
+ */
+static void sift_rel_mcount(GElf_Addr **mlocpp,
+			       GElf_Sxword *r_offsetp,
+			       void **const mrelpp,
+			       const struct section * const rels,
+			       unsigned const recsym_index,
+			       unsigned long const recval,
+			       unsigned const reltype,
+			       bool is_rela)
+{
+	GElf_Rel *mrelp = *mrelpp;
+	GElf_Rela *mrelap = *mrelpp;
+	struct symbol *mcount_sym = NULL;
+	struct reloc *reloc;
+
+	list_for_each_entry(reloc, &rels->reloc_list, list) {
+		unsigned long addend;
+
+		if (!mcount_sym)
+			mcount_sym = get_mcount_sym(reloc);
+
+		if (mcount_sym != reloc->sym || is_fake_mcount(reloc))
+			continue;
+
+		addend = reloc->offset - recval + mcount_adjust;
+		if (is_rela) {
+			mrelap->r_offset = *r_offsetp;
+			mrelap->r_info = GELF_R_INFO(recsym_index, reltype);
+			mrelap->r_addend = addend;
+			mrelap++;
+			**mlocpp = 0;
+		} else {
+			mrelp->r_offset = *r_offsetp;
+			mrelp->r_info = GELF_R_INFO(recsym_index, reltype);
+			mrelp++;
+			**mlocpp = addend;
+		}
+		(*mlocpp)++;
+		*r_offsetp += loc_size;
+	}
+	*mrelpp = is_rela ? (void *)mrelap : (void *)mrelp;
+}
+
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index fc6346a7eaf5..2dd303d51b78 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -17,67 +17,17 @@
  * This conversion to macros was done by:
  * Copyright 2010 Steven Rostedt <srostedt@redhat.com>, Red Hat Inc.
  */
-#undef sift_rel_mcount
 #undef do_func
 #undef Elf_Rela
 
 #ifdef RECORD_MCOUNT_64
-# define sift_rel_mcount	sift64_rel_mcount
 # define do_func		do64
 # define Elf_Rela		Elf64_Rela
 #else
-# define sift_rel_mcount	sift32_rel_mcount
 # define do_func		do32
 # define Elf_Rela		Elf32_Rela
 #endif
 
-/*
- * Look at the relocations in order to find the calls to mcount.
- * Accumulate the section offsets that are found, and their relocation info,
- * onto the end of the existing arrays.
- */
-static void sift_rel_mcount(GElf_Addr **mlocpp,
-			       GElf_Sxword *r_offsetp,
-			       void **const mrelpp,
-			       const struct section * const rels,
-			       unsigned const recsym_index,
-			       unsigned long const recval,
-			       unsigned const reltype,
-			       bool is_rela)
-{
-	GElf_Rel *mrelp = *mrelpp;
-	GElf_Rela *mrelap = *mrelpp;
-	struct symbol *mcount_sym = NULL;
-	struct reloc *reloc;
-
-	list_for_each_entry(reloc, &rels->reloc_list, list) {
-		unsigned long addend;
-
-		if (!mcount_sym)
-			mcount_sym = get_mcount_sym(reloc);
-
-		if (mcount_sym != reloc->sym || is_fake_mcount(reloc))
-			continue;
-
-		addend = reloc->offset - recval + mcount_adjust;
-		if (is_rela) {
-			mrelap->r_offset = *r_offsetp;
-			mrelap->r_info = GELF_R_INFO(recsym_index, reltype);
-			mrelap->r_addend = addend;
-			mrelap++;
-			**mlocpp = 0;
-		} else {
-			mrelp->r_offset = *r_offsetp;
-			mrelp->r_info = GELF_R_INFO(recsym_index, reltype);
-			mrelp++;
-			**mlocpp = addend;
-		}
-		(*mlocpp)++;
-		*r_offsetp += loc_size;
-	}
-	*mrelpp = is_rela ? (void *)mrelap : (void *)mrelp;
-}
-
 /* Overall supervision for Elf32 ET_REL file. */
 static int do_func(unsigned const reltype)
 {
-- 
2.20.1

