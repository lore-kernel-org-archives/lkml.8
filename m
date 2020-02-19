Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B685EC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911652465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSRQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:16:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgBSRQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:16:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E448724672;
        Wed, 19 Feb 2020 17:16:10 +0000 (UTC)
Date:   Wed, 19 Feb 2020 12:16:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH] rcu/kprobes: Comment why rcu_nmi_enter() is marked NOKPROBE
Message-ID: <20200219121609.45548925@gandalf.local.home>
In-Reply-To: <20200219163156.GY2935@paulmck-ThinkPad-P72>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.661923520@infradead.org>
        <20200219163156.GY2935@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

It's confusing that rcu_nmi_enter() is marked NOKPROBE and
rcu_nmi_exit() is not. One may think that the exit needs to be marked
for the same reason the enter is, as rcu_nmi_exit() reverts the RCU
state back to what it was before rcu_nmi_enter(). But the reason has
nothing to do with the state of RCU.

The breakpoint handler (int3 on x86) must not have any kprobe on it
until the kprobe handler is called. Otherwise, it can cause an infinite
recursion and crash the machine. It just so happens that
rcu_nmi_enter() is called by the int3 handler before the kprobe handler
can run, and therefore needs to be marked as NOKPROBE.

Comment this to remove the confusion to why rcu_nmi_enter() is marked
NOKPROBE but rcu_nmi_exit() is not.

Link: https://lore.kernel.org/r/20200213163800.5c51a5f1@gandalf.local.home
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1694a6b57ad8..ada7b2b638fb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -846,6 +846,14 @@ void rcu_nmi_enter(void)
 {
 	rcu_nmi_enter_common(false);
 }
+/*
+ * All functions called in the breakpoint trap handler (e.g. do_int3()
+ * on x86), must not allow kprobes until the kprobe breakpoint handler
+ * is called, otherwise it can cause an infinite recursion.
+ * On some archs, rcu_nmi_enter() is called in the breakpoint handler
+ * before the kprobe breakpoint handler is called, thus it must be
+ * marked as NOKPROBE.
+ */
 NOKPROBE_SYMBOL(rcu_nmi_enter);
 
 /**
