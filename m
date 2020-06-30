Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6395BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477BA20675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbgF3Oz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:55:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37638 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgF3Oz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:55:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id g20so16305075edm.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=LRlTz/DoSdGeE0PKox/YqTRF8d9xjO56YImrwMYM7ck=;
        b=F7kz+gdoWnyIb3wDLor1vqirnm/RK6cF4y/9b9YzI2p7BHaLqqmdb20sD8krxyOslR
         KHVD8epR7NpW8X72n5fBB6cPXjekKcQXwVaGne1eRtJTu59PwMM8bQelPf5TEndW4afv
         BzVmk3AMLirRS2xgRzdqHOojrsxzyrJROXNyF5CTRifki7779z+yy75jxzHP1fpzMdAM
         hkmjFJ9+Fvrv1VCKOT8mviqC0glHNhVGzgojvraNQL/cvOSYk5QdwSy22kX1cvYG6Goz
         XwQQmMbQeh59sX4FZF39DBESNIZL4TTIoWOZrOZJl6iScgcQdb3wM4x58FdGi+EeTXkg
         a23g==
X-Gm-Message-State: AOAM531lfCPPfpVvEj1ERi/YmYo162J+i9WMQ6Og2sbRp8sgqfwToTWu
        Mn9VHPXP1HFY4vaz/8BtuKj6DHvXevw=
X-Google-Smtp-Source: ABdhPJyrcIQSOJ4j8u0X6wQj4NfrkkkYfLiuvCIQI50ZdXQ7ihNvwsVs8V8r/ViyBrbf1JYnYP75CA==
X-Received: by 2002:a05:6402:203a:: with SMTP id ay26mr12564870edb.276.1593528955733;
        Tue, 30 Jun 2020 07:55:55 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id t6sm2244842ejc.40.2020.06.30.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 07:55:54 -0700 (PDT)
References: <20200629162633.8800-1-qais.yousef@arm.com> <20200629162633.8800-3-qais.yousef@arm.com> <87366dnfaq.derkling@matbug.net> <20200630094623.hnlqtgavauqlsuyd@e107158-lin.cambridge.arm.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] sched/uclamp: Protect uclamp fast path code with static key
In-reply-to: <20200630094623.hnlqtgavauqlsuyd@e107158-lin.cambridge.arm.com>
Message-ID: <87zh8kmwlt.derkling@matbug.net>
Date:   Tue, 30 Jun 2020 16:55:42 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Qais,
sorry for commenting on v5 with a v6 already posted, but...
... I cannot keep up with your re-spinning rate ;)

More importantly, perhaps you missed to comment on one of my previous
points.

Will have a better look at the rest of v6 later today.

Cheers,
Patrick

On Tue, Jun 30, 2020 at 11:46:24 +0200, Qais Yousef <qais.yousef@arm.com> wrote...
> On 06/30/20 10:11, Patrick Bellasi wrote:
>> On Mon, Jun 29, 2020 at 18:26:33 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

[...]

>> > +
>> > +static inline bool uclamp_is_enabled(void)
>> > +{
>> > +	return static_branch_likely(&sched_uclamp_used);
>> > +}
>> 
>> Looks like here we mix up terms, which can be confusing.
>> AFAIKS, we use:
>> - *_enabled for the sched class flags (compile time)
>> - *_used    for the user-space opting in (run time)
>
> I wanted to add a comment here.
>
> I can rename it to uclamp_is_used() if you want.

In my previous message I was mostly asking about this:

>> Thus, perhaps we can just use the same pattern used by the
>> sched_numa_balancing static key:
>> 
>>   $ git grep sched_numa_balancing
>>   kernel/sched/core.c:DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
>>   kernel/sched/core.c:            static_branch_enable(&sched_numa_balancing);
>>   kernel/sched/core.c:            static_branch_disable(&sched_numa_balancing);
>>   kernel/sched/core.c:    int state = static_branch_likely(&sched_numa_balancing);
>>   kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
>>   kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
>>   kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
>>   kernel/sched/fair.c:    if (static_branch_unlikely(&sched_numa_balancing))
>>   kernel/sched/sched.h:extern struct static_key_false sched_numa_balancing;
>> 
>> IOW: unconditionally define sched_uclamp_used as non static in core.c,
>> and use it directly on schedutil too.

So, what about this instead of adding the (renamed) method above?

