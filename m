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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3EBC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBD52469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJBEtAye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgB0N25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:28:57 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36160 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbgB0N2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:28:49 -0500
Received: by mail-yw1-f65.google.com with SMTP id y72so3003158ywg.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHwnDuy8iWilmn9MBT9whlCavLt7cICreHcENkQjCv4=;
        b=CJBEtAye2TuFgARfSmhGDEKoqdqhnhlwSVvIlyBwnvQ1lOngGokKx2+OJEGA+Hhpd/
         RhNiRUgErLXg7vSSgpVGA3IhDk2CWjY2/MpJjinbC15wEERpdj1WmhCVXZme8c5+ZfZd
         3R7BB1mIN2QdAIifcvUxxK43zNOrXwWukVXIz8bA/gqBC/nds4oTY6CWlynsrRy27czr
         V4ryfEiDEb46uwmtxsH83+dxOgkb3mJPtCRNSq5CkboT7JEMBKTyBgx9sYJnopUUgt2u
         ycOWyyBmM5TwRZCX02TwIjbD1Qt/uehoR3hzSj/KcHah7b9DYjBmbkeAnH19U/OkIFvE
         oEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHwnDuy8iWilmn9MBT9whlCavLt7cICreHcENkQjCv4=;
        b=ClQPR/bUB8qBeTo8aITQ01AzkyhPlvFG4ltBglI8UENwtkjdMC635mVC5SL3mErHi6
         nkqljGdqFM1i4fgte2RHtJw6mmymyr/eMxeneerhAsCWRu1phSFsTsIDcBSFu6yR0OqB
         g8xaRDJkA2ibz0L0+JQN3NPdE6+7oHGvfbsBe1G1kHdk5DDoOxuZmyvTJg0Y5Nj3MHf3
         if6tFT/QZsdsPwLEjmERm3lwPytAT8Ys0TaiyqUBJKyBgCPG+nCbL64oFvKGL6/yMIXB
         XUe9lzIi8MvlhEaOGKYCuET/7hrNpcxQGFmT/iIrioEV1EZ/3yRqzP0EfxSPkFA1+OSt
         bHwQ==
X-Gm-Message-State: APjAAAVk9UMHzLuH2F22hgAjR7cb9KJc5bZkW94x5AWhnoBxsqDyeu6O
        swDvN6GRdPocTXzb9BM4oGeWvog=
X-Google-Smtp-Source: APXvYqzadosJxM/7Edev02KM3p131epVuyYpMJ0jJzAHRdKQjtsWNAaqJ25xD0nKbr7LvW3kHmlwxQ==
X-Received: by 2002:a25:d34e:: with SMTP id e75mr1768544ybf.290.1582810126306;
        Thu, 27 Feb 2020 05:28:46 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j23sm2442759ywb.93.2020.02.27.05.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:28:45 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 7/8] x86-64: Use syscall wrappers for x32_rt_sigreturn
Date:   Thu, 27 Feb 2020 08:28:25 -0500
Message-Id: <20200227132826.195669-8-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227132826.195669-1-brgerst@gmail.com>
References: <20200227132826.195669-1-brgerst@gmail.com>
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

