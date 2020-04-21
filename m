Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185E1C55185
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16762087E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZaH3atk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgDUN23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUN22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:28:28 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D792CC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:28:27 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z26so13954023ljz.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpOgd+6tBNR92ThUfOn8ssI33bmd2mNNbQ4Gq8e+gNY=;
        b=NZaH3atkU27z/iPaioAdL3OKPfIwH50RfopQgsIPOjhtuobequkDWTlhheAGtYr9IO
         8/v7+RatAeh9crYvxe1PFVVqHyD+br7d80G5AQV5LvIwiOJD1FZu7QYn7b45DJvytWrM
         LWReSUsl3XAlomw3nBivuVeg/DI/f0+ZX74ysCxikxSDB3QDbnuUo+x2v1Vi6Nbh67Gw
         YiU+SRFLsamW2vRPmPOg8lQ2E9XhkkokjiIDGgS1e6DCOkj+ozvmVY5f5dlbodV8YT9Z
         z5APRp1N8NGpL0jB3COf3NylYsE7veqGh0jDKmQnmvdkAmkWNWO36RuYQrJf6KscnrHk
         yhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpOgd+6tBNR92ThUfOn8ssI33bmd2mNNbQ4Gq8e+gNY=;
        b=V8N1F6DeG874+g3iVp4djaaXaQkQauouCPfnDCyvoTuuvvIodo8h+STmkrqtGHVsMy
         IkQrGMQbPVAnJOx0/l4+3wgYCERTnW2woMYAx0enwMI4A2jXuL7q+dBnemVLLp58v+rU
         20XWkgU818GxzuBL1yutQ9NuSyGK9cv5oKifjgPC3GIKQ4UhsM6KMi5aYdj1xvuo+2GS
         sXUFCEMxAeu6lJdDz1t0eC7i9mUUxzM9N6+dz+5dQKu4d4df7I5ttdwJW+aI8U4w8qDf
         rupWOxx4bnaCnuUDytOgvESKuOqIEZVfqDuNtSmr/NduEX3Tl1rIba5GmLR8NGFQUlAO
         wuiQ==
X-Gm-Message-State: AGi0Pub1f3iFW+9NeoNqNkMg8xCn8+lExf2KT3cCkFp69yjMuLpQ0heC
        X2ol1P0pyHmOif6gJP4GO3Mh5HHpbThjm5Yjwgxzeg==
X-Google-Smtp-Source: APiQypIUI4a1kX8xFJVSw9OW5Hjn1NpSMwaABa2/cdBVCpxsKxHPKfaKXD5B58yOMl9AM4j2nOPgV5R0yO9r5jSEQhE=
X-Received: by 2002:a2e:888e:: with SMTP id k14mr13381134lji.4.1587475706237;
 Tue, 21 Apr 2020 06:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150556.10920-1-qais.yousef@arm.com> <jhjh7xlvqqe.mognet@arm.com>
 <20200421121305.ziu3dfqwo7cw6ymu@e107158-lin.cambridge.arm.com> <jhjv9ltkmel.mognet@arm.com>
In-Reply-To: <jhjv9ltkmel.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Apr 2020 15:28:14 +0200
Message-ID: <CAKfTPtB9gYh_7qV0y_t7HRg7HOpYfkJ96fXCYFFTBmcJxnnXEA@mail.gmail.com>
Subject: Re: [PATCH 0/4] sched/rt: Distribute tasks in find_lowest_rq()
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 at 15:18, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 21/04/20 13:13, Qais Yousef wrote:
> > On 04/14/20 19:58, Valentin Schneider wrote:
> >>
> >> I'm a bit wary about such blanket changes. I feel like most places impacted
> >> by this change don't gain anything by using the random thing. In sched land
> >> that would be:
> >
> > The API has always been clear that cpumask_any return a random cpu within the
> > mask. And the fact it's a one liner with cpumask_first() directly visible,
> > a user made the choice to stick to cpumask_any() indicates that that's what
> > they wanted.
> >
> > Probably a lot of them they don't care what cpu is returned and happy with the
> > random value. I don't see why it has to have an effect. Some could benefit,
> > like my use case here. Or others truly don't care, then it's fine to return
> > anything, as requested.
> >
>
> Exactly, *some* (which AFAICT is a minority) might benefit. So why should
> all the others pay the price for a functionality they do not need?
>
> I don't think your change would actually cause a splat somewhere; my point
> is about changing existing behaviour without having a story for it. The
> thing said 'pick a "random" cpu', sure, but it never did that, it always
> picked the first.
>
> I've pointed out two examples that want to be cpumask_first(), and I'm
> absolutely certain there are more than these two out there. What if folks
> ran some performance test and were completely fine with the _first()
> behaviour? What tells you randomness won't degrade some cases?

I tend to agree that any doesn't mean random and using a random cpu
will create strange behavior

One example is the irq affinity on b.L system. Right now, the irq are
always pinned to the same CPU (the 1st one which is most probably a
Little) but with your change we can imagine that this will change and
might ever change over 2 consecutives boot if for whatever reason (and
this happen) the drivers are not probed in the same order . At the end
you will run some tests with irq on little and other time irq on big.
And more generally speaking and a SMP system can be impacted because
the irq will not be pinned to the same CPU with always the same other
irqs

>
> IMO the correct procedure is to keep everything as it is and improve the
> specific callsites that benefit from randomness. I get your point that

I agree with this point

> using cpumask_any() should be a good enough indicator of the latter, but I
> don't think it can realistically be followed. To give my PoV, if in the
> past someone had used a cpumask_any() where a cpumask_first() could do, I
> would've acked it (disclaimer: super representative population of sample
> size = 1).
>
> Flipping the switch on everyone to then have a series of patches "oh this
> one didn't need it", "this one neither", "I actually need this to be the
> first" just feels sloppy.
>
> > I CCed Marc who's the maintainer of this file who can clarify better if this
> > really breaks anything.
> >
> > If any interrupt expects to be affined to a specific CPU then this must be
> > described in DT/driver. I think the GIC controller is free to distribute them
> > to any cpu otherwise if !force. Which is usually done by irq_balancer anyway
> > in userspace, IIUC.
> >
> > I don't see how cpumask_any_and() break anything here too. I actually think it
> > improves on things by better distribute the irqs on the system by default.
> >
>
> As you say, if someone wants smarter IRQ affinity they can do irq_balancer
> and whatnot. The default kernel policy for now has been to shove everything
> on the lowest-numbered CPU, and I see no valid reason to change that.
