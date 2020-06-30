Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D10C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE17920724
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389643AbgF3SEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:04:50 -0400
Received: from foss.arm.com ([217.140.110.172]:51326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbgF3SEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:04:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 989891FB;
        Tue, 30 Jun 2020 11:04:49 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED13A3F68F;
        Tue, 30 Jun 2020 11:04:47 -0700 (PDT)
Date:   Tue, 30 Jun 2020 19:04:45 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
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
Subject: Re: [PATCH v5 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200630180445.dvhm5fje6cuk6h4g@e107158-lin.cambridge.arm.com>
References: <20200629162633.8800-1-qais.yousef@arm.com>
 <20200629162633.8800-3-qais.yousef@arm.com>
 <87366dnfaq.derkling@matbug.net>
 <20200630094623.hnlqtgavauqlsuyd@e107158-lin.cambridge.arm.com>
 <87zh8kmwlt.derkling@matbug.net>
 <20200630154033.5r6zi7ajgag7jlec@e107158-lin.cambridge.arm.com>
 <87wo3omot7.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wo3omot7.derkling@matbug.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/20 19:44, Patrick Bellasi wrote:

[...]

> > I am sorry there's no written rule that says one should do it in a specific
> > way. And AFAIK both way are implemented in the kernel. I appreciate your
> > suggestion but as the person who did all the hard work, I think my preference
> > matters here too.
> 
> You sure know that sometime reviewing code can be an "hard work" too, so I
> would not go down that way at all with the discussion. Quite likely I
> have a different "subjective" view on how Open Source development works.
> 
> > And actually with my approach when uclamp is not compiled in there's no need to
> > define an extra variable; and since uclamp_is_used() is defined as false for
> > !CONFIG_UCLAMP_TASK, it'll help with DCE, so less likely to end up with dead
> > code that'll never run in the final binary.
> 
> Good, this is the simple and small reply I've politely asked for.

I am sorry if I offended you. I took all your comments seriously and answered
them to the best of my ability. All of your comments and suggestions were
highly appreciated too. If the wrong message reached across, rest assured it
wasn't the intended one.

Thanks

--
Qais Yousef
