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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5F4C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721082074E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEfYGcvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCMTw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:52:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33741 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgCMTwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id d22so8672792qtn.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRLPPaada1Gnu8tlz6LNuClHSQtdTE6w4ywYYXvxjAE=;
        b=YEfYGcvdrfPfo7nhpDLeybFQPPPWi6PS5cwnR9KJl5ERjQXW5NJ+gqrdxcw49qCdU1
         r8SYLURTCTmz6xYCQ1WnCP0SMG8qo27cRn9bdUX7uIT3uoX61hF5eAWRt2iNaib1W01l
         PEKz0qtES86oJ6og8KGM1YnCR61IfhPavNrWpXj/ECkXG2QdrgWxUb12B2ocRytQhQpz
         xPLNDYfqmLD7bdMDrRQj3bnelePopXYrs4tt+Hm7/bi/+JxfHVTH1NemL5FsjQymg3Mb
         epFRgazyaWZ1wUyfmAgbfaXOkMBYcGf8w+lgSP/6iXgSkjQl6Fvrzs0+zwnQM7TYGczj
         2GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRLPPaada1Gnu8tlz6LNuClHSQtdTE6w4ywYYXvxjAE=;
        b=i8MDpdAYOeFxT4BfG88NcyWrp+V+gzO8scU2X1OYp/S7He1MfQuChMQbKjZsRE8Kul
         4hQzPL0uFxxaQzokXnJlL8CTWNZSrZcqK7y6zRV2AwEW8RzeGG9kIKxDi5kkONLqRE3s
         Db+xN27WPksWy+L0lIa65AEIAeUnqWokgL3ejc6CJXRqElkQgkayrICz4nt1N8ASKBMH
         DU6gLoend+sJym52xj3yr3ScnYYKwboSBN63gpj36SAF3TXL59xT71Zf9X6va4K6Z5aw
         2ZcmF3gwA7CQrMK5ieZ/rbxD3/g980iQ8oZqw6kASyVDmKFxUWcoohssVr+5SWr2YYrh
         Jq7A==
X-Gm-Message-State: ANhLgQ3ZMXSNa1xwwQxhKL+DS9dgxv0oaGNxKyStkg9xTfJ7PJ2/yvOm
        77QpiwuoDa+53Lr2AT9/2Dvh4c4=
X-Google-Smtp-Source: ADFU+vsmKCR2EeiXkztqSAukKtbildNSWWbbnHFcKP8XeGidyIfBKk1J3q2uzNpLP5OoSTD+PXQ1kg==
X-Received: by 2002:ac8:1608:: with SMTP id p8mr14410376qtj.123.1584129141097;
        Fri, 13 Mar 2020 12:52:21 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:20 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 09/18] x86-64: Remove ptregs qualifier from syscall table
Date:   Fri, 13 Mar 2020 15:51:35 -0400
Message-Id: <20200313195144.164260-10-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the fast syscall path is removed, the ptregs qualifier is unused.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 0b5a25bc9998..e8fb7222a3bd 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -23,7 +23,7 @@
 12	common	brk			__x64_sys_brk
 13	64	rt_sigaction		__x64_sys_rt_sigaction
 14	common	rt_sigprocmask		__x64_sys_rt_sigprocmask
-15	64	rt_sigreturn		__x64_sys_rt_sigreturn/ptregs
+15	64	rt_sigreturn		__x64_sys_rt_sigreturn
 16	64	ioctl			__x64_sys_ioctl
 17	common	pread64			__x64_sys_pread64
 18	common	pwrite64		__x64_sys_pwrite64
@@ -64,10 +64,10 @@
 53	common	socketpair		__x64_sys_socketpair
 54	64	setsockopt		__x64_sys_setsockopt
 55	64	getsockopt		__x64_sys_getsockopt
-56	common	clone			__x64_sys_clone/ptregs
-57	common	fork			__x64_sys_fork/ptregs
-58	common	vfork			__x64_sys_vfork/ptregs
-59	64	execve			__x64_sys_execve/ptregs
+56	common	clone			__x64_sys_clone
+57	common	fork			__x64_sys_fork
+58	common	vfork			__x64_sys_vfork
+59	64	execve			__x64_sys_execve
 60	common	exit			__x64_sys_exit
 61	common	wait4			__x64_sys_wait4
 62	common	kill			__x64_sys_kill
@@ -180,7 +180,7 @@
 169	common	reboot			__x64_sys_reboot
 170	common	sethostname		__x64_sys_sethostname
 171	common	setdomainname		__x64_sys_setdomainname
-172	common	iopl			__x64_sys_iopl/ptregs
+172	common	iopl			__x64_sys_iopl
 173	common	ioperm			__x64_sys_ioperm
 174	64	create_module
 175	common	init_module		__x64_sys_init_module
@@ -330,7 +330,7 @@
 319	common	memfd_create		__x64_sys_memfd_create
 320	common	kexec_file_load		__x64_sys_kexec_file_load
 321	common	bpf			__x64_sys_bpf
-322	64	execveat		__x64_sys_execveat/ptregs
+322	64	execveat		__x64_sys_execveat
 323	common	userfaultfd		__x64_sys_userfaultfd
 324	common	membarrier		__x64_sys_membarrier
 325	common	mlock2			__x64_sys_mlock2
@@ -356,7 +356,7 @@
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
 434	common	pidfd_open		__x64_sys_pidfd_open
-435	common	clone3			__x64_sys_clone3/ptregs
+435	common	clone3			__x64_sys_clone3
 437	common	openat2			__x64_sys_openat2
 438	common	pidfd_getfd		__x64_sys_pidfd_getfd
 
@@ -374,7 +374,7 @@
 517	x32	recvfrom		__x32_compat_sys_recvfrom
 518	x32	sendmsg			__x32_compat_sys_sendmsg
 519	x32	recvmsg			__x32_compat_sys_recvmsg
-520	x32	execve			__x32_compat_sys_execve/ptregs
+520	x32	execve			__x32_compat_sys_execve
 521	x32	ptrace			__x32_compat_sys_ptrace
 522	x32	rt_sigpending		__x32_compat_sys_rt_sigpending
 523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait_time64
@@ -399,6 +399,6 @@
 542	x32	getsockopt		__x32_compat_sys_getsockopt
 543	x32	io_setup		__x32_compat_sys_io_setup
 544	x32	io_submit		__x32_compat_sys_io_submit
-545	x32	execveat		__x32_compat_sys_execveat/ptregs
+545	x32	execveat		__x32_compat_sys_execveat
 546	x32	preadv2			__x32_compat_sys_preadv64v2
 547	x32	pwritev2		__x32_compat_sys_pwritev64v2
-- 
2.24.1

