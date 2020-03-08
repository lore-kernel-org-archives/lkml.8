Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8461CC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E5120863
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgCHXZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:25:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57260 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgCHXX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:23:57 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Gl-00036r-Pt; Mon, 09 Mar 2020 00:23:41 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id E657E1040B5;
        Mon,  9 Mar 2020 00:23:30 +0100 (CET)
Message-Id: <20200308222610.245444311@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 08 Mar 2020 23:24:12 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-II V2 13/13] x86/entry/common: Split irq tracing in prepare_exit_to_usermode()
References: <20200308222359.370649591@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As in entry from user mode, lockdep and tracing have different
requirements. lockdep needs to know about the interrupts off state accross
the call to user_enter_irqsoff() but tracing is unsafe after the call.

Split it up and tell the tracer that interrupts are going to be enabled
before calling user_enter_irqsoff() and tell lockdep afterwards.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -251,9 +251,19 @@ static noinline void __prepare_exit_to_u
 {
 	__prepare_exit_to_usermode(regs);
 
+	/*
+	 * Return to user space enables interrupts. Tell the tracer before
+	 * invoking user_enter_irqsoff() which switches to CONTEXT_USER and
+	 * RCU to rcuidle state. Lockdep still needs to keep the irqs
+	 * disabled state.
+	 */
+	__trace_hardirqs_on();
+
 	user_enter_irqoff();
 	mds_user_clear_cpu_buffers();
-	trace_hardirqs_on();
+
+	/* All done. Tell lockdep as well. */
+	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 NOKPROBE_SYMBOL(prepare_exit_to_usermode);
 

