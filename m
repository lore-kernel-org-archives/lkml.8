Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF07C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B642620657
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0KspSqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgESPlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgESPlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:41:47 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF60C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:41:47 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 202so11615002lfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0d43uTOdUMjo8+h/D8gql32mRU0y1WLhq8SXyWr0IXc=;
        b=W0KspSqbJ6Aj72DfmWtAWHU7VMWd90gATZqaAo/4cvA1YpTLHu3x7p4bkzAcjLaecr
         Ec7eCPkDgEVFv0Wem7uMj2a7aKEUpjEcYdMNfYPKUInU+vAUKoUKWNCA8zrJv7/cJXSm
         7qddQEmzn2pUKGjmJw/bd9hbWC4M59o0nIuOTMSqZ6mw9Kc0dN2eCoxVULJXA0+ogLK+
         4BMAw29cH29CrL8OJ3dv0Bzf4vfNQaIW8FjuLgbRGF93vIuRKDQnDeB+o4jHlWUBOF1b
         s8OqYHkaUCkH5tgFJ2r+iMJ55IMhxjrE3OeuNWJE5ZwQ/4MqJ09mRD16n6OvzqasQev9
         fPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0d43uTOdUMjo8+h/D8gql32mRU0y1WLhq8SXyWr0IXc=;
        b=H8gvCvwhm4ku10g90qNBCPRAWVQlk6k8XSe8hClaTs3RQcOL1usOMqIDQCNP9BW8s3
         Ucmml9aoDjFaYzRED1Okfy5MZ5x6PiiD98OVXFqFws1XIhIm3KYm/yxVanQ+2lcSBcHy
         Nn+WDiV79Yfyr6v+10gJXK/ktHQ1w20UguJKzHSUCex286XnakuNzq/sQq1JLxKvVjOs
         sOL8dgd9dUWR7uy8aiOpNvrO8aNVdH9cy7O80w9vDOmVyBQQKOUkOH5OIkGvMS2ncpeQ
         uhWf6J3/k90apB8Erm/jpA2/WUThstqg7xR0aZm+bebvj1OPA4tEargwUbtvbIpnSsDF
         FQsw==
X-Gm-Message-State: AOAM532V0Hg7ffU5vJGcrhBxxyYBX3AlCRgezDKAvv1H6CCRBfeX0PHc
        cyMPFb0Rv8LtU8NHlBG16/Wki5CnGTbDawtXFQrHyg==
X-Google-Smtp-Source: ABdhPJxpqURueWANIDMzW29s7P6vWansVCV4Mh3OJO30N8TKR9yc05pBBYd8/l5q2NntO3MMxGWTiC4sCRcG0bI92Hc=
X-Received: by 2002:a05:6512:6ca:: with SMTP id u10mr16149796lff.184.1589902905516;
 Tue, 19 May 2020 08:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200506155301.14288-1-vincent.guittot@linaro.org> <c1beb50b-d385-524b-56e0-eae16d3700df@arm.com>
In-Reply-To: <c1beb50b-d385-524b-56e0-eae16d3700df@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 19 May 2020 17:41:19 +0200
Message-ID: <CAKfTPtDLceotUW0ni=QhD9Z8cc7NA5Yz2vBJi+NjAVzYztrm+g@mail.gmail.com>
Subject: Re: [PATCH v2] sched/pelt: sync util/runnable_sum with PELT window
 when propagating
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

On Tue, 19 May 2020 at 12:28, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 06/05/2020 17:53, Vincent Guittot wrote:
>
> [...]
>
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 02f323b85b6d..df3923a65162 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3441,52 +3441,46 @@ static inline void
> >  update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
> >  {
> >       long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
> > +     /*
> > +      * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
> > +      * See ___update_load_avg() for details.
> > +      */
> > +     u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
>
> Why not doing the assignment (like in update_tg_cfs_load()) after the
> next condition? Same question for update_tg_cfs_runnable().

In fact, I expect the compiler to be smart enough to do this at the best place

>
> [...]
>
> >  static inline void
> >  update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
> >  {
> >       long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
> > +     /*
> > +      * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
> > +      * See ___update_load_avg() for details.
> > +      */
> > +     u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
>
> We know have 6 assignments like this in fair.c and 1 in pelt.c. Could
> this not be refactored by using something like this in pelt.h:
>
> +static inline u32 get_divider(struct sched_avg *avg)

That's a good point
I would add a pelt in the name like
static inline u32 get_pelt_divider(struct sched_avg *avg)

> +{
> +       return LOAD_AVG_MAX - 1024 + avg->period_contrib;
> +}
>
> [...]
>
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > index b647d04d9c8b..1feff80e7e45 100644
> > --- a/kernel/sched/pelt.c
> > +++ b/kernel/sched/pelt.c
> > @@ -237,6 +237,30 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
> >       return 1;
> >  }
> >
> > +/*
> > + * When syncing *_avg with *_sum, we must take into account the current
> > + * position in the PELT segment otherwise the remaining part of the segment
> > + * will be considered as idle time whereas it's not yet elapsed and this will
> > + * generate unwanted oscillation in the range [1002..1024[.
> > + *
> > + * The max value of *_sum varies with the position in the time segment and is
> > + * equals to :
> > + *
> > + *   LOAD_AVG_MAX*y + sa->period_contrib
> > + *
> > + * which can be simplified into:
> > + *
> > + *   LOAD_AVG_MAX - 1024 + sa->period_contrib
> > + *
> > + * because LOAD_AVG_MAX*y == LOAD_AVG_MAX-1024
>
> Isn't this rather '~' instead of '==', even for y^32 = 0.5 ?
>
> 47742 * 0.5^(1/32) ~ 47742 - 1024

With integer precision and the runnable_avg_yN_inv array, you've got
exactly 1024

>
>
> Apart from that, LGTM
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
