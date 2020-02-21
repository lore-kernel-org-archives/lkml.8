Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05580C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93152067D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VgMcsDTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgBUI4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:56:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45803 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgBUI4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:56:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id e18so1346524ljn.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 00:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Svypjvy2UZNno/1cMDgFktputdE7RJsU9QZEtR8/pZM=;
        b=VgMcsDTdKVJcnFKGkUOW2mfFv22Gwkw27lKwgL1Kienz7zftcpFzN2A18juJ8D2Cw7
         FjhI4shpHMxqRangwynFGoEpX6R33NMJcGpi5uIRfhowZG4glWzs01yerh6Dtsadk9NA
         pyAuAm7klnSfCKUKpWxPnqxt/8VpSMEctw0fV6leDA7vEO1T0qhRy8DHU2z5y5pGix4/
         7KSPvsj4eCjpshuk9e3HPbd8hSwv56iTitKCk1RHtCMNy6UXZebtrAhDjZ2lcn30gvOW
         rsJi62ccjK39TUMREQVw5IZ6eEzZvlCpLciV88YiEOAcXSJSDkd7hmHT0GCXHd8P2kuD
         +WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Svypjvy2UZNno/1cMDgFktputdE7RJsU9QZEtR8/pZM=;
        b=IbZBOQ8rVJ4guRupTIW6g1zQuUI/8c8nK+a5r/7JrA3/ZaBTfxXg4Ijfq84wXvKLD3
         lc5NjjcF4RMtQvaSt74RL2IcD2s9hImOD4ZbsaAZd69ZKIN9THF1DUp3/VzeiSZfvHpD
         p3q6J4wmNjDFfr3E1eLYXyjybY7APymcQVnueyyUWRy5JS6GRyY5Y11ghH9KvE1C5J8D
         iCTUB79CpvvIJ6Ug/nO/uD/LHOw24diXHAtQUlAfHLDFlqSB/vJc/HI56PNtT/oe+zwJ
         KBOMAfK7xeHmhIvDsImDWMvwTGQ4k907wzPQa4FI+An2AbWHTFTDo7L13mPsLgAHtDCp
         Wpaw==
X-Gm-Message-State: APjAAAVgjQR8koQumkJPufs8vY8bDiA0gBMC6VRxOzcx45WN5FKwfmzD
        YRVQmkwuTCZhqFlRVDojQCiaF5kdqKjqIsUBR7xblQ==
X-Google-Smtp-Source: APXvYqxfxoFP8x91+J1mmeOGslBwmvMwE1BggW+LcwTJJx0btrjPjfv120D1iNr4ZSiWFSU2woeR/wb4PZobxBzxgmo=
X-Received: by 2002:a2e:8699:: with SMTP id l25mr20628240lji.137.1582275388201;
 Fri, 21 Feb 2020 00:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-5-vincent.guittot@linaro.org>
 <20200219125513.8953-1-vincent.guittot@linaro.org> <9fe822fc-c311-2b97-ae14-b9269dd99f1e@arm.com>
 <CAKfTPtD4kz07hikCuU2_cm67ntruopN9CdJEP+fg5L4_N=qEgg@mail.gmail.com> <d9f78b94-2455-e000-82bd-c00cfb9bbc8e@arm.com>
In-Reply-To: <d9f78b94-2455-e000-82bd-c00cfb9bbc8e@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Feb 2020 09:56:16 +0100
Message-ID: <CAKfTPtAQ_09wVM7zjrHDB+gJXpb5OH6CBvfKC7OB_Bo0Hd41vA@mail.gmail.com>
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

On Thu, 20 Feb 2020 at 17:11, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 20/02/2020 14:36, Vincent Guittot wrote:
> > I agree that setting by default to SCHED_CAPACITY_SCALE is too much
> > for little core.
> > The problem for little core can be fixed by using the cpu capacity instead
> >
>
> So that's indeed better for big.LITTLE & co. Any reason however for not
> aligning with the initialization of util_avg ?

The runnable_avg is the unweighted version of the load_avg so they
should both be sync at init and SCHED_CAPACITY_SCALE is in fact the
right value. Using cpu_scale is the same for smp and big core so we
can use it instead.

Then, the initial value of util_avg has never reflected some kind of
realistic value for the utilization of a new task, especially if those
tasks will become big ones. Runnable_avg now balances this effect to
say that we don't know what will be the behavior of the new task,
which might end up using all spare capacity although current
utilization is low and CPU is not "fully used". In fact, this is
exactly the purpose of runnable: highlight that there is maybe no
spare capacity even if CPU's utilization is low because of external
event like task migration or having new tasks with most probably wrong
utilization.

That being said, there is a bigger problem with the current version of
this patch, which is that I forgot to use runnable in
update_sg_wakeup_stats(). I have a patch that fixes this problem.

Also, I have tested both proposals with hackbench on my octo cores and
using cpu_scale gives slightly better results than util_avg, which
probably reflects the case I mentioned above.

grp     cpu_scale            util_avg               improvement
1       1,191(+/-0.77 %)     1,204(+/-1.16 %)       -1.07 %
4       1,147(+/-1.14 %)     1,195(+/-0.52 %)       -4.21 %
8       1,112(+/-1,52 %)     1,124(+/-1,45 %)       -1.12 %
16      1,163(+/-1.72 %)     1,169(+/-1.58 %)       -0,45 %

>
> With the default MC imbalance_pct (117), it takes 875 utilization to make
> a single CPU group (with 1024 capacity) overloaded (group_is_overloaded()).
> For a completely idle CPU, that means forking at least 3 tasks (512 + 256 +
> 128 util_avg)
>
> With your change, it only takes 2 tasks. I know I'm being nitpicky here, but
> I feel like those should be aligned, unless we have a proper argument against

I don't see any reason for keeping them aligned

> it - in which case this should also appear in the changelog with so far only
> mentions issues with util_avg migration, not the fork time initialization.
>
> > @@ -796,6 +794,8 @@ void post_init_entity_util_avg(struct task_struct *p)
> >                 }
> >         }
> >
> > +       sa->runnable_avg = cpu_scale;
> > +
> >         if (p->sched_class != &fair_sched_class) {
> >                 /*
> >                  * For !fair tasks do:
> >>
> >>>               sa->load_avg = scale_load_down(se->load.weight);
> >>> +     }
> >>>
> >>>       /* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
> >>>  }
