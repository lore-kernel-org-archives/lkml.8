Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B693FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C4B206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgFDI5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:57:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:40502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbgFDI5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:57:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7982AACA7;
        Thu,  4 Jun 2020 08:57:05 +0000 (UTC)
Date:   Thu, 4 Jun 2020 09:56:56 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        OTC LSE PnP <otc.lse.pnp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Si, Beibei" <beibei.si@intel.com>,
        "Du, Julie" <julie.du@intel.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        "Li, Aubrey" <aubrey.li@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>, Rui Zhang <rui.zhang@intel.com>
Subject: Re: [sched/fair] 0b0695f2b3:
 phoronix-test-suite.compress-gzip.0.seconds 19.8% regression
Message-ID: <20200604085656.GI3070@suse.de>
References: <20200514141526.GA30976@xsang-OptiPlex-9020>
 <CAKfTPtB3jQWd52FTyKNk5w8mmoDnu+jwYgkFBOiOKjb_BjxqTw@mail.gmail.com>
 <CAKfTPtCnnCcoN8m+qcPZNhO_RjkwRwiPT4Qq1qYRqTPn8Z_prQ@mail.gmail.com>
 <20200521083815.GA19280@xsang-OptiPlex-9020>
 <CAKfTPtD+JW-mBt20vHAwOBxo7wbYG3seAc2+t2dWkqSzxf3dSQ@mail.gmail.com>
 <CAKfTPtA8bGTGr2jDiGqA9R_FAZUzFBwvthJmunDjBUdzQF3wJQ@mail.gmail.com>
 <20200602052319.GA24856@xsang-OptiPlex-9020>
 <20200602142305.GA31901@xsang-OptiPlex-9020>
 <CAKfTPtBLKUBF_p-LxfRce2nJQFqGj95KZ+yisAN_qrMq5VxW=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBLKUBF_p-LxfRce2nJQFqGj95KZ+yisAN_qrMq5VxW=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 07:06:18PM +0200, Vincent Guittot wrote:
> > still exists, just the gap becomes smaller -
> > release         run1    run2
> > v5.4            4.32    4.3     <-- little change comparing to above
> > v5.5            5.04    5.06    <-- improves
> > v5.7-rc7        4.79    4.78
> > v5.7            4.77    4.77
> >
> > I also attached turbostat data as attached.
> 
> Thanks for the test results and the turbo stats figures.
> The outcomes are not as obvious as I would have expected. The
> performance difference for v5.5 and v5.7 when C6 and above are
> disabled tends to confirm that the idle state is impacting the
> performance but the difference still remain.
> Regarding turbostat output, the 1st main difference is the number of
> time the CPUs entered idle state:
> v5.4 run1 : 587252+905317+367732+859828+108+332436+110+217=3053000
> v5.7 run1 : 807623+639635+466723+1298557+108+283548+63+156=3496413
> which is +14% of entering idle.
> This is even more obvious on v5.5 run1:
> 761950+1320362+1681750+682042+91+304755+79+243=4751272 which is +55%
> of entering idle
> 
> We have a similar ratio without c6 and above c-state between v5.4 and
> v5.7 and the ratio has decreased to +22% between v5.4 and v5.5.
> 
> So this tends to confirm my assumption that tasks are more spread and
> this generates more enter/leave cpuidle. I still need to think about
> how to balance this
> 

I have not looked into the data in depth but it's worth noting that
cpuidle changed the time a CPU spent polling before entering a C state
within the same window.  See 36fcb4292473 ("cpuidle: use first valid target
residency as poll time") as an example where poll time went from hundreds
of nanoseconds to single digits depending on the machine. We used to poll
for up to a tick before entering idle. I'm not saying whether it's good
or bad but it certainly can have a big impact on how often a CPU enters
"true idle in a C state" as opposed to switching to the idle task (swapper)
for some house keeping.

Where things get fun is that the scheduler can make this more or less
obvious depending on its decisions. If tasks are bouncing like crazy around
a socket, the load balancer is shifting tasks like crazy or the scheduler
is stacking tasks when it should not then it can potentially perform
better in a benchmark if it prevents tasks entering a deep idle state.

-- 
Mel Gorman
SUSE Labs
