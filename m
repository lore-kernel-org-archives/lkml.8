Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAF6C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8516620767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yq8ypmQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIBN5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgIBNrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:47:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55B0C061231
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=EcmrYn8UUGHatKnaEDoMkHu3/lKszlxT4uMyJqLhMPQ=; b=Yq8ypmQDHZi77WccdOrKccu1y9
        JWRROxfH/Hd+mYDAW+kkUcq92WU7taZQhEe270tHtrJkEqCCFt1oHnIQB9c8wiIjtm1YlAtwaA4SI
        +RxmtIXyI1S2DWgc15uXggFrcETuXAEidrBRaweAw2LeF6eNJAT481FO05CU7lRXQtxFpysmFUWcF
        EGXHZ/bKwMVGBQKWLl+fv6tiGejn6qGbK17OPNa4fNEdocnvBmQbPu2RNImnhQfRy2s4okmKZzrJW
        eRoUBF7RWOTcj4ft6wCuT0edUNUD6c8XkiZVe8PwFZ586XHKNJGN2bJU3369+4ZaYxA80Rfh31prq
        VYVOrZiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDSxs-0002dh-2u; Wed, 02 Sep 2020 13:38:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A553B307691;
        Wed,  2 Sep 2020 15:38:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DD6A629A82C27; Wed,  2 Sep 2020 15:38:11 +0200 (CEST)
Message-ID: <20200902133201.292906672@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Sep 2020 15:26:00 +0200
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
Subject: [PATCH 11/13] x86/debug: Simplify hw_breakpoint_handler()
References: <20200902132549.496605622@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is called with interrupts disabled, there's no point in using
get_cpu() and per_cpu().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/hw_breakpoint.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -487,7 +487,7 @@ EXPORT_SYMBOL_GPL(hw_breakpoint_restore)
  */
 static int hw_breakpoint_handler(struct die_args *args)
 {
-	int i, cpu, rc = NOTIFY_STOP;
+	int i, rc = NOTIFY_STOP;
 	struct perf_event *bp;
 	unsigned long dr6;
 	unsigned long *dr6_p;
@@ -505,12 +505,10 @@ static int hw_breakpoint_handler(struct
 		return NOTIFY_DONE;
 
 	/*
-	 * Assert that local interrupts are disabled
 	 * Reset the DRn bits in the virtualized register value.
 	 * The ptrace trigger routine will add in whatever is needed.
 	 */
 	current->thread.debugreg6 &= ~DR_TRAP_BITS;
-	cpu = get_cpu();
 
 	/* Handle all the breakpoints that were triggered */
 	for (i = 0; i < HBP_NUM; ++i) {
@@ -525,7 +523,7 @@ static int hw_breakpoint_handler(struct
 		 */
 		rcu_read_lock();
 
-		bp = per_cpu(bp_per_reg[i], cpu);
+		bp = this_cpu_read(bp_per_reg[i]);
 		/*
 		 * Reset the 'i'th TRAP bit in dr6 to denote completion of
 		 * exception handling
@@ -560,8 +558,6 @@ static int hw_breakpoint_handler(struct
 	    (dr6 & (~DR_TRAP_BITS)))
 		rc = NOTIFY_DONE;
 
-	put_cpu();
-
 	return rc;
 }
 


