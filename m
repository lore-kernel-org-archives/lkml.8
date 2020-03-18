Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F584C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45D920771
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCRLx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:53:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57178 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgCRLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:53:27 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jEXFu-0003U8-HV; Wed, 18 Mar 2020 12:53:02 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C7EE71040C5; Wed, 18 Mar 2020 12:53:01 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Luck\, Tony" <tony.luck@intel.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
In-Reply-To: <CAEXW_YS927Tc3sPHeK9wW7nL=qvqFDoCX23xxtbMZmVhtbO1xw@mail.gmail.com>
References: <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com> <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com> <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com> <20200212230705.GA25315@sinkpad> <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com> <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com> <CANaguZC40mDHfL1H_9AA7H8cyd028t9PQVRqQ3kB4ha8R7hhqg@mail.gmail.com> <CAERHkruPUrOzDjEp1FV3KY20p9CxLAVzKrZNe5QXsCFZdGskzA@mail.gmail.com> <CANaguZBj_x_2+9KwbHCQScsmraC_mHdQB6uRqMTYMmvhBYfv2Q@mail.gmail.com> <20200221232057.GA19671@sinkpad> <20200317005521.GA8244@google.com> <ee268494-c35e-422f-1aaf-baab12191c38@linux.intel.com> <CAEXW_YS927Tc3sPHeK9wW7nL=qvqFDoCX23xxtbMZmVhtbO1xw@mail.gmail.com>
Date:   Wed, 18 Mar 2020 12:53:01 +0100
Message-ID: <877dzhc21u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel,

Joel Fernandes <joel@joelfernandes.org> writes:
> We have only 2 cores (4 HT) on many devices. It is not an option to
> dedicate a core to only running trusted code, that would kill
> performance. Another option is to designate a single HT of a
> particular core to run both untrusted code and an interrupt handler --
> but as Thomas pointed out, this does not work for per-CPU interrupts
> or managed interrupts, and the softirqs that they trigger. But if we
> just consider interrupts for which we can control the affinities (and
> assuming that most interrupts can be controlled like that), then maybe
> it will work? In the ChromeOS model, each untrusted task is in its own
> domain (cookie). So untrusted tasks cannot benefit from parallelism
> (in our case) anyway -- so it seems reasonable to run an affinable
> interrupt and an untrusted task, on a particular designated core.
>
> (Just thinking out loud...).  Another option could be a patch that
> Vineeth shared with me (that Peter experimentally wrote) where he
> sends IPI from an interrupt handler to a sibling running untrusted
> guest code which would result in it getting paused. I am hoping
> something like this could work on the host side as well (not just for
> guests). We could also set per-core state from the interrupted HT,
> possibly IPI'ing the untrusted sibling if we have to. If sibling runs
> untrusted code *after* the other's siblings interrupt already started,
> then the schedule() loop on the untrusted sibling would spin knowing
> the other sibling has an interrupt in progress. The softirq is a real
> problem though. Perhaps it can also set similar per-core state.

There is not much difference between bringing the sibling out of guest
mode and bringing it out of host user mode.

Adding state to force spinning until the other side has completed is not
rocket science either.

But the whole concept is prone to starvation issues and full of nasty
corner cases. From experiments I did back in the L1TF days I'm pretty
much convinced that this can't result in a generaly usable solution.

Let me share a few thoughts what might be doable with less horrors, but
be aware that this is mostly a brain dump of half thought out ideas.

1) Managed interrupts on multi queue devices

   It should be reasonably simple to force a reduced number of queues
   which would in turn allow to shield one ore two CPUs from such
   interrupts and queue handling for the price of indirection.

2) Timers and softirqs

   If device interrupts are targeted to "safe" CPUs then the amount of
   timers and soft interrupt processing will be reduced as well.

   That still leaves e.g. network TX side soft interrupts when the task
   running on a shielded core does networking. Maybe that's a non issue,
   but I'm not familiar enough with the network maze to give an answer.

   A possible workaround would be to force softirq processing into
   thread context so everything is under scheduler control. How well
   that scales is a different story.

   That would bring out the timer_list timers and reduce the potential
   surface to hrtimer expiry callbacks. Most of them should be fine
   (doing wakeups or scheduler housekeeping of some sort). For the
   others we might just utilize the mechanism which PREEMPT_RT uses and
   force them off into softirq expiry mode.

Thanks,

        tglx
