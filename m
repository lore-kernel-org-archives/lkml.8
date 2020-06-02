Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADA720734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgFBTvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:51:11 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36862 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728321AbgFBTvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:51:00 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:50:54 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 2A12F40C1B;
        Tue,  2 Jun 2020 12:50:55 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 11/32] objtool: mcount: Move get_mcountsym
Date:   Tue, 2 Jun 2020 12:50:04 -0700
Message-ID: <af34323c53a2ecea059c63db95916fcf8fbc0aa3.1591125127.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1591125127.git.mhelsley@vmware.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that it's been stripped of using the old recordmcount ELF
wrapper get_mcountsym() is ready to be promoted out of the
double-included wrapper header.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 16 ++++++++++++++++
 tools/objtool/recordmcount.h | 19 -------------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index dafa6dd10d04..f72d313a2b51 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -422,6 +422,22 @@ static int is_mcounted_section_name(char const *const txtname)
 		strcmp(".cpuidle.text", txtname) == 0;
 }
 
+static unsigned get_mcountsym(struct reloc *reloc)
+{
+	struct symbol *sym = reloc->sym;
+	char const *symname = sym->name;
+	char const *mcount = gpfx == '_' ? "_mcount" : "mcount";
+	char const *fentry = "__fentry__";
+
+	if (symname[0] == '.')
+		++symname;  /* ppc64 hack */
+	if (strcmp(mcount, symname) == 0 ||
+	    (altmcount && strcmp(altmcount, symname) == 0) ||
+	    (strcmp(fentry, symname) == 0))
+		return GELF_R_INFO(reloc->sym->idx, reloc->type);
+	return 0;
+}
+
 static const unsigned int missing_sym = (unsigned int)-1;
 
 /* 32 bit and 64 bit are very similar */
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index cbf66b63ff82..a3fb62e88450 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -27,7 +27,6 @@
 #undef find_section_sym_index
 #undef has_rel_mcount
 #undef tot_relsize
-#undef get_mcountsym
 #undef do_func
 #undef Elf_Addr
 #undef Elf_Ehdr
@@ -50,7 +49,6 @@
 # define has_rel_mcount		has64_rel_mcount
 # define tot_relsize		tot64_relsize
 # define do_func		do64
-# define get_mcountsym		get_mcountsym_64
 # define is_fake_mcount		is_fake_mcount64
 # define fn_is_fake_mcount	fn_is_fake_mcount64
 # define MIPS_is_fake_mcount	MIPS64_is_fake_mcount
@@ -75,7 +73,6 @@
 # define has_rel_mcount		has32_rel_mcount
 # define tot_relsize		tot32_relsize
 # define do_func		do32
-# define get_mcountsym		get_mcountsym_32
 # define is_fake_mcount		is_fake_mcount32
 # define fn_is_fake_mcount	fn_is_fake_mcount32
 # define MIPS_is_fake_mcount	MIPS32_is_fake_mcount
@@ -234,22 +231,6 @@ static int append_func(Elf_Ehdr *const ehdr,
 	return elf_write(lf);
 }
 
-static unsigned get_mcountsym(struct reloc *reloc)
-{
-	struct symbol *sym = reloc->sym;
-	char const *symname = sym->name;
-	char const *mcount = gpfx == '_' ? "_mcount" : "mcount";
-	char const *fentry = "__fentry__";
-
-	if (symname[0] == '.')
-		++symname;  /* ppc64 hack */
-	if (strcmp(mcount, symname) == 0 ||
-	    (altmcount && strcmp(altmcount, symname) == 0) ||
-	    (strcmp(fentry, symname) == 0))
-		return GELF_R_INFO(reloc->sym->idx, reloc->type);
-	return 0;
-}
-
 /*
  * Look at the relocations in order to find the calls to mcount.
  * Accumulate the section offsets that are found, and their relocation info,
-- 
2.20.1

