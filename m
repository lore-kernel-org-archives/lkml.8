Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B28DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D873120738
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFBFLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:11:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:36489 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgFBFLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:11:49 -0400
IronPort-SDR: x8haLGhrvdl8b10Es8Q+p2vpQAGgpf1/qg/kmzASDTTa/tz1zAVv35oG/+uyPig/QW79iv7ZKa
 JcLnJekNbV5g==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 22:11:44 -0700
IronPort-SDR: RfzGJRscahmaEkjSGf58WWxKX797C2XgJjSlGRPec22XNCjneLvGqlAArGNCvunedmTQg2O48V
 RzQr0+JbVtFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="tgz'50?json'50?scan'50,208,49,50";a="377626322"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jun 2020 22:11:38 -0700
Date:   Tue, 2 Jun 2020 13:23:19 +0800
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
        OTC LSE PnP <otc.lse.pnp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Si, Beibei" <beibei.si@intel.com>,
        "Du, Julie" <julie.du@intel.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        "Li, Aubrey" <aubrey.li@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        Rui Zhang <rui.zhang@intel.com>, oliver.sang@intel.com
Subject: Re: [sched/fair] 0b0695f2b3:
 phoronix-test-suite.compress-gzip.0.seconds 19.8% regression
Message-ID: <20200602052319.GA24856@xsang-OptiPlex-9020>
References: <20200514141526.GA30976@xsang-OptiPlex-9020>
 <CAKfTPtB3jQWd52FTyKNk5w8mmoDnu+jwYgkFBOiOKjb_BjxqTw@mail.gmail.com>
 <CAKfTPtCnnCcoN8m+qcPZNhO_RjkwRwiPT4Qq1qYRqTPn8Z_prQ@mail.gmail.com>
 <20200521083815.GA19280@xsang-OptiPlex-9020>
 <CAKfTPtD+JW-mBt20vHAwOBxo7wbYG3seAc2+t2dWkqSzxf3dSQ@mail.gmail.com>
 <CAKfTPtA8bGTGr2jDiGqA9R_FAZUzFBwvthJmunDjBUdzQF3wJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <CAKfTPtA8bGTGr2jDiGqA9R_FAZUzFBwvthJmunDjBUdzQF3wJQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 07:26:01PM +0200, Vincent Guittot wrote:
> On Mon, 25 May 2020 at 10:02, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Thu, 21 May 2020 at 10:28, Oliver Sang <oliver.sang@intel.com> wrote:
> > >
> > > On Wed, May 20, 2020 at 03:04:48PM +0200, Vincent Guittot wrote:
> > > > On Thu, 14 May 2020 at 19:09, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > Hi Oliver,
> > > > >
> > > > > On Thu, 14 May 2020 at 16:05, kernel test robot <oliver.sang@intel.com> wrote:
> > > > > >
> > > > > > Hi Vincent Guittot,
> > > > > >
> > > > > > Below report FYI.
> > > > > > Last year, we actually reported an improvement "[sched/fair] 0b0695f2b3:
> > > > > > vm-scalability.median 3.1% improvement" on link [1].
> > > > > > but now we found the regression on pts.compress-gzip.
> > > > > > This seems align with what showed in "[v4,00/10] sched/fair: rework the CFS
> > > > > > load balance" (link [2]), where showed the reworked load balance could have
> > > > > > both positive and negative effect for different test suites.
> > > > >
> > > > > We have tried to run  all possible use cases but it's impossible to
> > > > > covers all so there were a possibility that one that is not covered,
> > > > > would regressed.
> > > > >
> > > > > > And also from link [3], the patch set risks regressions.
> > > > > >
> > > > > > We also confirmed this regression on another platform
> > > > > > (Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 8G memory),
> > > > > > below is the data (lower is better).
> > > > > > v5.4    4.1
> > > > > > fcf0553db6f4c79387864f6e4ab4a891601f395e    4.01
> > > > > > 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912    4.89
> > > > > > v5.5    5.18
> > > > > > v5.6    4.62
> > > > > > v5.7-rc2    4.53
> > > > > > v5.7-rc3    4.59
> > > > > >
> > > > > > It seems there are some recovery on latest kernels, but not fully back.
> > > > > > We were just wondering whether you could share some lights the further works
> > > > > > on the load balance after patch set [2] which could cause the performance
> > > > > > change?
> > > > > > And whether you have plan to refine the load balance algorithm further?
> > > > >
> > > > > I'm going to have a look at your regression to understand what is
> > > > > going wrong and how it can be fixed
> > > >
> > > > I have run the benchmark on my local setups to try to reproduce the
> > > > regression and I don't see the regression. But my setups are different
> > > > from your so it might be a problem specific to yours
> > >
> > > Hi Vincent, which OS are you using? We found the regression on Clear OS,
> > > but it cannot reproduce on Debian.
> > > On https://www.phoronix.com/scan.php?page=article&item=mac-win-linux2018&num=5
> > > it was mentioned that -
> > > Gzip compression is much faster out-of-the-box on Clear Linux due to it exploiting
> > > multi-threading capabilities compared to the other operating systems Gzip support.
> >
> > I'm using Debian, I haven't noticed it was only on Clear OS.
> > I'm going to look at it. Could you send me traces in the meantime ?
> 
> I run more tests to understand the problem. Even if Clear Linux uses
> multithreading, the system is not overloaded and there is a
> significant amount of idle time. This means that we use the has_spare
> capacity path that spreads tasks on the system. At least that is what
> I have seen in the KVM image. Beside this, I think that I have been
> able to reproduce the problem on my platform with debian using pigz
> instead of gzip for the compress-gzip-1.2.0 test. On my platform, I
> can see a difference when I enable all CPU idle states whereas there
> is no performance difference when only the shallowest idle state is
> enabled.
> 
> The new load balance rework is more efficient at spreading tasks on
> the system and one side effect could be that there is more idle time
> between tasks wake up on each CPU. As a result, CPUs have to wake up
> from a deeper idle state. This could explain the +54% increase of C6
> usage that is reported.  Is it possible to get All C-state statistics
> ?

Hi Vincent, sorry for late. I selected the turbostat while running
compress-gzip on Clear OS, as attached. Besides v5.4 and v5.7-rc7,
I got the data for v5.5 and v5.7, too. Not sure it's enough since you
said "All C-state statistics". Hope it could be useful and if you want
more data, please let us know.

Again, I collect these data on our "Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz
with 8G memory" platform. for each release, I ran test twice to assure
the results consistent.

phoronix-test-suite.compress-gzip.0.seconds
release		run1	run2
v5.4		4.37	4.37
v5.5		5.37	5.46
v5.7-rc7	4.82	4.85
v5.7		4.86	4.83

> 
> Could you run the test after disabling deep idle states like C6 and
> above and check what is the difference between v5.7-rc7 and v5.4 ?

thanks for suggestion, will collect this data later.

> comparing fcf0553db6 ("sched/fair: Remove meaningless imbalance
> calculation") and
>   0b0695f2b3 ("sched/fair: Rework load_balance()") is not really
> useful because they are part of the same rework and should be
> considered a one single change.
> 
> >
> > >
> > > >
> > > > After analysing the benchmark, it doesn't overload the system and is
> > > > mainly based on 1 main gzip thread with few others waking up and
> > > > sleeping around.
> > > >
> > > > I thought that scheduler could be too aggressive when trying to
> > > > balance the threads on your system, which could generate more task
> > > > migrations and impact the performance. But this doesn't seem to be the
> > > > case because perf-stat.i.cpu-migrations is -8%. On the other side, the
> > > > context switch is +16% and more interestingly idle state C1E and C6
> > > > usages increase more than 50%. I don't know if we can rely or this
> > > > value or not but I wonder if it could be that threads are now spread
> > > > on different CPUs which generates idle time on the busy CPUs but the
> > > > added time to enter/leave these states hurts the performance.
> > > >
> > > > Could you make some traces of both kernels ? Tracing sched events
> > > > should be enough to understand the behavior
> > > >
> > > > Regards,
> > > > Vincent
> > > >
> > > > >
> > > > > Thanks
> > > > > Vincent
> > > > >
> > > > > > thanks
> > > > > >
> > > > > > [1] https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/SANC7QLYZKUNMM6O7UNR3OAQAKS5BESE/
> > > > > > [2] https://lore.kernel.org/patchwork/cover/1141687/
> > > > > > [3] https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.5-Scheduler

--Q68bSM7Ycu6FN28Q
Content-Type: application/x-gtar-compressed
Content-Disposition: attachment; filename="compress-gzip-turbostat.tgz"
Content-Transfer-Encoding: base64

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
Zvv72/8Dqb6Q5ABoAQA=

--Q68bSM7Ycu6FN28Q--
