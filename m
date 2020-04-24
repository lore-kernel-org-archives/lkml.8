Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C873C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520E420724
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vG3Tba0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDXHhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgDXHhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 03:37:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE3C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 00:37:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u6so8907299ljl.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 00:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLztsNgz+yDmFwrJSEWxjw2PGBak7jDN9usH+ekj5oQ=;
        b=vG3Tba0LZyMh1SR/tCXrhESk2NYX8j3gCf/tTrJvvfw9Tv8zrwPYauH7OwrG/6B5nX
         pqNUIGvdLw6lePetGwZO/9fdPZCJ46bYZqJexwgiVTb+Mr6J4sZrCehygMwtebZTZ4qF
         JbDVgMnmOnWBNNiHP3vKxPwgxYC8+uD9qS8eIQCRX03OHb7mYMHRC7IgLhArGgjFjtny
         vC8aBP/ndPKxDycTkssEc0ZX8n5Kgbrsu5ae5B5TXUtxBWveybp/nTXO3enGuExa96M9
         gaD3WYFL1Uv3D2OSUiXINBQdophS00rc/GI8EP6TD3djGQa/AW4CsivoaBx9Iuc7Cdpv
         rSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLztsNgz+yDmFwrJSEWxjw2PGBak7jDN9usH+ekj5oQ=;
        b=UgZS+fjWmb84amhBhNhIPRYgHqL3qI0pzgY7pWiWKuOUP7QHuVYF/aXocXwPKViu4a
         51uugmtx70AJQBodJNSqvbsChvTyxfTY+RLvlhZPwntAE7/SSUzwRUSoi2ttHAnSkt1C
         PEQx5/A8UR89qyDcTDj1OUWR3wh+UUAtgVgOdxrL6bEtMPFN/qmUoXwBeifcjOTzVt7C
         LQ+rwtYZ79tO3BWsZ0oYs1uktAffcBNKbP8ezSq3vcgBhYntpPZ/5RQQlJSpSF/HdMwl
         0Td9erMWTLX0zZ13bR7JGUOixpV21N2VH9C0HV/6jnoXzpAcn6gRTvvRR1SlJrHaiqBd
         SVLA==
X-Gm-Message-State: AGi0PuaWMyyfCqBjRpV8QmTF2DSQENCYqWzguaeArMAKndix4jwl93JF
        I9ZGQCO2dr/JieLbVPsCd60aoipt+IB2qSIV/Mt15w==
X-Google-Smtp-Source: APiQypIh3F8fsJ6XUYlv4PD/MpwuxYSHxkESJukFjBGHuCyxinHPJ6CkWWZNRcLGKqyQ2f3UfWJ7ajoXzlupFu4ICv8=
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr4734191ljp.209.1587713862987;
 Fri, 24 Apr 2020 00:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200422151401.9147-1-vincent.guittot@linaro.org> <20200423192930.GY2483@worktop.programming.kicks-ass.net>
In-Reply-To: <20200423192930.GY2483@worktop.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 24 Apr 2020 09:37:31 +0200
Message-ID: <CAKfTPtBUtK1c2WvE82k1bpS6hWECBs25rRc6t_6gyeJWRaF8uA@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: sync util/runnable_sum with PELT window when propagating
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 at 21:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 22, 2020 at 05:14:01PM +0200, Vincent Guittot wrote:
> > update_tg_cfs_util/runnable() propagate the impact of the attach/detach of
> > an entity down into the cfs_rq hierarchy which must keep the sync with
> > the current pelt window.
> >
> > Even if we can't sync child rq and its group se, we can sync the group se
> > and parent cfs_rq with current PELT window. In fact, we must keep them sync
> > in order to stay also synced with others se and group se that are already
> > attached to the cfs_rq.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 26 ++++++--------------------
> >  1 file changed, 6 insertions(+), 20 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 02f323b85b6d..ca6aa89c88f2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3441,52 +3441,38 @@ static inline void
> >  update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
> >  {
> >       long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
> > +     u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
> >
> >       /* Nothing to update */
> >       if (!delta)
> >               return;
> >
> > -     /*
> > -      * The relation between sum and avg is:
> > -      *
> > -      *   LOAD_AVG_MAX - 1024 + sa->period_contrib
> > -      *
> > -      * however, the PELT windows are not aligned between grq and gse.
> > -      */
>
> Instead of deleting this, could we perhaps extend it?

In fact, this is not the only place in fair.c that uses this rule to
align _avg and _sum but others don't have any special comment.

I can add a more detailed description of this relation for
___update_load_avg() in pelt.c and make a ref to this in all places in
fair.c that use this rule which are :
- update_tg_cfs_util
- update_tg_cfs_runnable
- update_cfs_rq_load_avg
- attach_entity_load_avg
- reweight_entity
