Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E05C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C3620656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yax2H35o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgBMQLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:11:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43583 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgBMQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:11:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so4649735lfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 08:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mluhp8Rm0Cv53d0DYRFOR6h+hAKA9d/wrwnHEDk2DUg=;
        b=yax2H35oN2YBPbA3ikqf2zgoGhmJogL61H+vGuA66ARtQD0i2D/LURXKUr3App7iI8
         aAjNXLe7F/PeHQhGlxJ6PS0j8GJyhAQz5ujZw/YAbpSDAKeH+tMENjRbEzZg7uCOxARw
         DYNn+bbzAOaZVTXgy0A1T+u3nqv8msR6D8kcY1RpJAleDTC0hTP49/NeCnFBdDNkThwG
         60SvS9vKsBH6gYgqA0NEqqS92iDSSEFQtiLHNYfnEhpfnjwU42YFq/kAtu8f/oFkpe5Z
         5DF542BACK0uIM8f48Kj+4oUdXEGc5JbswkFshXAm499CoLbW0z03UEUW5mu1WpzBsj/
         bp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mluhp8Rm0Cv53d0DYRFOR6h+hAKA9d/wrwnHEDk2DUg=;
        b=OXBvE0NotsJg6SA10S1ii+WbWrcXpcA3JjYQp0ePrSS+dHiosw3ab98sB6C6tuRXke
         Rn8PvX4C/N89WDT/HOxHGZSTIsOj46lzR6O2k3WMs7iTfTIM0DyTh5KYnKeRtSlPh+bE
         5aHDe8TXGxtbfOOXHHda07AqofCIYgP7OJiDSeM/cvuos6F9ZvnNfNFcYn+nB2d0PeIU
         TzuNHYd7uvzdBtpt9mq4Ep++OoNijWqCiM4qK4vRrdjCc5OPsnjtMMtPztxT9wEmIDtX
         K/rodyyottrX4BC35BwlS9PpYXsZORSWHPW+pvs2n/w3shMHdfKDKr+aIK9ICK4keZ+C
         b2HQ==
X-Gm-Message-State: APjAAAVx+3meNNRo6q3ItKMI9YY+8c2kLNRnh9Suq7Dv0Qpvg0dZYpj3
        SaHZJzO9uUHZrcJFDPXF7KrPmu6nRD+rY4FccdMhUA==
X-Google-Smtp-Source: APXvYqyRj5x88VF83830qiLAZIK9xpbsq30ZsojYoNMoq1OjkY8a/c4+2sAYlokH0fnEq/ZcAWD7CnwdNW3MWKwivhM=
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr9846493lfp.133.1581610294642;
 Thu, 13 Feb 2020 08:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-3-vincent.guittot@linaro.org> <20200212133715.GU3420@suse.de>
 <20200212194903.GS3466@techsingularity.net> <CAKfTPtDA5GamN4A1SnegYwYCk123TqUDE9EHFbHTgKCMR+yqGQ@mail.gmail.com>
 <20200213131658.9600-1-hdanton@sina.com> <20200213134655.GX3466@techsingularity.net>
 <20200213150026.GB6541@lorien.usersys.redhat.com> <20200213151430.GY3466@techsingularity.net>
In-Reply-To: <20200213151430.GY3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 13 Feb 2020 17:11:23 +0100
Message-ID: <CAKfTPtDjKW45QyXnF7Pu42AP48mNbDWTUttMSoDgDzOO5GSfnA@mail.gmail.com>
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

On Thu, 13 Feb 2020 at 16:14, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Feb 13, 2020 at 10:00:26AM -0500, Phil Auld wrote:
> > On Thu, Feb 13, 2020 at 01:46:55PM +0000 Mel Gorman wrote:
> > > On Thu, Feb 13, 2020 at 09:16:58PM +0800, Hillf Danton wrote:
> > > > > -       load = task_h_load(env->p);
> > > > > -       dst_load = env->dst_stats.load + load;
> > > > > -       src_load = env->src_stats.load - load;
> > > > > -
> > > > >         /*
> > > > > -        * If the improvement from just moving env->p direction is better
> > > > > -        * than swapping tasks around, check if a move is possible.
> > > > > +        * If dst node has spare capacity, then check if there is an
> > > > > +        * imbalance that would be overruled by the load balancer.
> > > > >          */
> > > > > -       maymove = !load_too_imbalanced(src_load, dst_load, env);
> > > > > +       if (env->dst_stats.node_type == node_has_spare) {
> > > > > +               unsigned int imbalance;
> > > > > +               int src_running, dst_running;
> > > > > +
> > > > > +               /* Would movement cause an imbalance? */
> > > > > +               src_running = env->src_stats.nr_running - 1;
> > > > > +               dst_running = env->src_stats.nr_running + 1;
> > > > > +               imbalance = max(0, dst_running - src_running);
> > > >
> > > > Have trouble working out why 2 is magician again to make your test data nicer :P
> > > >
> > >
> > > This is calculating what the nr_running would be after the move and
> > > checking if an imbalance exists after the move forcing the load balancer
> > > to intervene.
> >
> > Isn't that always going to work out to 2?
> >
>
> Crap, stupid cut and paste moving between source trees. Yes, this is
> broken.

On the load balance side we have 2 rules when NUMA groups has spare capacity:
- ensure that the diff between src and dst nr_running < 2
- if src_nr_running is lower than 2, allow a degree of imbalance of 2
instead of 1

Your test doesn't explicitly ensure that the 1 condition is met

That being said, I'm not sure it's really a wrong thing ? I mean
load_balance will probably try to pull back some tasks on src but as
long as it is not a task with dst node as preferred node, it should
not be that harmfull

>
> --
> Mel Gorman
> SUSE Labs
