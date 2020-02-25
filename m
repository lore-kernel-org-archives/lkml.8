Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECDDC4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD4124680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgBYXZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:25:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55517 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbgBYXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:50 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6ja6-0004au-Q9; Wed, 26 Feb 2020 00:25:39 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id A6DAC104099;
        Wed, 26 Feb 2020 00:25:33 +0100 (CET)
Message-Id: <20200225221305.919875257@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:08:08 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 7/8] x86/entry: Move irq tracing to prepare_exit_to_user_mode()
References: <20200225220801.571835584@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

which again gets it out of the ASM code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c   |    1 +
 arch/x86/entry/entry_32.S |    2 +-
 arch/x86/entry/entry_64.S |    1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -244,6 +244,7 @@ static inline void __prepare_exit_to_use
 __visible inline notrace void prepare_exit_to_usermode(struct pt_regs *regs)
 {
 	__prepare_exit_to_usermode(regs);
+	trace_hardirqs_on();
 }
 NOKPROBE_SYMBOL(prepare_exit_to_usermode);
 
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -855,7 +855,7 @@ SYM_CODE_START_LOCAL(ret_from_exception)
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
 	call	prepare_exit_to_usermode
-	jmp	restore_all
+	jmp	restore_all_switch_stack
 SYM_CODE_END(ret_from_exception)
 
 SYM_ENTRY(__begin_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -614,7 +614,6 @@ SYM_CODE_START_LOCAL(common_interrupt)
 .Lretint_user:
 	mov	%rsp,%rdi
 	call	prepare_exit_to_usermode
-	TRACE_IRQS_ON
 
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY

