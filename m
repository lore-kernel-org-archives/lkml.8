Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9F9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CC22074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S9Srk3vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgCXUcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:32:47 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53661 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgCXUco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:32:44 -0400
Received: by mail-pj1-f65.google.com with SMTP id l36so42390pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3b1sjWFJGWk+HhbHvBn4evu301M7fqA/kMQ4pyC4tI=;
        b=S9Srk3vtm/u5AWxb5Lq0VLBe/+/+CUvcc/nWuriifzbcDxo3ZwBkLe8Zpl+BamGg/O
         HO1v1zWZwiU7plLhdxR37s1Jaqc0uJSA8G7tsY4VxqWCO/G2fiHTxNvERagnEIgId99M
         jOOdb0wJUrZaXGZR5SVzv7rR8cyPHnbBh6gDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3b1sjWFJGWk+HhbHvBn4evu301M7fqA/kMQ4pyC4tI=;
        b=p98dysPsoiLCWvINyGzqOXX0Qewt2H4rzTD7lkZ2VGDLBZctOE/UXPr28q2Yx7U+0W
         0xaamoA3mn6w8EEqI9A83oKfZqfodnnT3p8gWclCQUFWeSzEMvs+CspGjQE00lq7gl33
         q77ASfPM3IdmStItrHjPYPWVemxltqLhTGNTMmfn2q+twfdfFTIGxfmBaYqTavUJssD3
         ek1WHJMtfBLH71fjjD62hu+iJ5ozb5CPJf0+cGJe81TIHZsfdRs3LciBCx+RjoGKMx2w
         DSUPmuHX8BOQzD0jqn0rNq2EPHWuEpxHSL0F2PHJ9p9lTYMREmLD8/Ik7TzB3LNvv7l5
         tr9g==
X-Gm-Message-State: ANhLgQ1tWBlbsVnkyUJl8aM7SLaeuumrnIsz9q8/BIx730iKPQPM3Bio
        rYQeHeae6APmmDcRXWAL1y8emA==
X-Google-Smtp-Source: ADFU+vtXBHEgdg26RkMBmCkSMYW4AGLyko9MzjPWEETXma0en8jpa6fm5D16S9175yT7TTEUnSU+xQ==
X-Received: by 2002:a17:90a:1911:: with SMTP id 17mr205762pjg.65.1585081963230;
        Tue, 24 Mar 2020 13:32:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v26sm3813241pfn.51.2020.03.24.13.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 13:32:41 -0700 (PDT)
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
        "Perla, Enrico" <enrico.perla@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] arm64: entry: Enable random_kstack_offset support
Date:   Tue, 24 Mar 2020 13:32:31 -0700
Message-Id: <20200324203231.64324-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324203231.64324-1-keescook@chromium.org>
References: <20200324203231.64324-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow for a randomized stack offset on a per-syscall basis, with roughly
5 bits of entropy.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/kernel/syscall.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

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

