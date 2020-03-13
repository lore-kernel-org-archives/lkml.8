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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB8CC5ACBF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD9020724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM//KSRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgCMTwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:52:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37135 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgCMTwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id l20so8649341qtp.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=asHgh1PP/dXumDoerrsVIvym6uaLF0Cebu4CCENRqXo=;
        b=CM//KSRP1iDlug/0eKM7vRGHM5t55OL5pO4IWR1efQLEmYSAJPUZhNZobYux0UfzVb
         S/7pfdk0oQxK7ZnBEF3eXK05B1+qxO6F1w9QmwE6ybz89+0Y30HnmluxKYZH306yq/Vt
         k9u7BP25BplbiAn+DTw/79CbMBT77QiEjzOMa+U2orEpTi/WLXnJb6frwa44leaVpkus
         E8FWA6s4zBXH/tXcERWgEvwA5cCA/06Oa6bpd7zX8lCHKUUPy0ANaQC/1HjeTzX1cQOC
         CY73X84KcboLVeElC70a3PPENH7/QbrO8p9KNI6i7Xvo40JwiA6t1rAFP6xLWE0769I7
         eh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=asHgh1PP/dXumDoerrsVIvym6uaLF0Cebu4CCENRqXo=;
        b=txqWj18EgKjU/zrTLYmRsvStGq1Im95iWxLTK4t9jnO+oQ63k3F5uksfLgQ/W9p3MW
         A4ynJyajkUXO+Mo19bh45iQf6DFzayyW6UV/qUlml0H20wNymvhExWZhYH1T1biHvM18
         E0U6+s0rF1av+V1meGVJP1vqfCxkV7Fug5lSCJ3qX91iV1dISkJzqp1nqDcMxBtNbQCV
         NAWJG/DgJuBjOk+1DIkrl3nXiSPQwO2ArNugoM9l740jEAxHGmv8UXKFGpI+luI1hSRy
         JKC7vW/7GGy6HrZ7g2rNkntgChjGbM3e8R4GYn4jfUHagBo6liPGBJmhM8RkJgymogc7
         NiCQ==
X-Gm-Message-State: ANhLgQ1m/mAYHJ6aUJtcXOgwFwk75vpG8A+Alk/HMQY+/pQDaFWRupWT
        My6OIfmIpPRcunWccuAq8PvpWpg=
X-Google-Smtp-Source: ADFU+vsas33/T1wls90LzJe/jnlvuo7MSv76eqsmkBQ9+WYGCIXlVM8QKM+2HWiSJZMleCmzUxSkcA==
X-Received: by 2002:aed:30ce:: with SMTP id 72mr13731312qtf.89.1584129152724;
        Fri, 13 Mar 2020 12:52:32 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:32 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 17/18] x86: Drop asmlinkage from syscalls
Date:   Fri, 13 Mar 2020 15:51:43 -0400
Message-Id: <20200313195144.164260-18-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asmlinkage is no longer required since the syscall ABI is now fully under
x86 architecture control.  This makes the 32-bit native syscalls a bit more
effecient by passing in regs via EAX instead of on the stack.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/syscall_32.c            |  2 +-
 arch/x86/entry/syscall_64.c            |  2 +-
 arch/x86/entry/syscall_x32.c           |  4 ++--
 arch/x86/include/asm/syscall.h         |  2 +-
 arch/x86/include/asm/syscall_wrapper.h | 31 ++++++++++++--------------
 5 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 097413c705ad..86eb0d89d46f 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -8,7 +8,7 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_I386(nr, sym) extern asmlinkage long __ia32_##sym(const struct pt_regs *);
+#define __SYSCALL_I386(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
 
 #include <asm/syscalls_32.h>
 #undef __SYSCALL_I386
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 66d3e65e3b6b..1594ec72bcbb 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -11,7 +11,7 @@
 #define __SYSCALL_X32(nr, sym)
 #define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
 
-#define __SYSCALL_64(nr, sym) extern asmlinkage long __x64_##sym(const struct pt_regs *);
+#define __SYSCALL_64(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
 
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 2fb09efd7b40..3d8d70d3896c 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -10,8 +10,8 @@
 
 #define __SYSCALL_64(nr, sym)
 
-#define __SYSCALL_X32(nr, sym) extern asmlinkage long __x32_##sym(const struct pt_regs *);
-#define __SYSCALL_COMMON(nr, sym) extern asmlinkage long __x64_##sym(const struct pt_regs *);
+#define __SYSCALL_X32(nr, sym) extern long __x32_##sym(const struct pt_regs *);
+#define __SYSCALL_COMMON(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_X32
 #undef __SYSCALL_COMMON
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index bb427d8cb1ef..7cbf733d11af 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -16,7 +16,7 @@
 #include <asm/thread_info.h>	/* for TS_COMPAT */
 #include <asm/unistd.h>
 
-typedef asmlinkage long (*sys_call_ptr_t)(const struct pt_regs *);
+typedef long (*sys_call_ptr_t)(const struct pt_regs *);
 extern const sys_call_ptr_t sys_call_table[];
 
 #if defined(CONFIG_X86_32)
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 5e13e2caf2e4..e10efa1454bc 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -8,8 +8,8 @@
 
 struct pt_regs;
 
-extern asmlinkage long __x64_sys_ni_syscall(const struct pt_regs *regs);
-extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
+extern long __x64_sys_ni_syscall(const struct pt_regs *regs);
+extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 
 /*
  * Instead of the generic __SYSCALL_DEFINEx() definition, the x86 version takes
@@ -66,22 +66,21 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
 
 #define __SYS_STUB0(abi, name)						\
-	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
+	long __##abi##_##name(const struct pt_regs *regs);		\
 	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
-	asmlinkage long __##abi##_##name(const struct pt_regs *regs)	\
+	long __##abi##_##name(const struct pt_regs *regs)		\
 		__alias(__do_##name);
 
 #define __SYS_STUBx(abi, name, ...)					\
-	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
+	long __##abi##_##name(const struct pt_regs *regs);		\
 	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
-	asmlinkage long __##abi##_##name(const struct pt_regs *regs)	\
+	long __##abi##_##name(const struct pt_regs *regs)		\
 	{								\
 		return __se_##name(__VA_ARGS__);			\
 	}
 
 #define __COND_SYSCALL(abi, name)					\
-	asmlinkage __weak long						\
-	__##abi##_##name(const struct pt_regs *__unused)		\
+	__weak long __##abi##_##name(const struct pt_regs *__unused)	\
 	{								\
 		return sys_ni_syscall();				\
 	}
@@ -192,11 +191,11 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * of them.
  */
 #define COMPAT_SYSCALL_DEFINE0(name)					\
-	static asmlinkage long						\
+	static long							\
 	__do_compat_sys_##name(const struct pt_regs *__unused);		\
 	__IA32_COMPAT_SYS_STUB0(name)					\
 	__X32_COMPAT_SYS_STUB0(name)					\
-	static asmlinkage long						\
+	static long							\
 	__do_compat_sys_##name(const struct pt_regs *__unused)
 
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
@@ -248,12 +247,10 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  */
 #define SYSCALL_DEFINE0(sname)						\
 	SYSCALL_METADATA(_##sname, 0);					\
-	static asmlinkage long						\
-	__do_sys_##sname(const struct pt_regs *__unused);		\
+	static long __do_sys_##sname(const struct pt_regs *__unused);	\
 	__X64_SYS_STUB0(sname)						\
 	__IA32_SYS_STUB0(sname)						\
-	static asmlinkage long						\
-	__do_sys_##sname(const struct pt_regs *__unused)
+	static long __do_sys_##sname(const struct pt_regs *__unused)
 
 #define COND_SYSCALL(name)						\
 	__X64_COND_SYSCALL(name)					\
@@ -268,8 +265,8 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * For VSYSCALLS, we need to declare these three syscalls with the new
  * pt_regs-based calling convention for in-kernel use.
  */
-asmlinkage long __x64_sys_getcpu(const struct pt_regs *regs);
-asmlinkage long __x64_sys_gettimeofday(const struct pt_regs *regs);
-asmlinkage long __x64_sys_time(const struct pt_regs *regs);
+long __x64_sys_getcpu(const struct pt_regs *regs);
+long __x64_sys_gettimeofday(const struct pt_regs *regs);
+long __x64_sys_time(const struct pt_regs *regs);
 
 #endif /* _ASM_X86_SYSCALL_WRAPPER_H */
-- 
2.24.1

