Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735BEC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D902222B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgDVWZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726754AbgDVWZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:25:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0FCC03C1AA;
        Wed, 22 Apr 2020 15:25:10 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnZ-0001Tl-OO; Thu, 23 Apr 2020 00:24:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D65A41C0493;
        Thu, 23 Apr 2020 00:24:48 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:48 -0000
From:   "tip-bot2 for Raphael Gault" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add abstraction for destination offsets
Cc:     Raphael Gault <raphael.gault@arm.com>,
        Julien Thierry <jthierry@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158759428821.28353.9131050862154620704.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e491242d03109dd911ab3b74bd4782ea35e4e75e
Gitweb:        https://git.kernel.org/tip/e491242d03109dd911ab3b74bd4782ea35e4e75e
Author:        Raphael Gault <raphael.gault@arm.com>
AuthorDate:    Fri, 27 Mar 2020 15:28:45 
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 14 Apr 2020 10:39:25 -05:00

objtool: Add abstraction for destination offsets

The jump and call destination relocation offsets are x86-specific.
Abstract them by calling arch-specific implementations.

[ jthierry: Remove superfluous comment; replace other addend offsets
      	    with arch_dest_rela_offset() ]

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/arch.h            |  6 ++++++
 tools/objtool/arch/x86/decode.c | 11 +++++++++++
 tools/objtool/check.c           | 18 ++++++++++--------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index ced3765..a9a50a2 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -66,6 +66,8 @@ struct stack_op {
 	struct op_src src;
 };
 
+struct instruction;
+
 void arch_initial_func_cfi_state(struct cfi_state *state);
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
@@ -75,4 +77,8 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 bool arch_callee_saved_reg(unsigned char reg);
 
+unsigned long arch_jump_destination(struct instruction *insn);
+
+unsigned long arch_dest_rela_offset(int addend);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index a62e032..7ce8650 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -11,6 +11,7 @@
 #include "../../../arch/x86/lib/inat.c"
 #include "../../../arch/x86/lib/insn.c"
 
+#include "../../check.h"
 #include "../../elf.h"
 #include "../../arch.h"
 #include "../../warn.h"
@@ -66,6 +67,16 @@ bool arch_callee_saved_reg(unsigned char reg)
 	}
 }
 
+unsigned long arch_dest_rela_offset(int addend)
+{
+	return addend + 4;
+}
+
+unsigned long arch_jump_destination(struct instruction *insn)
+{
+	return insn->offset + insn->len + insn->immediate;
+}
+
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5044f4c..10fbfb3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -592,13 +592,14 @@ static int add_jump_destinations(struct objtool_file *file)
 					       insn->offset, insn->len);
 		if (!rela) {
 			dest_sec = insn->sec;
-			dest_off = insn->offset + insn->len + insn->immediate;
+			dest_off = arch_jump_destination(insn);
 		} else if (rela->sym->type == STT_SECTION) {
 			dest_sec = rela->sym->sec;
-			dest_off = rela->addend + 4;
+			dest_off = arch_dest_rela_offset(rela->addend);
 		} else if (rela->sym->sec->idx) {
 			dest_sec = rela->sym->sec;
-			dest_off = rela->sym->sym.st_value + rela->addend + 4;
+			dest_off = rela->sym->sym.st_value +
+				   arch_dest_rela_offset(rela->addend);
 		} else if (strstr(rela->sym->name, "_indirect_thunk_")) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
@@ -688,7 +689,7 @@ static int add_call_destinations(struct objtool_file *file)
 		rela = find_rela_by_dest_range(file->elf, insn->sec,
 					       insn->offset, insn->len);
 		if (!rela) {
-			dest_off = insn->offset + insn->len + insn->immediate;
+			dest_off = arch_jump_destination(insn);
 			insn->call_dest = find_func_by_offset(insn->sec, dest_off);
 			if (!insn->call_dest)
 				insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
@@ -711,13 +712,14 @@ static int add_call_destinations(struct objtool_file *file)
 			}
 
 		} else if (rela->sym->type == STT_SECTION) {
+			dest_off = arch_dest_rela_offset(rela->addend);
 			insn->call_dest = find_func_by_offset(rela->sym->sec,
-							      rela->addend+4);
+							      dest_off);
 			if (!insn->call_dest) {
-				WARN_FUNC("can't find call dest symbol at %s+0x%x",
+				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
 					  rela->sym->sec->name,
-					  rela->addend + 4);
+					  dest_off);
 				return -1;
 			}
 		} else
@@ -828,7 +830,7 @@ static int handle_group_alt(struct objtool_file *file,
 		if (!insn->immediate)
 			continue;
 
-		dest_off = insn->offset + insn->len + insn->immediate;
+		dest_off = arch_jump_destination(insn);
 		if (dest_off == special_alt->new_off + special_alt->new_len) {
 			if (!fake_jump) {
 				WARN("%s: alternative jump to end of section",
