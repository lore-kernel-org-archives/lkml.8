Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2E0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A32120890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbgFRUjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:39:49 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731153AbgFRUjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:13 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:06 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id BEF8AB2656;
        Thu, 18 Jun 2020 16:39:09 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 14/51] objtool: mcount: Move get_mcountsym
Date:   Thu, 18 Jun 2020 13:38:00 -0700
Message-ID: <8c3b95adbd58e26c7b09e4d0c7e59acb25b69054.1592510545.git.mhelsley@vmware.com>
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

Now that it's been stripped of using the old recordmcount ELF
wrapper get_mcountsym() is ready to be promoted out of the
double-included wrapper header.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 16 ++++++++++++++++
 tools/objtool/recordmcount.h | 19 -------------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index dafa6dd10d04..d5f7c06afd57 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -422,6 +422,22 @@ static int is_mcounted_section_name(char const *const txtname)
 		strcmp(".cpuidle.text", txtname) == 0;
 }
 
+static struct symbol *get_mcountsym(struct reloc *reloc)
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
+		return sym;
+	return NULL;
+}
+
 static const unsigned int missing_sym = (unsigned int)-1;
 
 /* 32 bit and 64 bit are very similar */
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 6ac120aa45af..210899819261 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -27,7 +27,6 @@
 #undef find_section_sym_index
 #undef has_rel_mcount
 #undef tot_relsize
-#undef get_mcountsym
 #undef get_shnum
 #undef set_shnum
 #undef get_shstrndx
@@ -56,7 +55,6 @@
 # define set_shnum		set_shnum64
 # define get_shstrndx		get_shstrndx64
 # define do_func		do64
-# define get_mcountsym		get_mcountsym_64
 # define is_fake_mcount		is_fake_mcount64
 # define fn_is_fake_mcount	fn_is_fake_mcount64
 # define MIPS_is_fake_mcount	MIPS64_is_fake_mcount
@@ -84,7 +82,6 @@
 # define set_shnum		set_shnum32
 # define get_shstrndx		get_shstrndx32
 # define do_func		do32
-# define get_mcountsym		get_mcountsym_32
 # define is_fake_mcount		is_fake_mcount32
 # define fn_is_fake_mcount	fn_is_fake_mcount32
 # define MIPS_is_fake_mcount	MIPS32_is_fake_mcount
@@ -271,22 +268,6 @@ static int append_func(Elf_Ehdr *const ehdr,
 	return elf_write(lf);
 }
 
-static struct symbol *get_mcountsym(struct reloc *reloc)
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
-		return sym;
-	return NULL;
-}
-
 /*
  * Look at the relocations in order to find the calls to mcount.
  * Accumulate the section offsets that are found, and their relocation info,
-- 
2.20.1

