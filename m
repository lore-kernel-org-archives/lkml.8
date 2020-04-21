Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E794C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D36C2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgDUCXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:23:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgDUCXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:23:22 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74A5E2082E;
        Tue, 21 Apr 2020 02:23:21 +0000 (UTC)
Date:   Mon, 20 Apr 2020 22:23:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 2/2] sched: Extract the task putting code from
 pick_next_task()
Message-ID: <20200420222319.34f9f646@oasis.local.home>
In-Reply-To: <20200420231355.GU2483@worktop.programming.kicks-ass.net>
References: <cover.1587309963.git.yu.c.chen@intel.com>
        <7c1eab789cb4b53ec5f54644c089ce27ea14088a.1587309963.git.yu.c.chen@intel.com>
        <20200420183232.16b83374@gandalf.local.home>
        <jhjwo69lqcm.mognet@arm.com>
        <20200420231355.GU2483@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 01:13:55 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > The 'finish' thing isn't too far from the truth; it's the last thing we
> > need to do with the prev task (in terms of sched bookkeeping, I mean) -
> > and in Chen's defence ISTR Peter suggested that name.
> > 
> > Seeing as it's a "supercharged" put_prev_task(), I could live with the
> > marginally shorter "put_prev_task_balance()".  
> 
> What Valentin said; it's the last put we do before picking a new task.
> Also, I don't like long names. That said, I'm open to short and
> appropriate suggestions.

I wont bikeshed this too much.

Is the "finish" more appropriate with the other use cases that are
coming. I do like that "put_prev_task_balance()" too.

-- Steve
