Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9BDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E8BA207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNTw9D+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgFPOXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgFPOXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:23:30 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ED6C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:23:30 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r2so2797445ioo.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jsVhtDNHvqz+HJ+tLLklgMHoGAYxlJkQxlysBR1bMxY=;
        b=pNTw9D+vHSehA6YSxnLYGB/pldhJix+EtNs11HTEHG0x2GFkt7Fs8s3ZA1soEJ0aEu
         /KpiFkGghtKWjbySXktJNfnVsH1yuhcgnLaryDTxueRtaF5I0zXG42SFz3R40/N5yl2U
         8NxfbW2DUxDZxvj7hxZPUTh/H56GU6SpnB53UT5fCsE8SJ6r2if6Qxm+SDk2AlFENgko
         A10jBO1q7tWYFKUmfKrFa11iI042DOoxPQ6ArdKtkfaGBWflHTTM5N0VlE0AVCkHQ1uU
         e0O5oG0C1YM1ZX6s+gQse9yaARgD5kf2JZiim67bLzmYxe94Fgt7gh5bnjk7E+xeazvE
         e0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jsVhtDNHvqz+HJ+tLLklgMHoGAYxlJkQxlysBR1bMxY=;
        b=s9aEPMaCAXUa28qge/8cAEcas8jrgksNjyonBFDtmHxCvXegEz4ZnOJ/biV1Y4379u
         sd2lmQKZqXPIHCYoXLeF0r/AKpE0p2sa7wkpMPEqrwViDCqNMuQIJPvN6jvfWcMFwDJA
         DG5KBZIo0wVEF/SPqUtaPfiTP4eQhlEZdkoaOQYt1HPmpJ/uJBprAiqHVr7ZbAe+CMlY
         C8kFiJOU6KlOjd1ntonYmTTqWXOl4sy55zk1kye6KLEQH/H3aNMICKOKXeKphu1/XTx4
         9k+1tsCzOX1rPYzCvfeIXgiIDtPiMsjGSwPQXJh57HSkEdH3H8Lv5TnkcLg1lDRDrSfb
         jOZA==
X-Gm-Message-State: AOAM532qtSQ3DjbvlCGqBTmylVOOYNNpkiyMzznx8YdYi2gk5cf+Oz98
        sCzPQac6/urn0469WyNE8Y5NhzWDQw==
X-Google-Smtp-Source: ABdhPJzD6nwcjB4zaYmzN40oumqNo+4BbnWxErXnjhWd7vesmhe63EfpgHR3W8ruEWUd8tR5H1ydXw==
X-Received: by 2002:a6b:5915:: with SMTP id n21mr2953097iob.103.1592317409746;
        Tue, 16 Jun 2020 07:23:29 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm10049881ilk.14.2020.06.16.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:23:29 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/2] x86/x32: Use __x64 prefix for X32 compat syscalls
Date:   Tue, 16 Jun 2020 10:23:14 -0400
Message-Id: <20200616142315.375918-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616142315.375918-1-brgerst@gmail.com>
References: <20200616142315.375918-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ABI prefix for syscalls specifies the argument register mapping, so
there is no specific reason to continue using the __x32 prefix for the
compat syscalls.  This change will allow using native syscalls in the X32
specific portion of the syscall table.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/syscall_x32.c           |  8 +++-----
 arch/x86/include/asm/syscall_wrapper.h | 10 +++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 3d8d70d3896c..f993e6254043 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -9,15 +9,13 @@
 #include <asm/syscall.h>
 
 #define __SYSCALL_64(nr, sym)
+#define __SYSCALL_COMMON(nr, sym) __SYSCALL_X32(nr, sym)
 
-#define __SYSCALL_X32(nr, sym) extern long __x32_##sym(const struct pt_regs *);
-#define __SYSCALL_COMMON(nr, sym) extern long __x64_##sym(const struct pt_regs *);
+#define __SYSCALL_X32(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_X32
-#undef __SYSCALL_COMMON
 
-#define __SYSCALL_X32(nr, sym) [nr] = __x32_##sym,
-#define __SYSCALL_COMMON(nr, sym) [nr] = __x64_##sym,
+#define __SYSCALL_X32(nr, sym) [nr] = __x64_##sym,
 
 asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
 	/*
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index a84333adeef2..267fae9904ff 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -17,7 +17,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * __x64_sys_*()         - 64-bit native syscall
  * __ia32_sys_*()        - 32-bit native syscall or common compat syscall
  * __ia32_compat_sys_*() - 32-bit compat syscall
- * __x32_compat_sys_*()  - 64-bit X32 compat syscall
+ * __x64_compat_sys_*()  - 64-bit X32 compat syscall
  *
  * The registers are decoded according to the ABI:
  * 64-bit: RDI, RSI, RDX, R10, R8, R9
@@ -165,17 +165,17 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * with x86_64 obviously do not need such care.
  */
 #define __X32_COMPAT_SYS_STUB0(name)					\
-	__SYS_STUB0(x32, compat_sys_##name)
+	__SYS_STUB0(x64, compat_sys_##name)
 
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
-	__SYS_STUBx(x32, compat_sys##name,				\
+	__SYS_STUBx(x64, compat_sys##name,				\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
 #define __X32_COMPAT_COND_SYSCALL(name)					\
-	__COND_SYSCALL(x32, compat_sys_##name)
+	__COND_SYSCALL(x64, compat_sys_##name)
 
 #define __X32_COMPAT_SYS_NI(name)					\
-	__SYS_NI(x32, compat_sys_##name)
+	__SYS_NI(x64, compat_sys_##name)
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
-- 
2.26.2

