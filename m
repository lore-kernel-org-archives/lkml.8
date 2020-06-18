Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAA7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7FA20739
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yiTy7Kej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgFROvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731147AbgFROvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:51:02 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D7AC061794
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LlO2L2kUQGE6/JpAU+yId4GuI9JpU81K+hK06JLWY8o=; b=yiTy7KejA5PJLEgSdr6gtegcsA
        g+iZdhiJWbFpolplz1sFRgMDjyjmdT8sqZSeqDSDsAgv73TTtQyut2qGOOFVACkCsivRVdGgKZgQn
        qBv3tAlBqOgqGYncUmxFP6J5Sp/HulV7z5QdllEY1Nh0uJuOhETPBwKFWH+4edwO+9VzuLbQ3cb9A
        nDN3X6j4CE7Y4YmPtUtgU6RtmJwQeyrSkSHi8U7jfR0sU3I9EMbaHh7HOPYr/6nESafTf2ThnWtaI
        ucXlUS8+nna0bFgSr54q33rHu2d4uItm6Zu7wPeTDQ709MXBxxKGrRrW6USg1QvlPfdRVcYPQtNzL
        KORzg/ng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlvsB-0006Hq-GA; Thu, 18 Jun 2020 14:50:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68DA130775A;
        Thu, 18 Jun 2020 16:50:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 350442146C406; Thu, 18 Jun 2020 16:50:32 +0200 (CEST)
Message-ID: <20200618144801.995733773@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Jun 2020 16:44:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, dvyukov@google.com,
        elver@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        mhelsley@vmware.com, rostedt@goodmis.org, jthierry@redhat.com,
        mbenes@suse.cz, peterz@infradead.org
Subject: [PATCH 7/7] objtool: Fix noinstr vs KCOV
References: <20200618144407.520952071@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 arch/x86/Kconfig                          |    2 +-
 tools/objtool/arch.h                      |    2 ++
 tools/objtool/arch/x86/decode.c           |   18 ++++++++++++++++++
 tools/objtool/arch/x86/include/arch_elf.h |    6 ++++++
 tools/objtool/check.c                     |   19 +++++++++++++++++++
 5 files changed, 46 insertions(+), 1 deletion(-)

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
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -84,4 +84,6 @@ unsigned long arch_jump_destination(stru
 
 unsigned long arch_dest_reloc_offset(int addend);
 
+const char *arch_nop_insn(int len);
+
 #endif /* _ARCH_H */
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -565,3 +565,21 @@ void arch_initial_func_cfi_state(struct
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
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch_elf.h
@@ -0,0 +1,6 @@
+#ifndef _OBJTOOL_ARCH_ELF
+#define _OBJTOOL_ARCH_ELF
+
+#define R_NONE R_X86_64_NONE
+
+#endif /* _OBJTOOL_ARCH_ELF */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -12,6 +12,7 @@
 #include "check.h"
 #include "special.h"
 #include "warn.h"
+#include "arch_elf.h"
 
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
@@ -766,6 +767,24 @@ static int add_call_destinations(struct
 			insn->call_dest = reloc->sym;
 
 		/*
+		 * Many compilers cannot disable KCOV with a function attribute
+		 * so they need a little help, NOP out any KCOV calls from noinstr
+		 * text.
+		 */
+		if (insn->sec->noinstr &&
+		    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
+			if (reloc) {
+				reloc->type = R_NONE;
+				elf_write_reloc(file->elf, reloc);
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


