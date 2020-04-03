Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C3C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618692063A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585888934;
	bh=Lq2IMQMvPOCzvgXCncfrKwRonUqCRitFuKGazUr0kFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BSxsjPuOhxIPbsHWln1mlTkvFErrVy4OtJtthGAQPvwGC97naG8a/P4sn21TiAwsO
	 gzTihQvRriD2TLVSgyRQtpCqSlN/xAQYOwV7oURFVcd2bbfCaP+WuW2zactg5my0Yx
	 2wZYqIs//GOLWiUHfGlidI9s/ilIl2SvXapmnyOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbgDCEmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgDCEmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:42:11 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 124602063A;
        Fri,  3 Apr 2020 04:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585888930;
        bh=Lq2IMQMvPOCzvgXCncfrKwRonUqCRitFuKGazUr0kFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKYnAAsMcwnOaLvzLgVy2vO/OOGGAWi1Magvlrky38RnDpUIhnWEmvQd2k2Bt8Rcx
         hSLta1eTMIn7UER7bnP0rFMAic7xzo04z/6Z/9ngs9b6qtLClUJfg3LuzUCdi72Srf
         GIlarOt3uHYiYV0OKw0L4iIbcZpcHrlnsBb0wclY=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 03/11] csky: Add support for restartable sequence
Date:   Fri,  3 Apr 2020 12:41:42 +0800
Message-Id: <20200403044150.20562-3-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200403044150.20562-1-guoren@kernel.org>
References: <20200403044150.20562-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Copied and adapted from vincent's patch, but modified for csky.

ref:
https://lore.kernel.org/linux-riscv/1572919114-3886-3-git-send-email-vincent.chen@sifive.com/raw

Add calls to rseq_signal_deliver(), rseq_handle_notify_resume() and
rseq_syscall() to introduce RSEQ support.

1. Call the rseq_handle_notify_resume() function on return to userspace
   if TIF_NOTIFY_RESUME thread flag is set.

2. Call the rseq_signal_deliver() function to fixup on the pre-signal
   frame when a signal is delivered on top of a restartable sequence
   critical section.

3. Check that system calls are not invoked from within rseq critical
   sections by invoking rseq_signal() from ret_from_syscall(). With
   CONFIG_DEBUG_RSEQ, such behavior results in termination of the
   process with SIGSEGV.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/Kconfig         | 1 +
 arch/csky/kernel/entry.S  | 5 ++++-
 arch/csky/kernel/signal.c | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 2dfd3fb07db9..0e9b14367fa8 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -49,6 +49,7 @@ config CSKY
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select MAY_HAVE_SPARSE_IRQ
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 007706328000..0bde1d9fd277 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -128,7 +128,10 @@ tlbop_end 1
 ENTRY(csky_systemcall)
 	SAVE_ALL TRAP0_SIZE
 	zero_fp
-
+#ifdef CONFIG_RSEQ_DEBUG
+	mov	a0, sp
+	jbsr	rseq_syscall
+#endif
 	psrset  ee, ie
 
 	lrw     r11, __NR_syscalls
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index 9b1b7c039ddf..3d6b728cbb72 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -175,6 +175,8 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
 
+	rseq_signal_deliver(ksig, regs);
+
 	/* Are we from a system call? */
 	if (in_syscall(regs)) {
 		/* Avoid additional syscall restarting via ret_from_exception */
@@ -258,5 +260,6 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
+		rseq_handle_notify_resume(NULL, regs);
 	}
 }
-- 
2.17.0

