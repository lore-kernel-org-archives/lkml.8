Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B065AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF5120724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KbhEyM7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgHUMXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgHUMXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:23:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB68C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ks1dLryMTdp10CYeuUZ09xabzASbenEUFeha4TPmjBE=; b=KbhEyM7reQS0fla0at9VpGw66F
        N8ANv3ONUBW1XuJMa4cAWjRC/NtQga/guibtXR3PBTun80Ly4a1v+W73j36ZDKP9kpTHx6kC8Q43N
        bTOirOV0XIDNa4+JsVk68pd94uql9mJC5WOpbEya/5y2hj+GZnk1v1Cl7oDXs9ZtbZW5XczsQHROp
        n9taky1hOBh3NrDYPtZCJjsHknQdIhS/K7Tz+feUve5gmUckjBOUk4HryfwSEtmz5coLObDQeaUsz
        tfgbTGk6FLAKmuy4rxhpiNnKVYj06EDthBYscXY/PxOb1bcc6vPx6uH9rKgxeteycGZWs5J5ST7P4
        TiBjlx7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k964I-000172-M2; Fri, 21 Aug 2020 12:22:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4C15301324;
        Fri, 21 Aug 2020 14:22:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F1432B41094A; Fri, 21 Aug 2020 14:22:49 +0200 (CEST)
Date:   Fri, 21 Aug 2020 14:22:49 +0200
From:   peterz@infradead.org
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
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2.1 8/8] x86/debug: Remove the historical junk
Message-ID: <20200821122249.GM1362448@hirez.programming.kicks-ass.net>
References: <20200821093912.815135402@infradead.org>
 <20200821102053.219655533@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821102053.219655533@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:39:20AM +0200, Peter Zijlstra wrote:
> Remove the historical junk and replace it with a WARN and a comment.
> 
> The problem is that even though the kernel only uses TF single-step in
> kprobes and KGDB, both of which consume the event before this,
> QEMU/KVM has bugs in this area that can trigger this state so we have
> to deal with it.
> 
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Damn, I lost a refresh.

---
 arch/x86/kernel/traps.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -843,18 +843,19 @@ static __always_inline void exc_debug_ke
 	if (notify_debug(regs, &dr6))
 		goto out;
 
-	if (WARN_ON_ONCE(dr6 & DR_STEP)) {
-		/*
-		 * Historical junk that used to handle SYSENTER single-stepping.
-		 * This should be unreachable now.  If we survive for a while
-		 * without anyone hitting this warning, we'll turn this into
-		 * an oops.
-		 */
-		dr6 &= ~DR_STEP;
-		set_thread_flag(TIF_SINGLESTEP);
+	/*
+	 * The kernel doesn't use TF single-step outside of:
+	 *
+	 *  - Kprobes, consumed through kprobe_debug_handler()
+	 *  - KGDB, consumed through notify_debug()
+	 *
+	 * So if we get here with DR_STEP set, something is wonky.
+	 *
+	 * A known way to trigger this is through QEMU's GDB stub,
+	 * which leaks #DB into the guest and causes IST recursion.
+	 */
+	if (WARN_ON_ONCE(current->thread.debugreg6 & DR_STEP))
 		regs->flags &= ~X86_EFLAGS_TF;
-	}
-
 out:
 	instrumentation_end();
 	idtentry_exit_nmi(regs, irq_state);
