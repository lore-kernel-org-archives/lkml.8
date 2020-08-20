Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3498C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F56206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RjT7Y8jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbgHTKyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbgHTKxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:53:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F11C061388
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=XScWW+VDxJfM3kZOnRAy8sSy8A+dFKOXsHQbSKIdGYU=; b=RjT7Y8jm720oCr/g1lYdpD3QA1
        +/0XGKh0HCOt96nSsLowTfWV1cQs/R0mKeVp5ElIi7FvVX8u/crvSGFPzsxSr6il32k0kj+lHSe1R
        /1EUfixm/E/2v+/wPnQcEXXPrU1kF0ymcjUuI4iIdNbLriaZ78/ektkic96heEugPV5GPoUef7PkL
        ifudZiLuahGwtmyBqITvAPj7edZjIRXnK5IyTmnDqyUqM1oJn2zkgZNt0qVoWhqavjOyZIXwbefFn
        DOnyPExROWs9iFzMVEP9gHcZuvJtKPEngk/nA/wG3ZiXH7fbrE0DXfqfIwb4CE033O5hvCvB8eel2
        4Ime/BDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8iBU-0007Xr-Ux; Thu, 20 Aug 2020 10:52:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E0BA306099;
        Thu, 20 Aug 2020 12:52:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 492D32C38827E; Thu, 20 Aug 2020 12:52:36 +0200 (CEST)
Message-ID: <20200820104905.294802764@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Aug 2020 12:38:36 +0200
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
Subject: [RFC][PATCH 4/7] x86/debug: Move historical SYSENTER junk into exc_debug_kernel()
References: <20200820103832.486877479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -820,18 +820,6 @@ static void handle_debug(struct pt_regs
 		goto out;
 	}
 
-	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
-		/*
-		 * Historical junk that used to handle SYSENTER single-stepping.
-		 * This should be unreachable now.  If we survive for a while
-		 * without anyone hitting this warning, we'll turn this into
-		 * an oops.
-		 */
-		tsk->thread.debugreg6 &= ~DR_STEP;
-		set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
-		regs->flags &= ~X86_EFLAGS_TF;
-	}
-
 	si_code = get_si_code(tsk->thread.debugreg6);
 	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
 		send_sigtrap(regs, 0, si_code);
@@ -874,6 +862,18 @@ static __always_inline void exc_debug_ke
 	if (kprobe_debug_handler(regs))
 		goto out;
 
+	if (WARN_ON_ONCE(dr6 & DR_STEP)) {
+		/*
+		 * Historical junk that used to handle SYSENTER single-stepping.
+		 * This should be unreachable now.  If we survive for a while
+		 * without anyone hitting this warning, we'll turn this into
+		 * an oops.
+		 */
+		dr6 &= ~DR_STEP;
+		set_thread_flag(TIF_SINGLESTEP);
+		regs->flags &= ~X86_EFLAGS_TF;
+	}
+
 	handle_debug(regs, dr6, false);
 
 out:


