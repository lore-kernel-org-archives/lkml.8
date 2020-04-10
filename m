Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0C7C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150F020769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgDJTig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:38:36 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:28720 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbgDJTif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:38:35 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:38:30 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id A863640C50;
        Fri, 10 Apr 2020 12:38:34 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 24/36] objtool: mcount: Move helpers out of ELF wrapper
Date:   Fri, 10 Apr 2020 12:35:47 -0700
Message-ID: <8a4dfa4e57702c4a24475dcf130b2c8a515f06bd.1586468801.git.mhelsley@vmware.com>
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

These helpers are no longer dependent on the old ELF wrapper and can
be moved into the wrapper-independent code of recordmcount.c

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 25 +++++++++++++++++++++++++
 tools/objtool/recordmcount.h | 33 ---------------------------------
 2 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 99938d5a5bb1..f39919e1ea7e 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -445,6 +445,31 @@ static int nop_mcount(struct section * const rels,
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
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 4bbdb6c107b8..e6efdd34958e 100644
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
@@ -168,33 +162,6 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
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
-- 
2.20.1

