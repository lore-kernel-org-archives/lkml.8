Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E77C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E3B24680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgBYX04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:26:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55957 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730370AbgBYX0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:43 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jao-0004za-Gg; Wed, 26 Feb 2020 00:26:23 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id CD34C1040BA;
        Wed, 26 Feb 2020 00:25:47 +0100 (CET)
Message-Id: <20200225224145.764810350@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:33:37 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 16/16] x86/entry: Disable interrupts in IDTENTRY
References: <20200225223321.231477305@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all exceptions guarantee to return with interrupts disabled. Disable
them in idtentry_exit() which is invoked on all regular (non IST) exception
entry points. Preparatory patch for further consolidation of the return
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S       |    3 +--
 arch/x86/include/asm/idtentry.h |    3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1336,8 +1336,7 @@ SYM_CODE_END(error_entry)
 
 SYM_CODE_START_LOCAL(error_exit)
 	UNWIND_HINT_REGS
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
+	DEBUG_ENTRY_ASSERT_IRQS_OFF
 	testb	$3, CS(%rsp)
 	jz	retint_kernel
 	jmp	.Lretint_user
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -37,10 +37,11 @@ static __always_inline void idtentry_ent
 /**
  * idtentry_exit - Prepare returning to low level ASM code
  *
- * Place holder for now.
+ * Disables interrupts before returning
  */
 static __always_inline void idtentry_exit(struct pt_regs *regs)
 {
+	local_irq_disable();
 }
 
 /**

