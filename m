Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F50C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA892078D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgEEON7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729450AbgEEONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:13:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF77C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:13:53 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKG-0000Wg-ON; Tue, 05 May 2020 16:13:36 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 3C0B8FFC8D;
        Tue,  5 May 2020 16:13:36 +0200 (CEST)
Message-Id: <20200505134059.878578033@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:20 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 1 18/36] samples/kprobes: Add __kprobes and
 NOKPROBE_SYMBOL() for handlers.
References: <20200505131602.633487962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add __kprobes and NOKPROBE_SYMBOL() for sample kprobe handlers.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/158523421177.24735.16273975317343670204.stgit@devnote2

---
 samples/kprobes/kprobe_example.c    |    6 ++++--
 samples/kprobes/kretprobe_example.c |    2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -25,7 +25,7 @@ static struct kprobe kp = {
 };
 
 /* kprobe pre_handler: called just before the probed instruction is executed */
-static int handler_pre(struct kprobe *p, struct pt_regs *regs)
+static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
 {
 #ifdef CONFIG_X86
 	pr_info("<%s> pre_handler: p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
@@ -54,7 +54,7 @@ static int handler_pre(struct kprobe *p,
 }
 
 /* kprobe post_handler: called after the probed instruction is executed */
-static void handler_post(struct kprobe *p, struct pt_regs *regs,
+static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
 				unsigned long flags)
 {
 #ifdef CONFIG_X86
@@ -90,6 +90,8 @@ static int handler_fault(struct kprobe *
 	/* Return 0 because we don't handle the fault. */
 	return 0;
 }
+/* NOKPROBE_SYMBOL() is also available */
+NOKPROBE_SYMBOL(handler_fault);
 
 static int __init kprobe_init(void)
 {
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -48,6 +48,7 @@ static int entry_handler(struct kretprob
 	data->entry_stamp = ktime_get();
 	return 0;
 }
+NOKPROBE_SYMBOL(entry_handler);
 
 /*
  * Return-probe handler: Log the return value and duration. Duration may turn
@@ -67,6 +68,7 @@ static int ret_handler(struct kretprobe_
 			func_name, retval, (long long)delta);
 	return 0;
 }
+NOKPROBE_SYMBOL(ret_handler);
 
 static struct kretprobe my_kretprobe = {
 	.handler		= ret_handler,

