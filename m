Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06755C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB7820890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgFRUlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:41:40 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36734 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730973AbgFRUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:39 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:34 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 01721B2659;
        Thu, 18 Jun 2020 16:39:37 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 45/51] objtool: mcount: Move mcount section test to objtool ELF
Date:   Thu, 18 Jun 2020 13:38:31 -0700
Message-ID: <8bc94dfae5969002d946b1aad2f831474d4649fd.1592510545.git.mhelsley@vmware.com>
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

In preparation for removing this first pass by mcount move
the test for whether a section is mcountable into objtool's
ELF read code, much like we did with the symbol name. A
subsequent patch will eliminate the tot_relsize() function
and thereby reduce the number of passes through the ELF
data.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/elf.c    | 16 ++++++++++++++++
 tools/objtool/elf.h    |  2 +-
 tools/objtool/mcount.c | 36 +++++++++++-------------------------
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 666cbc01c332..dffdc3264a25 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -308,6 +308,20 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
 	return find_reloc_by_dest_range(elf, sec, offset, 1);
 }
 
+/* Names of the sections that could contain calls to mcount. */
+static int is_mcounted_section_name(char const *const txtname)
+{
+	return strncmp(".text",          txtname, 5) == 0 ||
+		strcmp(".init.text",     txtname) == 0 ||
+		strcmp(".ref.text",      txtname) == 0 ||
+		strcmp(".sched.text",    txtname) == 0 ||
+		strcmp(".spinlock.text", txtname) == 0 ||
+		strcmp(".irqentry.text", txtname) == 0 ||
+		strcmp(".softirqentry.text", txtname) == 0 ||
+		strcmp(".kprobes.text", txtname) == 0 ||
+		strcmp(".cpuidle.text", txtname) == 0;
+}
+
 static int read_sections(struct elf *elf)
 {
 	Elf_Scn *s = NULL;
@@ -370,6 +384,8 @@ static int read_sections(struct elf *elf)
 		}
 		sec->len = sec->sh.sh_size;
 
+		sec->mcounted = is_mcounted_section_name(sec->name);
+
 		list_add_tail(&sec->list, &elf->sections);
 		elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
 		elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index f0b02824f9d3..db207e93a1e6 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -39,7 +39,7 @@ struct section {
 	char *name;
 	int idx;
 	unsigned int len;
-	bool changed, text, rodata, noinstr;
+	bool changed, text, rodata, noinstr, mcounted;
 };
 
 enum symbol_class {
diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index 7d7843f7cd44..a75d918a9fa5 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -144,20 +144,6 @@ static int make_nop_arm64(struct section *txts, size_t const offset)
 	return elf_write_insn(lf, txts, offset, 4, ideal_nop);
 }
 
-/* Names of the sections that could contain calls to mcount. */
-static int is_mcounted_section_name(char const *const txtname)
-{
-	return strncmp(".text",          txtname, 5) == 0 ||
-		strcmp(".init.text",     txtname) == 0 ||
-		strcmp(".ref.text",      txtname) == 0 ||
-		strcmp(".sched.text",    txtname) == 0 ||
-		strcmp(".spinlock.text", txtname) == 0 ||
-		strcmp(".irqentry.text", txtname) == 0 ||
-		strcmp(".softirqentry.text", txtname) == 0 ||
-		strcmp(".kprobes.text", txtname) == 0 ||
-		strcmp(".cpuidle.text", txtname) == 0;
-}
-
 /*
  * MIPS mcount long call has 2 _mcount symbols, only the position of the 1st
  * _mcount symbol is needed for dynamic function tracer, with it, to disable
@@ -288,7 +274,7 @@ static int nop_mcount(struct section * const rels,
 	return 0;
 }
 
-static char const *has_rel_mcount(const struct section * const rels)
+static struct section const *has_rel_mcount(const struct section * const rels)
 {
 	const struct section *txts;
 	if (rels->sh.sh_type != SHT_REL && rels->sh.sh_type != SHT_RELA)
@@ -297,17 +283,17 @@ static char const *has_rel_mcount(const struct section * const rels)
 	if ((txts->sh.sh_type != SHT_PROGBITS) ||
 	    !(txts->sh.sh_flags & SHF_EXECINSTR))
 		return NULL;
-	return txts->name;
+	return txts;
 }
 
 static void tot_relsize(unsigned int *rel_entsize)
 {
 	const struct section *sec;
-	char const *txtname;
+	const struct section *txts;
 
 	list_for_each_entry(sec, &lf->sections, list) {
-		txtname = has_rel_mcount(sec);
-		if (!(txtname && is_mcounted_section_name(txtname)))
+		txts = has_rel_mcount(sec);
+		if (!(txts && txts->mcounted))
 			continue;
 		*rel_entsize = sec->sh.sh_entsize;
 	}
@@ -441,25 +427,25 @@ static int do_mcount(unsigned const reltype, size_t rela_size)
 	mrels->sh.sh_flags = 0; /* clear SHF_INFO_LINK */
 
 	list_for_each_entry(sec, &lf->sections, list) {
-		char const *txtname;
+		struct section const *txts;
 
-		txtname = has_rel_mcount(sec);
-		if (txtname && is_mcounted_section_name(txtname)) {
+		txts = has_rel_mcount(sec);
+		if (txts && txts->mcounted) {
 			unsigned long recval = 0;
 			unsigned int recsym;
 
 			if (find_section_sym_index(sec->sh.sh_info,
-						txtname, &recval, &recsym))
+						txts->name, &recval, &recsym))
 				goto out;
 
 			sift_rel_mcount(&r_offset, sec, mrels, mlocs,
 				recsym, recval, reltype, is_rela);
-		} else if (txtname && (warn_on_notrace_sect || make_nop)) {
+		} else if (txts && (warn_on_notrace_sect || make_nop)) {
 			/*
 			 * This section is ignored by ftrace, but still
 			 * has mcount calls. Convert them to nops now.
 			 */
-			if (nop_mcount(sec, txtname) < 0)
+			if (nop_mcount(sec, txts->name) < 0)
 				goto out;
 		}
 	}
-- 
2.20.1

