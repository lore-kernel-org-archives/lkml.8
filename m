Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C11FC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4A320706
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQmo4UiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgDXMrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgDXMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:47:40 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDBEC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:47:40 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k28so7565262lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26dzrYlw9Yt4KOLOThPZOKw0U2oq0zvdftZeS7P3BXg=;
        b=kQmo4UiCT4B6P4hn6/SMH8IwiW3tjCSbn+HojMSAv2mv+agfz+9+d/yNKIOUlamR1C
         oDB5kzLtpliREy8JhjWeOkdUyx2C8cBOFDRekdsGSlk8k5dscp/Lxlf6lZpn+aN4Essv
         b+jXsXV904YqN9dKa5Xl1kzPtb0yot90Elur9JDV9YlnX6+IcLbPhk0cxPEtwd9j9a1R
         TMTEsva4dggxnr5D3JEAokj/ChXI27kICmIpsa294YpmHi8yoRpqNXTMOVeWaNArDKcx
         PqtRpFXB9FTje0g3o26UxDIfwKXO9oy860k8+Urmejjwxxc++ujyOQnkBzm4Xok8FRzU
         KLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26dzrYlw9Yt4KOLOThPZOKw0U2oq0zvdftZeS7P3BXg=;
        b=GxUMTjVxm4Lb/K/jU7EXGlKXB22FXGVfQ4px5ULVtrrP9qPA5exrepSbpZN2QlsyJT
         UdKSDIA4fokS869JylNaS053KcYlQKlRhtyodNni3JzsouQ6eR1/VKPQGW0W91leBK+N
         QuG09MAFQpcV8lAwe35fdu7+dAp30+aK9MZU9Ix4fheTr6fKYZmh92R7txmBRAde0/CD
         JXloKf1CcbW+COcaSUBPUkMoav6Uuc+SAg4xep5Ma6K+rEPPOvEE4hzowAhM9CRaAXJ1
         vVEtQatGUBSuF7NsybLVZTqoEkNmQK1f6UoTans8XwiGJu0ChKaHhefzv80CcJJIwh5e
         UmNg==
X-Gm-Message-State: AGi0PuYaGt0KX3ceVIBTbS0jtVI1L88TSOmHxwNE6Xv/25nKu8Zv5zI6
        +Ak9lfTGQip8fRK4hu1v0CLNutA1TUwXxiUS0y3Snw==
X-Google-Smtp-Source: APiQypJctBqu0eb3YhmUg/LE+meu5E6yHAxgR0hbVxh/gpfMO8UpVk0E+o35JIkOIIK7RQBPaa9/Mhidm7bvOYLO+sQ=
X-Received: by 2002:ac2:5e65:: with SMTP id a5mr6077147lfr.189.1587732458716;
 Fri, 24 Apr 2020 05:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200422151401.9147-1-vincent.guittot@linaro.org>
 <23c1cbb8-7335-80ca-cf40-8abc5c1463f4@arm.com> <CAKfTPtD_W8DRmFS6xJUo+Yt=XaJgZmKxUzcCSnoLWNJN5xPFCw@mail.gmail.com>
 <5a105c97-4762-aa80-a816-c11c1b1f23f3@arm.com>
In-Reply-To: <5a105c97-4762-aa80-a816-c11c1b1f23f3@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 24 Apr 2020 14:47:26 +0200
Message-ID: <CAKfTPtAPaZ+8Q+=rYHeR=7tPgEa1PKgZoWFcqt=FxkU-wrwXMg@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: sync util/runnable_sum with PELT window when propagating
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 at 14:07, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 23/04/2020 18:17, Vincent Guittot wrote:
> > On Thu, 23 Apr 2020 at 16:30, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 22/04/2020 17:14, Vincent Guittot wrote:
>
> [..]
>
> >>     gcfs --> tg --> gse
> >>      ________________|
> >>      |
> >>      V
> >>
> >>     cfs ---> tg (root)
> >>
> >>      |
> >>      V
> >>
> >>     rq
> >>
> >
> > child cfs_rq aka gcfs_rq
> >   |
> > gse: group entity that represents child cfs_rq in parent cfs_rq
> >   |
> >   v
> > parent cfs_rq aka cfs_rq
>
> OK, I see. Maybe it's clearer to refer to child cfs_rq as gcfs_rq in
> this context.
>
> [...]
>
> >>>       /* Set new sched_entity's utilization */
> >>>       se->avg.util_avg = gcfs_rq->avg.util_avg;
> >>> -     se->avg.util_sum = se->avg.util_avg * LOAD_AVG_MAX;
> >>> +     se->avg.util_sum = se->avg.util_avg * divider;
> >>
> >> divider uses cfs_rq but we sync se->avg.util_avg with gcfs_rq here.
> >
> > we sync the util_avg of gse with the new util_avg of gcfs_rq but gse
> > is attached to cfs_rq and as a result we have to use cfs_rq's
> > period_contrib
>
> I agree.
>
> But the decay windows (avg.last_update_time, avg.period_contrib) of
> cfs_rq and gcfs_rq are not always aligned, I guess?
>
> I see they are not after the online_fair_sched_group() ->
> attach_entity_cfs_rq() but later the are in sync as well.

cfs_rq and gcfs_rq use 2 different clocks:
- cfs_rq_clock_pelt(cfs_rq)
- cfs_rq_clock_pelt(gcfs_rq)

And they can be different in some cases like cfs bandwidth

>
> I ran a couple of different rt-app taskgroup tests and try to
>
> BUG_ON(se->avg.period_contrib != gcfs_rq->avg.period_contrib);
> BUG_ON(se->avg.last_update_time != gcfs_rq->avg.last_update_time)
>
> in update_tg_cfs_util() but they didn't trigger so far.
>
> Both, cfs_rq and gcfs_rq are in sync in update_tg_cfs_util() before and
> during a task runs in gcfs_rq.
>
> Are there cases where this wouldn't necessary happen in
> update_tg_cfs_util(), maybe a more complicated testcase?
>
> >> But since avg.period_contrib of cfs_rq and gcfs_rq are the same this
> >> should work.
> >>
> >>>       /* Update parent cfs_rq utilization */
> >>>       add_positive(&cfs_rq->avg.util_avg, delta);
> >>> -     cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * LOAD_AVG_MAX;
> >>> +     cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
> >>
> >> Looks like that avg.last_update_time of se (group entity), it's gcfs_rq
> >> and cfs_rq is always the same in update_tg_cfs_[util\|runnable].
> >>
> >> So that means the PELT windows are aligned for cfs_rqs and group se's?
> >
> > We want to align util_avg with util_sum and period_contrib otherwise
> > we might have some unalignment. It's quite similarly to what is done
> > in attach_entity_load_avg()
>
> I agree.
>
> >> And if we want to enforce this for cfs_rq and task, we have
> >> sync_entity_load_avg().
> >
> > It's not a matter of syncing the last_update_time
>
> I agree, this is not what you want to achieve here.
> But syncing 'last_update_time' and 'period_contrib' is what I understand
> as aligning the decay window (like in attach_entity_load_avg()).
