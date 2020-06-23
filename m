Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D37EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B152078C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592933848;
	bh=Pmc4Qk3SkNxp1+Xft8iK3sugnTpwsjtIyHgR0m1BHxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TfRhQj9p656T/9rr3qH2neRk0LOoIApP4k+vl2Z79K6IPr2Aq/k1KRhI7/nCeP/Zh
	 jlQGFSaKq/zum8SuM2ePxXWvgpKVq+8ecknKzr0DKMlZIKBeA9AC7Tvsj/Z7kK2BP1
	 lJuGbNX800PuOfV/xWGwTi6jN1+riiP2J3dXRbdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbgFWRhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387723AbgFWRhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:37:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D8620706;
        Tue, 23 Jun 2020 17:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592933823;
        bh=Pmc4Qk3SkNxp1+Xft8iK3sugnTpwsjtIyHgR0m1BHxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVYYFLg01Ir5y4JICdRrz9VOZ8kNXUkEH0N8KtktFTY98ocOJjnadXsjmnGQVP3sO
         nYA9M+wGKL1H4IR80Qm+2drsJuVKrCvpsxZJtnGW2WUfGugmwtUXHSA2Wv0MgSt8Iu
         2S+f6IafHhA7K5xu2UJH0RXYrexGvK3PPS/DQLp0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 4/6] s390/ptrace: fix setting syscall number
Date:   Tue, 23 Jun 2020 13:36:56 -0400
Message-Id: <20200623173658.1356241-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623173658.1356241-1-sashal@kernel.org>
References: <20200623173658.1356241-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit 873e5a763d604c32988c4a78913a8dab3862d2f9 ]

When strace wants to update the syscall number, it sets GPR2
to the desired number and updates the GPR via PTRACE_SETREGSET.
It doesn't update regs->int_code which would cause the old syscall
executed on syscall restart. As we cannot change the ptrace ABI and
don't have a field for the interruption code, check whether the tracee
is in a syscall and the last instruction was svc. In that case assume
that the tracer wants to update the syscall number and copy the GPR2
value to regs->int_code.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/ptrace.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index fc2974b929c37..ee757d6f585e6 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -308,6 +308,25 @@ static inline void __poke_user_per(struct task_struct *child,
 		child->thread.per_user.end = data;
 }
 
+static void fixup_int_code(struct task_struct *child, addr_t data)
+{
+	struct pt_regs *regs = task_pt_regs(child);
+	int ilc = regs->int_code >> 16;
+	u16 insn;
+
+	if (ilc > 6)
+		return;
+
+	if (ptrace_access_vm(child, regs->psw.addr - (regs->int_code >> 16),
+			&insn, sizeof(insn), FOLL_FORCE) != sizeof(insn))
+		return;
+
+	/* double check that tracee stopped on svc instruction */
+	if ((insn >> 8) != 0xa)
+		return;
+
+	regs->int_code = 0x20000 | (data & 0xffff);
+}
 /*
  * Write a word to the user area of a process at location addr. This
  * operation does have an additional problem compared to peek_user.
@@ -319,7 +338,9 @@ static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
 	struct user *dummy = NULL;
 	addr_t offset;
 
+
 	if (addr < (addr_t) &dummy->regs.acrs) {
+		struct pt_regs *regs = task_pt_regs(child);
 		/*
 		 * psw and gprs are stored on the stack
 		 */
@@ -337,7 +358,11 @@ static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
 				/* Invalid addressing mode bits */
 				return -EINVAL;
 		}
-		*(addr_t *)((addr_t) &task_pt_regs(child)->psw + addr) = data;
+
+		if (test_pt_regs_flag(regs, PIF_SYSCALL) &&
+			addr == offsetof(struct user, regs.gprs[2]))
+			fixup_int_code(child, data);
+		*(addr_t *)((addr_t) &regs->psw + addr) = data;
 
 	} else if (addr < (addr_t) (&dummy->regs.orig_gpr2)) {
 		/*
@@ -703,6 +728,10 @@ static int __poke_user_compat(struct task_struct *child,
 			regs->psw.mask = (regs->psw.mask & ~PSW_MASK_BA) |
 				(__u64)(tmp & PSW32_ADDR_AMODE);
 		} else {
+
+			if (test_pt_regs_flag(regs, PIF_SYSCALL) &&
+				addr == offsetof(struct compat_user, regs.gprs[2]))
+				fixup_int_code(child, data);
 			/* gpr 0-15 */
 			*(__u32*)((addr_t) &regs->psw + addr*2 + 4) = tmp;
 		}
-- 
2.25.1

