Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E0AC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC494205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfWmmWWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgD0QAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728517AbgD0QAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:00:46 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B04C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:46 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a18so18789662qkl.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aDem5II6XtVFnIoK0CnL/HzpdSNcG3sRMln2VgftrwU=;
        b=ZfWmmWWeg8Xv5CC2meB1osNUPG8RstNTWpr4cI8ESrfdKMVwQ7dxJXztTGQFimsM+Q
         CNvseJXVkYZoisMem4nRmxocSgBUZWRX2WM22kEjc8yGFWBw+H2CgMCAGJRvh5nA4tpL
         psKwxJzZBPKnH8RZhpmunbTEeHw7mqoGl1Chyd7YQFp1F8NuL79hZl5YpbN3INQoxV+B
         bs2zi3POqfqPXq6HRcKeb0fQ5M+8KRlgMPb3DVTPJden1T0c6jIaMjOnnX/iCef8UIHH
         0wTi0R/2zRQc9P2Tgoryc+izyibMdoy6SFeJchSyHM1zbcKBR0WBctCIMUrRhaOOp1KA
         baSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aDem5II6XtVFnIoK0CnL/HzpdSNcG3sRMln2VgftrwU=;
        b=IeNa4+Ah1UzyTYGKobibE1zbYgX6HA+hviFlgEYTwjHieXGXhEPjFsDG1LG4h5Rj3t
         QMgUqoF7Sxygs/UIAvKnb9lFnPEVQVpSUWTnQFOGBwW32/AoxrQk7S/4LQwLSUy2Z5Y5
         cEos1srZulpFDkmCnh1ewXSc6C4ugKdbRoIFHvrDTljPXboLYnKY5vKSNBW49jQq6Gxw
         8LcD5s9fVFtg1GquMP9aLbswcTmnLucJSIKdoAiJVjIG8Sjgzxna7g4566yanoR76CDr
         Vqn/JXG/RQ06g0A3rZIPVkPf3CQwdVQm20ISP12UxGL41uthYckJ9h+uoBBGJSXAYSwq
         sciQ==
X-Gm-Message-State: AGi0PuYrQZClHYdQ2dzq+9CsL6scEQhWRyT5V6NbwfLtPihEAWR66D98
        w0mnZhNa7pYKi9ib7WkKW2Uj0bfhoAzIHfvVe20=
X-Google-Smtp-Source: APiQypJO4M2N3eKFmynDymgRKzs8tsPGJgj0wNazOuUIlfBTsE5WgPC/94hr99zCwp1irzlSc77dDJj+XxgS7YX4+qA=
X-Received: by 2002:a0c:8262:: with SMTP id h89mr21907606qva.173.1588003245161;
 Mon, 27 Apr 2020 09:00:45 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:00:12 -0700
In-Reply-To: <20200427160018.243569-1-samitolvanen@google.com>
Message-Id: <20200427160018.243569-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200427160018.243569-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 06/12] arm64: preserve x18 when CPU is suspended
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't lose the current task's shadow stack when the CPU is suspended.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/suspend.h |  2 +-
 arch/arm64/mm/proc.S             | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 8939c87c4dce..0cde2f473971 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-#define NR_CTX_REGS 12
+#define NR_CTX_REGS 13
 #define NR_CALLEE_SAVED_REGS 12
 
 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 197a9ba2d5ea..ed15be0f8103 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -58,6 +58,8 @@
  * cpu_do_suspend - save CPU registers context
  *
  * x0: virtual address of context pointer
+ *
+ * This must be kept in sync with struct cpu_suspend_ctx in <asm/suspend.h>.
  */
 SYM_FUNC_START(cpu_do_suspend)
 	mrs	x2, tpidr_el0
@@ -82,6 +84,11 @@ alternative_endif
 	stp	x8, x9, [x0, #48]
 	stp	x10, x11, [x0, #64]
 	stp	x12, x13, [x0, #80]
+	/*
+	 * Save x18 as it may be used as a platform register, e.g. by shadow
+	 * call stack.
+	 */
+	str	x18, [x0, #96]
 	ret
 SYM_FUNC_END(cpu_do_suspend)
 
@@ -98,6 +105,13 @@ SYM_FUNC_START(cpu_do_resume)
 	ldp	x9, x10, [x0, #48]
 	ldp	x11, x12, [x0, #64]
 	ldp	x13, x14, [x0, #80]
+	/*
+	 * Restore x18, as it may be used as a platform register, and clear
+	 * the buffer to minimize the risk of exposure when used for shadow
+	 * call stack.
+	 */
+	ldr	x18, [x0, #96]
+	str	xzr, [x0, #96]
 	msr	tpidr_el0, x2
 	msr	tpidrro_el0, x3
 	msr	contextidr_el1, x4
-- 
2.26.2.303.gf8c07b1a785-goog

