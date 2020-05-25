Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40A4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A322F2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EerNxe3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390985AbgEYOjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390944AbgEYOjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:39:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF51C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sDmy5Xm2F2pY2KhwGXNcV6+J3j89es51xHtTpy+cA+A=; b=EerNxe3smaAc3YWerSP2Lw+Npr
        tFZ8sQaFtxsOb746sxudWvYOKBpBmZArB9MeYtZyCdI7JxOYogp1YFwif7kF+W6eubgzeaPlDYfZ7
        mpuchARpKoY0U/x7lncesvfyIRe7TxxaR1mgsoLlp459I9SptO5dMVSiVZzaQU8PZPvFyrxvNBnJ+
        5/SJQNk2nO9Br7ajHJO+rCGLWC91fkjWpFEvebYohEYV5jIB3UQ082WzxdEDn4F0k/3uD4Fuk9+lP
        k7gAu3DiVqtBhknvniOaWGeNCpeTG/dkMyTQZfvl0dngm0Oqy7wVgO+CiGsSPJTZRqXHbXDRCPRP7
        Q11KbcNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdEFq-000050-T9; Mon, 25 May 2020 14:39:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0E6B300B38;
        Mon, 25 May 2020 16:38:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D689D2389FE1F; Mon, 25 May 2020 16:38:59 +0200 (CEST)
Date:   Mon, 25 May 2020 16:38:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: Endless soft-lockups for compiling workload since next-20200519
Message-ID: <20200525143859.GX325280@hirez.programming.kicks-ass.net>
References: <CAG=TAF6jUsQrW-fjbS3vpjkMfn8=MUDsuQxjk3NMfvQa250RHA@mail.gmail.com>
 <20200520125056.GC325280@hirez.programming.kicks-ass.net>
 <20200521004035.GA15455@lenoir>
 <20200521093938.GG325280@hirez.programming.kicks-ass.net>
 <20200521104937.GB325303@hirez.programming.kicks-ass.net>
 <20200521110027.GC325303@hirez.programming.kicks-ass.net>
 <20200521124113.GC15455@lenoir>
 <20200525132105.GW325280@hirez.programming.kicks-ass.net>
 <20200525140541.GA28923@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525140541.GA28923@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 04:05:49PM +0200, Frederic Weisbecker wrote:
> On Mon, May 25, 2020 at 03:21:05PM +0200, Peter Zijlstra wrote:
> > @@ -2320,7 +2304,7 @@ static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
> >  
> >  	if (llist_add(&p->wake_entry, &rq->wake_list)) {
> >  		if (!set_nr_if_polling(rq->idle))
> > -			smp_call_function_single_async(cpu, &rq->wake_csd);
> > +			smp_call_function_single_async(cpu, &p->wake_csd);
> >  		else
> >  			trace_sched_wake_idle_without_ipi(cpu);
> 
> Ok that's of course very unlikely but could it be possible to have the
> following:
> 
> CPU 0                         CPU 1                                     CPU 2
> -----       
> 
> //Wake up A
> ttwu_queue(TASK A, CPU 1)     idle_loop {
>                                   ttwu_queue_pending {
>                                       ....
>                                       raw_spin_unlock_irqrestore(rq)
>                                       # VMEXIT (with IPI still pending)
>                                                                         //task A migrates here
>                                                                         wait_event(....)
>                                                                         //sleep
> 
> //Wake up A
> ttwu_queue(TASK A, CPU 2) {
>     //IPI on CPU 2 ignored
>     // due to csd->flags == CSD_LOCK
> 

Right you are.

Bah!

More thinking....
