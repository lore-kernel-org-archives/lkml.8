Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662F0C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFBB20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pzVuvMn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgDXIyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgDXIyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:54:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78243C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:54:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e25so9135704ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9GVRv0tnUdcMYO9fvfgPggeotX0hi2sOna3pg9qtgY=;
        b=pzVuvMn8n8cfZc6G6azqoFMWCttVgAwxmVwcKSmHy6O4gmhraag3P+Vn4adAOgMs5Y
         0sbCNc5BEOsGuVxfhEnBQAxDk+kQgav53Ls7LiaqAkve+ulCU5cRToMSrbMwiHOfz5jx
         aljnokXRVFT2do27LeSKiPuvb5AVVnRSKkZsYujO8DAESV9uUxIU33M9+yDanUtotmlq
         asXOcToOsKJpCVhd8UqPdYHNH88u0+CmqAqe5m03/Zgo2NSo3m9ow+ivntgQyZHRuKhx
         vTQPVr+oZFQrBN0tGWF9nt69crD4UfrL0QN/5Z+vxjhTYvIiSYKDjxt4cYH6snRpaL3G
         tGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9GVRv0tnUdcMYO9fvfgPggeotX0hi2sOna3pg9qtgY=;
        b=Pfdq3PscUfBskR3Ef7Ke7aCvKHs2/Y4wXDdjf+dd32lUIdsWxMy1ZFDR9yF+HO/z+R
         m7Ny8nusZ/MBgwzzW5Yfb7tNSmZskdANNXiDegeC+5F3qhFlF2lRH9Z8X9UwdWNj21yD
         ffD12zBYPrzJiglk5yy5/TNmvrhYADxqjr2z3mTBVy2TvHhod2iUE1fnFTjNVOl+e4uc
         AYMu3SsdZ4JKLLvnW0OW8AsJvo0D51TjSmqjZ4Ygvl6LYkVFYTd+cwcAgrJ48ezHJisO
         lHzSScbqvXaqQFKstbGHH643fzhbQBzFfdIfhEVmn/rJe/vwXpy5C1VgLrMHAY8WEfad
         hfCA==
X-Gm-Message-State: AGi0PuaoPvdtI4kqtrvyryD4ZS4vHLSVzDffFk64YBf8W1xnl+mlry8m
        R+jZvgA7Hxva25EQOFBF8jD7hShpXS6g51IANoQU/g==
X-Google-Smtp-Source: APiQypLC8TwTBaqf+1fLNT7NizoZUzhAgq6Q0YB61UDIdJEjhg88McvFmEdQxVRpRxriP4elNdnuAgQNrOuZlkhkHac=
X-Received: by 2002:a2e:740f:: with SMTP id p15mr4178712ljc.151.1587718459820;
 Fri, 24 Apr 2020 01:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200422151401.9147-1-vincent.guittot@linaro.org>
 <20200423192930.GY2483@worktop.programming.kicks-ass.net> <CAKfTPtBUtK1c2WvE82k1bpS6hWECBs25rRc6t_6gyeJWRaF8uA@mail.gmail.com>
 <206b1f00-bb96-5e7f-f80a-b10cd88c8a71@arm.com>
In-Reply-To: <206b1f00-bb96-5e7f-f80a-b10cd88c8a71@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 24 Apr 2020 10:54:08 +0200
Message-ID: <CAKfTPtB4Uf7PbRdrqLm8vMy-UfYhQV_SgFSKCP2QOyvxSqLtqg@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: sync util/runnable_sum with PELT window when propagating
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 at 10:41, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 24/04/2020 09:37, Vincent Guittot wrote:
> > On Thu, 23 Apr 2020 at 21:29, Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Wed, Apr 22, 2020 at 05:14:01PM +0200, Vincent Guittot wrote:
> >>> update_tg_cfs_util/runnable() propagate the impact of the attach/detach of
> >>> an entity down into the cfs_rq hierarchy which must keep the sync with
> >>> the current pelt window.
> >>>
> >>> Even if we can't sync child rq and its group se, we can sync the group se
> >>> and parent cfs_rq with current PELT window. In fact, we must keep them sync
> >>> in order to stay also synced with others se and group se that are already
> >>> attached to the cfs_rq.
> >>>
> >>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>> ---
> >>>  kernel/sched/fair.c | 26 ++++++--------------------
> >>>  1 file changed, 6 insertions(+), 20 deletions(-)
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 02f323b85b6d..ca6aa89c88f2 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -3441,52 +3441,38 @@ static inline void
> >>>  update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
> >>>  {
> >>>       long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
> >>> +     u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
> >>>
> >>>       /* Nothing to update */
> >>>       if (!delta)
> >>>               return;
> >>>
> >>> -     /*
> >>> -      * The relation between sum and avg is:
> >>> -      *
> >>> -      *   LOAD_AVG_MAX - 1024 + sa->period_contrib
> >>> -      *
> >>> -      * however, the PELT windows are not aligned between grq and gse.
> >>> -      */
> >>
> >> Instead of deleting this, could we perhaps extend it?
> >
> > In fact, this is not the only place in fair.c that uses this rule to
> > align _avg and _sum but others don't have any special comment.
> >
> > I can add a more detailed description of this relation for
> > ___update_load_avg() in pelt.c and make a ref to this in all places in
> > fair.c that use this rule which are :
> > - update_tg_cfs_util
> > - update_tg_cfs_runnable
> > - update_cfs_rq_load_avg
> > - attach_entity_load_avg
> > - reweight_entity
>
> But IMHO the
>
> "* however, the PELT windows are not aligned between grq and gse."
>
> should only apply to update_tg_cfs_util() and update_tg_cfs_runnable().
> And attach_entity_load_avg() (for cfs_rq and se).
>
> They seem to be special since we derive divider from a cfs_rq PELT value
> and use it for a se PELT value.

hmmm... There is nothing special here.

When se is attached to cfs_rq, they both have the same divider because
they use the same clock.

>
> I assume this fact is specifically worth highlighting with a comment. I
> mean the fact we can do this because the decay windows are actually aligned.
