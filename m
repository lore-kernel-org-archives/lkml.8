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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C98C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1026C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn84ucjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgCMTxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:53:15 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45476 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgCMTwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:16 -0400
Received: by mail-qv1-f68.google.com with SMTP id h20so1366778qvr.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdLgZrHw1sAMv8bl4fbMC3y09BZ5sVeBir4EgIezMcA=;
        b=Kn84ucjhCAHCMYTbkYpqCwnDB1ttUkrlKerbPULbEhfV9LaeKRI2Pges7AlVxupHHA
         N+FY+moGLEsmuUw1HSFk0WlPiea4uq6pqqn8P3rJnzB9gtVOq0zDxBdPAwq7ZZ/0kL3c
         MUuGUU244+gAwJaDEHi7VYl1Bt5dU2bz66s1p1wI+RpOcC4lDy7CHzqqw7TIl5wcn9QD
         4SA2T75t7e5LPAEBgNjlYM7iF28gyihhNs4ZROIGv6hS8XJgbYaeNyfIEYZeEN1nigdF
         +rhguaQOe0Rae5yj4D4CYuMYHgPv4bJshi50WIA9FK6/jV+vWERnvknWTynPJCNHPemF
         oPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdLgZrHw1sAMv8bl4fbMC3y09BZ5sVeBir4EgIezMcA=;
        b=asK6aFCRRHebFZYjyHkKOrAiYXD9lyMtXn369bSpzVvIBMbuHOZq0R4wme0AWwys5z
         y3pm2N+7U1XN9z5MV5VqWS/bAEvl7PURbfvuH3yscTK3q9BYPEzIVwqn/fLHx6wKX0XK
         cebfAlMT7tIdFueIw/gmtcZhzHwutWetaSBMo9401xRH7mD1Nh/0VkGeItM/rwI9m3hJ
         LKmVsNRbeUo30aQ7pS5jU42PDAKrqG8QWiECZjzuaa7r6VZLrr9KdBXWpnzmoFRCOUSP
         32Kz66KLx8cetSNeAuCScHutB97f2Knk4abwE8mHp+f0bjQl5jnZ78y+OOskN2150hrT
         4nLg==
X-Gm-Message-State: ANhLgQ19Vuz0IqTktzbOcZX8DzhwE5naUxCocxV1YrvRkXCChGzdCIqx
        3IDpflguUq2O4JKm21fMuRQagkA=
X-Google-Smtp-Source: ADFU+vsTFI5LXlBi7fApkaWm3RdMF+T3zI90B51gcznssvXhLewcEwEM8cZMlroddNlkpf1PFCLejQ==
X-Received: by 2002:a0c:e7c3:: with SMTP id c3mr14094176qvo.62.1584129134679;
        Fri, 13 Mar 2020 12:52:14 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:14 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 04/18] x86, syscalls: Refactor SYS_NI macros
Date:   Fri, 13 Mar 2020 15:51:30 -0400
Message-Id: <20200313195144.164260-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull the common code out from the SYS_NI macros into a new __SYS_NI macro.
Also conditionalize the X64 version in preparation for enabling syscall
wrappers on 32-bit native kernels.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/syscall_wrapper.h | 32 ++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 0117b25e6753..1d96ccebc0d2 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -42,6 +42,9 @@ struct pt_regs;
 		return sys_ni_syscall();				\
 	}
 
+#define __SYS_NI(abi, name)						\
+	SYSCALL_ALIAS(__##abi##_##name, sys_ni_posix_timers)
+
 #ifdef CONFIG_X86_64
 #define __X64_SYS_STUB0(name)						\
 	__SYS_STUB0(x64, sys_##name)
@@ -52,10 +55,14 @@ struct pt_regs;
 
 #define __X64_COND_SYSCALL(name)					\
 	__COND_SYSCALL(x64, sys_##name)
+
+#define __X64_SYS_NI(name)						\
+	__SYS_NI(x64, sys_##name)
 #else /* CONFIG_X86_64 */
 #define __X64_SYS_STUB0(name)
 #define __X64_SYS_STUBx(x, name, ...)
 #define __X64_COND_SYSCALL(name)
+#define __X64_SYS_NI(name)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_IA32_EMULATION
@@ -77,6 +84,9 @@ struct pt_regs;
 #define __IA32_COMPAT_COND_SYSCALL(name)				\
 	__COND_SYSCALL(ia32, compat_sys_##name)
 
+#define __IA32_COMPAT_SYS_NI(name)					\
+	__SYS_NI(ia32, compat_sys_##name)
+
 #define __IA32_SYS_STUB0(name)						\
 	__SYS_STUB0(ia32, sys_##name)
 
@@ -87,17 +97,17 @@ struct pt_regs;
 #define __IA32_COND_SYSCALL(name)					\
 	__COND_SYSCALL(ia32, sys_##name)
 
-#define SYS_NI(name)							\
-	SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);		\
-	SYSCALL_ALIAS(__ia32_sys_##name, sys_ni_posix_timers)
-
+#define __IA32_SYS_NI(name)						\
+	__SYS_NI(ia32, sys_##name)
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUB0(name)
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
 #define __IA32_COMPAT_COND_SYSCALL(name)
+#define __IA32_COMPAT_SYS_NI(name)
 #define __IA32_SYS_STUB0(name)
 #define __IA32_SYS_STUBx(x, name, ...)
 #define __IA32_COND_SYSCALL(name)
+#define __IA32_SYS_NI(name)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -116,10 +126,14 @@ struct pt_regs;
 
 #define __X32_COMPAT_COND_SYSCALL(name)					\
 	__COND_SYSCALL(x32, compat_sys_##name)
+
+#define __X32_COMPAT_SYS_NI(name)					\
+	__SYS_NI(x32, compat_sys_##name)
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #define __X32_COMPAT_COND_SYSCALL(name)
+#define __X32_COMPAT_SYS_NI(name)
 #endif /* CONFIG_X86_X32 */
 
 
@@ -158,8 +172,8 @@ struct pt_regs;
 	__X32_COMPAT_COND_SYSCALL(name)
 
 #define COMPAT_SYS_NI(name)						\
-	SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers);	\
-	SYSCALL_ALIAS(__x32_compat_sys_##name, sys_ni_posix_timers)
+	__IA32_COMPAT_SYS_NI(name)					\
+	__X32_COMPAT_SYS_NI(name)
 
 #endif /* CONFIG_COMPAT */
 
@@ -231,9 +245,9 @@ struct pt_regs;
 	__X64_COND_SYSCALL(name)					\
 	__IA32_COND_SYSCALL(name)
 
-#ifndef SYS_NI
-#define SYS_NI(name) SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);
-#endif
+#define SYS_NI(name)							\
+	__X64_SYS_NI(name)						\
+	__IA32_SYS_NI(name)
 
 
 /*
-- 
2.24.1

