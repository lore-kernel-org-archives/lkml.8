Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1358CC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E32207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+GFjCJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgBTOgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:36:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37764 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgBTOgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:36:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id q23so4489103ljm.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNU2PjgDfv50dT32BqsNIp3wuvczGu9NfgNw5Wz+0pY=;
        b=o+GFjCJ7hMUVDSOpBiJKWaA9NbCQkUqFuTiC+7rEs4lsOxiAiKLDvclu8NqCUl4NZg
         8GzQARVM4I33hA4rnn9/xDyMzPxQBNrORgDkw89LYyMQUV2E+62HxTWdT5OTK+X4HULL
         cbp3+aCk1YQKSXavJUFGFtaTsLSVj6UI53Si6gIINGHz5xk92NSixehK6rCg3S1HKdv6
         pJKdnKYPKq8yt0UfP0COjU+G4ZmFECHbeSXmTLpvfgGMHE9vzehugxhn+gl9dKftFGQa
         j+sycNZjHbiEQjxD3YjzUoKTRQf5ixLGvbuQi0PdV3VlPWux4vDB/U7z4XfH8v5HnNT3
         pPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNU2PjgDfv50dT32BqsNIp3wuvczGu9NfgNw5Wz+0pY=;
        b=E7e5HzOTGqcMTIFy6DotpJ7pCD0cfYWWbXkypWq6xQ+oh34VuDB6F+M1dYrmBbdJAY
         /JW32FmZWfg4TEX8XkrEJVLDWllHZxAS9rFcwJz2Kn0FiQDmCPX08RRfhUOXxlCmDuic
         iXNFXF9hiSPr11DLdZRQNur39U1Gz+cMQXfswcKyXpOW020Ek1WKaWOx/gZnb8V0AtbR
         1/63rExVNA6v3mBjHbOq1ishSL44WgzvqhAXlE53fqQoUep84RtEOzojaQ2AocVmC8pD
         WCZC/dYmx8+9KGAu2RFcT24bvuJGPzwgsf7jsRwoR80UkRE+53XuowgZOz1cGnaNG/SR
         tzuw==
X-Gm-Message-State: APjAAAUJahoLTgdBqwvq8Rawu7kXlILg2xG4+W35X9ec+ewIiNGCZ2Rk
        zzv4bHvsl76zhzP1Ed1E7bCO02TU2sjLfDZ5TPqD6w==
X-Google-Smtp-Source: APXvYqxokDPlwsh1WzUxaMAfMxMZhvCJynmBZe9AcagF42QPDYs3BfRga2gIxxwJ9drBSa4wYh0x2xZaiIAn6pbPwNM=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr18113734ljg.154.1582209374674;
 Thu, 20 Feb 2020 06:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-5-vincent.guittot@linaro.org>
 <20200219125513.8953-1-vincent.guittot@linaro.org> <9fe822fc-c311-2b97-ae14-b9269dd99f1e@arm.com>
In-Reply-To: <9fe822fc-c311-2b97-ae14-b9269dd99f1e@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Feb 2020 15:36:02 +0100
Message-ID: <CAKfTPtD4kz07hikCuU2_cm67ntruopN9CdJEP+fg5L4_N=qEgg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] sched/pelt: Add a new runnable average signal
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 at 21:10, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 19/02/2020 12:55, Vincent Guittot wrote:
> > @@ -740,8 +740,10 @@ void init_entity_runnable_average(struct sched_entity *se)
> >        * Group entities are initialized with zero load to reflect the fact that
> >        * nothing has been attached to the task group yet.
> >        */
> > -     if (entity_is_task(se))
> > +     if (entity_is_task(se)) {
> > +             sa->runnable_avg = SCHED_CAPACITY_SCALE;
>
> So this is a comment that's more related to patch 5, but the relevant bit is
> here. I'm thinking this initialization might be too aggressive wrt load
> balance. This will also give different results between symmetric vs
> asymmetric topologies - a single fork() will make a LITTLE CPU group (at the
> base domain level) overloaded straight away. That won't happen for bigs or on
> symmetric topologies because
>
>   // group_is_overloaded()
>   sgs->group_capacity * imbalance_pct) < (sgs->group_runnable * 100)
>
> will be false - it would take more than one task for that to happen (due to
> the imbalance_pct).
>
> So maybe what we want here instead is to mimic what he have for utilization,
> i.e. initialize to half the spare capacity of the local CPU. IOW,
> conceptually something like this:
>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 99249a2484b4..762717092235 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -740,10 +740,8 @@ void init_entity_runnable_average(struct sched_entity *se)
>          * Group entities are initialized with zero load to reflect the fact that
>          * nothing has been attached to the task group yet.
>          */
> -       if (entity_is_task(se)) {
> -               sa->runnable_avg = SCHED_CAPACITY_SCALE;
> +       if (entity_is_task(se))
>                 sa->load_avg = scale_load_down(se->load.weight);
> -       }
>
>         /* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
>  }
> @@ -796,6 +794,8 @@ void post_init_entity_util_avg(struct task_struct *p)
>                 }
>         }
>
> +       sa->runnable_avg = sa->util_avg;
> +
>         if (p->sched_class != &fair_sched_class) {
>                 /*
>                  * For !fair tasks do:
> ---
>
> The current approach has the merit of giving some sort of hint to the LB
> that there is a bunch of new tasks that it could spread out, but I fear it
> is too aggressive.

I agree that setting by default to SCHED_CAPACITY_SCALE is too much
for little core.
The problem for little core can be fixed by using the cpu capacity instead

@@ -796,6 +794,8 @@ void post_init_entity_util_avg(struct task_struct *p)
                }
        }

+       sa->runnable_avg = cpu_scale;
+
        if (p->sched_class != &fair_sched_class) {
                /*
                 * For !fair tasks do:
>
> >               sa->load_avg = scale_load_down(se->load.weight);
> > +     }
> >
> >       /* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
> >  }
