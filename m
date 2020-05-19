Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B359C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 347EC2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgEST70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgEST7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:59:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA2BC08C5C0;
        Tue, 19 May 2020 12:59:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O9-0000AA-Rm; Tue, 19 May 2020 21:58:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CA77C1C0178;
        Tue, 19 May 2020 21:58:43 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:43 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/32: Move non entry code into .text section
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134340.320164650@linutronix.de>
References: <20200505134340.320164650@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832371.17951.6250394079949069799.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     cd809a7a917164820bdb20a7d41f3d1ce98ddc83
Gitweb:        https://git.kernel.org/tip/cd809a7a917164820bdb20a7d41f3d1ce98ddc83
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Mar 2020 19:47:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:49 +02:00

x86/entry/32: Move non entry code into .text section

All ASM code which is not part of the entry functionality can move out into
the .text section. No reason to keep it in the non-instrumentable entry
section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134340.320164650@linutronix.de


---
 arch/x86/entry/entry_32.S |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index a5eed84..bf0082b 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -730,6 +730,7 @@
  * %eax: prev task
  * %edx: next task
  */
+.pushsection .text, "ax"
 SYM_CODE_START(__switch_to_asm)
 	/*
 	 * Save callee-saved registers
@@ -776,6 +777,7 @@ SYM_CODE_START(__switch_to_asm)
 
 	jmp	__switch_to
 SYM_CODE_END(__switch_to_asm)
+.popsection
 
 /*
  * The unwinder expects the last frame on the stack to always be at the same
@@ -784,6 +786,7 @@ SYM_CODE_END(__switch_to_asm)
  * asmlinkage function so its argument has to be pushed on the stack.  This
  * wrapper creates a proper "end of stack" frame header before the call.
  */
+.pushsection .text, "ax"
 SYM_FUNC_START(schedule_tail_wrapper)
 	FRAME_BEGIN
 
@@ -794,6 +797,8 @@ SYM_FUNC_START(schedule_tail_wrapper)
 	FRAME_END
 	ret
 SYM_FUNC_END(schedule_tail_wrapper)
+.popsection
+
 /*
  * A newly forked process directly context switches into this address.
  *
@@ -801,6 +806,7 @@ SYM_FUNC_END(schedule_tail_wrapper)
  * ebx: kernel thread func (NULL for user thread)
  * edi: kernel thread arg
  */
+.pushsection .text, "ax"
 SYM_CODE_START(ret_from_fork)
 	call	schedule_tail_wrapper
 
@@ -825,6 +831,7 @@ SYM_CODE_START(ret_from_fork)
 	movl	$0, PT_EAX(%esp)
 	jmp	2b
 SYM_CODE_END(ret_from_fork)
+.popsection
 
 /*
  * Return to user mode is not as complex as all this looks,
@@ -1691,6 +1698,7 @@ SYM_CODE_START(general_protection)
 	jmp	common_exception
 SYM_CODE_END(general_protection)
 
+.pushsection .text, "ax"
 SYM_CODE_START(rewind_stack_do_exit)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
@@ -1701,3 +1709,4 @@ SYM_CODE_START(rewind_stack_do_exit)
 	call	do_exit
 1:	jmp 1b
 SYM_CODE_END(rewind_stack_do_exit)
+.popsection
