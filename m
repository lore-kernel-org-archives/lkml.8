Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A38C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECB02074F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3z+r2Zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgCMTwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:52:15 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42762 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgCMTwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:13 -0400
Received: by mail-qv1-f66.google.com with SMTP id ca9so5289702qvb.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMFX2UjK/YCSohRE7yQ/ihMCB+E/zblhtxkiw6UKhcM=;
        b=p3z+r2ZgzZukiJ4PI/JPuMVuAkRd48obnJjcBh54ixZ3nQIuE2GhQH7UhEMYKSprHI
         ykH21ko1NZ4ecdWSUfFjjy6i6pqrn1zUoQyXwdZzsthC2IKfHbaMfF2N3Q6kSGPumUty
         na7BuJoNofYb9ScLAxufCk4RO49eq8DTgcYuphkerloMmxT7YuHltdUTobFunq+pypFF
         fWkzRAPT3Dy5UR5G4rbtWgAifH/DZhM9DeXK29QS04CtQ4QCKFmN5ZyvFzLIXob0OJ7x
         VPkM09ufi6wBsnUUtKafRREuYzjsFY43YzkBqMwwngdfoa2cdJGZXmndi2JBTR1hOpW0
         85Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMFX2UjK/YCSohRE7yQ/ihMCB+E/zblhtxkiw6UKhcM=;
        b=h5ksuLv/MWMWwjibplahyCcaWL+SkU5FGsBdZmAWnPxT9d1H943pjvdwZztdYHhJR0
         f8A6qVB8Tdd7GlPBJB2srABeqhx9VGChJ7mB3iMjkj+VoJbcS/3UtzncgwIml7sNRUCC
         qOMkqnZuEPJfKujE0LbfxJxj+o5+VAzFPdsBi5TvSNE8ZR7A75lTbcbd2ukPt3iWmPjj
         5Ac29a4BApiYdvd2TMOveAK6hFMWCQbeZ0utnmUr2AfGv6ZZ9I5bId0LKwnMIqafPxvs
         UOJwyNW783ajF2ReSvqaVEgEUr5L+z2Zpaoj9tIOGGFjqkwD9fis4Ujvxs7Fyh11c9s8
         78yQ==
X-Gm-Message-State: ANhLgQ1aNQDMcjeQ12QFD9Rhn8kvZJJeDsb6qSy/66Eeg73mzHpeHuVH
        0/+HvxmQQwOrAGamf38Ol0qT9+k=
X-Google-Smtp-Source: ADFU+vtdxW08jLaclk8xsIF1gHJOYNvDZUS6LlZRMJrpairbT5g3Vm3EJuPn70nRmyy3jhdD15Uxaw==
X-Received: by 2002:a05:6214:a46:: with SMTP id ee6mr14226720qvb.32.1584129131602;
        Fri, 13 Mar 2020 12:52:11 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:11 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 02/18] x86, syscalls: Refactor SYSCALL_DEFINE0 macros
Date:   Fri, 13 Mar 2020 15:51:28 -0400
Message-Id: <20200313195144.164260-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
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
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/syscall_wrapper.h | 73 +++++++++++---------------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index a1c090bde063..45ad60571166 100644
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
 
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
 	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
@@ -216,13 +206,14 @@ struct pt_regs;
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

