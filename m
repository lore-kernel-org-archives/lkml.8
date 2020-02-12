Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2752EC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28702082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jb9F5htF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLQOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:14:10 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40511 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLQOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:14:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18so2964223ljo.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 08:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tcKPeVamvtlrN5RSH/6sRJOKOPqbnT+njiiXrnR2FE=;
        b=jb9F5htF3IHR2jF/s4ghJMuM4i/gcB51R39jS5/m6WKp+ydkzJfT04xG0Y73Oniy8v
         jXGY43W6LFKq1WsCfGVnTUgql5Rsoi8rTm4OjnsgouvKM528XjRv++J5z1ktbgXnaxjv
         DcdZO4N2qO2UIpsJgNlJN9HHASvrhD4jKNE1l9FpLfdA3+XV2xYgVqd/t3Pl9dU3lHUO
         NS2U6ybhnLxXAz5twY0Rw/BH05pfjJBJ8//FsvaNitbvsCdeMdaS6n1tgQUbqexBs4l4
         GZp6UB6wHhoUEuC7NODSQJ6S00E67Bc2jXKNcueGfK599Evvdl26IRjAXjPN52010wEr
         DycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tcKPeVamvtlrN5RSH/6sRJOKOPqbnT+njiiXrnR2FE=;
        b=Q+6a+xNnF/PwNJWvhqkTxWLllIzvWllTVJxQYxwryNjN9bZMDN7id65mCYEXsgxOX8
         C3Cj/ZGCC2FxK3WQmxbyljEqWRu9Q9b+F3AUIYVpiUaHXm37kEx3xYdKaAal4F+SeKht
         zWuGnPL0ra5Kpa3PICofmXQlzSAp5BfT3GYvQMmpwltwxiOHB5Q6YZuudhyT1gSo9sOG
         GAC1hIvVUo533k9BWSUUOT8oLEs6dUO2DEwU4f6HNtSGnp9FNf+440I0EyygITbz16iD
         54f9JiJvuuAtW73/PcQrKzXlvrPMbM6zJ8yGONv+e+ISzQ4uFhcz0zeY6YdW/EOdAcZA
         gX6Q==
X-Gm-Message-State: APjAAAVom6smp3nUeceEjo4OymWH//xWfZwvcyyS28D1bxM09aMDJqlN
        A5/U2R80u7k1dEs6qfDSdSFj/cnt3DmHLmMDhrRu1g==
X-Google-Smtp-Source: APXvYqwUx2RtHdSeOxuAp36dMrleO/imyGInK7FYFJk2eU3wiQYyWc47tYUJS8FHowdnJCYuUNb8GkPXTepYvI4Y9gQ=
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr8306485ljj.4.1581524046440;
 Wed, 12 Feb 2020 08:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20200212093654.4816-1-mgorman@techsingularity.net>
 <CAKfTPtA7LVe0wccghiQbRArfZZFz7xZwV3dsoQ_Jcdr4swVWZQ@mail.gmail.com> <20200212154850.GQ3466@techsingularity.net>
In-Reply-To: <20200212154850.GQ3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 12 Feb 2020 17:13:55 +0100
Message-ID: <CAKfTPtDG+nxaBQFubfHC_LGxPwtJcR3xY5oS4-i-SkqrvPSwcw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Reconcile NUMA balancing decisions with the
 load balancer
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 at 16:48, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Feb 12, 2020 at 02:22:03PM +0100, Vincent Guittot wrote:
> > Hi Mel,
> >
> > On Wed, 12 Feb 2020 at 10:36, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > The NUMA balancer makes placement decisions on tasks that partially
> > > take the load balancer into account and vice versa but there are
> > > inconsistencies. This can result in placement decisions that override
> > > each other leading to unnecessary migrations -- both task placement and
> > > page placement. This is a prototype series that attempts to reconcile the
> > > decisions. It's a bit premature but it would also need to be reconciled
> > > with Vincent's series "[PATCH 0/4] remove runnable_load_avg and improve
> > > group_classify"
> > >
> > > The first three patches are unrelated and are either pending in tip or
> > > should be but they were part of the testing of this series so I have to
> > > mention them.
> > >
> > > The fourth and fifth patches are tracing only and was needed to get
> > > sensible data out of ftrace with respect to task placement for NUMA
> > > balancing. Patches 6-8 reduce overhead and reduce the changes of NUMA
> > > balancing overriding itself. Patches 9-11 try and bring the CPU placement
> > > decisions of NUMA balancing in line with the load balancer.
> >
> > Don't know if it's only me but I can't find patches 9-11 on mailing list
> >
>
> I think my outgoing SMTP must have decided I was spamming. I tried
> resending just those patches.

I received them.
Thanks

>
> At the moment, I'm redoing a series in top of tip taking the tracing
> patches, yours on top (for testing) and the minor optimisations to see
> what that gets me.  The reconcilation between NUMA balancing and load
> balancing (patches 9-11) can be redone on top if the rest look ok.
>
> --
> Mel Gorman
> SUSE Labs
