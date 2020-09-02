Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0BFC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A18208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zke8VF7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgIBPqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgIBNj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:39:29 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F2C06125F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/Oowka1+4HYHH/M2f74f3FfCfCIjB94/ju74cCoLjd0=; b=Zke8VF7uLsaMj/PYECiOBSSFvx
        H2sjuKM4vy4ESU9+EBXJmoBD3INTmxkO22LgyRbJy3XGaGiDc1c7NJ5Nf1uYo09Aufh7zIxfWZWEV
        3gW3xO6vmhkvQ+CL65ZwbEWsrrZTi7CH+qnRotbRdH8VTd7ZDf1w8w3IAPm+xdI/ZDTbm93OrO1aR
        JtoVSMaYM9RrOaFJDe7p71yQYsB8NN+ZAkHQe5HFla6vPjXbK9uz1ZeWsRy4gXHXyiCyprdbyk+UB
        GN6evDmF/s1hssbSrL8CklkQusl9WZcyh0BwihIxbafiyU9gu5KkGLa3t6cJsAk8DT2AWmFjNtBf0
        do3L5JTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDSxs-0002dn-7k; Wed, 02 Sep 2020 13:38:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7256307697;
        Wed,  2 Sep 2020 15:38:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E2A4E29A82C29; Wed,  2 Sep 2020 15:38:11 +0200 (CEST)
Message-ID: <20200902133201.354220797@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Sep 2020 15:26:01 +0200
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
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [RFC][PATCH 12/13] x86/debug: Support negative polarity DR6 bits
References: <20200902132549.496605622@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DR6 has a whole bunch of bits that have negative polarity; they were
architecturally reserved and defined to be 1 and are now getting used.
Since they're 1 by default, 0 becomes the signal value.

Handle this by xor'ing the read DR6 value by the reserved mask, this
will flip them around such that 1 is the signal value (positive
polarity).

Current Linux doesn't yet support any of these bits, but there's two
defined:

 - DR6[11] Bus Lock Debug Exception		(ISEr39)
 - DR6[16] Restricted Transactional Memory	(SDM)

Update ptrace_{set,get}_debugreg() to provide/consume the value in
architectural polarity. Although afaict ptrace_set_debugreg(6) is
pointless, the value is not consumed anywhere.

Change hw_breakpoint_restore() to alway write the DR6_RESERVED value
to DR6, again, no consumer for that write.

Suggested-by: Andrew Cooper <Andrew.Cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/hw_breakpoint.c |    2 +-
 arch/x86/kernel/ptrace.c        |    4 ++--
 arch/x86/kernel/traps.c         |    5 ++---
 3 files changed, 5 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -500,7 +500,7 @@ void hw_breakpoint_restore(void)
 	set_debugreg(__this_cpu_read(cpu_debugreg[1]), 1);
 	set_debugreg(__this_cpu_read(cpu_debugreg[2]), 2);
 	set_debugreg(__this_cpu_read(cpu_debugreg[3]), 3);
-	set_debugreg(current->thread.debugreg6, 6);
+	set_debugreg(DR6_RESERVED, 6);
 	set_debugreg(__this_cpu_read(cpu_dr7), 7);
 }
 EXPORT_SYMBOL_GPL(hw_breakpoint_restore);
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -601,7 +601,7 @@ static unsigned long ptrace_get_debugreg
 		if (bp)
 			val = bp->hw.info.address;
 	} else if (n == 6) {
-		val = thread->debugreg6;
+		val = thread->debugreg6 ^ DR6_RESERVED; /* Flip back to arch polarity */
 	} else if (n == 7) {
 		val = thread->ptrace_dr7;
 	}
@@ -657,7 +657,7 @@ static int ptrace_set_debugreg(struct ta
 	if (n < HBP_NUM) {
 		rc = ptrace_set_breakpoint_addr(tsk, n, val);
 	} else if (n == 6) {
-		thread->debugreg6 = val;
+		thread->debugreg6 = val ^ DR6_RESERVED; /* Flip to positive polarity */
 		rc = 0;
 	} else if (n == 7) {
 		rc = ptrace_write_dr7(tsk, val);
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -745,9 +745,8 @@ static __always_inline unsigned long deb
 	 * Keep it simple: clear DR6 immediately.
 	 */
 	get_debugreg(dr6, 6);
-	set_debugreg(0, 6);
-	/* Filter out all the reserved bits which are preset to 1 */
-	dr6 &= ~DR6_RESERVED;
+	set_debugreg(DR6_RESERVED, 6);
+	dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
 
 	/*
 	 * The SDM says "The processor clears the BTF flag when it


