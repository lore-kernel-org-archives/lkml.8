Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06151C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC351204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690073;
	bh=tOeoHQl/xkAbw98W/d/HbPYQ9y5YcAyc2aZjIwp5VYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c2ECV+1rFnIodzm5JGIQMie6nDSY6WFFXgFK6GtkkUpWbWgyVHnrDo1hLEwPHQERP
	 gOfse0jsFmMmQ5dYaaubjt465VPYpjxfq5Io81byAvV6iUCV6tmpmZcufrEvv4NXbN
	 RrSjomqyBt786N6xtRZmQHLzsJffHKLJSXLsqao0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403823AbgHQSrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388013AbgHQPze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:55:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C49B20760;
        Mon, 17 Aug 2020 15:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679733;
        bh=tOeoHQl/xkAbw98W/d/HbPYQ9y5YcAyc2aZjIwp5VYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bnb4Vp+5ldUZi3gCyZtTWslx0Nd4DcKd1FdSk4NXBe3A0waQSTYnaGbkqZNkVsKa4
         Oi+CdkcsM5zVCAoeLJFvui3pR/Mo3eRLHzoLYKdC7G2XzwE8unT1WJ9Qf89AOSNPKN
         WamS4F4vQjeWYDVuAH2AFT6a60KRhmVPWuJF8RLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, Jann Horn <jannh@google.com>
Subject: [PATCH 5.7 315/393] x86/fsgsbase/64: Fix NULL deref in 86_fsgsbase_read_task
Date:   Mon, 17 Aug 2020 17:16:05 +0200
Message-Id: <20200817143834.887647766@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 8ab49526b53d3172d1d8dd03a75c7d1f5bd21239 ]

syzbot found its way in 86_fsgsbase_read_task() and triggered this oops:

   KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
   CPU: 0 PID: 6866 Comm: syz-executor262 Not tainted 5.8.0-syzkaller #0
   RIP: 0010:x86_fsgsbase_read_task+0x16d/0x310 arch/x86/kernel/process_64.c:393
   Call Trace:
     putreg32+0x3ab/0x530 arch/x86/kernel/ptrace.c:876
     genregs32_set arch/x86/kernel/ptrace.c:1026 [inline]
     genregs32_set+0xa4/0x100 arch/x86/kernel/ptrace.c:1006
     copy_regset_from_user include/linux/regset.h:326 [inline]
     ia32_arch_ptrace arch/x86/kernel/ptrace.c:1061 [inline]
     compat_arch_ptrace+0x36c/0xd90 arch/x86/kernel/ptrace.c:1198
     __do_compat_sys_ptrace kernel/ptrace.c:1420 [inline]
     __se_compat_sys_ptrace kernel/ptrace.c:1389 [inline]
     __ia32_compat_sys_ptrace+0x220/0x2f0 kernel/ptrace.c:1389
     do_syscall_32_irqs_on arch/x86/entry/common.c:84 [inline]
     __do_fast_syscall_32+0x57/0x80 arch/x86/entry/common.c:126
     do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:149
     entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

This can happen if ptrace() or sigreturn() pokes an LDT selector into FS
or GS for a task with no LDT and something tries to read the base before
a return to usermode notices the bad selector and fixes it.

The fix is to make sure ldt pointer is not NULL.

Fixes: 07e1d88adaae ("x86/fsgsbase/64: Fix ptrace() to read the FS/GS base accurately")
Co-developed-by: Jann Horn <jannh@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/process_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 5ef9d8f25b0e8..cf2cda72a75bf 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -315,7 +315,7 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 		 */
 		mutex_lock(&task->mm->context.lock);
 		ldt = task->mm->context.ldt;
-		if (unlikely(idx >= ldt->nr_entries))
+		if (unlikely(!ldt || idx >= ldt->nr_entries))
 			base = 0;
 		else
 			base = get_desc_base(ldt->entries + idx);
-- 
2.25.1



