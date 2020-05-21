Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224A82072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vO1OR1Wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgEUJqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:46:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33344 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgEUJqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xJUdphGKJUKhgIinM68b1mk7CPkaxjn/+2MCaXBPBbo=; b=vO1OR1Wx3Y/LoO/HBRgWVYPKre
        q/E1M1NpSEbEtommc2Mx6MmlmHCA16wIVYHDbvaAuh4CQRAgpN/cg24jW24K5JO6+617hM/Vv5rDL
        zXVGGVfE/cwuDi62N7QmR6RX77WO7WWwPFj/J88v4bnkSjCQEQW7B298gS5UaPryHGi/5zb86JIxL
        8sQqbm1seCMcsuuJryZ1Q+uVe1LU173S6EsQjD9Ob4p1MwGazTXWc8Kqh19w5G+0YYzZs+eTd4+QA
        v4V+82u6b/tGc9+NobIIB8e2yxAE4kSspu66W7q3I1HsvBDn3m37ygYkTUyY4iAADYpG2BSyCljUi
        zpQrpG7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbhg7-0001BI-Vw; Thu, 21 May 2020 09:39:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D0A73011C6;
        Thu, 21 May 2020 11:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09B1A25BAC8BA; Thu, 21 May 2020 11:39:38 +0200 (CEST)
Date:   Thu, 21 May 2020 11:39:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: Endless soft-lockups for compiling workload since next-20200519
Message-ID: <20200521093938.GG325280@hirez.programming.kicks-ass.net>
References: <CAG=TAF6jUsQrW-fjbS3vpjkMfn8=MUDsuQxjk3NMfvQa250RHA@mail.gmail.com>
 <20200520125056.GC325280@hirez.programming.kicks-ass.net>
 <20200521004035.GA15455@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521004035.GA15455@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 02:40:36AM +0200, Frederic Weisbecker wrote:
> On Wed, May 20, 2020 at 02:50:56PM +0200, Peter Zijlstra wrote:
> > On Tue, May 19, 2020 at 11:58:17PM -0400, Qian Cai wrote:
> > > Just a head up. Repeatedly compiling kernels for a while would trigger
> > > endless soft-lockups since next-20200519 on both x86_64 and powerpc.
> > > .config are in,
> > 
> > Could be 90b5363acd47 ("sched: Clean up scheduler_ipi()"), although I've
> > not seen anything like that myself. Let me go have a look.
> > 
> > 
> > In as far as the logs are readable (they're a wrapped mess, please don't
> > do that!), they contain very little useful, as is typical with IPIs :/
> > 
> > > [ 1167.993773][    C1] WARNING: CPU: 1 PID: 0 at kernel/smp.c:127
> > > flush_smp_call_function_queue+0x1fa/0x2e0
> 
> So I've tried to think of a race that could produce that and here is
> the only thing I could come up with. It's a bit complicated unfortunately:

This:

>         smp_call_function_single_async() {             smp_call_function_single_async() {
>             // verified csd->flags != CSD_LOCK             // verified csd->flags != CSD_LOCK
>             csd->flags = CSD_LOCK                          csd->flags = CSD_LOCK

concurrent smp_call_function_single_async() using the same csd is what
I'm looking at as well. Now in the ILB case there is an easy cure:

(because there is only a single ilb target)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 01f94cf52783..b6d8a7b991f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10033,7 +10033,7 @@ static void kick_ilb(unsigned int flags)
 	 * is idle. And the softirq performing nohz idle load balance
 	 * will be run before returning from the IPI.
 	 */
-	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);
+	smp_call_function_single_async(ilb_cpu, &this_rq()->nohz_csd);
 }
 
 /*

Qian, can you give that a spin?

But I'm still not convinced of your scenario:

>                                                    kick_ilb() {
>                                                        atomic_fetch_or(...., nohz_flags(0))

>         atomic_fetch_or(...., nohz_flags(0))           #VMENTER
>         smp_call_function_single_async() {             smp_call_function_single_async() {
>             // verified csd->flags != CSD_LOCK             // verified csd->flags != CSD_LOCK
>             csd->flags = CSD_LOCK                          csd->flags = CSD_LOCK

Note that we check the return value of atomic_fetch_or() and bail if
someone else set a flag in KICK_MASK before us.

Aah, I suppose you're saying this can happen when:

  !(flags & NOHZ_KICK_MASK)

? That's not supposed to happen though.


Anyway, let me go stare at the remove wake-up case, because i'm afraid
that might have the same problem too...
