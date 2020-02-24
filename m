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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B320DC11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3C920880
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khOVId9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgBXSSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:18:20 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35055 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBXSSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:18:18 -0500
Received: by mail-yw1-f67.google.com with SMTP id i190so5655655ywc.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 10:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNGI++LCtmWKqhI75KNMOUUrisxGISxEFr9CPvfqxm0=;
        b=khOVId9pGjxaXOPTQWWdErrpLrGR5UOdQWa1Samy6zEYPgy/r1SKKuBMsUPvIXVKnX
         KX4E3qDoZNnuEQR46lAyYE6IOubMyQ+LhB7z/LXLvA7J5LEng0p90/VZKnrsJ2SHCAkJ
         WTr8RNgcuLtgSn/jMal9FubiN9tCx1i85db0spKMf50819/yqIhIN7Hq2c8EQ58xP6fi
         Z6rr71cU1Qies4g8dja52ZfScxjrx5T2JjFiG2fT/O8RwkhAE8SLIahYeq+i4cnN+N//
         7+Sfhwb1mQiW7NzxhrdkZBvfmfQ1ZWu5IxbrEF+ePzaMXfAYWQwnGJkVW2LRNHqXXtLn
         75Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNGI++LCtmWKqhI75KNMOUUrisxGISxEFr9CPvfqxm0=;
        b=nSBQG4eoso7u1sBfLh2hgw/jLuadThu5oCMwrJAL4IhlF2IaUeJtXhTn6seq23k/m3
         NV3XlXD4XR0+IizpPe1fFL92a6VQtnCsRqMrCaGuNeACxPFR0e/TTCqnO8dBvGQA1Rpe
         Sq8L8ZNUJri8fpjQavvSiE6LOXQwykhi0JIGm5uzrH2hNanJGTbc/qCi5+GuRUEUSJ1G
         A01cWGUlbXK/Zk3AI2zzIjzr/81kEpH8UFqq1QplC6qHOeDr24+nQY1vQ92fsDSokgmD
         lQAwg+4Nt9pzQ1Uh9kjqAMVPBUL3OoBn/eo0fy6GQ0BR4lbEesjlRqEvtH1x564bwW4f
         6hkg==
X-Gm-Message-State: APjAAAV2rBQSnKWumNGzyrSe/Vrw3fPrWPIlY7roXQTplW3z/DxXRztg
        C8Z3bcNXCDfQIheAQpUVqluhyOk=
X-Google-Smtp-Source: APXvYqzAzSS0QsmGGfFs+rQ3tKv461CGWG7/fmav8DXlBElM5jE18J0c5KlF+klVWKhYbJp/cFLl7g==
X-Received: by 2002:a81:3944:: with SMTP id g65mr39555260ywa.169.1582568296758;
        Mon, 24 Feb 2020 10:18:16 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i66sm5632383ywa.74.2020.02.24.10.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:18:16 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 3/8] x86, syscalls: Refactor COND_SYSCALL macros
Date:   Mon, 24 Feb 2020 13:17:52 -0500
Message-Id: <20200224181757.724961-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224181757.724961-1-brgerst@gmail.com>
References: <20200224181757.724961-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull the common code out from the COND_SYSCALL macros into a new
__COND_SYSCALL macro.  Also conditionalize the X64 version in preparation
for enabling syscall wrappers on 32-bit native kernels.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/syscall_wrapper.h | 44 +++++++++++++++-----------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index c13be057865f..781adf7f611f 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -35,6 +35,13 @@ struct pt_regs;
 		return __se_##name(__VA_ARGS__);			\
 	}
 
+#define __COND_SYSCALL(abi, name)					\
+	asmlinkage __weak long						\
+	__##abi##_##name(const struct pt_regs *__unused)		\
+	{								\
+		return sys_ni_syscall();				\
+	}
+
 #ifdef CONFIG_X86_64
 #define __X64_SYS_STUB0(sys_name)					\
 	__SYS_STUB0(x64, sys_name)
@@ -42,9 +49,13 @@ struct pt_regs;
 #define __X64_SYS_STUBx(x, sys_name, ...)				\
 	__SYS_STUBx(x64, sys_name,					\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
+
+#define __X64_COND_SYSCALL(sys_name)					\
+	__COND_SYSCALL(x64, sys_name)
 #else /* CONFIG_X86_64 */
 #define __X64_SYS_STUB0(sys_name)
 #define __X64_SYS_STUBx(x, sys_name, ...)
+#define __X64_COND_SYSCALL(sys_name)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_IA32_EMULATION
@@ -63,6 +74,9 @@ struct pt_regs;
 	__SYS_STUBx(ia32, compat_sys_name,				\
 		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
+#define __IA32_COMPAT_COND_SYSCALL(compat_sys_name)			\
+	__COND_SYSCALL(ia32, compat_sys_name)
+
 #define __IA32_SYS_STUB0(sys_name)					\
 	__SYS_STUB0(ia32, sys_name)
 
@@ -70,15 +84,8 @@ struct pt_regs;
 	__SYS_STUBx(ia32, sys_name,					\
 		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
-#define COND_SYSCALL(name)							\
-	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
-	{									\
-		return sys_ni_syscall();					\
-	}									\
-	asmlinkage __weak long __ia32_sys_##name(const struct pt_regs *__unused)\
-	{									\
-		return sys_ni_syscall();					\
-	}
+#define __IA32_COND_SYSCALL(sys_name)					\
+	__COND_SYSCALL(ia32, sys_name)
 
 #define SYS_NI(name)							\
 	SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);		\
@@ -87,8 +94,10 @@ struct pt_regs;
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUB0(compat_sys_name)
 #define __IA32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)
+#define __IA32_COMPAT_COND_SYSCALL(compat_sys_name)
 #define __IA32_SYS_STUB0(sys_name)
 #define __IA32_SYS_STUBx(x, sys_name, ...)
+#define __IA32_COND_SYSCALL(sys_name)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -105,9 +114,12 @@ struct pt_regs;
 	__SYS_STUBx(x32, compat_sys_name,				\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
+#define __X32_COMPAT_COND_SYSCALL(compat_sys_name)			\
+	__COND_SYSCALL(x32, compat_sys_name)
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(compat_sys_name)
 #define __X32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)
+#define __X32_COMPAT_COND_SYSCALL(compat_sys_name)
 #endif /* CONFIG_X86_X32 */
 
 
@@ -147,8 +159,8 @@ struct pt_regs;
  * kernel/time/posix-stubs.c to cover this case as well.
  */
 #define COND_SYSCALL_COMPAT(name) 					\
-	cond_syscall(__ia32_compat_sys_##name);				\
-	cond_syscall(__x32_compat_sys_##name)
+	__IA32_COMPAT_COND_SYSCALL(compat_sys_##name)			\
+	__X32_COMPAT_COND_SYSCALL(compat_sys_##name)
 
 #define COMPAT_SYS_NI(name)						\
 	SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers);	\
@@ -220,13 +232,9 @@ struct pt_regs;
 	static asmlinkage long						\
 	__do_sys_##sname(const struct pt_regs *__unused)
 
-#ifndef COND_SYSCALL
-#define COND_SYSCALL(name) 							\
-	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
-	{									\
-		return sys_ni_syscall();					\
-	}
-#endif
+#define COND_SYSCALL(name)						\
+	__X64_COND_SYSCALL(sys_##name)					\
+	__IA32_COND_SYSCALL(sys_##name)
 
 #ifndef SYS_NI
 #define SYS_NI(name) SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);
-- 
2.24.1

