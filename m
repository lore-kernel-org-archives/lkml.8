Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C511C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D31724670
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgBYXZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:25:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55520 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbgBYXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:50 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6ja5-0004ZG-9z; Wed, 26 Feb 2020 00:25:37 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C37C8104094;
        Wed, 26 Feb 2020 00:25:32 +0100 (CET)
Message-Id: <20200225221305.496864179@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:08:04 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 3/8] x86/entry/common: Mark syscall entry points notrace/nokprobe
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

Anything before enter_from_user_mode() is not safe to be traced or probed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -314,11 +314,12 @@ void do_syscall_64_irqs_on(unsigned long
 	syscall_return_slowpath(regs);
 }
 
-__visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+__visible notrace void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 	syscall_entry_fixups();
 	do_syscall_64_irqs_on(nr, regs);
 }
+NOKPROBE_SYMBOL(do_syscall_64);
 #endif
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
@@ -369,11 +370,12 @@ static __always_inline void do_syscall_3
 }
 
 /* Handles int $0x80 */
-__visible void do_int80_syscall_32(struct pt_regs *regs)
+__visible notrace void do_int80_syscall_32(struct pt_regs *regs)
 {
 	syscall_entry_fixups();
 	do_syscall_32_irqs_on(regs);
 }
+NOKPROBE_SYMBOL(do_int80_syscall_32);
 
 /* Fast syscall 32bit variant */
 static __always_inline long do_fast_syscall_32_irqs_on(struct pt_regs *regs)
@@ -449,10 +451,11 @@ static __always_inline long do_fast_sysc
 }
 
 /* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
-__visible long do_fast_syscall_32(struct pt_regs *regs)
+__visible notrace long do_fast_syscall_32(struct pt_regs *regs)
 {
 	syscall_entry_fixups();
 	return do_fast_syscall_32_irqs_on(regs);
 }
+NOKPROBE_SYMBOL(do_fast_syscall_32);
 
 #endif /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */

