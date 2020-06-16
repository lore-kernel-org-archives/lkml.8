Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7546C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 910C520776
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pQdJ0hKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgFPLO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgFPLO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:14:28 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FC3C08C5C2;
        Tue, 16 Jun 2020 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=litWpZtRy6TJW48SmX5DD3trA2cJolHEZtNuMHmiMHI=; b=pQdJ0hKv+IpdKlEYu9sQxkjeLd
        rS62Xky4rcmlQsC+LnKaofCPkWl5J25SInfRA8nT9R3G0LqZY/hwwAwlKX7jTdFuYrmmmTBfvlAA9
        DWTSZRYAeORW2PaWF9s9VMT8rpHG7tIlZX7//YpwnfFidgsvfruGMcLgd7TaBUecpPDpDuL5fBR93
        bmLcpSMzQPPpmMS21DFVDV2uauYQpxyBZdE4z6X3+jxeDV9CdkyXtxqBIaA0SJX5AHUItBlI+0JMe
        fOC+boT+Z7DcNf2YeZh+/3hhDZZD+lHWSkpH5sKrFhl2AE5Dli4K1haSXkHv3DckIrblpXIjt/ac7
        SKsnpx5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jl9Xd-0008F4-U3; Tue, 16 Jun 2020 11:14:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 305D73010C8;
        Tue, 16 Jun 2020 13:14:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1686F2B9CA57C; Tue, 16 Jun 2020 13:14:08 +0200 (CEST)
Date:   Tue, 16 Jun 2020 13:14:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Subject: Re: [tip: x86/entry] x86/entry: Treat BUG/WARN as NMI-like entries
Message-ID: <20200616111408.GS2531@hirez.programming.kicks-ass.net>
References: <f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org>
 <159199140855.16989.18012912492179715507.tip-bot2@tip-bot2>
 <20200615145018.GU2531@hirez.programming.kicks-ass.net>
 <CALCETrWhbg_61CTo9_T6s1NDFvOgUx7ebSzhXj7O_m8htePwKA@mail.gmail.com>
 <20200615194458.GL2531@hirez.programming.kicks-ass.net>
 <CALCETrUbwwoYTzyntr=bUjJU44iyt+S8bRS04OxmByP3aD4A9g@mail.gmail.com>
 <20200615222330.GI2514@hirez.programming.kicks-ass.net>
 <CALCETrXisDDMb_eaPDq1DWrMuSqo1hDrOd14u7fSR4J_RxJu_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXisDDMb_eaPDq1DWrMuSqo1hDrOd14u7fSR4J_RxJu_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 03:46:00PM -0700, Andy Lutomirski wrote:

> In some sense, #UD and #PF are fundamentally different.  #PF wants to
> be able to schedule in the kernel.  #UD wants to be as minimal as
> possible in the kernel but probably still wants to do the nmi_enter()
> dance in case it's an RCU warning and the warning handler code wants
> to use RCU.
> 
> One solution would be to get rid of ud2 for warnings and replace it
> with CALL warning_thunk :)  But I guess I'm okay with your patch.

Well, the raisin we use UD2 is because it's only 2 bytes, which makes
for nice and compact code. Ideally we'd have a single byte #UD
instruction, but alas.

However, I realized that there's another analogy with #PF that does
transfer to #UD. For #PF we state that in-kernel #PF only happens when
RCU is already watching -- by virtue of us being careful in noinstr.

But similarly we can state we only have UD2 when we want to call
WARN/BUG and can forgo exception entry.

That would then result in something like this...

---
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index af75109485c2..8fe57b07a03b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -216,40 +216,35 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
 
-DEFINE_IDTENTRY_RAW(exc_invalid_op)
+static noinstr bool handle_bug(struct pt_regs *regs)
 {
-	bool rcu_exit;
+	bool handled = false;
 
 	/*
-	 * Handle BUG/WARN like NMIs instead of like normal idtentries:
-	 * if we bugged/warned in a bad RCU context, for example, the last
-	 * thing we want is to BUG/WARN again in the idtentry code, ad
-	 * infinitum.
+	 * All lies, just get the WARN/BUG out.
 	 */
-	if (!user_mode(regs) && is_valid_bugaddr(regs->ip)) {
-		enum bug_trap_type type;
+	instrumentation_begin();
+	if (is_valid_bugaddr(regs->ip) &&
+	    report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
+		regs->ip += LEN_UD2;
+		handled = true;
+	}
+	instrumentation_end();
 
-		nmi_enter();
-		instrumentation_begin();
-		trace_hardirqs_off_finish();
-		type = report_bug(regs->ip, regs);
-		if (regs->flags & X86_EFLAGS_IF)
-			trace_hardirqs_on_prepare();
-		instrumentation_end();
-		nmi_exit();
+	return handled;
+}
 
-		if (type == BUG_TRAP_TYPE_WARN) {
-			/* Skip the ud2. */
-			regs->ip += LEN_UD2;
-			return;
-		}
+DEFINE_IDTENTRY_RAW(exc_invalid_op)
+{
+	bool rcu_exit;
 
-		/*
-		 * Else, if this was a BUG and report_bug returns or if this
-		 * was just a normal #UD, we want to continue onward and
-		 * crash.
-		 */
-	}
+	/*
+	 * We use UD2 as a short encoding for 'CALL __WARN', as such
+	 * handle it before exception entry to avoid recursive WARN
+	 * in case exception entry is the one triggering WARNs.
+	 */
+	if (!user_mode(regs) && handle_bug(regs))
+		return;
 
 	rcu_exit = idtentry_enter_cond_rcu(regs);
 	instrumentation_begin();
