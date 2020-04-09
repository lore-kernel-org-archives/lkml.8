Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE08FC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA242074F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgDIOzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:55:42 -0400
Received: from foss.arm.com ([217.140.110.172]:51270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgDIOzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:55:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 834C830E;
        Thu,  9 Apr 2020 07:55:40 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 885F93F68F;
        Thu,  9 Apr 2020 07:55:38 -0700 (PDT)
Date:   Thu, 9 Apr 2020 15:55:36 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sched/deadline: Implement fallback mechanism for
 !fit case
Message-ID: <20200409145359.y276yeikn7dp6jmx@e107158-lin.cambridge.arm.com>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-5-dietmar.eggemann@arm.com>
 <20200409102557.h4humnsa5dlwvlym@e107158-lin.cambridge.arm.com>
 <20200409150010.468951df@sweethome>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200409150010.468951df@sweethome>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca

On 04/09/20 15:00, luca abeni wrote:
> > Outside of the scope of this series. But does it make sense to make
> > sched_setattr() fail to create a new deadline task if the system will
> > be overcommitted, hence causing some dl tasks to miss their deadlines?
> 
> The problem is that with multiple processors/cores it is not easy to
> know in advance if any task will miss a deadline (see section 3.3 of
> Documentation/scheduler/sched-deadline.rst).
> 
> The admission control we are currently using should prevent
> SCHED_DEADLINE tasks from overloading the system (starving non-deadline
> tasks); proving hard deadline guarantees with global EDF scheduling is
> much more difficult (and could be probably done in user-space, I think).

I see. I'll dig through the docs, thanks for the reference.

> > If some overcommitting is fine (some deadlines are soft and are okay
> > to fail every once in a while), does it make sense for this to be a
> > tunable of how much the system can be overcommitted before
> > disallowing new DL tasks to be created?
> 
> There is already a tunable for the SCHED_DEADLINE admission test
> (/proc/sys/kernel/sched_rt_{runtime,period}_us, if I understand well
> what you are suggesting). The problem is that it is not easy to find a
> value for this tunable that guarantees the hard respect of all
> deadlines.

I don't think it's similar to what I was referring to. But my knowledge about
DL could have failed me to fully appreciate what you're saying.

This tunable for RT prevents a single task from using 100% CPU time. I think
DL uses it in a similar manner.

What I meant by overcommiting, is allowing more DL tasks than the system can
guarantee to meet their deadlines.

For example, in the context of capacity awareness, if you have 2 big cores, but
4 DL tasks request a bandwidth that can only be satisfied by the big cores,
then 2 of them will miss their deadlines (almost) consistently, IIUC.

This can be generalized on SMP (I believe). But judging from your earlier
response, it's not as straightforward as it seems :)

> 
> But IMHO if someone really wants hard deadline guarantees it is better
> to use partitioned scheduling (see Section 5 of the SCHED_DEADLINE
> documentation).

RT is the same. So this makes sense. Though one would hope to be able to
improve on this in the future. Something for me to ponder over :)

Thanks

--
Qais Yousef
