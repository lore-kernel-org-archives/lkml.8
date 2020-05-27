Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B93AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0A720721
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391378AbgE0Qmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:42:51 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:13180 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391355AbgE0Qms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:42:48 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 27 May 2020 09:42:44 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 40F434046A;
        Wed, 27 May 2020 09:42:47 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 3/3] objtool: Add support for relocations without addends
Date:   Wed, 27 May 2020 09:42:33 -0700
Message-ID: <933488b79c91ba040e68847fe53531fd97b18e07.1590597288.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1590597288.git.mhelsley@vmware.com>
References: <cover.1590597288.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently objtool only collects information about relocations with
addends. In recordmcount, which we are about to merge into objtool,
some supported architectures do not use rela relocations. Since
object files use one or the other the list can be reused.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/elf.c | 109 ++++++++++++++++++++++++++++++++++++--------
 tools/objtool/elf.h |   5 +-
 2 files changed, 95 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index a162bc383945..cc7b628b1566 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2014 Seth Jennings <sjenning@redhat.com>
  */
 
+#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -490,6 +491,32 @@ void elf_add_reloc(struct elf *elf, struct reloc *reloc)
 	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
 }
 
+static int read_rel_reloc(struct section *sec, int i, struct reloc *reloc, unsigned int *symndx)
+{
+	if (!gelf_getrel(sec->data, i, &reloc->rel)) {
+		WARN_ELF("gelf_getrel");
+		return -1;
+	}
+	reloc->type = GELF_R_TYPE(reloc->rel.r_info);
+	reloc->addend = 0;
+	reloc->offset = reloc->rel.r_offset;
+	*symndx = GELF_R_SYM(reloc->rel.r_info);
+	return 0;
+}
+
+static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsigned int *symndx)
+{
+	if (!gelf_getrela(sec->data, i, &reloc->rela)) {
+		WARN_ELF("gelf_getrela");
+		return -1;
+	}
+	reloc->type = GELF_R_TYPE(reloc->rela.r_info);
+	reloc->addend = reloc->rela.r_addend;
+	reloc->offset = reloc->rela.r_offset;
+	*symndx = GELF_R_SYM(reloc->rela.r_info);
+	return 0;
+}
+
 static int read_relocs(struct elf *elf)
 {
 	struct section *sec;
@@ -497,17 +524,21 @@ static int read_relocs(struct elf *elf)
 	int i;
 	unsigned int symndx;
 	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
+	int (*read_reloc)(struct section *, int, struct reloc *, unsigned int *);
 
 	list_for_each_entry(sec, &elf->sections, list) {
-		if (sec->sh.sh_type != SHT_RELA)
-			continue;
+		switch(sec->sh.sh_type) {
+		case SHT_REL: read_reloc = read_rel_reloc; break;
+		case SHT_RELA: read_reloc = read_rela_reloc; break;
+		default: continue;
+		}
 
 		if (sec->sh.sh_flags & SHF_INFO_LINK) {
 			sec->base = find_section_by_index(elf, sec->sh.sh_info);
 		} else if (strncmp(sec->name, ".rel", 4) == 0) {
 			WARN("Using naming heuristic to find base of reloc section %s",
 			     sec->name);
-			sec->base = find_section_by_name(elf, sec->name + 5);
+			sec->base = find_section_by_name(elf, strchrnul(sec->name + 1, '.'));
 		}
 		if (!sec->base) {
 			WARN("can't find base section for reloc section %s",
@@ -525,16 +556,8 @@ static int read_relocs(struct elf *elf)
 				return -1;
 			}
 			memset(reloc, 0, sizeof(*reloc));
-
-			if (!gelf_getrela(sec->data, i, &reloc->rela)) {
-				WARN_ELF("gelf_getrela");
+			if (read_reloc(sec, i, reloc, &symndx))
 				return -1;
-			}
-
-			reloc->type = GELF_R_TYPE(reloc->rela.r_info);
-			reloc->addend = reloc->rela.r_addend;
-			reloc->offset = reloc->rela.r_offset;
-			symndx = GELF_R_SYM(reloc->rela.r_info);
 			reloc->sym = find_symbol_by_index(elf, symndx);
 			reloc->sec = sec;
 			if (!reloc->sym) {
@@ -752,16 +775,50 @@ struct section *elf_create_reloc_section(struct elf *elf, struct section *base)
 	return sec;
 }
 
-int elf_rebuild_reloc_section(struct section *sec)
+static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
 {
 	struct reloc *reloc;
-	int nr, idx = 0, size;
-	GElf_Rela *relocs;
+	int idx = 0, size;
+	GElf_Rel *relocs;
+
+	/*
+	 * Allocate a buffer for relocations with addends but also use
+	 * it for other relocations too. The section type determines
+	 * the size of the section, the buffer used, and the entries.
+	 */
+	size = nr * sizeof(*relocs);
+	relocs = malloc(size);
+	if (!relocs) {
+		perror("malloc");
+		return -1;
+	}
 
-	nr = 0;
-	list_for_each_entry(reloc, &sec->reloc_list, list)
-		nr++;
+	sec->data->d_buf = relocs;
+	sec->data->d_size = size;
+
+	sec->sh.sh_size = size;
+
+	idx = 0;
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
+		relocs[idx].r_offset = reloc->offset;
+		relocs[idx].r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		idx++;
+	}
+
+	return 0;
+}
+
+static int elf_rebuild_rela_reloc_section(struct section *sec, int nr)
+{
+	struct reloc *reloc;
+	int idx = 0, size;
+	GElf_Rela *relocs;
 
+	/*
+	 * Allocate a buffer for relocations with addends but also use
+	 * it for other relocations too. The section type determines
+	 * the size of the section, the buffer used, and the entries.
+	 */
 	size = nr * sizeof(*relocs);
 	relocs = malloc(size);
 	if (!relocs) {
@@ -785,6 +842,22 @@ int elf_rebuild_reloc_section(struct section *sec)
 	return 0;
 }
 
+int elf_rebuild_reloc_section(struct section *sec)
+{
+	struct reloc *reloc;
+	int nr;
+
+	nr = 0;
+	list_for_each_entry(reloc, &sec->reloc_list, list)
+		nr++;
+
+	switch(sec->sh.sh_type) {
+	case SHT_REL:  return elf_rebuild_rel_reloc_section(sec, nr);
+	case SHT_RELA: return elf_rebuild_rela_reloc_section(sec, nr);
+	default:       return -1;
+	}
+}
+
 int elf_write(const struct elf *elf)
 {
 	struct section *sec;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 6ad759fd778e..048200af8267 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -61,7 +61,10 @@ struct symbol {
 struct reloc {
 	struct list_head list;
 	struct hlist_node hash;
-	GElf_Rela rela;
+	union {
+		GElf_Rela rela;
+		GElf_Rel  rel;
+	};
 	struct section *sec;
 	struct symbol *sym;
 	unsigned int type;
-- 
2.20.1

