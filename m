Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190EDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4E120732
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbgFRUkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:21 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731307AbgFRUjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:21 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:12 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 11569B2656;
        Thu, 18 Jun 2020 16:39:16 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 22/51] objtool: mcount: Move has_rel_mcount() and tot_relsize()
Date:   Thu, 18 Jun 2020 13:38:08 -0700
Message-ID: <2511660716aabd9843ab58abef20425507aa354f.1592510545.git.mhelsley@vmware.com>
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

The has_rel_mcount() and tot_relsize() helpers are no longer
dependent on the ELF wrapper so we can move them.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 26 ++++++++++++++++++++++++++
 tools/objtool/recordmcount.h | 33 ---------------------------------
 2 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index fae0b15d0632..918e47217379 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -446,6 +446,32 @@ static int nop_mcount(struct section * const rels,
 	return 0;
 }
 
+static char const *has_rel_mcount(const struct section * const rels)
+{
+	const struct section *txts;
+	if (rels->sh.sh_type != SHT_REL && rels->sh.sh_type != SHT_RELA)
+		return NULL;
+	txts = find_section_by_index(lf, rels->sh.sh_info);
+	if ((txts->sh.sh_type != SHT_PROGBITS) ||
+	    !(txts->sh.sh_flags & SHF_EXECINSTR))
+		return NULL;
+	return txts->name;
+}
+
+static unsigned tot_relsize(void)
+{
+	const struct section *sec;
+	unsigned totrelsz = 0;
+	char const *txtname;
+
+	list_for_each_entry(sec, &lf->sections, list) {
+		txtname = has_rel_mcount(sec);
+		if (txtname && is_mcounted_section_name(txtname))
+			totrelsz += sec->sh.sh_size;
+	}
+	return totrelsz;
+}
+
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 25028c61da2b..2733f7fde51d 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -20,8 +20,6 @@
 #undef append_func
 #undef mcount_adjust
 #undef sift_rel_mcount
-#undef has_rel_mcount
-#undef tot_relsize
 #undef do_func
 #undef Elf_Shdr
 #undef Elf_Rel
@@ -36,8 +34,6 @@
 #ifdef RECORD_MCOUNT_64
 # define append_func		append64
 # define sift_rel_mcount	sift64_rel_mcount
-# define has_rel_mcount		has64_rel_mcount
-# define tot_relsize		tot64_relsize
 # define do_func		do64
 # define mcount_adjust		mcount_adjust_64
 # define Elf_Rel		Elf64_Rel
@@ -51,8 +47,6 @@
 #else
 # define append_func		append32
 # define sift_rel_mcount	sift32_rel_mcount
-# define has_rel_mcount		has32_rel_mcount
-# define tot_relsize		tot32_relsize
 # define do_func		do32
 # define mcount_adjust		mcount_adjust_32
 # define Elf_Rel		Elf32_Rel
@@ -165,33 +159,6 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 	return mlocp;
 }
 
-static char const *has_rel_mcount(const struct section * const rels)
-{
-	const struct section *txts;
-	if (rels->sh.sh_type != SHT_REL && rels->sh.sh_type != SHT_RELA)
-		return NULL;
-	txts = find_section_by_index(lf, rels->sh.sh_info);
-	if ((txts->sh.sh_type != SHT_PROGBITS) ||
-	    !(txts->sh.sh_flags & SHF_EXECINSTR))
-		return NULL;
-	return txts->name;
-}
-
-
-static unsigned tot_relsize(void)
-{
-	const struct section *sec;
-	unsigned totrelsz = 0;
-	char const *txtname;
-
-	list_for_each_entry(sec, &lf->sections, list) {
-		txtname = has_rel_mcount(sec);
-		if (txtname && is_mcounted_section_name(txtname))
-			totrelsz += sec->sh.sh_size;
-	}
-	return totrelsz;
-}
-
 /* Overall supervision for Elf32 ET_REL file. */
 static int do_func(unsigned const reltype)
 {
-- 
2.20.1

