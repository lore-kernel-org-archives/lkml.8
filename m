Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F76DC4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1053D24680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgBYXaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:30:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55566 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbgBYXZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:54 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6ja3-0004Yi-RD; Wed, 26 Feb 2020 00:25:36 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 5B104101226;
        Wed, 26 Feb 2020 00:25:32 +0100 (CET)
Message-Id: <20200225221305.295289073@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:08:02 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 1/8] x86/entry/64: Trace irqflags unconditionally on when returing to user space
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

User space cannot longer disable interrupts so trace return to user space
unconditionally as IRQS_ON.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -174,7 +174,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_h
 	movq	%rsp, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
-	TRACE_IRQS_IRETQ		/* we're about to change IF */
+	TRACE_IRQS_ON			/* return enables interrupts */
 
 	/*
 	 * Try to use SYSRET instead of IRET if we're returning to
@@ -619,7 +619,7 @@ SYM_CODE_START_LOCAL(common_interrupt)
 .Lretint_user:
 	mov	%rsp,%rdi
 	call	prepare_exit_to_usermode
-	TRACE_IRQS_IRETQ
+	TRACE_IRQS_ON
 
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY

