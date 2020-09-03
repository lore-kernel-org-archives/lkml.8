Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E10AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B08F20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka9OnETU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgICSar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:30:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27776 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727065AbgICSap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599157843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJbk2K6+pCV68bFCa4baP2HQg3BY5d7akosXwLiLy00=;
        b=Ka9OnETUc2P+RX34283AxSzsn380u6ALA2UbdWzOc5DEMJriNoyvy+1RSFPYetQGTAO5Zv
        4yhLLIUlixtDTV5x0Odl86LhoQfy4Kzx2Wn82dL/GtBcbefPd0erfugvfftlZ/0GM+EZRR
        oz4dVNuAWAumOfZr8vunBlEW6Q7KgI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-wgmA4WdrPoWG-w3vINI_QA-1; Thu, 03 Sep 2020 14:30:41 -0400
X-MC-Unique: wgmA4WdrPoWG-w3vINI_QA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EE5081F00B;
        Thu,  3 Sep 2020 18:30:40 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CC7510013C4;
        Thu,  3 Sep 2020 18:30:39 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id DCE744168BB3; Thu,  3 Sep 2020 15:30:15 -0300 (-03)
Date:   Thu, 3 Sep 2020 15:30:15 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Requirements to control kernel isolation/nohz_full at runtime
Message-ID: <20200903183015.GA1027417@fuller.cnet>
References: <20200901104640.GA13814@lenoir>
 <20200903182359.GA1016174@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903182359.GA1016174@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 03:23:59PM -0300, Marcelo Tosatti wrote:
> On Tue, Sep 01, 2020 at 12:46:41PM +0200, Frederic Weisbecker wrote:
> > Hi,
> 
> Hi Frederic,
> 
> Thanks for the summary! Looking forward to your comments...
> 
> > I'm currently working on making nohz_full/nohz_idle runtime toggable
> > and some other people seem to be interested as well. So I've dumped
> > a few thoughts about some pre-requirements to achieve that for those
> > interested.
> > 
> > As you can see, there is a bit of hard work in the way. I'm iterating
> > that in https://pad.kernel.org/p/isolation, feel free to edit:
> > 
> > 
> > == RCU nocb ==
> > 
> > Currently controllable with "rcu_nocbs=" boot parameter and/or through nohz_full=/isolcpus=nohz
> > We need to make it toggeable at runtime. Currently handling that:
> > v1: https://lwn.net/Articles/820544/
> > v2: coming soon
> 
> Nice.
> 
> > == TIF_NOHZ ==
> > 
> > Need to get rid of that in order not to trigger syscall slowpath on CPUs that don't want nohz_full.
> > Also we don't want to iterate all threads and clear the flag when the last nohz_full CPU exits nohz_full
> > mode. Prefer static keys to call context tracking on archs. x86 does that well.
> > 
> > == Proper entry code ==
> > 
> > We must make sure that a given arch never calls exception_enter() / exception_exit().
> > This saves the previous state of context tracking and switch to kernel mode (from context tracking POV)
> > temporarily. Since this state is saved on the stack, this prevents us from turning off context tracking
> > entirely on a CPU: The tracking must be done on all CPUs and that takes some cycles.
> > 
> > This means that, considering early entry code (before the call to context tracking upon kernel entry,
> > and after the call to context tracking upon kernel exit), we must take care of few things:
> > 
> > 1) Make sure early entry code can't trigger exceptions. Or if it does, the given exception can't schedule
> > or use RCU (unless it calls rcu_nmi_enter()). Otherwise the exception must call exception_enter()/exception_exit()
> > which we don't want.
> > 
> > 2) No call to schedule_user().
> > 
> > 3) Make sure early entry code is not interruptible or preempt_schedule_irq() would rely on
> > exception_entry()/exception_exit()
> > 
> > 4) Make sure early entry code can't be traced (no call to preempt_schedule_notrace()), or if it does it
> > can't schedule
> > 
> > I believe x86 does most of that well. In the end we should remove exception_enter()/exit implementations
> > in x86 and replace it with a check that makes sure context_tracking state is not in USER. An arch meeting
> > all the above conditions would earn a CONFIG_ARCH_HAS_SANE_CONTEXT_TRACKING. Being able to toggle nohz_full
> > at runtime would depend on that.
> > 
> > 
> > == Cputime accounting ==
> > 
> > Both write and read side must switch to tick based accounting and drop the use of seqlock in task_cputime(),
> > task_gtime(), kcpustat_field(), kcpustat_cpu_fetch(). Special ordering/state machine is required to make that without races.
> > 
> > == Nohz ==
> > 
> > Switch from nohz_full to nohz_idle. Mind a few details:
> >     
> >     1) Turn off 1Hz offlined tick handled in housekeeping
> >     2) Handle tick dependencies, take care of racing CPUs setting/clearing tick dependency. It's much trickier when
> >     we switch from nohz_idle to nohz_full
> >     
> > == Unbound affinity ==
> > 
> > Restore kernel threads, workqueue, timers, etc... wide affinity. But take care of cpumasks that have been set through other
> > interfaces: sysfs, procfs, etc...
> 
> We were looking at a userspace interface: what would be a proper
> (unified, similar to isolcpus= interface) and its implementation:
> 
> The simplest idea for interface seemed to be exposing the integer list of
> CPUs and isolation flags to userspace (probably via sysfs).
> 
> The scheme would allow flags to be separately enabled/disabled, 
> with not all flags being necessary toggable (could for example
> disallow nohz_full= toggling until it is implemented, but allow for
> other isolation features to be toggable).
> 
> This would require per flag housekeeping_masks (instead of a single).
> 
> Back to the userspace interface, you mentioned earlier that cpusets
> was a possibility for it. However:
> 
> "Cpusets provide a Linux kernel mechanism to constrain which CPUs and
> Memory Nodes are used by a process or set of processes.
> 
> The Linux kernel already has a pair of mechanisms to specify on which
> CPUs a task may be scheduled (sched_setaffinity) and on which Memory
> Nodes it may obtain memory (mbind, set_mempolicy).
> 
> Cpusets extends these two mechanisms as follows:"
> 
> The isolation flags do not necessarily have anything to do with
> tasks, but with CPUs: a given feature is disabled or enabled on a
> given CPU. 
> No?

One cpumask per feature, implemented separately in sysfs, also 
seems OK (modulo documentation about the RCU update and users
of the previous versions).

This is what is being done for rcu_nocbs= already...

