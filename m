Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE904C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB862070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgEUI23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:28:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:25542 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgEUI22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:28:28 -0400
IronPort-SDR: XsOmRlSZEdVkYgdrFG+6vsEP+c3GCK440C8LGdt8tNAdTVHTEP7hS7Xzowe3ybUv5NoSM1aMiQ
 7P02EqFL5SsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 01:28:27 -0700
IronPort-SDR: 2XqH1//BlcuXLUSNAADl6V49RRN3nvt8ef7TB35ONPE91zxEogfGyzUb1FZXZAyW1B6hPvuO//
 5yq671fEsMCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,417,1583222400"; 
   d="scan'208";a="264979175"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga003.jf.intel.com with ESMTP; 21 May 2020 01:28:24 -0700
Date:   Thu, 21 May 2020 16:38:15 +0800
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
        OTC LSE PnP <otc.lse.pnp@intel.com>, ying.huang@intel.com
Subject: Re: [sched/fair] 0b0695f2b3:
 phoronix-test-suite.compress-gzip.0.seconds 19.8% regression
Message-ID: <20200521083815.GA19280@xsang-OptiPlex-9020>
References: <20200514141526.GA30976@xsang-OptiPlex-9020>
 <CAKfTPtB3jQWd52FTyKNk5w8mmoDnu+jwYgkFBOiOKjb_BjxqTw@mail.gmail.com>
 <CAKfTPtCnnCcoN8m+qcPZNhO_RjkwRwiPT4Qq1qYRqTPn8Z_prQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCnnCcoN8m+qcPZNhO_RjkwRwiPT4Qq1qYRqTPn8Z_prQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 03:04:48PM +0200, Vincent Guittot wrote:
> On Thu, 14 May 2020 at 19:09, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Hi Oliver,
> >
> > On Thu, 14 May 2020 at 16:05, kernel test robot <oliver.sang@intel.com> wrote:
> > >
> > > Hi Vincent Guittot,
> > >
> > > Below report FYI.
> > > Last year, we actually reported an improvement "[sched/fair] 0b0695f2b3:
> > > vm-scalability.median 3.1% improvement" on link [1].
> > > but now we found the regression on pts.compress-gzip.
> > > This seems align with what showed in "[v4,00/10] sched/fair: rework the CFS
> > > load balance" (link [2]), where showed the reworked load balance could have
> > > both positive and negative effect for different test suites.
> >
> > We have tried to run  all possible use cases but it's impossible to
> > covers all so there were a possibility that one that is not covered,
> > would regressed.
> >
> > > And also from link [3], the patch set risks regressions.
> > >
> > > We also confirmed this regression on another platform
> > > (Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 8G memory),
> > > below is the data (lower is better).
> > > v5.4    4.1
> > > fcf0553db6f4c79387864f6e4ab4a891601f395e    4.01
> > > 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912    4.89
> > > v5.5    5.18
> > > v5.6    4.62
> > > v5.7-rc2    4.53
> > > v5.7-rc3    4.59
> > >
> > > It seems there are some recovery on latest kernels, but not fully back.
> > > We were just wondering whether you could share some lights the further works
> > > on the load balance after patch set [2] which could cause the performance
> > > change?
> > > And whether you have plan to refine the load balance algorithm further?
> >
> > I'm going to have a look at your regression to understand what is
> > going wrong and how it can be fixed
> 
> I have run the benchmark on my local setups to try to reproduce the
> regression and I don't see the regression. But my setups are different
> from your so it might be a problem specific to yours

Hi Vincent, which OS are you using? We found the regression on Clear OS,
but it cannot reproduce on Debian.
On https://www.phoronix.com/scan.php?page=article&item=mac-win-linux2018&num=5
it was mentioned that -
Gzip compression is much faster out-of-the-box on Clear Linux due to it exploiting
multi-threading capabilities compared to the other operating systems Gzip support. 

> 
> After analysing the benchmark, it doesn't overload the system and is
> mainly based on 1 main gzip thread with few others waking up and
> sleeping around.
> 
> I thought that scheduler could be too aggressive when trying to
> balance the threads on your system, which could generate more task
> migrations and impact the performance. But this doesn't seem to be the
> case because perf-stat.i.cpu-migrations is -8%. On the other side, the
> context switch is +16% and more interestingly idle state C1E and C6
> usages increase more than 50%. I don't know if we can rely or this
> value or not but I wonder if it could be that threads are now spread
> on different CPUs which generates idle time on the busy CPUs but the
> added time to enter/leave these states hurts the performance.
> 
> Could you make some traces of both kernels ? Tracing sched events
> should be enough to understand the behavior
> 
> Regards,
> Vincent
> 
> >
> > Thanks
> > Vincent
> >
> > > thanks
> > >
> > > [1] https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/SANC7QLYZKUNMM6O7UNR3OAQAKS5BESE/
> > > [2] https://lore.kernel.org/patchwork/cover/1141687/
> > > [3] https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.5-Scheduler
