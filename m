Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99593C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3C320890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbgFRUmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:42:08 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:4380 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731344AbgFRUjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:31 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:26 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id E0C4EB265A;
        Thu, 18 Jun 2020 16:39:29 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 38/51] objtool: mcount: mcount symbol name simplification
Date:   Thu, 18 Jun 2020 13:38:24 -0700
Message-ID: <2aefb1817980e30ec3ff3803eb0236a87d17c26a.1592510545.git.mhelsley@vmware.com>
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

Remove gpfx -- the recognized prefix for the mcount symbol
-- and just recognize any of the prefixes. This allows us
to further substitute the various strings directly into the
code rather than using variables.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/mcount.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index 7e621769c488..4d6596a031bf 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -43,7 +43,6 @@
 
 #define R_ARM_THM_CALL		10
 
-static char gpfx;	/* prefix for global symbol name (sometimes '_') */
 extern int warn_on_notrace_sect; /* warn when section has mcount not being recorded */
 
 static struct elf *lf;
@@ -166,14 +165,16 @@ static struct symbol *get_mcount_sym(struct reloc *reloc)
 {
 	struct symbol *sym = reloc->sym;
 	char const *symname = sym->name;
-	char const *mcount = gpfx == '_' ? "_mcount" : "mcount";
-	char const *fentry = "__fentry__";
 
 	if (symname[0] == '.')
-		++symname;  /* ppc64 hack */
-	if (strcmp(mcount, symname) == 0 ||
+		symname++;  /* ppc64 hack */
+
+	if (symname[0] == '_')
+		symname++;
+
+	if (strcmp("mcount", symname) == 0 ||
 	    (strcmp("__gnu_mcount_nc", symname) == 0) ||
-	    (strcmp(fentry, symname) == 0))
+	    (strcmp("_fentry__", symname) == 0))
 		return sym;
 	return NULL;
 }
@@ -550,7 +551,6 @@ static int do_file(char const *const fname)
 		goto out;
 	}
 
-	gpfx = '_';
 	switch (lf->ehdr.e_machine) {
 	default:
 		fprintf(stderr, "unrecognized e_machine %u %s\n",
@@ -562,14 +562,12 @@ static int do_file(char const *const fname)
 		make_nop = make_nop_x86;
 		ideal_nop = ideal_nop5_x86_32;
 		mcount_adjust = -1;
-		gpfx = 0;
 		break;
 	case EM_ARM:
 		reltype = R_ARM_ABS32;
 		make_nop = make_nop_arm;
 		rel_type_nop = R_ARM_NONE;
 		is_fake_mcount = arm_is_fake_mcount;
-		gpfx = 0;
 		break;
 	case EM_AARCH64:
 		reltype = R_AARCH64_ABS64;
@@ -582,7 +580,7 @@ static int do_file(char const *const fname)
 	case EM_PPC:	reltype = R_PPC_ADDR32; break;
 	case EM_PPC64:	reltype = R_PPC64_ADDR64; break;
 	case EM_S390:	/* reltype: e_class    */ break;
-	case EM_SH:	reltype = R_SH_DIR32; gpfx = 0; break;
+	case EM_SH:	reltype = R_SH_DIR32;  break;
 	case EM_SPARCV9: reltype = R_SPARC_64; break;
 	case EM_X86_64:
 		make_nop = make_nop_x86;
@@ -590,7 +588,6 @@ static int do_file(char const *const fname)
 		reltype = R_X86_64_64;
 		rel_type_nop = R_X86_64_NONE;
 		mcount_adjust = -1;
-		gpfx = 0;
 		break;
 	}  /* end switch */
 
-- 
2.20.1

