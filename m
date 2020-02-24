Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C6DC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4972084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGqS8P+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgBXSSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:18:23 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:32807 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgBXSSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:18:16 -0500
Received: by mail-yb1-f195.google.com with SMTP id w190so5102646ybc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 10:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TqWUOLCvaVuyRcwhiqpGEkws0d4f425GHhOkrc0uq4=;
        b=KGqS8P+/bMNvz82HBDQlxzwRFzUklgltenDApftqITPInO257gydfi/bW+guufuTLy
         +ZGTYcvfcVvb0VDmJc0Ze3LaVRBdMpuBKDJwc7WMJR/I6HAQ1ae7AebvVwlPq4x4oB3m
         uPFutv+GxKlbaqzCzYRCVCK5iCr/rKX743NCQbX/rdaYImRnohZYmg1VksYOOx347QKH
         NyKTYhksdJl239BabsM+8RUZa4Kt4LGVAk5Uz+63otDfv7lJhFzMFCEZohFzB2sfpSJh
         4ZQ8CNJqc6GBFY/7xAy39KBQiQIV8LZxKsJkNhvWIV14SOP1YERYQ5rpuND29Br5WsyS
         GVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TqWUOLCvaVuyRcwhiqpGEkws0d4f425GHhOkrc0uq4=;
        b=Ru7tmw1xfGxW5hFFUIr2wy1IXCLHW4qRPxSd7rF320n9BgZZ9Jc6cPSbQ9wB12sJgT
         23FA28YWpyf16EKq5DIFrIY1Ud1AM2cku69ZCbxpRVSuN2eokz2rOhPJB1pMoQ9MUdA3
         gIZ5FJJFvK0OuBJEzj0pvafH4dGL/nuk6Y8XbZp/xxFn3axSs73Ru6Kmv09A9Vjwl/A7
         SIoLYvFa5fSBv5oiWarrPZX1nXOBPeIE/n+3WItxJU9xBpiaJ6rYHr+AHyKILUPJ+Fgd
         eJ8uDqUewzqB+M0LqMTUlNH6sAUr8LRYiBwAC4zyKzGXeV5OEnqdPxcxrKGnUQbBIDHN
         8eRQ==
X-Gm-Message-State: APjAAAWX3zKxR/o+X3n44gfjppFmgFW99VPvilxt7Z628S4PCzfNuHt/
        wnKcVwvHTbn/UEIS6JoXc+aNwOU=
X-Google-Smtp-Source: APXvYqyNP2DmpIMZjyZMU2Jt2gRN0vigOULSav+rtJi0GmE1qCfVp4wbyuuIHfNBddvV2NefNvEQGA==
X-Received: by 2002:a25:820b:: with SMTP id q11mr13919882ybk.123.1582568295516;
        Mon, 24 Feb 2020 10:18:15 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i66sm5632383ywa.74.2020.02.24.10.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:18:15 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 2/8] x86, syscalls: Refactor SYSCALL_DEFINE0 macros
Date:   Mon, 24 Feb 2020 13:17:51 -0500
Message-Id: <20200224181757.724961-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224181757.724961-1-brgerst@gmail.com>
References: <20200224181757.724961-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull the common code out from the SYSCALL_DEFINE0 macros into a new
__SYS_STUB0 macro.  Also conditionalize the X64 version in preparation for
enabling syscall wrappers on 32-bit native kernels.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/syscall_wrapper.h | 73 +++++++++++---------------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 44ed358a2e3c..c13be057865f 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -21,6 +21,12 @@ struct pt_regs;
 	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
 	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
 
+#define __SYS_STUB0(abi, name)						\
+	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
+	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
+	asmlinkage long __##abi##_##name(const struct pt_regs *regs)	\
+		__alias(__do_##name);
+
 #define __SYS_STUBx(abi, name, ...)					\
 	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
 	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
@@ -30,10 +36,14 @@ struct pt_regs;
 	}
 
 #ifdef CONFIG_X86_64
+#define __X64_SYS_STUB0(sys_name)					\
+	__SYS_STUB0(x64, sys_name)
+
 #define __X64_SYS_STUBx(x, sys_name, ...)				\
 	__SYS_STUBx(x64, sys_name,					\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 #else /* CONFIG_X86_64 */
+#define __X64_SYS_STUB0(sys_name)
 #define __X64_SYS_STUBx(x, sys_name, ...)
 #endif /* CONFIG_X86_64 */
 
@@ -46,34 +56,20 @@ struct pt_regs;
  * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
  * case as well.
  */
-#define __IA32_COMPAT_SYS_STUB0(x, name)				\
-	asmlinkage long __ia32_compat_sys_##name(const struct pt_regs *regs);\
-	ALLOW_ERROR_INJECTION(__ia32_compat_sys_##name, ERRNO);		\
-	asmlinkage long __ia32_compat_sys_##name(const struct pt_regs *regs)\
-	{								\
-		return __se_compat_sys_##name();			\
-	}
+#define __IA32_COMPAT_SYS_STUB0(compat_sys_name)			\
+	__SYS_STUB0(ia32, compat_sys_name)
 
 #define __IA32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)		\
 	__SYS_STUBx(ia32, compat_sys_name,				\
 		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
+#define __IA32_SYS_STUB0(sys_name)					\
+	__SYS_STUB0(ia32, sys_name)
+
 #define __IA32_SYS_STUBx(x, sys_name, ...)				\
 	__SYS_STUBx(ia32, sys_name,					\
 		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
-/*
- * To keep the naming coherent, re-define SYSCALL_DEFINE0 to create an alias
- * named __ia32_sys_*()
- */
-
-#define SYSCALL_DEFINE0(sname)						\
-	SYSCALL_METADATA(_##sname, 0);					\
-	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused);\
-	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);		\
-	SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);		\
-	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)
-
 #define COND_SYSCALL(name)							\
 	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
 	{									\
@@ -89,7 +85,9 @@ struct pt_regs;
 	SYSCALL_ALIAS(__ia32_sys_##name, sys_ni_posix_timers)
 
 #else /* CONFIG_IA32_EMULATION */
+#define __IA32_COMPAT_SYS_STUB0(compat_sys_name)
 #define __IA32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)
+#define __IA32_SYS_STUB0(sys_name)
 #define __IA32_SYS_STUBx(x, sys_name, ...)
 #endif /* CONFIG_IA32_EMULATION */
 
@@ -100,20 +98,15 @@ struct pt_regs;
  * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
  * with x86_64 obviously do not need such care.
  */
-#define __X32_COMPAT_SYS_STUB0(x, name, ...)				\
-	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs);\
-	ALLOW_ERROR_INJECTION(__x32_compat_sys_##name, ERRNO);		\
-	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs)\
-	{								\
-		return __se_compat_sys_##name();\
-	}
+#define __X32_COMPAT_SYS_STUB0(compat_sys_name)				\
+	__SYS_STUB0(x32, compat_sys_name)
 
 #define __X32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)			\
 	__SYS_STUBx(x32, compat_sys_name,				\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
 #else /* CONFIG_X86_X32 */
-#define __X32_COMPAT_SYS_STUB0(x, name)
+#define __X32_COMPAT_SYS_STUB0(compat_sys_name)
 #define __X32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)
 #endif /* CONFIG_X86_X32 */
 
@@ -125,15 +118,12 @@ struct pt_regs;
  * of them.
  */
 #define COMPAT_SYSCALL_DEFINE0(name)					\
-	static long __se_compat_sys_##name(void);			\
-	static inline long __do_compat_sys_##name(void);		\
-	__IA32_COMPAT_SYS_STUB0(x, name)				\
-	__X32_COMPAT_SYS_STUB0(x, name)					\
-	static long __se_compat_sys_##name(void)			\
-	{								\
-		return __do_compat_sys_##name();			\
-	}								\
-	static inline long __do_compat_sys_##name(void)
+	static asmlinkage long						\
+	__do_compat_sys_##name(const struct pt_regs *__unused);		\
+	__IA32_COMPAT_SYS_STUB0(compat_sys_##name)			\
+	__X32_COMPAT_SYS_STUB0(compat_sys_##name)			\
+	static asmlinkage long						\
+	__do_compat_sys_##name(const struct pt_regs *__unused)
 
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)				\
 	static long							\
@@ -221,13 +211,14 @@ struct pt_regs;
  * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() and SYS_NI()
  * macros to work correctly.
  */
-#ifndef SYSCALL_DEFINE0
 #define SYSCALL_DEFINE0(sname)						\
 	SYSCALL_METADATA(_##sname, 0);					\
-	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused);\
-	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);		\
-	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)
-#endif
+	static asmlinkage long						\
+	__do_sys_##sname(const struct pt_regs *__unused);		\
+	__X64_SYS_STUB0(sys_##sname)					\
+	__IA32_SYS_STUB0(sys_##sname)					\
+	static asmlinkage long						\
+	__do_sys_##sname(const struct pt_regs *__unused)
 
 #ifndef COND_SYSCALL
 #define COND_SYSCALL(name) 							\
-- 
2.24.1

