Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB703C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3D82098B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgDUIhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:37:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:29758 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUIhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:37:45 -0400
IronPort-SDR: r29xraq78hBiIhTHoza3FL1uTErqPK4A0EdPgKDte7i4WhRSgedea6wXNA2S5Sadw8TJ0ZURd0
 XPCxg0WYpr5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 01:37:44 -0700
IronPort-SDR: CEHbwDgISfbBnr3/OcAdWR6P1aWQPaTA2mGHl9y6W7jCn4K1uZuWdDCyELQdmIw/me8+TRYmwq
 EpTe7YWZRMBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,409,1580803200"; 
   d="scan'208";a="456688398"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga006.fm.intel.com with ESMTP; 21 Apr 2020 01:37:42 -0700
Date:   Tue, 21 Apr 2020 16:38:12 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 2/2] sched: Extract the task putting code from
 pick_next_task()
Message-ID: <20200421083812.GE9721@chenyu-office.sh.intel.com>
References: <cover.1587309963.git.yu.c.chen@intel.com>
 <7c1eab789cb4b53ec5f54644c089ce27ea14088a.1587309963.git.yu.c.chen@intel.com>
 <20200420183232.16b83374@gandalf.local.home>
 <jhjwo69lqcm.mognet@arm.com>
 <20200420231355.GU2483@worktop.programming.kicks-ass.net>
 <20200420222319.34f9f646@oasis.local.home>
 <CAKfTPtBG=Nu+76NywfD0rk-BmT=2egTd_9FaPU4oCP1D_eyuBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBG=Nu+76NywfD0rk-BmT=2egTd_9FaPU4oCP1D_eyuBQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 09:42:26AM +0200, Vincent Guittot wrote:
> On Tue, 21 Apr 2020 at 04:23, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 21 Apr 2020 01:13:55 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > > The 'finish' thing isn't too far from the truth; it's the last thing we
> > > > need to do with the prev task (in terms of sched bookkeeping, I mean) -
> > > > and in Chen's defence ISTR Peter suggested that name.
> > > >
> > > > Seeing as it's a "supercharged" put_prev_task(), I could live with the
> > > > marginally shorter "put_prev_task_balance()".
> > >
> > > What Valentin said; it's the last put we do before picking a new task.
> > > Also, I don't like long names. That said, I'm open to short and
> > > appropriate suggestions.
> >
> > I wont bikeshed this too much.
> >
> > Is the "finish" more appropriate with the other use cases that are
> > coming. I do like that "put_prev_task_balance()" too.
> 
> This name looks reasonnable
>
Okay, I'll change it to this name.

Thanks,
Chenyu
> >
> > -- Steve
