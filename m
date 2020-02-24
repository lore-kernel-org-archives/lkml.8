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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039ADC11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AE520732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi1ZRmas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgBXSSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:18:32 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45962 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgBXSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:18:24 -0500
Received: by mail-yw1-f65.google.com with SMTP id a125so5615672ywe.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 10:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHwnDuy8iWilmn9MBT9whlCavLt7cICreHcENkQjCv4=;
        b=Pi1ZRmasehPUqENQ7aKQlDIlyNiSUhy4AWW2+0kBF7SfvdtpYhwJ/5s9SduhNZtKLg
         PDRKXIQQ72xz5/D4Aj7+jHf+Yb1vMlx60CIXUYFIJ9OO7jgYRy7nbGBReNa7s7PGW4dx
         IoxwjmujqVGHzlE4Vl0LbR64HWcs9DkzrlqBwcNr6prNrLg9zKSRqTvPnUQ+WwMHb4Z4
         7Y6ZX9c7vi1WMbmt3ewHyNhLW39g8np2AiEYdJL6ixqVfVKUrKpVG6o82GPrU7qZLpRh
         zwCTC3y9WAic9aRUERbt8kd5kf3kbVbPChcl/NAI87cOYPrsOqvQIi+b+D7e8nPK/GJZ
         Tlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHwnDuy8iWilmn9MBT9whlCavLt7cICreHcENkQjCv4=;
        b=an2BP1BMGZlBtNVzmp03h9WFI+bP52+VsDhmwWuHYdhjwCpiZya/z8lGwgz1OYzv1u
         JG0f2hhiiZwGkLeiJFt1ryGriFSGkm7ou+Kij/wB4wr90XXYsbzGoPHaJGxNlnEu2sDi
         IzCOUZCwEys8wRcSXolz7HIHtaxCkbJ46b0Bz5Lf9csJ4Zhu3GHvyo0I8FsIRSVjeuVb
         wLMz6O6brPfxtXlIWbHjoKD+4U/qiNzkJnikpGEFrj0nkYmSH6/a4OadBkCq94YoR/0n
         qlvwL3RZHdbrtOhma3qBwrRMMSKjkvh13UW5TGA8PC7/viOO8zsM6VTDeedOsFAjzgtd
         eQcg==
X-Gm-Message-State: APjAAAVmeMa4C+dl6XUOsjgiteKgTUlvwTzspx0zjdGYM+rg49yfOJVo
        CcfJC/Og3ZTKX9TiKpMXE4dG1Lw=
X-Google-Smtp-Source: APXvYqzULWiaMtA1qizgG/WX4ZEj0lUuCX+qjWlskgx2VDJVXk4xmynIgA5Yvjt4WkQrpyyKY2KO/g==
X-Received: by 2002:a81:5787:: with SMTP id l129mr45180131ywb.483.1582568301886;
        Mon, 24 Feb 2020 10:18:21 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i66sm5632383ywa.74.2020.02.24.10.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:18:21 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 7/8] x86-64: Use syscall wrappers for x32_rt_sigreturn
Date:   Mon, 24 Feb 2020 13:17:56 -0500
Message-Id: <20200224181757.724961-8-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224181757.724961-1-brgerst@gmail.com>
References: <20200224181757.724961-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing syscall wrapper for x32_rt_sigreturn().

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 2 +-
 arch/x86/include/asm/sighandling.h     | 5 -----
 arch/x86/kernel/signal.c               | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 44d510bc9b78..0b5a25bc9998 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -367,7 +367,7 @@
 # is defined.
 #
 512	x32	rt_sigaction		__x32_compat_sys_rt_sigaction
-513	x32	rt_sigreturn		sys32_x32_rt_sigreturn
+513	x32	rt_sigreturn		__x32_compat_sys_x32_rt_sigreturn
 514	x32	ioctl			__x32_compat_sys_ioctl
 515	x32	readv			__x32_compat_sys_readv
 516	x32	writev			__x32_compat_sys_writev
diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index 2fcbd6f33ef7..bd26834724e5 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -17,9 +17,4 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
 int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		     struct pt_regs *regs, unsigned long mask);
 
-
-#ifdef CONFIG_X86_X32_ABI
-asmlinkage long sys32_x32_rt_sigreturn(void);
-#endif
-
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8a29573851a3..860904990b26 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -859,7 +859,7 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where)
 }
 
 #ifdef CONFIG_X86_X32_ABI
-asmlinkage long sys32_x32_rt_sigreturn(void)
+COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe_x32 __user *frame;
-- 
2.24.1

