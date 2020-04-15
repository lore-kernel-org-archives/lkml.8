Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A85C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DAAF206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fg67SeEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416122AbgDOQcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416090AbgDOQcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:32:04 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1BAC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:32:02 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id a10so1542691uad.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmoc5zikups2YB0r+vesjserrrGc5wDVV4y8pgXM4+w=;
        b=fg67SeErN3cfY6wJJvBR9ZhgLtFwBcITGGWV1dtc22ncPaPxfoSqiLZ7qVBsuGFM+w
         ZUz497QbcxmBk3Y/B5BKVINvOOAlgqaTT07aYRt2JjtgruP7lpq1ooFfq4zcdOwy4q2C
         9Id82wAk2bBqnJ9ezgMnECpedABRDfcUEtgdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmoc5zikups2YB0r+vesjserrrGc5wDVV4y8pgXM4+w=;
        b=MjWLMFA74O2f/C8je45YGZJ4PoQm33sK4vsENN6SVCQqgozFM/QCuFmphBeGvT2Qfo
         Hl2nUHaVtwrKAf1aU9NaA3Zuiv7BJJXmHfRGfXTq8laocTgYtxCVIUxRvpGiHkqYAGsy
         C4mj9E/X5na0d49aXnUWPLtEaSg0aXLLva5EERDiUVSwvNEKV04we995SyalELjB0PhP
         BJ8+ndQ6XAWwwmh145zMrQocZqaAbsTfPHdT+GikkU+C87eVmHGpsxmaP9y96cSPh+/q
         dRntMXmUceKHjip+wrX67vNZ9dQBPzH4RciH0CppDs2X3mfDrDJE+Hc6adj+xz2xKlBo
         L08Q==
X-Gm-Message-State: AGi0PuYrzLHDmL7GLoRozcTsXIwhkj5Ue5Sq9PJVP/6mLJoNo+EfmSK4
        yRnuNeJMZJiM2mIOz1Tk7Hyqt+DCwmM=
X-Google-Smtp-Source: APiQypJtK3VBpec75sy6s+fb5cfNrwWaSxcmGyHo3xNaSEqV1hzxWKU/vkFOL6y0NV5/PIZFa2PxmQ==
X-Received: by 2002:ab0:b13:: with SMTP id b19mr5177776uak.91.1586968320884;
        Wed, 15 Apr 2020 09:32:00 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id r188sm2211440vsb.20.2020.04.15.09.31.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 09:32:00 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id k19so251788vsm.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:31:59 -0700 (PDT)
X-Received: by 2002:a67:7141:: with SMTP id m62mr5268042vsc.73.1586968319284;
 Wed, 15 Apr 2020 09:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200414161320.251897-1-qperret@google.com> <CAD=FV=Vo4h43vS1K1+ziAJhQ3UG+Zrx8JN8Q1tkMWU1Oh6OavA@mail.gmail.com>
 <20200415082001.GA256573@google.com>
In-Reply-To: <20200415082001.GA256573@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Apr 2020 09:31:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UB7OZzQO46dV7KOHGqRkgbtaSgLfq55yddyx0L_e37Fg@mail.gmail.com>
Message-ID: <CAD=FV=UB7OZzQO46dV7KOHGqRkgbtaSgLfq55yddyx0L_e37Fg@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Fix reset-on-fork from RT with uclamp
To:     Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        ctheegal@codeaurora.org, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 15, 2020 at 1:20 AM Quentin Perret <qperret@google.com> wrote:
>
> Hi Doug,
>
> On Tuesday 14 Apr 2020 at 13:45:03 (-0700), Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Apr 14, 2020 at 9:13 AM Quentin Perret <qperret@google.com> wrote:
> > >
> > > uclamp_fork() resets the uclamp values to their default when the
> > > reset-on-fork flag is set. It also checks whether the task has a RT
> > > policy, and sets its uclamp.min to 1024 accordingly. However, during
> > > reset-on-fork, the task's policy is lowered to SCHED_NORMAL right after,
> > > hence leading to an erroneous uclamp.min setting for the new task if it
> > > was forked from RT.
> > >
> > > Fix this by removing the unnecessary check on rt_policy() in
> > > uclamp_fork() as this doesn't make sense if the reset-on-fork flag is
> > > set.
> > >
> > > Reported-by: Chitti Babu Theegala <ctheegal@codeaurora.org>
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  kernel/sched/core.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 3a61a3b8eaa9..9ea3e484eea2 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -1234,10 +1234,6 @@ static void uclamp_fork(struct task_struct *p)
> > >         for_each_clamp_id(clamp_id) {
> > >                 unsigned int clamp_value = uclamp_none(clamp_id);
> > >
> > > -               /* By default, RT tasks always get 100% boost */
> > > -               if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> > > -                       clamp_value = uclamp_none(UCLAMP_MAX);
> > > -
> > >                 uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
> >
> > The local variable "clamp_value" doesn't have a lot of value anymore,
> > does it?  (Pun intended).
>
> :)
>
> > Remove it?
>
> Right, but I figured the generated code should be similar, and
> 'uclamp_se_set(&p->uclamp_req[clamp_id], uclamp_none(clamp_id), false);'
> doesn't fit in 80 cols at this identation level, so I kept the local
> var. No strong opinion, though.

OK.  It's definitely a bikeshed color issue and since you'll spend
more time in this bikeshed than I will I'll leave it to you to pick
the color.

I'm not at all an expert on this code but it sure looks sane to me.
If you think my review tag is worth anything in this context feel free
to add it, but since you already have Patrick's mine probably adds
very little value.

-Doug
