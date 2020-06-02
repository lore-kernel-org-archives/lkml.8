Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86664C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB9B20734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgFBTv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:51:27 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:29399 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728405AbgFBTvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:51:08 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:51:05 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 1662340BEC;
        Tue,  2 Jun 2020 12:51:06 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 25/32] objtool: mcount: Move mcount_adjust out of wrapper
Date:   Tue, 2 Jun 2020 12:50:18 -0700
Message-ID: <7ccc13efc69cb327a44908951d1de7cf4f8bd9a6.1591125127.git.mhelsley@vmware.com>
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

The mcount_adjust variable defines how many bytes to move back
from the relocation address in order to be able to get to the
start of the function call instruction(s) needed to turn it
into a no-op. The values are very small and signed so we don't
need to worry about changing the size of the variable's type
inside the wrapper -- we can just use a regular int.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 12 +++++++++---
 tools/objtool/recordmcount.h |  5 -----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 5ec44c9f2884..06a8f8ddefa7 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -385,6 +385,12 @@ static unsigned tot_relsize(unsigned int *rel_entsize)
 	}
 	return totrelsz;
 }
+
+/* zero or a small negative offset added to get the start of the call
+ * instruction
+ */
+static int mcount_adjust = 0;
+
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
@@ -495,7 +501,7 @@ static int do_file(char const *const fname)
 		rel_type_nop = R_386_NONE;
 		make_nop = make_nop_x86;
 		ideal_nop = ideal_nop5_x86_32;
-		mcount_adjust_32 = -1;
+		mcount_adjust = -1;
 		gpfx = 0;
 		break;
 	case EM_ARM:
@@ -524,7 +530,7 @@ static int do_file(char const *const fname)
 		ideal_nop = ideal_nop5_x86_64;
 		reltype = R_X86_64_64;
 		rel_type_nop = R_X86_64_NONE;
-		mcount_adjust_64 = -1;
+		mcount_adjust = -1;
 		gpfx = 0;
 		break;
 	}  /* end switch */
@@ -556,7 +562,7 @@ static int do_file(char const *const fname)
 		}
 		if (lf->ehdr.e_machine == EM_S390) {
 			reltype = R_390_64;
-			mcount_adjust_64 = -14;
+			mcount_adjust = -14;
 		}
 		if (lf->ehdr.e_machine == EM_MIPS) {
 			reltype = R_MIPS_64;
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index e2de71f99566..853c4006a34f 100644
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

