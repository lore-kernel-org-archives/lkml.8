Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E84C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4D02073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfTh2q5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgC0MJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:09:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52728 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbgC0MJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585310975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJQH4adUoRVUBtJ5CeJjShCGcnT/rCeSh9pNXp1X7Ag=;
        b=YfTh2q5Cb8O7sEWL/U57+jhZn7Uf9n1AIS9EBn8RZx1ZEP76kP6/9PUStiRlP4+3oBKCQW
        aSKiYiQ5hel9TQnUoYbCBwzxas2TNqnwVnZ8dh/knlpCuDfy3ih7kN/rJmdlvDMKAX9xq+
        npw5IaARn8otN9kiXsnSgB5T23zwGws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-3BBQ8wcvNCib6c4h8eJsFg-1; Fri, 27 Mar 2020 08:09:31 -0400
X-MC-Unique: 3BBQ8wcvNCib6c4h8eJsFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBC8C1005509;
        Fri, 27 Mar 2020 12:09:29 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-58.gru2.redhat.com [10.97.116.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48F3760BF4;
        Fri, 27 Mar 2020 12:09:29 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 8F85D4198B3C; Fri, 27 Mar 2020 09:07:28 -0300 (-03)
Date:   Fri, 27 Mar 2020 09:07:28 -0300
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
Message-ID: <20200327120728.GA11108@fuller.cnet>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
 <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
 <87imiuq0cg.fsf@nanos.tec.linutronix.de>
 <20200324152016.GA25422@fuller.cnet>
 <20200325002956.GC20223@lenoir>
 <20200325114736.GA17165@fuller.cnet>
 <20200326162002.GA3946@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326162002.GA3946@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 05:20:05PM +0100, Frederic Weisbecker wrote:
> On Wed, Mar 25, 2020 at 08:47:36AM -0300, Marcelo Tosatti wrote:
> > 
> > Hi Frederic,
> > 
> > On Wed, Mar 25, 2020 at 01:30:00AM +0100, Frederic Weisbecker wrote:
> > > On Tue, Mar 24, 2020 at 12:20:16PM -0300, Marcelo Tosatti wrote:
> > > > 
> > > > This is a kernel enhancement to configure the cpu affinity of kernel
> > > > threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>
> > > > 
> > > > When this option is specified, the cpumask is immediately applied upon
> > > > thread launch. This does not affect kernel threads that specify cpu
> > > > and node.
> > > > 
> > > > This allows CPU isolation (that is not allowing certain threads
> > > > to execute on certain CPUs) without using the isolcpus=domain parameter,
> > > > making it possible to enable load balancing on such CPUs
> > > > during runtime (see
> > > > 
> > > > Note-1: this is based off on Wind River's patch at
> > > > https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch
> > > > 
> > > > Difference being that this patch is limited to modifying
> > > > kernel thread cpumask: Behaviour of other threads can
> > > > be controlled via cgroups or sched_setaffinity.
> > > > 
> > > > Note-2: MontaVista's patch was based off Christoph Lameter's patch at
> > > > https://lwn.net/Articles/565932/ with the only difference being
> > > > the kernel parameter changed from kthread to kthread_cpus.
> > > > 
> > > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > > 
> > > I'm wondering, why do you need such a boot shift at all when you
> > > can actually affine kthreads on runtime?
> > 
> > New, unbound kernel threads inherit the cpumask of kthreadd.
> > 
> > Therefore there is a race between kernel thread creation 
> > and affine.
> > 
> > If you know of a solution to that problem, that can be used instead.
> 
> Well, you could first set the affinity of kthreadd and only then the affinity
> of the others. But I can still imagine some tiny races with fork().
> 
> > > 
> > > >  };
> > > >  
> > > >  #ifdef CONFIG_CPU_ISOLATION
> > > > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > > > index b262f47046ca..be9c8d53a986 100644
> > > > --- a/kernel/kthread.c
> > > > +++ b/kernel/kthread.c
> > > > @@ -347,7 +347,7 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
> > > >  		 * The kernel thread should not inherit these properties.
> > > >  		 */
> > > >  		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
> > > > -		set_cpus_allowed_ptr(task, cpu_all_mask);
> > > > +		set_cpus_allowed_ptr(task, cpu_kthread_mask);
> > > 
> > > I'm wondering, why are we using cpu_all_mask and not cpu_possible_mask here?
> > > If we used the latter, you wouldn't need to create cpu_kthread_mask and
> > > you could directly rely on housekeeping_cpumask(HK_FLAG_KTHREAD).
> > 
> > I suppose that either work: CPUs can only be online from
> > cpu_possible_mask (and is contained in cpu_possible_mask).
> > 
> > Nice cleanup, thanks.
> 
> But may I suggest you to do:
> 
> -         set_cpus_allowed_ptr(task, cpu_all_mask);
> +         set_cpus_allowed_ptr(task, cpu_possible_mask);
> 
> as a first step in its own patch in the series. I just want to make sure that change
> isn't missed by reviewers or bisections, in case someone catches something we
> overlooked.
> 
> > 
> > > 
> > > > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > > > index 008d6ac2342b..e9d48729efd4 100644
> > > > --- a/kernel/sched/isolation.c
> > > > +++ b/kernel/sched/isolation.c
> > > > @@ -169,6 +169,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
> > > >  			continue;
> > > >  		}
> > > >  
> > > > +		if (!strncmp(str, "no_kthreads,", 12)) {
> > > > +			str += 12;
> > > > +			flags |= HK_FLAG_NO_KTHREADS;
> > > 
> > > You will certainly want HK_FLAG_WQ as well since workqueue has its own
> > > way to deal with unbound affinity.
> > 
> > Yep. HK_FLAG_WQ is simply a convenience so that the user does not have
> > to configure this separately: OK.
> 
> Also, and that's a larger debate, are you interested in isolating kthreads
> only or any kind of kernel unbound work that could be affine outside
> a given CPU?

Any kind of kernel work.

> In case of all the unbound work, I may suggest an all-in-one "unbound"
> flag that would do:
> 
>     HK_FLAG_KTHREAD | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC
>         | HK_FLAG_SCHED
> 
> Otherwise we can stick with HK_FLAG_KTHREAD, but I'd be curious about your usecase.
> 
> Thanks.

BTW HK_FLAG_SCHED is not settable at the moment.

Any reason why nohz_full= is not setting it ?

Thanks

