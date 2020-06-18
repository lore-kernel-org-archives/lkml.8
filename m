Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37198C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFC3208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgFRUjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:39:32 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:3944 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730903AbgFRUjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:08 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:01 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id AA257B265F;
        Thu, 18 Jun 2020 16:39:04 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 08/51] objtool: mcount: Remove unused fname parameter
Date:   Thu, 18 Jun 2020 13:37:54 -0700
Message-ID: <93aeffe2e6529cf01f5238d1342af6d5206fd85d.1592510545.git.mhelsley@vmware.com>
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

The name of the object file being processed is unused in
the wrapper's leaf functions so we no longer need to pass
it as a parameter.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c |  4 ++--
 tools/objtool/recordmcount.h | 19 ++++++++-----------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index f585bf7f45f5..9941683b3f60 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -586,7 +586,7 @@ static int do_file(char const *const fname)
 			reltype = R_MIPS_32;
 			is_fake_mcount32 = MIPS32_is_fake_mcount;
 		}
-		if (do32(ehdr, fname, reltype) < 0)
+		if (do32(ehdr, reltype) < 0)
 			goto out;
 		break;
 	case ELFCLASS64: {
@@ -607,7 +607,7 @@ static int do_file(char const *const fname)
 			Elf64_r_info = MIPS64_r_info;
 			is_fake_mcount64 = MIPS64_is_fake_mcount;
 		}
-		if (do64(ghdr, fname, reltype) < 0)
+		if (do64(ghdr, reltype) < 0)
 			goto out;
 		break;
 	}
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 4bd61c9d1fd5..53abfd49a537 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -548,8 +548,7 @@ static int find_secsym_ndx(unsigned const txtndx,
 /* Evade ISO C restriction: no declaration after statement in has_rel_mcount. */
 static char const * __has_rel_mcount(GElf_Shdr const *const relhdr, /* reltype */
 				     Elf_Shdr const *const shdr0,
-				     char const *const shstrtab,
-				     char const *const fname)
+				     char const *const shstrtab)
 {
 	/* .sh_info depends on .sh_type == SHT_REL[,A] */
 	Elf_Shdr const *const txthdr = &shdr0[relhdr->sh_info];
@@ -563,25 +562,23 @@ static char const * __has_rel_mcount(GElf_Shdr const *const relhdr, /* reltype *
 
 static char const *has_rel_mcount(GElf_Shdr const *const relhdr,
 				  Elf_Shdr const *const shdr0,
-				  char const *const shstrtab,
-				  char const *const fname)
+				  char const *const shstrtab)
 {
 	if (relhdr->sh_type != SHT_REL && relhdr->sh_type != SHT_RELA)
 		return NULL;
-	return __has_rel_mcount(relhdr, shdr0, shstrtab, fname);
+	return __has_rel_mcount(relhdr, shdr0, shstrtab);
 }
 
 
 static unsigned tot_relsize(Elf_Shdr const *const shdr0,
-			    const char *const shstrtab,
-			    const char *const fname)
+			    const char *const shstrtab)
 {
 	struct section *sec;
 	unsigned totrelsz = 0;
 	char const *txtname;
 
 	list_for_each_entry(sec, &lf->sections, list) {
-		txtname = has_rel_mcount(&sec->sh, shdr0, shstrtab, fname);
+		txtname = has_rel_mcount(&sec->sh, shdr0, shstrtab);
 		if (txtname && is_mcounted_section_name(txtname))
 			totrelsz += sec->sh.sh_size;
 	}
@@ -589,7 +586,7 @@ static unsigned tot_relsize(Elf_Shdr const *const shdr0,
 }
 
 /* Overall supervision for Elf32 ET_REL file. */
-static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
+static int do_func(Elf_Ehdr *const ehdr,
 		   unsigned const reltype)
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
@@ -622,7 +619,7 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 	if (find_section_by_name(lf, "__mcount_loc") != NULL)
 		return 0;
 
-	totrelsz = tot_relsize(shdr0, shstrtab, fname);
+	totrelsz = tot_relsize(shdr0, shstrtab);
 	if (totrelsz == 0)
 		return 0;
 	mrel0 = umalloc(totrelsz);
@@ -645,7 +642,7 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 
 		relhdr = &sec->sh;
 		txtname = has_rel_mcount(relhdr, shdr0,
-			shstrtab, fname);
+			shstrtab);
 		if (txtname && is_mcounted_section_name(txtname)) {
 			unsigned int recsym;
 			uint_t recval = 0;
-- 
2.20.1

