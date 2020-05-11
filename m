Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24373C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDDB206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbgEKRfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:35:43 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:37716 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729698AbgEKRfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:35:38 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 11 May 2020 10:35:35 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 49DDB401CB;
        Mon, 11 May 2020 10:35:36 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 3/5] objtool: Add support for relocations without addends
Date:   Mon, 11 May 2020 10:35:11 -0700
Message-ID: <17ee3f6f2a246008aaae70f92df24ae92fa0e21e.1588888003.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1588888003.git.mhelsley@vmware.com>
References: <cover.1588888003.git.mhelsley@vmware.com>
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
 tools/objtool/elf.c | 55 ++++++++++++++++++++++++++++++++++++---------
 tools/objtool/elf.h |  5 ++++-
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c4857fa3f1d1..cd841e3df87d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -465,12 +465,14 @@ static int read_relas(struct elf *elf)
 	unsigned long nr_rela, max_rela = 0, tot_rela = 0;
 
 	list_for_each_entry(sec, &elf->sections, list) {
-		if (sec->sh.sh_type != SHT_RELA)
+		if ((sec->sh.sh_type != SHT_RELA) &&
+		     (sec->sh.sh_type != SHT_REL))
 			continue;
 
-		sec->base = find_section_by_name(elf, sec->name + 5);
+		sec->base = find_section_by_name(elf, sec->name +
+				((sec->sh.sh_type != SHT_REL) ? 5 : 4));
 		if (!sec->base) {
-			WARN("can't find base section for rela section %s",
+			WARN("can't find base section for relocation section %s",
 			     sec->name);
 			return -1;
 		}
@@ -486,13 +488,26 @@ static int read_relas(struct elf *elf)
 			}
 			memset(rela, 0, sizeof(*rela));
 
-			if (!gelf_getrela(sec->data, i, &rela->rela)) {
-				WARN_ELF("gelf_getrela");
-				return -1;
+			switch(sec->sh.sh_type) {
+			case SHT_REL:
+				if (!gelf_getrel(sec->data, i, &rela->rel)) {
+					WARN_ELF("gelf_getrel");
+					return -1;
+				}
+				rela->addend = 0;
+				break;
+			case SHT_RELA:
+				if (!gelf_getrela(sec->data, i, &rela->rela)) {
+					WARN_ELF("gelf_getrela");
+					return -1;
+				}
+				rela->addend = rela->rela.r_addend;
+				break;
+			default:
+				break;
 			}
 
 			rela->type = GELF_R_TYPE(rela->rela.r_info);
-			rela->addend = rela->rela.r_addend;
 			rela->offset = rela->rela.r_offset;
 			symndx = GELF_R_SYM(rela->rela.r_info);
 			rela->sym = find_symbol_by_index(elf, symndx);
@@ -717,17 +732,27 @@ int elf_rebuild_rela_section(struct section *sec)
 	struct rela *rela;
 	int nr, idx = 0, size;
 	GElf_Rela *relas;
+	GElf_Rel *rels;
 
 	nr = 0;
 	list_for_each_entry(rela, &sec->rela_list, list)
 		nr++;
 
+	/*
+	 * Allocate a buffer for relocations with addends but also use
+	 * it for other relocations too. The section type determines
+	 * the size of the section, the buffer used, and the entries.
+	 */
 	size = nr * sizeof(*relas);
 	relas = malloc(size);
 	if (!relas) {
 		perror("malloc");
 		return -1;
 	}
+	rels = (void *)relas;
+	if (sec->sh.sh_type == SHT_REL) {
+		size = nr * sizeof(*rels);
+	}
 
 	sec->data->d_buf = relas;
 	sec->data->d_size = size;
@@ -736,9 +761,19 @@ int elf_rebuild_rela_section(struct section *sec)
 
 	idx = 0;
 	list_for_each_entry(rela, &sec->rela_list, list) {
-		relas[idx].r_offset = rela->offset;
-		relas[idx].r_addend = rela->addend;
-		relas[idx].r_info = GELF_R_INFO(rela->sym->idx, rela->type);
+		switch(sec->sh.sh_type) {
+		case SHT_REL:
+			rels[idx].r_offset = rela->offset;
+			rels[idx].r_info = GELF_R_INFO(rela->sym->idx, rela->type);
+			break;
+		case SHT_RELA:
+			relas[idx].r_addend = rela->addend;
+			relas[idx].r_offset = rela->offset;
+			relas[idx].r_info = GELF_R_INFO(rela->sym->idx, rela->type);
+			break;
+		default:
+			break;
+		}
 		idx++;
 	}
 
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 0b79c2353a21..71bd47055963 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -61,7 +61,10 @@ struct symbol {
 struct rela {
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

