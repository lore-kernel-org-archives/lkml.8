Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B23C54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405BB20735
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T/YXNFJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgCXUcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:32:42 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56030 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgCXUcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:32:41 -0400
Received: by mail-pj1-f66.google.com with SMTP id mj6so36622pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tXxslwRt84lo46s4AfUIy0jwZL6qW/F8aLPlGo+Vuzs=;
        b=T/YXNFJYjvxaejU1cNn6KiZWcTChX5JBh8J6KYpqLsCb4Zi/vVIMOgsSl+o1HY1WJ2
         vWHAi9J3xlxnvLtkfEmpWoe/DsoFGZbmYUNMbqksBmf+pmqHgLFCCUoxSz+q/p2uCZ5s
         HUkzy9HRyx5OmeeEAodSW6aIsMJPc3Pvav6+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXxslwRt84lo46s4AfUIy0jwZL6qW/F8aLPlGo+Vuzs=;
        b=n2r8HBP0TeLZsM3jXtbgcGNr2GQOhCSFxy4x4/FUt/oKeSrmcrKqi0LLAZfrGGDH7P
         kPvCBJwnBTFEOxCegdTghotT/mIPQLoBiO45HWRQodByFk4Q+EWHNNAlxcWfJvQ6TUnL
         iqLyor58xPgFOaCA4rcVcbb2/FZsWyatSnSBBfvtxR4qUz++7P4BMtGiuoUtojihuv3V
         lMeYRQA/u5t3vFHNVzkFYl+haxv/j7PgCfw+xPBt5NwP235t/S3OulA3wyHnQuQVsia6
         W/RVei8kZQu93WiENB1PC9lnd2pa6NMgsGS3Fb8UthuC52EBwGUHOaxVLkvcOwk3RoRh
         ZjfQ==
X-Gm-Message-State: ANhLgQ2ljwSDsQzNctoYH9cteFqQaXeHccbFIzOKpK9jjqaBq1NJW1oD
        +wwTBHxhO/4GAb0YO+Vbag2NDw==
X-Google-Smtp-Source: ADFU+vuPz1pOMJKdmnm1JY1Cd9NWe+ToQ10sdatj73bSqAyNgc+HS1jzGaTvvHVtjKzMIO9M2dV0uA==
X-Received: by 2002:a17:902:8bc8:: with SMTP id r8mr27618425plo.48.1585081958998;
        Tue, 24 Mar 2020 13:32:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 135sm17497623pfu.207.2020.03.24.13.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 13:32:37 -0700 (PDT)
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
Subject: [PATCH v2 4/5] x86/entry: Enable random_kstack_offset support
Date:   Tue, 24 Mar 2020 13:32:30 -0700
Message-Id: <20200324203231.64324-5-keescook@chromium.org>
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
 arch/x86/Kconfig        |  1 +
 arch/x86/entry/common.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea77046f9b..b9d449581eb6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -150,6 +150,7 @@ config X86
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_VMAP_STACK		if X86_64
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CMPXCHG_DOUBLE
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 9747876980b5..086d7af570af 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -26,6 +26,7 @@
 #include <linux/livepatch.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/randomize_kstack.h>
 
 #include <asm/desc.h>
 #include <asm/traps.h>
@@ -189,6 +190,13 @@ __visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 
+	/*
+	 * x86_64 stack alignment means 3 bits are ignored, so keep
+	 * the top 5 bits. x86_32 needs only 2 bits of alignment, so
+	 * the top 6 bits will be used.
+	 */
+	choose_random_kstack_offset(rdtsc() & 0xFF);
+
 	cached_flags = READ_ONCE(ti->flags);
 
 	if (unlikely(cached_flags & EXIT_TO_USERMODE_LOOP_FLAGS))
@@ -283,6 +291,7 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 	struct thread_info *ti;
 
+	add_random_kstack_offset();
 	enter_from_user_mode();
 	local_irq_enable();
 	ti = current_thread_info();
@@ -355,6 +364,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 /* Handles int $0x80 */
 __visible void do_int80_syscall_32(struct pt_regs *regs)
 {
+	add_random_kstack_offset();
 	enter_from_user_mode();
 	local_irq_enable();
 	do_syscall_32_irqs_on(regs);
@@ -378,8 +388,8 @@ __visible long do_fast_syscall_32(struct pt_regs *regs)
 	 */
 	regs->ip = landing_pad;
 
+	add_random_kstack_offset();
 	enter_from_user_mode();
-
 	local_irq_enable();
 
 	/* Fetch EBP from where the vDSO stashed it. */
-- 
2.20.1

