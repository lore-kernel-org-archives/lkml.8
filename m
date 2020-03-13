Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C047C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0040920770
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pc7WgZK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgCMRMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:12:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32994 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCMRMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:12:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id f13so11390594ljp.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9i1VcIGQBKvOT9Yd/IZFWMay3cd+gMILpeCF5u9rNvc=;
        b=pc7WgZK64lZOBYMpH2huzgvQuSv/xXu5TaxoHrzHo8o4Zu0s/Lw4cUh4rAVRMz2GCG
         fSo60DMjZCe4GHi59hv7tDNUYWWVoZhx+mrNVLCw4VL+F+4vQurXyb+oY4/H2AtI5JUY
         7hlRETqxdxpmDDd6bfpTYYZ/dlQlDWspIaqsmhJ67YvEEPZvSNYNoCF6CodTYpCw5J5s
         Ok3yl9a3t+9yD+3E9LqBmGzLuTThxR7DJN3Dw3JPtWR2iyWxVkxIB0BdWDCB1iv0T05U
         iTimEy8E9rwHRilHpum4z2fkh26yNEyxSzqYuVXnzCKL8bh49FOGl67S/o8tcydwDzUI
         Yxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9i1VcIGQBKvOT9Yd/IZFWMay3cd+gMILpeCF5u9rNvc=;
        b=HqBO4CIc0Io4MfLeJ3mF1xALwfJj77SCqyyOLEdDUBNajmm3PDjLJ2sbcKDftle/nV
         okY45MTumkdn1wGsKzq+TWUv3tEpPOcth7/z0eFugKtAsmlildr7oWVRStsoSUxRJuch
         3TMt7bPJu8HzpYRKSajcm4s2I295vI+uYwTAQ8PUr5vQS2Bibh4fqSa+P6LpKjeD3UBe
         VLfrhUPe1ekN7Xp0enH3c7FC3nEnlqlf+5PCLa8TaTLzNnnthOO5N6nplgR5lSf5x8TH
         cdUumP9usN3dxS7cFEGhbK0lwC7Ih4o9aaEScE1PYk4BPvQPdX4GCJEgXJ7sh8WG7H/Z
         SsAg==
X-Gm-Message-State: ANhLgQ3jD0rPRLkwIb/acHsyO4TqLCpZDQmPJD6HddC458laMa32WZPv
        BZW0SBVmvjffIOs3+L1K6PzN36vc/2yBhHVvGMLg3Q==
X-Google-Smtp-Source: ADFU+vvMkdn/Z6SXWMnRn56lxVUJvBZUPPixAsWHVkhD1jAz5V377OSR/2/BHS7iv73Koti454bE2jiGB5leiBwqPrs=
X-Received: by 2002:a2e:b5c3:: with SMTP id g3mr8650818ljn.151.1584119560282;
 Fri, 13 Mar 2020 10:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200312165429.990-1-vincent.guittot@linaro.org>
 <jhjr1xwjz96.mognet@arm.com> <CAKfTPtCQZMOz9HzdiWg5g9O+W=hC5E-fiG8YVHWCcODjFRfefQ@mail.gmail.com>
 <jhjpndgjxxk.mognet@arm.com> <jhj4kuspgse.mognet@arm.com> <CAKfTPtD67EKA46i12FHpJQT4gTzaH=ASAyb2dhv4=owPHBRSdQ@mail.gmail.com>
 <CAKfTPtBZgvTBYR+kYjj9dHq8_25mG19CZmYzY5s33ijSHdLGyQ@mail.gmail.com>
 <jhj36acp88q.mognet@arm.com> <CAKfTPtAMmYONX+qxp1Awj+XpqkWU3ootcyv7iar7e6z5nSczpw@mail.gmail.com>
 <jhj1rpwp4z1.mognet@arm.com>
In-Reply-To: <jhj1rpwp4z1.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Mar 2020 18:12:28 +0100
Message-ID: <CAKfTPtCopLDoUsC+Mt6k99Hdn52pcKkrNYQsYNRW5LdgyMg4Nw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: improve spreading of utilization
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 at 17:57, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On Fri, Mar 13 2020, Vincent Guittot wrote:
>
> >> Good point on the capacity reduction vs group_is_overloaded.
> >>
> >> That said, can't we also reach this with migrate_task? Say the local
> >
> > The test has only been added for migrate_util so migrate_task is not impacted
> >
> >> group is entirely idle, and the busiest group has a few non-idle CPUs
> >> but they all have at most 1 running task. AFAICT we would still go to
> >> calculate_imbalance(), and try to balance out the number of idle CPUs.
> >
> > such case is handled by migrate_task when we try to even the number of
> > tasks between groups
> >
> >>
> >> If the migration_type is migrate_util, that can't happen because of this
> >> change. Since we have this progressive balancing strategy (tasks -> util
> >> -> load), it's a bit odd to have this "gap" in the middle where we get
> >> one less possibility to trigger active balance, don't you think? That
> >> is, providing I didn't say nonsense again :)
> >
> > Right now, I can't think of a use case that could trigger such
> > situation because we use migrate_util when source is overloaded which
> > means that there is at least one waiting task and we favor this task
> > in priority
> >
>
> Right, what I was trying to say is that AIUI migration_type ==
> migrate_task with <= 1 running task per CPU in the busiest group can
> *currently* lead to a balance attempt, and thus a potential active
> balance.
>
> Consider a local group of 4 idle CPUs, and a busiest group of 3 busy 1
> idle CPUs, each busy having only 1 running task. That busiest group
> would be group_has_spare, so we would compute an imbalance of
> (4-1) / 2 == 1 task to move. We'll proceed with the load balance, but
> we'll only move things if we go through an active_balance.

yes because we want to even as much as possible the number of tasks per group

>
> My point is that if we prevent this for migrate_util, it would make
> sense to prevent it for migrate_task, but it's not straightforward since

hmm but we don't want to prevent this active balance for migrate_task
because of cases like the one you mentioned above.

we might consider to finally select a CPU with only 1 running task
with migrate_util if there is no other CPU with more than 1 task. But
this would complexify the code and I don't think it's possible because
migrate_util is used to pull some utilizations from an overloaded
group which must have a CPU with a waiting task to be overloaded.

> we have things like ASYM_PACKING.
>
> >>
> >> It's not a super big deal, but I think it's nice if we can maintain a
> >> consistent / gradual migration policy.
> >>
> >> >>
> >> >> > might be hard to notice in benchmarks.
