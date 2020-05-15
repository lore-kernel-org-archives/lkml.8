Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2FBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F6A2078B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgEPAKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbgEPAKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:10:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E9C05BD0A
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 17:10:38 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZkP6-00025f-El; Sat, 16 May 2020 02:10:12 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C3057FF834;
        Sat, 16 May 2020 02:10:11 +0200 (CEST)
Message-Id: <20200515235124.783722942@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 May 2020 01:45:51 +0200
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V6 04/37] x86: Make hardware latency tracing explicit
References: <20200515234547.710474468@linutronix.de>
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


The hardware latency tracer calls into trace_sched_clock and ends up in
various instrumentable functions which is problemeatic vs. the kprobe
handling especially the text poke machinery. It's invoked from
nmi_enter/exit(), i.e. non-instrumentable code.

Use nmi_enter/exit_notrace() instead. These variants do not invoke the
hardware latency tracer which avoids chasing down complex callchains to
make them non-instrumentable.

The real interesting measurement is the actual NMI handler. Add an explicit
invocation for the hardware latency tracer to it.

#DB and #BP are uninteresting as they really should not be in use when
analzying hardware induced latencies.

If #DF hits, hardware latency is definitely not interesting anymore and in
case of a machine check the hardware latency is not the most troublesome
issue either.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/mce/core.c |    4 ++--
 arch/x86/kernel/nmi.c          |    6 ++++--
 arch/x86/kernel/traps.c        |   12 +++++++-----
 3 files changed, 13 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1916,7 +1916,7 @@ static __always_inline void exc_machine_
 	    mce_check_crashing_cpu())
 		return;
 
-	nmi_enter();
+	nmi_enter_notrace();
 	/*
 	 * The call targets are marked noinstr, but objtool can't figure
 	 * that out because it's an indirect call. Annotate it.
@@ -1924,7 +1924,7 @@ static __always_inline void exc_machine_
 	instrumentation_begin();
 	machine_check_vector(regs);
 	instrumentation_end();
-	nmi_exit();
+	nmi_exit_notrace();
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -334,6 +334,7 @@ static noinstr void default_do_nmi(struc
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
 	instrumentation_begin();
+	ftrace_nmi_handler_enter();
 
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
@@ -420,6 +421,7 @@ static noinstr void default_do_nmi(struc
 		unknown_nmi_error(reason, regs);
 
 out:
+	ftrace_nmi_handler_exit();
 	instrumentation_end();
 }
 
@@ -536,14 +538,14 @@ DEFINE_IDTENTRY_NMI(exc_nmi)
 	}
 #endif
 
-	nmi_enter();
+	nmi_enter_notrace();
 
 	inc_irq_stat(__nmi_count);
 
 	if (!ignore_nmis)
 		default_do_nmi(regs);
 
-	nmi_exit();
+	nmi_exit_notrace();
 
 #ifdef CONFIG_X86_64
 	if (unlikely(this_cpu_read(update_debug_stack))) {
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -387,7 +387,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	}
 #endif
 
-	nmi_enter();
+	nmi_enter_notrace();
 	instrumentation_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
@@ -632,12 +632,14 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		instrumentation_end();
 		idtentry_exit(regs);
 	} else {
-		nmi_enter();
+		nmi_enter_notrace();
 		instrumentation_begin();
+		ftrace_nmi_handler_enter();
 		if (!do_int3(regs))
 			die("int3", regs, 0);
+		ftrace_nmi_handler_exit();
 		instrumentation_end();
-		nmi_exit();
+		nmi_exit_notrace();
 	}
 }
 
@@ -849,7 +851,7 @@ static void noinstr handle_debug(struct
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 					     unsigned long dr6)
 {
-	nmi_enter();
+	nmi_enter_notrace();
 	/*
 	 * The SDM says "The processor clears the BTF flag when it
 	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
@@ -871,7 +873,7 @@ static __always_inline void exc_debug_ke
 	if (dr6)
 		handle_debug(regs, dr6, false);
 
-	nmi_exit();
+	nmi_exit_notrace();
 }
 
 static __always_inline void exc_debug_user(struct pt_regs *regs,

