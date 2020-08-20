Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B369620885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYASPIx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgHTVZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgHTVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:25:54 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE80C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:25:54 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y2so3722289ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qg7ruuG7drWC0btRbr1uOGU4H3EwWSnI1pvnZe6oIgQ=;
        b=WYASPIx5hMDjYGgzF+G0RR6vw6melkP0mguy36kGh/wXS2V3ohz4Yii1y0Dtu6iU+C
         lgRRuCa0Yz5B35a2ewWAKf33bxKi/ZqAeyD8rQWw85LdFb2z8gOVCfCrvbQvZJodRNNh
         93t7iBP1COzAj3azTPFpmNT9k287RMuDfF0QdK0dNPN9GZd/Pm2A1vVPjU1lJWZkZaHf
         nU6xPpk8TwGTW75Mc7AKO0NSOXk++jx1+LU8HnsQ1FWGYEidvRi3cymONp0dCcu0QeUG
         4+nCMyIA/qqZc1mDImkpEjw/YDWEjMczSHz8TTIH2lTkWLwJ5jB54ykxBxVdOEh8OdXx
         YVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qg7ruuG7drWC0btRbr1uOGU4H3EwWSnI1pvnZe6oIgQ=;
        b=Zk8YFnxQcxzPElEnJBhWQz/F6pn4xpAMh7yeDc+kKEatIaUUc9dOeKrFh6y3Exs1nG
         Fdl/rJf84SjvMToakXrbD6dk5/R355QsXDZh5nLFB0pwZOX6kOUrXQvvLLHoYPWSi2Z5
         BazD9R+GL3P/NmgmnKXUhTB8IrvMVOLkBVDgrq7j9Gx5H0ajxTQtwr4a6qEkwg0HkR0P
         x7IrlK9VY3u1KwduXEpepDnP0BV26dk5Upu3qoghKN+j4QaF41Gp8McLFAON/01vTL4u
         budBXzlNT/eRx4Z3eHSvCfLH/kMyuGGR1R0Zc+AEkEkFCggQ5cjLh0xEzknv7EqcKO7B
         VBsA==
X-Gm-Message-State: AOAM532dhqDoDbDRwRWa84zV2eZcaFlpoVaCj0xTPIQCVk0YW1oGZc02
        0O+9T7XPZc4vQQSZ6A9fsPRUmptb9yobwRW1wG2gyw==
X-Google-Smtp-Source: ABdhPJzqYADzY46O//FIwuGauKEriUJHxgBT1Pgq+Qn+KFzEpsr1NawCQfd1pK50vIf1JrU/YAnSLFtnkF/7XxmoXBo=
X-Received: by 2002:a2e:9396:: with SMTP id g22mr121322ljh.446.1597958752359;
 Thu, 20 Aug 2020 14:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200820130350.3211-1-longman@redhat.com> <20200820130350.3211-3-longman@redhat.com>
 <20200820173546.GB912520@cmpxchg.org> <a3d4783b-5aee-da40-06c0-ac63e292ccdb@redhat.com>
In-Reply-To: <a3d4783b-5aee-da40-06c0-ac63e292ccdb@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Aug 2020 14:25:41 -0700
Message-ID: <CALvZod6GARMuO8YzMp-1FZaasSZJ8t2b9dUu5tXUcDeuHxA6KA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/memcg: Simplify mem_cgroup_get_max()
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 1:29 PM Waiman Long <longman@redhat.com> wrote:
>
> On 8/20/20 1:35 PM, Johannes Weiner wrote:
> > On Thu, Aug 20, 2020 at 09:03:49AM -0400, Waiman Long wrote:
> >> The mem_cgroup_get_max() function used to get memory+swap max from
> >> both the v1 memsw and v2 memory+swap page counters & return the maximum
> >> of these 2 values. This is redundant and it is more efficient to just
> >> get either the v1 or the v2 values depending on which one is currently
> >> in use.
> >>
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> >> ---
> >>   mm/memcontrol.c | 14 +++++---------
> >>   1 file changed, 5 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index 26b7a48d3afb..d219dca5239f 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -1633,17 +1633,13 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
> >>    */
> >>   unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
> >>   {
> >> -    unsigned long max;
> >> +    unsigned long max = READ_ONCE(memcg->memory.max);
> >>
> >> -    max = READ_ONCE(memcg->memory.max);
> >>      if (mem_cgroup_swappiness(memcg)) {
> >> -            unsigned long memsw_max;
> >> -            unsigned long swap_max;
> >> -
> >> -            memsw_max = memcg->memsw.max;
> >> -            swap_max = READ_ONCE(memcg->swap.max);
> >> -            swap_max = min(swap_max, (unsigned long)total_swap_pages);
> >> -            max = min(max + swap_max, memsw_max);
> >> +            if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> >> +                    max += READ_ONCE(memcg->swap.max);
> >> +            else
> >> +                    max = memcg->memsw.max;
> > I agree with the premise of the patch, but v1 and v2 have sufficiently
> > different logic, and the way v1 overrides max from the innermost
> > branch again also doesn't help in understanding what's going on.
> >
> > Can you please split out the v1 and v2 code?
> >
> >       if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> >               max = READ_ONCE(memcg->memory.max);
> >               if (mem_cgroup_swappiness(memcg))
> >                       max += READ_ONCE(memcg->swap.max);
> >       } else {
> >               if (mem_cgroup_swappiness(memcg))
> >                       max = memcg->memsw.max;
> >               else
> >                       max = READ_ONCE(memcg->memory.max);
> >       }
> >
> > It's slightly repetitive, but IMO much more readable.
> >
> Sure. That makes it even better.
>

Can you please also add in the commit message why it is ok to drop
total_swap_pages comparison from mem_cgroup_get_max()?
