Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02DEC2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6172492C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbgELWXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731369AbgELWXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:23:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB23C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:23:22 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYdIH-0004jL-JN; Wed, 13 May 2020 00:22:34 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 15AF91006A1;
        Wed, 13 May 2020 00:22:32 +0200 (CEST)
Message-Id: <20200512213810.518709291@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 12 May 2020 23:01:10 +0200
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
Subject: [patch V5 11/38] rcu: Provide __rcu_is_watching()
References: <20200512210059.056244513@linutronix.de>
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

Same as rcu_is_watching() but without the preempt_disable/enable() pair
inside the function. It is merked noinstr so it ends up in the
non-instrumentable text section.

This is useful for non-preemptible code especially in the low level entry
section. Using rcu_is_watching() there results in a call to the
preempt_schedule_notrace() thunk which triggers noinstr section warnings in
objtool.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 include/linux/rcutiny.h |    1 +
 include/linux/rcutree.h |    1 +
 kernel/rcu/tree.c       |    5 +++++
 3 files changed, 7 insertions(+)

--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -86,6 +86,7 @@ static inline void rcu_scheduler_startin
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
+static inline bool __rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_dyntick_idle(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
 static inline bool rcu_gp_might_be_stalled(void) { return false; }
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -58,6 +58,7 @@ extern int rcu_scheduler_active __read_m
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
+bool __rcu_is_watching(void);
 #ifndef CONFIG_PREEMPTION
 void rcu_all_qs(void);
 #endif
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -984,6 +984,11 @@ static void rcu_disable_urgency_upon_qs(
 	}
 }
 
+noinstr bool __rcu_is_watching(void)
+{
+	return !rcu_dynticks_curr_cpu_in_eqs();
+}
+
 /**
  * rcu_is_watching - see if RCU thinks that the current CPU is not idle
  *

