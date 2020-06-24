Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27390C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0DCE2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMmycSCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405052AbgFXQkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404287AbgFXQkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:40:46 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB9AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:40:46 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so3325850ljo.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XoshPN5XbNY/+bDsSl+mj1mYq+288SpY+RGYXvB3nH0=;
        b=pMmycSCX84fqEyPLDn/+dHMpgntzzHUBCeavTF1hHDXe/Ofh8IYS28Ect1EfNF5dtj
         omxIhxKzXsKKer8nb4qtBCSAKurhS8oimKsk/U/wXrMeICfM7U5eQesKDX+Q8spzpGhd
         Nn5fV0GQ+4Yv92E6oyupkCZWCJK68+o32RBssbNb75u7Vaa+8qe0bYB1tCgJUzcFxpPr
         sjSgRkyW2dvEt24cBgPv+VLe3fiGQP7Cf8vuZc78ddPjjqzssGxb2dhob9H+WhHqZKuI
         fSLD/wk/OrmqOp5c8oQuSS1daOhpK5YdOwhNHd5DDb2Qy/+D8yySjAuXP4q4BVz2i8EP
         8oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoshPN5XbNY/+bDsSl+mj1mYq+288SpY+RGYXvB3nH0=;
        b=CM9Q1OJAKgZmib2Y4cTabQvgcSDU4VgcJCjNgTsSI0GCmavWsBAsHoAHGTF+WZx1Qa
         1ZIgQ7Bncz3SeF6MvtUsIR2LLXohRRjzwbFn1h1JcN7Yk9w88z2rGecjoqx0rx6MSZul
         rLh1RHiM+duj7KGYH6m+QeJYoEbcaDMIvwC1dWhJR0EIyVuEAHMJH+bbteJJJixV9kdw
         TryzGkTYe0Dc4qq84TSsNxfyEpRosXG5zCEWVypuAD68NOZAktY51SaexMEKngUcET3U
         dDPRkgNdUcnNpa2sZgVXkjfo09ASw5IzJeDWv0PXMSVswhkEndEwbpx7XWE4bz2v6BcV
         teRg==
X-Gm-Message-State: AOAM532dS9ExJNsdqWUXleZ7ywpTZB9jAENEG2ubUqV3eeqzCIoPrZ+h
        sip2YJWmJqBslRloK+3y1C10SWJQA/SpNjPVO7AjYg==
X-Google-Smtp-Source: ABdhPJylJsOgRZ1W0W3lxH0cw1V11QYwBOxt57YCDB7bU98TxRoT39VpdFhDOmvf5DOD1I24j2QL5ofKrPaoiPhrsuk=
X-Received: by 2002:a2e:541e:: with SMTP id i30mr13415087ljb.156.1593016844467;
 Wed, 24 Jun 2020 09:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200624154422.29166-1-vincent.guittot@linaro.org> <jhj8sgcs9v7.mognet@arm.com>
In-Reply-To: <jhj8sgcs9v7.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 24 Jun 2020 18:40:32 +0200
Message-ID: <CAKfTPtC0ytqNmexVFm6kzTSpj3r0kiOxs5MtHMhvR5rJuiz_Jw@mail.gmail.com>
Subject: Re: [PATCH] sched/cfs: change initial value of runnable_avg
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 at 18:32, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 24/06/20 16:44, Vincent Guittot wrote:
> > Some performance regression on reaim benchmark have been raised with
> >   commit 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")
> >
> > The problem comes from the init value of runnable_avg which is initialized
> > with max value. This can be a problem if the newly forked task is finally
> > a short task because the group of CPUs is wrongly set to overloaded and
> > tasks are pulled less agressively.
> >
> > Set initial value of runnable_avg equals to util_avg to reflect that there
> > is no waiting time so far.
> >
> > Fixes: 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0424a0af5f87..45e467bf42fc 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -806,7 +806,7 @@ void post_init_entity_util_avg(struct task_struct *p)
> >               }
> >       }
> >
> > -     sa->runnable_avg = cpu_scale;
> > +     sa->runnable_avg = sa->util_avg;
>
> IIRC we didn't go for this initially because hackbench behaved slightly
> worse with it. Did we end up re-evaluating this? Also, how does this reaim

yes. hackbench was slightly worse and it was the only inputs at that
time, that's why we decided to keep the other init. Since, Rong
reported a significant regression for reaim which is fixed by this
patch

> benchmark behave with it? I *think* the table from that regression thread
> says it behaves better, but I had a hard time parsing it (seems like it got
> damaged by line wrapping)
>
> Conceptually I'm all for it, so as long as the tests back it up:
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>
> >
> >       if (p->sched_class != &fair_sched_class) {
> >               /*
>
