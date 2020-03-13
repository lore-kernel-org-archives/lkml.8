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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3DDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F2B20752
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SopNcbve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgCMTwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:52:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45569 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgCMTwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id c145so14668002qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9WPpNVWgUFBL/+n4blULIdPA+VB0XbLtNGA7+D/vfY=;
        b=SopNcbveCeNcQ8/5kYVCRpJI9XQNL8VFHCRyCZIxFLYaNO3Wp6AWDqSx6uEXAa+qBQ
         QR6+ktIVe75eUDxyZx356Tt/o9xZJ8vtnzP989nqGuKbfsNBvpM6HgtAXuPI3ZjTBqCI
         VoVywUjwa21op3LBvWBzp6eQSDIm3XtubcnxEbSQbOrnlP7ALlrQIAeUofCZXu6ScdoG
         vOezGGpTH9RUnMHIIpk6v/qXU6UkSxDdjkvB10EhgC4ufWDb6ZZpzTjpzOX6S7qo6qgX
         j8d4N1epwFAyvHfHGr3ZEXC2PaSm49BXZc/oJsp+jybEctqWd995k0wZ+I6qJs6/Vo2F
         gyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9WPpNVWgUFBL/+n4blULIdPA+VB0XbLtNGA7+D/vfY=;
        b=qwHvcDsUGkcdWagfhQGssTTxU+9CE7v9D5kRdIlJEpc/FTDDDvTOtKrQNB3ZhiMHDT
         41Mf3Am693H7QMcxGXdqYYeLJja90OfsNcoyZNtCI4riZcQgg0V76ksbph73Tt1Rt9t+
         1TQsE8EO0+MQQWIQ0uJG1PwwpzHUPniBzNGUGwSGKhVP7XSJMzmfQ1qQnS9nuEUCPZIs
         +wgg0K828ve4JABr6297OKkBVjCyPgge4BwSICdbm0cWVucYzxK0eEKim5CsWAexm5E7
         lwrly7kT1h13b+uYIKFX/xIm8NGaxC9RxmhjsJrswRfYL9iwRMWSj8V4rhzjcV545I6K
         G2Fw==
X-Gm-Message-State: ANhLgQ3sYITsI0aGKLFict/G4ODfEguXYurRpnNSVuEZG1HAWhrgtdUM
        Oih94c/Kp+6eO8JH/veSmaJAVus=
X-Google-Smtp-Source: ADFU+vuXTSXSSNt21hiHVt63jiecQvbSDgPMo6KJulyIW5gIOKthBWEvKGYQLAB8X6O64Y2VoT8YUQ==
X-Received: by 2002:a37:6e42:: with SMTP id j63mr14749941qkc.400.1584129142406;
        Fri, 13 Mar 2020 12:52:22 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:22 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 10/18] x86: Remove syscall qualifier support
Date:   Fri, 13 Mar 2020 15:51:36 -0400
Message-Id: <20200313195144.164260-11-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syscall qualifier support is no longer needed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/syscall_32.c           |  6 +++---
 arch/x86/entry/syscall_64.c           |  6 +++---
 arch/x86/entry/syscall_x32.c          |  6 +++---
 arch/x86/entry/syscalls/syscalltbl.sh | 10 +---------
 arch/x86/um/sys_call_table_32.c       |  4 ++--
 arch/x86/um/sys_call_table_64.c       |  4 ++--
 6 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 3207cf685cde..9f4cab4a56d8 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -9,10 +9,10 @@
 
 #ifdef CONFIG_IA32_EMULATION
 /* On X86_64, we use struct pt_regs * to pass parameters to syscalls */
-#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_I386(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
 #define __sys_ni_syscall __ia32_sys_ni_syscall
 #else /* CONFIG_IA32_EMULATION */
-#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#define __SYSCALL_I386(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #define __sys_ni_syscall sys_ni_syscall
 #endif /* CONFIG_IA32_EMULATION */
@@ -20,7 +20,7 @@ extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned lon
 #include <asm/syscalls_32.h>
 #undef __SYSCALL_I386
 
-#define __SYSCALL_I386(nr, sym, qual) [nr] = sym,
+#define __SYSCALL_I386(nr, sym) [nr] = sym,
 
 __visible const sys_call_ptr_t ia32_sys_call_table[__NR_ia32_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 5dc6846979df..bce4821a7e14 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,13 +8,13 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_X32(nr, sym, qual)
+#define __SYSCALL_X32(nr, sym)
 
-#define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_64(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
 
-#define __SYSCALL_64(nr, sym, qual) [nr] = sym,
+#define __SYSCALL_64(nr, sym) [nr] = sym,
 
 asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 95abb6da0ecc..21e306c5a401 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -8,13 +8,13 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_64(nr, sym, qual)
+#define __SYSCALL_64(nr, sym)
 
-#define __SYSCALL_X32(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_X32(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_X32
 
-#define __SYSCALL_X32(nr, sym, qual) [nr] = sym,
+#define __SYSCALL_X32(nr, sym) [nr] = sym,
 
 asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
index 1af2be39e7d9..b0519ddad8d7 100644
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/arch/x86/entry/syscalls/syscalltbl.sh
@@ -9,15 +9,7 @@ syscall_macro() {
     local nr="$2"
     local entry="$3"
 
-    # Entry can be either just a function name or "function/qualifier"
-    real_entry="${entry%%/*}"
-    if [ "$entry" = "$real_entry" ]; then
-        qualifier=
-    else
-        qualifier=${entry#*/}
-    fi
-
-    echo "__SYSCALL_${abi}($nr, $real_entry, $qualifier)"
+    echo "__SYSCALL_${abi}($nr, $entry)"
 }
 
 emit() {
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index a0d75c560030..2ed81e581755 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -26,11 +26,11 @@
 
 #define old_mmap sys_old_mmap
 
-#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#define __SYSCALL_I386(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
 #include <asm/syscalls_32.h>
 
 #undef __SYSCALL_I386
-#define __SYSCALL_I386(nr, sym, qual) [ nr ] = sym,
+#define __SYSCALL_I386(nr, sym) [ nr ] = sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index fa97740badd5..7d057ea53d54 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -36,11 +36,11 @@
 #define stub_execveat sys_execveat
 #define stub_rt_sigreturn sys_rt_sigreturn
 
-#define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#define __SYSCALL_64(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
 #include <asm/syscalls_64.h>
 
 #undef __SYSCALL_64
-#define __SYSCALL_64(nr, sym, qual) [ nr ] = sym,
+#define __SYSCALL_64(nr, sym) [ nr ] = sym,
 
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 
-- 
2.24.1

