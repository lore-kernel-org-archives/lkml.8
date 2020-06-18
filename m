Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA703C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9C320890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbgFRUlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:41:46 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:10226 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731435AbgFRUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:39 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:35 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id AF706B2659;
        Thu, 18 Jun 2020 16:39:38 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 46/51] objtool: mcount: Flag mcount relocation sections
Date:   Thu, 18 Jun 2020 13:38:32 -0700
Message-ID: <29c6498b2b7f839a66c29a71b1250563016c9d93.1592510545.git.mhelsley@vmware.com>
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

Move the check for relocations sections that apply to
mcountable text sections into objtool's ELF code.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/elf.c    | 13 +++++++++++++
 tools/objtool/elf.h    |  2 +-
 tools/objtool/mcount.c | 36 ++++++++++++++++--------------------
 3 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index dffdc3264a25..3708f85fe36d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -385,6 +385,7 @@ static int read_sections(struct elf *elf)
 		sec->len = sec->sh.sh_size;
 
 		sec->mcounted = is_mcounted_section_name(sec->name);
+		sec->relocs_mcountable = false;
 
 		list_add_tail(&sec->list, &elf->sections);
 		elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
@@ -609,6 +610,17 @@ static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsi
 	return 0;
 }
 
+static bool relocs_mcountable(const struct section * const rels)
+{
+       const struct section *txts;
+
+       txts = rels->base;
+       if ((txts->sh.sh_type != SHT_PROGBITS) ||
+           !(txts->sh.sh_flags & SHF_EXECINSTR))
+               return false;
+       return true;
+}
+
 static int read_relocs(struct elf *elf)
 {
 	struct section *sec;
@@ -630,6 +642,7 @@ static int read_relocs(struct elf *elf)
 		}
 
 		sec->base->reloc = sec;
+		sec->relocs_mcountable = relocs_mcountable(sec);
 
 		nr_reloc = 0;
 		for (i = 0; i < sec->sh.sh_size / sec->sh.sh_entsize; i++) {
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index db207e93a1e6..92d3e68abf59 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -39,7 +39,7 @@ struct section {
 	char *name;
 	int idx;
 	unsigned int len;
-	bool changed, text, rodata, noinstr, mcounted;
+	bool changed, text, rodata, noinstr, mcounted, relocs_mcountable;
 };
 
 enum symbol_class {
diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index a75d918a9fa5..9cd52beed871 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -274,28 +274,13 @@ static int nop_mcount(struct section * const rels,
 	return 0;
 }
 
-static struct section const *has_rel_mcount(const struct section * const rels)
-{
-	const struct section *txts;
-	if (rels->sh.sh_type != SHT_REL && rels->sh.sh_type != SHT_RELA)
-		return NULL;
-	txts = find_section_by_index(lf, rels->sh.sh_info);
-	if ((txts->sh.sh_type != SHT_PROGBITS) ||
-	    !(txts->sh.sh_flags & SHF_EXECINSTR))
-		return NULL;
-	return txts;
-}
-
 static void tot_relsize(unsigned int *rel_entsize)
 {
 	const struct section *sec;
-	const struct section *txts;
 
 	list_for_each_entry(sec, &lf->sections, list) {
-		txts = has_rel_mcount(sec);
-		if (!(txts && txts->mcounted))
-			continue;
-		*rel_entsize = sec->sh.sh_entsize;
+		if (sec->relocs_mcountable)
+			*rel_entsize = sec->sh.sh_entsize;
 	}
 }
 
@@ -429,8 +414,19 @@ static int do_mcount(unsigned const reltype, size_t rela_size)
 	list_for_each_entry(sec, &lf->sections, list) {
 		struct section const *txts;
 
-		txts = has_rel_mcount(sec);
-		if (txts && txts->mcounted) {
+		/* Find relocation sections.. */
+		if (sec->sh.sh_type != SHT_REL &&
+		    sec->sh.sh_type != SHT_RELA)
+			continue;
+		/* Which may relocate mcount calls.. */
+		if (!sec->relocs_mcountable)
+			continue;
+		txts = sec->base;
+		if (!txts)
+			continue;
+
+		if (txts->mcounted) {
+			/* In mcountable text sections */
 			unsigned long recval = 0;
 			unsigned int recsym;
 
@@ -440,7 +436,7 @@ static int do_mcount(unsigned const reltype, size_t rela_size)
 
 			sift_rel_mcount(&r_offset, sec, mrels, mlocs,
 				recsym, recval, reltype, is_rela);
-		} else if (txts && (warn_on_notrace_sect || make_nop)) {
+		} else if (warn_on_notrace_sect || make_nop) {
 			/*
 			 * This section is ignored by ftrace, but still
 			 * has mcount calls. Convert them to nops now.
-- 
2.20.1

