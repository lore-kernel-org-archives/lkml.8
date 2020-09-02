Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90963C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B62D208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bls6TKdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgIBPqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgIBNj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:39:29 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81479C061258
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RHraV7yw4injJqMysRln+KjYYQx+yGxYSsQMAf/RFbU=; b=bls6TKdYNjJUdWI4PpJl7tcjxh
        iIkAoXv73qjD3Lz52jBk2m5GzCWKofALKLIhAMTS5Zukrhj2yqukj9UM/v12Q9HNhp9f4X50Wmc1M
        8ojTHvPHiE9xsFZPGtFUfpV/DwfeHDZv4GYA6dCF9z4vCNgrqRjwqwei4PvawuJcWXzuwOCZETEgV
        fypdE0Es1ySZMdHN+0blhCHTIW5yEfwuH96cIN8Bs5LxcyreAbIhxI0yUKyyxSjaEn0pwkTnGvJvy
        LhfI0pLTIQkxcInK7OiAZxAOkWycTW4jxhVghHuQQZhsLjCORDN33hGy435whUZj4L6qihXEWDBow
        5so8bX3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDSxs-0002dp-80; Wed, 02 Sep 2020 13:38:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A96FA30769C;
        Wed,  2 Sep 2020 15:38:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D793F29A82C26; Wed,  2 Sep 2020 15:38:11 +0200 (CEST)
Message-ID: <20200902133201.170216274@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Sep 2020 15:25:58 +0200
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
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 09/13] x86/debug: Remove the historical junk
References: <20200902132549.496605622@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the historical junk and replace it with a WARN and a comment.

The problem is that even though the kernel only uses TF single-step in
kprobes and KGDB, both of which consume the event before this,
QEMU/KVM has bugs in this area that can trigger this state so we have
to deal with it.

Suggested-by: Brian Gerst <brgerst@gmail.com>
Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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


