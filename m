Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D292C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0B42083B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BKy23l2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgFVTcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbgFVTbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:31:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682E5C061796
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:31:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s23so8851327pfh.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcPQ3teAeONtZCSjASMvWQH+0FGked91D84DWb3cnhA=;
        b=BKy23l2w1m43ZpBXQM2fDRryt6KkrHZIrILWSDueLTLg7JkO/xXIBdrpxBtpXqG8Eo
         C+whcf+rw091oqysj+R7yNmqCI48ZtM7rhgZGnobI7SE5xNIel15JCPoNXr8RLA/8gKA
         FUXw0i2C4M8kbA9Vh9+15Qvp6mVOpj0mucLag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcPQ3teAeONtZCSjASMvWQH+0FGked91D84DWb3cnhA=;
        b=H9GdzCUVjuD1c6aqOXBe0Y2/wZiQ/7fVR+oEAAu7njT84sL5NALFKZkca6C0sJ4Jf3
         VvuHA3PpjG/u85RcgUGbHl8VlEDkF68cBTubIdx/wxdqIuCON3/ZtjZlX5LCZZyaM22W
         KaBL+5SP25RanBOynSFsxE+ninS8fzekx8pW2LvktnFsr/xM6KpngNmqOkvMtIdbM6eD
         ksOHcKgCdl+2JNpG8E/0zXbWw3adeha6UJTEwEb2LtdHmlIl986jh4t0GQhKfzb/YE/Z
         /RLl3kA8g4FmkUJrM3B5K+h0qCjt6erJbyrrM+V9D4s1lB+v1jh/07KaUYGOVDvAu2Ot
         wedg==
X-Gm-Message-State: AOAM5318VZ0+UM7DL2eVfWQ2dasDYMDkK1Fk+cm/t6kefnmTqy4ShCqP
        qV2nyRsTipr9tAA7iEpyCA2vPA==
X-Google-Smtp-Source: ABdhPJwITrbj7E83VXsf9fWrxu//1aHMGodlvPkjapka8zNgM+eZ+A/1KAwdust7T+yhFUZyNvTBXw==
X-Received: by 2002:a63:3f42:: with SMTP id m63mr14501829pga.310.1592854314990;
        Mon, 22 Jun 2020 12:31:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n189sm14916252pfn.108.2020.06.22.12.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:31:54 -0700 (PDT)
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
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] arm64: entry: Enable random_kstack_offset support
Date:   Mon, 22 Jun 2020 12:31:46 -0700
Message-Id: <20200622193146.2985288-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622193146.2985288-1-keescook@chromium.org>
References: <20200622193146.2985288-1-keescook@chromium.org>
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
 arch/arm64/kernel/Makefile  |  5 +++++
 arch/arm64/kernel/syscall.c | 10 ++++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4a094bedcb2..2902e5316e1a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -135,6 +135,7 @@ config ARM64
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 151f28521f1e..39fc23d3770b 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -11,6 +11,11 @@ CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
 
+# Downgrade to -fstack-protector to avoid triggering unneeded stack canary
+# checks due to randomize_kstack_offset.
+CFLAGS_REMOVE_syscall.o += -fstack-protector-strong
+CFLAGS_syscall.o	+= $(subst -fstack-protector-strong,-fstack-protector,$(filter -fstack-protector-strong,$(KBUILD_CFLAGS)))
+
 # Object file lists.
 obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   entry-common.o entry-fpsimd.o process.o ptrace.o	\
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 5f5b868292f5..00d3c84db9cd 100644
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
2.25.1

