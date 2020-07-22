Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571F2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3724D2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbgGVXVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:21:11 -0400
Received: from outpost17.zedat.fu-berlin.de ([130.133.4.110]:40571 "EHLO
        outpost17.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733132AbgGVXVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:21:10 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2020 19:21:08 EDT
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <mkarcher@physik.fu-berlin.de>)
          id 1jyNwD-000bZx-OI; Thu, 23 Jul 2020 01:14:13 +0200
Received: from mx.physik.fu-berlin.de ([160.45.64.218])
          by relay1.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_DHE_RSA_WITH_AES_128_CBC_SHA
          (envelope-from <mkarcher@physik.fu-berlin.de>)
          id 1jyNwD-001IvP-Lp; Thu, 23 Jul 2020 01:14:13 +0200
Received: from epyc.physik.fu-berlin.de ([160.45.64.180])
        by mx.physik.fu-berlin.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <mkarcher@physik.fu-berlin.de>)
        id 1jyNw6-0002TM-Ay; Thu, 23 Jul 2020 01:14:06 +0200
Received: from mkarcher by epyc.physik.fu-berlin.de with local (Exim 4.94 #2 (Debian))
        id 1jyNw6-001lBg-23; Thu, 23 Jul 2020 01:14:06 +0200
From:   Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
To:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH 2/4] sh: Rearrange blocks in entry-common.S
Date:   Thu, 23 Jul 2020 01:13:20 +0200
Message-Id: <20200722231322.419642-2-kernel@mkarcher.dialup.fu-berlin.de>
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

This avoids out-of-range jumps that get auto-replaced by the assembler
and prepares for the changes needed to implement SECCOMP_FILTER cleanly.

Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 arch/sh/kernel/entry-common.S | 57 ++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index 9bac5bbb67f3..c4d88d61890d 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -178,34 +178,6 @@ syscall_exit_work:
 	bra	resume_userspace
 	 nop
 
-	.align	2
-syscall_trace_entry:
-	!                     	Yes it is traced.
-	mov     r15, r4
-	mov.l	7f, r11		! Call do_syscall_trace_enter which notifies
-	jsr	@r11	    	! superior (will chomp R[0-7])
-	 nop
-	mov.l	r0, @(OFF_R0,r15)	! Save return value
-	!			Reload R0-R4 from kernel stack, where the
-	!   	    	    	parent may have modified them using
-	!   	    	    	ptrace(POKEUSR).  (Note that R0-R2 are
-	!   	    	    	reloaded from the kernel stack by syscall_call
-	!   	    	    	below, so don't need to be reloaded here.)
-	!   	    	    	This allows the parent to rewrite system calls
-	!   	    	    	and args on the fly.
-	mov.l	@(OFF_R4,r15), r4   ! arg0
-	mov.l	@(OFF_R5,r15), r5
-	mov.l	@(OFF_R6,r15), r6
-	mov.l	@(OFF_R7,r15), r7   ! arg3
-	mov.l	@(OFF_R3,r15), r3   ! syscall_nr
-	!
-	mov.l	6f, r10			! Number of syscalls
-	cmp/hs	r10, r3
-	bf	syscall_call
-	mov	#-ENOSYS, r0
-	bra	syscall_exit
-	 mov.l	r0, @(OFF_R0,r15)	! Return value
-
 __restore_all:
 	mov	#OFF_SR, r0
 	mov.l	@(r0,r15), r0	! get status register
@@ -388,6 +360,35 @@ syscall_exit:
 	bf	syscall_exit_work
 	bra	__restore_all
 	 nop
+
+	.align	2
+syscall_trace_entry:
+	!                     	Yes it is traced.
+	mov     r15, r4
+	mov.l	7f, r11		! Call do_syscall_trace_enter which notifies
+	jsr	@r11	    	! superior (will chomp R[0-7])
+	 nop
+	mov.l	r0, @(OFF_R0,r15)	! Save return value
+	!			Reload R0-R4 from kernel stack, where the
+	!   	    	    	parent may have modified them using
+	!   	    	    	ptrace(POKEUSR).  (Note that R0-R2 are
+	!   	    	    	reloaded from the kernel stack by syscall_call
+	!   	    	    	below, so don't need to be reloaded here.)
+	!   	    	    	This allows the parent to rewrite system calls
+	!   	    	    	and args on the fly.
+	mov.l	@(OFF_R4,r15), r4   ! arg0
+	mov.l	@(OFF_R5,r15), r5
+	mov.l	@(OFF_R6,r15), r6
+	mov.l	@(OFF_R7,r15), r7   ! arg3
+	mov.l	@(OFF_R3,r15), r3   ! syscall_nr
+	!
+	mov.l	6f, r10			! Number of syscalls
+	cmp/hs	r10, r3
+	bf	syscall_call
+	mov	#-ENOSYS, r0
+	bra	syscall_exit
+	 mov.l	r0, @(OFF_R0,r15)	! Return value
+
 	.align	2
 #if !defined(CONFIG_CPU_SH2)
 1:	.long	TRA
-- 
2.28.0.rc1

