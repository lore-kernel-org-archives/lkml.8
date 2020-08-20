Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D099C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232D0204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cFnqWEza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgHTSUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgHTSUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:20:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6250FC061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OVfpbpqmin8cx945Hs7aPE0xp2w2+ycijaPNAI8kbbc=; b=cFnqWEzaT/0b+Q0T6xU63XmHcS
        +uAxyPgkhspYnQ7rJ7LSRldlUNIkB1f8VjRVJRDuDgDr7SXIklQGUv1sRmqBrQiKJlfwz2n5BeWr8
        vITmZVHZbtxKFJ+TKS3N4VdSSlHp/WcxlLos/HsRfLtzS95B8Zw2w8qZy6vPfNMiD/7IBw6+G5G4G
        mtIowWmYzZ4X9kINU6WFHoF7jLjDFONIHMzxJ5guTGi2cTbCjJ4ceoZF8KWClMT7NZwWe3cIFrEeE
        CKQkriE6eLgVuLxL+5CFdp9llrRxKRJr+Md1aisAYZQ25WSPP0AmeSco0bGDajFnGPPTOV4DfVIor
        vh75ny6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8pAD-0002hD-Gd; Thu, 20 Aug 2020 18:19:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE4F2301179;
        Thu, 20 Aug 2020 20:19:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6EC42B410968; Thu, 20 Aug 2020 20:19:46 +0200 (CEST)
Date:   Thu, 20 Aug 2020 20:19:46 +0200
From:   peterz@infradead.org
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
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
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC][PATCH 4/7] x86/debug: Move historical SYSENTER junk into
 exc_debug_kernel()
Message-ID: <20200820181946.GF1362448@hirez.programming.kicks-ass.net>
References: <20200820163453.GE1362448@hirez.programming.kicks-ass.net>
 <156769F5-0BCC-4FB8-A56D-0E92601F558A@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <156769F5-0BCC-4FB8-A56D-0E92601F558A@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 09:43:15AM -0700, Andy Lutomirski wrote:
> I’ve lost track of how many bugs QEMU and KVM have in this space.
> Let’s keep it as a warning, but a bug. But let’s get rid of the
> totally bogus TIF_SINGLESTEP manipulation.

OK, I've shuffled the series around to fix that ordering problem in
patch 4 and added the below patch at the end.

Although I'm not entirely sure it actually leaks a #DB or just wrecks
the state.. *shrug*.

---
Subject: x86/debug: Remove the historical junk
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Aug 20 18:28:37 CEST 2020


Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -839,22 +839,18 @@ static __always_inline void exc_debug_ke
 		goto out;
 
 	/*
-	 * Reload dr6, the notifier might have changed it.
+	 * The kernel doesn't use TF single-step outside of:
+	 *
+	 *  - Kprobes, consumed through kprobe_debug_handler()
+	 *  - KGDB, consumed through notify_debug()
+	 *
+	 * So if we get here with DR_STEP set, something is wonky.
+	 *
+	 * A known way to trigger this is through QEMU's GDB stub,
+	 * which leaks #DB into the guest and causes IST recursion.
 	 */
-	dr6 = current->thread.debugreg6;
-
-	if (WARN_ON_ONCE(dr6 & DR_STEP)) {
-		/*
-		 * Historical junk that used to handle SYSENTER single-stepping.
-		 * This should be unreachable now.  If we survive for a while
-		 * without anyone hitting this warning, we'll turn this into
-		 * an oops.
-		 */
-		dr6 &= ~DR_STEP;
-		set_thread_flag(TIF_SINGLESTEP);
+	if (WARN_ON_ONCE(current->thread.debugreg6 & DR_STEP))
 		regs->flags &= ~X86_EFLAGS_TF;
-	}
-
 out:
 	instrumentation_end();
 	idtentry_exit_nmi(regs, irq_state);
