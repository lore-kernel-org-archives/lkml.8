Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D848C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF092072F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlnOhmUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDFBJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 21:09:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39046 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFBJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 21:09:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id k15so6761095pfh.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 18:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8k07XNenfR4dUzD3PNZZK1ZOVaoBC/tsDFFRckZPngg=;
        b=jlnOhmUVEJrA+FMZOqNWuh9/YSiOwPQntCMWtsso2gXQNhlnMDQnKjno1FV9AutlzG
         D36jfcLVHc2Rp6Iy/AS08Snfy+60e8yQapAFq/wVZpGN5iHD8RIQ4dj6eoYo15pL2E6C
         Xs2JAzOrEYSAB7omYN37ir8Oj/qgayqgQO0Kyr0pDGk1FRJpn4Bgo9q0m0y5nKHqQx6R
         U0S3AIxyUvY67jFXd9lEEi+86H3y547gWZWstxObw4FZVs2uE1KSYevWAJvmY2lLRXDe
         +Z8BSB7DS0zgPD2pngc70Tss5LIw0OvwGTj5ZfbqBrN7IiK8fdjXdonqcCHatK4IrEGJ
         gGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8k07XNenfR4dUzD3PNZZK1ZOVaoBC/tsDFFRckZPngg=;
        b=L2A3qc23zSXXo9MhJ1qWV7rF7U3ydEh/oeCSk3YVFsT5DRYYVxSEhrC9aAbB/T2sWF
         Qt8ICMK+UHSMhsq3PFft0d3JHbWUUezCgnDwXdRZcY7PdNAgzszqJgVgqe+zlxDuIE/x
         rmgVm89eOL3qmaBZgV+YuB+oUworWtmyE1pCBigKjPlqRg87EAca9l5PRlIfCxJp3aAP
         m9xg2EVjED2i6eblTbObFKqjxVI9fEqS1EpYenTFDUJ5qfDuU+zckZGMjVexF0IYvu9e
         Lr8oXLOBMkVUKlmTOYhA1+pp9AJT7q9/Kcw929BrGcaFwL3lAai2j1oQn1naAAujbNNJ
         9d2w==
X-Gm-Message-State: AGi0PuZTkeatHUgD38wacZSnNf1NaQl8btOCTz1TCn2Tf1ebqG4OXIyR
        rHHLffYleNB17lo3wKPpJ97nPA==
X-Google-Smtp-Source: APiQypKjtcmEqg9g+RU+8rt/l6Zfks1lKNlKCGYLoNckYqL4Wk18fQNJd0fBhMBFsPtQ3M8P0wNV1w==
X-Received: by 2002:a63:3d06:: with SMTP id k6mr18392081pga.418.1586135343242;
        Sun, 05 Apr 2020 18:09:03 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id w9sm10425442pfd.94.2020.04.05.18.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 18:09:02 -0700 (PDT)
Date:   Sun, 5 Apr 2020 18:08:59 -0700
From:   Fangrui Song <maskray@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        clang-built-linux@googlegroups.com
Subject: Re: [RESEND][PATCH v3 09/17] x86/static_call: Add out-of-line static
 call implementation
Message-ID: <20200406010859.bcfouhukcgmg2on7@google.com>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.819003994@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200324142245.819003994@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-24, Peter Zijlstra wrote:
>Add the x86 out-of-line static call implementation.  For each key, a
>permanent trampoline is created which is the destination for all static
>calls for the given key.  The trampoline has a direct jump which gets
>patched by static_call_update() when the destination function changes.
>
>Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>[peterz: fixed trampoline, rewrote patching code]
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>---
> arch/x86/Kconfig                   |    1 +
> arch/x86/include/asm/static_call.h |   22 ++++++++++++++++++++++
> arch/x86/kernel/Makefile           |    1 +
> arch/x86/kernel/static_call.c      |   31 +++++++++++++++++++++++++++++++
> 4 files changed, 55 insertions(+)
> create mode 100644 arch/x86/include/asm/static_call.h
> create mode 100644 arch/x86/kernel/static_call.c
>
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -205,6 +205,7 @@ config X86
> 	select HAVE_FUNCTION_ARG_ACCESS_API
> 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
> 	select HAVE_STACK_VALIDATION		if X86_64
>+	select HAVE_STATIC_CALL
> 	select HAVE_RSEQ
> 	select HAVE_SYSCALL_TRACEPOINTS
> 	select HAVE_UNSTABLE_SCHED_CLOCK
>--- /dev/null
>+++ b/arch/x86/include/asm/static_call.h
>@@ -0,0 +1,22 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+#ifndef _ASM_STATIC_CALL_H
>+#define _ASM_STATIC_CALL_H
>+
>+#include <asm/text-patching.h>
>+
>+/*
>+ * For CONFIG_HAVE_STATIC_CALL, this is a permanent trampoline which
>+ * does a direct jump to the function.  The direct jump gets patched by
>+ * static_call_update().
>+ */
>+#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
>+	asm(".pushsection .text, \"ax\"				\n"	\
>+	    ".align 4						\n"	\
>+	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
>+	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
>+	    "	jmp.d32 " #func "				\n"	\
>+	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
>+	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
>+	    ".popsection					\n")
>+
>+#endif /* _ASM_STATIC_CALL_H */

Hi Peter,

Coming here from https://github.com/ClangBuiltLinux/linux/issues/974

jmp.d32 is not recognized by clang integrated assembler.
The syntax appears to be very rarely used. According to Debian Code Search,
u-boot is the only project using this syntax.

In March 2017, gas added the pseudo prefix {disp32}
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=86fa6981e7487e2c2df4337aa75ed2d93c32eaf2
which generalizes jmp.d32  ({disp32} jmp foo)

I wonder whether the instruction jmp.d32 can be replaced with the trick in
arch/x86/include/asm/jump_label.h for clang portability.

% grep -A2 'jmp.d32' arch/x86/include/asm/jump_label.h
         /* Equivalent to "jmp.d32 \target" */
         .byte           0xe9
         .long           \target - .Lstatic_jump_after_\@
...

+ clang-built-linux@googlegroups.com
