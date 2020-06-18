Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D403AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BD3208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbgFRUks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:48 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:10226 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731487AbgFRUjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:42 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:36 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 8014CB2659;
        Thu, 18 Jun 2020 16:39:39 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 47/51] objtool: mcount: Merge section mcount flags
Date:   Thu, 18 Jun 2020 13:38:33 -0700
Message-ID: <cf3a0bb03cb666bf5e6360c2dbd3c5f102d01947.1592510545.git.mhelsley@vmware.com>
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

One flag is only for relocation sections and the other only
for text (not relocation) sections so we can share the same
flag and test the section type when we need to.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/elf.c    | 5 ++---
 tools/objtool/elf.h    | 2 +-
 tools/objtool/mcount.c | 9 ++++++---
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3708f85fe36d..12bd889a62ba 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -384,8 +384,7 @@ static int read_sections(struct elf *elf)
 		}
 		sec->len = sec->sh.sh_size;
 
-		sec->mcounted = is_mcounted_section_name(sec->name);
-		sec->relocs_mcountable = false;
+		sec->mcountable = is_mcounted_section_name(sec->name);
 
 		list_add_tail(&sec->list, &elf->sections);
 		elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
@@ -642,7 +641,7 @@ static int read_relocs(struct elf *elf)
 		}
 
 		sec->base->reloc = sec;
-		sec->relocs_mcountable = relocs_mcountable(sec);
+		sec->mcountable = relocs_mcountable(sec);
 
 		nr_reloc = 0;
 		for (i = 0; i < sec->sh.sh_size / sec->sh.sh_entsize; i++) {
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 92d3e68abf59..fb10f470d1a4 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -39,7 +39,7 @@ struct section {
 	char *name;
 	int idx;
 	unsigned int len;
-	bool changed, text, rodata, noinstr, mcounted, relocs_mcountable;
+	bool changed, text, rodata, noinstr, mcountable;
 };
 
 enum symbol_class {
diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index 9cd52beed871..80daf0e17eab 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -279,7 +279,10 @@ static void tot_relsize(unsigned int *rel_entsize)
 	const struct section *sec;
 
 	list_for_each_entry(sec, &lf->sections, list) {
-		if (sec->relocs_mcountable)
+		if (sec->sh.sh_type != SHT_REL &&
+		    sec->sh.sh_type != SHT_RELA)
+			continue;
+		if (sec->mcountable)
 			*rel_entsize = sec->sh.sh_entsize;
 	}
 }
@@ -419,13 +422,13 @@ static int do_mcount(unsigned const reltype, size_t rela_size)
 		    sec->sh.sh_type != SHT_RELA)
 			continue;
 		/* Which may relocate mcount calls.. */
-		if (!sec->relocs_mcountable)
+		if (!sec->mcountable)
 			continue;
 		txts = sec->base;
 		if (!txts)
 			continue;
 
-		if (txts->mcounted) {
+		if (txts->mcountable) {
 			/* In mcountable text sections */
 			unsigned long recval = 0;
 			unsigned int recsym;
-- 
2.20.1

