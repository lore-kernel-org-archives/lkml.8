Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4530CC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106D920714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAmB01Le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCYLsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:48:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24648 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726276AbgCYLsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585136884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yVztRHM0wPS4jPDaBQT2Oc6LcCZfd2nVYB+shZ5fKfA=;
        b=PAmB01LeDIcjNIOsvcPFYUFigczpFiZUAe5kKJFvjpThD1GLs4vBVZDalYnDDQsHa62R0m
        St1vT0hYSEj3TTuR2F6xVH2baBk15Ko753F25IWKOrk5x3iM/EWeBoF55ZHFkNR5Dbpm9a
        CUUWS7SEyYL0kSul8jC3/G5x86Kgssk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-gSUD7jFQPMSXnFIah7RC5A-1; Wed, 25 Mar 2020 07:48:00 -0400
X-MC-Unique: gSUD7jFQPMSXnFIah7RC5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2CC6800D5C;
        Wed, 25 Mar 2020 11:47:58 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-46.gru2.redhat.com [10.97.116.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 510F7BBBC2;
        Wed, 25 Mar 2020 11:47:58 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 6CCC24198B04; Wed, 25 Mar 2020 08:47:36 -0300 (-03)
Date:   Wed, 25 Mar 2020 08:47:36 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Chris Friesen <chris.friesen@windriver.com>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] isolcpus: affine kernel threads to specified cpumask
Message-ID: <20200325114736.GA17165@fuller.cnet>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
 <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
 <87imiuq0cg.fsf@nanos.tec.linutronix.de>
 <20200324152016.GA25422@fuller.cnet>
 <20200325002956.GC20223@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325002956.GC20223@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Frederic,

On Wed, Mar 25, 2020 at 01:30:00AM +0100, Frederic Weisbecker wrote:
> On Tue, Mar 24, 2020 at 12:20:16PM -0300, Marcelo Tosatti wrote:
> > 
> > This is a kernel enhancement to configure the cpu affinity of kernel
> > threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>
> > 
> > When this option is specified, the cpumask is immediately applied upon
> > thread launch. This does not affect kernel threads that specify cpu
> > and node.
> > 
> > This allows CPU isolation (that is not allowing certain threads
> > to execute on certain CPUs) without using the isolcpus=domain parameter,
> > making it possible to enable load balancing on such CPUs
> > during runtime (see
> > 
> > Note-1: this is based off on Wind River's patch at
> > https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch
> > 
> > Difference being that this patch is limited to modifying
> > kernel thread cpumask: Behaviour of other threads can
> > be controlled via cgroups or sched_setaffinity.
> > 
> > Note-2: MontaVista's patch was based off Christoph Lameter's patch at
> > https://lwn.net/Articles/565932/ with the only difference being
> > the kernel parameter changed from kthread to kthread_cpus.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> I'm wondering, why do you need such a boot shift at all when you
> can actually affine kthreads on runtime?

New, unbound kernel threads inherit the cpumask of kthreadd.

Therefore there is a race between kernel thread creation 
and affine.

If you know of a solution to that problem, that can be used instead.

> > 
> > ---
> > 
> > v2: use isolcpus= subcommand (Thomas Gleixner)
> > 
> >  Documentation/admin-guide/kernel-parameters.txt |    8 ++++++++
> >  include/linux/cpumask.h                         |    5 +++++
> >  include/linux/sched/isolation.h                 |    1 +
> >  init/main.c                                     |    1 +
> >  kernel/cpu.c                                    |   13 +++++++++++++
> >  kernel/kthread.c                                |    4 ++--
> >  kernel/sched/isolation.c                        |    6 ++++++
> >  7 files changed, 36 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index c07815d230bc..7318e3057383 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1959,6 +1959,14 @@
> >  			  the CPU affinity syscalls or cpuset.
> >  			  <cpu number> begins at 0 and the maximum value is
> >  			  "number of CPUs in system - 1".
> > +			  When using cpusets, use the isolcpus option no_kthreads
> > +			  to avoid creation of kernel threads on isolated CPUs.
> > +
> > +			no_kthreads
> > +			  Adjust the CPU affinity mask of unbound kernel threads to
> > +			  not contain CPUs on the isolated list. This complements
> > +			  the isolation provided by the cpusets mechanism described
> > +			  above.
> 
> Actually that should be "kthread" instead of no_kthreads. A flag of isolcpus
> describes what we want a set of CPUs to be isolated from. Well, at least that's
> how we started with "domain" and "managed_irq".

Sure.

> 
> >  
> >  			managed_irq
> >  
> > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > index 0fbcbacd1b29..d002332d00eb 100644
> > --- a/include/linux/sched/isolation.h
> > +++ b/include/linux/sched/isolation.h
> > @@ -14,6 +14,7 @@ enum hk_flags {
> >  	HK_FLAG_DOMAIN		= (1 << 5),
> >  	HK_FLAG_WQ		= (1 << 6),
> >  	HK_FLAG_MANAGED_IRQ	= (1 << 7),
> > +	HK_FLAG_NO_KTHREADS	= (1 << 8),
> 
> Similarly that should be HK_FLAG_KTHREAD.

Sure.

> 
> >  };
> >  
> >  #ifdef CONFIG_CPU_ISOLATION
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index b262f47046ca..be9c8d53a986 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -347,7 +347,7 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
> >  		 * The kernel thread should not inherit these properties.
> >  		 */
> >  		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
> > -		set_cpus_allowed_ptr(task, cpu_all_mask);
> > +		set_cpus_allowed_ptr(task, cpu_kthread_mask);
> 
> I'm wondering, why are we using cpu_all_mask and not cpu_possible_mask here?
> If we used the latter, you wouldn't need to create cpu_kthread_mask and
> you could directly rely on housekeeping_cpumask(HK_FLAG_KTHREAD).

I suppose that either work: CPUs can only be online from
cpu_possible_mask (and is contained in cpu_possible_mask).

Nice cleanup, thanks.

> 
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index 008d6ac2342b..e9d48729efd4 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -169,6 +169,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
> >  			continue;
> >  		}
> >  
> > +		if (!strncmp(str, "no_kthreads,", 12)) {
> > +			str += 12;
> > +			flags |= HK_FLAG_NO_KTHREADS;
> 
> You will certainly want HK_FLAG_WQ as well since workqueue has its own
> way to deal with unbound affinity.

Yep. HK_FLAG_WQ is simply a convenience so that the user does not have
to configure this separately: OK.

> 
> > +			continue;
> > +		}
> > +
> >  		pr_warn("isolcpus: Error, unknown flag\n");
> >  		return 0;
> >  	}
> > 
> 
> Thanks.

