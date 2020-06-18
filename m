Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBBBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5419620890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgFRUl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:41:26 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36734 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731566AbgFRUjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:48 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:38 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 73BC8B265A;
        Thu, 18 Jun 2020 16:39:41 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 50/51] objtool: mcount: Remove useless lookup
Date:   Thu, 18 Jun 2020 13:38:36 -0700
Message-ID: <5b0c55a54fec946cbbea4a3e0e87485d71123e47.1592510545.git.mhelsley@vmware.com>
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

Since the relocation section's sh_info points back to the text
section it applies to and we already have that we can just pass
it in and greatly simplify find_section_sym_index().

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/mcount.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index 084bbc02de0c..a74625aed09b 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -198,35 +198,27 @@ static const unsigned int missing_sym = (unsigned int)-1;
  *    Num:    Value  Size Type    Bind   Vis      Ndx Name
  *      2: 00000000     0 SECTION LOCAL  DEFAULT    1
  */
-static int find_section_sym_index(unsigned const txtndx,
-				char const *const txtname,
-				unsigned long *const recvalp,
-				unsigned int *sym_index)
+static int find_section_sym_index(const struct section * const txts,
+				  unsigned long *const recvalp,
+				  unsigned int *sym_index)
 {
 	struct symbol *sym;
-	struct section *txts = find_section_by_index(lf, txtndx);
-
-	if (!txts) {
-		fprintf(stderr, "Cannot find section %u: %s.\n",
-			txtndx, txtname);
-		return missing_sym;
-	}
 
 	list_for_each_entry(sym, &txts->symbol_list, list) {
 		/* avoid symbols with weak binding */
-		if ((sym->bind == STB_LOCAL) || (sym->bind == STB_GLOBAL)) {
-			/* function symbols on ARM have quirks, avoid them */
-			if (lf->ehdr.e_machine == EM_ARM
-			    && sym->type == STT_FUNC)
-				continue;
-
-			*recvalp = sym->sym.st_value;
-			*sym_index = sym->idx;
-			return 0;
-		}
+		if ((sym->bind != STB_LOCAL) && (sym->bind != STB_GLOBAL))
+			continue;
+
+		/* function symbols on ARM have quirks, avoid them */
+		if (lf->ehdr.e_machine == EM_ARM && sym->type == STT_FUNC)
+			continue;
+
+		*recvalp = sym->sym.st_value;
+		*sym_index = sym->idx;
+		return 0;
 	}
 	fprintf(stderr, "Cannot find symbol for section %u: %s.\n",
-		txtndx, txtname);
+		txts->idx, txts->name);
 	return missing_sym;
 }
 
@@ -414,8 +406,7 @@ static int do_mcount(unsigned const reltype)
 			unsigned long recval = 0;
 			unsigned int recsym;
 
-			if (find_section_sym_index(sec->sh.sh_info,
-						txts->name, &recval, &recsym))
+			if (find_section_sym_index(txts, &recval, &recsym))
 				goto out;
 
 			sift_rel_mcount(&r_offset, sec, mrels, mlocs,
-- 
2.20.1

