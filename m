Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0588C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69AF520732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F6bQulPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgHUKWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgHUKVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:21:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3046FC061388
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=WNU654V3brid1HO9uv0IDw05DX0Ulatj1b4QJavZgHs=; b=F6bQulPpBwwyJ6qLHNwzE2zb3R
        IblckB8mw/PI1fXQF8YU+qdIi7TSDMMMHGkjQZoZlwBUBxQvZt/66UxEMo5q4hFh31lolUorjDKM5
        rrkXzDwXHCWzKVG4J84XwnwPYa1eLB8ejBoQvDDzkWvhMuxg5q5j0KXOUAcoYQ7EC2121scJF6+ns
        md354Hx084queJahstjG/VKu2fbGihCPpBTvbOWI7OBEPuzxMVW6eO9Gedn//r2RfDDgcd9qNlfU4
        snEVKKubXhOrbPaxKLYiK9pwHYhbe2vIWXlA5kJUtQvj3YJ07Gk3AC+wps6m3MO0R5a1eT8QZlOiZ
        YQnonK8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k94An-0008GO-RW; Fri, 21 Aug 2020 10:21:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8621F305B23;
        Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5EF422C8FF368; Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Message-ID: <20200821102053.034965283@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 11:39:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 5/8] x86/debug: Simplify #DB signal code
References: <20200821093912.815135402@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the two variables, avoid computing si_code when not needed
and be consistent about which dr6 value is used.

This makes it easier to shuffle code around later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -786,15 +786,6 @@ static __always_inline unsigned long deb
 static void handle_debug(struct pt_regs *regs, unsigned long dr6)
 {
 	struct task_struct *tsk = current;
-	bool user_icebp;
-	int si_code;
-
-	/*
-	 * If dr6 has no reason to give us about the origin of this trap,
-	 * then it's very likely the result of an icebp/int01 trap.
-	 * User wants a sigtrap for that.
-	 */
-	user_icebp = !dr6;
 
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
@@ -813,6 +804,11 @@ static void handle_debug(struct pt_regs
 		goto out;
 	}
 
+	/*
+	 * Reload dr6, the notifier might have changed it.
+	 */
+	dr6 = tsk->thread.debugreg6;
+
 	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
 		/*
 		 * Historical junk that used to handle SYSENTER single-stepping.
@@ -825,9 +821,13 @@ static void handle_debug(struct pt_regs
 		regs->flags &= ~X86_EFLAGS_TF;
 	}
 
-	si_code = get_si_code(tsk->thread.debugreg6);
-	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
-		send_sigtrap(regs, 0, si_code);
+	/*
+	 * If dr6 has no reason to give us about the origin of this trap,
+	 * then it's very likely the result of an icebp/int01 trap.
+	 * User wants a sigtrap for that.
+	 */
+	if (dr6 & (DR_STEP | DR_TRAP_BITS) || !dr6)
+		send_sigtrap(regs, 0, get_si_code(dr6));
 
 out:
 	cond_local_irq_disable(regs);


