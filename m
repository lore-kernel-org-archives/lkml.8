Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE97C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2097A20724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1AbODuKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbgHTKx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbgHTKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:52:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39676C061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=DGXmVVpu4dSTuj4cl+n/LvOmKxL4QVfYORTxIGFYnh4=; b=1AbODuKVG8a4WZDMMdncUeL6rp
        ZRpjuSFBOmoe8uqffpmDptpX9kvk2KbSXTLnqQCQxDWxPC3/AHb2kJaAQWb0XDChDiKbvxKJ4AOqc
        J6jjObeLgpIy77Vtmfmdcxsu/xGQbxu93w2XAabdyXbEICljAmZcCo4FebuhsdmTl04lgZo+GQc85
        58HSZTHnLYdZNl4GLkwQy+3UeHQh/7ZWTqMO1COcVarMB1h8XJQzsiAuzLWGZzYpbJtkCNNHKoPeG
        Ho/bVQsFTj+DfkBoJb+CMJOnyPS69AZC8DIFeQhYeKlOQAbbSjIe2xxag2cS7gV2Lp5cpmLi6p09T
        QxPmhgeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8iBT-0008Ga-UB; Thu, 20 Aug 2020 10:52:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D34A73060F3;
        Thu, 20 Aug 2020 12:52:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 502342C388280; Thu, 20 Aug 2020 12:52:36 +0200 (CEST)
Message-ID: <20200820104905.411406337@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Aug 2020 12:38:38 +0200
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
Subject: [RFC][PATCH 6/7] x86/debug: Simplify #DB signal code
References: <20200820103832.486877479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

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
@@ -813,9 +804,17 @@ static void handle_debug(struct pt_regs
 		goto out;
 	}
 
-	si_code = get_si_code(tsk->thread.debugreg6);
-	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
-		send_sigtrap(regs, 0, si_code);
+	/*
+	 * Reload dr6, the notifier might have changed it.
+	 */
+	dr6 = tsk->thread.debugreg6;
+	/*
+	 * If dr6 has no reason to give us about the origin of this trap,
+	 * then it's very likely the result of an icebp/int01 trap.
+	 * User wants a sigtrap for that.
+	 */
+	if (dr6 & (DR_STEP | DR_TRAP_BITS) || !dr6)
+		send_sigtrap(regs, 0, get_si_code(dr6));
 
 out:
 	cond_local_irq_disable(regs);


