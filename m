Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E26FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD23B207C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590415553;
	bh=4VZk7RGn/PZBtXmEcizHf6YuFu228DNJ0CvSOZvd4BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zhH6Hr3E7MR1QFnoMX9ND0XRiqZSqGzR0zU+gPNi8c9wVmwZ3vLbzIAIw8TQGX93E
	 QLlwHF+HMZ3z8lxQHH82fZW5/gdGOD0VLRniEEKx2DNiRm4Wpwe7HlRpJHdWqELxjt
	 ypDCywaA0ABObmG21USb+Hzv2W1oHBKi2DbRgrAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390847AbgEYOFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388862AbgEYOFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:05:52 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC9EA2078B;
        Mon, 25 May 2020 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590415552;
        bh=4VZk7RGn/PZBtXmEcizHf6YuFu228DNJ0CvSOZvd4BE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djIhABcz5/fRiDGNcdUszfyq0up8K+3x3CkQ/nelt1OocgB6msuJwEizqeMiNWURe
         hxbFIRagK4FJ90O4P8/mnGAm5naoZrRqw0YMNh7o4fvMR8aVumSLb+wDTQ8PaYKcn9
         qAn7oLs40TIYavPqgVIiInlrv+PaZpuGPHjV7n34=
Date:   Mon, 25 May 2020 16:05:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: Endless soft-lockups for compiling workload since next-20200519
Message-ID: <20200525140541.GA28923@lenoir>
References: <CAG=TAF6jUsQrW-fjbS3vpjkMfn8=MUDsuQxjk3NMfvQa250RHA@mail.gmail.com>
 <20200520125056.GC325280@hirez.programming.kicks-ass.net>
 <20200521004035.GA15455@lenoir>
 <20200521093938.GG325280@hirez.programming.kicks-ass.net>
 <20200521104937.GB325303@hirez.programming.kicks-ass.net>
 <20200521110027.GC325303@hirez.programming.kicks-ass.net>
 <20200521124113.GC15455@lenoir>
 <20200525132105.GW325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525132105.GW325280@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 03:21:05PM +0200, Peter Zijlstra wrote:
> @@ -2320,7 +2304,7 @@ static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
>  
>  	if (llist_add(&p->wake_entry, &rq->wake_list)) {
>  		if (!set_nr_if_polling(rq->idle))
> -			smp_call_function_single_async(cpu, &rq->wake_csd);
> +			smp_call_function_single_async(cpu, &p->wake_csd);
>  		else
>  			trace_sched_wake_idle_without_ipi(cpu);

Ok that's of course very unlikely but could it be possible to have the
following:

CPU 0                         CPU 1                                     CPU 2
-----       

//Wake up A
ttwu_queue(TASK A, CPU 1)     idle_loop {
                                  ttwu_queue_pending {
                                      ....
                                      raw_spin_unlock_irqrestore(rq)
                                      # VMEXIT (with IPI still pending)
                                                                        //task A migrates here
                                                                        wait_event(....)
                                                                        //sleep

//Wake up A
ttwu_queue(TASK A, CPU 2) {
    //IPI on CPU 2 ignored
    // due to csd->flags == CSD_LOCK

