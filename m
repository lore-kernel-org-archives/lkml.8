Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B61BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F38CD20890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbgFRUly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:41:54 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:40437 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731391AbgFRUjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:36 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:32 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 9A0E7B2668;
        Thu, 18 Jun 2020 16:39:35 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 42/51] objtool: mcount: Move mcount symbol name testing
Date:   Thu, 18 Jun 2020 13:38:28 -0700
Message-ID: <0a4ae1e3db4f65c8da1988b58e19915e1bf8327d.1592510545.git.mhelsley@vmware.com>
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

Move the test for mcount symbols into the ELF code itself
and set a class on indicator on the symbol. This simplifies
mcount a little and tests the symbols names near where they're
first touched so should be cache-hot and may also help us
reduce the number of passes through the ELF contents needed
for individual subcommands. Finally, if we manage to combine
subcommands into a single exec of objtool the number of
passes through the ELF data could be even further reduced.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/elf.c    | 18 ++++++++++++++++++
 tools/objtool/elf.h    |  6 ++++++
 tools/objtool/mcount.c | 31 +++----------------------------
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8dcdea8020a5..d55d8fef11b4 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -387,6 +387,21 @@ static int read_sections(struct elf *elf)
 	return 0;
 }
 
+static bool is_mcount_sym(const char *name)
+{
+	if (name[0] == '.')
+		name++;  /* ppc64 hack */
+
+	if (name[0] == '_')
+		name++;
+
+	if (strcmp("mcount", name) == 0 ||
+	    (strcmp("__gnu_mcount_nc", name) == 0) ||
+	    (strcmp("_fentry__", name) == 0))
+		return true;
+	return false;
+}
+
 static int read_symbols(struct elf *elf)
 {
 	struct section *symtab, *symtab_shndx, *sec;
@@ -456,6 +471,9 @@ static int read_symbols(struct elf *elf)
 		} else
 			sym->sec = find_section_by_index(elf, 0);
 
+		if (is_mcount_sym(sym->name))
+			sym->class = SYM_MCOUNT;
+
 		sym->offset = sym->sym.st_value;
 		sym->len = sym->sym.st_size;
 
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 09fa0d085341..13935edaff54 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -42,6 +42,11 @@ struct section {
 	bool changed, text, rodata, noinstr;
 };
 
+enum symbol_class {
+	SYM_REGULAR = 0,
+	SYM_MCOUNT = 1,
+};
+
 struct symbol {
 	struct list_head list;
 	struct rb_node node;
@@ -55,6 +60,7 @@ struct symbol {
 	unsigned long offset;
 	unsigned int len;
 	struct symbol *pfunc, *cfunc, *alias;
+	enum symbol_class class;
 	bool uaccess_safe;
 };
 
diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index 029e6e72c972..7fbde6ce6eb8 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -152,24 +152,6 @@ static int is_mcounted_section_name(char const *const txtname)
 		strcmp(".cpuidle.text", txtname) == 0;
 }
 
-static struct symbol *get_mcount_sym(struct reloc *reloc)
-{
-	struct symbol *sym = reloc->sym;
-	char const *symname = sym->name;
-
-	if (symname[0] == '.')
-		symname++;  /* ppc64 hack */
-
-	if (symname[0] == '_')
-		symname++;
-
-	if (strcmp("mcount", symname) == 0 ||
-	    (strcmp("__gnu_mcount_nc", symname) == 0) ||
-	    (strcmp("_fentry__", symname) == 0))
-		return sym;
-	return NULL;
-}
-
 /*
  * MIPS mcount long call has 2 _mcount symbols, only the position of the 1st
  * _mcount symbol is needed for dynamic function tracer, with it, to disable
@@ -266,16 +248,13 @@ static int nop_mcount(struct section * const rels,
 {
 	struct reloc *reloc;
 	struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
-	struct symbol *mcount_sym = NULL;
 	int once = 0;
 
 	list_for_each_entry(reloc, &rels->reloc_list, list) {
 		int ret = -1;
 
-		if (!mcount_sym)
-			mcount_sym = get_mcount_sym(reloc);
-
-		if (mcount_sym == reloc->sym && !is_fake_mcount(reloc)) {
+		if (reloc->sym->class == SYM_MCOUNT &&
+		    !is_fake_mcount(reloc)) {
 			if (make_nop) {
 				ret = make_nop(txts, reloc->offset);
 				if (ret < 0)
@@ -355,16 +334,12 @@ static void sift_rel_mcount(GElf_Addr **mlocpp,
 {
 	GElf_Rel *mrelp = *mrelpp;
 	GElf_Rela *mrelap = *mrelpp;
-	struct symbol *mcount_sym = NULL;
 	struct reloc *reloc;
 
 	list_for_each_entry(reloc, &rels->reloc_list, list) {
 		unsigned long addend;
 
-		if (!mcount_sym)
-			mcount_sym = get_mcount_sym(reloc);
-
-		if (mcount_sym != reloc->sym || is_fake_mcount(reloc))
+		if (reloc->sym->class == SYM_MCOUNT || is_fake_mcount(reloc))
 			continue;
 
 		addend = reloc->offset - recval + mcount_adjust;
-- 
2.20.1

