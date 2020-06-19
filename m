Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B999DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD5B207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgFSIRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731290AbgFSIQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:16:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B1DC06174E;
        Fri, 19 Jun 2020 01:16:06 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmCBr-0003oh-UA; Fri, 19 Jun 2020 10:16:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 67AA51C0085;
        Fri, 19 Jun 2020 10:15:58 +0200 (CEST)
Date:   Fri, 19 Jun 2020 08:15:58 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix noinstr vs KCOV
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159255455812.16989.2009345164870958211.tip-bot2@tip-bot2>
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

Commit-ID:     0f1441b44e823a74f3f3780902a113e07c73fbf6
Gitweb:        https://git.kernel.org/tip/0f1441b44e823a74f3f3780902a113e07c73fbf6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 12 Jun 2020 16:05:26 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 18 Jun 2020 17:36:33 +02:00

objtool: Fix noinstr vs KCOV

Since many compilers cannot disable KCOV with a function attribute,
help it to NOP out any __sanitizer_cov_*() calls injected in noinstr
code.

This turns:

12:   e8 00 00 00 00          callq  17 <lockdep_hardirqs_on+0x17>
		13: R_X86_64_PLT32      __sanitizer_cov_trace_pc-0x4

into:

12:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
		13: R_X86_64_NONE      __sanitizer_cov_trace_pc-0x4

Just like recordmcount does.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
 arch/x86/Kconfig                          |  2 +-
 tools/objtool/arch.h                      |  2 ++
 tools/objtool/arch/x86/decode.c           | 18 ++++++++++++++++++
 tools/objtool/arch/x86/include/arch_elf.h |  6 ++++++
 tools/objtool/check.c                     | 19 +++++++++++++++++++
 5 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 tools/objtool/arch/x86/include/arch_elf.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6a0cc52..883da0a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -67,7 +67,7 @@ config X86
 	select ARCH_HAS_FILTER_PGPROT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
-	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_KCOV			if X86_64 && STACK_VALIDATION
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index eda15a5..3c59677 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -84,4 +84,6 @@ unsigned long arch_jump_destination(struct instruction *insn);
 
 unsigned long arch_dest_rela_offset(int addend);
 
+const char *arch_nop_insn(int len);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 4b504fc..9872195 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -565,3 +565,21 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
 	state->regs[16].base = CFI_CFA;
 	state->regs[16].offset = -8;
 }
+
+const char *arch_nop_insn(int len)
+{
+	static const char nops[5][5] = {
+		/* 1 */ { 0x90 },
+		/* 2 */ { 0x66, 0x90 },
+		/* 3 */ { 0x0f, 0x1f, 0x00 },
+		/* 4 */ { 0x0f, 0x1f, 0x40, 0x00 },
+		/* 5 */ { 0x0f, 0x1f, 0x44, 0x00, 0x00 },
+	};
+
+	if (len < 1 || len > 5) {
+		WARN("invalid NOP size: %d\n", len);
+		return NULL;
+	}
+
+	return nops[len-1];
+}
diff --git a/tools/objtool/arch/x86/include/arch_elf.h b/tools/objtool/arch/x86/include/arch_elf.h
new file mode 100644
index 0000000..69cc426
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch_elf.h
@@ -0,0 +1,6 @@
+#ifndef _OBJTOOL_ARCH_ELF
+#define _OBJTOOL_ARCH_ELF
+
+#define R_NONE R_X86_64_NONE
+
+#endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 91a67db..478267a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -12,6 +12,7 @@
 #include "check.h"
 #include "special.h"
 #include "warn.h"
+#include "arch_elf.h"
 
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
@@ -766,6 +767,24 @@ static int add_call_destinations(struct objtool_file *file)
 			insn->call_dest = rela->sym;
 
 		/*
+		 * Many compilers cannot disable KCOV with a function attribute
+		 * so they need a little help, NOP out any KCOV calls from noinstr
+		 * text.
+		 */
+		if (insn->sec->noinstr &&
+		    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
+			if (rela) {
+				rela->type = R_NONE;
+				elf_write_rela(file->elf, rela);
+			}
+
+			elf_write_insn(file->elf, insn->sec,
+				       insn->offset, insn->len,
+				       arch_nop_insn(insn->len));
+			insn->type = INSN_NOP;
+		}
+
+		/*
 		 * Whatever stack impact regular CALLs have, should be undone
 		 * by the RETURN of the called function.
 		 *
