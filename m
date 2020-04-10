Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31929C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B23A20732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgDJTl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:41:27 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36243 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgDJTlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:41:25 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:39:05 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 5E464B2D03;
        Fri, 10 Apr 2020 15:39:09 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 30/36] objtool: mcount: Move mcount_adjust out of wrapper
Date:   Fri, 10 Apr 2020 12:35:53 -0700
Message-ID: <531409b6dbb2df74056ba03269e311b8248ba7ae.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
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
index 5fdef8b2ac28..52d8d9800bf9 100644
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
index 353c7d082631..b4d3c55f2c9c 100644
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

