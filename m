Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46936C11D27
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8A5222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpd3pzk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgBUFKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:10:41 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35269 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgBUFKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:10:39 -0500
Received: by mail-yb1-f193.google.com with SMTP id p123so600272ybp.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 21:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=krAE7ycC/2k1W/1ATQ3jD1P1JN/WDVFSVrdN2mtH4vY=;
        b=fpd3pzk0wm92KFI6vCcjE9KeFugcHVOuvJP6IoGqy3QhPIqQdi2AFQO7q+0Q5gwsSf
         Zh5cCVuPfqYcZMaSeZL0QPwT6w8KVQ75hkM5+Zs+iWLfgWuWoIhXHGcRIPWKVzYGFmrp
         P/XxtCLMDrbgzMELLNUbTvfSVW/ZTXmzFsdDDbjBdelKzz7ARo2JuJcrj4A1PHm85wWB
         gXMjVBH3AFV2vDGfSHIIdLHxXUiSi7gaA4Qg2eFUaRCAZlxS1Q0S2tCgjm40YkbBoZHE
         pBtDkM7KPlknbzVb5p5YCRSHbD7x9FnN+OSze3Jdzs0/bAM740Lk5/NaDFlxu4DtWW3q
         T6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=krAE7ycC/2k1W/1ATQ3jD1P1JN/WDVFSVrdN2mtH4vY=;
        b=JfcFjPHLipycmVRvMCD7mqx2QdPGwoPOR/KOdSWAJyVtcfMYIiNV/51zHHJ44+EkWS
         uwoTnILjDMMoSWZgiCPi91NUsOL0YbYiEH4WhRA9wxQo1gbx3jQ2Pc2D2McbmKLbP1JM
         7Zv3tq9NnUSTVvUoUPgUI+GVQviIrVhbeOH5sPYe08WAKe8tqd3f2mqj/J1HI2prayOU
         PGHv9pvOMzTyJEnlQHvvgpcdXP44EdVNO/vOhxCdXkoVZRfuJyVtM8yj3dVLgtBHVis2
         C3rNGQI5hEeMClmdUCX394Vy75bxixBX6Q87XuGbxOKx0yk1NXLL1NX3siMXGiDr2SNV
         0N8A==
X-Gm-Message-State: APjAAAVjg3sKNWBeT5uWZ5+nCEl1a4BqgG6q7Ffcw4Y1gmf7eOWeqQ0q
        iQSRlYOyR7AbIagzoYPd0tjujD0=
X-Google-Smtp-Source: APXvYqzRo40QQ9K8V3uSguwrA1J1wHG9jwyW330vDhT+i5ZN6wBGW/UPbIWTLD1EcMqolKShYRBvSA==
X-Received: by 2002:a25:e909:: with SMTP id n9mr33645009ybd.187.1582261837437;
        Thu, 20 Feb 2020 21:10:37 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id a12sm840904ywa.95.2020.02.20.21.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 21:10:37 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 4/5] x86-64: Use syscall wrappers for x32_rt_sigreturn
Date:   Fri, 21 Feb 2020 00:09:33 -0500
Message-Id: <20200221050934.719152-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221050934.719152-1-brgerst@gmail.com>
References: <20200221050934.719152-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Brian Gerst <brgerst@gmail.com>
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

