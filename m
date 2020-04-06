Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080D9C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8563206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SHvDMZKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgDFXQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:16:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38844 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgDFXQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:16:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id m17so792056pgj.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 16:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6T/7mkz2QJj1i6yBI9rf5y5UrGkfIoNdamdak5bIEr8=;
        b=SHvDMZKynQoupRAYdyzGP7833YCcGwM4Pjmu4hIlfgEi41IUoIMZIvMFkCimFNo1pC
         ukiFfjPKn6dwME2ko+g8mNG5D99lrZbhcV9idRFBRE7QuhQxO7LJZsbFMVIn38ydgfCG
         4qMfQRVb21FqPszfB/2JLkg9/aNX0WWnHNT0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6T/7mkz2QJj1i6yBI9rf5y5UrGkfIoNdamdak5bIEr8=;
        b=Jx2yq5aRe6XBwbR8+HCnSxEGE1kpyjGoZoUgHvFVihKOKDL6jL2HctEZpFLytmLD6k
         Ey610iRyZJ2CcMpq8GEKIZi//VZOk9e5MBpTQJeUBrx1o6Ki1ZycydvRWX/ggxjM7Qr5
         gMHdLjpahH1BW8V3/3pWWVXi8etVisKLKTxhQtgqfcE0Lk+ytgVYINmRzAm1c3L5HGQ1
         RWI3Jm/3EuZxG9UWNqXp9QjayqOWAhiY0tEq2cYVKeldM4IFKAJGXSkbW3NkwVk6yD9W
         NrGeQ5bk6xb2CdjMjhzBYL7/THGHV9WJJ8akQcZ1Dsv5nsUBtYkTVqqkyZ2+ywRfoLRi
         FQYA==
X-Gm-Message-State: AGi0PuYcOnHrkWS/Q+4/aBr9eEKigNS0KynhKZhhh5Zgd85G9SrIjzfo
        vXCvtLU1P++5bCBJbSs1BxfyQA==
X-Google-Smtp-Source: APiQypKPb2SK+P7H+McMjGGqVwR7DToHZCme/uHbB59Pjk0ShbX/p0nUYaBfdUBZDv7/4hnnvCIAMQ==
X-Received: by 2002:a62:d10b:: with SMTP id z11mr1732920pfg.205.1586214975509;
        Mon, 06 Apr 2020 16:16:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k20sm11602048pgn.62.2020.04.06.16.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 16:16:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] arm64: entry: Enable random_kstack_offset support
Date:   Mon,  6 Apr 2020 16:16:06 -0700
Message-Id: <20200406231606.37619-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406231606.37619-1-keescook@chromium.org>
References: <20200406231606.37619-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow for a randomized stack offset on a per-syscall basis, with roughly
5 bits of entropy.

In order to avoid unconditional stack canaries on syscall entry, also
downgrade from -fstack-protector-strong to -fstack-protector to avoid
triggering checks due to alloca(). Examining the resulting syscall.o,
sees no changes in canary coverage (none before, none now).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/kernel/Makefile  |  4 ++++
 arch/arm64/kernel/syscall.c | 10 ++++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0b30e884e088..4d5aa4959f72 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -127,6 +127,7 @@ config ARM64
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index fc6488660f64..b89005f125d6 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -11,6 +11,10 @@ CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
 
+# Downgrade to -fstack-protector to avoid triggering unneeded stack canary
+# checks due to randomize_kstack_offset.
+CFLAGS_syscall.o	+= $(subst -fstack-protector-strong,-fstack-protector,$(filter -fstack-protector-strong,$(KBUILD_CFLAGS)))
+
 # Object file lists.
 obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   entry-common.o entry-fpsimd.o process.o ptrace.o	\
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index a12c0c88d345..238dbd753b44 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -5,6 +5,7 @@
 #include <linux/errno.h>
 #include <linux/nospec.h>
 #include <linux/ptrace.h>
+#include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
 
 #include <asm/daifflags.h>
@@ -42,6 +43,8 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 {
 	long ret;
 
+	add_random_kstack_offset();
+
 	if (scno < sc_nr) {
 		syscall_fn_t syscall_fn;
 		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
@@ -51,6 +54,13 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 	}
 
 	regs->regs[0] = ret;
+
+	/*
+	 * Since the compiler chooses a 4 bit alignment for the stack,
+	 * let's save one additional bit (9 total), which gets us up
+	 * near 5 bits of entropy.
+	 */
+	choose_random_kstack_offset(get_random_int() & 0x1FF);
 }
 
 static inline bool has_syscall_work(unsigned long flags)
-- 
2.20.1

