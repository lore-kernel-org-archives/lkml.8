Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602B8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015762078C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590021640;
	bh=bkp5EojXuJdRFg/NUpaj7S7uzkKntoSInnR8U3HN/1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LdRDx//oZA1+VRMkVpUyqWXhngylNSMulXjz92cfjwWmhCcwzmQrF/pN4p6iphTC6
	 kGDxSRNAxY2yc0DmbRGFRVTKz33n4egxtOIuYS0BfpiW5cjCYzBw77OSe8apOtu/VK
	 oOtIPKGNyN3Qc2seSqyfYYhBnSbBxJiDo0gwBlW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgEUAkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgEUAki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:40:38 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D58C20756;
        Thu, 21 May 2020 00:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590021638;
        bh=bkp5EojXuJdRFg/NUpaj7S7uzkKntoSInnR8U3HN/1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZzSQm07Earmg9k84H+0M7AKm1RWBEh2THpEzki+xqIevfjuKMw7BLGjy9vkIM6L3g
         vg/eLkxzZ/4rmYAZK1T4/q88BdbFepb0OdiXhAOmP35tajLFhTeBIQ4CkbuZ76ZZBK
         5iX1DKP2/WID6qyIQvZRaZTC5kcg0Ck+oRwhUOP0=
Date:   Thu, 21 May 2020 02:40:36 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: Endless soft-lockups for compiling workload since next-20200519
Message-ID: <20200521004035.GA15455@lenoir>
References: <CAG=TAF6jUsQrW-fjbS3vpjkMfn8=MUDsuQxjk3NMfvQa250RHA@mail.gmail.com>
 <20200520125056.GC325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200520125056.GC325280@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 02:50:56PM +0200, Peter Zijlstra wrote:
> On Tue, May 19, 2020 at 11:58:17PM -0400, Qian Cai wrote:
> > Just a head up. Repeatedly compiling kernels for a while would trigger
> > endless soft-lockups since next-20200519 on both x86_64 and powerpc.
> > .config are in,
> 
> Could be 90b5363acd47 ("sched: Clean up scheduler_ipi()"), although I've
> not seen anything like that myself. Let me go have a look.
> 
> 
> In as far as the logs are readable (they're a wrapped mess, please don't
> do that!), they contain very little useful, as is typical with IPIs :/
> 
> > [ 1167.993773][    C1] WARNING: CPU: 1 PID: 0 at kernel/smp.c:127
> > flush_smp_call_function_queue+0x1fa/0x2e0

So I've tried to think of a race that could produce that and here is
the only thing I could come up with. It's a bit complicated unfortunately:

CPU 0                                              CPU 1
-----                                              -----

tick {
    trigger_load_balance() {
        raise_softirq(SCHED_SOFTIRQ);
        //but nohz_flags(0) = 0
    }
                                                   kick_ilb() {
                                                       atomic_fetch_or(...., nohz_flags(0))
    softirq() {                                        #VMEXIT or anything that could stop a CPU for a while
        run_rebalance_domain() {
            nohz_idle_balance() {
                atomic_andnot(NOHZ_KICK_MASK, nohz_flag(0))
            }
         }
     }
}

// schedule
nohz_newidle_balance() {
    kick_ilb() { // pick current CPU
        atomic_fetch_or(...., nohz_flags(0))           #VMENTER
        smp_call_function_single_async() {             smp_call_function_single_async() {
            // verified csd->flags != CSD_LOCK             // verified csd->flags != CSD_LOCK
            csd->flags = CSD_LOCK                          csd->flags = CSD_LOCK
            //execute in place                             //queue and send IPI
            csd->flags = 0
            nohz_csd_func()
	}
    }
}


IPI�{
    flush_smp_call_function_queue() {
        csd_unlock() {
            WARN_ON(csd->flags != CSD_LOCK) <---------!!!!!



The root cause here would be that trigger_load_balance() unconditionally raise
the softirq. And I have to confess I'm not clear why since the softirq is
essentially a no-op when nohz_flags() is 0.

Thanks.
