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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1001CC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D736C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCbm2yN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgCMTxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:53:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46109 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgCMTwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id t13so8605315qtn.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9ou2grAHoRiRwhqAV4lvqbe3cCcX01SZvcbrB6jjJY=;
        b=UCbm2yN7uaQejw2flDriMY/LSjTshDU5WtvJkOtSAGAbC7A514WKwV/ph3HqHRg9vS
         y49wYABqSd98f54S7oUT4HQkftM+0x9Y6UHjBgNpfeROvD1mFktzjxiGYmCGW7WQsmzG
         dql5X8lY2Gi5MxtEWD8XKDOLG7RX0A/OOxE4eBgMfgNWkYvzNRHf95zvRN5raW+wloJV
         CNrUXm28gzyG+lH8SufySBS+5DJfAzKcdtiz8Tw8j5kN/5N+j6fCWODlBNHh5KjNfGzF
         sLs0SwWAK7fNHP5pdaK2Ged8lVIrUsTs5bJOHPO6c7PQGbGQUlcFAHPFefyClWlnRiuK
         anXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9ou2grAHoRiRwhqAV4lvqbe3cCcX01SZvcbrB6jjJY=;
        b=KLZbeDtG2clEznwNr5qaZ2WaH1k/FrE8jLUEBvzLKmK//71+Iq/2/MXBRmEOvESaH+
         6KXxMiWNcAoZQqHJ840N8bSi2t3Ph1OeuiCerKBNydHsFai/sd1i/OlR8BwEsZeOQ4ZV
         jXwYbMxnmsXCkWi1IIk6xV6dCV/lA1tM6ncGWk/77zuqy9eYI3ATmnRcU+iwXL2zebg1
         lO4GZsEpgUOrWUbxA9xDPFheARpOD/BRjq6gRwBp/J0OUnU+WBRvGVje7ph0IdhVDxuM
         U6vpB5zFfG3L1NDKSp7n+oXR3tY/exCCHKDrO4c5jIRRP+XXt4cmODgxWw14XaVNJ58D
         GZKA==
X-Gm-Message-State: ANhLgQ2kVHirdVvBAhHJeXH43w3lc2EInK/QCynXPDF2sZZjSSb8heOo
        5yfDNqQDMWDONLLbLFzIDdCrU9Q=
X-Google-Smtp-Source: ADFU+vum4KIhPjWE4tTIb/Wfw8ruaDRRga6LTQotpy60U+IA7vGUareGadblth9pAL0iPJ6nUTIoXQ==
X-Received: by 2002:ac8:2bf8:: with SMTP id n53mr6768841qtn.1.1584129137251;
        Fri, 13 Mar 2020 12:52:17 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:16 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 06/18] x86-64: Move sys_ni_syscall stub to common.c
Date:   Fri, 13 Mar 2020 15:51:32 -0400
Message-Id: <20200313195144.164260-7-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so it can be available to multiple syscall tables.  Also directly return
-ENOSYS instead of bouncing to the generic sys_ni_syscall().

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/common.c                | 7 +++++++
 arch/x86/entry/syscall_64.c            | 7 -------
 arch/x86/include/asm/syscall_wrapper.h | 3 +++
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index ec167d8c41cb..c3a8e6513f74 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -439,3 +439,10 @@ __visible long do_fast_syscall_32(struct pt_regs *regs)
 #endif
 }
 #endif
+
+#ifdef CONFIG_X86_64
+SYSCALL_DEFINE0(ni_syscall)
+{
+	return -ENOSYS;
+}
+#endif
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index adf619a856e8..058dc1b73e96 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,13 +8,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
-extern asmlinkage long sys_ni_syscall(void);
-
-SYSCALL_DEFINE0(ni_syscall)
-{
-	return sys_ni_syscall();
-}
-
 #define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
 #define __SYSCALL_X32(nr, sym, qual) __SYSCALL_64(nr, sym, qual)
 #include <asm/syscalls_64.h>
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 1d96ccebc0d2..0f126e40a464 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -8,6 +8,9 @@
 
 struct pt_regs;
 
+extern asmlinkage long __x64_sys_ni_syscall(const struct pt_regs *regs);
+extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
+
 /* Mapping of registers to parameters for syscalls on x86-64 and x32 */
 #define SC_X86_64_REGS_TO_ARGS(x, ...)					\
 	__MAP(x,__SC_ARGS						\
-- 
2.24.1

