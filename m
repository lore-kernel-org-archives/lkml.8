Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974F0C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9EC24677
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581694003;
	bh=wO1Ew9sb+rGZJ/Rr+TIVUwLrRh/XqNGrVvPFvVSptnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IieQ6NJcgrdApNKdDM8PRlDlF9MR32PmFC3bKdCADZDUfDs/7Bd51PGem4/ok68h/
	 6j4uP/ElaK4Ci/Oli2NGn6DKELVC98SzMj/ui+bMx4ti0e97RTXXw8wxQuyX3lgqvZ
	 qCtg/JP2uhZgpxtdhTX9Hb184VTWjbMhnCLb324o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbgBNP0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:26:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387536AbgBNP0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:26:40 -0500
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C52C7217F4;
        Fri, 14 Feb 2020 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581693999;
        bh=wO1Ew9sb+rGZJ/Rr+TIVUwLrRh/XqNGrVvPFvVSptnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7qFo9IOzsU7k/GKxri+G459miEoEqmq7ZNObeP5vvuhiXusNoCOsG6Sdkqp4rTnA
         Wg3dovyWR3oLVI67zYEFrMVAOMwg7Ck/sarWTo20sueQSvPWH1qPvMw8JfbIunZjSW
         vuoSPBIPaFxYBp/cdNBZUnbXDqnZgTjSIJ18D1Do=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 5/5] arm64: Remove TIF_NOHZ
Date:   Fri, 14 Feb 2020 16:26:15 +0100
Message-Id: <20200214152615.25447-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214152615.25447-1-frederic@kernel.org>
References: <20200214152615.25447-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syscall slow path is spuriously invoked when context tracking is
activated while the entry code calls context tracking from fast path.

Remove that overhead and the unused flag itself while at it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig                   | 1 -
 arch/arm64/include/asm/thread_info.h | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c945fa3df26..0b30e884e088 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -140,7 +140,6 @@ config ARM64
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING
-	select HAVE_TIF_NOHZ
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index f0cec4160136..512174a8e789 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -63,7 +63,6 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
 #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
-#define TIF_NOHZ		7
 #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
 #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
@@ -83,7 +82,6 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
-#define _TIF_NOHZ		(1 << TIF_NOHZ)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
@@ -100,7 +98,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
-				 _TIF_NOHZ | _TIF_SYSCALL_EMU)
+				 _TIF_SYSCALL_EMU)
 
 #define INIT_THREAD_INFO(tsk)						\
 {									\
-- 
2.25.0

