Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFF1C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D292A20842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yOg1Jo7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgCDLzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:55:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33767 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbgCDLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:55:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id f13so1708378ljp.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 03:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KGst1ceARhN0S2erqmPUjoBDzaUYfQfZODEEV8BeYQ=;
        b=yOg1Jo7KzdMLopESxdGS+mL3Qz5sl5hwYNd8jOj+HQOvhLJZI4fjf1oogv6Nw7vQ1m
         6KQ1acWQt/meOar5gO34IqB2Qipkm0gnwiyRRZ8xNnSvVPO/4kK+zSRQx/HtzYHjid6g
         DCiXOEE4swpPGCIWlOj4ZtmJYwVlwfobDg1IUeBe1Ib5fiQAzMLQY6mPv541b46iBI2Q
         Yi04t3IzyQ/vUkCl93F9B+hIpNJfztY20ykD2fqJ0yPBNdFmYhz6bUD8FUzwi/a1vgyX
         aDo3yIqfsCrorbsx0XjTXNvu0wkWmFWSFJ+c2dvs7c7dLJcARNQ6ArnayAirkSU9eZYp
         NxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KGst1ceARhN0S2erqmPUjoBDzaUYfQfZODEEV8BeYQ=;
        b=NzMQXj21wYd5iTybAM3IavZqMIYVmlHhgPmc4z13HiDRsw17Trb2sQ2OSaHIdSJjOV
         Y3waPZKAf8zRtBHh5zcOfgD6WrktsG/BNvLM25kxdAkHLLg3Y1nVSygTcyP+uQy3zwJe
         M8S0BV/bDcgb297iMiOKUa83RK+JoCdSMDUy+fRT0SlYNknkXQ81jLlGlmwfgvO2R8BJ
         sdGRrZEY3lZQ0mSqXB9F/GI11bEICfB/VO0uJBPI+dCLaSLzvCN5HAXEJBOTksHAB3yZ
         82l+/iaB0poVEAH3XWgMHprOazmAV923TsvW+Zx1tNnXWgN8hc5OBrUyMpPO1SOQ/bHe
         uEcg==
X-Gm-Message-State: ANhLgQ0C/JoJM0VcLsngk641bRU+HKf8KHLUp8h2R2YKcmY86uNX7scr
        oJFgD9KUtt0VORpB1rnEpvrE1pyo7yRj/aOI7xlS0Q==
X-Google-Smtp-Source: ADFU+vvERIzVELgMxjXIK/0bg2ysl2qBnLReCiRMfKR8klz4a+TQxfqtIK0cQk0HeKoyTC7CZSrXcz3g8aIiB2N9lGs=
X-Received: by 2002:a2e:2a06:: with SMTP id q6mr1751495ljq.65.1583322933077;
 Wed, 04 Mar 2020 03:55:33 -0800 (PST)
MIME-Version: 1.0
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
 <20200303195245.GF2596@hirez.programming.kicks-ass.net> <241603dd-1149-58aa-85cf-43f3da2de43f@linux.alibaba.com>
 <CAKfTPtB=+sMXYXEeb2WppUracxLNXQPJj0H7d-MqEmgrB3gTDw@mail.gmail.com> <20200304095209.GK2596@hirez.programming.kicks-ass.net>
In-Reply-To: <20200304095209.GK2596@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Mar 2020 12:55:21 +0100
Message-ID: <CAKfTPtDrSzET+=G7rHvhDY3491CzGvp3ZqW0cqR8jhC1EvC2mQ@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq is
 too, small
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 10:52, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 04, 2020 at 09:47:34AM +0100, Vincent Guittot wrote:
> > you will add +1 of nice prio for each device
> >
> > should we use instead
> > # define scale_load_down(w) ((w >> SCHED_FIXEDPOINT_SHIFT) ? (w >>
> > SCHED_FIXEDPOINT_SHIFT) : MIN_SHARES)
>
> That's '((w >> SHIFT) ?: MIN_SHARES)', but even that is not quite right.
>
> I think we want something like:
>
> #define scale_load_down(w) \
> ({ unsigned long ___w = (w); \
>    if (___w) \
>      ____w = max(MIN_SHARES, ___w >> SHIFT); \
>    ___w; })
>
> That is, we very much want to retain 0 I'm thinking.

yes, you're right
