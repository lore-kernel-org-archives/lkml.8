Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913E1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7548520890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbgFRUky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:54 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36734 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731484AbgFRUjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:42 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:36 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 2B062B265A;
        Thu, 18 Jun 2020 16:39:40 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 48/51] objtool: mcount: Eliminate first pass
Date:   Thu, 18 Jun 2020 13:38:34 -0700
Message-ID: <0cac2f36423a66cf981f66cc1710735602786225.1592510545.git.mhelsley@vmware.com>
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

Determine the size of the mcount relocations in objtool's
ELF reading code. This reduces the number of passes we make
through the list of sections (which can become large due to
things like -ffunction-sections).

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/elf.c    |  2 ++
 tools/objtool/elf.h    |  1 +
 tools/objtool/mcount.c | 16 +---------------
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 12bd889a62ba..733e10d4a574 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -642,6 +642,8 @@ static int read_relocs(struct elf *elf)
 
 		sec->base->reloc = sec;
 		sec->mcountable = relocs_mcountable(sec);
+		if (sec->mcountable && !elf->mcount_rel_entsize)
+			elf->mcount_rel_entsize = sec->sh.sh_entsize;
 
 		nr_reloc = 0;
 		for (i = 0; i < sec->sh.sh_size / sec->sh.sh_entsize; i++) {
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index fb10f470d1a4..8ece1ca79cca 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -87,6 +87,7 @@ struct elf {
 	Elf *elf;
 	GElf_Ehdr ehdr;
 	int fd;
+	size_t mcount_rel_entsize;
 	bool changed;
 	char *name;
 	struct list_head sections;
diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index 80daf0e17eab..9527924af56b 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -274,19 +274,6 @@ static int nop_mcount(struct section * const rels,
 	return 0;
 }
 
-static void tot_relsize(unsigned int *rel_entsize)
-{
-	const struct section *sec;
-
-	list_for_each_entry(sec, &lf->sections, list) {
-		if (sec->sh.sh_type != SHT_REL &&
-		    sec->sh.sh_type != SHT_RELA)
-			continue;
-		if (sec->mcountable)
-			*rel_entsize = sec->sh.sh_entsize;
-	}
-}
-
 /* zero or a small negative offset added to get the start of the call
  * instruction
  */
@@ -388,14 +375,13 @@ static int do_mcount(unsigned const reltype, size_t rela_size)
 	struct section *sec, *mlocs, *mrels;
 	const char * const mc_name =  "__mcount_loc";
 
-	unsigned int rel_entsize = 0;
+	const unsigned int rel_entsize = lf->mcount_rel_entsize;
 	int result = -1;
 	bool is_rela;
 
 	if (find_section_by_name(lf, "__mcount_loc") != NULL)
 		return 0;
 
-	tot_relsize(&rel_entsize);
 	is_rela = (rela_size == rel_entsize);
 
 	/* add section: __mcount_loc */
-- 
2.20.1

