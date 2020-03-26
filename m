Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4933FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE51B20857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585239612;
	bh=V0bwBbJyY1QosWL6Qthc9eGWMt88BWvj2yaKKDb3Gwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZMloGJgf+wD+bybvZGMWD15Zqg29sj3M7Y/+JgxMD4Hbv3b6uRw9pgdfBEc1cy7yb
	 CO38f53wfp9iTrbrflZzci0FnEyf/iGvO0uER+pqWBy/vP3GVExHvZUYubYlp9z5xP
	 YXlygiIeTydK3qumX/GhplTM86U2hIEewKpkI2Es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgCZQUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCZQUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:20:10 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 932882083E;
        Thu, 26 Mar 2020 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585239608;
        bh=V0bwBbJyY1QosWL6Qthc9eGWMt88BWvj2yaKKDb3Gwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GvkZkibuDm+OFw8wtKPkyfUYgQDoF2Yixj/a6D5D7bR7wv76S56yWtdpwNuVJK5lX
         jop5cohgQMNbB0D4zW6pQSzEl8aNEOZFkKr/xft7Sdno01jGGmDbeiE/sYLcyVq9gU
         4/A/x22BWY0eMx+gFvc54a7exf+MIe4KMu/pf1K4=
Date:   Thu, 26 Mar 2020 17:20:05 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Chris Friesen <chris.friesen@windriver.com>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] isolcpus: affine kernel threads to specified cpumask
Message-ID: <20200326162002.GA3946@lenoir>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
 <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
 <87imiuq0cg.fsf@nanos.tec.linutronix.de>
 <20200324152016.GA25422@fuller.cnet>
 <20200325002956.GC20223@lenoir>
 <20200325114736.GA17165@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325114736.GA17165@fuller.cnet>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 08:47:36AM -0300, Marcelo Tosatti wrote:
> 
> Hi Frederic,
> 
> On Wed, Mar 25, 2020 at 01:30:00AM +0100, Frederic Weisbecker wrote:
> > On Tue, Mar 24, 2020 at 12:20:16PM -0300, Marcelo Tosatti wrote:
> > > 
> > > This is a kernel enhancement to configure the cpu affinity of kernel
> > > threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>
> > > 
> > > When this option is specified, the cpumask is immediately applied upon
> > > thread launch. This does not affect kernel threads that specify cpu
> > > and node.
> > > 
> > > This allows CPU isolation (that is not allowing certain threads
> > > to execute on certain CPUs) without using the isolcpus=domain parameter,
> > > making it possible to enable load balancing on such CPUs
> > > during runtime (see
> > > 
> > > Note-1: this is based off on Wind River's patch at
> > > https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch
> > > 
> > > Difference being that this patch is limited to modifying
> > > kernel thread cpumask: Behaviour of other threads can
> > > be controlled via cgroups or sched_setaffinity.
> > > 
> > > Note-2: MontaVista's patch was based off Christoph Lameter's patch at
> > > https://lwn.net/Articles/565932/ with the only difference being
> > > the kernel parameter changed from kthread to kthread_cpus.
> > > 
> > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > I'm wondering, why do you need such a boot shift at all when you
> > can actually affine kthreads on runtime?
> 
> New, unbound kernel threads inherit the cpumask of kthreadd.
> 
> Therefore there is a race between kernel thread creation 
> and affine.
> 
> If you know of a solution to that problem, that can be used instead.

Well, you could first set the affinity of kthreadd and only then the affinity
of the others. But I can still imagine some tiny races with fork().

> > 
> > >  };
> > >  
> > >  #ifdef CONFIG_CPU_ISOLATION
> > > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > > index b262f47046ca..be9c8d53a986 100644
> > > --- a/kernel/kthread.c
> > > +++ b/kernel/kthread.c
> > > @@ -347,7 +347,7 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
> > >  		 * The kernel thread should not inherit these properties.
> > >  		 */
> > >  		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
> > > -		set_cpus_allowed_ptr(task, cpu_all_mask);
> > > +		set_cpus_allowed_ptr(task, cpu_kthread_mask);
> > 
> > I'm wondering, why are we using cpu_all_mask and not cpu_possible_mask here?
> > If we used the latter, you wouldn't need to create cpu_kthread_mask and
> > you could directly rely on housekeeping_cpumask(HK_FLAG_KTHREAD).
> 
> I suppose that either work: CPUs can only be online from
> cpu_possible_mask (and is contained in cpu_possible_mask).
> 
> Nice cleanup, thanks.

But may I suggest you to do:

-         set_cpus_allowed_ptr(task, cpu_all_mask);
+         set_cpus_allowed_ptr(task, cpu_possible_mask);

as a first step in its own patch in the series. I just want to make sure that change
isn't missed by reviewers or bisections, in case someone catches something we
overlooked.

> 
> > 
> > > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > > index 008d6ac2342b..e9d48729efd4 100644
> > > --- a/kernel/sched/isolation.c
> > > +++ b/kernel/sched/isolation.c
> > > @@ -169,6 +169,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
> > >  			continue;
> > >  		}
> > >  
> > > +		if (!strncmp(str, "no_kthreads,", 12)) {
> > > +			str += 12;
> > > +			flags |= HK_FLAG_NO_KTHREADS;
> > 
> > You will certainly want HK_FLAG_WQ as well since workqueue has its own
> > way to deal with unbound affinity.
> 
> Yep. HK_FLAG_WQ is simply a convenience so that the user does not have
> to configure this separately: OK.

Also, and that's a larger debate, are you interested in isolating kthreads
only or any kind of kernel unbound work that could be affine outside
a given CPU?

In case of all the unbound work, I may suggest an all-in-one "unbound"
flag that would do:

    HK_FLAG_KTHREAD | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC
        | HK_FLAG_SCHED

Otherwise we can stick with HK_FLAG_KTHREAD, but I'd be curious about your usecase.

Thanks.
