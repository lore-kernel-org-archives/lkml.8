Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6039C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21A524676
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbjABa6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgBMQio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:38:44 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33177 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgBMQio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:38:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so7371929lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rp8g8WQQ3U+cXy6ejqXKIY11jw9YGGZz9TGQWvFpfQ4=;
        b=vbjABa6prCK0lgoZbrTnNGzqy6al9K91SM25MQ6F/I9AEU+4GzJN1pbPRtVOQbEIA3
         Ijy3cIgD2LEi23+b5pDsaT/V1YdDATW0nNnWgl50RIu0HPOGSRy4IzF+dnyKiFlWeHG1
         6zeKLPkNx5AGf30aoU4OPEUmDByNSGNCsW1a/HUMyAoOk7a71KzwLyQujNRZnl1tdTdF
         E31tS6fTxZf7j0eMCmGSQxM0clnZnINqyY+StTEVSxA4w3eDua15HeFl+PRhCQAD3dsE
         iqKvS0AVwE71bV6HaU+nBRIqByt/ksch0eWebByTdKHRFFPizQATIn/mlZXoZGZ4S9Yf
         JXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rp8g8WQQ3U+cXy6ejqXKIY11jw9YGGZz9TGQWvFpfQ4=;
        b=YZfmBdGoODEdfHTtBdDzu2JOhx7TIj8WCMqcg03dvMiXYJrtddY0zzdU+b163mTRvY
         cxUQneoB61eax2XlJ6pyB0Ha6fER9bYWnSF2mrGxm6fI1/GTCeW7Zh04t9QcwwHG/71y
         th/soGgBJASbeMR/86CmND0RP7xASparK37q+L8OHOYu3LpfA5+3eAEu9sLOTDj9u2Y8
         dv4YbMEbGGQbOepb5OgezcJRI/+QVeRnKQcK/Gb6xEGK7mov6N0FJqskR41QiNT+OHDG
         XS8fRSHYAao2BgNnLum/gqpgSKlfwD+BIE+4wkH5Kz0WgxNIWIhfHVnUPSxmF64b2Sqt
         0pvA==
X-Gm-Message-State: APjAAAViXwcbAgMIH0BDdZgjDvLxJ7QwDTwshdNKTI4DRR5j1zrX25oD
        cay+3ZUgBoeqI0v0faglbAN2DvZ4rg6haOZWFShVxA==
X-Google-Smtp-Source: APXvYqwu8aBCGhzTF/fgWBAcUNVF+q/DggTsoIepBm01kjtKjRRvEEjFteeR/hpqbVZh6e+k9JHXokGhaMM3av69lNg=
X-Received: by 2002:a2e:9596:: with SMTP id w22mr11169047ljh.21.1581611922624;
 Thu, 13 Feb 2020 08:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-3-vincent.guittot@linaro.org> <20200212133715.GU3420@suse.de>
 <20200212194903.GS3466@techsingularity.net> <CAKfTPtDA5GamN4A1SnegYwYCk123TqUDE9EHFbHTgKCMR+yqGQ@mail.gmail.com>
 <20200213131658.9600-1-hdanton@sina.com> <20200213134655.GX3466@techsingularity.net>
 <20200213150026.GB6541@lorien.usersys.redhat.com> <20200213151430.GY3466@techsingularity.net>
 <CAKfTPtDjKW45QyXnF7Pu42AP48mNbDWTUttMSoDgDzOO5GSfnA@mail.gmail.com> <20200213163437.GZ3466@techsingularity.net>
In-Reply-To: <20200213163437.GZ3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 13 Feb 2020 17:38:31 +0100
Message-ID: <CAKfTPtD8k-LMaXz_MNmxeW5aXDO4ZZ6j=gwCRTRU89OJ9nUEGw@mail.gmail.com>
Subject: Re: [RFC 2/4] sched/numa: replace runnable_load_avg by load_avg
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 at 17:34, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Feb 13, 2020 at 05:11:23PM +0100, Vincent Guittot wrote:
> > > On Thu, Feb 13, 2020 at 10:00:26AM -0500, Phil Auld wrote:
> > > > On Thu, Feb 13, 2020 at 01:46:55PM +0000 Mel Gorman wrote:
> > > > > On Thu, Feb 13, 2020 at 09:16:58PM +0800, Hillf Danton wrote:
> > > > > > > -       load = task_h_load(env->p);
> > > > > > > -       dst_load = env->dst_stats.load + load;
> > > > > > > -       src_load = env->src_stats.load - load;
> > > > > > > -
> > > > > > >         /*
> > > > > > > -        * If the improvement from just moving env->p direction is better
> > > > > > > -        * than swapping tasks around, check if a move is possible.
> > > > > > > +        * If dst node has spare capacity, then check if there is an
> > > > > > > +        * imbalance that would be overruled by the load balancer.
> > > > > > >          */
> > > > > > > -       maymove = !load_too_imbalanced(src_load, dst_load, env);
> > > > > > > +       if (env->dst_stats.node_type == node_has_spare) {
> > > > > > > +               unsigned int imbalance;
> > > > > > > +               int src_running, dst_running;
> > > > > > > +
> > > > > > > +               /* Would movement cause an imbalance? */
> > > > > > > +               src_running = env->src_stats.nr_running - 1;
> > > > > > > +               dst_running = env->src_stats.nr_running + 1;
> > > > > > > +               imbalance = max(0, dst_running - src_running);
> > > > > >
> > > > > > Have trouble working out why 2 is magician again to make your test data nicer :P
> > > > > >
> > > > >
> > > > > This is calculating what the nr_running would be after the move and
> > > > > checking if an imbalance exists after the move forcing the load balancer
> > > > > to intervene.
> > > >
> > > > Isn't that always going to work out to 2?
> > > >
> > >
> > > Crap, stupid cut and paste moving between source trees. Yes, this is
> > > broken.
> >
> > On the load balance side we have 2 rules when NUMA groups has spare capacity:
> > - ensure that the diff between src and dst nr_running < 2
> > - if src_nr_running is lower than 2, allow a degree of imbalance of 2
> > instead of 1
> >
> > Your test doesn't explicitly ensure that the 1 condition is met
> >
> > That being said, I'm not sure it's really a wrong thing ? I mean
> > load_balance will probably try to pull back some tasks on src but as
> > long as it is not a task with dst node as preferred node, it should
> > not be that harmfull
>
> My thinking was that if source has as many or more running tasks than
> the destination *after* the move that it's not harmful and does not add
> work for the load balancer.

load_balancer will see an imbalance but fbq_classify_group/queue
should be there to prevent from pulling back tasks that are on the
preferred node but only other tasks

>
> --
> Mel Gorman
> SUSE Labs
