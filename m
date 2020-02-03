Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A23DC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34DE20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgBCRPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:15:05 -0500
Received: from foss.arm.com ([217.140.110.172]:56462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729002AbgBCRPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:15:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 095EE30E;
        Mon,  3 Feb 2020 09:15:04 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 859383F52E;
        Mon,  3 Feb 2020 09:15:02 -0800 (PST)
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
To:     Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20200131100629.GC27398@codeaurora.org>
 <20200131153405.2ejp7fggqtg5dodx@e107158-lin.cambridge.arm.com>
 <CAEU1=PnYryM26F-tNAT0JVUoFcygRgE374JiBeJPQeTEoZpANg@mail.gmail.com>
 <20200203142712.a7yvlyo2y3le5cpn@e107158-lin>
 <20200203111451.0d1da58f@oasis.local.home>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <8868c5cf-e3f4-04e1-e071-0476ac813191@arm.com>
Date:   Mon, 3 Feb 2020 17:15:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200203111451.0d1da58f@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2020 16:14, Steven Rostedt wrote:
> On Mon, 3 Feb 2020 14:27:14 +0000
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
>> I don't see one right answer here. The current mechanism could certainly do
>> better; but it's not clear what better means without delving into system
>> specific details. I am open to any suggestions to improve it.
> 
> The way I see this is that if there's no big cores available but little
> cores are, and the RT task has those cores in its affinity mask then
> the task most definitely should consider moving to the little core. The
> cpu_find() should return them!
> 
> But, what we can do is to mark the little core that's running an RT
> task on a it that prefers bigger cores, as "rt-overloaded".  This will
> add this core into the being looked at when another core schedules out
> an RT task. When that happens, the RT task on the little core will get
> pulled back to the big core.
> 

That sounds sensible enough - it's also very similar to what we have for
CFS, labeled under "misfit tasks" (i.e. tasks that are "too big" for
LITTLEs).

> 
> Note, this will require a bit more logic as the overloaded code wasn't
> designed for migration of running tasks, but that could be added.
> 

I haven't adventured too much within RT land, but FWIW that's what we use
the CPU stopper for in CFS (see active_load_balance_cpu_stop()).

> -- Steve
> 
