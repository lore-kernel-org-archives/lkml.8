Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94854C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74CA220C09
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FUB52KH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389213AbgFSTh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389188AbgFSThX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:37:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FB6C0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:37:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so4702133pjd.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=o7if+DdFqLdTqlhmKOgGWwPbnBli3b0MNWvVpv3R4kw=;
        b=FUB52KH7JaEZzQ1Sa88+rHDFmBQsWgAcadbsgEbWzKh0ASy5MJvrDDegCm1NTXAOS8
         vGHr/8ouSL2waaiB0YbuZHgyMv/9ZwoFxlq+Rv9mQnqomECuQBKi0/XNW3pVwoYGpCEf
         Goc0O9aqUxBX+7MjVIfo9KadJ7D/V9gTIEtuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=o7if+DdFqLdTqlhmKOgGWwPbnBli3b0MNWvVpv3R4kw=;
        b=rGEI8Upzm+eutfv4dfcApITxscZgwW/uM7Sj7PQQ91StKElkDboFNEbYXA5qHnSEQ7
         nZcCTAcwwZprcSDYT3054ilM6yu5BBqg49KFhL/l9L76kYi4RD4qZ8wSCjdTrKST7beG
         9XEdf5UPr3LRwCX5V5ZY8oCoX5Bc+KPhGYMJHCtTaqXeqiPrYHu8UdPDB2HRauwgR1T+
         LpFvX/kvSLm4jCzpns/mhpuYJTYNDzv53RlZHdzyy0b2S9qoFWDzzfBWL9br2AsIZ09f
         6VC2Ob09eVY1R2dtmQptfWs9M30nJ1kB9tG/qQK4/ySTU+nbOpNjuIqFwoqZnt7pCflg
         FuzA==
X-Gm-Message-State: AOAM531xrJd9618QLmO0ExXbE6lZ/1W7nWRHFuRlX9hR2E9ECRJ37Pzi
        lk9tdAfzT7aLXO7Zpytfs+pBvw==
X-Google-Smtp-Source: ABdhPJy1kxnlCvJmO5IS+9Scdoew2zfX/pdbNf5xDUloU8j9e4g8x0h4K8xzytX/BaBY+vfXdU7CGQ==
X-Received: by 2002:a17:90a:ea84:: with SMTP id h4mr4579161pjz.45.1592595442674;
        Fri, 19 Jun 2020 12:37:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w10sm5773025pgm.70.2020.06.19.12.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 12:37:21 -0700 (PDT)
Date:   Fri, 19 Jun 2020 12:37:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH] seccomp: Use -1 marker for end of mode 1 syscall list
Message-ID: <202006191236.AC3E22AAB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The terminator for the mode 1 syscalls list was a 0, but that could be
a valid syscall number (e.g. x86_64 __NR_read). By luck, __NR_read was
listed first and the loop construct would not test it, so there was no
bug. However, this is fragile. Replace the terminator with -1 instead,
and make the variable name for mode 1 syscall lists more descriptive.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
I'll be putting this into my for-next/seccomp tree. I would love a MIPS
ack, if someone's got a moment to double-check this. :)
---
 arch/mips/include/asm/seccomp.h |  4 ++--
 include/asm-generic/seccomp.h   |  2 +-
 kernel/seccomp.c                | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/seccomp.h b/arch/mips/include/asm/seccomp.h
index e383d7e27b93..aa809589a181 100644
--- a/arch/mips/include/asm/seccomp.h
+++ b/arch/mips/include/asm/seccomp.h
@@ -9,12 +9,12 @@ static inline const int *get_compat_mode1_syscalls(void)
 	static const int syscalls_O32[] = {
 		__NR_O32_Linux + 3, __NR_O32_Linux + 4,
 		__NR_O32_Linux + 1, __NR_O32_Linux + 193,
-		0, /* null terminated */
+		-1, /* negative terminated */
 	};
 	static const int syscalls_N32[] = {
 		__NR_N32_Linux + 0, __NR_N32_Linux + 1,
 		__NR_N32_Linux + 58, __NR_N32_Linux + 211,
-		0, /* null terminated */
+		-1, /* negative terminated */
 	};
 
 	if (IS_ENABLED(CONFIG_MIPS32_O32) && test_thread_flag(TIF_32BIT_REGS))
diff --git a/include/asm-generic/seccomp.h b/include/asm-generic/seccomp.h
index 1321ac7821d7..6b6f42bc58f9 100644
--- a/include/asm-generic/seccomp.h
+++ b/include/asm-generic/seccomp.h
@@ -33,7 +33,7 @@ static inline const int *get_compat_mode1_syscalls(void)
 	static const int mode1_syscalls_32[] = {
 		__NR_seccomp_read_32, __NR_seccomp_write_32,
 		__NR_seccomp_exit_32, __NR_seccomp_sigreturn_32,
-		0, /* null terminated */
+		-1, /* negative terminated */
 	};
 	return mode1_syscalls_32;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 0ed57e8c49d0..866a432cd746 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -742,20 +742,20 @@ static inline void seccomp_log(unsigned long syscall, long signr, u32 action,
  */
 static const int mode1_syscalls[] = {
 	__NR_seccomp_read, __NR_seccomp_write, __NR_seccomp_exit, __NR_seccomp_sigreturn,
-	0, /* null terminated */
+	-1, /* negative terminated */
 };
 
 static void __secure_computing_strict(int this_syscall)
 {
-	const int *syscall_whitelist = mode1_syscalls;
+	const int *allowed_syscalls = mode1_syscalls;
 #ifdef CONFIG_COMPAT
 	if (in_compat_syscall())
-		syscall_whitelist = get_compat_mode1_syscalls();
+		allowed_syscalls = get_compat_mode1_syscalls();
 #endif
 	do {
-		if (*syscall_whitelist == this_syscall)
+		if (*allowed_syscalls == this_syscall)
 			return;
-	} while (*++syscall_whitelist);
+	} while (*++allowed_syscalls != -1);
 
 #ifdef SECCOMP_DEBUG
 	dump_stack();
-- 
2.25.1


-- 
Kees Cook
