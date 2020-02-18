Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF3FC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40B121D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBRSDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:03:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgBRSDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:03:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2714C2070B;
        Tue, 18 Feb 2020 18:03:02 +0000 (UTC)
Date:   Tue, 18 Feb 2020 13:03:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/rt: cpupri_find: implement fallback mechanism
 for !fit case
Message-ID: <20200218130300.679f77ea@gandalf.local.home>
In-Reply-To: <20200218172745.hd7fxjqnzqkhfqx3@e107158-lin.cambridge.arm.com>
References: <20200214163949.27850-1-qais.yousef@arm.com>
        <20200214163949.27850-2-qais.yousef@arm.com>
        <c0772fca-0a4b-c88d-fdf2-5715fcf8447b@arm.com>
        <20200217234549.rpv3ns7bd7l6twqu@e107158-lin>
        <20200218114658.74236b3c@gandalf.local.home>
        <20200218172745.hd7fxjqnzqkhfqx3@e107158-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 17:27:46 +0000
Qais Yousef <qais.yousef@arm.com> wrote:

> > If we are going to use static branches, then lets just remove the
> > parameter totally. That is, make two functions (with helpers), where
> > one needs this fitness function the other does not.
> > 
> > 	if (static_branch_unlikely(&sched_asym_cpu_capacity))
> > 		ret = cpupri_find_fitness(...);
> > 	else
> > 		ret = cpupri_find(...);
> > 
> > 	if (!ret)
> > 		return -1;
> > 
> > Something like that?  
> 
> Is there any implication on code generation here?
> 
> I like my flavour better tbh. But I don't mind refactoring the function out if
> it does make it more readable.

I just figured we remove the passing of the parameter (which does make
an impact on the code generation).

Also, perhaps it would be better to not have to pass functions to the
cpupri_find(). Is there any other function that needs to be past, or
just this one in this series?

-- Steve
