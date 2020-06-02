Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC92EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96D82086A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgFBOSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:18:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:58044 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFBOSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:18:34 -0400
IronPort-SDR: GHlq/+b4ino96+WabMbkPMRzxwI/AjfONriYMPEgxIYVdDtzltpa6bFEVuLMrsPwo/mRsGMDTC
 BGlMYCkbcmcQ==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 07:11:31 -0700
IronPort-SDR: vVcEmRG6Eby1PYrJpX3LrKvErDz5GWDTvk48nvj4IjbItgQSwKA8BLfgz3QBvmD2edNO0yMJjV
 nBgDPjlQAX5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,464,1583222400"; 
   d="tgz'50?json'50?scan'50,208,49,50";a="268711666"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2020 07:11:24 -0700
Date:   Tue, 2 Jun 2020 22:23:05 +0800
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
Message-ID: <20200602142305.GA31901@xsang-OptiPlex-9020>
References: <20200514141526.GA30976@xsang-OptiPlex-9020>
 <CAKfTPtB3jQWd52FTyKNk5w8mmoDnu+jwYgkFBOiOKjb_BjxqTw@mail.gmail.com>
 <CAKfTPtCnnCcoN8m+qcPZNhO_RjkwRwiPT4Qq1qYRqTPn8Z_prQ@mail.gmail.com>
 <20200521083815.GA19280@xsang-OptiPlex-9020>
 <CAKfTPtD+JW-mBt20vHAwOBxo7wbYG3seAc2+t2dWkqSzxf3dSQ@mail.gmail.com>
 <CAKfTPtA8bGTGr2jDiGqA9R_FAZUzFBwvthJmunDjBUdzQF3wJQ@mail.gmail.com>
 <20200602052319.GA24856@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20200602052319.GA24856@xsang-OptiPlex-9020>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2020 at 01:23:19PM +0800, Oliver Sang wrote:
> On Fri, May 29, 2020 at 07:26:01PM +0200, Vincent Guittot wrote:
> > On Mon, 25 May 2020 at 10:02, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Thu, 21 May 2020 at 10:28, Oliver Sang <oliver.sang@intel.com> wrote:
> > > >
> > > > On Wed, May 20, 2020 at 03:04:48PM +0200, Vincent Guittot wrote:
> > > > > On Thu, 14 May 2020 at 19:09, Vincent Guittot
> > > > > <vincent.guittot@linaro.org> wrote:
> > > > > >
> > > > > > Hi Oliver,
> > > > > >
> > > > > > On Thu, 14 May 2020 at 16:05, kernel test robot <oliver.sang@intel.com> wrote:
> > > > > > >
> > > > > > > Hi Vincent Guittot,
> > > > > > >
> > > > > > > Below report FYI.
> > > > > > > Last year, we actually reported an improvement "[sched/fair] 0b0695f2b3:
> > > > > > > vm-scalability.median 3.1% improvement" on link [1].
> > > > > > > but now we found the regression on pts.compress-gzip.
> > > > > > > This seems align with what showed in "[v4,00/10] sched/fair: rework the CFS
> > > > > > > load balance" (link [2]), where showed the reworked load balance could have
> > > > > > > both positive and negative effect for different test suites.
> > > > > >
> > > > > > We have tried to run  all possible use cases but it's impossible to
> > > > > > covers all so there were a possibility that one that is not covered,
> > > > > > would regressed.
> > > > > >
> > > > > > > And also from link [3], the patch set risks regressions.
> > > > > > >
> > > > > > > We also confirmed this regression on another platform
> > > > > > > (Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 8G memory),
> > > > > > > below is the data (lower is better).
> > > > > > > v5.4    4.1
> > > > > > > fcf0553db6f4c79387864f6e4ab4a891601f395e    4.01
> > > > > > > 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912    4.89
> > > > > > > v5.5    5.18
> > > > > > > v5.6    4.62
> > > > > > > v5.7-rc2    4.53
> > > > > > > v5.7-rc3    4.59
> > > > > > >
> > > > > > > It seems there are some recovery on latest kernels, but not fully back.
> > > > > > > We were just wondering whether you could share some lights the further works
> > > > > > > on the load balance after patch set [2] which could cause the performance
> > > > > > > change?
> > > > > > > And whether you have plan to refine the load balance algorithm further?
> > > > > >
> > > > > > I'm going to have a look at your regression to understand what is
> > > > > > going wrong and how it can be fixed
> > > > >
> > > > > I have run the benchmark on my local setups to try to reproduce the
> > > > > regression and I don't see the regression. But my setups are different
> > > > > from your so it might be a problem specific to yours
> > > >
> > > > Hi Vincent, which OS are you using? We found the regression on Clear OS,
> > > > but it cannot reproduce on Debian.
> > > > On https://www.phoronix.com/scan.php?page=article&item=mac-win-linux2018&num=5
> > > > it was mentioned that -
> > > > Gzip compression is much faster out-of-the-box on Clear Linux due to it exploiting
> > > > multi-threading capabilities compared to the other operating systems Gzip support.
> > >
> > > I'm using Debian, I haven't noticed it was only on Clear OS.
> > > I'm going to look at it. Could you send me traces in the meantime ?
> > 
> > I run more tests to understand the problem. Even if Clear Linux uses
> > multithreading, the system is not overloaded and there is a
> > significant amount of idle time. This means that we use the has_spare
> > capacity path that spreads tasks on the system. At least that is what
> > I have seen in the KVM image. Beside this, I think that I have been
> > able to reproduce the problem on my platform with debian using pigz
> > instead of gzip for the compress-gzip-1.2.0 test. On my platform, I
> > can see a difference when I enable all CPU idle states whereas there
> > is no performance difference when only the shallowest idle state is
> > enabled.
> > 
> > The new load balance rework is more efficient at spreading tasks on
> > the system and one side effect could be that there is more idle time
> > between tasks wake up on each CPU. As a result, CPUs have to wake up
> > from a deeper idle state. This could explain the +54% increase of C6
> > usage that is reported.  Is it possible to get All C-state statistics
> > ?
> 
> Hi Vincent, sorry for late. I selected the turbostat while running
> compress-gzip on Clear OS, as attached. Besides v5.4 and v5.7-rc7,
> I got the data for v5.5 and v5.7, too. Not sure it's enough since you
> said "All C-state statistics". Hope it could be useful and if you want
> more data, please let us know.
> 
> Again, I collect these data on our "Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz
> with 8G memory" platform. for each release, I ran test twice to assure
> the results consistent.
> 
> phoronix-test-suite.compress-gzip.0.seconds
> release		run1	run2
> v5.4		4.37	4.37
> v5.5		5.37	5.46
> v5.7-rc7	4.82	4.85
> v5.7		4.86	4.83
> 
> > 
> > Could you run the test after disabling deep idle states like C6 and
> > above and check what is the difference between v5.7-rc7 and v5.4 ?
> 
> thanks for suggestion, will collect this data later.

Hi Vincent, I test by disabling deep idle states, but the regression
still exists, just the gap becomes smaller -
release		run1	run2
v5.4		4.32	4.3	<-- little change comparing to above
v5.5		5.04	5.06	<-- improves
v5.7-rc7	4.79	4.78
v5.7		4.77	4.77

I also attached turbostat data as attached.

> 
> > comparing fcf0553db6 ("sched/fair: Remove meaningless imbalance
> > calculation") and
> >   0b0695f2b3 ("sched/fair: Rework load_balance()") is not really
> > useful because they are part of the same rework and should be
> > considered a one single change.
> > 
> > >
> > > >
> > > > >
> > > > > After analysing the benchmark, it doesn't overload the system and is
> > > > > mainly based on 1 main gzip thread with few others waking up and
> > > > > sleeping around.
> > > > >
> > > > > I thought that scheduler could be too aggressive when trying to
> > > > > balance the threads on your system, which could generate more task
> > > > > migrations and impact the performance. But this doesn't seem to be the
> > > > > case because perf-stat.i.cpu-migrations is -8%. On the other side, the
> > > > > context switch is +16% and more interestingly idle state C1E and C6
> > > > > usages increase more than 50%. I don't know if we can rely or this
> > > > > value or not but I wonder if it could be that threads are now spread
> > > > > on different CPUs which generates idle time on the busy CPUs but the
> > > > > added time to enter/leave these states hurts the performance.
> > > > >
> > > > > Could you make some traces of both kernels ? Tracing sched events
> > > > > should be enough to understand the behavior
> > > > >
> > > > > Regards,
> > > > > Vincent
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > > Vincent
> > > > > >
> > > > > > > thanks
> > > > > > >
> > > > > > > [1] https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/SANC7QLYZKUNMM6O7UNR3OAQAKS5BESE/
> > > > > > > [2] https://lore.kernel.org/patchwork/cover/1141687/
> > > > > > > [3] https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.5-Scheduler



--zhXaljGHf11kAtnf
Content-Type: application/x-gtar-compressed
Content-Disposition: attachment; filename="compress-gzip-turbostat-no-c6.tgz"
Content-Transfer-Encoding: base64

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
u9vnvv95e/3X8v2f5n9b9X9OaSP/l6+MQ/+HB4yr8X/50vki/1curX/2f+U+O/J/5bY79H9d
MPbo/7BfZ7Xyf3ZDnvF/PclW+7+jEqt7/2dX0lf5v3J1n/B/8bDC6v5lei+e8H92cZ4DgN0h
aQCg3qwnAKDfalyOASD8VAo1df6f5/+27/8BZJ3/p7Qv+D/4uep1tWub2P9n5n8j4lL/E5b/
OqVNzf+Z/oug+K91/p/Slv868F/8Jv+1f99f5L/4L/Ff/N3+az+/z/ovXv7rxf6Ln/Vf7YPH
/uvotT3/1b526L8eVsUX/Rffjcb3+S8e+y/u+S/u+i/u+S/u+S/u+i/u+S/u+S/u+i8e+y9+
hf/an7TLfy3/tfzX8l/Lf73bf6Xyk9Pr0r/dfwVP+6/dI9P+a/fMtP/aPTPtv3bPTPuv3TOf
8V/5wBWW5b+e8F+iLMIABsLNf4ErxRwjJ63Mh4KYav8FblZGtE5D8CM/6FGrv11plKaEi1oR
M5KpCxqrqNKBv8SoekFLW2pZza7/CqBxsoIluAkMZCnVMSmCIhdowJIGSeOalTlIaMAS94Lk
dwV5919pHyTmWxeWgorJzFD0qfZK+UfPPwjPMBPa/Fdeayqj4HE4sQyn1xKgIeVN2uikaAZr
2JNoTcJ6OKn4L1GPFSzRncNrPq2UF3KJUg1aiOixUW6F8k14JbeVABU2z0Km3G6eRdA4EnjO
qyXkaws3Msp68kOdxJrjq45yKwGadGwNiOW+byMsZOn8QuSY55LyL6E6yrxU8yoJo3RapKxt
KwGqm9/rmtrPJTmwKDHkHyEk4ka5la0x3v+xs30EtxRwyY4fFx7XkfiyjjifHCFh8L2zhzQ9
23AuU9z8V574PJdolg/vB0Dkotxs1eTTrk5PVjxdGPbEvXR+1xRwEmzJFrJ4Z26+MLfARuw8
hDoxW1lIcYbYheK/2PKvqRXNA0pX/0WJbXPkXREUYomvlywmHdA4xLyxAygZrv7LW5jVGJMr
nUNZSYKpYW7e/OkMsg3Lf727fe77n7fX/9y+//FIuL7/OaON/de4/qddKaf8F76q/me5tA78
l91nR/6r3HaH/qubV6ziX11r1uivbk6xRn8dcKeH1/ToVKO/9EL6Sv3VzUvX6q9uxc5af9EB
hav5F3WVWKO/9NY8o7/0Xj2hv1y/Oulv0l+T5//b/Veozn8AXvXfTmlf8V8/d9Wvttpqq622
2r/d/gczk2teAEABAA==

--zhXaljGHf11kAtnf--
