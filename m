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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5E5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62672071C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9J5/iM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgCMTwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:52:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43350 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgCMTwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id x1so9844005qkx.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avGZMSb1iKPVA/GqEJwtJuNvc7eOmE5dr3Lq8Ilmmas=;
        b=f9J5/iM3PgfIkqO/AiGdyq4Gu9JzJCDiT5ITcoEngsbfougYp3zQP0qR6uuFds017n
         +RPptc79ZAM02I6n4Q0uULlk+Dx8DoI7AD5yUkWTvQPVaZRTg0Ba79FfI+ahmWTTHCrT
         86Dxswo/ZIZPMOW6HFh9qYBWP91MoaRtwCX/qhU1xsPzZZQse3lAv+v412+zpIpSOSTr
         U7XEXz+Hby76Q4ba39iFSwg6zRagZ6H233bi6zK8q2vN3bqKRL4VpNbtQe1PG1ncbyaj
         fP0/J+zk4Y8uHiyYZGPAWP+7cYQSBj9b8xK/0577Mhax69Wf33QwynEQEjBMSc5CcArv
         CaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avGZMSb1iKPVA/GqEJwtJuNvc7eOmE5dr3Lq8Ilmmas=;
        b=ukIS8X+CWXlD0pUs3qMmr3vYP7nDAEy9yrxIvPSJIUJVh90yCMA68ZjbeGr+30t4T3
         Gfc5RrAsskf+tdsErIA4YUxaAqJulnK/2/WCKLFi5FhW5STrX4J3o5dTVdoipCZQmmN/
         GeNC+vanI4hlYz8bPTKTd+OBd2QLksMjFQkyBkqKCWNvVGeVQrUtKz4hNm2rjgW9cTQA
         QCObm+uSLFOxOEiE6tXME7aPG6kYK62aDFaTbWsuDEuNaM8v8EOnpHoP6BZfLffqc9W+
         FpuzuU7yvfZkYstE1hnYKWC3BZjin8ymdtDKy5HkHg/K07XMx+5d/GCXbrCVv+Iv4/2r
         AE4Q==
X-Gm-Message-State: ANhLgQ3kSSCR3bMEivmaW5lxntux56MV6CN2Q+j6T+1NiAIOKasxTY/k
        Rvzx4C85Jbqqi9PJdAlzLKNj0jU=
X-Google-Smtp-Source: ADFU+vvFRkYklZIDNY6UFp7Y5TIgvTyP3ya5n3YUmFQGhJlwfTE2gUtmIF9MdSsds7q1dxw9/TJtFA==
X-Received: by 2002:a37:b045:: with SMTP id z66mr12729420qke.297.1584129138588;
        Fri, 13 Mar 2020 12:52:18 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:18 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 07/18] x86-64: Split X32 syscall table into its own file
Date:   Fri, 13 Mar 2020 15:51:33 -0400
Message-Id: <20200313195144.164260-8-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since X32 has its own syscall table now, move it to a separate file.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/Makefile      |  1 +
 arch/x86/entry/syscall_64.c  | 27 ++-------------------------
 arch/x86/entry/syscall_x32.c | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 25 deletions(-)
 create mode 100644 arch/x86/entry/syscall_x32.c

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 06fc70cf5433..85eb381259c2 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -14,4 +14,5 @@ obj-y				+= vdso/
 obj-y				+= vsyscall/
 
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
+obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
 
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 058dc1b73e96..efb85c6dce13 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,14 +8,13 @@
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
+#define __SYSCALL_X32(nr, sym, qual)
+
 #define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
-#define __SYSCALL_X32(nr, sym, qual) __SYSCALL_64(nr, sym, qual)
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
-#undef __SYSCALL_X32
 
 #define __SYSCALL_64(nr, sym, qual) [nr] = sym,
-#define __SYSCALL_X32(nr, sym, qual)
 
 asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	/*
@@ -25,25 +24,3 @@ asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	[0 ... __NR_syscall_max] = &__x64_sys_ni_syscall,
 #include <asm/syscalls_64.h>
 };
-
-#undef __SYSCALL_64
-#undef __SYSCALL_X32
-
-#ifdef CONFIG_X86_X32_ABI
-
-#define __SYSCALL_64(nr, sym, qual)
-#define __SYSCALL_X32(nr, sym, qual) [nr] = sym,
-
-asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_syscall_x32_max+1] = {
-	/*
-	 * Smells like a compiler bug -- it doesn't work
-	 * when the & below is removed.
-	 */
-	[0 ... __NR_syscall_x32_max] = &__x64_sys_ni_syscall,
-#include <asm/syscalls_64.h>
-};
-
-#undef __SYSCALL_64
-#undef __SYSCALL_X32
-
-#endif
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
new file mode 100644
index 000000000000..d144ced7f582
--- /dev/null
+++ b/arch/x86/entry/syscall_x32.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* System call table for x32 ABI. */
+
+#include <linux/linkage.h>
+#include <linux/sys.h>
+#include <linux/cache.h>
+#include <linux/syscalls.h>
+#include <asm/asm-offsets.h>
+#include <asm/syscall.h>
+
+#define __SYSCALL_64(nr, sym, qual)
+
+#define __SYSCALL_X32(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
+#include <asm/syscalls_64.h>
+#undef __SYSCALL_X32
+
+#define __SYSCALL_X32(nr, sym, qual) [nr] = sym,
+
+asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_syscall_x32_max+1] = {
+	/*
+	 * Smells like a compiler bug -- it doesn't work
+	 * when the & below is removed.
+	 */
+	[0 ... __NR_syscall_x32_max] = &__x64_sys_ni_syscall,
+#include <asm/syscalls_64.h>
+};
-- 
2.24.1

