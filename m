Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F072C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435A022B47
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbgGVXVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:21:18 -0400
Received: from outpost17.zedat.fu-berlin.de ([130.133.4.110]:40571 "EHLO
        outpost17.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733219AbgGVXVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:21:17 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2020 19:21:08 EDT
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <mkarcher@physik.fu-berlin.de>)
          id 1jyNwG-000baX-ST; Thu, 23 Jul 2020 01:14:16 +0200
Received: from mx.physik.fu-berlin.de ([160.45.64.218])
          by relay1.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_DHE_RSA_WITH_AES_128_CBC_SHA
          (envelope-from <mkarcher@physik.fu-berlin.de>)
          id 1jyNwG-001Iw5-QC; Thu, 23 Jul 2020 01:14:16 +0200
Received: from epyc.physik.fu-berlin.de ([160.45.64.180])
        by mx.physik.fu-berlin.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <mkarcher@physik.fu-berlin.de>)
        id 1jyNwA-0002UU-5I; Thu, 23 Jul 2020 01:14:10 +0200
Received: from mkarcher by epyc.physik.fu-berlin.de with local (Exim 4.94 #2 (Debian))
        id 1jyNw9-001lBn-T7; Thu, 23 Jul 2020 01:14:09 +0200
From:   Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
To:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH 3/4] sh: Add SECCOMP_FILTER
Date:   Thu, 23 Jul 2020 01:13:21 +0200
Message-Id: <20200722231322.419642-3-kernel@mkarcher.dialup.fu-berlin.de>
X-Mailer: git-send-email 2.28.0.rc1
In-Reply-To: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
References: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 160.45.64.218
X-ZEDAT-Hint: RV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port sh to use the new SECCOMP_FILTER code.

Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 arch/sh/Kconfig                               | 1 +
 arch/sh/kernel/entry-common.S                 | 2 ++
 arch/sh/kernel/ptrace_32.c                    | 5 +++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 8 +++++++-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 32d959849df9..10b510c16841 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -27,6 +27,7 @@ config SUPERH
 	select GENERIC_SMP_IDLE_THREAD
 	select GUP_GET_PTE_LOW_HIGH if X2TLB
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DEBUG_BUGVERBOSE
diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index c4d88d61890d..ad963104d22d 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -368,6 +368,8 @@ syscall_trace_entry:
 	mov.l	7f, r11		! Call do_syscall_trace_enter which notifies
 	jsr	@r11	    	! superior (will chomp R[0-7])
 	 nop
+	cmp/eq	#-1, r0
+	bt	syscall_exit
 	mov.l	r0, @(OFF_R0,r15)	! Save return value
 	!			Reload R0-R4 from kernel stack, where the
 	!   	    	    	parent may have modified them using
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 64bfb714943e..25ccfbd02bfa 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -485,8 +485,6 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	long ret = 0;
 
-	secure_computing_strict(regs->regs[0]);
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs))
 		/*
@@ -496,6 +494,9 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 		 */
 		ret = -1L;
 
+	if (secure_computing() == -1)
+		return -1;
+
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[0]);
 
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 252140a52553..6eb21685c88f 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -122,6 +122,8 @@ struct seccomp_data {
 #  define __NR_seccomp 358
 # elif defined(__s390__)
 #  define __NR_seccomp 348
+# elif defined(__sh__)
+#  define __NR_seccomp 372
 # else
 #  warning "seccomp syscall number unknown for this architecture"
 #  define __NR_seccomp 0xffff
@@ -1622,6 +1624,10 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 # define SYSCALL_SYSCALL_NUM regs[4]
 # define SYSCALL_RET	regs[2]
 # define SYSCALL_NUM_RET_SHARE_REG
+#elif defined(__sh__)
+# define ARCH_REGS	struct pt_regs
+# define SYSCALL_NUM	gpr[3]
+# define SYSCALL_RET	gpr[0]
 #else
 # error "Do not know how to find your architecture's registers and syscalls"
 #endif
@@ -1693,7 +1699,7 @@ void change_syscall(struct __test_metadata *_metadata,
 	EXPECT_EQ(0, ret) {}
 
 #if defined(__x86_64__) || defined(__i386__) || defined(__powerpc__) || \
-	defined(__s390__) || defined(__hppa__) || defined(__riscv)
+	defined(__s390__) || defined(__hppa__) || defined(__riscv) || defined(__sh__)
 	{
 		regs.SYSCALL_NUM = syscall;
 	}
-- 
2.28.0.rc1

