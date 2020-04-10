Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78617C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5836220732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgDJTh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:37:56 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:28692 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgDJThy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:37:54 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:37:49 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id A39C5B2C87;
        Fri, 10 Apr 2020 15:37:53 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 18/36] objtool: mcount: Move is_fake_mcount()
Date:   Fri, 10 Apr 2020 12:35:41 -0700
Message-ID: <2ba56706710215ddbcc73d1b7cb4045c4e1a11a4.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Promote this now-bit-independent code out of the old
recordmcount ELF wrapper.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 48 +++++++++++++++++++++++++++++++---
 tools/objtool/recordmcount.h | 50 ------------------------------------
 2 files changed, 45 insertions(+), 53 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 91d14743218a..6c499fe86132 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -438,6 +438,48 @@ static unsigned get_mcountsym(struct rela *rela)
 	return 0;
 }
 
+/*
+ * MIPS mcount long call has 2 _mcount symbols, only the position of the 1st
+ * _mcount symbol is needed for dynamic function tracer, with it, to disable
+ * tracing(ftrace_make_nop), the instruction in the position is replaced with
+ * the "b label" instruction, to enable tracing(ftrace_make_call), replace the
+ * instruction back. So, here, we set the 2nd one as fake and filter it.
+ *
+ * c:	3c030000	lui	v1,0x0		<-->	b	label
+ *		c: R_MIPS_HI16	_mcount
+ *		c: R_MIPS_NONE	*ABS*
+ *		c: R_MIPS_NONE	*ABS*
+ * 10:	64630000	daddiu	v1,v1,0
+ *		10: R_MIPS_LO16	_mcount
+ *		10: R_MIPS_NONE	*ABS*
+ *		10: R_MIPS_NONE	*ABS*
+ * 14:	03e0082d	move	at,ra
+ * 18:	0060f809	jalr	v1
+ * label:
+ */
+#define MIPS_FAKEMCOUNT_OFFSET	4
+
+static int MIPS_is_fake_mcount(struct rela const *rela)
+{
+	unsigned long old_r_offset = ~0UL;
+	unsigned long current_r_offset = rela->offset;
+	int is_fake;
+
+	is_fake = (old_r_offset != ~0UL) &&
+		(current_r_offset - old_r_offset == MIPS_FAKEMCOUNT_OFFSET);
+	old_r_offset = current_r_offset;
+
+	return is_fake;
+}
+
+/* Functions and pointers that do_file() may override for specific e_machine. */
+static int fn_is_fake_mcount(struct rela const *rela)
+{
+	return 0;
+}
+
+static int (*is_fake_mcount)(struct rela const *rela) = fn_is_fake_mcount;
+
 static const unsigned int missing_sym = (unsigned int)-1;
 
 /* 32 bit and 64 bit are very similar */
@@ -557,7 +599,7 @@ static int do_file(char const *const fname)
 		altmcount = "__gnu_mcount_nc";
 		make_nop = make_nop_arm;
 		rel_type_nop = R_ARM_NONE;
-		is_fake_mcount32 = arm_is_fake_mcount;
+		is_fake_mcount = arm_is_fake_mcount;
 		gpfx = 0;
 		break;
 	case EM_AARCH64:
@@ -597,7 +639,7 @@ static int do_file(char const *const fname)
 		}
 		if (w2(ehdr->e_machine) == EM_MIPS) {
 			reltype = R_MIPS_32;
-			is_fake_mcount32 = MIPS32_is_fake_mcount;
+			is_fake_mcount = MIPS_is_fake_mcount;
 		}
 		if (do32(ehdr, reltype) < 0)
 			goto out;
@@ -617,7 +659,7 @@ static int do_file(char const *const fname)
 		if (w2(ghdr->e_machine) == EM_MIPS) {
 			reltype = R_MIPS_64;
 			Elf64_r_info = MIPS64_r_info;
-			is_fake_mcount64 = MIPS64_is_fake_mcount;
+			is_fake_mcount = MIPS_is_fake_mcount;
 		}
 		if (do64(ghdr, reltype) < 0)
 			goto out;
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index f99851034fa8..d61892597731 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -18,9 +18,6 @@
  * Copyright 2010 Steven Rostedt <srostedt@redhat.com>, Red Hat Inc.
  */
 #undef append_func
-#undef is_fake_mcount
-#undef fn_is_fake_mcount
-#undef MIPS_is_fake_mcount
 #undef mcount_adjust
 #undef sift_rel_mcount
 #undef nop_mcount
@@ -48,9 +45,6 @@
 # define has_rel_mcount		has64_rel_mcount
 # define tot_relsize		tot64_relsize
 # define do_func		do64
-# define is_fake_mcount		is_fake_mcount64
-# define fn_is_fake_mcount	fn_is_fake_mcount64
-# define MIPS_is_fake_mcount	MIPS64_is_fake_mcount
 # define mcount_adjust		mcount_adjust_64
 # define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
@@ -71,9 +65,6 @@
 # define has_rel_mcount		has32_rel_mcount
 # define tot_relsize		tot32_relsize
 # define do_func		do32
-# define is_fake_mcount		is_fake_mcount32
-# define fn_is_fake_mcount	fn_is_fake_mcount32
-# define MIPS_is_fake_mcount	MIPS32_is_fake_mcount
 # define mcount_adjust		mcount_adjust_32
 # define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
@@ -88,13 +79,6 @@
 # define _size			4
 #endif
 
-/* Functions and pointers that do_file() may override for specific e_machine. */
-static int fn_is_fake_mcount(struct rela const *rela)
-{
-	return 0;
-}
-static int (*is_fake_mcount)(struct rela const *rela) = fn_is_fake_mcount;
-
 static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
 {
 	rp->r_info = _w(ELF_R_INFO(sym, type));
@@ -103,40 +87,6 @@ static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_E
 
 static int mcount_adjust = 0;
 
-/*
- * MIPS mcount long call has 2 _mcount symbols, only the position of the 1st
- * _mcount symbol is needed for dynamic function tracer, with it, to disable
- * tracing(ftrace_make_nop), the instruction in the position is replaced with
- * the "b label" instruction, to enable tracing(ftrace_make_call), replace the
- * instruction back. So, here, we set the 2nd one as fake and filter it.
- *
- * c:	3c030000	lui	v1,0x0		<-->	b	label
- *		c: R_MIPS_HI16	_mcount
- *		c: R_MIPS_NONE	*ABS*
- *		c: R_MIPS_NONE	*ABS*
- * 10:	64630000	daddiu	v1,v1,0
- *		10: R_MIPS_LO16	_mcount
- *		10: R_MIPS_NONE	*ABS*
- *		10: R_MIPS_NONE	*ABS*
- * 14:	03e0082d	move	at,ra
- * 18:	0060f809	jalr	v1
- * label:
- */
-#define MIPS_FAKEMCOUNT_OFFSET	4
-
-static int MIPS_is_fake_mcount(struct rela const *rela)
-{
-	static unsigned long old_r_offset = ~0UL;
-	unsigned long current_r_offset = rela->offset;
-	int is_fake;
-
-	is_fake = (old_r_offset != ~0UL) &&
-		(current_r_offset - old_r_offset == MIPS_FAKEMCOUNT_OFFSET);
-	old_r_offset = current_r_offset;
-
-	return is_fake;
-}
-
 /* Append the new shstrtab, Elf_Shdr[], __mcount_loc and its relocations. */
 static int append_func(Elf_Ehdr *const ehdr,
 			Elf_Shdr *const shstr,
-- 
2.20.1

