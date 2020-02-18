Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7571AC3403B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B69221D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvIOoKWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgBROPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:15:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43319 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgBROPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:15:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so23141260ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 06:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/I96XjCy45FrSiOOSIP4LbktmpEXlMTBIVpcEP7eY4=;
        b=WvIOoKWdR3yhpJT8DTNT3yzKoIzfOYLSRNYg0Sj4Wfq9Nxv6caTGv2ew5IEi+yDuXO
         pKGEgTqEkYwnVlyxt9zBUBpxvYyZKVmmPgXQ0xcRHPRt0GHzD+tpuEb1tm9BMKWClUsy
         8zxNdvD/COqAhRQ+25hf1eLEaTvHP5DVrvel0YAZkczYZKmt8Pdhe8DptvCetcW5yfyc
         8v6Xhf396Iv0kGJCQqsF/f5+YAbJPPUFxAxVG3tByf6+k9ZiLYy/sCEL8V/uSPGFruyo
         9iTWlZRtga168ec/jNIJHTqWPmd36pUQtkacJspWlnp30FO7R3EgD8zUexWaNuc2Yc7F
         3SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/I96XjCy45FrSiOOSIP4LbktmpEXlMTBIVpcEP7eY4=;
        b=UKnl7RmEtdgZ00aOzk0cg+eQ/s5wCvPXJp+HcCyg9wgO/qceFBeNW8yBv4KTQO/D5t
         9rvlxfqgiQPHGHHd+c+UmdXzGgsmkt7aK+NPx3lX45KWmQMashag/C7YAQZ4jQzhnq9C
         //0N/OM8UU7Uqjvswc1RYMjXugg5WrmSsLu2eDlWHjayMNCZIE75yD9BngsWviqZ6Jpe
         /bZOfdmS6gMwenUJURip8jWnlzAFBfxHb1QbTcmUhKYKmQlqkW+IoxQ9BABmTG78NeU9
         PC4yrP1pXd4WuPM4Ur/R+LrZgA6C10WQE3abQtiROGys3yGL+4aFvNH9AZhGWbyhtsZ0
         8I4A==
X-Gm-Message-State: APjAAAUZ3czj3Bd5Ugbaq5Cbsd+cHNzyWg8Z3LJnixtUATYqOsQJPb+s
        QuMw6BpivUWE4xTHlrF4rEQw51cAqU4dtZSv1FJJNQ==
X-Google-Smtp-Source: APXvYqz/+XveCSZtSXBY98DPZIClc6Sfarsw73hzrv5HUNrJkZn98HSENcCk60dPkH2DMRTpj3jlVt8ACTyy7fLj9OA=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr12317715ljg.154.1582035333487;
 Tue, 18 Feb 2020 06:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-2-vincent.guittot@linaro.org> <ee38d205-b356-9474-785e-e514d81b7d7f@arm.com>
 <20200218132203.GB14914@hirez.programming.kicks-ass.net>
In-Reply-To: <20200218132203.GB14914@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Feb 2020 15:15:22 +0100
Message-ID: <CAKfTPtB3qudK8aMq2cx==4RW8t1pz6ymz1Ti0r8oO4TefWzMRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] sched/fair: Reorder enqueue/dequeue_task_fair path
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 at 14:22, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 18, 2020 at 01:37:37PM +0100, Dietmar Eggemann wrote:
> > On 14/02/2020 16:27, Vincent Guittot wrote:
> > > The walk through the cgroup hierarchy during the enqueue/dequeue of a task
> > > is split in 2 distinct parts for throttled cfs_rq without any added value
> > > but making code less readable.
> > >
> > > Change the code ordering such that everything related to a cfs_rq
> > > (throttled or not) will be done in the same loop.
> > >
> > > In addition, the same steps ordering is used when updating a cfs_rq:
> > > - update_load_avg
> > > - update_cfs_group
> > > - update *h_nr_running
> >
> > Is this code change really necessary? You pay with two extra goto's. We
> > still have the two for_each_sched_entity(se)'s because of 'if
> > (se->on_rq); break;'.
>
> IIRC he relies on the presented ordering in patch #5 -- adding the
> running_avg metric.

Yes, that's the main reason, updating load_avg before h_nr_running
