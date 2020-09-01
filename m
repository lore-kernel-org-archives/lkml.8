Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B90C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04231206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598957215;
	bh=2dh4bRkFIOL/aDM+3ZCDXfmsfOJzqiZBEB8pBIDbibM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0UqBQTRm5wi27PTE7UHXA4BTjF1Ln251Tilu4iWvksRRZtbEFS0pmDkxQOxvzAzxb
	 adoYAdxxmPxm0HolpaV8vmZDmgs1Z5PF3fSw6TLF7NAdccTc60We2la5jzttdUFVIJ
	 LdWSlWHGi0opuFxe+eLOrqVJt6Y98HmUXHAYCt2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgIAKqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgIAKqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:46:45 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6474B206C0;
        Tue,  1 Sep 2020 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598957204;
        bh=2dh4bRkFIOL/aDM+3ZCDXfmsfOJzqiZBEB8pBIDbibM=;
        h=Date:From:To:Cc:Subject:From;
        b=1Av6u4w16lE/r6ASmORVmsslLgV00S4fcOpMkHmo1O1uSTrCt7pLK6wDjsSRb0xMm
         Y9ytsvl61r7WjHSWZMM5FSLy8MGXvncFK8ELRefDvuIJW7zP7e7Jpy7NO4djXrx7bz
         v7udxhOjEwKl0+YLEyhE+zYCMJKoay35qmfZB1b4=
Date:   Tue, 1 Sep 2020 12:46:41 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>, Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Requirements to control kernel isolation/nohz_full at runtime
Message-ID: <20200901104640.GA13814@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently working on making nohz_full/nohz_idle runtime toggable
and some other people seem to be interested as well. So I've dumped
a few thoughts about some pre-requirements to achieve that for those
interested.

As you can see, there is a bit of hard work in the way. I'm iterating
that in https://pad.kernel.org/p/isolation, feel free to edit:


== RCU nocb ==

Currently controllable with "rcu_nocbs=" boot parameter and/or through nohz_full=/isolcpus=nohz
We need to make it toggeable at runtime. Currently handling that:
v1: https://lwn.net/Articles/820544/
v2: coming soon

== TIF_NOHZ ==

Need to get rid of that in order not to trigger syscall slowpath on CPUs that don't want nohz_full.
Also we don't want to iterate all threads and clear the flag when the last nohz_full CPU exits nohz_full
mode. Prefer static keys to call context tracking on archs. x86 does that well.

== Proper entry code ==

We must make sure that a given arch never calls exception_enter() / exception_exit().
This saves the previous state of context tracking and switch to kernel mode (from context tracking POV)
temporarily. Since this state is saved on the stack, this prevents us from turning off context tracking
entirely on a CPU: The tracking must be done on all CPUs and that takes some cycles.

This means that, considering early entry code (before the call to context tracking upon kernel entry,
and after the call to context tracking upon kernel exit), we must take care of few things:

1) Make sure early entry code can't trigger exceptions. Or if it does, the given exception can't schedule
or use RCU (unless it calls rcu_nmi_enter()). Otherwise the exception must call exception_enter()/exception_exit()
which we don't want.

2) No call to schedule_user().

3) Make sure early entry code is not interruptible or preempt_schedule_irq() would rely on
exception_entry()/exception_exit()

4) Make sure early entry code can't be traced (no call to preempt_schedule_notrace()), or if it does it
can't schedule

I believe x86 does most of that well. In the end we should remove exception_enter()/exit implementations
in x86 and replace it with a check that makes sure context_tracking state is not in USER. An arch meeting
all the above conditions would earn a CONFIG_ARCH_HAS_SANE_CONTEXT_TRACKING. Being able to toggle nohz_full
at runtime would depend on that.


== Cputime accounting ==

Both write and read side must switch to tick based accounting and drop the use of seqlock in task_cputime(),
task_gtime(), kcpustat_field(), kcpustat_cpu_fetch(). Special ordering/state machine is required to make that without races.

== Nohz ==

Switch from nohz_full to nohz_idle. Mind a few details:
    
    1) Turn off 1Hz offlined tick handled in housekeeping
    2) Handle tick dependencies, take care of racing CPUs setting/clearing tick dependency. It's much trickier when
    we switch from nohz_idle to nohz_full
    
== Unbound affinity ==

Restore kernel threads, workqueue, timers, etc... wide affinity. But take care of cpumasks that have been set through other
interfaces: sysfs, procfs, etc...
