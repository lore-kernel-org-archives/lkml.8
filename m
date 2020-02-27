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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD9CC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3DC246A5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZM2Srfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgB0N2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:28:51 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34657 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbgB0N2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:28:49 -0500
Received: by mail-yw1-f67.google.com with SMTP id b186so3012613ywc.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+T6YGrccF2xqAmPwkCHULg2SNhjk/QECsgLsAGoV/Ko=;
        b=jZM2SrfmWUjivEtNHviDTPtrHlc5rNFdeDyK+le7wAqOm++qRmNoGQWdS4tg1JqERc
         fIGNiwlNdWw5wlCB9P+E6qPztZzIF9Drm1md9qAshuXmJZ+zZAaB/vgM/Q/IUMFceLVW
         Oz0tXkB+Yhd6ZV1uUMWiBu1fcarWulblX3s3ky58uMzwMCC6tEJeWbHietjRB4aNCMrZ
         IwW3epFal1yzs0NtygTnUZo+gpsyQZbr9x4Q9bWysQypiA9G/szwAIIqttMa4RHnDpRN
         6xGZCoDTaFlSYPrDXWazxOzshoQMAmDiOY84/tWsES8S0vr8l+LtaK2STq5Kq3cjCOzm
         1Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+T6YGrccF2xqAmPwkCHULg2SNhjk/QECsgLsAGoV/Ko=;
        b=J4uw71TFX3GVG92ypxDrFNzdzIAtaaegLXtGrhbTHJnp/mTqicw3/uJfxHL03nICTW
         2AN2r9X196bGktedgcL+KEIkViwaM8imqE0QLidUSb6vOii+hGQxtbM7hS/fBp3eEdrK
         c3yZ5JO72uudJmDILa8TfJZZ8M7TjFJ3XiGZ00f1G4XbRjszefV6RKXusmu8I2fCOqeT
         POGBn9Wzi3dVPk3xrrq8rJ5wOfdaYgNRvC0iNTili8fqzfr0gkZOHOTFSJz1lQfjsY9K
         UlS5eQfUhE08xO5J6TAS85IjPZSLtOrpTjEo4OQHtL2qiSqQ0edJRsJ7RL0lW8kd0lvi
         6S5A==
X-Gm-Message-State: APjAAAXoGlDwC+CJ8AX7xreZVnG+lZstnXFeKUu6HQz9CZGVNQfWrvIN
        7pcT9tkJNyr5Arl1V+kS7H87SBk=
X-Google-Smtp-Source: APXvYqzHawCpzNXzClPSiatNZ7TLX5bENBp3lkfvQKz6pbGjB1bZsFO+8MqYIuH1Q+GE4WernRO/yQ==
X-Received: by 2002:a5b:b0d:: with SMTP id z13mr3518487ybp.169.1582810127585;
        Thu, 27 Feb 2020 05:28:47 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j23sm2442759ywb.93.2020.02.27.05.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:28:47 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 8/8] x86: Drop asmlinkage from syscalls
Date:   Thu, 27 Feb 2020 08:28:26 -0500
Message-Id: <20200227132826.195669-9-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227132826.195669-1-brgerst@gmail.com>
References: <20200227132826.195669-1-brgerst@gmail.com>
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
---
 arch/x86/entry/syscall_32.c            |  2 +-
 arch/x86/entry/syscall_64.c            |  2 +-
 arch/x86/include/asm/syscall.h         |  2 +-
 arch/x86/include/asm/syscall_wrapper.h | 31 ++++++++++++--------------
 4 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 7af944b686ef..4e0113f3d4e8 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -8,7 +8,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_I386(nr, sym, qual) extern long sym(const struct pt_regs *);
 
 #include <asm/syscalls_32.h>
 #undef __SYSCALL_I386
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 058dc1b73e96..3331a71eec77 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,7 +8,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_64(nr, sym, qual) extern long sym(const struct pt_regs *);
 #define __SYSCALL_X32(nr, sym, qual) __SYSCALL_64(nr, sym, qual)
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 576178aefa01..a0b189714bac 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -17,7 +17,7 @@
 #include <asm/thread_info.h>	/* for TS_COMPAT */
 #include <asm/unistd.h>
 
-typedef asmlinkage long (*sys_call_ptr_t)(const struct pt_regs *);
+typedef long (*sys_call_ptr_t)(const struct pt_regs *);
 extern const sys_call_ptr_t sys_call_table[];
 
 #if defined(CONFIG_X86_32)
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index f3f29aeba2cb..28a3cd847c48 100644
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
 
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)				\
@@ -253,12 +252,10 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
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
@@ -273,8 +270,8 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
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

