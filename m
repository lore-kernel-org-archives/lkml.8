Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A08C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837EF222C3
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgCHXZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:25:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57239 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgCHXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:23:55 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Gg-00035I-LO; Mon, 09 Mar 2020 00:23:35 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 05C631040AD;
        Mon,  9 Mar 2020 00:23:30 +0100 (CET)
Message-Id: <20200308222609.825111830@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 08 Mar 2020 23:24:08 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-II V2 09/13] x86/entry/common: Split hardirq tracing into lockdep and ftrace parts
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

trace_hardirqs_off() is in fact a tracepoint which can be utilized by BPF,
which is unsafe before calling enter_from_user_mode(), which in turn
invokes context tracking. trace_hardirqs_off() also invokes
lockdep_hardirqs_off() under the hood.

OTOH lockdep needs to know about the interrupts disabled state before
enter_from_user_mode(). lockdep_hardirqs_off() is safe to call at this
point.

Split it so lockdep knows about the state and invoke the tracepoint after
the context is set straight.

Even if the functions attached to a tracepoint would all be safe to be
called in rcuidle having it split up is still giving a performance
advantage because rcu_read_lock_sched() is avoiding the whole dance of:

   scru_read_lock();
   rcu_irq_enter_irqson();
   ...
   rcu_irq_exit_irqson();
   scru_read_unlock();
   
around the tracepoint function invocation just to have the C entry points
of syscalls call enter_from_user_mode() right after the above dance.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/entry/common.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -60,10 +60,19 @@ static __always_inline void syscall_entr
 {
 	/*
 	 * Usermode is traced as interrupts enabled, but the syscall entry
-	 * mechanisms disable interrupts. Tell the tracer.
+	 * mechanisms disable interrupts. Tell lockdep before calling
+	 * enter_from_user_mode(). This is safe vs. RCU while the
+	 * tracepoint is not.
 	 */
-	trace_hardirqs_off();
+	lockdep_hardirqs_on(CALLER_ADDR0);
+
 	enter_from_user_mode();
+
+	/*
+	 * Tell the tracer about the irq state as well before enabling
+	 * interrupts.
+	 */
+	__trace_hardirqs_off();
 	local_irq_enable();
 }
 

