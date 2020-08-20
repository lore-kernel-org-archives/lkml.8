Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DC1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0573320738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1nV8xXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgHTOYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgHTOYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:24:18 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EC5C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:24:18 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id j19so450765oor.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6nbYux31Ygm+S1ZFzocKiKaMUxITSb9tEwn8M8YVaA=;
        b=C1nV8xXDoFlHvnIY11XJxDmj0dqIaVLKAbMEibphui4S/YRRDZQFf5sQqb88jwrUaU
         EM0bcBsChm943BRU6jEVva11pImi5CZ1BQvUb+oSM8GxlXJ/5p5HB+vLLsbT2clB/ZHK
         ysK3MVQduxqfTsdivbJMg1m2qkw+ow+W2zqD/uLfOlmHKFM1Hy5pOFceBAhGnjTxitWK
         wzHZnkWdcjRas+uljGkWETPT1GK/TWGEFcMp+sIfaO3SLPpHKMYLx0lGYBRayFxXao9p
         952Ueu7AapruTZLLpYdKaBEGvO/vyKrtNBhKAM6jw8onrGsJ8WF5a2tNsMN9nEzPqkRf
         cKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6nbYux31Ygm+S1ZFzocKiKaMUxITSb9tEwn8M8YVaA=;
        b=jTS7ecoNrbc5/n9XTVJs58U/vAYqunOsuy2jqfAkcrzZFQfuuo91VfQ22aZ9bDyx+H
         Wg0JNhO4vw+34t3nC7Evsspdi5ZhZgwKHLEZxnhO8mD/zHfhF8xiqbA+snv+DV8v7xau
         eKg0KDWynjiZJvBeN5FAFF/U5e2qgvIODijGh2MpspzuLykCIKYBg0WOh4zbVpOAsN1T
         qwKQeLsfhE3se0jJFN6N+Dur/jqF7YTPQhJscEaMqmotnuc5ZOUqEBJXiQ7bEnJodSgH
         5jYciQhCAeJs8RBaTBiWsVVmlo19bOP02pealxr/Fz6uta3LNXve45RDQpYIuFH/JZpm
         D3wg==
X-Gm-Message-State: AOAM5338BMjOUShpdfYJL1dPW3FNbAL15kAQZHImMJoRgUswUuPpN+iK
        Y73xchh3p6ir2wpWDnGCfpTl7Z8jrAaNbiOPw9Y=
X-Google-Smtp-Source: ABdhPJyt8S6QZmWVpmMXoa0IW2s7IHmnpIfJgxbHvmZyFt/Cwl2DEHLt6IlPoFja1kCVyjkOOhiCeaGCOSDw0ox41T0=
X-Received: by 2002:a4a:c299:: with SMTP id b25mr2575576ooq.35.1597933457899;
 Thu, 20 Aug 2020 07:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200820120025.74460-1-benbjiang@tencent.com> <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
 <20200820125829.GT2674@hirez.programming.kicks-ass.net> <CAKfTPtBuZOb9-W5sS=DqxcuMFa8Lw=7XqMJ_YrXEgd5zvufYjA@mail.gmail.com>
 <20200820134341.GW2674@hirez.programming.kicks-ass.net> <CAKfTPtC203mVB6QB1APbZ5igavdcwbJsCQH_8K__rhGxi+KXoQ@mail.gmail.com>
In-Reply-To: <CAKfTPtC203mVB6QB1APbZ5igavdcwbJsCQH_8K__rhGxi+KXoQ@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Thu, 20 Aug 2020 22:24:07 +0800
Message-ID: <CAPJCdBk_PeWExFDu23kWMCus_Yy7nsf_kLtEu9ZBAWurHmj0wA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: avoid vruntime compensation for SCHED_IDLE task
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 22:09, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 20 Aug 2020 at 15:44, <peterz@infradead.org> wrote:
> >
> > > That's been said, not compensating the vruntime for a sched_idle task
> > > makes sense for me. Even if that will only help for others task in the
> > > same cfs_rq
> >
> > Yeah, but it is worth the extra pointer chasing and branches?
>
> For that I let Jiang provides figures to show the worthful
I'll try to have some tests and show the wakeup latency difference
after applying the patch later.

Thanks for your time.
Regards
Jiang
>
> >
> > Then again, I suppose we started all that with the idle_h_nr_running
> > nonsense :/
