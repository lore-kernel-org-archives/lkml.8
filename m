Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F598C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1B320724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PBcHfDXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbgHTKyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731724AbgHTKxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:53:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F23BC061387
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TeO9rz3sjn3E0TMFhE7YmYChuS9nQysvnB1/WdjxhaY=; b=PBcHfDXy4ucnMsPNQgBr3I75z4
        0FKlVCqbohuQ2kTGNe8tLI0GVMLTzvw64lc6tq938O1sbVMz6pzP8BKs4bVUm8wCSGpzPJoDiEyd8
        rAabX2fGl6+2tua5W56BmFVawBBd6lBwLJkjLLKUQAIzYOxx2cN1syowpDLYUGj9uEdHTGadCssb7
        PDt3Oo6AkB4/O0mpETkgeBMjgtEdEDPwBy6ja1SrOb1iZqC7SUfI7kQ/9iTDa5/UCbeh/18gSdALn
        rcjjzOd7fdSiOkCLQOk+P4FN1fqcuLbw24lQA8jkA8zWX/6+qrl5f6Tv6JGzikWLp9XqJ4QyUMuzs
        e40NJEPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8iBU-0007Xx-VB; Thu, 20 Aug 2020 10:52:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D62A3306E56;
        Thu, 20 Aug 2020 12:52:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 521EE2C38827F; Thu, 20 Aug 2020 12:52:36 +0200 (CEST)
Message-ID: <20200820104905.470593910@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Aug 2020 12:38:39 +0200
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
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 7/7] x86/debug: Move cond_local_irq_enable() block into exc_debug_user()
References: <20200820103832.486877479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   65 +++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -783,41 +783,15 @@ static __always_inline unsigned long deb
  *
  * May run on IST stack.
  */
-static void handle_debug(struct pt_regs *regs, unsigned long dr6)
+static bool notify_debug(struct pt_regs *regs, unsigned long dr6)
 {
-	struct task_struct *tsk = current;
-
 	/* Store the virtualized DR6 value */
-	tsk->thread.debugreg6 = dr6;
-
-	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
-		       SIGTRAP) == NOTIFY_STOP) {
-		return;
-	}
-
-	/* It's safe to allow irq's after DR6 has been saved */
-	cond_local_irq_enable(regs);
+	current->thread.debugreg6 = dr6;
 
-	if (v8086_mode(regs)) {
-		handle_vm86_trap((struct kernel_vm86_regs *) regs, 0,
-				 X86_TRAP_DB);
-		goto out;
-	}
-
-	/*
-	 * Reload dr6, the notifier might have changed it.
-	 */
-	dr6 = tsk->thread.debugreg6;
-	/*
-	 * If dr6 has no reason to give us about the origin of this trap,
-	 * then it's very likely the result of an icebp/int01 trap.
-	 * User wants a sigtrap for that.
-	 */
-	if (dr6 & (DR_STEP | DR_TRAP_BITS) || !dr6)
-		send_sigtrap(regs, 0, get_si_code(dr6));
+	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0, SIGTRAP) == NOTIFY_STOP)
+		return true;
 
-out:
-	cond_local_irq_disable(regs);
+	return false;
 }
 
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
@@ -872,7 +846,7 @@ static __always_inline void exc_debug_ke
 	if (!dr6)
 		goto out;
 
-	handle_debug(regs, dr6);
+	notify_debug(regs, dr6);
 
 out:
 	instrumentation_end();
@@ -902,8 +876,33 @@ static __always_inline void exc_debug_us
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
-	handle_debug(regs, dr6);
+	if (notify_debug(regs, dr6))
+		goto out;
+
+	/*
+	 * Reload dr6, the notifier might have changed it.
+	 */
+	dr6 = current->thread.debugreg6;
+
+	/* It's safe to allow irq's after DR6 has been saved */
+	local_irq_enable();
+
+	if (v8086_mode(regs)) {
+		handle_vm86_trap((struct kernel_vm86_regs *)regs, 0, X86_TRAP_DB);
+		goto out_irq;
+	}
 
+	/*
+	 * If dr6 has no reason to give us about the origin of this trap,
+	 * then it's very likely the result of an icebp/int01 trap.
+	 * User wants a sigtrap for that.
+	 */
+	if (dr6 & (DR_STEP | DR_TRAP_BITS) || !dr6)
+		send_sigtrap(regs, 0, get_si_code(dr6));
+
+out_irq:
+	local_irq_disable();
+out:
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);
 }


