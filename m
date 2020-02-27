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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191B7C4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA12C2469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eht7sMpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgB0N3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:29:02 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33304 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgB0N2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:28:42 -0500
Received: by mail-yw1-f68.google.com with SMTP id j186so949245ywe.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HqhHugz76OgagodwitVumfy54toBEGqyFpWBMzh2Igg=;
        b=Eht7sMpVlKQ4Dyi5IhGT0tCFReHf2SVD00KqWXiUiNuyTiiaZYL8sYIuEYsTgLG/lT
         e362OZmYRt0CefDvrAnNaoSF0Ft0jHSalvyR05DwCv33eZZGPMJ+fuhbT7XfGocnWR9H
         SKC75r4Q2Fws0wa6m6w0VD8GHqF6G+pMWVI2uGzsdG8HK62GYzfGTw/tlHNBhZb+eucI
         3jrIWCDrWuw+yAWhJeNGj7UULUWiCAwpR8UkfgzKsdl5HxiAYe6ydwchn6uRkyqpKQq8
         htMzqkiidyF4vITk+pjTqDRzVWCsU6guqdYj5Kj93SGo9vJOzQZ3SBCFPGwJ0ETvDgQL
         7ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqhHugz76OgagodwitVumfy54toBEGqyFpWBMzh2Igg=;
        b=gnR/zvveqGBCWmXw21hBw3I4FiKSgKRMkdu/bNRApQvgtPUKepwaL2Fothqh7ME2NF
         9hOYTAAsZOEj6vBjWoSzCNzda4Ymh/UNUqs0BHhuomLZJmSilBS9U85VKsNxdUk1jiS9
         +HFVqih4z0eJTJcC2+Sj1Cl9wwXsRHAHy0jgab4z/zQRAFZiZfB4jkv7vtlRf9+x0lJt
         qyNaEUxhjvt2HekvzgKp25exxJ+EUaNkUAdBoqZRiY/w+e+ELzDxA2l26SjrZX1VNp7T
         TtOQr+E3+wPq3iLvR6E3Tpm57uNsTmTTiXNga7goKslE/HE001CfCfEqg+JMjdcP1WAU
         B+LA==
X-Gm-Message-State: APjAAAVeik8DEFXRMdUesoLbzE/tFk5qe1EaFjiwfMsasjGCqcGzNKr1
        PhBzEqQIFDaz67biELjvlJFEIm4=
X-Google-Smtp-Source: APXvYqwd4egXAglBtdQJyNImVG+ueLqsbri0pUpTE5G2TPjsqlIKmDHi5aAYIx9cGdUvbz8JtBRjcw==
X-Received: by 2002:a25:b904:: with SMTP id x4mr3986460ybj.478.1582810120975;
        Thu, 27 Feb 2020 05:28:40 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j23sm2442759ywb.93.2020.02.27.05.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:28:40 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 4/8] x86, syscalls: Refactor SYS_NI macros
Date:   Thu, 27 Feb 2020 08:28:22 -0500
Message-Id: <20200227132826.195669-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227132826.195669-1-brgerst@gmail.com>
References: <20200227132826.195669-1-brgerst@gmail.com>
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
---
 arch/x86/include/asm/syscall_wrapper.h | 32 ++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index aaafc8421a2d..b19b696b1cb4 100644
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
 
 
@@ -163,8 +177,8 @@ struct pt_regs;
 	__X32_COMPAT_COND_SYSCALL(name)
 
 #define COMPAT_SYS_NI(name)						\
-	SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers);	\
-	SYSCALL_ALIAS(__x32_compat_sys_##name, sys_ni_posix_timers)
+	__IA32_COMPAT_SYS_NI(name)					\
+	__X32_COMPAT_SYS_NI(name)
 
 #endif /* CONFIG_COMPAT */
 
@@ -236,9 +250,9 @@ struct pt_regs;
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

