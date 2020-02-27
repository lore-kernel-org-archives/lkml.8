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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAB7C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D82246AA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD1MNW5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgB0N2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:28:43 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42941 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgB0N2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:28:41 -0500
Received: by mail-yw1-f65.google.com with SMTP id n127so2953363ywd.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9VQxCyM2hvTyJaZ1S03xRmBtMDIN1aB0IF58zWd9TY=;
        b=aD1MNW5zBnBrfiJEbSTee9zYXDYCetD4QRjiCgECC/2dsaQj/R2Po2r6ZDqI8dtYgf
         EN9HM5c37LVZBFZO8xpbJTs0CpL2lbdfWN8tiWXpftewXVe/FH79OTHnexXR83+DwylZ
         U1DLDAoyxtzs+Bd6zX2lM6wMpaYkk/5XuluS55VkW8FdTpPUi3hMz+tKQg4KiRJnypRQ
         yuIScgYhzB01iUOcB03ajAZQ74l8CZO7ZA1RmW8hK5Yz36ZYaXlnNNeKFuiUw6Dgo2uB
         496zFt/3sHLkhbwAFc8Q6zOKHCI+DqwBdbDBGl1dtCzK1t8R0fds3w1fbEpiQs022pTz
         n1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9VQxCyM2hvTyJaZ1S03xRmBtMDIN1aB0IF58zWd9TY=;
        b=S7UyxStkOF1PsVEBCcQI1BzTdZGPbMSUdexPsqcEtj7SO8XqnjA9yNr3XM3ozll6zg
         L/yYeBk7kEBnuhj25ILOf/VhdKdho1DTu7KQcaLKn62fJX+O5Brz1eKyp5zFH/L0zwxf
         mwSfrXHM5DQgx5h5WuqXZBwuqfdBKTP3fW3yGTAfQ8naj+34lBXEmQzh26IQh6B8zEA2
         x0uS6qZL+hkkumU1O3FMZpSUhoN150fUpIFjrtJgI1CDron7K2a92hY8IDJgfPUs+HdD
         obboNaUhYiysJzBfHiHeJK7ZG34O/NBorD3V7aVPK5YNzGtjAUZzQG7jLjpsm91kx+Z9
         1cvg==
X-Gm-Message-State: APjAAAU9lDKvv5snh7DWURoQjCzKjswHCVP6gBbwUMDgbLTa6lO3Jidr
        suN/P11RJ8OBG0DXj+bC7hELe84=
X-Google-Smtp-Source: APXvYqwe2foaLn3D391WyRDFr3UDb+Y5aKXNdTrXLAya5Z1qfoGxVmH9SKpw1NHg74KnjC7aHo9mGg==
X-Received: by 2002:a25:8810:: with SMTP id c16mr3807298ybl.270.1582810119269;
        Thu, 27 Feb 2020 05:28:39 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j23sm2442759ywb.93.2020.02.27.05.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:28:38 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 3/8] x86, syscalls: Refactor COND_SYSCALL macros
Date:   Thu, 27 Feb 2020 08:28:21 -0500
Message-Id: <20200227132826.195669-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227132826.195669-1-brgerst@gmail.com>
References: <20200227132826.195669-1-brgerst@gmail.com>
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
index 2b1ae55c52ee..aaafc8421a2d 100644
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
 #define __X64_SYS_STUB0(name)						\
 	__SYS_STUB0(x64, sys_##name)
@@ -42,9 +49,13 @@ struct pt_regs;
 #define __X64_SYS_STUBx(x, name, ...)					\
 	__SYS_STUBx(x64, sys##name,					\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
+
+#define __X64_COND_SYSCALL(name)					\
+	__COND_SYSCALL(x64, sys_##name)
 #else /* CONFIG_X86_64 */
 #define __X64_SYS_STUB0(name)
 #define __X64_SYS_STUBx(x, name, ...)
+#define __X64_COND_SYSCALL(name)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_IA32_EMULATION
@@ -63,6 +74,9 @@ struct pt_regs;
 	__SYS_STUBx(ia32, compat_sys##name,				\
 		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
+#define __IA32_COMPAT_COND_SYSCALL(name)				\
+	__COND_SYSCALL(ia32, compat_sys_##name)
+
 #define __IA32_SYS_STUB0(name)						\
 	__SYS_STUB0(ia32, sys_##name)
 
@@ -70,15 +84,8 @@ struct pt_regs;
 	__SYS_STUBx(ia32, sys##name,					\
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
+#define __IA32_COND_SYSCALL(name)					\
+	__COND_SYSCALL(ia32, sys_##name)
 
 #define SYS_NI(name)							\
 	SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);		\
@@ -87,8 +94,10 @@ struct pt_regs;
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUB0(name)
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
+#define __IA32_COMPAT_COND_SYSCALL(name)
 #define __IA32_SYS_STUB0(name)
 #define __IA32_SYS_STUBx(x, name, ...)
+#define __IA32_COND_SYSCALL(name)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -105,9 +114,12 @@ struct pt_regs;
 	__SYS_STUBx(x32, compat_sys##name,				\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
+#define __X32_COMPAT_COND_SYSCALL(name)					\
+	__COND_SYSCALL(x32, compat_sys_##name)
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
+#define __X32_COMPAT_COND_SYSCALL(name)
 #endif /* CONFIG_X86_X32 */
 
 
@@ -147,8 +159,8 @@ struct pt_regs;
  * kernel/time/posix-stubs.c to cover this case as well.
  */
 #define COND_SYSCALL_COMPAT(name) 					\
-	cond_syscall(__ia32_compat_sys_##name);				\
-	cond_syscall(__x32_compat_sys_##name)
+	__IA32_COMPAT_COND_SYSCALL(name)				\
+	__X32_COMPAT_COND_SYSCALL(name)
 
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
+	__X64_COND_SYSCALL(name)					\
+	__IA32_COND_SYSCALL(name)
 
 #ifndef SYS_NI
 #define SYS_NI(name) SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);
-- 
2.24.1

