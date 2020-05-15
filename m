Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE0CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2A920727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgEOBdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 21:33:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:13334 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgEOBdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 21:33:44 -0400
IronPort-SDR: BmrZePuu1tvn8YUlGhPkhMmUxy8QzBgLJA/uk/dVnn2iwbenH7+pW6wTohj093av+f1uh+lZXh
 6mMuUTZW6YjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 18:33:44 -0700
IronPort-SDR: Im6fgqTxAvztK1qFPSFDucoKTzQvr16bT3x6hQFF3D64IZ44fbwCy5S1Uq6PBJhWOhS8aRPGWq
 BMCkGVxnjdQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,393,1583222400"; 
   d="scan'208";a="410287701"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga004.jf.intel.com with ESMTP; 14 May 2020 18:33:41 -0700
Date:   Fri, 15 May 2020 09:43:39 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        OTC LSE PnP <otc.lse.pnp@intel.com>, oliver.sang@intel.com
Subject: Re: [sched/fair] 0b0695f2b3:
 phoronix-test-suite.compress-gzip.0.seconds 19.8% regression
Message-ID: <20200515014339.GA9854@xsang-OptiPlex-9020>
References: <20200514141526.GA30976@xsang-OptiPlex-9020>
 <CAKfTPtB3jQWd52FTyKNk5w8mmoDnu+jwYgkFBOiOKjb_BjxqTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB3jQWd52FTyKNk5w8mmoDnu+jwYgkFBOiOKjb_BjxqTw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 07:09:35PM +0200, Vincent Guittot wrote:
> Hi Oliver,
> 
> On Thu, 14 May 2020 at 16:05, kernel test robot <oliver.sang@intel.com> wrote:
> >
> > Hi Vincent Guittot,
> >
> > Below report FYI.
> > Last year, we actually reported an improvement "[sched/fair] 0b0695f2b3:
> > vm-scalability.median 3.1% improvement" on link [1].
> > but now we found the regression on pts.compress-gzip.
> > This seems align with what showed in "[v4,00/10] sched/fair: rework the CFS
> > load balance" (link [2]), where showed the reworked load balance could have
> > both positive and negative effect for different test suites.
> 
> We have tried to run  all possible use cases but it's impossible to
> covers all so there were a possibility that one that is not covered,
> would regressed.
> 
> > And also from link [3], the patch set risks regressions.
> >
> > We also confirmed this regression on another platform
> > (Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 8G memory),
> > below is the data (lower is better).
> > v5.4    4.1
> > fcf0553db6f4c79387864f6e4ab4a891601f395e    4.01
> > 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912    4.89
> > v5.5    5.18
> > v5.6    4.62
> > v5.7-rc2    4.53
> > v5.7-rc3    4.59
> >
> > It seems there are some recovery on latest kernels, but not fully back.
> > We were just wondering whether you could share some lights the further works
> > on the load balance after patch set [2] which could cause the performance
> > change?
> > And whether you have plan to refine the load balance algorithm further?
> 
> I'm going to have a look at your regression to understand what is
> going wrong and how it can be fixed

Thanks a lot!

> 
> Thanks
> Vincent
> 
