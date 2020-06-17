Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9EDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C983208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgFQKEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:04:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84160C061755;
        Wed, 17 Jun 2020 03:04:49 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlUw1-0006Mp-78; Wed, 17 Jun 2020 12:04:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C5D0E1C0089;
        Wed, 17 Jun 2020 12:04:44 +0200 (CEST)
Date:   Wed, 17 Jun 2020 10:04:44 -0000
From:   "tip-bot2 for Matt Helsley" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add support for relocations without addends
Cc:     Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159238828457.16989.2595919108500303396.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     fb414783b65c880606fbc1463e6849f017e60d46
Gitweb:        https://git.kernel.org/tip/fb414783b65c880606fbc1463e6849f017e60d46
Author:        Matt Helsley <mhelsley@vmware.com>
AuthorDate:    Fri, 29 May 2020 14:01:14 -07:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 02 Jun 2020 15:37:04 -05:00

objtool: Add support for relocations without addends

Currently objtool only collects information about relocations with
addends. In recordmcount, which we are about to merge into objtool,
some supported architectures do not use rela relocations.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
Reviewed-by: Julien Thierry <jthierry@redhat.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c     | 145 ++++++++++++++++++++++++++++++++++-----
 tools/objtool/elf.h     |   7 +-
 tools/objtool/orc_gen.c |   2 +-
 3 files changed, 134 insertions(+), 20 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3160931..95d86bc 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -496,6 +496,32 @@ void elf_add_reloc(struct elf *elf, struct reloc *reloc)
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
@@ -505,7 +531,8 @@ static int read_relocs(struct elf *elf)
 	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
 
 	list_for_each_entry(sec, &elf->sections, list) {
-		if (sec->sh.sh_type != SHT_RELA)
+		if ((sec->sh.sh_type != SHT_RELA) &&
+		    (sec->sh.sh_type != SHT_REL))
 			continue;
 
 		sec->base = find_section_by_index(elf, sec->sh.sh_info);
@@ -525,16 +552,17 @@ static int read_relocs(struct elf *elf)
 				return -1;
 			}
 			memset(reloc, 0, sizeof(*reloc));
-
-			if (!gelf_getrela(sec->data, i, &reloc->rela)) {
-				WARN_ELF("gelf_getrela");
-				return -1;
+			switch (sec->sh.sh_type) {
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
@@ -722,7 +750,37 @@ struct section *elf_create_section(struct elf *elf, const char *name,
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
+static struct section *elf_create_rela_reloc_section(struct elf *elf, struct section *base)
 {
 	char *relocname;
 	struct section *sec;
@@ -752,16 +810,53 @@ struct section *elf_create_reloc_section(struct elf *elf, struct section *base)
 	return sec;
 }
 
-int elf_rebuild_reloc_section(struct section *sec)
+struct section *elf_create_reloc_section(struct elf *elf,
+					 struct section *base,
+					 int reltype)
+{
+	switch (reltype) {
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
@@ -785,6 +880,22 @@ int elf_rebuild_reloc_section(struct section *sec)
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
+	switch (sec->sh.sh_type) {
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
index 6ad759f..78a2db2 100644
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
index 93c720b..75e08cf 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -181,7 +181,7 @@ int create_orc_sections(struct objtool_file *file)
 	if (!sec)
 		return -1;
 
-	ip_relocsec = elf_create_reloc_section(file->elf, sec);
+	ip_relocsec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
 	if (!ip_relocsec)
 		return -1;
 
