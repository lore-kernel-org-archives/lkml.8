Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC22C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B48206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBUJE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:04:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:36002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgBUJEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:04:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6BB1DAD08;
        Fri, 21 Feb 2020 09:04:52 +0000 (UTC)
Date:   Fri, 21 Feb 2020 09:04:48 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v3 4/5] sched/pelt: Add a new runnable average signal
Message-ID: <20200221090448.GQ3420@suse.de>
References: <20200214152729.6059-5-vincent.guittot@linaro.org>
 <20200219125513.8953-1-vincent.guittot@linaro.org>
 <9fe822fc-c311-2b97-ae14-b9269dd99f1e@arm.com>
 <CAKfTPtD4kz07hikCuU2_cm67ntruopN9CdJEP+fg5L4_N=qEgg@mail.gmail.com>
 <d9f78b94-2455-e000-82bd-c00cfb9bbc8e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d9f78b94-2455-e000-82bd-c00cfb9bbc8e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 04:11:18PM +0000, Valentin Schneider wrote:
> On 20/02/2020 14:36, Vincent Guittot wrote:
> > I agree that setting by default to SCHED_CAPACITY_SCALE is too much
> > for little core.
> > The problem for little core can be fixed by using the cpu capacity instead
> > 
> 
> So that's indeed better for big.LITTLE & co. Any reason however for not
> aligning with the initialization of util_avg ?
> 
> With the default MC imbalance_pct (117), it takes 875 utilization to make
> a single CPU group (with 1024 capacity) overloaded (group_is_overloaded()).
> For a completely idle CPU, that means forking at least 3 tasks (512 + 256 +
> 128 util_avg)
> 
> With your change, it only takes 2 tasks. I know I'm being nitpicky here, but
> I feel like those should be aligned, unless we have a proper argument against
> it - in which case this should also appear in the changelog with so far only
> mentions issues with util_avg migration, not the fork time initialization.
> 

So, what is the way forward here? Should this patch be modified now,
a patch be placed on top or go with what we have for the moment that
works for symmetric CPUs and deal with the asym case later?

I do not have any asym systems at all so I've no means of checking
whether there is a problem or not.

-- 
Mel Gorman
SUSE Labs
