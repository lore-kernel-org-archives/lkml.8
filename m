Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A678C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9E720732
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbgFRUkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:17 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731297AbgFRUjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:21 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:12 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 4C099B2656;
        Thu, 18 Jun 2020 16:39:15 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 21/51] objtool: mcount: Move nop_mcount()
Date:   Thu, 18 Jun 2020 13:38:07 -0700
Message-ID: <4188c8a328fe196579328fa76caa33daec4d0613.1592510545.git.mhelsley@vmware.com>
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

The nop_mcount() function overwrites mcount calls that should be
ignored with no-ops. This operation varies by architecture and
wordsize so we retain the function pointers used to implement
the fundamental operation while nop_mcount() itself is responsible
for walking the relocations, determining if they should be turned
into no-ops, then calling the arch-specific code. Since none of
these use the recordmcount ELF wrappers anymore we can move it out
of the wrapper.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 47 +++++++++++++++++++++++++++++++++
 tools/objtool/recordmcount.h | 50 ------------------------------------
 2 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index c015091a8a8c..fae0b15d0632 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -399,6 +399,53 @@ static int find_section_sym_index(unsigned const txtndx,
 	return missing_sym;
 }
 
+/*
+ * Read the relocation table again, but this time its called on sections
+ * that are not going to be traced. The mcount calls here will be converted
+ * into nops.
+ */
+static int nop_mcount(struct section * const rels,
+		      const char *const txtname)
+{
+	struct reloc *reloc;
+	struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
+	struct symbol *mcountsym = NULL;
+	int once = 0;
+
+	list_for_each_entry(reloc, &rels->reloc_list, list) {
+		int ret = -1;
+
+		if (!mcountsym)
+			mcountsym = get_mcountsym(reloc);
+
+		if (mcountsym == reloc->sym && !is_fake_mcount(reloc)) {
+			if (make_nop) {
+				ret = make_nop(txts, reloc->offset);
+				if (ret < 0)
+					return -1;
+			}
+			if (warn_on_notrace_sect && !once) {
+				printf("Section %s has mcount callers being ignored\n",
+				       txtname);
+				once = 1;
+				/* just warn? */
+				if (!make_nop)
+					return 0;
+			}
+		}
+
+		/*
+		 * If we successfully removed the mcount, mark the relocation
+		 * as a nop (don't do anything with it).
+		 */
+		if (!ret) {
+			reloc->type = rel_type_nop;
+			rels->changed = true;
+		}
+	}
+	return 0;
+}
+
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 1f14c64ed484..25028c61da2b 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -20,7 +20,6 @@
 #undef append_func
 #undef mcount_adjust
 #undef sift_rel_mcount
-#undef nop_mcount
 #undef has_rel_mcount
 #undef tot_relsize
 #undef do_func
@@ -37,7 +36,6 @@
 #ifdef RECORD_MCOUNT_64
 # define append_func		append64
 # define sift_rel_mcount	sift64_rel_mcount
-# define nop_mcount		nop_mcount_64
 # define has_rel_mcount		has64_rel_mcount
 # define tot_relsize		tot64_relsize
 # define do_func		do64
@@ -53,7 +51,6 @@
 #else
 # define append_func		append32
 # define sift_rel_mcount	sift32_rel_mcount
-# define nop_mcount		nop_mcount_32
 # define has_rel_mcount		has32_rel_mcount
 # define tot_relsize		tot32_relsize
 # define do_func		do32
@@ -168,53 +165,6 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 	return mlocp;
 }
 
-/*
- * Read the relocation table again, but this time its called on sections
- * that are not going to be traced. The mcount calls here will be converted
- * into nops.
- */
-static int nop_mcount(struct section * const rels,
-		      const char *const txtname)
-{
-	struct reloc *reloc;
-	struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
-	struct symbol *mcountsym = NULL;
-	int once = 0;
-
-	list_for_each_entry(reloc, &rels->reloc_list, list) {
-		int ret = -1;
-
-		if (!mcountsym)
-			mcountsym = get_mcountsym(reloc);
-
-		if (mcountsym == reloc->sym && !is_fake_mcount(reloc)) {
-			if (make_nop) {
-				ret = make_nop(txts, reloc->offset);
-				if (ret < 0)
-					return -1;
-			}
-			if (warn_on_notrace_sect && !once) {
-				printf("Section %s has mcount callers being ignored\n",
-				       txtname);
-				once = 1;
-				/* just warn? */
-				if (!make_nop)
-					return 0;
-			}
-		}
-
-		/*
-		 * If we successfully removed the mcount, mark the relocation
-		 * as a nop (don't do anything with it).
-		 */
-		if (!ret) {
-			reloc->type = rel_type_nop;
-			rels->changed = true;
-		}
-	}
-	return 0;
-}
-
 static char const *has_rel_mcount(const struct section * const rels)
 {
 	const struct section *txts;
-- 
2.20.1

