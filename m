Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96003C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A15A2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AKceh5o6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgEWNCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 09:02:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54174 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbgEWNCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i+W32p7Xn+loQfbQxblgigVhjgb2f2mo+rxQQ2WzG34=; b=AKceh5o6OodesP30RZroLDIYPC
        7PLxJoMMc4SZOFO5rwEM7MtkO1ousap93Qimv2T3EHonJEkuBkyq6hjgyixdHqEcGKlFCScddYuMP
        i4AP7dtvSiQPtuy3SLuF3jf9+q2MCVaqNclWf+JbXzLdq6ZvVHAkhZyMBj4zZ2qeqTLMxSENnjoDl
        mvVSMJ0r+nLZCWaQZLfqw2ZkMnuaXPXlPbdilgOxsIOlklCbhgB5STpwdhgAE1BIDwibSo62Z4M6D
        uuLdh8eGRh6SH8xcFZ9gIq2vRRvP/K4G7MQX8myA77cXHtR94l+pZ3ansJVr44RCElrwHo0898Lj0
        7WfMcDoQ==;
Received: from [24.132.217.100] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcTkq-000089-VT; Sat, 23 May 2020 12:59:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBDEA9834A3; Sat, 23 May 2020 14:59:40 +0200 (CEST)
Date:   Sat, 23 May 2020 14:59:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: [RFC][PATCH 0/4] x86/entry: disallow #DB more
Message-ID: <20200523125940.GA2483@worktop.programming.kicks-ass.net>
References: <20200522204738.645043059@infradead.org>
 <CALCETrV7GYg5V5dgM9BToc6RAqpcjRdoZoeXbnrTKTqjBfft6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV7GYg5V5dgM9BToc6RAqpcjRdoZoeXbnrTKTqjBfft6g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 03:13:57PM -0700, Andy Lutomirski wrote:
> On Fri, May 22, 2020 at 1:49 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Hai, this kills #DB during NMI/#MC and with that allows removing all the nasty
> > IST rewrite crud.
> >
> 
> This is great, except that the unconditional DR7 write is going to
> seriously hurt perf performance.  Fortunately, no one cares about
> perf, right? :)

Good point, so the trivial optimization is below. I couldn't find
instruction latency numbers for DRn load/stores anywhere. I'm hoping
loads are cheap.

> Even just reading first won't help enough because DR7
> reads are likely to be VM exits.

WTF, why is virt always such a horrible piece of crap?

> Can we have a percpu dr7 shadow
> (with careful ordering) or even just a percpu count of dr7 users so we
> can skip this if there are no breakpoints?  We have cpu_dr7, and some
> minor changes would make this work.  Maybe replace all the direct
> cpu_dr7 access with helpers like dr7_set_bits() and dr7_clear_bits()?

I'll try and sort through that on Monday or so.


---
 arch/x86/include/asm/debugreg.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -97,7 +97,8 @@ extern void hw_breakpoint_restore(void);
 static __always_inline void local_db_save(unsigned long *dr7)
 {
 	get_debugreg(*dr7, 7);
-	set_debugreg(0, 7);
+	if (*dr7)
+		set_debugreg(0, 7);
 	/*
 	 * Ensure the compiler doesn't lower the above statements into
 	 * the critical section; disabling breakpoints late would not
@@ -114,7 +115,8 @@ static __always_inline void local_db_res
 	 * not be good.
 	 */
 	barrier();
-	set_debugreg(dr7, 7);
+	if (dr7)
+		set_debugreg(dr7, 7);
 }
 
 #ifdef CONFIG_CPU_SUP_AMD

