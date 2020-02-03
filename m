Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BC2C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F2F2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgBCQO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:14:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgBCQO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:14:59 -0500
Received: from oasis.local.home (unknown [213.120.252.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45E1C2080D;
        Mon,  3 Feb 2020 16:14:56 +0000 (UTC)
Date:   Mon, 3 Feb 2020 11:14:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20200203111451.0d1da58f@oasis.local.home>
In-Reply-To: <20200203142712.a7yvlyo2y3le5cpn@e107158-lin>
References: <20191009104611.15363-1-qais.yousef@arm.com>
        <20200131100629.GC27398@codeaurora.org>
        <20200131153405.2ejp7fggqtg5dodx@e107158-lin.cambridge.arm.com>
        <CAEU1=PnYryM26F-tNAT0JVUoFcygRgE374JiBeJPQeTEoZpANg@mail.gmail.com>
        <20200203142712.a7yvlyo2y3le5cpn@e107158-lin>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2020 14:27:14 +0000
Qais Yousef <qais.yousef@arm.com> wrote:

> I don't see one right answer here. The current mechanism could certainly do
> better; but it's not clear what better means without delving into system
> specific details. I am open to any suggestions to improve it.

The way I see this is that if there's no big cores available but little
cores are, and the RT task has those cores in its affinity mask then
the task most definitely should consider moving to the little core. The
cpu_find() should return them!

But, what we can do is to mark the little core that's running an RT
task on a it that prefers bigger cores, as "rt-overloaded".  This will
add this core into the being looked at when another core schedules out
an RT task. When that happens, the RT task on the little core will get
pulled back to the big core.

Here's what I propose.

1. Scheduling of an RT task that wants big cores, but has little cores
in its affinity.

2. Calls cpu_find() which will look to place it first on a big core, if
there's a core that is running a task that is lower priority than
itself.

3. If all the big cores have RT tasks it can not preempt, look to find
a little core.

4. If a little core is returned, and we schedule an RT task that
prefers big cores on it, we mark it overloaded.

5. An RT task on a big core schedules out. Start looking at the RT
overloaded run queues.

6. See that there's an RT task on the little core, and migrate it over.


Note, this will require a bit more logic as the overloaded code wasn't
designed for migration of running tasks, but that could be added.

-- Steve
