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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD21BC11D24
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968C0208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1Fu+ogQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgBUFKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:10:51 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45841 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgBUFKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:10:40 -0500
Received: by mail-yb1-f194.google.com with SMTP id j78so566324ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 21:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ue/f9kEN8w6QddyvIhT39ZkvX9Hca0EirpL9SV/YEhY=;
        b=d1Fu+ogQGZMD0q7e9H3iAoCmudipLn8ZuzLY0G3GwkYcoza/uH2zJDM74Cb2jmDghf
         Xpn6p5zwkkeVBx4nB0lmdNvVq+Dp+QSjC5/ZK6hQoyUlyqr+FoOEAYjfX3e8UAj1CXsi
         kg6/G3+bXOGdrn4SHV2ktybc+iG30BAvAmWiPhoNh15Uv8bx4OeT9O57fZkQ1uacWPUx
         eOdj80bTjm3gIoCs3T0FACFspcaZqngIQw++FzQPsYvjcvYlhE79s2mzCMvS2rA3Xugl
         0ZRH/Ot3iFoOOa2ENkFMVPWjnQ5zlcyVaRFKJ/ccWPeiRGq36CFCe8KKM5RW+dtUFQiy
         /W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ue/f9kEN8w6QddyvIhT39ZkvX9Hca0EirpL9SV/YEhY=;
        b=eU48zttbby9q6C0b8ZFYWA9chwnmtmwfPM0rTitmM9120VO+hvb6QMkWUdcKQK0Sf9
         IGLZy0lwqd172tFyD5yFCpMLViW6rZh1cLlWTSefw/LQCViQvKysNJ0tI2UVSnwv5GEO
         xNgfv2t4KWJF8IVj6Ul0rFlCVfkx5Y07j8R9gBsS807jZCh3VTzPQZH0qZDq9iVd2otU
         EyF57w1dHcdSULuOp7X7gSdhUw91XVNvSWO/jKw52n+8KjDw32Ecs9JeLu6nVOFvOhf7
         jOlaPGdCEHwcjWT3ZDGDdyXPZ7c15cyFFhuCirN72tA+FwMSmQiDpHHG5MEuM5N1Nfza
         qVHg==
X-Gm-Message-State: APjAAAVoAg4E8qWWAW80PrnjsCGcYhGSVBGCf+xLBQQmX+1Lvat5hM/v
        5N8B0leCg5jpqQ+YCGwFkpYx1+A=
X-Google-Smtp-Source: APXvYqzMh3iEsEwkshKFk8HwoLVBJqZ4sHXteP4uimssoCVi4tYyD1uFTbT9FLDSbhnIZsK4uUb9Cw==
X-Received: by 2002:a25:6d05:: with SMTP id i5mr31802180ybc.520.1582261838589;
        Thu, 20 Feb 2020 21:10:38 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id a12sm840904ywa.95.2020.02.20.21.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 21:10:38 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 5/5] x86: Drop asmlinkage from syscalls
Date:   Fri, 21 Feb 2020 00:09:34 -0500
Message-Id: <20200221050934.719152-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221050934.719152-1-brgerst@gmail.com>
References: <20200221050934.719152-1-brgerst@gmail.com>
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
---
 arch/x86/entry/syscall_32.c            |  2 +-
 arch/x86/entry/syscall_64.c            |  2 +-
 arch/x86/include/asm/syscall.h         |  2 +-
 arch/x86/include/asm/syscall_wrapper.h | 20 ++++++++++----------
 4 files changed, 13 insertions(+), 13 deletions(-)

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
index 9e9259a92020..68d2231bbff0 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -8,8 +8,8 @@
 
 struct pt_regs;
 
-extern asmlinkage long __x64_sys_ni_syscall(const struct pt_regs *regs);
-extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
+extern long __x64_sys_ni_syscall(const struct pt_regs *regs);
+extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 
 /*
  * Instead of the generic __SYSCALL_DEFINEx() definition, this macro takes
@@ -59,23 +59,23 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
 
 #define __SYS_STUBx(abi, name, ...)					\
-	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
+	long __##abi##_##name(const struct pt_regs *regs);		\
 	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
-	asmlinkage long __##abi##_##name(const struct pt_regs *regs)	\
+	long __##abi##_##name(const struct pt_regs *regs)		\
 	{								\
 		return __se_##name(__VA_ARGS__);			\
 	}
 
 #define __SYS_STUB0(abi, name)						\
-	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
+	long __##abi##_##name(const struct pt_regs *regs);		\
 	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
-	asmlinkage long __##abi##_##name(const struct pt_regs *regs)	\
+	long __##abi##_##name(const struct pt_regs *regs)		\
 	{								\
 		return __do_##name();					\
 	}
 
 #define __COND_SYSCALL(abi, name)					\
-	asmlinkage __weak long						\
+	__weak long							\
 	 __##abi##_##name(const struct pt_regs *regs)			\
 	{								\
 		return sys_ni_syscall();				\
@@ -270,8 +270,8 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
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

