Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DF0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1DD20890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbgFRUml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:42:41 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:4380 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731313AbgFRUjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:22 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:17 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 0EB95B265D;
        Thu, 18 Jun 2020 16:39:21 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 28/51] objtool: mcount: Move mcount_adjust out of wrapper
Date:   Thu, 18 Jun 2020 13:38:14 -0700
Message-ID: <d6d0f204075d948b353a9f5793abc632067b0d36.1592510545.git.mhelsley@vmware.com>
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

The mcount_adjust variable defines how many bytes to move back
from the relocation address in order to be able to get to the
start of the function call instruction(s) needed to turn it
into a no-op. The values are very small and signed so we don't
need to worry about changing the size of the variable's type
inside the wrapper -- we can just use a regular int.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 11 ++++++++---
 tools/objtool/recordmcount.h |  5 -----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index a263062c9c64..bb53927612fb 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -387,6 +387,11 @@ static unsigned tot_relsize(unsigned int *rel_entsize)
 	return totrelsz;
 }
 
+/* zero or a small negative offset added to get the start of the call
+ * instruction
+ */
+static int mcount_adjust = 0;
+
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
@@ -497,7 +502,7 @@ static int do_file(char const *const fname)
 		rel_type_nop = R_386_NONE;
 		make_nop = make_nop_x86;
 		ideal_nop = ideal_nop5_x86_32;
-		mcount_adjust_32 = -1;
+		mcount_adjust = -1;
 		gpfx = 0;
 		break;
 	case EM_ARM:
@@ -526,7 +531,7 @@ static int do_file(char const *const fname)
 		ideal_nop = ideal_nop5_x86_64;
 		reltype = R_X86_64_64;
 		rel_type_nop = R_X86_64_NONE;
-		mcount_adjust_64 = -1;
+		mcount_adjust = -1;
 		gpfx = 0;
 		break;
 	}  /* end switch */
@@ -558,7 +563,7 @@ static int do_file(char const *const fname)
 		}
 		if (lf->ehdr.e_machine == EM_S390) {
 			reltype = R_390_64;
-			mcount_adjust_64 = -14;
+			mcount_adjust = -14;
 		}
 		if (lf->ehdr.e_machine == EM_MIPS) {
 			reltype = R_MIPS_64;
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index a74a80b3356e..e2c8b9d4725d 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -18,7 +18,6 @@
  * Copyright 2010 Steven Rostedt <srostedt@redhat.com>, Red Hat Inc.
  */
 #undef append_func
-#undef mcount_adjust
 #undef sift_rel_mcount
 #undef do_func
 #undef Elf_Shdr
@@ -35,7 +34,6 @@
 # define append_func		append64
 # define sift_rel_mcount	sift64_rel_mcount
 # define do_func		do64
-# define mcount_adjust		mcount_adjust_64
 # define Elf_Rel		Elf64_Rel
 # define Elf_Rela		Elf64_Rela
 # define ELF_R_INFO		ELF64_R_INFO
@@ -48,7 +46,6 @@
 # define append_func		append32
 # define sift_rel_mcount	sift32_rel_mcount
 # define do_func		do32
-# define mcount_adjust		mcount_adjust_32
 # define Elf_Rel		Elf32_Rel
 # define Elf_Rela		Elf32_Rela
 # define ELF_R_INFO		ELF32_R_INFO
@@ -65,8 +62,6 @@ static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
 }
 static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
 
-static int mcount_adjust = 0;
-
 /* Append the new  __mcount_loc and its relocations. */
 static int append_func(uint_t const *const mloc0,
 			uint_t const *const mlocp,
-- 
2.20.1

