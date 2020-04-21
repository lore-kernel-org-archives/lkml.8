Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD96EC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAE6206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpYqVTQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgDUOW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728802AbgDUOW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:22:57 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C43FC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:22:55 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 198so11265489lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k6ab/bkDu1RVkI97s7atWFtrdWrGa0cxJtw4Ir9Dm3U=;
        b=jpYqVTQSOyZUQiPZFkWvoPVxTMBfTsq2BYoHf5MkHXsfqo0OZEKBEeYm8/Dk7mQRN3
         F+s+McOJy74BOI4cVjfQkLuz1uYUw0qgQz6fDSfKir/CiKx6J1qn88bNmiigBfXfFQqV
         WZeU4Wvj4MDtrk3vFaQmwpZKwoMwT4PDU+Bood1/zqRTIwZi/C5NgNkSvFMxMvWn/VJ0
         j8OBEXArZuywjr/JTYQ4jK9NC0l/VWLjkNEE7gCOBz02Qpt1ZxfJMvzBRgvy8soLcjc4
         RkgQ9x2ZcyRTWnDALoX1pjn8CGeNW+k0DYaqGya6nngRSjgjQc3RU4HgXMf6GlGoC8WM
         K31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k6ab/bkDu1RVkI97s7atWFtrdWrGa0cxJtw4Ir9Dm3U=;
        b=WxFTySsQ3UVSIVwlHUhZ9zrHPfosxg64hjah94QobbZwX0vkq5q7QtKHm5xUZKLMKH
         i77WHxdLaB+l9dfmsyzmY0az5U41XS54bl3PxmTDxdOO7eK8gm4J/kp8cHlwLzVRDu1K
         FhmyJ4vNNM4/M+DtrcmjLfTphpest+o+6otI9MdBeMDOpJRwwsoo8PET0xx6YCryvttt
         1O9bQ/fqxnd6/T8DZjXIUktxK8HnVa1joOSnTCaIScqmoniAk+I1+MlbkSJhWKdMw80V
         1rWLSD82Fb5c+swA2hKfjsucyYDkJoF/egRwyJXaiLeDQRNyIr7uZUwC4IWH2+1qgow8
         WyQA==
X-Gm-Message-State: AGi0Pua5kwJM01hcFRs7gAhW3oF3MUX1vHsABQLi9yDgxsuggpOVMH/I
        InARqxRyk8V6tojpkWHzaK8=
X-Google-Smtp-Source: APiQypLOWabhOG5HSENpfy7YGJYzeAvG31B+2Zeni4o72kAv+2SO5PJ86WJt3uu+Cn836PTokSJGHg==
X-Received: by 2002:ac2:5e66:: with SMTP id a6mr14405778lfr.177.1587478972958;
        Tue, 21 Apr 2020 07:22:52 -0700 (PDT)
Received: from localhost ([176.212.68.26])
        by smtp.gmail.com with ESMTPSA id m18sm2264385lfj.10.2020.04.21.07.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 07:22:52 -0700 (PDT)
Date:   Tue, 21 Apr 2020 07:22:49 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] sched/rt: Distribute tasks in find_lowest_rq()
Message-ID: <20200421142249.GA13889@yury-thinkpad>
References: <20200414150556.10920-1-qais.yousef@arm.com>
 <jhjh7xlvqqe.mognet@arm.com>
 <20200421121305.ziu3dfqwo7cw6ymu@e107158-lin.cambridge.arm.com>
 <jhjv9ltkmel.mognet@arm.com>
 <CAKfTPtB9gYh_7qV0y_t7HRg7HOpYfkJ96fXCYFFTBmcJxnnXEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB9gYh_7qV0y_t7HRg7HOpYfkJ96fXCYFFTBmcJxnnXEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 03:28:14PM +0200, Vincent Guittot wrote:
> On Tue, 21 Apr 2020 at 15:18, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> >
> > On 21/04/20 13:13, Qais Yousef wrote:
> > > On 04/14/20 19:58, Valentin Schneider wrote:
> > >>
> > >> I'm a bit wary about such blanket changes. I feel like most places impacted
> > >> by this change don't gain anything by using the random thing. In sched land
> > >> that would be:
> > >
> > > The API has always been clear that cpumask_any return a random cpu within the
> > > mask. And the fact it's a one liner with cpumask_first() directly visible,
> > > a user made the choice to stick to cpumask_any() indicates that that's what
> > > they wanted.
> > >
> > > Probably a lot of them they don't care what cpu is returned and happy with the
> > > random value. I don't see why it has to have an effect. Some could benefit,
> > > like my use case here. Or others truly don't care, then it's fine to return
> > > anything, as requested.
> > >
> >
> > Exactly, *some* (which AFAICT is a minority) might benefit. So why should
> > all the others pay the price for a functionality they do not need?
> >
> > I don't think your change would actually cause a splat somewhere; my point
> > is about changing existing behaviour without having a story for it. The
> > thing said 'pick a "random" cpu', sure, but it never did that, it always
> > picked the first.
> >
> > I've pointed out two examples that want to be cpumask_first(), and I'm
> > absolutely certain there are more than these two out there. What if folks
> > ran some performance test and were completely fine with the _first()
> > behaviour? What tells you randomness won't degrade some cases?
> 
> I tend to agree that any doesn't mean random and using a random cpu
> will create strange behavior
> 
> One example is the irq affinity on b.L system. Right now, the irq are
> always pinned to the same CPU (the 1st one which is most probably a
> Little) but with your change we can imagine that this will change and
> might ever change over 2 consecutives boot if for whatever reason (and
> this happen) the drivers are not probed in the same order . At the end
> you will run some tests with irq on little and other time irq on big.
> And more generally speaking and a SMP system can be impacted because
> the irq will not be pinned to the same CPU with always the same other
> irqs
> 
> >
> > IMO the correct procedure is to keep everything as it is and improve the
> > specific callsites that benefit from randomness. I get your point that
> 
> I agree with this point
> > using cpumask_any() should be a good enough indicator of the latter, but I
> > don't think it can realistically be followed. To give my PoV, if in the
> > past someone had used a cpumask_any() where a cpumask_first() could do, I
> > would've acked it (disclaimer: super representative population of sample
> > size = 1).
> >
> > Flipping the switch on everyone to then have a series of patches "oh this
> > one didn't need it", "this one neither", "I actually need this to be the
> > first" just feels sloppy.
> >
> > > I CCed Marc who's the maintainer of this file who can clarify better if this
> > > really breaks anything.
> > >
> > > If any interrupt expects to be affined to a specific CPU then this must be
> > > described in DT/driver. I think the GIC controller is free to distribute them
> > > to any cpu otherwise if !force. Which is usually done by irq_balancer anyway
> > > in userspace, IIUC.
> > >
> > > I don't see how cpumask_any_and() break anything here too. I actually think it
> > > improves on things by better distribute the irqs on the system by default.
> > >
> >
> > As you say, if someone wants smarter IRQ affinity they can do irq_balancer
> > and whatnot. The default kernel policy for now has been to shove everything
> > on the lowest-numbered CPU, and I see no valid reason to change that.

My 5 cents. I was also surprised when I found cpumask_any() nailed to the first
CPU. But for my use I found it beneficial.

Namely, all system IRQs and other events are targeted to the first CPU which is
considered as system maintenance unit. Other CPUs are dedicated to user-specific
payloads using task isolation. This approach improves latency a lot.

Systems that have many cores operating in idling/powersave mode probably benefit
from the state of things as well - they don't wake up sleeping cores and therefore
save power and improve IRQ turnaround.

Thanks,
Yury
 
