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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F54C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662982084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv2kOs0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgBXSS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:18:27 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46793 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgBXSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:18:24 -0500
Received: by mail-yw1-f67.google.com with SMTP id z141so5619567ywd.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 10:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Faej6XlslQuCVWI/UEs1hdwz5IqgDD2MoTe70t9WRVI=;
        b=cv2kOs0xp072JeQk106T9FTmSHC8m5CSUzWWWghGYjCVCAgoQM+TzQhGkplqZmFxbd
         ykC3thJzLxFZiPueRklzXGM5n1g/HU3R5rxgRXaxT2EyDhPseHoKmtGHwM2MNtjfiSxk
         +JNexfj9wETdH02ZtTAXB7/+JkgjpR1gOcZLPznxxamJp+B4UV7YNRMa52MtmHl7ZrnU
         hcYedmJU0OLtjUUXYk/KiBiAGXZs7gnwF44ns7H2hCE7CikKbGTw8JgXL5dSs/UGq1Fw
         w7CHtX36jyQHHR/DtlLG1egHqQGMymZ1QrlW3Zgv6MS1E3iOC4CjhWpzNKBH5enaim5v
         v8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Faej6XlslQuCVWI/UEs1hdwz5IqgDD2MoTe70t9WRVI=;
        b=PVJ5vW/sT5L06cKpQTNZ9zfrA/v5SJCwSR1fZ3d1INxwlcDT1B03GcFT0usEPaCvIi
         SBdvUdF7v4Ikz3aqNyA0+DZ2SZ51BGIcCTzsmGTNrCPJZM0PYxGIE5NwrYn1d8w8NF50
         K5PUD5jjc+z8SljA8gtNoiZZl5RyKEX7YDMGmp4yOQAPYgS7dze20x1kqhwgLBn7km78
         cZytMr/dxhVgYsAYFec1pff3Pyu34DQtgCJp+qCl15/kPZXOwh1Uw/oHlOzEfp4gdmQZ
         q6fCTFIPEQtpL/GHX1RuySAUzRblzHMFtbxD7G39nNpqIbIX+g9xC4mZs+KcsQbkAGSM
         FIiQ==
X-Gm-Message-State: APjAAAURAPGl4BWUr45d29Geso22WE9e2ZrEPeHzFCeIv7GlKBiiWcjO
        wg29DDnNPy6aOFt1EgxjaPAKYoU=
X-Google-Smtp-Source: APXvYqzMmarC1fkh7NRSHxK9kDgjzWydT8ToKRbNKcBn+87p/GaeSAjXL1v1SR0bCbG8EJTA5AWaIw==
X-Received: by 2002:a81:4c42:: with SMTP id z63mr46066281ywa.24.1582568303123;
        Mon, 24 Feb 2020 10:18:23 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i66sm5632383ywa.74.2020.02.24.10.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:18:22 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 8/8] x86: Drop asmlinkage from syscalls
Date:   Mon, 24 Feb 2020 13:17:57 -0500
Message-Id: <20200224181757.724961-9-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224181757.724961-1-brgerst@gmail.com>
References: <20200224181757.724961-1-brgerst@gmail.com>
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
index f793f3b990a8..9b399f073642 100644
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
@@ -183,11 +182,11 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * of them.
  */
 #define COMPAT_SYSCALL_DEFINE0(name)					\
-	static asmlinkage long						\
+	static long							\
 	__do_compat_sys_##name(const struct pt_regs *__unused);		\
 	__IA32_COMPAT_SYS_STUB0(compat_sys_##name)			\
 	__X32_COMPAT_SYS_STUB0(compat_sys_##name)			\
-	static asmlinkage long						\
+	static long							\
 	__do_compat_sys_##name(const struct pt_regs *__unused)
 
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)				\
@@ -244,12 +243,10 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  */
 #define SYSCALL_DEFINE0(sname)						\
 	SYSCALL_METADATA(_##sname, 0);					\
-	static asmlinkage long						\
-	__do_sys_##sname(const struct pt_regs *__unused);		\
+	static long __do_sys_##sname(const struct pt_regs *__unused);	\
 	__X64_SYS_STUB0(sys_##sname)					\
 	__IA32_SYS_STUB0(sys_##sname)					\
-	static asmlinkage long						\
-	__do_sys_##sname(const struct pt_regs *__unused)
+	static long __do_sys_##sname(const struct pt_regs *__unused)
 
 #define COND_SYSCALL(name)						\
 	__X64_COND_SYSCALL(sys_##name)					\
@@ -264,8 +261,8 @@ extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
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

