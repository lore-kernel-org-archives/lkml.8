Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A585C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D97520890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbgFRUlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:41:32 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36734 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731497AbgFRUjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:43 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:37 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id CAF65B265B;
        Thu, 18 Jun 2020 16:39:40 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 49/51] objtool: mcount: Remove relocation size check
Date:   Thu, 18 Jun 2020 13:38:35 -0700
Message-ID: <6daddf400359443d5b8a2d765794524d896e3d55.1592510545.git.mhelsley@vmware.com>
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

Rather than use the size of the relocations check the section
header type directly to see if the mcount relocations should
be rel or rela relocations.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/elf.c    |  4 ++--
 tools/objtool/elf.h    |  2 +-
 tools/objtool/mcount.c | 15 +++++----------
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 733e10d4a574..4948df31bba0 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -642,8 +642,8 @@ static int read_relocs(struct elf *elf)
 
 		sec->base->reloc = sec;
 		sec->mcountable = relocs_mcountable(sec);
-		if (sec->mcountable && !elf->mcount_rel_entsize)
-			elf->mcount_rel_entsize = sec->sh.sh_entsize;
+		if (sec->mcountable)
+			elf->mcount_r_addends = (sec->sh.sh_type == SHT_RELA);
 
 		nr_reloc = 0;
 		for (i = 0; i < sec->sh.sh_size / sec->sh.sh_entsize; i++) {
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 8ece1ca79cca..f298e327af01 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -87,8 +87,8 @@ struct elf {
 	Elf *elf;
 	GElf_Ehdr ehdr;
 	int fd;
-	size_t mcount_rel_entsize;
 	bool changed;
+	bool mcount_r_addends;
 	char *name;
 	struct list_head sections;
 	DECLARE_HASHTABLE(symbol_hash, ELF_HASH_BITS);
diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index 9527924af56b..084bbc02de0c 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -368,22 +368,17 @@ static void fill_mcount_locs(GElf_Sxword r_offset, GElf_Addr **rbuf,
 }
 
 /* Overall supervision for Elf32 ET_REL file. */
-static int do_mcount(unsigned const reltype, size_t rela_size)
+static int do_mcount(unsigned const reltype)
 {
-	GElf_Sxword r_offset = 0;
-
 	struct section *sec, *mlocs, *mrels;
 	const char * const mc_name =  "__mcount_loc";
-
-	const unsigned int rel_entsize = lf->mcount_rel_entsize;
+	GElf_Sxword r_offset = 0;
 	int result = -1;
-	bool is_rela;
+	const bool is_rela = lf->mcount_r_addends;
 
 	if (find_section_by_name(lf, "__mcount_loc") != NULL)
 		return 0;
 
-	is_rela = (rela_size == rel_entsize);
-
 	/* add section: __mcount_loc */
 	mlocs = elf_create_section(lf, mc_name, sizeof(GElf_Addr), 0);
 	if (!mlocs)
@@ -562,7 +557,7 @@ static int do_file(char const *const fname)
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
 		loc_size = 4;
-		rc = do_mcount(reltype, sizeof(Elf32_Rela));
+		rc = do_mcount(reltype);
 		break;
 	case ELFCLASS64: {
 		if (lf->ehdr.e_ehsize != sizeof(Elf64_Ehdr)
@@ -580,7 +575,7 @@ static int do_file(char const *const fname)
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
 		loc_size = 8;
-		rc = do_mcount(reltype, sizeof(Elf64_Rela));
+		rc = do_mcount(reltype);
 		break;
 	}
 	}  /* end switch */
-- 
2.20.1

