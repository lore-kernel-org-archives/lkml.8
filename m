Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58D6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCB0206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m7dUqlsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFLOhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgFLOhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:37:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AF4C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=tr0PHMWQDKASoKKJIXhHrp4k0+3m9wdOXqJFrwxEy6w=; b=m7dUqlsLdWPj6NFEZfD5d1/Rd3
        Tlll3lUpiZGZxF8hgawXhytv2+kQjDA5UPIBpi1ouXmIjmRMskY+qsg7uLX7j8LSLMi2XaMFy+gwG
        a6bOoG7elz6CGMuRbRHrOhpgdJIJhrxTEsolDt34GmNXDBffN1A+ToB0GunvRz9GmQ3RpxhWNEyGX
        vsmqM4CFADfKccySgpmN8mMoMTkiDMksXLxS7T43d3AynTGZSkj4Zih6wkqvFZEHTmWLBWYjMJQ9/
        dtPxahH/y75c5A1AmXsXIrAFiyQGRKSRUBeFP0V2JnQ2QGgP/xXfO9dxwd7g7QMgGSCslwO9mEIkc
        pUgPzoOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjkoI-0006uc-6M; Fri, 12 Jun 2020 14:37:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC7CD301AC6;
        Fri, 12 Jun 2020 16:37:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CBA7C2389EBA3; Fri, 12 Jun 2020 16:37:31 +0200 (CEST)
Message-ID: <20200612143554.071314718@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Jun 2020 16:30:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, dvyukov@google.com,
        elver@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        mhelsley@vmware.com, rostedt@goodmis.org, jthierry@redhat.com,
        mbenes@suse.cz, peterz@infradead.org
Subject: [RFC][PATCH 3/3] objtool: Fix noinstr vs KCOV
References: <20200612143034.933422660@infradead.org>
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
---
 tools/objtool/arch.h                      |    2 ++
 tools/objtool/arch/x86/decode.c           |   18 ++++++++++++++++++
 tools/objtool/arch/x86/include/arch_elf.h |    6 ++++++
 tools/objtool/check.c                     |   19 +++++++++++++++++++
 4 files changed, 45 insertions(+)

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
@@ -744,6 +745,24 @@ static int add_call_destinations(struct
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


