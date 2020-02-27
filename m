Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58580C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261BE2469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rp8AVLzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgB0TOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:14:02 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54821 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbgB0TOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:14:01 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so192757pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 11:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ltWk1OgooA+fGQ205Nk5s6jGGfXx7mNf2yLqJVxcgnw=;
        b=Rp8AVLzq1CPKtYmNKrPMUXgzzx33DJcSPvqTOL4EobIGFP3mlVvRq/kmIftdAuLdqZ
         4CUgUF3a0750hfUoEocFn3lYwRJ6T+320TTMqBaU1UliyjjIQ8l9TH9Q0m4i/0QL++FS
         mJwHjxNete5q+zMFfTTXQSRJ0LTl5+TXzNtsUqEZx2ye4Lo0c52cii/hQ9HkqKwUUbVi
         Ek4J4z5AfzIJ70QsQ6YZXD2oEoC3udFYuL2FEnZgkvPMyd5QqNgLsKGdFw1eBIUfWdqE
         IM5CqkVKD7NAqWjYMTpRVA0h3XlGXJV2cIRWLLqbqW2xTQ3ChohQFQPU1aI+yvBuvxp5
         IEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ltWk1OgooA+fGQ205Nk5s6jGGfXx7mNf2yLqJVxcgnw=;
        b=IysjTYleVVKVMSTeenRA4i7EVOtK2aDnJPKxyGU6TjMg63J77Te/x4OKdvgwfG20HE
         pmCSF/aFWOvyecRr+QoZuAwXTDIB6ufy7TXlaPI3CrNMeMD/ozFMlbBvddz/VVUsRB82
         izcG4TnmDV2ohlQsp96eJB3/cteMwKVOG4kHdSqxnHG0whZsKoxxRvdRlDoDz/HJSOnc
         j//CnrhuzTvfQkWeql3sHsObh+nCzS/Q1Db6LPrrgCs7DJRD2iRXtZsWLVnB5NRS32VE
         Zv0ErHM+BNwJBstjbmRyUnWHtUdocKob9rNKRpXngntjKsuEG5PpYieAB/7RC3hDxoKJ
         pDig==
X-Gm-Message-State: APjAAAU2epkedyq0PnGP3560wYZ7NOH5vMWbxlZPLmFqOK7A/tyEMaOC
        JczEuJ5EXYVXdbii5LhuMV5iMQ==
X-Google-Smtp-Source: APXvYqxzPyPSsvFtFByHNy4x3W9dwnvrfBp/1CjXJ466D6gCZgkzxAVF9/9wrnk3zltWV9XlRazzzg==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr246741plp.252.1582830840604;
        Thu, 27 Feb 2020 11:14:00 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id r8sm7148844pjo.22.2020.02.27.11.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:13:59 -0800 (PST)
From:   bsegall@google.com
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ben Segall <bsegall@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>, zhout@vivaldi.net
Subject: Re: [PATCH] sched/fair: fix runnable_avg for throttled cfs
References: <20200226181640.21664-1-vincent.guittot@linaro.org>
        <xm26r1yhtbjr.fsf@bsegall-linux.svl.corp.google.com>
        <CAKfTPtBm9Gt16gqQgxoErOOmpbUHit6bNf4CVLvDzf04SjWtEg@mail.gmail.com>
Date:   Thu, 27 Feb 2020 11:13:58 -0800
In-Reply-To: <CAKfTPtBm9Gt16gqQgxoErOOmpbUHit6bNf4CVLvDzf04SjWtEg@mail.gmail.com>
        (Vincent Guittot's message of "Wed, 26 Feb 2020 22:01:36 +0100")
Message-ID: <xm26mu93u9l5.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Guittot <vincent.guittot@linaro.org> writes:

> On Wed, 26 Feb 2020 at 20:04, <bsegall@google.com> wrote:
>>
>> Vincent Guittot <vincent.guittot@linaro.org> writes:
>>
>> > When a cfs_rq is throttled, its group entity is dequeued and its running
>> > tasks are removed. We must update runnable_avg with current h_nr_running
>> > and update group_se->runnable_weight with new h_nr_running at each level
>> > of the hierarchy.
>>
>> You'll also need to do this for task enqueue/dequeue inside of a
>> throttled hierarchy, I'm pretty sure.
>
> AFAICT, this is already done with patch "sched/pelt: Add a new
> runnable average signal" when task is enqueued/dequeued inside a
> throttled hierarchy

Right, I misread what exactly was going on.

>
>>
>> >
>> > Fixes: 9f68395333ad ("sched/pelt: Add a new runnable average signal")
>> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> > ---
>> > This patch applies on top of tip/sched/core
>> >
>> >  kernel/sched/fair.c | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index fcc968669aea..6d46974e9be7 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -4703,6 +4703,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
>> >
>> >               if (dequeue)
>> >                       dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
>> > +             else {
>> > +                     update_load_avg(qcfs_rq, se, 0);
>> > +                     se_update_runnable(se);
>> > +             }
>> > +
>> >               qcfs_rq->h_nr_running -= task_delta;
>> >               qcfs_rq->idle_h_nr_running -= idle_task_delta;
>> >
>> > @@ -4772,6 +4777,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>> >               cfs_rq = cfs_rq_of(se);
>> >               if (enqueue)
>> >                       enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
>> > +             else {
>> > +                     update_load_avg(cfs_rq, se, 0);
>>
>>
>> > +                     se_update_runnable(se);
>> > +             }
>> > +
>> >               cfs_rq->h_nr_running += task_delta;
>> >               cfs_rq->idle_h_nr_running += idle_task_delta;
