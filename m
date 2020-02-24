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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C39C11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C6020732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FswnqJsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBXSSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:18:21 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37939 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgBXSST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:18:19 -0500
Received: by mail-yb1-f194.google.com with SMTP id x9so2976700ybl.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 10:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6mKLcD2LqOc6BL6XFCqcLnf/wXzkZpY8qut1p/qNDG0=;
        b=FswnqJsLEHbwSmB29jNEJ1dsZfvyF7RUJuWyR/bkUBc8fp82V8UDlGoeyeRNrWLeCl
         sNd2y09uarBYTZ/SUAvmoyzhZL5L0cEPOEjYiEdAsyMP8gC8JfWz8pYrFqHz4WR8OQ22
         9C92xbfZT5cOisV5vI7JhiJ8Ksx75SYi4fMVz1tnPjKcExuyqTncxAvbrTe5kaOWBJ+l
         igcGwIMLDQbjPHuh9tc4Li7yUhrBeO/ErC954XOkOEciMb8oFVzuTr+fgyna65PLLltR
         1ZBKIfZGlFZCg3V7QdR2zphag59AfI3AvpVYy7sesGSmlEsqChllWSks8DcDi5GiTBNM
         OsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6mKLcD2LqOc6BL6XFCqcLnf/wXzkZpY8qut1p/qNDG0=;
        b=a5vxsHZJJVYGyEuGm6pZajEdhSac6f+QAW/k4vKO58ZIPlzT6dO7xN0qdMeRUK2RuC
         J2uWFGOkxdDRuN4TmH6+7umCHCnUsR+a/GyZKn1FFE1/TPlFzdiTQ4TDB9TKBPLfkki9
         NlwDMzYfrhEsu2Vmvupxd3SZhgDdbbNM3AoyB1TD1BrpTLoaR0F5dV7k3vdGU8JmqvNW
         L/99OpSXbZvQgZJ7jG7PCdrVLJhi4+IocTTfszXNdsl+kCfMKLxqga/gi4cqgd+kgEFm
         yfec5W7yTultVKQJ0mwlHaNlmnKCVfEgDihnvAY7j9pMt09DLUvBXdmNxia/LN3F4xMa
         yPkw==
X-Gm-Message-State: APjAAAX0xrzI1SWky61AUHKCwRrTivajDXCgJMmm73t7VsVS4+JJOqeP
        HTflaFKw6Wyr+cv9D9gV00mPJfE=
X-Google-Smtp-Source: APXvYqy8FFqPZJ930N3vkAsLPT2rKPDZufxDCzXBv2zF8QpAJzyGkOBjlvDkZT2c4Y4CZ67VrI5fow==
X-Received: by 2002:a25:d6c4:: with SMTP id n187mr3686382ybg.12.1582568297869;
        Mon, 24 Feb 2020 10:18:17 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i66sm5632383ywa.74.2020.02.24.10.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:18:17 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 4/8] x86, syscalls: Refactor SYS_NI macros
Date:   Mon, 24 Feb 2020 13:17:53 -0500
Message-Id: <20200224181757.724961-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224181757.724961-1-brgerst@gmail.com>
References: <20200224181757.724961-1-brgerst@gmail.com>
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
index 781adf7f611f..1166635cd841 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -42,6 +42,9 @@ struct pt_regs;
 		return sys_ni_syscall();				\
 	}
 
+#define __SYS_NI(abi, name)						\
+	SYSCALL_ALIAS(__##abi##_##name, sys_ni_posix_timers)
+
 #ifdef CONFIG_X86_64
 #define __X64_SYS_STUB0(sys_name)					\
 	__SYS_STUB0(x64, sys_name)
@@ -52,10 +55,14 @@ struct pt_regs;
 
 #define __X64_COND_SYSCALL(sys_name)					\
 	__COND_SYSCALL(x64, sys_name)
+
+#define __X64_SYS_NI(sys_name)						\
+	__SYS_NI(x64, sys_name)
 #else /* CONFIG_X86_64 */
 #define __X64_SYS_STUB0(sys_name)
 #define __X64_SYS_STUBx(x, sys_name, ...)
 #define __X64_COND_SYSCALL(sys_name)
+#define __X64_SYS_NI(sys_name)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_IA32_EMULATION
@@ -77,6 +84,9 @@ struct pt_regs;
 #define __IA32_COMPAT_COND_SYSCALL(compat_sys_name)			\
 	__COND_SYSCALL(ia32, compat_sys_name)
 
+#define __IA32_COMPAT_SYS_NI(compat_sys_name)				\
+	__SYS_NI(ia32, compat_sys_name)
+
 #define __IA32_SYS_STUB0(sys_name)					\
 	__SYS_STUB0(ia32, sys_name)
 
@@ -87,17 +97,17 @@ struct pt_regs;
 #define __IA32_COND_SYSCALL(sys_name)					\
 	__COND_SYSCALL(ia32, sys_name)
 
-#define SYS_NI(name)							\
-	SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);		\
-	SYSCALL_ALIAS(__ia32_sys_##name, sys_ni_posix_timers)
-
+#define __IA32_SYS_NI(sys_name)						\
+	__SYS_NI(ia32, sys_name)
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUB0(compat_sys_name)
 #define __IA32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)
 #define __IA32_COMPAT_COND_SYSCALL(compat_sys_name)
+#define __IA32_COMPAT_SYS_NI(compat_sys_name)
 #define __IA32_SYS_STUB0(sys_name)
 #define __IA32_SYS_STUBx(x, sys_name, ...)
 #define __IA32_COND_SYSCALL(sys_name)
+#define __IA32_SYS_NI(sys_name)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -116,10 +126,14 @@ struct pt_regs;
 
 #define __X32_COMPAT_COND_SYSCALL(compat_sys_name)			\
 	__COND_SYSCALL(x32, compat_sys_name)
+
+#define __X32_COMPAT_SYS_NI(compat_sys_name)				\
+	__SYS_NI(x32, compat_sys_name)
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(compat_sys_name)
 #define __X32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)
 #define __X32_COMPAT_COND_SYSCALL(compat_sys_name)
+#define __X32_COMPAT_SYS_NI(compat_sys_name)
 #endif /* CONFIG_X86_X32 */
 
 
@@ -163,8 +177,8 @@ struct pt_regs;
 	__X32_COMPAT_COND_SYSCALL(compat_sys_##name)
 
 #define COMPAT_SYS_NI(name)						\
-	SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers);	\
-	SYSCALL_ALIAS(__x32_compat_sys_##name, sys_ni_posix_timers)
+	__IA32_COMPAT_SYS_NI(compat_sys_##name)				\
+	__X32_COMPAT_SYS_NI(compat_sys_##name)
 
 #endif /* CONFIG_COMPAT */
 
@@ -236,9 +250,9 @@ struct pt_regs;
 	__X64_COND_SYSCALL(sys_##name)					\
 	__IA32_COND_SYSCALL(sys_##name)
 
-#ifndef SYS_NI
-#define SYS_NI(name) SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);
-#endif
+#define SYS_NI(name)							\
+	__X64_SYS_NI(sys_##name)					\
+	__IA32_SYS_NI(sys_##name)
 
 
 /*
-- 
2.24.1

