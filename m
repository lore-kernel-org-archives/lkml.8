Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6435C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6E8207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590620559;
	bh=74TO1RGMg81O6r2d7CQjDhADvcSRIb+eipXPQYo/VzA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=J6cR1XZHUckr15PYZw4A5vA4af1qC4qmaITw1Ohi+MCzRN0a0jkEr0l9WaxggARSs
	 nL79+QPNTXq0jaj7XBdnY4aga+Vmk507/J1wcbiaciPlS8RSh8pdHtLHn2/VWSOYj7
	 x4FnuRH/UqcRycObEmtxAdKVnCr53yl5dPiIa+uY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgE0XCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 19:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0XCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 19:02:38 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA6902075F;
        Wed, 27 May 2020 23:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590620558;
        bh=74TO1RGMg81O6r2d7CQjDhADvcSRIb+eipXPQYo/VzA=;
        h=From:To:Cc:Subject:Date:From;
        b=jvd3ntDzRZbS5wbSBVyse0QhFGTYxu/Qjw7I5KSJcEpBwnDj0gaQXqteVTvY1G7+a
         7hTtqa6xgB6pE0+xkQrnBEduPAuyPZUAEXh8wq4eBsusYZtk9OyA83KtPvzLPLLdiF
         A8cB53XcpH9jYN+fiHq1jpMsdtldnz0yMr/AzO8o=
From:   Andy Lutomirski <luto@kernel.org>
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] selftests/x86: Add a syscall_arg_fault_64 test for negative GSBASE
Date:   Wed, 27 May 2020 16:02:36 -0700
Message-Id: <f4f71efc91b9eae5e3dae21c9aee1c70cf5f370e.1590620529.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel erroneously allows WRGSBASE and user code writes a
negative value, paranoid_entry will get confused.  Check for this by
writing a negative value to GSBASE and doing SYSENTER with TF set.
A successful run looks like:

    [RUN]	SYSENTER with TF, invalid state, and GSBASE < 0
    [SKIP]	Illegal instruction

A failed run causes a kernel hang, and I believe it's because we
double-fault and then get a never ending series of page faults and,
when we exhaust the double fault stack we double fault again,
starting the process over.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 .../testing/selftests/x86/syscall_arg_fault.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index bc0ecc2e862e..62fba40866d5 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -72,6 +72,7 @@ static void sigsegv_or_sigbus(int sig, siginfo_t *info, void *ctx_void)
 	if (ax != -EFAULT && ax != -ENOSYS) {
 		printf("[FAIL]\tAX had the wrong value: 0x%lx\n",
 		       (unsigned long)ax);
+		printf("\tIP = 0x%lx\n", (unsigned long)ctx->uc_mcontext.gregs[REG_IP]);
 		n_errs++;
 	} else {
 		printf("[OK]\tSeems okay\n");
@@ -226,5 +227,30 @@ int main()
 	}
 	set_eflags(get_eflags() & ~X86_EFLAGS_TF);
 
+#ifdef __x86_64__
+	printf("[RUN]\tSYSENTER with TF, invalid state, and GSBASE < 0\n");
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		sigtrap_consecutive_syscalls = 0;
+
+		asm volatile ("wrgsbase %%rax\n\t"
+			      :: "a" (0xffffffffffff0000UL));
+
+		set_eflags(get_eflags() | X86_EFLAGS_TF);
+		asm volatile (
+			"movl $-1, %%eax\n\t"
+			"movl $-1, %%ebx\n\t"
+			"movl $-1, %%ecx\n\t"
+			"movl $-1, %%edx\n\t"
+			"movl $-1, %%esi\n\t"
+			"movl $-1, %%edi\n\t"
+			"movl $-1, %%ebp\n\t"
+			"movl $-1, %%esp\n\t"
+			"sysenter"
+			: : : "memory", "flags");
+	}
+	set_eflags(get_eflags() & ~X86_EFLAGS_TF);
+#endif
+
 	return 0;
 }
-- 
2.25.4

