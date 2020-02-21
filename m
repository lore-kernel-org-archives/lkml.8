Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220CDC11D27
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23AE24670
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+RN5hBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgBUFKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:10:36 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43845 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgBUFKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:10:35 -0500
Received: by mail-yb1-f195.google.com with SMTP id b141so574446ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 21:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ori4lTLtmTjBxtgmjlF40p3QxF9zZ+a/QOuQY89Qmts=;
        b=H+RN5hBPyWpoQfCxDWef4y835S6GrS8xv5uP7GiS5DF9UhOK6n6BFzJzCicnrHQCJV
         4U1N1dhS/+ne2V/K+S8l4fy9Dk5N1wPiJuJ4x+QEasrl1EdfuI8nDKAo8OdeOV2gPCS0
         hPbPQgt5JkXAvYeEi4BftTlWQUlfIf+4fKOlmI+ODmCPtBOWaGbbetwpsytGZzAOgCt+
         PJpmW6sIi6jGqwzxHUQfpN7JR9L9hStZ1XvddlutRHdxpVPq8FpmlfD3xYWqXlFCWYHz
         wdR1F0ajaS4R/KjYaSXsiKOQbgT/MZ3p9cK1cw52KjUw02bDTnaM1AsqawMBLBKLSB6f
         i5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ori4lTLtmTjBxtgmjlF40p3QxF9zZ+a/QOuQY89Qmts=;
        b=N6WF/Tf7Frm1+3a8CjrCFt57r7KeRqdT8lDkaQlrnkL5DrWQcgvZkuWfJ7yyiC7FO6
         WAnnH6YHFQiivMB6nUJL8NhGxwGXWCUFskkWaEtNN1wrMsixlYdbyj5/JVrQm7C1u+XK
         WFMgDWIa/vnQR/7cOUxeGVKoebs927GLXYGbwCuXxweJwAjvpdahg6kKrWrHmpe12PVy
         BRAhspTsQjg3UWzHbtYtY1FBgUY8CK35TBBZ14eBDOapU0rqzmoA7OM6f+w593wqYKUu
         6KSO6IPwFmSSCbJUokYr8P/NwrqylyY8iUfv/y/xBDgo2MpJhs0VAelfvNEkmsZBGUwe
         rwKg==
X-Gm-Message-State: APjAAAXdFl+tzzru2M69MRbnjm6caj/cLxUJwemiILFd6heAG+6Rq6tc
        +rKCaeFAQJaNEt6aM6yTZptOkFU=
X-Google-Smtp-Source: APXvYqy1jBW73BtbAtHlVm5Q7Yg/8WcACyrgWNI6WcQOeoM4gY2xm/miIG4Q1frlnjEKAtNvIPrswQ==
X-Received: by 2002:a25:7cc1:: with SMTP id x184mr32609403ybc.322.1582261833863;
        Thu, 20 Feb 2020 21:10:33 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id a12sm840904ywa.95.2020.02.20.21.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 21:10:33 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/5] x86: Refactor syscall_wrapper.h
Date:   Fri, 21 Feb 2020 00:09:30 -0500
Message-Id: <20200221050934.719152-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221050934.719152-1-brgerst@gmail.com>
References: <20200221050934.719152-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor syscall_wrapper.h to make the code more understandable, and
prepare for enabling pt_regs based syscalls for 32-bit native.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/syscall_wrapper.h | 363 +++++++++++++------------
 1 file changed, 194 insertions(+), 169 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index e2389ce9bf58..00be12017118 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -8,6 +8,40 @@
 
 struct pt_regs;
 
+/*
+ * Instead of the generic __SYSCALL_DEFINEx() definition, this macro takes
+ * struct pt_regs *regs as the only argument of the syscall stub named
+ * __x64_sys_*(). It decodes just the registers it needs and passes them on to
+ * the __se_sys_*() wrapper performing sign extension and then to the
+ * __do_sys_*() function doing the actual job. These wrappers and functions
+ * are inlined (at least in very most cases), meaning that the assembly looks
+ * as follows (slightly re-ordered for better readability):
+ *
+ * <__x64_sys_recv>:		<-- syscall with 4 parameters
+ *	callq	<__fentry__>
+ *
+ *	mov	0x70(%rdi),%rdi	<-- decode regs->di
+ *	mov	0x68(%rdi),%rsi	<-- decode regs->si
+ *	mov	0x60(%rdi),%rdx	<-- decode regs->dx
+ *	mov	0x38(%rdi),%rcx	<-- decode regs->r10
+ *
+ *	xor	%r9d,%r9d	<-- clear %r9
+ *	xor	%r8d,%r8d	<-- clear %r8
+ *
+ *	callq	__sys_recvfrom	<-- do the actual work in __sys_recvfrom()
+ *				    which takes 6 arguments
+ *
+ *	cltq			<-- extend return value to 64-bit
+ *	retq			<-- return
+ *
+ * This approach avoids leaking random user-provided register content down
+ * the call chain.
+ *
+ * If IA32_EMULATION is enabled, this macro generates an additional wrapper
+ * named __ia32_sys_*() which decodes the struct pt_regs *regs according
+ * to the i386 calling convention (bx, cx, dx, si, di, bp).
+ */
+
 /* Mapping of registers to parameters for syscalls on x86-64 and x32 */
 #define SC_X86_64_REGS_TO_ARGS(x, ...)					\
 	__MAP(x,__SC_ARGS						\
@@ -21,68 +55,146 @@ struct pt_regs;
 	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
 	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
 
-#ifdef CONFIG_IA32_EMULATION
-/*
- * For IA32 emulation, we need to handle "compat" syscalls *and* create
- * additional wrappers (aptly named __ia32_sys_xyzzy) which decode the
- * ia32 regs in the proper order for shared or "common" syscalls. As some
- * syscalls may not be implemented, we need to expand COND_SYSCALL in
- * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
- * case as well.
- */
-#define __IA32_COMPAT_SYS_STUB0(x, name)				\
-	asmlinkage long __ia32_compat_sys_##name(const struct pt_regs *regs);\
-	ALLOW_ERROR_INJECTION(__ia32_compat_sys_##name, ERRNO);		\
-	asmlinkage long __ia32_compat_sys_##name(const struct pt_regs *regs)\
+#define __SYS_STUBx(abi, name, ...)					\
+	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
+	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
+	asmlinkage long __##abi##_##name(const struct pt_regs *regs)	\
 	{								\
-		return __se_compat_sys_##name();			\
+		return __se_##name(__VA_ARGS__);			\
 	}
 
-#define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
-	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs);\
-	ALLOW_ERROR_INJECTION(__ia32_compat_sys##name, ERRNO);		\
-	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs)\
+#define __SYS_STUB0(abi, name)						\
+	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
+	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
+	asmlinkage long __##abi##_##name(const struct pt_regs *regs)	\
 	{								\
-		return __se_compat_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
+		return __do_##name();					\
 	}
 
-#define __IA32_SYS_STUBx(x, name, ...)					\
-	asmlinkage long __ia32_sys##name(const struct pt_regs *regs);	\
-	ALLOW_ERROR_INJECTION(__ia32_sys##name, ERRNO);			\
-	asmlinkage long __ia32_sys##name(const struct pt_regs *regs)	\
+#define __COND_SYSCALL(abi, name)					\
+	asmlinkage __weak long						\
+	 __##abi##_##name(const struct pt_regs *regs)			\
 	{								\
-		return __se_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
+		return sys_ni_syscall();				\
 	}
 
+#ifdef CONFIG_X86_64
+#define __X64_SYS_STUBx(x, name, ...)					\
+	__SYS_STUBx(x64, name, SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
+
+#define __X64_SYS_STUB0(name)						\
+	__SYS_STUB0(x64, name)
+
+#define __X64_COND_SYSCALL(name)					\
+	__COND_SYSCALL(x64, name)
+
+#define __X64_SYS_NI(name)						\
+	SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers)
+
+#else /* CONFIG_X86_64 */
+#define __X64_SYS_STUBx(x, name, ...)
+#define __X64_SYS_STUB0(name)
+#define __X64_COND_SYSCALL(name)
+#define __X64_SYS_NI(name)
+#endif /* CONFIG_X86_64 */
+
+
+#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+#define __IA32_SYS_STUBx(x, name, ...)					\
+	__SYS_STUBx(ia32, name, SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
+
+#define __IA32_SYS_STUB0(name)						\
+	__SYS_STUB0(ia32, name)
+
+#define __IA32_COND_SYSCALL(name)					\
+	__COND_SYSCALL(ia32, name)
+
+#define __IA32_SYS_NI(name)						\
+	SYSCALL_ALIAS(__ia32_sys_##name, sys_ni_posix_timers)
+
+#else /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
+#define __IA32_SYS_STUBx(x, name, ...)
+#define __IA32_SYS_STUB0(name)
+#define __IA32_COND_SYSCALL(name)
+#define __IA32_SYS_NI(name)
+#endif /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
+
+
+#define __SYSCALL_DEFINEx(x, name, ...)					\
+	static long							\
+	__se_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__));		\
+	static inline long						\
+	__do_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__));		\
+	__X64_SYS_STUBx(x, sys##name, __VA_ARGS__)			\
+	__IA32_SYS_STUBx(x, sys##name, __VA_ARGS__)			\
+	static long							\
+	__se_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__))		\
+	{								\
+		long ret = __do_sys##name(__MAP(x, __SC_CAST,		\
+					  __VA_ARGS__));		\
+		__MAP(x, __SC_TEST, __VA_ARGS__);			\
+		__PROTECT(x, ret, __MAP(x, __SC_ARGS, __VA_ARGS__));	\
+		return ret;						\
+	}								\
+	static inline long						\
+	__do_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__))
+
 /*
- * To keep the naming coherent, re-define SYSCALL_DEFINE0 to create an alias
- * named __ia32_sys_*()
+ * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
+ * obvious reasons, and passing struct pt_regs *regs to it in %rdi does not
+ * hurt, we only need to re-define it here to keep the naming congruent to
+ * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() and SYS_NI()
+ * macros to work correctly.
  */
+#define SYSCALL_DEFINE0(name)					\
+	SYSCALL_METADATA(_##name, 0);				\
+	static inline long __do_sys_##name(void);		\
+	__X64_SYS_STUB0(sys_##name)				\
+	__IA32_SYS_STUB0(sys_##name)				\
+	static inline long __do_sys_##name(void)
 
-#define SYSCALL_DEFINE0(sname)						\
-	SYSCALL_METADATA(_##sname, 0);					\
-	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused);\
-	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);		\
-	SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);		\
-	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)
-
-#define COND_SYSCALL(name)							\
-	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
-	{									\
-		return sys_ni_syscall();					\
-	}									\
-	asmlinkage __weak long __ia32_sys_##name(const struct pt_regs *__unused)\
-	{									\
-		return sys_ni_syscall();					\
-	}
+#define COND_SYSCALL(name)					\
+	__X64_COND_SYSCALL(sys_##name)				\
+	__IA32_COND_SYSCALL(sys_##name)
 
-#define SYS_NI(name)							\
-	SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);		\
-	SYSCALL_ALIAS(__ia32_sys_##name, sys_ni_posix_timers)
+#define SYS_NI(name)						\
+	__X64_SYS_NI(name)					\
+	__IA32_SYS_NI(name)
+
+
+#ifdef CONFIG_COMPAT
+/*
+ * Compat means IA32_EMULATION and/or X86_X32. As they use a different
+ * mapping of registers to parameters, we need to generate stubs for each
+ * of them.
+ */
+
+#ifdef CONFIG_IA32_EMULATION
+/*
+ * For IA32 emulation, we need to handle "compat" syscalls *and* create
+ * additional wrappers (aptly named __ia32_sys_xyzzy) which decode the
+ * ia32 regs in the proper order for shared or "common" syscalls. As some
+ * syscalls may not be implemented, we need to expand COND_SYSCALL in
+ * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
+ * case as well.
+ */
+#define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
+	__SYS_STUBx(ia32, name, SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
+
+#define __IA32_COMPAT_SYS_STUB0(name)					\
+	__SYS_STUB0(ia32, name)
+
+#define __IA32_COMPAT_COND_SYSCALL(name)				\
+	__COND_SYSCALL(ia32, name)
+
+#define __IA32_COMPAT_SYS_NI(name)					\
+	SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers)
 
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
-#define __IA32_SYS_STUBx(x, fullname, name, ...)
+#define __IA32_COMPAT_SYS_STUB0(name)
+#define __IA32_COMPAT_COND_SYSCALL(name)
+#define __IA32_COMPAT_SYS_NI(name)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -92,55 +204,48 @@ struct pt_regs;
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
-
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
-	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
-	ALLOW_ERROR_INJECTION(__x32_compat_sys##name, ERRNO);		\
-	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
-	{								\
-		return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}
+	__SYS_STUBx(x32, name, SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
+
+#define __X32_COMPAT_SYS_STUB0(name)					\
+	__SYS_STUB0(x32, name)
+
+#define __X32_COMPAT_COND_SYSCALL(name)					\
+	__COND_SYSCALL(x32, name)
+
+#define __X32_COMPAT_SYS_NI(name)					\
+	SYSCALL_ALIAS(__x32_compat_sys_##name, sys_ni_posix_timers)
 
 #else /* CONFIG_X86_X32 */
-#define __X32_COMPAT_SYS_STUB0(x, name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
+#define __X32_COMPAT_SYS_STUB0(name)
+#define __X32_COMPAT_COND_SYSCALL(name)
+#define __X32_COMPAT_SYS_NI(name)
 #endif /* CONFIG_X86_X32 */
 
 
-#ifdef CONFIG_COMPAT
-/*
- * Compat means IA32_EMULATION and/or X86_X32. As they use a different
- * mapping of registers to parameters, we need to generate stubs for each
- * of them.
- */
-#define COMPAT_SYSCALL_DEFINE0(name)					\
-	static long __se_compat_sys_##name(void);			\
-	static inline long __do_compat_sys_##name(void);		\
-	__IA32_COMPAT_SYS_STUB0(x, name)				\
-	__X32_COMPAT_SYS_STUB0(x, name)					\
-	static long __se_compat_sys_##name(void)			\
+#define COMPAT_SYSCALL_DEFINEx(x, name, ...)				\
+	static long							\
+	__se_compat_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__));	\
+	static inline long						\
+	__do_compat_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__));	\
+	__IA32_COMPAT_SYS_STUBx(x, compat_sys##name, __VA_ARGS__)	\
+	__X32_COMPAT_SYS_STUBx(x, compat_sys##name, __VA_ARGS__)	\
+	static long							\
+	__se_compat_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__))		\
 	{								\
-		return __do_compat_sys_##name();			\
+		return __do_compat_sys##name(__MAP(x, __SC_DELOUSE,	\
+					     __VA_ARGS__));		\
 	}								\
-	static inline long __do_compat_sys_##name(void)
+	static inline long						\
+	__do_compat_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__))
 
-#define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
-	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
-	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-	__IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
-	__X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
-	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
-	{									\
-		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
-	}									\
-	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#define COMPAT_SYSCALL_DEFINE0(name)				\
+	SYSCALL_METADATA(_##name, 0);				\
+	static inline long __do_compat_sys_##name(void);	\
+	__IA32_COMPAT_SYS_STUB0(compat_sys_##name)		\
+	__X32_COMPAT_SYS_STUB0(compat_sys_##name)		\
+	static inline long __do_compat_sys_##name(void)
 
 /*
  * As some compat syscalls may not be implemented, we need to expand
@@ -148,96 +253,16 @@ struct pt_regs;
  * kernel/time/posix-stubs.c to cover this case as well.
  */
 #define COND_SYSCALL_COMPAT(name) 					\
-	cond_syscall(__ia32_compat_sys_##name);				\
-	cond_syscall(__x32_compat_sys_##name)
+	__IA32_COMPAT_COND_SYSCALL(compat_sys_##name)			\
+	__X32_COMPAT_COND_SYSCALL(compat_sys_##name)
 
 #define COMPAT_SYS_NI(name)						\
-	SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers);	\
-	SYSCALL_ALIAS(__x32_compat_sys_##name, sys_ni_posix_timers)
+	__IA32_COMPAT_SYS_NI(name)					\
+	__X32_COMPAT_SYS_NI(name)
 
 #endif /* CONFIG_COMPAT */
 
 
-/*
- * Instead of the generic __SYSCALL_DEFINEx() definition, this macro takes
- * struct pt_regs *regs as the only argument of the syscall stub named
- * __x64_sys_*(). It decodes just the registers it needs and passes them on to
- * the __se_sys_*() wrapper performing sign extension and then to the
- * __do_sys_*() function doing the actual job. These wrappers and functions
- * are inlined (at least in very most cases), meaning that the assembly looks
- * as follows (slightly re-ordered for better readability):
- *
- * <__x64_sys_recv>:		<-- syscall with 4 parameters
- *	callq	<__fentry__>
- *
- *	mov	0x70(%rdi),%rdi	<-- decode regs->di
- *	mov	0x68(%rdi),%rsi	<-- decode regs->si
- *	mov	0x60(%rdi),%rdx	<-- decode regs->dx
- *	mov	0x38(%rdi),%rcx	<-- decode regs->r10
- *
- *	xor	%r9d,%r9d	<-- clear %r9
- *	xor	%r8d,%r8d	<-- clear %r8
- *
- *	callq	__sys_recvfrom	<-- do the actual work in __sys_recvfrom()
- *				    which takes 6 arguments
- *
- *	cltq			<-- extend return value to 64-bit
- *	retq			<-- return
- *
- * This approach avoids leaking random user-provided register content down
- * the call chain.
- *
- * If IA32_EMULATION is enabled, this macro generates an additional wrapper
- * named __ia32_sys_*() which decodes the struct pt_regs *regs according
- * to the i386 calling convention (bx, cx, dx, si, di, bp).
- */
-#define __SYSCALL_DEFINEx(x, name, ...)					\
-	asmlinkage long __x64_sys##name(const struct pt_regs *regs);	\
-	ALLOW_ERROR_INJECTION(__x64_sys##name, ERRNO);			\
-	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
-	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-	asmlinkage long __x64_sys##name(const struct pt_regs *regs)	\
-	{								\
-		return __se_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}								\
-	__IA32_SYS_STUBx(x, name, __VA_ARGS__)				\
-	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
-	{								\
-		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
-		__MAP(x,__SC_TEST,__VA_ARGS__);				\
-		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
-		return ret;						\
-	}								\
-	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
-
-/*
- * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
- * obvious reasons, and passing struct pt_regs *regs to it in %rdi does not
- * hurt, we only need to re-define it here to keep the naming congruent to
- * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() and SYS_NI()
- * macros to work correctly.
- */
-#ifndef SYSCALL_DEFINE0
-#define SYSCALL_DEFINE0(sname)						\
-	SYSCALL_METADATA(_##sname, 0);					\
-	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused);\
-	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);		\
-	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)
-#endif
-
-#ifndef COND_SYSCALL
-#define COND_SYSCALL(name) 							\
-	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
-	{									\
-		return sys_ni_syscall();					\
-	}
-#endif
-
-#ifndef SYS_NI
-#define SYS_NI(name) SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);
-#endif
-
-
 /*
  * For VSYSCALLS, we need to declare these three syscalls with the new
  * pt_regs-based calling convention for in-kernel use.
-- 
2.24.1

