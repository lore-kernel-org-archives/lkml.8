Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CD1C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFF120767
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YlSJUTS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgCSByt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:54:49 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42820 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgCSByt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:54:49 -0400
Received: by mail-qk1-f196.google.com with SMTP id e11so768624qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 18:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X4WGWSKDvxnCC9fUtMJlfqQs/fN6qQq83wxe5mtIl3A=;
        b=YlSJUTS5B3MBfo6ucuo8eEG3Mf6hYfIR1NLZLtl9u6bUUbbjsngGUEvV2+L0EYWswq
         MYbDp1WyT/rGWIsB9zA632p4OyM4yAJ0vcF48jXihmGOZ89SL+Wb6mAR3aGX8i8dbqya
         A1//1Vmz0nZDM14ukgeRiM5On9O21hlfljqrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X4WGWSKDvxnCC9fUtMJlfqQs/fN6qQq83wxe5mtIl3A=;
        b=YlbwhIist7HfH6vorolhzRIODJC/xnoChfpmqKh6FxKAticDdyn3TqbewM3uw4/rqg
         LzOao343fAlyyWW5DYULk5vlDlq0V4XGHU3rjLNY+l1dORT2MX0n0lpsnCtJjo/5SQNo
         a2BD2e0//uU2R8lp1Xyd5eCCYMQA2K1tJztYOu0pn0bLeSUVEYMMCLEKvjnY6l0Hri9k
         q4tlKctUcJk0jbHitnMBTSp2HKDO2rDSZBPXl52up5HUncwqYBHgUCFRmuDGtwQ0n+QN
         l6U077v7meq1sRTdceVE6mBdtvPbCgjLClw9NU+qa4i0Bza+5OpQa/PAQrjQvhuYFSNL
         qWVA==
X-Gm-Message-State: ANhLgQ35uWp4KuPpGGzDZJB4hWUWD+IurWnbWODJXmk/jL34MbMwPz1I
        nIjZdDmPCoB6x7m809Ykrav3aw==
X-Google-Smtp-Source: ADFU+vv7a+CDD6iI9L5GFHHBldPnYpjIrLOH7kmU8JDJxaPLyIjJzekbThTYE+FnH3QYUg8oaVIGcQ==
X-Received: by 2002:a05:620a:1309:: with SMTP id o9mr821147qkj.293.1584582885801;
        Wed, 18 Mar 2020 18:54:45 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x9sm482413qtk.7.2020.03.18.18.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 18:54:45 -0700 (PDT)
Date:   Wed, 18 Mar 2020 21:54:44 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200319015444.GA224062@google.com>
References: <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <CANaguZC40mDHfL1H_9AA7H8cyd028t9PQVRqQ3kB4ha8R7hhqg@mail.gmail.com>
 <CAERHkruPUrOzDjEp1FV3KY20p9CxLAVzKrZNe5QXsCFZdGskzA@mail.gmail.com>
 <CANaguZBj_x_2+9KwbHCQScsmraC_mHdQB6uRqMTYMmvhBYfv2Q@mail.gmail.com>
 <20200221232057.GA19671@sinkpad>
 <20200317005521.GA8244@google.com>
 <ee268494-c35e-422f-1aaf-baab12191c38@linux.intel.com>
 <CAEXW_YS927Tc3sPHeK9wW7nL=qvqFDoCX23xxtbMZmVhtbO1xw@mail.gmail.com>
 <877dzhc21u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dzhc21u.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, Mar 18, 2020 at 12:53:01PM +0100, Thomas Gleixner wrote:
> Joel,
> 
> Joel Fernandes <joel@joelfernandes.org> writes:
> > We have only 2 cores (4 HT) on many devices. It is not an option to
> > dedicate a core to only running trusted code, that would kill
> > performance. Another option is to designate a single HT of a
> > particular core to run both untrusted code and an interrupt handler --
> > but as Thomas pointed out, this does not work for per-CPU interrupts
> > or managed interrupts, and the softirqs that they trigger. But if we
> > just consider interrupts for which we can control the affinities (and
> > assuming that most interrupts can be controlled like that), then maybe
> > it will work? In the ChromeOS model, each untrusted task is in its own
> > domain (cookie). So untrusted tasks cannot benefit from parallelism
> > (in our case) anyway -- so it seems reasonable to run an affinable
> > interrupt and an untrusted task, on a particular designated core.
> >
> > (Just thinking out loud...).  Another option could be a patch that
> > Vineeth shared with me (that Peter experimentally wrote) where he
> > sends IPI from an interrupt handler to a sibling running untrusted
> > guest code which would result in it getting paused. I am hoping
> > something like this could work on the host side as well (not just for
> > guests). We could also set per-core state from the interrupted HT,
> > possibly IPI'ing the untrusted sibling if we have to. If sibling runs
> > untrusted code *after* the other's siblings interrupt already started,
> > then the schedule() loop on the untrusted sibling would spin knowing
> > the other sibling has an interrupt in progress. The softirq is a real
> > problem though. Perhaps it can also set similar per-core state.
> 
> There is not much difference between bringing the sibling out of guest
> mode and bringing it out of host user mode.
> 
> Adding state to force spinning until the other side has completed is not
> rocket science either.
> 
> But the whole concept is prone to starvation issues and full of nasty
> corner cases. From experiments I did back in the L1TF days I'm pretty
> much convinced that this can't result in a generaly usable solution.
> Let me share a few thoughts what might be doable with less horrors, but
> be aware that this is mostly a brain dump of half thought out ideas.
> 
> 1) Managed interrupts on multi queue devices
> 
>    It should be reasonably simple to force a reduced number of queues
>    which would in turn allow to shield one ore two CPUs from such
>    interrupts and queue handling for the price of indirection.
> 
> 2) Timers and softirqs
> 
>    If device interrupts are targeted to "safe" CPUs then the amount of
>    timers and soft interrupt processing will be reduced as well.
> 
>    That still leaves e.g. network TX side soft interrupts when the task
>    running on a shielded core does networking. Maybe that's a non issue,
>    but I'm not familiar enough with the network maze to give an answer.
> 
>    A possible workaround would be to force softirq processing into
>    thread context so everything is under scheduler control. How well
>    that scales is a different story.
> 
>    That would bring out the timer_list timers and reduce the potential
>    surface to hrtimer expiry callbacks. Most of them should be fine
>    (doing wakeups or scheduler housekeeping of some sort). For the
>    others we might just utilize the mechanism which PREEMPT_RT uses and
>    force them off into softirq expiry mode.

Thanks a lot for your thoughts, it is really helpful.

One issue with interrupt affinities is, we have only 2 cores on many devices
(4 HTs).  If we assign 1 HT out of the 4 for receiving interrupts (at least
the ones we can control affinity off), then that means we have to devote that
core to running only 1 trusted task at a time, since one of the 2 HT is
designated for interrupts. That leaves us with only the other 2 HTs on the
other core for simultaneously running the 2 trusted tasks, thus reducing the
parallellism.

Thanks for raising the point about running interrupts and softirqs in process
context to solve these, turns out we do use threaded IRQs however not on most
interrupts.  We could consider threading as many IRQs (and softirqs) as
as possible and for the ones we cannot thread, may be we can code audit code and
assess the risk, possibly deferring processing of sensitivity data to
workqueue context. Perhaps we can also conditionally force a softirq into
process context say if we detect that the core has an untrusted task running
on the softirq HT's sibling, and if not let the softirq execute in softirq
context itself.

Thanks, Thomas!!

 - Joel

