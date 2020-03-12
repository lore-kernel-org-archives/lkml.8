Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547AEC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2642071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vxvv/eNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgCLNwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:52:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46840 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgCLNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=V7Duu4tbcIT7Gqqhjc4VX+XUii17MaHeZ72gDmdRkTE=; b=vxvv/eNGqAMlrl8no5cVpLOTaa
        mZrBClebDALcyG8VHOMlcA0Ecuatoy/bNWmdzY5qJ2RyKkP8zshaAdZ46Iopg//S9NE7U7huVMKCd
        K+JUpMRR5/SdqoSK3pSt0FMWNckmBLspClqMUOEFZ/57G7js5qz3Bc809Fdkx0u6cxmu+oL2ERZff
        oof/9wGyHFuG34q2OuWCzBnuAAY/P9PyUVlK5cqMEm4mF9S02xEYkgeNrviIkcfoDnA6dWSiU3mZc
        UuMy4/bafcCDsO/DBoYzlvJ+dN873Z5tGum/znxZoPm5wlFyYJqmFbRkDXSv+GUgtxUgXrCFkpK83
        nm+zbdwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOFM-0003AQ-Nh; Thu, 12 Mar 2020 13:51:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27A49303C41;
        Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 14A382B740AE6; Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Message-Id: <20200312135041.641079164@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 12 Mar 2020 14:41:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 04/16] objtool: Annotate identity_mapped()
References: <20200312134107.700205216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally identity_mapped is not visible to objtool, due to:

  arch/x86/kernel/Makefile:OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o := y

However, when we want to run objtool on vmlinux.o there is no hiding
it. Without the annotation we'll get complaints about the:

	call 1f
1:	popq %rB

construct from the add_call_destinations() pass. Because
identity_mapped() is a SYM_CODE_START_LOCAL_NOALIGN() it is STT_NOTYPE
and we need sym_for_each_insn() to iterate the actual instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/relocate_kernel_64.S |    2 ++
 include/linux/frame.h                |   16 ++++++++++++++++
 tools/objtool/check.c                |    4 ++--
 3 files changed, 20 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -5,6 +5,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/frame.h>
 #include <asm/page_types.h>
 #include <asm/kexec.h>
 #include <asm/processor-flags.h>
@@ -210,6 +211,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_ma
 	pushq	%rax
 	ret
 SYM_CODE_END(identity_mapped)
+STACK_FRAME_NON_STANDARD(identity_mapped)
 
 SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	movq	RSP(%r8), %rsp
--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -3,6 +3,9 @@
 #define _LINUX_FRAME_H
 
 #ifdef CONFIG_STACK_VALIDATION
+
+#ifndef __ASSEMBLY__
+
 /*
  * This macro marks the given function's stack frame as "non-standard", which
  * tells objtool to ignore the function when doing stack metadata validation.
@@ -15,6 +18,19 @@
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func
 
+#else /* __ASSEMBLY__ */
+
+#define STACK_FRAME_NON_STANDARD(func) \
+	.pushsection .discard.func_stack_frame_non_standard, "aw"; \
+	.align 8; \
+	.type __func_stack_frame_non_standard_##func, @object; \
+	.size __func_stack_frame_non_standard_##func, 8; \
+__func_stack_frame_non_standard_##func: \
+	.quad func; \
+	.popsection
+
+#endif /* __ASSEMBLY */
+
 #else /* !CONFIG_STACK_VALIDATION */
 
 #define STACK_FRAME_NON_STANDARD(func)
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -416,7 +416,7 @@ static void add_ignores(struct objtool_f
 
 		case STT_SECTION:
 			func = find_symbol_by_offset(rela->sym->sec, rela->addend);
-			if (!func || func->type != STT_FUNC)
+			if (!func || (func->type != STT_FUNC && func->type != STT_NOTYPE))
 				continue;
 			break;
 
@@ -425,7 +425,7 @@ static void add_ignores(struct objtool_f
 			continue;
 		}
 
-		func_for_each_insn(file, func, insn)
+		sym_for_each_insn(file, func, insn)
 			insn->ignore = true;
 	}
 }


