Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E410C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7A2206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgDJTj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:39:27 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:28773 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726861AbgDJTj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:39:27 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:39:22 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 6136240BC0;
        Fri, 10 Apr 2020 12:39:26 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 33/36] objtool: mcount: Move sift_rel_mcount out of wrapper file
Date:   Fri, 10 Apr 2020 12:35:56 -0700
Message-ID: <0442618da2678ee6bc657bfda6137140239f58be.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
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
 tools/objtool/recordmcount.h | 51 ------------------------------------
 2 files changed, 47 insertions(+), 51 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 89765870b0dd..a16611a352e5 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -394,6 +394,53 @@ static int mcount_adjust = 0;
 /* Size of an entry in __mcount_loc; 4 or 8 */
 static size_t loc_size;
 
+/*
+ * Look at the relocations in order to find the calls to mcount.
+ * Accumulate the section offsets that are found, and their relocation info,
+ * onto the end of the existing arrays.
+ */
+static void sift_rel_mcount(GElf_Addr **mlocpp,
+			    GElf_Sxword *r_offsetp,
+			    void **const mrelpp,
+			    const struct section * const rels,
+			    unsigned const recsym_index,
+			    unsigned long const recval,
+			    unsigned const reltype,
+			    bool is_rela)
+{
+	GElf_Rel *mrelp = *mrelpp;
+	GElf_Rela *mrelap = *mrelpp;
+	unsigned int mcount_sym_info = 0;
+	struct rela *rela;
+
+	list_for_each_entry(rela, &rels->rela_list, list) {
+		unsigned long addend;
+
+		if (!mcount_sym_info)
+			mcount_sym_info = get_mcount_sym_info(rela);
+
+		if (mcount_sym_info != GELF_R_INFO(rela->sym->idx, rela->type) || is_fake_mcount(rela))
+			continue;
+
+		addend = rela->offset - recval + mcount_adjust;
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
+		r_offsetp += loc_size;
+	}
+	*mrelpp = is_rela ? (void *)mrelap : (void *)mrelp;
+}
+
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index bdf77172da58..7db08ad9b4a7 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -17,68 +17,17 @@
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
-	unsigned int mcount_sym_info = 0;
-	struct rela *rela;
-
-	list_for_each_entry(rela, &rels->rela_list, list) {
-		unsigned long addend;
-
-		if (!mcount_sym_info)
-			mcount_sym_info = get_mcount_sym_info(rela);
-
-		if (mcount_sym_info != GELF_R_INFO(rela->sym->idx, rela->type) || is_fake_mcount(rela))
-			continue;
-
-		addend = rela->offset - recval + mcount_adjust;
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
-		r_offsetp += loc_size;
-	}
-	*mrelpp = is_rela ? (void *)mrelap : (void *)mrelp;
-}
-
-
 /* Overall supervision for Elf32 ET_REL file. */
 static int do_func(unsigned const reltype)
 {
-- 
2.20.1

