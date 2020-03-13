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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDF6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A2920716
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjUwT5XI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCMTwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:52:21 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45535 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgCMTwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id c145so14667429qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEgBD2zORFbqr37RMAp7AXXsfNvhw9SIyZ840n+FY/o=;
        b=QjUwT5XIHXnaom5edG3D5NvjM1rFr9w/5MbbG8CAezp7LabtlXBCURZm7/e4TSN9/m
         Iz//WrMv5wWaCX9RbRH8FpF992QURN6QOdNgOuf/7SqtKI7SJPtE8tPmp17yIttNbN1c
         LwmbiaVkJQEGVu3LeyNWy1PcKfNmdRJHY9dJ31L9y/88rjME3GZyOLGo72+mbYeFxrh1
         nusQVBlBe75nFUOt1OSZ77/AOfw5+3eO+49wkELPVcO8CI9QQzjmCmO8HnIfqTqgnEfG
         E3u3HhnxgKyROihOYniW42ZLQDBZNkp9cHMx0yna9syKJ87pAAns1yPDTzrBHp/VZFgz
         +Reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEgBD2zORFbqr37RMAp7AXXsfNvhw9SIyZ840n+FY/o=;
        b=RnUGw/5sfbcBkOPf/fOA0K32IQ+EZbBH0GuNzUJZF91ogKwVk426vjRrEF9CBUPUPb
         LTXHisKDWE1ErBfU9T/mOsUhsk8iFENVU0yqIVP3lXLfvz6fhoqAiN2nlLK3Niiy/+ld
         uQC78DWJCQeVqYg6sKssltulm2OdABKcN1T+emeMZ3sNmdT2IO2oJ6ZlNe9ygRecXUm4
         GWdWCKmsimIC0EDCsxsjkZQdtrSnFHUa2GHbJA4kUWy1Be0NJ8VGM2lJNg+vJCQitTsx
         7sgXdT1BZQVoKP0rTP9yslaqM5Dn2W4qrFFtjdDSE5ExWS4OZEVFeGS78adB8EM2dt4H
         K73w==
X-Gm-Message-State: ANhLgQ3R8BASiD+ENqDHUr5OQiEu4Nedy8syxqhTkf3sRwK3UYU+QoxC
        c4Qj3wkfx2JrAEg8Kev/EU3vxW8=
X-Google-Smtp-Source: ADFU+vtZDvC3sjDrrqtIn0Z9aKj+gxU9PI4xHIbjZjMLCKNgQxbsvkK06zA2oVtXS0kpfPYrZvaDwg==
X-Received: by 2002:a37:9b51:: with SMTP id d78mr15282932qke.65.1584129135967;
        Fri, 13 Mar 2020 12:52:15 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:15 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 05/18] x86-64: Use syscall wrappers for x32_rt_sigreturn
Date:   Fri, 13 Mar 2020 15:51:31 -0400
Message-Id: <20200313195144.164260-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing syscall wrapper for x32_rt_sigreturn().

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
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

