Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D77C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B16246A3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCnq6ZqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgB0N3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:29:06 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45253 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbgB0N2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:28:39 -0500
Received: by mail-yw1-f66.google.com with SMTP id a125so2926788ywe.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ISW4IJiYVZlUtS/571LODHPsOH1NVoiUPrzOcqK7P/E=;
        b=HCnq6ZqQsA9ekb7RCuLPqsKVFlPtqUBK1ynIiDrnSEp5AHkFvlEB+65YA8jRg8MpBc
         UPWFF98p+n9291NiFstEFlRhbI1CiXwKX6mtxqvyiDl1oVBfxFbSTYnyKpku9T0/3wSQ
         7Yo/v2NFlzwljHF4N4IRrXuB8y7Qs2zW7y8X/92eC3oZpMHmBo6MoA8cj6lOxrGmR16w
         1TM7mBbXwTmWO1IEfVI7LnCwpFvBvuMc3rSXy7v1JvCU3Q5LiW4vfIfuwCH/dYmdNi+W
         bF6UhP27MWszVRhRcSm51CHOD5N3wst/jUObS5BFf2eGrTC4CGSwT8aRJXWA+9IuNnVi
         Ljjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ISW4IJiYVZlUtS/571LODHPsOH1NVoiUPrzOcqK7P/E=;
        b=HCZw84o2wSgCvYe/hYtSh9fkZgr95wZlIacaT9K0Si4+PwM754ZmEORQoSZeMT5z6t
         0rXUA90cQ8AfgsC5T1dGXBa9X9Nfe5BWsm2DR+tl1lNQFOzfrBVItXL5+cdXoX/Lu7qm
         /nlJ1771WKucvRi2aOe0cQ53EM5UxfkYc2+i3ZL7eQw0myvDfMNbJrsIGC5z1E7IKhRw
         szZZ9CGlfuRI0u+wP6O3c1bvsLzg3unpht3qHKA6kem3OP4J1iIOV5WFBu4e0MTS+X+Z
         YGjhYGyLyeq58p0yUwalFaIMyiLx/JYreQ4oMFbQce6vtl11Pwopwt8w7eUP4W95lMfJ
         tXqg==
X-Gm-Message-State: APjAAAXnB6XekMdQt+SBZtkXsXyb2g9ZmDP5qu2lN4RiTQt2ImdHIQ3R
        /Foqr4adxk0i1PrT/0XLlM4Folk=
X-Google-Smtp-Source: APXvYqytRGKko8tJgk6mIfEJoO946C8AINt/5Hpltuea048Y0oX44enrDMnZxi5ln1KLLmoeiMKymQ==
X-Received: by 2002:a81:a985:: with SMTP id g127mr3966117ywh.470.1582810117700;
        Thu, 27 Feb 2020 05:28:37 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j23sm2442759ywb.93.2020.02.27.05.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:28:37 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 2/8] x86, syscalls: Refactor SYSCALL_DEFINE0 macros
Date:   Thu, 27 Feb 2020 08:28:20 -0500
Message-Id: <20200227132826.195669-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227132826.195669-1-brgerst@gmail.com>
References: <20200227132826.195669-1-brgerst@gmail.com>
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
index 7a4c2aff52c6..2b1ae55c52ee 100644
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
+#define __X64_SYS_STUB0(name)						\
+	__SYS_STUB0(x64, sys_##name)
+
 #define __X64_SYS_STUBx(x, name, ...)					\
 	__SYS_STUBx(x64, sys##name,					\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 #else /* CONFIG_X86_64 */
+#define __X64_SYS_STUB0(name)
 #define __X64_SYS_STUBx(x, name, ...)
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
+#define __IA32_COMPAT_SYS_STUB0(name)					\
+	__SYS_STUB0(ia32, compat_sys_##name)
 
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
 	__SYS_STUBx(ia32, compat_sys##name,				\
 		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
+#define __IA32_SYS_STUB0(name)						\
+	__SYS_STUB0(ia32, sys_##name)
+
 #define __IA32_SYS_STUBx(x, name, ...)					\
 	__SYS_STUBx(ia32, sys##name,					\
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
+#define __IA32_COMPAT_SYS_STUB0(name)
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
+#define __IA32_SYS_STUB0(name)
 #define __IA32_SYS_STUBx(x, name, ...)
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
+#define __X32_COMPAT_SYS_STUB0(name)					\
+	__SYS_STUB0(x32, compat_sys_##name)
 
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
 	__SYS_STUBx(x32, compat_sys##name,				\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
 #else /* CONFIG_X86_X32 */
-#define __X32_COMPAT_SYS_STUB0(x, name)
+#define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
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
+	__IA32_COMPAT_SYS_STUB0(name)					\
+	__X32_COMPAT_SYS_STUB0(name)					\
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
+	__X64_SYS_STUB0(sname)						\
+	__IA32_SYS_STUB0(sname)						\
+	static asmlinkage long						\
+	__do_sys_##sname(const struct pt_regs *__unused)
 
 #ifndef COND_SYSCALL
 #define COND_SYSCALL(name) 							\
-- 
2.24.1

