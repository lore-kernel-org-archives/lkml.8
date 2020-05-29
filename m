Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC151C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1593214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgE2VBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:01:32 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:31982 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727106AbgE2VBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:01:31 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 29 May 2020 14:01:22 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 6430BB2A01;
        Fri, 29 May 2020 17:01:26 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH 2/2] objtool: Add support for relocations without addends
Date:   Fri, 29 May 2020 14:01:14 -0700
Message-ID: <af8b5d5bffc64af00ad88e0b7bd216e91cbfdb36.1590785960.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1590785960.git.mhelsley@vmware.com>
References: <cover.1590785960.git.mhelsley@vmware.com>
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
some supported architectures do not use rela relocations.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/elf.c     | 146 +++++++++++++++++++++++++++++++++++-----
 tools/objtool/elf.h     |   7 +-
 tools/objtool/orc_gen.c |   2 +-
 3 files changed, 135 insertions(+), 20 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c21e8417637b..5034918494b6 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -490,6 +490,32 @@ void elf_add_reloc(struct elf *elf, struct reloc *reloc)
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
@@ -499,7 +525,8 @@ static int read_relocs(struct elf *elf)
 	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
 
 	list_for_each_entry(sec, &elf->sections, list) {
-		if (sec->sh.sh_type != SHT_RELA)
+		if ((sec->sh.sh_type != SHT_RELA) &&
+		    (sec->sh.sh_type != SHT_REL))
 			continue;
 
 		sec->base = find_section_by_index(elf, sec->sh.sh_info);
@@ -519,16 +546,17 @@ static int read_relocs(struct elf *elf)
 				return -1;
 			}
 			memset(reloc, 0, sizeof(*reloc));
-
-			if (!gelf_getrela(sec->data, i, &reloc->rela)) {
-				WARN_ELF("gelf_getrela");
-				return -1;
+			switch(sec->sh.sh_type) {
+			case SHT_REL:
+				if (read_rel_reloc(sec, i, reloc, &symndx))
+					return -1;
+				break;
+			case SHT_RELA:
+				if (read_rela_reloc(sec, i, reloc, &symndx))
+					return -1;
+				break;
+			default: return -1;
 			}
-
-			reloc->type = GELF_R_TYPE(reloc->rela.r_info);
-			reloc->addend = reloc->rela.r_addend;
-			reloc->offset = reloc->rela.r_offset;
-			symndx = GELF_R_SYM(reloc->rela.r_info);
 			reloc->sym = find_symbol_by_index(elf, symndx);
 			reloc->sec = sec;
 			if (!reloc->sym) {
@@ -716,7 +744,38 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	return sec;
 }
 
-struct section *elf_create_reloc_section(struct elf *elf, struct section *base)
+static struct section *elf_create_rel_reloc_section(struct elf *elf, struct section *base)
+{
+	char *relocname;
+	struct section *sec;
+
+	relocname = malloc(strlen(base->name) + strlen(".rel") + 1);
+	if (!relocname) {
+		perror("malloc");
+		return NULL;
+	}
+	strcpy(relocname, ".rel");
+	strcat(relocname, base->name);
+
+	sec = elf_create_section(elf, relocname, sizeof(GElf_Rel), 0);
+	free(relocname);
+	if (!sec)
+		return NULL;
+
+	base->reloc = sec;
+	sec->base = base;
+
+	sec->sh.sh_type = SHT_REL;
+	sec->sh.sh_addralign = 8;
+	sec->sh.sh_link = find_section_by_name(elf, ".symtab")->idx;
+	sec->sh.sh_info = base->idx;
+	sec->sh.sh_flags = SHF_INFO_LINK;
+
+	return sec;
+}
+
+
+static struct section *elf_create_rela_reloc_section(struct elf *elf, struct section *base)
 {
 	char *relocname;
 	struct section *sec;
@@ -746,16 +805,53 @@ struct section *elf_create_reloc_section(struct elf *elf, struct section *base)
 	return sec;
 }
 
-int elf_rebuild_reloc_section(struct section *sec)
+struct section *elf_create_reloc_section(struct elf *elf,
+					 struct section *base,
+					 int reltype)
+{
+	switch(reltype) {
+	case SHT_REL:  return elf_create_rel_reloc_section(elf, base);
+	case SHT_RELA: return elf_create_rela_reloc_section(elf, base);
+	default:       return NULL;
+	}
+}
+
+static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
 {
 	struct reloc *reloc;
-	int nr, idx = 0, size;
-	GElf_Rela *relocs;
+	int idx = 0, size;
+	GElf_Rel *relocs;
 
-	nr = 0;
-	list_for_each_entry(reloc, &sec->reloc_list, list)
-		nr++;
+	/* Allocate a buffer for relocations */
+	size = nr * sizeof(*relocs);
+	relocs = malloc(size);
+	if (!relocs) {
+		perror("malloc");
+		return -1;
+	}
+
+	sec->data->d_buf = relocs;
+	sec->data->d_size = size;
 
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
+
+	/* Allocate a buffer for relocations with addends */
 	size = nr * sizeof(*relocs);
 	relocs = malloc(size);
 	if (!relocs) {
@@ -779,6 +875,22 @@ int elf_rebuild_reloc_section(struct section *sec)
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
index 6ad759fd778e..78a2db23b8b6 100644
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
@@ -116,7 +119,7 @@ static inline u32 reloc_hash(struct reloc *reloc)
 
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
-struct section *elf_create_reloc_section(struct elf *elf, struct section *base);
+struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
 void elf_add_reloc(struct elf *elf, struct reloc *reloc);
 int elf_write(const struct elf *elf);
 void elf_close(struct elf *elf);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index b538a0408cde..47875e83598b 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -181,7 +181,7 @@ int create_orc_sections(struct objtool_file *file)
 	if (!sec)
 		return -1;
 
-	ip_relocsec = elf_create_reloc_section(file->elf, sec);
+	ip_relocsec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
 	if (!ip_relocsec)
 		return -1;
 
-- 
2.20.1

