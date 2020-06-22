Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0F2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD28620644
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgFVRB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbgFVRBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:01:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95C4C061573;
        Mon, 22 Jun 2020 10:01:25 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jnPox-0005ms-Mb; Mon, 22 Jun 2020 19:01:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0652D1C0051;
        Mon, 22 Jun 2020 19:01:23 +0200 (CEST)
Date:   Mon, 22 Jun 2020 17:01:22 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] selftests/x86: Add a syscall_arg_fault_64 test
 for negative GSBASE
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f4f71efc91b9eae5e3dae21c9aee1c70cf5f370e.1590620529.git.luto@kernel.org>
References: <f4f71efc91b9eae5e3dae21c9aee1c70cf5f370e.1590620529.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159284528271.16989.5534524906632422674.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     a5d25e01c8146ad8846da4760422e12242fceafe
Gitweb:        https://git.kernel.org/tip/a5d25e01c8146ad8846da4760422e12242fceafe
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 27 May 2020 16:02:36 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 22 Jun 2020 18:56:36 +02:00

selftests/x86: Add a syscall_arg_fault_64 test for negative GSBASE

If the kernel erroneously allows WRGSBASE and user code writes a
negative value, paranoid_entry will get confused. Check for this by
writing a negative value to GSBASE and doing SYSENTER with TF set. A
successful run looks like:

    [RUN]	SYSENTER with TF, invalid state, and GSBASE < 0
    [SKIP]	Illegal instruction

A failed run causes a kernel hang, and I believe it's because we
double-fault and then get a never ending series of page faults and,
when we exhaust the double fault stack we double fault again,
starting the process over.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/f4f71efc91b9eae5e3dae21c9aee1c70cf5f370e.1590620529.git.luto@kernel.org
---
 tools/testing/selftests/x86/syscall_arg_fault.c | 26 ++++++++++++++++-
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index bc0ecc2..62fba40 100644
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
