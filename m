Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F2BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C845320775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbgF3RoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:44:25 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:42010 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbgF3RoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:44:21 -0400
Received: by mail-ej1-f66.google.com with SMTP id i14so21522513ejr.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=A5m4iIJZB8g0jtmUtDpb9yGTt+vhjXl0DvXeBfp21DY=;
        b=EXMscsB+lamX2FZP93m9eXhjDCirDCPmvgtbShBOgTRtzObntoEtZmynpmAevVfN+E
         mkIDdiQ6pCsq38nPODOphMZTI6wqPkg+5ZFVpedrQsqWp+sz3iKUYaW2fIm/Jf22QnfL
         fJ5nsN86xMxVn3o6uhRwwDu/Wdn3wBoTxmZclxl3NIdMZI4HhJ3pLLMbJlzxy12McDmG
         PuOj7QUlUGPyIg2bp9xAAAskgXz7ZI8AWWXP35J+AYiqu8Sm73xHqsuJFemeeALZkvhS
         +umBwiCTWOpE+ClkFANyiUjRPqLxmGrHrcJ/b39mQAYsrKgqlSZQXfsqBqumWN2wgPBR
         16EQ==
X-Gm-Message-State: AOAM533AlOV8j4WosRvQhBanUtGbsV+piiX3NuJVFCQlQxx9RS1BHbrM
        +pEsYg6rGM3TNzRk5bAJrjpMA24lqAQ=
X-Google-Smtp-Source: ABdhPJxUaqM/iJdLSAxeMt09Wp9qhA1Z1WMtMWevGkkfRG7LbW+Qe2cOaM2HmISXWMUJeRr1kCWK5g==
X-Received: by 2002:a17:906:364e:: with SMTP id r14mr8680093ejb.258.1593539058617;
        Tue, 30 Jun 2020 10:44:18 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id j24sm3452711edp.22.2020.06.30.10.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:44:17 -0700 (PDT)
References: <20200629162633.8800-1-qais.yousef@arm.com> <20200629162633.8800-3-qais.yousef@arm.com> <87366dnfaq.derkling@matbug.net> <20200630094623.hnlqtgavauqlsuyd@e107158-lin.cambridge.arm.com> <87zh8kmwlt.derkling@matbug.net> <20200630154033.5r6zi7ajgag7jlec@e107158-lin.cambridge.arm.com>
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
In-reply-to: <20200630154033.5r6zi7ajgag7jlec@e107158-lin.cambridge.arm.com>
Message-ID: <87wo3omot7.derkling@matbug.net>
Date:   Tue, 30 Jun 2020 19:44:04 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jun 30, 2020 at 17:40:34 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

> Hi Patrick
>
> On 06/30/20 16:55, Patrick Bellasi wrote:
>> 
>> Hi Qais,
>> sorry for commenting on v5 with a v6 already posted, but...
>> ... I cannot keep up with your re-spinning rate ;)
>
> I classified that as a nit really and doesn't affect correctness. We have
> different subjective view on what is better here. I did all the work in the
> past 2 weeks and I think as the author of this patch I have the right to keep
> my preference on subjective matters. I did consider your feedback and didn't
> ignore it and improved the naming and added a comment to make sure there's no
> confusion.
>
> We could nitpick the best name forever, but is it really that important?

Which leans toward confirming the impression I had while reading your
previous response, i.e. you stopped reading at the name change
observation, which would be _just_ a nit-picking, although still worth
IMHO.

Instead, I went further and asked you to consider a different approach:
not adding a new kernel symbol to represent a concept already there.

> I really don't see any added value for one approach or another here to start
> a long debate about it.

Then you could have just called out that instead of silently ignoring
the comment/proposal.

> The comments were small enough that I didn't see any controversy that
> warrants holding the patches longer. I agreed with your proposal to use
> uc_se->active and clarified why your other suggestions don't hold.
>
> You pointed that uclamp_is_enabled() confused you; and I responded that I'll
> change the name.

Perhaps it would not confuse only me having 'something_enabled()'
referring to 'something_used'.

> Sorry for not being explicit about answering the below, but
> I thought my answer implied that I don't prefer it.

Your answer was about a name change, don't see correlation with a
different approach... but should be just me.

>> >> Thus, perhaps we can just use the same pattern used by the
>> >> sched_numa_balancing static key:
>> >> 
>> >>   $ git grep sched_numa_balancing
>> >>   kernel/sched/core.c:DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
>> >>   kernel/sched/core.c:            static_branch_enable(&sched_numa_balancing);
>> >>   kernel/sched/core.c:            static_branch_disable(&sched_numa_balancing);
>> >>   kernel/sched/core.c:    int state = static_branch_likely(&sched_numa_balancing);
>> >>   kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
>> >>   kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
>> >>   kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
>> >>   kernel/sched/fair.c:    if (static_branch_unlikely(&sched_numa_balancing))
>> >>   kernel/sched/sched.h:extern struct static_key_false sched_numa_balancing;
>> >> 
>> >> IOW: unconditionally define sched_uclamp_used as non static in core.c,
>> >> and use it directly on schedutil too.
>> 
>> So, what about this instead of adding the (renamed) method above?
>
> I am sorry there's no written rule that says one should do it in a specific
> way. And AFAIK both way are implemented in the kernel. I appreciate your
> suggestion but as the person who did all the hard work, I think my preference
> matters here too.

You sure know that sometime reviewing code can be an "hard work" too, so I
would not go down that way at all with the discussion. Quite likely I
have a different "subjective" view on how Open Source development works.

> And actually with my approach when uclamp is not compiled in there's no need to
> define an extra variable; and since uclamp_is_used() is defined as false for
> !CONFIG_UCLAMP_TASK, it'll help with DCE, so less likely to end up with dead
> code that'll never run in the final binary.

Good, this is the simple and small reply I've politely asked for.

Best,
Patrick

