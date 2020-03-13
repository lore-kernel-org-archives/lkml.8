Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8914C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD98E206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCMReN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:34:13 -0400
Received: from foss.arm.com ([217.140.110.172]:33714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgCMReN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:34:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B214431B;
        Fri, 13 Mar 2020 10:34:12 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 794673F534;
        Fri, 13 Mar 2020 10:34:11 -0700 (PDT)
References: <20200312165429.990-1-vincent.guittot@linaro.org> <jhjr1xwjz96.mognet@arm.com> <CAKfTPtCQZMOz9HzdiWg5g9O+W=hC5E-fiG8YVHWCcODjFRfefQ@mail.gmail.com> <jhjpndgjxxk.mognet@arm.com> <jhj4kuspgse.mognet@arm.com> <CAKfTPtD67EKA46i12FHpJQT4gTzaH=ASAyb2dhv4=owPHBRSdQ@mail.gmail.com> <CAKfTPtBZgvTBYR+kYjj9dHq8_25mG19CZmYzY5s33ijSHdLGyQ@mail.gmail.com> <jhj36acp88q.mognet@arm.com> <CAKfTPtAMmYONX+qxp1Awj+XpqkWU3ootcyv7iar7e6z5nSczpw@mail.gmail.com> <jhj1rpwp4z1.mognet@arm.com> <CAKfTPtCopLDoUsC+Mt6k99Hdn52pcKkrNYQsYNRW5LdgyMg4Nw@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: improve spreading of utilization
In-reply-to: <CAKfTPtCopLDoUsC+Mt6k99Hdn52pcKkrNYQsYNRW5LdgyMg4Nw@mail.gmail.com>
Date:   Fri, 13 Mar 2020 17:34:09 +0000
Message-ID: <jhjzhcknoq6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Mar 13 2020, Vincent Guittot wrote:
>> My point is that if we prevent this for migrate_util, it would make
>> sense to prevent it for migrate_task, but it's not straightforward since
>
> hmm but we don't want to prevent this active balance for migrate_task
> because of cases like the one you mentioned above.
>
> we might consider to finally select a CPU with only 1 running task
> with migrate_util if there is no other CPU with more than 1 task. But
> this would complexify the code and I don't think it's possible because
> migrate_util is used to pull some utilizations from an overloaded
> group which must have a CPU with a waiting task to be overloaded.
>

OK, so what we may want in the future is a tighter link between
find_busiest_queue() and voluntary_active_balance(). I don't see a neat
way of doing this right now, I'll ponder over it.

Thanks for keeping up with my rambling.
