Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA87C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D738620756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qB1js4Gz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgETNFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETNFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:05:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F35C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 06:05:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w10so3628495ljo.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m0Q2Cm1YHTD7x4UJHeNf1FSPUVpeIotpUxKptrDIQQw=;
        b=qB1js4GzrraR5DJFemUNW7f9cThQ8cDkXdeKewb39Dwv7y1roCVV2cu5ZtiEfydAt3
         imS8wg/7pUSp86xJwuui1q3iNDTNyTHGA0px2sp0ecbIIVYzzrq5fxjW9xi71RW4SEGG
         bsdm/Bqa65n7rvUZcpbx+51kLwU5fJxdpLzKbB4Mugc7c9aEJcFKJ3QETHazt34COnL1
         EWgEw7itTjNxAcQ9Yfr5NQj4AzfSf0FQRReh+3oWUpqGJkX7h9GvV7Vex2Z7ipTsM1f6
         0e61KIo3eZO1pSFBXN6MOCoa2ACpEPRLefLz7zheCldN2P2mEENGDvqX65SsEB9pEQhd
         kvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m0Q2Cm1YHTD7x4UJHeNf1FSPUVpeIotpUxKptrDIQQw=;
        b=E6WvWq6hWuJX59v2pL7Xsej4xMzUGzwpwej7t7O6bRB39MZQK9IZKd5YiHjQodE9T8
         7KJAALx+LNX33DaVeNQI6fZMJ08tzmPCbBXFKqA6EEF2pKNmOUFzPlYrLWMKaOWCq3ke
         97+sTUFlVjTha5/jJt03HQHExxdan86AwK/vf+GHye7yUrkEYt5mnylfZFmfyVn73EfW
         bVjlzLCEOKagO+XbDF1EuwQrS6i/G9Zh5jtGeVR+QweJW8Lr3slnrXLRUxB5CRWyNncL
         0ETrHA6QUdlmsUS/p27CdKdRDsRdt+kDt7gR4Agux1D4Y731gNGtI9i7A1xcZiwtO3wA
         vxdQ==
X-Gm-Message-State: AOAM530MTP1eiy498p5PQ6aVbVyVxgIdgQG6gL17rkYNxKusY8U4D5mK
        UpyGD4l3sdkXtkGkoSodCB0quxOUE4FcHITuYySPHg==
X-Google-Smtp-Source: ABdhPJzQ67s7e8WTrtepnYesqYixBQutnCD1+rai+atMZE3phLcyRdn6ut7cU4RJLXMhcfJTEZiUNjE3vt4MRYQ3DEo=
X-Received: by 2002:a2e:9510:: with SMTP id f16mr2753571ljh.111.1589979901487;
 Wed, 20 May 2020 06:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200514141526.GA30976@xsang-OptiPlex-9020> <CAKfTPtB3jQWd52FTyKNk5w8mmoDnu+jwYgkFBOiOKjb_BjxqTw@mail.gmail.com>
In-Reply-To: <CAKfTPtB3jQWd52FTyKNk5w8mmoDnu+jwYgkFBOiOKjb_BjxqTw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 20 May 2020 15:04:48 +0200
Message-ID: <CAKfTPtCnnCcoN8m+qcPZNhO_RjkwRwiPT4Qq1qYRqTPn8Z_prQ@mail.gmail.com>
Subject: Re: [sched/fair] 0b0695f2b3: phoronix-test-suite.compress-gzip.0.seconds
 19.8% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        OTC LSE PnP <otc.lse.pnp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 at 19:09, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Oliver,
>
> On Thu, 14 May 2020 at 16:05, kernel test robot <oliver.sang@intel.com> w=
rote:
> >
> > Hi Vincent Guittot,
> >
> > Below report FYI.
> > Last year, we actually reported an improvement "[sched/fair] 0b0695f2b3=
:
> > vm-scalability.median 3.1% improvement" on link [1].
> > but now we found the regression on pts.compress-gzip.
> > This seems align with what showed in "[v4,00/10] sched/fair: rework the=
 CFS
> > load balance" (link [2]), where showed the reworked load balance could =
have
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
> > We were just wondering whether you could share some lights the further =
works
> > on the load balance after patch set [2] which could cause the performan=
ce
> > change?
> > And whether you have plan to refine the load balance algorithm further?
>
> I'm going to have a look at your regression to understand what is
> going wrong and how it can be fixed

I have run the benchmark on my local setups to try to reproduce the
regression and I don't see the regression. But my setups are different
from your so it might be a problem specific to yours

After analysing the benchmark, it doesn't overload the system and is
mainly based on 1 main gzip thread with few others waking up and
sleeping around.

I thought that scheduler could be too aggressive when trying to
balance the threads on your system, which could generate more task
migrations and impact the performance. But this doesn't seem to be the
case because perf-stat.i.cpu-migrations is -8%. On the other side, the
context switch is +16% and more interestingly idle state C1E and C6
usages increase more than 50%. I don't know if we can rely or this
value or not but I wonder if it could be that threads are now spread
on different CPUs which generates idle time on the busy CPUs but the
added time to enter/leave these states hurts the performance.

Could you make some traces of both kernels ? Tracing sched events
should be enough to understand the behavior

Regards,
Vincent

>
> Thanks
> Vincent
>
> > thanks
> >
> > [1] https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/SANC7Q=
LYZKUNMM6O7UNR3OAQAKS5BESE/
> > [2] https://lore.kernel.org/patchwork/cover/1141687/
> > [3] https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DLinux-5.5-S=
cheduler
> >
> >
> >
> > Below is the detail regression report FYI.
> >
> > Greeting,
> >
> > FYI, we noticed a 19.8% regression of phoronix-test-suite.compress-gzip=
.0.seconds due to commit:
> >
> >
> > commit: 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912 ("sched/fair: Rework l=
oad_balance()")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: phoronix-test-suite
> > on test machine: 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with=
 32G memory
> > with following parameters:
> >
> >         test: compress-gzip-1.2.0
> >         cpufreq_governor: performance
> >         ucode: 0xca
> >
> > test-description: The Phoronix Test Suite is the most comprehensive tes=
ting and benchmarking platform available that provides an extensible framew=
ork for which new tests can be easily added.
> > test-url: http://www.phoronix-test-suite.com/
> >
> > In addition to that, the commit also has significant impact on the foll=
owing tests:
> >
> > +------------------+---------------------------------------------------=
--------------------+
> > | testcase: change | phoronix-test-suite:                              =
                    |
> > | test machine     | 12 threads Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz=
 with 8G memory     |
> > | test parameters  | cpufreq_governor=3Dperformance                    =
                      |
> > |                  | test=3Dcompress-gzip-1.2.0                        =
                      |
> > +------------------+---------------------------------------------------=
--------------------+
> > | testcase: change | vm-scalability: vm-scalability.median 3.1% improve=
ment                |
> > | test machine     | 104 threads Skylake with 192G memory              =
                    |
> > | test parameters  | cpufreq_governor=3Dperformance                    =
                      |
> > |                  | runtime=3D300s                                    =
                      |
> > |                  | size=3D8T                                         =
                      |
> > |                  | test=3Danon-cow-seq                               =
                      |
> > |                  | ucode=3D0x2000064                                 =
                      |
> > +------------------+---------------------------------------------------=
--------------------+
> > | testcase: change | stress-ng: stress-ng.fault.ops_per_sec -23.1% regr=
ession              |
> > | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20G=
Hz with 128G memory |
> > | test parameters  | class=3Dscheduler                                 =
                      |
> > |                  | cpufreq_governor=3Dperformance                    =
                      |
> > |                  | disk=3D1HDD                                       =
                      |
> > |                  | nr_threads=3D100%                                 =
                      |
> > |                  | sc_pid_max=3D4194304                              =
                      |
> > |                  | testtime=3D1s                                     =
                      |
> > |                  | ucode=3D0xb000038                                 =
                      |
> > +------------------+---------------------------------------------------=
--------------------+
> > | testcase: change | stress-ng: stress-ng.schedpolicy.ops_per_sec -33.3=
% regression        |
> > | test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GH=
z with 192G memory  |
> > | test parameters  | class=3Dinterrupt                                 =
                      |
> > |                  | cpufreq_governor=3Dperformance                    =
                      |
> > |                  | disk=3D1HDD                                       =
                      |
> > |                  | nr_threads=3D100%                                 =
                      |
> > |                  | testtime=3D1s                                     =
                      |
> > |                  | ucode=3D0x500002c                                 =
                      |
> > +------------------+---------------------------------------------------=
--------------------+
> > | testcase: change | stress-ng: stress-ng.schedpolicy.ops_per_sec 42.3%=
 improvement        |
> > | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20G=
Hz with 128G memory |
> > | test parameters  | class=3Dinterrupt                                 =
                      |
> > |                  | cpufreq_governor=3Dperformance                    =
                      |
> > |                  | disk=3D1HDD                                       =
                      |
> > |                  | nr_threads=3D100%                                 =
                      |
> > |                  | testtime=3D30s                                    =
                      |
> > |                  | ucode=3D0xb000038                                 =
                      |
> > +------------------+---------------------------------------------------=
--------------------+
> > | testcase: change | stress-ng: stress-ng.schedpolicy.ops_per_sec 35.1%=
 improvement        |
> > | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20G=
Hz with 128G memory |
> > | test parameters  | class=3Dinterrupt                                 =
                      |
> > |                  | cpufreq_governor=3Dperformance                    =
                      |
> > |                  | disk=3D1HDD                                       =
                      |
> > |                  | nr_threads=3D100%                                 =
                      |
> > |                  | testtime=3D1s                                     =
                      |
> > |                  | ucode=3D0xb000038                                 =
                      |
> > +------------------+---------------------------------------------------=
--------------------+
> > | testcase: change | stress-ng: stress-ng.ioprio.ops_per_sec -20.7% reg=
ression             |
> > | test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GH=
z with 192G memory  |
> > | test parameters  | class=3Dos                                        =
                      |
> > |                  | cpufreq_governor=3Dperformance                    =
                      |
> > |                  | disk=3D1HDD                                       =
                      |
> > |                  | fs=3Dext4                                         =
                      |
> > |                  | nr_threads=3D100%                                 =
                      |
> > |                  | testtime=3D1s                                     =
                      |
> > |                  | ucode=3D0x500002b                                 =
                      |
> > +------------------+---------------------------------------------------=
--------------------+
> > | testcase: change | stress-ng: stress-ng.schedpolicy.ops_per_sec 43.0%=
 improvement        |
> > | test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20G=
Hz with 128G memory |
> > | test parameters  | class=3Dinterrupt                                 =
                      |
> > |                  | cpufreq_governor=3Dperformance                    =
                      |
> > |                  | disk=3D1HDD                                       =
                      |
> > |                  | nr_threads=3D100%                                 =
                      |
> > |                  | testtime=3D30s                                    =
                      |
> > |                  | ucode=3D0xb000038                                 =
                      |
> > +------------------+---------------------------------------------------=
--------------------+
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >
> >
> > Details are as below:
> > -----------------------------------------------------------------------=
--------------------------->
> >
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/ucode=
:
> >   gcc-7/performance/x86_64-lck-7983/clear-x86_64-phoronix-30140/lkp-cfl=
-e1/compress-gzip-1.2.0/phoronix-test-suite/0xca
> >
> > commit:
> >   fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
> >   0b0695f2b3 ("sched/fair: Rework load_balance()")
> >
> > fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :4            4%           0:7     perf-profile.children.cyc=
les-pp.error_entry
> >          %stddev     %change         %stddev
> >              \          |                \
> >       6.01           +19.8%       7.20        phoronix-test-suite.compr=
ess-gzip.0.seconds
> >     147.57 =C4=85  8%     +25.1%     184.54        phoronix-test-suite.=
time.elapsed_time
> >     147.57 =C4=85  8%     +25.1%     184.54        phoronix-test-suite.=
time.elapsed_time.max
> >      52926 =C4=85  8%     -23.8%      40312        meminfo.max_used_kB
> >       0.11 =C4=85  7%      -0.0        0.09 =C4=85  3%  mpstat.cpu.all.=
soft%
> >     242384            -1.4%     238931        proc-vmstat.nr_inactive_a=
non
> >     242384            -1.4%     238931        proc-vmstat.nr_zone_inact=
ive_anon
> >  1.052e+08 =C4=85 27%     +56.5%  1.647e+08 =C4=85 10%  cpuidle.C1E.tim=
e
> >    1041078 =C4=85 22%     +54.7%    1610786 =C4=85  7%  cpuidle.C1E.usa=
ge
> >  3.414e+08 =C4=85  6%     +57.6%  5.381e+08 =C4=85 28%  cpuidle.C6.time
> >     817897 =C4=85  3%     +50.1%    1227607 =C4=85 11%  cpuidle.C6.usag=
e
> >       2884            -4.2%       2762        turbostat.Avg_MHz
> >    1041024 =C4=85 22%     +54.7%    1610657 =C4=85  7%  turbostat.C1E
> >     817802 =C4=85  3%     +50.1%    1227380 =C4=85 11%  turbostat.C6
> >      66.75            -2.0%      65.42        turbostat.CorWatt
> >      67.28            -2.0%      65.94        turbostat.PkgWatt
> >      32.50            +6.2%      34.50        vmstat.cpu.id
> >      62.50            -2.4%      61.00        vmstat.cpu.us
> >       2443 =C4=85  2%     -28.9%       1738 =C4=85  2%  vmstat.io.bi
> >      23765 =C4=85  4%     +16.5%      27685        vmstat.system.cs
> >      37860            -7.1%      35180 =C4=85  2%  vmstat.system.in
> >  3.474e+09 =C4=85  3%     -12.7%  3.032e+09        perf-stat.i.branch-i=
nstructions
> >  1.344e+08 =C4=85  2%     -11.6%  1.188e+08        perf-stat.i.branch-m=
isses
> >   13033225 =C4=85  4%     -19.0%   10561032        perf-stat.i.cache-mi=
sses
> >  5.105e+08 =C4=85  3%     -15.3%  4.322e+08        perf-stat.i.cache-re=
ferences
> >      24205 =C4=85  4%     +16.3%      28161        perf-stat.i.context-=
switches
> >      30.25 =C4=85  2%     +39.7%      42.27 =C4=85  2%  perf-stat.i.cpi
> >   4.63e+10            -4.7%  4.412e+10        perf-stat.i.cpu-cycles
> >       3147 =C4=85  4%      -8.4%       2882 =C4=85  2%  perf-stat.i.cpu=
-migrations
> >      16724 =C4=85  2%     +45.9%      24406 =C4=85  5%  perf-stat.i.cyc=
les-between-cache-misses
> >       0.18 =C4=85 13%      -0.1        0.12 =C4=85  4%  perf-stat.i.dTL=
B-load-miss-rate%
> >  4.822e+09 =C4=85  3%     -11.9%  4.248e+09        perf-stat.i.dTLB-loa=
ds
> >       0.07 =C4=85  8%      -0.0        0.05 =C4=85 16%  perf-stat.i.dTL=
B-store-miss-rate%
> >  1.623e+09 =C4=85  2%     -11.5%  1.436e+09        perf-stat.i.dTLB-sto=
res
> >    1007120 =C4=85  3%      -8.9%     917854 =C4=85  2%  perf-stat.i.iTL=
B-load-misses
> >  1.816e+10 =C4=85  3%     -12.2%  1.594e+10        perf-stat.i.instruct=
ions
> >       2.06 =C4=85 54%     -66.0%       0.70        perf-stat.i.major-fa=
ults
> >      29896 =C4=85 13%     -35.2%      19362 =C4=85  8%  perf-stat.i.min=
or-faults
> >       0.00 =C4=85  9%      -0.0        0.00 =C4=85  6%  perf-stat.i.nod=
e-load-miss-rate%
> >    1295134 =C4=85  3%     -14.2%    1111173        perf-stat.i.node-loa=
ds
> >    3064949 =C4=85  4%     -18.7%    2491063 =C4=85  2%  perf-stat.i.nod=
e-stores
> >      29898 =C4=85 13%     -35.2%      19363 =C4=85  8%  perf-stat.i.pag=
e-faults
> >      28.10            -3.5%      27.12        perf-stat.overall.MPKI
> >       2.55            -0.1        2.44 =C4=85  2%  perf-stat.overall.ca=
che-miss-rate%
> >       2.56 =C4=85  3%      +8.5%       2.77        perf-stat.overall.cp=
i
> >       3567 =C4=85  5%     +17.3%       4186        perf-stat.overall.cy=
cles-between-cache-misses
> >       0.02 =C4=85  3%      +0.0        0.02 =C4=85  3%  perf-stat.overa=
ll.dTLB-load-miss-rate%
> >      18031            -3.6%      17375 =C4=85  2%  perf-stat.overall.in=
structions-per-iTLB-miss
> >       0.39 =C4=85  3%      -7.9%       0.36        perf-stat.overall.ip=
c
> >  3.446e+09 =C4=85  3%     -12.6%  3.011e+09        perf-stat.ps.branch-=
instructions
> >  1.333e+08 =C4=85  2%     -11.5%   1.18e+08        perf-stat.ps.branch-=
misses
> >   12927998 =C4=85  4%     -18.8%   10491818        perf-stat.ps.cache-m=
isses
> >  5.064e+08 =C4=85  3%     -15.2%  4.293e+08        perf-stat.ps.cache-r=
eferences
> >      24011 =C4=85  4%     +16.5%      27973        perf-stat.ps.context=
-switches
> >  4.601e+10            -4.6%  4.391e+10        perf-stat.ps.cpu-cycles
> >       3121 =C4=85  4%      -8.3%       2863 =C4=85  2%  perf-stat.ps.cp=
u-migrations
> >  4.783e+09 =C4=85  3%     -11.8%  4.219e+09        perf-stat.ps.dTLB-lo=
ads
> >   1.61e+09 =C4=85  2%     -11.4%  1.426e+09        perf-stat.ps.dTLB-st=
ores
> >     999100 =C4=85  3%      -8.7%     911974 =C4=85  2%  perf-stat.ps.iT=
LB-load-misses
> >  1.802e+10 =C4=85  3%     -12.1%  1.584e+10        perf-stat.ps.instruc=
tions
> >       2.04 =C4=85 54%     -65.9%       0.70        perf-stat.ps.major-f=
aults
> >      29656 =C4=85 13%     -35.1%      19237 =C4=85  8%  perf-stat.ps.mi=
nor-faults
> >    1284601 =C4=85  3%     -14.1%    1103823        perf-stat.ps.node-lo=
ads
> >    3039931 =C4=85  4%     -18.6%    2474451 =C4=85  2%  perf-stat.ps.no=
de-stores
> >      29658 =C4=85 13%     -35.1%      19238 =C4=85  8%  perf-stat.ps.pa=
ge-faults
> >      50384 =C4=85  2%     +16.5%      58713 =C4=85  4%  softirqs.CPU0.R=
CU
> >      33143 =C4=85  2%     +19.9%      39731 =C4=85  2%  softirqs.CPU0.S=
CHED
> >      72672           +24.0%      90109        softirqs.CPU0.TIMER
> >      22182 =C4=85  4%     +26.3%      28008 =C4=85  4%  softirqs.CPU1.S=
CHED
> >      74465 =C4=85  4%     +26.3%      94027 =C4=85  3%  softirqs.CPU1.T=
IMER
> >      18680 =C4=85  7%     +29.2%      24135 =C4=85  3%  softirqs.CPU10.=
SCHED
> >      75941 =C4=85  2%     +21.8%      92486 =C4=85  7%  softirqs.CPU10.=
TIMER
> >      48991 =C4=85  4%     +22.7%      60105 =C4=85  5%  softirqs.CPU11.=
RCU
> >      18666 =C4=85  6%     +28.4%      23976 =C4=85  4%  softirqs.CPU11.=
SCHED
> >      74896 =C4=85  6%     +24.4%      93173 =C4=85  3%  softirqs.CPU11.=
TIMER
> >      49490           +20.5%      59659 =C4=85  2%  softirqs.CPU12.RCU
> >      18973 =C4=85  7%     +26.0%      23909 =C4=85  3%  softirqs.CPU12.=
SCHED
> >      50620           +19.9%      60677 =C4=85  6%  softirqs.CPU13.RCU
> >      19136 =C4=85  6%     +23.2%      23577 =C4=85  4%  softirqs.CPU13.=
SCHED
> >      74812           +33.3%      99756 =C4=85  7%  softirqs.CPU13.TIMER
> >      50824           +15.9%      58881 =C4=85  3%  softirqs.CPU14.RCU
> >      19550 =C4=85  5%     +24.1%      24270 =C4=85  4%  softirqs.CPU14.=
SCHED
> >      76801           +22.8%      94309 =C4=85  4%  softirqs.CPU14.TIMER
> >      51844           +11.5%      57795 =C4=85  3%  softirqs.CPU15.RCU
> >      19204 =C4=85  8%     +28.4%      24662 =C4=85  2%  softirqs.CPU15.=
SCHED
> >      74751           +29.9%      97127 =C4=85  3%  softirqs.CPU15.TIMER
> >      50307           +17.4%      59062 =C4=85  4%  softirqs.CPU2.RCU
> >      22150           +12.2%      24848        softirqs.CPU2.SCHED
> >      79653 =C4=85  2%     +21.6%      96829 =C4=85 10%  softirqs.CPU2.T=
IMER
> >      50833           +21.1%      61534 =C4=85  4%  softirqs.CPU3.RCU
> >      18935 =C4=85  2%     +32.0%      25002 =C4=85  3%  softirqs.CPU3.S=
CHED
> >      50569           +15.8%      58570 =C4=85  4%  softirqs.CPU4.RCU
> >      20509 =C4=85  5%     +18.3%      24271        softirqs.CPU4.SCHED
> >      80942 =C4=85  2%     +15.3%      93304 =C4=85  3%  softirqs.CPU4.T=
IMER
> >      50692           +16.5%      59067 =C4=85  4%  softirqs.CPU5.RCU
> >      20237 =C4=85  3%     +18.2%      23914 =C4=85  3%  softirqs.CPU5.S=
CHED
> >      78963           +21.8%      96151 =C4=85  2%  softirqs.CPU5.TIMER
> >      19709 =C4=85  7%     +20.1%      23663        softirqs.CPU6.SCHED
> >      81250           +15.9%      94185        softirqs.CPU6.TIMER
> >      51379           +15.0%      59108        softirqs.CPU7.RCU
> >      19642 =C4=85  5%     +28.4%      25227 =C4=85  3%  softirqs.CPU7.S=
CHED
> >      78299 =C4=85  2%     +30.3%     102021 =C4=85  4%  softirqs.CPU7.T=
IMER
> >      49723           +19.0%      59169 =C4=85  4%  softirqs.CPU8.RCU
> >      20138 =C4=85  6%     +21.7%      24501 =C4=85  2%  softirqs.CPU8.S=
CHED
> >      75256 =C4=85  3%     +22.8%      92419 =C4=85  2%  softirqs.CPU8.T=
IMER
> >      50406 =C4=85  2%     +17.4%      59178 =C4=85  4%  softirqs.CPU9.R=
CU
> >      19182 =C4=85  9%     +24.2%      23831 =C4=85  6%  softirqs.CPU9.S=
CHED
> >      73572 =C4=85  5%     +30.4%      95951 =C4=85  8%  softirqs.CPU9.T=
IMER
> >     812363           +16.6%     946858 =C4=85  3%  softirqs.RCU
> >     330042 =C4=85  4%     +23.5%     407533        softirqs.SCHED
> >    1240046           +22.5%    1519539        softirqs.TIMER
> >     251015 =C4=85 21%     -84.2%      39587 =C4=85106%  sched_debug.cfs=
_rq:/.MIN_vruntime.avg
> >     537847 =C4=85  4%     -44.8%     297100 =C4=85 66%  sched_debug.cfs=
_rq:/.MIN_vruntime.max
> >     257990 =C4=85  5%     -63.4%      94515 =C4=85 82%  sched_debug.cfs=
_rq:/.MIN_vruntime.stddev
> >      38935           +47.9%      57601        sched_debug.cfs_rq:/.exec=
_clock.avg
> >      44119           +40.6%      62013        sched_debug.cfs_rq:/.exec=
_clock.max
> >      37622           +49.9%      56404        sched_debug.cfs_rq:/.exec=
_clock.min
> >      47287 =C4=85  7%     -70.3%      14036 =C4=85 88%  sched_debug.cfs=
_rq:/.load.min
> >      67.17           -52.9%      31.62 =C4=85 31%  sched_debug.cfs_rq:/=
.load_avg.min
> >     251015 =C4=85 21%     -84.2%      39588 =C4=85106%  sched_debug.cfs=
_rq:/.max_vruntime.avg
> >     537847 =C4=85  4%     -44.8%     297103 =C4=85 66%  sched_debug.cfs=
_rq:/.max_vruntime.max
> >     257991 =C4=85  5%     -63.4%      94516 =C4=85 82%  sched_debug.cfs=
_rq:/.max_vruntime.stddev
> >     529078 =C4=85  3%     +45.2%     768398        sched_debug.cfs_rq:/=
.min_vruntime.avg
> >     547175 =C4=85  2%     +44.1%     788582        sched_debug.cfs_rq:/=
.min_vruntime.max
> >     496420           +48.3%     736148 =C4=85  2%  sched_debug.cfs_rq:/=
.min_vruntime.min
> >       1.33 =C4=85 15%     -44.0%       0.75 =C4=85 32%  sched_debug.cfs=
_rq:/.nr_running.avg
> >       0.83 =C4=85 20%     -70.0%       0.25 =C4=85 70%  sched_debug.cfs=
_rq:/.nr_running.min
> >       0.54 =C4=85  8%     -15.9%       0.45 =C4=85  7%  sched_debug.cfs=
_rq:/.nr_running.stddev
> >       0.33           +62.9%       0.54 =C4=85  8%  sched_debug.cfs_rq:/=
.nr_spread_over.avg
> >       1.33           +54.7%       2.06 =C4=85 17%  sched_debug.cfs_rq:/=
.nr_spread_over.max
> >       0.44 =C4=85  7%     +56.4%       0.69 =C4=85  6%  sched_debug.cfs=
_rq:/.nr_spread_over.stddev
> >     130.83 =C4=85 14%     -25.6%      97.37 =C4=85 15%  sched_debug.cfs=
_rq:/.runnable_load_avg.avg
> >      45.33 =C4=85  6%     -79.3%       9.38 =C4=85 70%  sched_debug.cfs=
_rq:/.runnable_load_avg.min
> >      47283 =C4=85  7%     -70.9%      13741 =C4=85 89%  sched_debug.cfs=
_rq:/.runnable_weight.min
> >       1098 =C4=85  8%     -27.6%     795.02 =C4=85 24%  sched_debug.cfs=
_rq:/.util_avg.avg
> >     757.50 =C4=85  9%     -51.3%     369.25 =C4=85 10%  sched_debug.cfs=
_rq:/.util_avg.min
> >     762.39 =C4=85 11%     -44.4%     424.04 =C4=85 46%  sched_debug.cfs=
_rq:/.util_est_enqueued.avg
> >     314.00 =C4=85 18%     -78.5%      67.38 =C4=85100%  sched_debug.cfs=
_rq:/.util_est_enqueued.min
> >     142951 =C4=85  5%     +22.8%     175502 =C4=85  3%  sched_debug.cpu=
.avg_idle.avg
> >      72112           -18.3%      58937 =C4=85 13%  sched_debug.cpu.avg_=
idle.stddev
> >     127638 =C4=85  7%     +39.3%     177858 =C4=85  5%  sched_debug.cpu=
.clock.avg
> >     127643 =C4=85  7%     +39.3%     177862 =C4=85  5%  sched_debug.cpu=
.clock.max
> >     127633 =C4=85  7%     +39.3%     177855 =C4=85  5%  sched_debug.cpu=
.clock.min
> >     126720 =C4=85  7%     +39.4%     176681 =C4=85  5%  sched_debug.cpu=
.clock_task.avg
> >     127168 =C4=85  7%     +39.3%     177179 =C4=85  5%  sched_debug.cpu=
.clock_task.max
> >     125240 =C4=85  7%     +39.5%     174767 =C4=85  5%  sched_debug.cpu=
.clock_task.min
> >     563.60 =C4=85  2%     +25.9%     709.78 =C4=85  9%  sched_debug.cpu=
.clock_task.stddev
> >       1.66 =C4=85 18%     -37.5%       1.04 =C4=85 32%  sched_debug.cpu=
.nr_running.avg
> >       0.83 =C4=85 20%     -62.5%       0.31 =C4=85 87%  sched_debug.cpu=
.nr_running.min
> >     127617 =C4=85  3%     +52.9%     195080        sched_debug.cpu.nr_s=
witches.avg
> >     149901 =C4=85  6%     +45.2%     217652        sched_debug.cpu.nr_s=
witches.max
> >     108182 =C4=85  5%     +61.6%     174808        sched_debug.cpu.nr_s=
witches.min
> >       0.20 =C4=85  5%     -62.5%       0.07 =C4=85 67%  sched_debug.cpu=
.nr_uninterruptible.avg
> >     -29.33           -13.5%     -25.38        sched_debug.cpu.nr_uninte=
rruptible.min
> >      92666 =C4=85  8%     +66.8%     154559        sched_debug.cpu.sche=
d_count.avg
> >     104565 =C4=85 11%     +57.2%     164374        sched_debug.cpu.sche=
d_count.max
> >      80272 =C4=85 10%     +77.2%     142238        sched_debug.cpu.sche=
d_count.min
> >      38029 =C4=85 10%     +80.4%      68608        sched_debug.cpu.sche=
d_goidle.avg
> >      43413 =C4=85 11%     +68.5%      73149        sched_debug.cpu.sche=
d_goidle.max
> >      32420 =C4=85 11%     +94.5%      63069        sched_debug.cpu.sche=
d_goidle.min
> >      51567 =C4=85  8%     +60.7%      82878        sched_debug.cpu.ttwu=
_count.avg
> >      79015 =C4=85  9%     +45.2%     114717 =C4=85  4%  sched_debug.cpu=
.ttwu_count.max
> >      42919 =C4=85  9%     +63.3%      70086        sched_debug.cpu.ttwu=
_count.min
> >     127632 =C4=85  7%     +39.3%     177854 =C4=85  5%  sched_debug.cpu=
_clk
> >     125087 =C4=85  7%     +40.1%     175285 =C4=85  5%  sched_debug.kti=
me
> >     127882 =C4=85  6%     +39.3%     178163 =C4=85  5%  sched_debug.sch=
ed_clk
> >     146.00 =C4=85 13%    +902.9%       1464 =C4=85143%  interrupts.133:=
IR-PCI-MSI.2097153-edge.eth1-TxRx-0
> >       3375 =C4=85 93%     -94.8%     174.75 =C4=85 26%  interrupts.134:=
IR-PCI-MSI.2097154-edge.eth1-TxRx-1
> >     297595 =C4=85  8%     +22.8%     365351 =C4=85  2%  interrupts.CPU0=
.LOC:Local_timer_interrupts
> >       8402           -21.7%       6577 =C4=85 25%  interrupts.CPU0.NMI:=
Non-maskable_interrupts
> >       8402           -21.7%       6577 =C4=85 25%  interrupts.CPU0.PMI:=
Performance_monitoring_interrupts
> >     937.00 =C4=85  2%     +18.1%       1106 =C4=85 11%  interrupts.CPU0=
.RES:Rescheduling_interrupts
> >     146.00 =C4=85 13%    +902.9%       1464 =C4=85143%  interrupts.CPU1=
.133:IR-PCI-MSI.2097153-edge.eth1-TxRx-0
> >     297695 =C4=85  8%     +22.7%     365189 =C4=85  2%  interrupts.CPU1=
.LOC:Local_timer_interrupts
> >       8412           -20.9%       6655 =C4=85 25%  interrupts.CPU1.NMI:=
Non-maskable_interrupts
> >       8412           -20.9%       6655 =C4=85 25%  interrupts.CPU1.PMI:=
Performance_monitoring_interrupts
> >     297641 =C4=85  8%     +22.7%     365268 =C4=85  2%  interrupts.CPU1=
0.LOC:Local_timer_interrupts
> >       8365           -10.9%       7455 =C4=85  3%  interrupts.CPU10.NMI=
:Non-maskable_interrupts
> >       8365           -10.9%       7455 =C4=85  3%  interrupts.CPU10.PMI=
:Performance_monitoring_interrupts
> >     297729 =C4=85  8%     +22.7%     365238 =C4=85  2%  interrupts.CPU1=
1.LOC:Local_timer_interrupts
> >       8376           -21.8%       6554 =C4=85 26%  interrupts.CPU11.NMI=
:Non-maskable_interrupts
> >       8376           -21.8%       6554 =C4=85 26%  interrupts.CPU11.PMI=
:Performance_monitoring_interrupts
> >     297394 =C4=85  8%     +22.8%     365274 =C4=85  2%  interrupts.CPU1=
2.LOC:Local_timer_interrupts
> >       8393           -10.5%       7512 =C4=85  3%  interrupts.CPU12.NMI=
:Non-maskable_interrupts
> >       8393           -10.5%       7512 =C4=85  3%  interrupts.CPU12.PMI=
:Performance_monitoring_interrupts
> >     297744 =C4=85  8%     +22.7%     365243 =C4=85  2%  interrupts.CPU1=
3.LOC:Local_timer_interrupts
> >       8353           -10.6%       7469 =C4=85  3%  interrupts.CPU13.NMI=
:Non-maskable_interrupts
> >       8353           -10.6%       7469 =C4=85  3%  interrupts.CPU13.PMI=
:Performance_monitoring_interrupts
> >     148.50 =C4=85 17%     -24.2%     112.50 =C4=85  8%  interrupts.CPU1=
3.TLB:TLB_shootdowns
> >     297692 =C4=85  8%     +22.7%     365311 =C4=85  2%  interrupts.CPU1=
4.LOC:Local_timer_interrupts
> >       8374           -10.4%       7501 =C4=85  4%  interrupts.CPU14.NMI=
:Non-maskable_interrupts
> >       8374           -10.4%       7501 =C4=85  4%  interrupts.CPU14.PMI=
:Performance_monitoring_interrupts
> >     297453 =C4=85  8%     +22.8%     365311 =C4=85  2%  interrupts.CPU1=
5.LOC:Local_timer_interrupts
> >       8336           -22.8%       6433 =C4=85 26%  interrupts.CPU15.NMI=
:Non-maskable_interrupts
> >       8336           -22.8%       6433 =C4=85 26%  interrupts.CPU15.PMI=
:Performance_monitoring_interrupts
> >     699.50 =C4=85 21%     +51.3%       1058 =C4=85 10%  interrupts.CPU1=
5.RES:Rescheduling_interrupts
> >       3375 =C4=85 93%     -94.8%     174.75 =C4=85 26%  interrupts.CPU2=
.134:IR-PCI-MSI.2097154-edge.eth1-TxRx-1
> >     297685 =C4=85  8%     +22.7%     365273 =C4=85  2%  interrupts.CPU2=
.LOC:Local_timer_interrupts
> >       8357           -21.2%       6584 =C4=85 25%  interrupts.CPU2.NMI:=
Non-maskable_interrupts
> >       8357           -21.2%       6584 =C4=85 25%  interrupts.CPU2.PMI:=
Performance_monitoring_interrupts
> >     164.00 =C4=85 30%     -23.0%     126.25 =C4=85 32%  interrupts.CPU2=
.TLB:TLB_shootdowns
> >     297352 =C4=85  8%     +22.9%     365371 =C4=85  2%  interrupts.CPU3=
.LOC:Local_timer_interrupts
> >       8383           -10.6%       7493 =C4=85  4%  interrupts.CPU3.NMI:=
Non-maskable_interrupts
> >       8383           -10.6%       7493 =C4=85  4%  interrupts.CPU3.PMI:=
Performance_monitoring_interrupts
> >     780.50 =C4=85  3%     +32.7%       1035 =C4=85  6%  interrupts.CPU3=
.RES:Rescheduling_interrupts
> >     297595 =C4=85  8%     +22.8%     365415 =C4=85  2%  interrupts.CPU4=
.LOC:Local_timer_interrupts
> >       8382           -21.4%       6584 =C4=85 25%  interrupts.CPU4.NMI:=
Non-maskable_interrupts
> >       8382           -21.4%       6584 =C4=85 25%  interrupts.CPU4.PMI:=
Performance_monitoring_interrupts
> >     297720 =C4=85  8%     +22.7%     365347 =C4=85  2%  interrupts.CPU5=
.LOC:Local_timer_interrupts
> >       8353           -32.0%       5679 =C4=85 34%  interrupts.CPU5.NMI:=
Non-maskable_interrupts
> >       8353           -32.0%       5679 =C4=85 34%  interrupts.CPU5.PMI:=
Performance_monitoring_interrupts
> >     727.00 =C4=85 16%     +98.3%       1442 =C4=85 47%  interrupts.CPU5=
.RES:Rescheduling_interrupts
> >     297620 =C4=85  8%     +22.8%     365343 =C4=85  2%  interrupts.CPU6=
.LOC:Local_timer_interrupts
> >       8388           -10.3%       7526 =C4=85  4%  interrupts.CPU6.NMI:=
Non-maskable_interrupts
> >       8388           -10.3%       7526 =C4=85  4%  interrupts.CPU6.PMI:=
Performance_monitoring_interrupts
> >     156.50 =C4=85  3%     -27.6%     113.25 =C4=85 16%  interrupts.CPU6=
.TLB:TLB_shootdowns
> >     297690 =C4=85  8%     +22.7%     365363 =C4=85  2%  interrupts.CPU7=
.LOC:Local_timer_interrupts
> >       8390           -23.1%       6449 =C4=85 25%  interrupts.CPU7.NMI:=
Non-maskable_interrupts
> >       8390           -23.1%       6449 =C4=85 25%  interrupts.CPU7.PMI:=
Performance_monitoring_interrupts
> >     918.00 =C4=85 16%     +49.4%       1371 =C4=85  7%  interrupts.CPU7=
.RES:Rescheduling_interrupts
> >     120.00 =C4=85 35%     +70.8%     205.00 =C4=85 17%  interrupts.CPU7=
.TLB:TLB_shootdowns
> >     297731 =C4=85  8%     +22.7%     365368 =C4=85  2%  interrupts.CPU8=
.LOC:Local_timer_interrupts
> >       8393           -32.5%       5668 =C4=85 35%  interrupts.CPU8.NMI:=
Non-maskable_interrupts
> >       8393           -32.5%       5668 =C4=85 35%  interrupts.CPU8.PMI:=
Performance_monitoring_interrupts
> >     297779 =C4=85  8%     +22.7%     365399 =C4=85  2%  interrupts.CPU9=
.LOC:Local_timer_interrupts
> >       8430           -10.8%       7517 =C4=85  2%  interrupts.CPU9.NMI:=
Non-maskable_interrupts
> >       8430           -10.8%       7517 =C4=85  2%  interrupts.CPU9.PMI:=
Performance_monitoring_interrupts
> >     956.50           +13.5%       1085 =C4=85  4%  interrupts.CPU9.RES:=
Rescheduling_interrupts
> >    4762118 =C4=85  8%     +22.7%    5845069 =C4=85  2%  interrupts.LOC:=
Local_timer_interrupts
> >     134093           -18.2%     109662 =C4=85 11%  interrupts.NMI:Non-m=
askable_interrupts
> >     134093           -18.2%     109662 =C4=85 11%  interrupts.PMI:Perfo=
rmance_monitoring_interrupts
> >      66.97 =C4=85  9%     -29.9       37.12 =C4=85 49%  perf-profile.ca=
lltrace.cycles-pp.deflate
> >      66.67 =C4=85  9%     -29.7       36.97 =C4=85 50%  perf-profile.ca=
lltrace.cycles-pp.deflate_medium.deflate
> >      43.24 =C4=85  9%     -18.6       24.61 =C4=85 49%  perf-profile.ca=
lltrace.cycles-pp.longest_match.deflate_medium.deflate
> >       2.29 =C4=85 14%      -1.2        1.05 =C4=85 58%  perf-profile.ca=
lltrace.cycles-pp.deflateSetDictionary
> >       0.74 =C4=85  6%      -0.5        0.27 =C4=85100%  perf-profile.ca=
lltrace.cycles-pp.read.__libc_start_main
> >       0.74 =C4=85  7%      -0.5        0.27 =C4=85100%  perf-profile.ca=
lltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read.__libc_start_main
> >       0.73 =C4=85  7%      -0.5        0.27 =C4=85100%  perf-profile.ca=
lltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.__libc_=
start_main
> >       0.73 =C4=85  7%      -0.5        0.27 =C4=85100%  perf-profile.ca=
lltrace.cycles-pp.__x64_sys_read.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me.read.__libc_start_main
> >       0.73 =C4=85  7%      -0.5        0.27 =C4=85100%  perf-profile.ca=
lltrace.cycles-pp.ksys_read.__x64_sys_read.do_syscall_64.entry_SYSCALL_64_a=
fter_hwframe.read
> >       0.26 =C4=85100%      +0.6        0.88 =C4=85 45%  perf-profile.ca=
lltrace.cycles-pp.vfs_statx.__do_sys_newfstatat.__x64_sys_newfstatat.do_sys=
call_64.entry_SYSCALL_64_after_hwframe
> >       0.34 =C4=85100%      +0.7        1.02 =C4=85 42%  perf-profile.ca=
lltrace.cycles-pp.do_sys_open.__x64_sys_openat.do_syscall_64.entry_SYSCALL_=
64_after_hwframe
> >       0.28 =C4=85100%      +0.7        0.96 =C4=85 44%  perf-profile.ca=
lltrace.cycles-pp.__do_sys_newfstatat.__x64_sys_newfstatat.do_syscall_64.en=
try_SYSCALL_64_after_hwframe
> >       0.28 =C4=85100%      +0.7        0.96 =C4=85 44%  perf-profile.ca=
lltrace.cycles-pp.__x64_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after=
_hwframe
> >       0.34 =C4=85100%      +0.7        1.03 =C4=85 42%  perf-profile.ca=
lltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame
> >       0.00            +0.8        0.77 =C4=85 35%  perf-profile.calltra=
ce.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrup=
t.cpuidle_enter_state.cpuidle_enter
> >       0.56 =C4=85  9%      +0.8        1.40 =C4=85 45%  perf-profile.ca=
lltrace.cycles-pp.__schedule.schedule.futex_wait_queue_me.futex_wait.do_fut=
ex
> >       0.58 =C4=85 10%      +0.9        1.43 =C4=85 45%  perf-profile.ca=
lltrace.cycles-pp.schedule.futex_wait_queue_me.futex_wait.do_futex.__x64_sy=
s_futex
> >       0.33 =C4=85100%      +0.9        1.21 =C4=85 28%  perf-profile.ca=
lltrace.cycles-pp.menu_select.cpuidle_select.do_idle.cpu_startup_entry.star=
t_secondary
> >       0.34 =C4=85 99%      +0.9        1.27 =C4=85 30%  perf-profile.ca=
lltrace.cycles-pp.cpuidle_select.do_idle.cpu_startup_entry.start_secondary.=
secondary_startup_64
> >       0.00            +1.0        0.96 =C4=85 62%  perf-profile.calltra=
ce.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startu=
p_entry
> >       0.62 =C4=85  9%      +1.0        1.60 =C4=85 52%  perf-profile.ca=
lltrace.cycles-pp.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex.d=
o_syscall_64
> >       0.68 =C4=85 10%      +1.0        1.73 =C4=85 51%  perf-profile.ca=
lltrace.cycles-pp.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
> >       0.46 =C4=85100%      +1.1        1.60 =C4=85 43%  perf-profile.ca=
lltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_ent=
er_state.cpuidle_enter.do_idle
> >       0.47 =C4=85100%      +1.2        1.62 =C4=85 43%  perf-profile.ca=
lltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do=
_idle.cpu_startup_entry
> >      17.73 =C4=85 21%     +19.1       36.84 =C4=85 25%  perf-profile.ca=
lltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_=
startup_entry
> >      17.75 =C4=85 20%     +19.9       37.63 =C4=85 26%  perf-profile.ca=
lltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_ent=
ry.start_secondary
> >      17.84 =C4=85 20%     +20.0       37.82 =C4=85 26%  perf-profile.ca=
lltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.s=
econdary_startup_64
> >      18.83 =C4=85 20%     +21.2       40.05 =C4=85 27%  perf-profile.ca=
lltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_start=
up_64
> >      18.89 =C4=85 20%     +21.2       40.11 =C4=85 27%  perf-profile.ca=
lltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
> >      18.89 =C4=85 20%     +21.2       40.12 =C4=85 27%  perf-profile.ca=
lltrace.cycles-pp.start_secondary.secondary_startup_64
> >      20.14 =C4=85 20%     +22.5       42.66 =C4=85 27%  perf-profile.ca=
lltrace.cycles-pp.secondary_startup_64
> >      66.97 =C4=85  9%     -29.9       37.12 =C4=85 49%  perf-profile.ch=
ildren.cycles-pp.deflate
> >      66.83 =C4=85  9%     -29.8       37.06 =C4=85 49%  perf-profile.ch=
ildren.cycles-pp.deflate_medium
> >      43.58 =C4=85  9%     -18.8       24.80 =C4=85 49%  perf-profile.ch=
ildren.cycles-pp.longest_match
> >       2.29 =C4=85 14%      -1.2        1.12 =C4=85 43%  perf-profile.ch=
ildren.cycles-pp.deflateSetDictionary
> >       0.84            -0.3        0.58 =C4=85 19%  perf-profile.childre=
n.cycles-pp.read
> >       0.52 =C4=85 13%      -0.2        0.27 =C4=85 43%  perf-profile.ch=
ildren.cycles-pp.fill_window
> >       0.06            +0.0        0.08 =C4=85 13%  perf-profile.childre=
n.cycles-pp.update_stack_state
> >       0.07 =C4=85 14%      +0.0        0.11 =C4=85 24%  perf-profile.ch=
ildren.cycles-pp._raw_spin_unlock_irqrestore
> >       0.03 =C4=85100%      +0.1        0.09 =C4=85 19%  perf-profile.ch=
ildren.cycles-pp.find_next_and_bit
> >       0.00            +0.1        0.06 =C4=85 15%  perf-profile.childre=
n.cycles-pp.refcount_inc_not_zero_checked
> >       0.03 =C4=85100%      +0.1        0.08 =C4=85 33%  perf-profile.ch=
ildren.cycles-pp.free_pcppages_bulk
> >       0.07 =C4=85  7%      +0.1        0.12 =C4=85 36%  perf-profile.ch=
ildren.cycles-pp.syscall_return_via_sysret
> >       0.00            +0.1        0.06 =C4=85 28%  perf-profile.childre=
n.cycles-pp.rb_erase
> >       0.03 =C4=85100%      +0.1        0.09 =C4=85 24%  perf-profile.ch=
ildren.cycles-pp.shmem_undo_range
> >       0.03 =C4=85100%      +0.1        0.09 =C4=85 28%  perf-profile.ch=
ildren.cycles-pp.unlinkat
> >       0.03 =C4=85100%      +0.1        0.09 =C4=85 28%  perf-profile.ch=
ildren.cycles-pp.__x64_sys_unlinkat
> >       0.03 =C4=85100%      +0.1        0.09 =C4=85 28%  perf-profile.ch=
ildren.cycles-pp.do_unlinkat
> >       0.03 =C4=85100%      +0.1        0.09 =C4=85 28%  perf-profile.ch=
ildren.cycles-pp.ovl_destroy_inode
> >       0.03 =C4=85100%      +0.1        0.09 =C4=85 28%  perf-profile.ch=
ildren.cycles-pp.shmem_evict_inode
> >       0.03 =C4=85100%      +0.1        0.09 =C4=85 28%  perf-profile.ch=
ildren.cycles-pp.shmem_truncate_range
> >       0.05            +0.1        0.12 =C4=85 38%  perf-profile.childre=
n.cycles-pp.unmap_vmas
> >       0.00            +0.1        0.07 =C4=85 30%  perf-profile.childre=
n.cycles-pp.timerqueue_del
> >       0.00            +0.1        0.07 =C4=85 26%  perf-profile.childre=
n.cycles-pp.idle_cpu
> >       0.09 =C4=85 17%      +0.1        0.15 =C4=85 19%  perf-profile.ch=
ildren.cycles-pp.__update_load_avg_se
> >       0.00            +0.1        0.07 =C4=85 33%  perf-profile.childre=
n.cycles-pp.unmap_region
> >       0.00            +0.1        0.07 =C4=85 33%  perf-profile.childre=
n.cycles-pp.__alloc_fd
> >       0.03 =C4=85100%      +0.1        0.10 =C4=85 31%  perf-profile.ch=
ildren.cycles-pp.destroy_inode
> >       0.03 =C4=85100%      +0.1        0.10 =C4=85 30%  perf-profile.ch=
ildren.cycles-pp.evict
> >       0.06 =C4=85 16%      +0.1        0.13 =C4=85 35%  perf-profile.ch=
ildren.cycles-pp.ovl_override_creds
> >       0.00            +0.1        0.07 =C4=85 26%  perf-profile.childre=
n.cycles-pp.kernel_text_address
> >       0.00            +0.1        0.07 =C4=85 41%  perf-profile.childre=
n.cycles-pp.file_remove_privs
> >       0.07 =C4=85 23%      +0.1        0.14 =C4=85 47%  perf-profile.ch=
ildren.cycles-pp.hrtimer_next_event_without
> >       0.03 =C4=85100%      +0.1        0.10 =C4=85 24%  perf-profile.ch=
ildren.cycles-pp.__dentry_kill
> >       0.03 =C4=85100%      +0.1        0.10 =C4=85 29%  perf-profile.ch=
ildren.cycles-pp.dentry_unlink_inode
> >       0.03 =C4=85100%      +0.1        0.10 =C4=85 29%  perf-profile.ch=
ildren.cycles-pp.iput
> >       0.03 =C4=85100%      +0.1        0.10 =C4=85 54%  perf-profile.ch=
ildren.cycles-pp.__close_fd
> >       0.08 =C4=85 25%      +0.1        0.15 =C4=85 35%  perf-profile.ch=
ildren.cycles-pp.__switch_to
> >       0.00            +0.1        0.07 =C4=85 29%  perf-profile.childre=
n.cycles-pp.__switch_to_asm
> >       0.00            +0.1        0.08 =C4=85 24%  perf-profile.childre=
n.cycles-pp.__kernel_text_address
> >       0.03 =C4=85100%      +0.1        0.11 =C4=85 51%  perf-profile.ch=
ildren.cycles-pp.enqueue_hrtimer
> >       0.03 =C4=85100%      +0.1        0.11 =C4=85 33%  perf-profile.ch=
ildren.cycles-pp.rcu_gp_kthread_wake
> >       0.03 =C4=85100%      +0.1        0.11 =C4=85 33%  perf-profile.ch=
ildren.cycles-pp.swake_up_one
> >       0.03 =C4=85100%      +0.1        0.11 =C4=85 33%  perf-profile.ch=
ildren.cycles-pp.swake_up_locked
> >       0.10 =C4=85 30%      +0.1        0.18 =C4=85 17%  perf-profile.ch=
ildren.cycles-pp.irqtime_account_irq
> >       0.03 =C4=85100%      +0.1        0.11 =C4=85 38%  perf-profile.ch=
ildren.cycles-pp.unmap_page_range
> >       0.00            +0.1        0.09 =C4=85 37%  perf-profile.childre=
n.cycles-pp.putname
> >       0.03 =C4=85100%      +0.1        0.11 =C4=85 28%  perf-profile.ch=
ildren.cycles-pp.filemap_map_pages
> >       0.07 =C4=85 28%      +0.1        0.16 =C4=85 35%  perf-profile.ch=
ildren.cycles-pp.getname
> >       0.03 =C4=85100%      +0.1        0.11 =C4=85 40%  perf-profile.ch=
ildren.cycles-pp.unmap_single_vma
> >       0.08 =C4=85 29%      +0.1        0.17 =C4=85 38%  perf-profile.ch=
ildren.cycles-pp.queued_spin_lock_slowpath
> >       0.03 =C4=85100%      +0.1        0.12 =C4=85 54%  perf-profile.ch=
ildren.cycles-pp.setlocale
> >       0.03 =C4=85100%      +0.1        0.12 =C4=85 60%  perf-profile.ch=
ildren.cycles-pp.__open64_nocancel
> >       0.00            +0.1        0.09 =C4=85 31%  perf-profile.childre=
n.cycles-pp.__hrtimer_get_next_event
> >       0.00            +0.1        0.10 =C4=85 28%  perf-profile.childre=
n.cycles-pp.get_unused_fd_flags
> >       0.00            +0.1        0.10 =C4=85 65%  perf-profile.childre=
n.cycles-pp.timerqueue_add
> >       0.07 =C4=85 28%      +0.1        0.17 =C4=85 42%  perf-profile.ch=
ildren.cycles-pp.__hrtimer_next_event_base
> >       0.03 =C4=85100%      +0.1        0.12 =C4=85 51%  perf-profile.ch=
ildren.cycles-pp.__x64_sys_close
> >       0.00            +0.1        0.10 =C4=85 38%  perf-profile.childre=
n.cycles-pp.do_lookup_x
> >       0.03 =C4=85100%      +0.1        0.12 =C4=85 23%  perf-profile.ch=
ildren.cycles-pp.kmem_cache_free
> >       0.04 =C4=85100%      +0.1        0.14 =C4=85 53%  perf-profile.ch=
ildren.cycles-pp.__do_munmap
> >       0.00            +0.1        0.10 =C4=85 35%  perf-profile.childre=
n.cycles-pp.unwind_get_return_address
> >       0.00            +0.1        0.10 =C4=85 49%  perf-profile.childre=
n.cycles-pp.shmem_add_to_page_cache
> >       0.07 =C4=85 20%      +0.1        0.18 =C4=85 25%  perf-profile.ch=
ildren.cycles-pp.find_next_bit
> >       0.08 =C4=85 25%      +0.1        0.18 =C4=85 34%  perf-profile.ch=
ildren.cycles-pp.dput
> >       0.11 =C4=85 33%      +0.1        0.21 =C4=85 37%  perf-profile.ch=
ildren.cycles-pp.perf_mux_hrtimer_handler
> >       0.08 =C4=85  5%      +0.1        0.19 =C4=85 27%  perf-profile.ch=
ildren.cycles-pp._raw_spin_lock_irqsave
> >       0.00            +0.1        0.11 =C4=85 52%  perf-profile.childre=
n.cycles-pp.rcu_idle_exit
> >       0.03 =C4=85100%      +0.1        0.14 =C4=85 18%  perf-profile.ch=
ildren.cycles-pp.entry_SYSCALL_64
> >       0.08            +0.1        0.19 =C4=85 43%  perf-profile.childre=
n.cycles-pp.exit_mmap
> >       0.09 =C4=85 22%      +0.1        0.20 =C4=85 57%  perf-profile.ch=
ildren.cycles-pp.set_next_entity
> >       0.07 =C4=85  7%      +0.1        0.18 =C4=85 60%  perf-profile.ch=
ildren.cycles-pp.switch_mm_irqs_off
> >       0.10 =C4=85 26%      +0.1        0.21 =C4=85 32%  perf-profile.ch=
ildren.cycles-pp.sched_clock
> >       0.12 =C4=85 25%      +0.1        0.23 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.update_cfs_group
> >       0.07 =C4=85 14%      +0.1        0.18 =C4=85 45%  perf-profile.ch=
ildren.cycles-pp.lapic_next_deadline
> >       0.08 =C4=85  5%      +0.1        0.20 =C4=85 44%  perf-profile.ch=
ildren.cycles-pp.mmput
> >       0.11 =C4=85 18%      +0.1        0.23 =C4=85 41%  perf-profile.ch=
ildren.cycles-pp.clockevents_program_event
> >       0.07 =C4=85  7%      +0.1        0.18 =C4=85 40%  perf-profile.ch=
ildren.cycles-pp.strncpy_from_user
> >       0.00            +0.1        0.12 =C4=85 48%  perf-profile.childre=
n.cycles-pp.flush_old_exec
> >       0.11 =C4=85 18%      +0.1        0.23 =C4=85 37%  perf-profile.ch=
ildren.cycles-pp.native_sched_clock
> >       0.09 =C4=85 17%      +0.1        0.21 =C4=85 46%  perf-profile.ch=
ildren.cycles-pp._dl_sysdep_start
> >       0.12 =C4=85 19%      +0.1        0.26 =C4=85 37%  perf-profile.ch=
ildren.cycles-pp.tick_program_event
> >       0.09 =C4=85 33%      +0.1        0.23 =C4=85 61%  perf-profile.ch=
ildren.cycles-pp.mmap_region
> >       0.14 =C4=85 21%      +0.1        0.28 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.sched_clock_cpu
> >       0.11 =C4=85 27%      +0.1        0.25 =C4=85 56%  perf-profile.ch=
ildren.cycles-pp.do_mmap
> >       0.11 =C4=85 36%      +0.1        0.26 =C4=85 57%  perf-profile.ch=
ildren.cycles-pp.ksys_mmap_pgoff
> >       0.09 =C4=85 17%      +0.1        0.23 =C4=85 48%  perf-profile.ch=
ildren.cycles-pp.lookup_fast
> >       0.04 =C4=85100%      +0.2        0.19 =C4=85 48%  perf-profile.ch=
ildren.cycles-pp.open_path
> >       0.11 =C4=85 30%      +0.2        0.27 =C4=85 58%  perf-profile.ch=
ildren.cycles-pp.vm_mmap_pgoff
> >       0.11 =C4=85 27%      +0.2        0.28 =C4=85 37%  perf-profile.ch=
ildren.cycles-pp.update_blocked_averages
> >       0.11            +0.2        0.29 =C4=85 38%  perf-profile.childre=
n.cycles-pp.search_binary_handler
> >       0.11 =C4=85  4%      +0.2        0.29 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.load_elf_binary
> >       0.11 =C4=85 30%      +0.2        0.30 =C4=85 50%  perf-profile.ch=
ildren.cycles-pp.inode_permission
> >       0.04 =C4=85100%      +0.2        0.24 =C4=85 55%  perf-profile.ch=
ildren.cycles-pp.__GI___open64_nocancel
> >       0.15 =C4=85 29%      +0.2        0.35 =C4=85 34%  perf-profile.ch=
ildren.cycles-pp.getname_flags
> >       0.16 =C4=85 25%      +0.2        0.38 =C4=85 26%  perf-profile.ch=
ildren.cycles-pp.get_next_timer_interrupt
> >       0.18 =C4=85 11%      +0.2        0.41 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.execve
> >       0.19 =C4=85  5%      +0.2        0.42 =C4=85 37%  perf-profile.ch=
ildren.cycles-pp.__x64_sys_execve
> >       0.18 =C4=85  2%      +0.2        0.42 =C4=85 37%  perf-profile.ch=
ildren.cycles-pp.__do_execve_file
> >       0.32 =C4=85 18%      +0.3        0.57 =C4=85 33%  perf-profile.ch=
ildren.cycles-pp.__account_scheduler_latency
> >       0.21 =C4=85 17%      +0.3        0.48 =C4=85 47%  perf-profile.ch=
ildren.cycles-pp.schedule_idle
> >       0.20 =C4=85 19%      +0.3        0.49 =C4=85 33%  perf-profile.ch=
ildren.cycles-pp.tick_nohz_next_event
> >       0.21 =C4=85 26%      +0.3        0.55 =C4=85 41%  perf-profile.ch=
ildren.cycles-pp.find_busiest_group
> >       0.32 =C4=85 26%      +0.3        0.67 =C4=85 52%  perf-profile.ch=
ildren.cycles-pp.__handle_mm_fault
> >       0.22 =C4=85 25%      +0.4        0.57 =C4=85 49%  perf-profile.ch=
ildren.cycles-pp.filename_lookup
> >       0.34 =C4=85 27%      +0.4        0.72 =C4=85 50%  perf-profile.ch=
ildren.cycles-pp.handle_mm_fault
> >       0.42 =C4=85 32%      +0.4        0.80 =C4=85 43%  perf-profile.ch=
ildren.cycles-pp.shmem_getpage_gfp
> >       0.36 =C4=85 23%      +0.4        0.77 =C4=85 41%  perf-profile.ch=
ildren.cycles-pp.load_balance
> >       0.41 =C4=85 30%      +0.4        0.82 =C4=85 50%  perf-profile.ch=
ildren.cycles-pp.do_page_fault
> >       0.39 =C4=85 30%      +0.4        0.80 =C4=85 50%  perf-profile.ch=
ildren.cycles-pp.__do_page_fault
> >       0.28 =C4=85 22%      +0.4        0.70 =C4=85 37%  perf-profile.ch=
ildren.cycles-pp.tick_nohz_get_sleep_length
> >       0.43 =C4=85 31%      +0.4        0.86 =C4=85 49%  perf-profile.ch=
ildren.cycles-pp.page_fault
> >       0.31 =C4=85 25%      +0.5        0.77 =C4=85 46%  perf-profile.ch=
ildren.cycles-pp.user_path_at_empty
> >       0.36 =C4=85 20%      +0.5        0.84 =C4=85 34%  perf-profile.ch=
ildren.cycles-pp.newidle_balance
> >       0.45 =C4=85 21%      +0.5        0.95 =C4=85 44%  perf-profile.ch=
ildren.cycles-pp.vfs_statx
> >       0.46 =C4=85 20%      +0.5        0.97 =C4=85 43%  perf-profile.ch=
ildren.cycles-pp.__do_sys_newfstatat
> >       0.47 =C4=85 20%      +0.5        0.98 =C4=85 44%  perf-profile.ch=
ildren.cycles-pp.__x64_sys_newfstatat
> >       0.29 =C4=85 37%      +0.5        0.81 =C4=85 32%  perf-profile.ch=
ildren.cycles-pp.io_serial_in
> >       0.53 =C4=85 25%      +0.5        1.06 =C4=85 49%  perf-profile.ch=
ildren.cycles-pp.path_openat
> >       0.55 =C4=85 24%      +0.5        1.09 =C4=85 50%  perf-profile.ch=
ildren.cycles-pp.do_filp_open
> >       0.35 =C4=85  2%      +0.5        0.90 =C4=85 60%  perf-profile.ch=
ildren.cycles-pp.uart_console_write
> >       0.35 =C4=85  4%      +0.6        0.91 =C4=85 60%  perf-profile.ch=
ildren.cycles-pp.console_unlock
> >       0.35 =C4=85  4%      +0.6        0.91 =C4=85 60%  perf-profile.ch=
ildren.cycles-pp.univ8250_console_write
> >       0.35 =C4=85  4%      +0.6        0.91 =C4=85 60%  perf-profile.ch=
ildren.cycles-pp.serial8250_console_write
> >       0.82 =C4=85 23%      +0.6        1.42 =C4=85 31%  perf-profile.ch=
ildren.cycles-pp.__hrtimer_run_queues
> >       0.47 =C4=85 28%      +0.6        1.10 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.irq_work_interrupt
> >       0.47 =C4=85 28%      +0.6        1.10 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.smp_irq_work_interrupt
> >       0.47 =C4=85 28%      +0.6        1.10 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.irq_work_run
> >       0.47 =C4=85 28%      +0.6        1.10 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.perf_duration_warn
> >       0.47 =C4=85 28%      +0.6        1.10 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.printk
> >       0.47 =C4=85 28%      +0.6        1.10 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.vprintk_func
> >       0.47 =C4=85 28%      +0.6        1.10 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.vprintk_default
> >       0.47 =C4=85 28%      +0.6        1.11 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.irq_work_run_list
> >       0.49 =C4=85 31%      +0.6        1.13 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.vprintk_emit
> >       0.54 =C4=85 19%      +0.6        1.17 =C4=85 38%  perf-profile.ch=
ildren.cycles-pp.pick_next_task_fair
> >       0.32 =C4=85  7%      +0.7        1.02 =C4=85 56%  perf-profile.ch=
ildren.cycles-pp.poll_idle
> >       0.60 =C4=85 15%      +0.7        1.31 =C4=85 29%  perf-profile.ch=
ildren.cycles-pp.menu_select
> >       0.65 =C4=85 27%      +0.7        1.36 =C4=85 45%  perf-profile.ch=
ildren.cycles-pp.do_sys_open
> >       0.62 =C4=85 15%      +0.7        1.36 =C4=85 31%  perf-profile.ch=
ildren.cycles-pp.cpuidle_select
> >       0.66 =C4=85 26%      +0.7        1.39 =C4=85 44%  perf-profile.ch=
ildren.cycles-pp.__x64_sys_openat
> >       1.11 =C4=85 22%      +0.9        2.03 =C4=85 31%  perf-profile.ch=
ildren.cycles-pp.hrtimer_interrupt
> >       0.89 =C4=85 24%      +0.9        1.81 =C4=85 42%  perf-profile.ch=
ildren.cycles-pp.futex_wait_queue_me
> >       1.16 =C4=85 27%      +1.0        2.13 =C4=85 36%  perf-profile.ch=
ildren.cycles-pp.schedule
> >       0.97 =C4=85 23%      +1.0        1.97 =C4=85 42%  perf-profile.ch=
ildren.cycles-pp.futex_wait
> >       1.33 =C4=85 25%      +1.2        2.55 =C4=85 39%  perf-profile.ch=
ildren.cycles-pp.__schedule
> >       1.84 =C4=85 26%      +1.6        3.42 =C4=85 36%  perf-profile.ch=
ildren.cycles-pp.smp_apic_timer_interrupt
> >       1.76 =C4=85 22%      +1.6        3.41 =C4=85 40%  perf-profile.ch=
ildren.cycles-pp.do_futex
> >       1.79 =C4=85 22%      +1.7        3.49 =C4=85 41%  perf-profile.ch=
ildren.cycles-pp.__x64_sys_futex
> >       2.23 =C4=85 20%      +1.7        3.98 =C4=85 37%  perf-profile.ch=
ildren.cycles-pp.apic_timer_interrupt
> >      17.73 =C4=85 21%     +19.1       36.86 =C4=85 25%  perf-profile.ch=
ildren.cycles-pp.intel_idle
> >      19.00 =C4=85 21%     +21.1       40.13 =C4=85 26%  perf-profile.ch=
ildren.cycles-pp.cpuidle_enter_state
> >      19.02 =C4=85 21%     +21.2       40.19 =C4=85 26%  perf-profile.ch=
ildren.cycles-pp.cpuidle_enter
> >      18.89 =C4=85 20%     +21.2       40.12 =C4=85 27%  perf-profile.ch=
ildren.cycles-pp.start_secondary
> >      20.14 =C4=85 20%     +22.5       42.65 =C4=85 27%  perf-profile.ch=
ildren.cycles-pp.cpu_startup_entry
> >      20.08 =C4=85 20%     +22.5       42.59 =C4=85 27%  perf-profile.ch=
ildren.cycles-pp.do_idle
> >      20.14 =C4=85 20%     +22.5       42.66 =C4=85 27%  perf-profile.ch=
ildren.cycles-pp.secondary_startup_64
> >      43.25 =C4=85  9%     -18.6       24.63 =C4=85 49%  perf-profile.se=
lf.cycles-pp.longest_match
> >      22.74 =C4=85 11%     -10.8       11.97 =C4=85 50%  perf-profile.se=
lf.cycles-pp.deflate_medium
> >       2.26 =C4=85 14%      -1.2        1.11 =C4=85 44%  perf-profile.se=
lf.cycles-pp.deflateSetDictionary
> >       0.51 =C4=85 12%      -0.3        0.24 =C4=85 57%  perf-profile.se=
lf.cycles-pp.fill_window
> >       0.07 =C4=85  7%      +0.0        0.10 =C4=85 24%  perf-profile.se=
lf.cycles-pp._raw_spin_unlock_irqrestore
> >       0.07 =C4=85  7%      +0.1        0.12 =C4=85 36%  perf-profile.se=
lf.cycles-pp.syscall_return_via_sysret
> >       0.08 =C4=85 12%      +0.1        0.14 =C4=85 15%  perf-profile.se=
lf.cycles-pp.__update_load_avg_se
> >       0.06            +0.1        0.13 =C4=85 27%  perf-profile.self.cy=
cles-pp._raw_spin_lock_irqsave
> >       0.08 =C4=85 25%      +0.1        0.15 =C4=85 37%  perf-profile.se=
lf.cycles-pp.__switch_to
> >       0.06 =C4=85 16%      +0.1        0.13 =C4=85 29%  perf-profile.se=
lf.cycles-pp.get_page_from_freelist
> >       0.00            +0.1        0.07 =C4=85 29%  perf-profile.self.cy=
cles-pp.__switch_to_asm
> >       0.05            +0.1        0.13 =C4=85 57%  perf-profile.self.cy=
cles-pp.switch_mm_irqs_off
> >       0.00            +0.1        0.08 =C4=85 41%  perf-profile.self.cy=
cles-pp.interrupt_entry
> >       0.00            +0.1        0.08 =C4=85 61%  perf-profile.self.cy=
cles-pp.run_timer_softirq
> >       0.07 =C4=85 23%      +0.1        0.15 =C4=85 43%  perf-profile.se=
lf.cycles-pp.__hrtimer_next_event_base
> >       0.03 =C4=85100%      +0.1        0.12 =C4=85 43%  perf-profile.se=
lf.cycles-pp.update_cfs_group
> >       0.08 =C4=85 29%      +0.1        0.17 =C4=85 38%  perf-profile.se=
lf.cycles-pp.queued_spin_lock_slowpath
> >       0.00            +0.1        0.09 =C4=85 29%  perf-profile.self.cy=
cles-pp.strncpy_from_user
> >       0.06 =C4=85 16%      +0.1        0.15 =C4=85 24%  perf-profile.se=
lf.cycles-pp.find_next_bit
> >       0.00            +0.1        0.10 =C4=85 35%  perf-profile.self.cy=
cles-pp.do_lookup_x
> >       0.00            +0.1        0.10 =C4=85 13%  perf-profile.self.cy=
cles-pp.kmem_cache_free
> >       0.06 =C4=85 16%      +0.1        0.16 =C4=85 30%  perf-profile.se=
lf.cycles-pp.do_idle
> >       0.03 =C4=85100%      +0.1        0.13 =C4=85 18%  perf-profile.se=
lf.cycles-pp.entry_SYSCALL_64
> >       0.03 =C4=85100%      +0.1        0.14 =C4=85 41%  perf-profile.se=
lf.cycles-pp.update_blocked_averages
> >       0.11 =C4=85 18%      +0.1        0.22 =C4=85 37%  perf-profile.se=
lf.cycles-pp.native_sched_clock
> >       0.07 =C4=85 14%      +0.1        0.18 =C4=85 46%  perf-profile.se=
lf.cycles-pp.lapic_next_deadline
> >       0.00            +0.1        0.12 =C4=85 65%  perf-profile.self.cy=
cles-pp.set_next_entity
> >       0.12 =C4=85 28%      +0.1        0.27 =C4=85 32%  perf-profile.se=
lf.cycles-pp.cpuidle_enter_state
> >       0.15 =C4=85  3%      +0.2        0.32 =C4=85 39%  perf-profile.se=
lf.cycles-pp.io_serial_out
> >       0.25 =C4=85  4%      +0.2        0.48 =C4=85 19%  perf-profile.se=
lf.cycles-pp.menu_select
> >       0.15 =C4=85 22%      +0.3        0.42 =C4=85 46%  perf-profile.se=
lf.cycles-pp.find_busiest_group
> >       0.29 =C4=85 37%      +0.4        0.71 =C4=85 42%  perf-profile.se=
lf.cycles-pp.io_serial_in
> >       0.32 =C4=85  7%      +0.7        1.02 =C4=85 56%  perf-profile.se=
lf.cycles-pp.poll_idle
> >      17.73 =C4=85 21%     +19.1       36.79 =C4=85 25%  perf-profile.se=
lf.cycles-pp.intel_idle
> >
> >
> >
> >                    phoronix-test-suite.compress-gzip.0.seconds
> >
> >   8 +------------------------------------------------------------------=
-----+
> >     |                       O   O    O   O                 O   O   O   =
 O   |
> >   7 |-+ O  O   O   O    O              O     O    O   O                =
     |
> >   6 |-+      +                     +                    +              =
     |
> >     |   +    :   +   +             :       +    +   +   :              =
     |
> >   5 |-+ :    :   :   :            ::       :    :   :   :              =
     |
> >     |   ::  : :  :   ::           : :      :   ::   :  :               =
     |
> >   4 |:+: :  : : : : : :           : :     : :  : : : : :               =
     |
> >     |: : :  : : : : : :   +   +   : :  +  : :  : : : : :               =
     |
> >   3 |:+:  : : : : : :  :  :   :  :  :  :  : :  : : : : :               =
     |
> >   2 |:+:  : : : : : :  : : : : : :  : : : : : :  : : : :               =
     |
> >     |: :  : : : : : :  : : : : : :  : : : : : :  : : : :               =
     |
> >   1 |-:   ::   :   :   : : : : : :   :: ::   ::   :   :                =
     |
> >     | :    :   :   :    :   :   :    :   :   :    :   :                =
     |
> >   0 +------------------------------------------------------------------=
-----+
> >
> >
> > [*] bisect-good sample
> > [O] bisect-bad  sample
> >
> > ***********************************************************************=
****************************
> > lkp-cfl-d1: 12 threads Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 8G =
memory
> >
> >
> > ***********************************************************************=
****************************
> > lkp-skl-fpga01: 104 threads Skylake with 192G memory
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/t=
estcase/ucode:
> >   gcc-7/performance/x86_64-rhel-7.6/debian-x86_64-2019-09-23.cgz/300s/8=
T/lkp-skl-fpga01/anon-cow-seq/vm-scalability/0x2000064
> >
> > commit:
> >   fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
> >   0b0695f2b3 ("sched/fair: Rework load_balance()")
> >
> > fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >     413301            +3.1%     426103        vm-scalability.median
> >       0.04 =C4=85  2%     -34.0%       0.03 =C4=85 12%  vm-scalability.=
median_stddev
> >   43837589            +2.4%   44902458        vm-scalability.throughput
> >     181085           -18.7%     147221        vm-scalability.time.invol=
untary_context_switches
> >   12762365 =C4=85  2%      +3.9%   13262025        vm-scalability.time.=
minor_page_faults
> >       7773            +2.9%       7997        vm-scalability.time.perce=
nt_of_cpu_this_job_got
> >      11449            +1.2%      11589        vm-scalability.time.syste=
m_time
> >      12024            +4.7%      12584        vm-scalability.time.user_=
time
> >     439194 =C4=85  2%     +46.0%     641402 =C4=85  2%  vm-scalability.=
time.voluntary_context_switches
> >  1.148e+10            +5.0%  1.206e+10        vm-scalability.workload
> >       0.00 =C4=85 54%      +0.0        0.00 =C4=85 17%  mpstat.cpu.all.=
iowait%
> >    4767597           +52.5%    7268430 =C4=85 41%  numa-numastat.node1.=
local_node
> >    4781030           +52.3%    7280347 =C4=85 41%  numa-numastat.node1.=
numa_hit
> >      24.75            -9.1%      22.50 =C4=85  2%  vmstat.cpu.id
> >      37.50            +4.7%      39.25        vmstat.cpu.us
> >       6643 =C4=85  3%     +15.1%       7647        vmstat.system.cs
> >   12220504           +33.4%   16298593 =C4=85  4%  cpuidle.C1.time
> >     260215 =C4=85  6%     +55.3%     404158 =C4=85  3%  cpuidle.C1.usag=
e
> >    4986034 =C4=85  3%     +56.2%    7786811 =C4=85  2%  cpuidle.POLL.ti=
me
> >     145941 =C4=85  3%     +61.2%     235218 =C4=85  2%  cpuidle.POLL.us=
age
> >       1990            +3.0%       2049        turbostat.Avg_MHz
> >     254633 =C4=85  6%     +56.7%     398892 =C4=85  4%  turbostat.C1
> >       0.04            +0.0        0.05        turbostat.C1%
> >     309.99            +1.5%     314.75        turbostat.RAMWatt
> >       1688 =C4=85 11%     +17.4%       1983 =C4=85  5%  slabinfo.UNIX.a=
ctive_objs
> >       1688 =C4=85 11%     +17.4%       1983 =C4=85  5%  slabinfo.UNIX.n=
um_objs
> >       2460 =C4=85  3%     -15.8%       2072 =C4=85 11%  slabinfo.dmaeng=
ine-unmap-16.active_objs
> >       2460 =C4=85  3%     -15.8%       2072 =C4=85 11%  slabinfo.dmaeng=
ine-unmap-16.num_objs
> >       2814 =C4=85  9%     +14.6%       3225 =C4=85  4%  slabinfo.sock_i=
node_cache.active_objs
> >       2814 =C4=85  9%     +14.6%       3225 =C4=85  4%  slabinfo.sock_i=
node_cache.num_objs
> >       0.67 =C4=85  5%      +0.1        0.73 =C4=85  3%  perf-profile.ca=
lltrace.cycles-pp.__alloc_pages_nodemask.alloc_pages_vma.do_huge_pmd_wp_pag=
e.__handle_mm_fault.handle_mm_fault
> >       0.68 =C4=85  6%      +0.1        0.74 =C4=85  2%  perf-profile.ca=
lltrace.cycles-pp.alloc_pages_vma.do_huge_pmd_wp_page.__handle_mm_fault.han=
dle_mm_fault.__do_page_fault
> >       0.05            +0.0        0.07 =C4=85  7%  perf-profile.childre=
n.cycles-pp.schedule
> >       0.06            +0.0        0.08 =C4=85  6%  perf-profile.childre=
n.cycles-pp.__wake_up_common
> >       0.06 =C4=85  7%      +0.0        0.08 =C4=85  6%  perf-profile.ch=
ildren.cycles-pp.wake_up_page_bit
> >       0.23 =C4=85  7%      +0.0        0.28 =C4=85  5%  perf-profile.ch=
ildren.cycles-pp._raw_spin_lock_irqsave
> >       0.00            +0.1        0.05        perf-profile.children.cyc=
les-pp.drm_fb_helper_sys_imageblit
> >       0.00            +0.1        0.05        perf-profile.children.cyc=
les-pp.sys_imageblit
> >      29026 =C4=85  3%     -26.7%      21283 =C4=85 44%  numa-vmstat.nod=
e0.nr_inactive_anon
> >      30069 =C4=85  3%     -20.5%      23905 =C4=85 26%  numa-vmstat.nod=
e0.nr_shmem
> >      12120 =C4=85  2%     -15.5%      10241 =C4=85 12%  numa-vmstat.nod=
e0.nr_slab_reclaimable
> >      29026 =C4=85  3%     -26.7%      21283 =C4=85 44%  numa-vmstat.nod=
e0.nr_zone_inactive_anon
> >    4010893           +16.1%    4655889 =C4=85  9%  numa-vmstat.node1.nr=
_active_anon
> >    3982581           +16.3%    4632344 =C4=85  9%  numa-vmstat.node1.nr=
_anon_pages
> >       6861           +16.1%       7964 =C4=85  8%  numa-vmstat.node1.nr=
_anon_transparent_hugepages
> >       2317 =C4=85 42%    +336.9%      10125 =C4=85 93%  numa-vmstat.nod=
e1.nr_inactive_anon
> >       6596 =C4=85  4%     +18.2%       7799 =C4=85 14%  numa-vmstat.nod=
e1.nr_kernel_stack
> >       9629 =C4=85  8%     +66.4%      16020 =C4=85 41%  numa-vmstat.nod=
e1.nr_shmem
> >       7558 =C4=85  3%     +26.5%       9561 =C4=85 14%  numa-vmstat.nod=
e1.nr_slab_reclaimable
> >    4010227           +16.1%    4655056 =C4=85  9%  numa-vmstat.node1.nr=
_zone_active_anon
> >       2317 =C4=85 42%    +336.9%      10125 =C4=85 93%  numa-vmstat.nod=
e1.nr_zone_inactive_anon
> >    2859663 =C4=85  2%     +46.2%    4179500 =C4=85 36%  numa-vmstat.nod=
e1.numa_hit
> >    2680260 =C4=85  2%     +49.3%    4002218 =C4=85 37%  numa-vmstat.nod=
e1.numa_local
> >     116661 =C4=85  3%     -26.3%      86010 =C4=85 44%  numa-meminfo.no=
de0.Inactive
> >     116192 =C4=85  3%     -26.7%      85146 =C4=85 44%  numa-meminfo.no=
de0.Inactive(anon)
> >      48486 =C4=85  2%     -15.5%      40966 =C4=85 12%  numa-meminfo.no=
de0.KReclaimable
> >      48486 =C4=85  2%     -15.5%      40966 =C4=85 12%  numa-meminfo.no=
de0.SReclaimable
> >     120367 =C4=85  3%     -20.5%      95642 =C4=85 26%  numa-meminfo.no=
de0.Shmem
> >   16210528           +15.2%   18673368 =C4=85  6%  numa-meminfo.node1.A=
ctive
> >   16210394           +15.2%   18673287 =C4=85  6%  numa-meminfo.node1.A=
ctive(anon)
> >   14170064           +15.6%   16379835 =C4=85  7%  numa-meminfo.node1.A=
nonHugePages
> >   16113351           +15.3%   18577254 =C4=85  7%  numa-meminfo.node1.A=
nonPages
> >      10534 =C4=85 33%    +293.8%      41480 =C4=85 92%  numa-meminfo.no=
de1.Inactive
> >       9262 =C4=85 42%    +338.2%      40589 =C4=85 93%  numa-meminfo.no=
de1.Inactive(anon)
> >      30235 =C4=85  3%     +26.5%      38242 =C4=85 14%  numa-meminfo.no=
de1.KReclaimable
> >       6594 =C4=85  4%     +18.3%       7802 =C4=85 14%  numa-meminfo.no=
de1.KernelStack
> >   17083646           +15.1%   19656922 =C4=85  7%  numa-meminfo.node1.M=
emUsed
> >      30235 =C4=85  3%     +26.5%      38242 =C4=85 14%  numa-meminfo.no=
de1.SReclaimable
> >      38540 =C4=85  8%     +66.4%      64117 =C4=85 42%  numa-meminfo.no=
de1.Shmem
> >     106342           +19.8%     127451 =C4=85 11%  numa-meminfo.node1.S=
lab
> >    9479688            +4.5%    9905902        proc-vmstat.nr_active_ano=
n
> >    9434298            +4.5%    9856978        proc-vmstat.nr_anon_pages
> >      16194            +4.3%      16895        proc-vmstat.nr_anon_trans=
parent_hugepages
> >     276.75            +3.6%     286.75        proc-vmstat.nr_dirtied
> >    3888633            -1.1%    3845882        proc-vmstat.nr_dirty_back=
ground_threshold
> >    7786774            -1.1%    7701168        proc-vmstat.nr_dirty_thre=
shold
> >   39168820            -1.1%   38741444        proc-vmstat.nr_free_pages
> >      50391            +1.0%      50904        proc-vmstat.nr_slab_unrec=
laimable
> >     257.50            +3.6%     266.75        proc-vmstat.nr_written
> >    9479678            +4.5%    9905895        proc-vmstat.nr_zone_activ=
e_anon
> >    1501517            -5.9%    1412958        proc-vmstat.numa_hint_fau=
lts
> >    1075936           -13.1%     934706        proc-vmstat.numa_hint_fau=
lts_local
> >   17306395            +4.8%   18141722        proc-vmstat.numa_hit
> >    5211079            +4.2%    5427541        proc-vmstat.numa_huge_pte=
_updates
> >   17272620            +4.8%   18107691        proc-vmstat.numa_local
> >      33774            +0.8%      34031        proc-vmstat.numa_other
> >     690793 =C4=85  3%     -13.7%     596166 =C4=85  2%  proc-vmstat.num=
a_pages_migrated
> >  2.669e+09            +4.2%   2.78e+09        proc-vmstat.numa_pte_upda=
tes
> >  2.755e+09            +5.6%  2.909e+09        proc-vmstat.pgalloc_norma=
l
> >   13573227 =C4=85  2%      +3.6%   14060842        proc-vmstat.pgfault
> >  2.752e+09            +5.6%  2.906e+09        proc-vmstat.pgfree
> >  1.723e+08 =C4=85  2%     +14.3%   1.97e+08 =C4=85  8%  proc-vmstat.pgm=
igrate_fail
> >     690793 =C4=85  3%     -13.7%     596166 =C4=85  2%  proc-vmstat.pgm=
igrate_success
> >    5015265            +5.0%    5266730        proc-vmstat.thp_deferred_=
split_page
> >    5019661            +5.0%    5271482        proc-vmstat.thp_fault_all=
oc
> >      18284 =C4=85 62%     -79.9%       3681 =C4=85172%  sched_debug.cfs=
_rq:/.MIN_vruntime.avg
> >    1901618 =C4=85 62%     -89.9%     192494 =C4=85172%  sched_debug.cfs=
_rq:/.MIN_vruntime.max
> >     185571 =C4=85 62%     -85.8%      26313 =C4=85172%  sched_debug.cfs=
_rq:/.MIN_vruntime.stddev
> >      15241 =C4=85  6%     -36.6%       9655 =C4=85  6%  sched_debug.cfs=
_rq:/.exec_clock.stddev
> >      18284 =C4=85 62%     -79.9%       3681 =C4=85172%  sched_debug.cfs=
_rq:/.max_vruntime.avg
> >    1901618 =C4=85 62%     -89.9%     192494 =C4=85172%  sched_debug.cfs=
_rq:/.max_vruntime.max
> >     185571 =C4=85 62%     -85.8%      26313 =C4=85172%  sched_debug.cfs=
_rq:/.max_vruntime.stddev
> >     898812 =C4=85  7%     -31.2%     618552 =C4=85  5%  sched_debug.cfs=
_rq:/.min_vruntime.stddev
> >      10.30 =C4=85 12%     +34.5%      13.86 =C4=85  6%  sched_debug.cfs=
_rq:/.nr_spread_over.avg
> >      34.75 =C4=85  8%     +95.9%      68.08 =C4=85  4%  sched_debug.cfs=
_rq:/.nr_spread_over.max
> >       9.12 =C4=85 11%     +82.3%      16.62 =C4=85  9%  sched_debug.cfs=
_rq:/.nr_spread_over.stddev
> >   -1470498           -31.9%   -1000709        sched_debug.cfs_rq:/.spre=
ad0.min
> >     899820 =C4=85  7%     -31.2%     618970 =C4=85  5%  sched_debug.cfs=
_rq:/.spread0.stddev
> >       1589 =C4=85  9%     -19.2%       1284 =C4=85  9%  sched_debug.cfs=
_rq:/.util_avg.max
> >       0.54 =C4=85 39%   +7484.6%      41.08 =C4=85 92%  sched_debug.cfs=
_rq:/.util_est_enqueued.min
> >     238.84 =C4=85  8%     -33.2%     159.61 =C4=85 26%  sched_debug.cfs=
_rq:/.util_est_enqueued.stddev
> >      10787 =C4=85  2%     +13.8%      12274        sched_debug.cpu.nr_s=
witches.avg
> >      35242 =C4=85  9%     +32.3%      46641 =C4=85 25%  sched_debug.cpu=
.nr_switches.max
> >       9139 =C4=85  3%     +16.4%      10636        sched_debug.cpu.sche=
d_count.avg
> >      32025 =C4=85 10%     +34.6%      43091 =C4=85 27%  sched_debug.cpu=
.sched_count.max
> >       4016 =C4=85  2%     +14.7%       4606 =C4=85  5%  sched_debug.cpu=
.sched_count.min
> >       2960           +38.3%       4093        sched_debug.cpu.sched_goi=
dle.avg
> >      11201 =C4=85 24%     +75.8%      19691 =C4=85 26%  sched_debug.cpu=
.sched_goidle.max
> >       1099 =C4=85  6%     +56.9%       1725 =C4=85  6%  sched_debug.cpu=
.sched_goidle.min
> >       1877 =C4=85 10%     +32.5%       2487 =C4=85 17%  sched_debug.cpu=
.sched_goidle.stddev
> >       4348 =C4=85  3%     +19.3%       5188        sched_debug.cpu.ttwu=
_count.avg
> >      17832 =C4=85 11%     +78.6%      31852 =C4=85 29%  sched_debug.cpu=
.ttwu_count.max
> >       1699 =C4=85  6%     +28.2%       2178 =C4=85  7%  sched_debug.cpu=
.ttwu_count.min
> >       1357 =C4=85 10%     -22.6%       1050 =C4=85  4%  sched_debug.cpu=
.ttwu_local.avg
> >      11483 =C4=85  5%     -25.0%       8614 =C4=85 15%  sched_debug.cpu=
.ttwu_local.max
> >       1979 =C4=85 12%     -36.8%       1251 =C4=85 10%  sched_debug.cpu=
.ttwu_local.stddev
> >  3.941e+10            +5.0%  4.137e+10        perf-stat.i.branch-instru=
ctions
> >       0.02 =C4=85 50%      -0.0        0.02 =C4=85  5%  perf-stat.i.bra=
nch-miss-rate%
> >      67.94            -3.9       63.99        perf-stat.i.cache-miss-ra=
te%
> >  8.329e+08            -1.9%   8.17e+08        perf-stat.i.cache-misses
> >  1.224e+09            +4.5%   1.28e+09        perf-stat.i.cache-referen=
ces
> >       6650 =C4=85  3%     +15.5%       7678        perf-stat.i.context-=
switches
> >       1.64            -1.8%       1.61        perf-stat.i.cpi
> >  2.037e+11            +2.8%  2.095e+11        perf-stat.i.cpu-cycles
> >     257.56            -4.0%     247.13        perf-stat.i.cpu-migration=
s
> >     244.94            +4.5%     255.91        perf-stat.i.cycles-betwee=
n-cache-misses
> >    1189446 =C4=85  2%      +3.2%    1227527        perf-stat.i.dTLB-loa=
d-misses
> >  2.669e+10            +4.7%  2.794e+10        perf-stat.i.dTLB-loads
> >       0.00 =C4=85  7%      -0.0        0.00        perf-stat.i.dTLB-sto=
re-miss-rate%
> >     337782            +4.5%     353044        perf-stat.i.dTLB-store-mi=
sses
> >  9.096e+09            +4.7%  9.526e+09        perf-stat.i.dTLB-stores
> >      39.50            +2.1       41.64        perf-stat.i.iTLB-load-mis=
s-rate%
> >     296305 =C4=85  2%      +9.0%     323020        perf-stat.i.iTLB-loa=
d-misses
> >  1.238e+11            +4.9%  1.299e+11        perf-stat.i.instructions
> >     428249 =C4=85  2%      -4.4%     409553        perf-stat.i.instruct=
ions-per-iTLB-miss
> >       0.61            +1.6%       0.62        perf-stat.i.ipc
> >      44430            +3.8%      46121        perf-stat.i.minor-faults
> >      54.82            +3.9       58.73        perf-stat.i.node-load-mis=
s-rate%
> >   68519419 =C4=85  4%     -11.7%   60479057 =C4=85  6%  perf-stat.i.nod=
e-load-misses
> >   49879161 =C4=85  3%     -20.7%   39554915 =C4=85  4%  perf-stat.i.nod=
e-loads
> >      44428            +3.8%      46119        perf-stat.i.page-faults
> >       0.02            -0.0        0.01 =C4=85  5%  perf-stat.overall.br=
anch-miss-rate%
> >      68.03            -4.2       63.83        perf-stat.overall.cache-m=
iss-rate%
> >       1.65            -2.0%       1.61        perf-stat.overall.cpi
> >     244.61            +4.8%     256.41        perf-stat.overall.cycles-=
between-cache-misses
> >      30.21            +2.2       32.38        perf-stat.overall.iTLB-lo=
ad-miss-rate%
> >     417920 =C4=85  2%      -3.7%     402452        perf-stat.overall.in=
structions-per-iTLB-miss
> >       0.61            +2.1%       0.62        perf-stat.overall.ipc
> >      57.84            +2.6       60.44        perf-stat.overall.node-lo=
ad-miss-rate%
> >  3.925e+10            +5.1%  4.124e+10        perf-stat.ps.branch-instr=
uctions
> >  8.295e+08            -1.8%  8.144e+08        perf-stat.ps.cache-misses
> >  1.219e+09            +4.6%  1.276e+09        perf-stat.ps.cache-refere=
nces
> >       6625 =C4=85  3%     +15.4%       7648        perf-stat.ps.context=
-switches
> >  2.029e+11            +2.9%  2.088e+11        perf-stat.ps.cpu-cycles
> >     256.82            -4.2%     246.09        perf-stat.ps.cpu-migratio=
ns
> >    1184763 =C4=85  2%      +3.3%    1223366        perf-stat.ps.dTLB-lo=
ad-misses
> >  2.658e+10            +4.8%  2.786e+10        perf-stat.ps.dTLB-loads
> >     336658            +4.5%     351710        perf-stat.ps.dTLB-store-m=
isses
> >  9.059e+09            +4.8%  9.497e+09        perf-stat.ps.dTLB-stores
> >     295140 =C4=85  2%      +9.0%     321824        perf-stat.ps.iTLB-lo=
ad-misses
> >  1.233e+11            +5.0%  1.295e+11        perf-stat.ps.instructions
> >      44309            +3.7%      45933        perf-stat.ps.minor-faults
> >   68208972 =C4=85  4%     -11.6%   60272675 =C4=85  6%  perf-stat.ps.no=
de-load-misses
> >   49689740 =C4=85  3%     -20.7%   39401789 =C4=85  4%  perf-stat.ps.no=
de-loads
> >      44308            +3.7%      45932        perf-stat.ps.page-faults
> >  3.732e+13            +5.1%  3.922e+13        perf-stat.total.instructi=
ons
> >      14949 =C4=85  2%     +14.5%      17124 =C4=85 11%  softirqs.CPU0.S=
CHED
> >       9940           +37.8%      13700 =C4=85 24%  softirqs.CPU1.SCHED
> >       9370 =C4=85  2%     +28.2%      12014 =C4=85 16%  softirqs.CPU10.=
SCHED
> >      17637 =C4=85  2%     -16.5%      14733 =C4=85 16%  softirqs.CPU101=
.SCHED
> >      17846 =C4=85  3%     -17.4%      14745 =C4=85 16%  softirqs.CPU103=
.SCHED
> >       9552           +24.7%      11916 =C4=85 17%  softirqs.CPU11.SCHED
> >       9210 =C4=85  5%     +27.9%      11784 =C4=85 16%  softirqs.CPU12.=
SCHED
> >       9378 =C4=85  3%     +27.7%      11974 =C4=85 16%  softirqs.CPU13.=
SCHED
> >       9164 =C4=85  2%     +29.4%      11856 =C4=85 18%  softirqs.CPU14.=
SCHED
> >       9215           +21.2%      11170 =C4=85 19%  softirqs.CPU15.SCHED
> >       9118 =C4=85  2%     +29.1%      11772 =C4=85 16%  softirqs.CPU16.=
SCHED
> >       9413           +29.2%      12165 =C4=85 18%  softirqs.CPU17.SCHED
> >       9309 =C4=85  2%     +29.9%      12097 =C4=85 17%  softirqs.CPU18.=
SCHED
> >       9423           +26.1%      11880 =C4=85 15%  softirqs.CPU19.SCHED
> >       9010 =C4=85  7%     +37.8%      12420 =C4=85 18%  softirqs.CPU2.S=
CHED
> >       9382 =C4=85  3%     +27.0%      11916 =C4=85 15%  softirqs.CPU20.=
SCHED
> >       9102 =C4=85  4%     +30.0%      11830 =C4=85 16%  softirqs.CPU21.=
SCHED
> >       9543 =C4=85  3%     +23.4%      11780 =C4=85 18%  softirqs.CPU22.=
SCHED
> >       8998 =C4=85  5%     +29.2%      11630 =C4=85 18%  softirqs.CPU24.=
SCHED
> >       9254 =C4=85  2%     +23.9%      11462 =C4=85 19%  softirqs.CPU25.=
SCHED
> >      18450 =C4=85  4%     -16.9%      15341 =C4=85 16%  softirqs.CPU26.=
SCHED
> >      17551 =C4=85  4%     -14.8%      14956 =C4=85 13%  softirqs.CPU27.=
SCHED
> >      17575 =C4=85  4%     -14.6%      15010 =C4=85 14%  softirqs.CPU28.=
SCHED
> >      17515 =C4=85  5%     -14.2%      15021 =C4=85 13%  softirqs.CPU29.=
SCHED
> >      17715 =C4=85  2%     -16.1%      14856 =C4=85 13%  softirqs.CPU30.=
SCHED
> >      17754 =C4=85  4%     -16.1%      14904 =C4=85 13%  softirqs.CPU31.=
SCHED
> >      17675 =C4=85  2%     -17.0%      14679 =C4=85 21%  softirqs.CPU32.=
SCHED
> >      17625 =C4=85  2%     -16.0%      14813 =C4=85 13%  softirqs.CPU34.=
SCHED
> >      17619 =C4=85  2%     -14.7%      15024 =C4=85 14%  softirqs.CPU35.=
SCHED
> >      17887 =C4=85  3%     -17.0%      14841 =C4=85 14%  softirqs.CPU36.=
SCHED
> >      17658 =C4=85  3%     -16.3%      14771 =C4=85 12%  softirqs.CPU38.=
SCHED
> >      17501 =C4=85  2%     -15.3%      14816 =C4=85 14%  softirqs.CPU39.=
SCHED
> >       9360 =C4=85  2%     +25.4%      11740 =C4=85 14%  softirqs.CPU4.S=
CHED
> >      17699 =C4=85  4%     -16.2%      14827 =C4=85 14%  softirqs.CPU42.=
SCHED
> >      17580 =C4=85  3%     -16.5%      14679 =C4=85 15%  softirqs.CPU43.=
SCHED
> >      17658 =C4=85  3%     -17.1%      14644 =C4=85 14%  softirqs.CPU44.=
SCHED
> >      17452 =C4=85  4%     -14.0%      15001 =C4=85 15%  softirqs.CPU46.=
SCHED
> >      17599 =C4=85  4%     -17.4%      14544 =C4=85 14%  softirqs.CPU47.=
SCHED
> >      17792 =C4=85  3%     -16.5%      14864 =C4=85 14%  softirqs.CPU48.=
SCHED
> >      17333 =C4=85  2%     -16.7%      14445 =C4=85 14%  softirqs.CPU49.=
SCHED
> >       9483           +32.3%      12547 =C4=85 24%  softirqs.CPU5.SCHED
> >      17842 =C4=85  3%     -15.9%      14997 =C4=85 16%  softirqs.CPU51.=
SCHED
> >       9051 =C4=85  2%     +23.3%      11160 =C4=85 13%  softirqs.CPU52.=
SCHED
> >       9385 =C4=85  3%     +25.2%      11752 =C4=85 16%  softirqs.CPU53.=
SCHED
> >       9446 =C4=85  6%     +24.9%      11798 =C4=85 14%  softirqs.CPU54.=
SCHED
> >      10006 =C4=85  6%     +22.4%      12249 =C4=85 14%  softirqs.CPU55.=
SCHED
> >       9657           +22.0%      11780 =C4=85 16%  softirqs.CPU57.SCHED
> >       9399           +27.5%      11980 =C4=85 15%  softirqs.CPU58.SCHED
> >       9234 =C4=85  3%     +27.7%      11795 =C4=85 14%  softirqs.CPU59.=
SCHED
> >       9726 =C4=85  6%     +24.0%      12062 =C4=85 16%  softirqs.CPU6.S=
CHED
> >       9165 =C4=85  2%     +23.7%      11342 =C4=85 14%  softirqs.CPU60.=
SCHED
> >       9357 =C4=85  2%     +25.8%      11774 =C4=85 15%  softirqs.CPU61.=
SCHED
> >       9406 =C4=85  3%     +25.2%      11780 =C4=85 16%  softirqs.CPU62.=
SCHED
> >       9489           +23.2%      11688 =C4=85 15%  softirqs.CPU63.SCHED
> >       9399 =C4=85  2%     +23.5%      11604 =C4=85 16%  softirqs.CPU65.=
SCHED
> >       8950 =C4=85  2%     +31.6%      11774 =C4=85 16%  softirqs.CPU66.=
SCHED
> >       9260           +21.7%      11267 =C4=85 19%  softirqs.CPU67.SCHED
> >       9187           +27.1%      11672 =C4=85 17%  softirqs.CPU68.SCHED
> >       9443 =C4=85  2%     +25.5%      11847 =C4=85 17%  softirqs.CPU69.=
SCHED
> >       9144 =C4=85  3%     +28.0%      11706 =C4=85 16%  softirqs.CPU7.S=
CHED
> >       9276 =C4=85  2%     +28.0%      11871 =C4=85 17%  softirqs.CPU70.=
SCHED
> >       9494           +21.4%      11526 =C4=85 14%  softirqs.CPU71.SCHED
> >       9124 =C4=85  3%     +27.8%      11657 =C4=85 17%  softirqs.CPU72.=
SCHED
> >       9189 =C4=85  3%     +25.9%      11568 =C4=85 16%  softirqs.CPU73.=
SCHED
> >       9392 =C4=85  2%     +23.7%      11619 =C4=85 16%  softirqs.CPU74.=
SCHED
> >      17821 =C4=85  3%     -14.7%      15197 =C4=85 17%  softirqs.CPU78.=
SCHED
> >      17581 =C4=85  2%     -15.7%      14827 =C4=85 15%  softirqs.CPU79.=
SCHED
> >       9123           +28.2%      11695 =C4=85 15%  softirqs.CPU8.SCHED
> >      17524 =C4=85  2%     -16.7%      14601 =C4=85 14%  softirqs.CPU80.=
SCHED
> >      17644 =C4=85  3%     -16.2%      14782 =C4=85 14%  softirqs.CPU81.=
SCHED
> >      17705 =C4=85  3%     -18.6%      14414 =C4=85 22%  softirqs.CPU84.=
SCHED
> >      17679 =C4=85  2%     -14.1%      15185 =C4=85 11%  softirqs.CPU85.=
SCHED
> >      17434 =C4=85  3%     -15.5%      14724 =C4=85 14%  softirqs.CPU86.=
SCHED
> >      17409 =C4=85  2%     -15.0%      14794 =C4=85 13%  softirqs.CPU87.=
SCHED
> >      17470 =C4=85  3%     -15.7%      14730 =C4=85 13%  softirqs.CPU88.=
SCHED
> >      17748 =C4=85  4%     -17.1%      14721 =C4=85 12%  softirqs.CPU89.=
SCHED
> >       9323           +28.0%      11929 =C4=85 17%  softirqs.CPU9.SCHED
> >      17471 =C4=85  2%     -16.9%      14525 =C4=85 13%  softirqs.CPU90.=
SCHED
> >      17900 =C4=85  3%     -17.0%      14850 =C4=85 14%  softirqs.CPU94.=
SCHED
> >      17599 =C4=85  4%     -17.4%      14544 =C4=85 15%  softirqs.CPU95.=
SCHED
> >      17697 =C4=85  4%     -17.7%      14569 =C4=85 13%  softirqs.CPU96.=
SCHED
> >      17561 =C4=85  3%     -15.1%      14901 =C4=85 13%  softirqs.CPU97.=
SCHED
> >      17404 =C4=85  3%     -16.1%      14601 =C4=85 13%  softirqs.CPU98.=
SCHED
> >      17802 =C4=85  3%     -19.4%      14344 =C4=85 15%  softirqs.CPU99.=
SCHED
> >       1310 =C4=85 10%     -17.0%       1088 =C4=85  5%  interrupts.CPU1=
.RES:Rescheduling_interrupts
> >       3427           +13.3%       3883 =C4=85  9%  interrupts.CPU10.CAL=
:Function_call_interrupts
> >     736.50 =C4=85 20%     +34.4%     989.75 =C4=85 17%  interrupts.CPU1=
00.RES:Rescheduling_interrupts
> >       3421 =C4=85  3%     +14.6%       3921 =C4=85  9%  interrupts.CPU1=
01.CAL:Function_call_interrupts
> >       4873 =C4=85  8%     +16.2%       5662 =C4=85  7%  interrupts.CPU1=
01.NMI:Non-maskable_interrupts
> >       4873 =C4=85  8%     +16.2%       5662 =C4=85  7%  interrupts.CPU1=
01.PMI:Performance_monitoring_interrupts
> >     629.50 =C4=85 19%     +83.2%       1153 =C4=85 46%  interrupts.CPU1=
01.RES:Rescheduling_interrupts
> >     661.75 =C4=85 14%     +25.7%     832.00 =C4=85 13%  interrupts.CPU1=
02.RES:Rescheduling_interrupts
> >       4695 =C4=85  5%     +15.5%       5420 =C4=85  9%  interrupts.CPU1=
03.NMI:Non-maskable_interrupts
> >       4695 =C4=85  5%     +15.5%       5420 =C4=85  9%  interrupts.CPU1=
03.PMI:Performance_monitoring_interrupts
> >       3460           +12.1%       3877 =C4=85  9%  interrupts.CPU11.CAL=
:Function_call_interrupts
> >     691.50 =C4=85  7%     +41.0%     975.00 =C4=85 32%  interrupts.CPU1=
9.RES:Rescheduling_interrupts
> >       3413 =C4=85  2%     +13.4%       3870 =C4=85 10%  interrupts.CPU2=
0.CAL:Function_call_interrupts
> >       3413 =C4=85  2%     +13.4%       3871 =C4=85 10%  interrupts.CPU2=
2.CAL:Function_call_interrupts
> >     863.00 =C4=85 36%     +45.3%       1254 =C4=85 24%  interrupts.CPU2=
3.RES:Rescheduling_interrupts
> >     659.75 =C4=85 12%     +83.4%       1209 =C4=85 20%  interrupts.CPU2=
6.RES:Rescheduling_interrupts
> >     615.00 =C4=85 10%     +87.8%       1155 =C4=85 14%  interrupts.CPU2=
7.RES:Rescheduling_interrupts
> >     663.75 =C4=85  5%     +67.9%       1114 =C4=85  7%  interrupts.CPU2=
8.RES:Rescheduling_interrupts
> >       3421 =C4=85  4%     +13.4%       3879 =C4=85  9%  interrupts.CPU2=
9.CAL:Function_call_interrupts
> >     805.25 =C4=85 16%     +33.0%       1071 =C4=85 15%  interrupts.CPU2=
9.RES:Rescheduling_interrupts
> >       3482 =C4=85  3%     +11.0%       3864 =C4=85  8%  interrupts.CPU3=
.CAL:Function_call_interrupts
> >     819.75 =C4=85 19%     +48.4%       1216 =C4=85 12%  interrupts.CPU3=
0.RES:Rescheduling_interrupts
> >     777.25 =C4=85  8%     +31.6%       1023 =C4=85  6%  interrupts.CPU3=
1.RES:Rescheduling_interrupts
> >     844.50 =C4=85 25%     +41.7%       1196 =C4=85 20%  interrupts.CPU3=
2.RES:Rescheduling_interrupts
> >     722.75 =C4=85 14%     +94.2%       1403 =C4=85 26%  interrupts.CPU3=
3.RES:Rescheduling_interrupts
> >       3944 =C4=85 25%     +36.8%       5394 =C4=85  9%  interrupts.CPU3=
4.NMI:Non-maskable_interrupts
> >       3944 =C4=85 25%     +36.8%       5394 =C4=85  9%  interrupts.CPU3=
4.PMI:Performance_monitoring_interrupts
> >     781.75 =C4=85  9%     +45.3%       1136 =C4=85 27%  interrupts.CPU3=
4.RES:Rescheduling_interrupts
> >     735.50 =C4=85  9%     +33.3%     980.75 =C4=85  4%  interrupts.CPU3=
5.RES:Rescheduling_interrupts
> >     691.75 =C4=85 10%     +41.6%     979.50 =C4=85 13%  interrupts.CPU3=
6.RES:Rescheduling_interrupts
> >     727.00 =C4=85 16%     +47.7%       1074 =C4=85 15%  interrupts.CPU3=
7.RES:Rescheduling_interrupts
> >       4413 =C4=85  7%     +24.9%       5511 =C4=85  9%  interrupts.CPU3=
8.NMI:Non-maskable_interrupts
> >       4413 =C4=85  7%     +24.9%       5511 =C4=85  9%  interrupts.CPU3=
8.PMI:Performance_monitoring_interrupts
> >     708.75 =C4=85 25%     +62.6%       1152 =C4=85 22%  interrupts.CPU3=
8.RES:Rescheduling_interrupts
> >     666.50 =C4=85  7%     +57.8%       1052 =C4=85 13%  interrupts.CPU3=
9.RES:Rescheduling_interrupts
> >     765.75 =C4=85 11%     +25.2%     958.75 =C4=85 14%  interrupts.CPU4=
.RES:Rescheduling_interrupts
> >       3395 =C4=85  2%     +15.1%       3908 =C4=85 10%  interrupts.CPU4=
0.CAL:Function_call_interrupts
> >     770.00 =C4=85 16%     +45.3%       1119 =C4=85 18%  interrupts.CPU4=
0.RES:Rescheduling_interrupts
> >     740.50 =C4=85 26%     +61.9%       1198 =C4=85 19%  interrupts.CPU4=
1.RES:Rescheduling_interrupts
> >       3459 =C4=85  2%     +12.9%       3905 =C4=85 11%  interrupts.CPU4=
2.CAL:Function_call_interrupts
> >       4530 =C4=85  5%     +22.8%       5564 =C4=85  9%  interrupts.CPU4=
2.NMI:Non-maskable_interrupts
> >       4530 =C4=85  5%     +22.8%       5564 =C4=85  9%  interrupts.CPU4=
2.PMI:Performance_monitoring_interrupts
> >       3330 =C4=85 25%     +60.0%       5328 =C4=85 10%  interrupts.CPU4=
4.NMI:Non-maskable_interrupts
> >       3330 =C4=85 25%     +60.0%       5328 =C4=85 10%  interrupts.CPU4=
4.PMI:Performance_monitoring_interrupts
> >     686.25 =C4=85  9%     +48.4%       1018 =C4=85 10%  interrupts.CPU4=
4.RES:Rescheduling_interrupts
> >     702.00 =C4=85 15%     +38.6%     973.25 =C4=85  5%  interrupts.CPU4=
5.RES:Rescheduling_interrupts
> >       4742 =C4=85  7%     +19.3%       5657 =C4=85  8%  interrupts.CPU4=
6.NMI:Non-maskable_interrupts
> >       4742 =C4=85  7%     +19.3%       5657 =C4=85  8%  interrupts.CPU4=
6.PMI:Performance_monitoring_interrupts
> >     732.75 =C4=85  6%     +51.9%       1113 =C4=85  7%  interrupts.CPU4=
6.RES:Rescheduling_interrupts
> >     775.50 =C4=85 17%     +41.3%       1095 =C4=85  6%  interrupts.CPU4=
7.RES:Rescheduling_interrupts
> >     670.75 =C4=85  5%     +60.7%       1078 =C4=85  6%  interrupts.CPU4=
8.RES:Rescheduling_interrupts
> >       4870 =C4=85  8%     +16.5%       5676 =C4=85  7%  interrupts.CPU4=
9.NMI:Non-maskable_interrupts
> >       4870 =C4=85  8%     +16.5%       5676 =C4=85  7%  interrupts.CPU4=
9.PMI:Performance_monitoring_interrupts
> >     694.75 =C4=85 12%     +25.8%     874.00 =C4=85 11%  interrupts.CPU4=
9.RES:Rescheduling_interrupts
> >     686.00 =C4=85  9%     +52.0%       1042 =C4=85 20%  interrupts.CPU5=
0.RES:Rescheduling_interrupts
> >       3361           +17.2%       3938 =C4=85  9%  interrupts.CPU51.CAL=
:Function_call_interrupts
> >       4707 =C4=85  6%     +16.0%       5463 =C4=85  8%  interrupts.CPU5=
1.NMI:Non-maskable_interrupts
> >       4707 =C4=85  6%     +16.0%       5463 =C4=85  8%  interrupts.CPU5=
1.PMI:Performance_monitoring_interrupts
> >     638.75 =C4=85 12%     +28.6%     821.25 =C4=85 15%  interrupts.CPU5=
4.RES:Rescheduling_interrupts
> >     677.50 =C4=85  8%     +51.8%       1028 =C4=85 29%  interrupts.CPU5=
8.RES:Rescheduling_interrupts
> >       3465 =C4=85  2%     +12.0%       3880 =C4=85  9%  interrupts.CPU6=
.CAL:Function_call_interrupts
> >     641.25 =C4=85  2%     +26.1%     808.75 =C4=85 10%  interrupts.CPU6=
0.RES:Rescheduling_interrupts
> >     599.75 =C4=85  2%     +45.6%     873.50 =C4=85  8%  interrupts.CPU6=
2.RES:Rescheduling_interrupts
> >     661.50 =C4=85  9%     +52.4%       1008 =C4=85 27%  interrupts.CPU6=
3.RES:Rescheduling_interrupts
> >     611.00 =C4=85 12%     +31.1%     801.00 =C4=85 13%  interrupts.CPU6=
9.RES:Rescheduling_interrupts
> >       3507 =C4=85  2%     +10.8%       3888 =C4=85  9%  interrupts.CPU7=
.CAL:Function_call_interrupts
> >     664.00 =C4=85  5%     +32.3%     878.50 =C4=85 23%  interrupts.CPU7=
0.RES:Rescheduling_interrupts
> >       5780 =C4=85  9%     -38.8%       3540 =C4=85 37%  interrupts.CPU7=
3.NMI:Non-maskable_interrupts
> >       5780 =C4=85  9%     -38.8%       3540 =C4=85 37%  interrupts.CPU7=
3.PMI:Performance_monitoring_interrupts
> >       5787 =C4=85  9%     -26.7%       4243 =C4=85 28%  interrupts.CPU7=
6.NMI:Non-maskable_interrupts
> >       5787 =C4=85  9%     -26.7%       4243 =C4=85 28%  interrupts.CPU7=
6.PMI:Performance_monitoring_interrupts
> >     751.50 =C4=85 15%     +88.0%       1413 =C4=85 37%  interrupts.CPU7=
8.RES:Rescheduling_interrupts
> >     725.50 =C4=85 12%     +82.9%       1327 =C4=85 36%  interrupts.CPU7=
9.RES:Rescheduling_interrupts
> >     714.00 =C4=85 18%     +33.2%     951.00 =C4=85 15%  interrupts.CPU8=
0.RES:Rescheduling_interrupts
> >     706.25 =C4=85 19%     +55.6%       1098 =C4=85 27%  interrupts.CPU8=
2.RES:Rescheduling_interrupts
> >       4524 =C4=85  6%     +19.6%       5409 =C4=85  8%  interrupts.CPU8=
3.NMI:Non-maskable_interrupts
> >       4524 =C4=85  6%     +19.6%       5409 =C4=85  8%  interrupts.CPU8=
3.PMI:Performance_monitoring_interrupts
> >     666.75 =C4=85 15%     +37.3%     915.50 =C4=85  4%  interrupts.CPU8=
3.RES:Rescheduling_interrupts
> >     782.50 =C4=85 26%     +57.6%       1233 =C4=85 21%  interrupts.CPU8=
4.RES:Rescheduling_interrupts
> >     622.75 =C4=85 12%     +77.8%       1107 =C4=85 17%  interrupts.CPU8=
5.RES:Rescheduling_interrupts
> >       3465 =C4=85  3%     +13.5%       3933 =C4=85  9%  interrupts.CPU8=
6.CAL:Function_call_interrupts
> >     714.75 =C4=85 14%     +47.0%       1050 =C4=85 10%  interrupts.CPU8=
6.RES:Rescheduling_interrupts
> >       3519 =C4=85  2%     +11.7%       3929 =C4=85  9%  interrupts.CPU8=
7.CAL:Function_call_interrupts
> >     582.75 =C4=85 10%     +54.2%     898.75 =C4=85 11%  interrupts.CPU8=
7.RES:Rescheduling_interrupts
> >     713.00 =C4=85 10%     +36.6%     974.25 =C4=85 11%  interrupts.CPU8=
8.RES:Rescheduling_interrupts
> >     690.50 =C4=85 13%     +53.0%       1056 =C4=85 13%  interrupts.CPU8=
9.RES:Rescheduling_interrupts
> >       3477           +11.0%       3860 =C4=85  8%  interrupts.CPU9.CAL:=
Function_call_interrupts
> >     684.50 =C4=85 14%     +39.7%     956.25 =C4=85 11%  interrupts.CPU9=
0.RES:Rescheduling_interrupts
> >       3946 =C4=85 21%     +39.8%       5516 =C4=85 10%  interrupts.CPU9=
1.NMI:Non-maskable_interrupts
> >       3946 =C4=85 21%     +39.8%       5516 =C4=85 10%  interrupts.CPU9=
1.PMI:Performance_monitoring_interrupts
> >     649.00 =C4=85 13%     +54.3%       1001 =C4=85  6%  interrupts.CPU9=
1.RES:Rescheduling_interrupts
> >     674.25 =C4=85 21%     +39.5%     940.25 =C4=85 11%  interrupts.CPU9=
2.RES:Rescheduling_interrupts
> >       3971 =C4=85 26%     +41.2%       5606 =C4=85  8%  interrupts.CPU9=
4.NMI:Non-maskable_interrupts
> >       3971 =C4=85 26%     +41.2%       5606 =C4=85  8%  interrupts.CPU9=
4.PMI:Performance_monitoring_interrupts
> >       4129 =C4=85 22%     +33.2%       5499 =C4=85  9%  interrupts.CPU9=
5.NMI:Non-maskable_interrupts
> >       4129 =C4=85 22%     +33.2%       5499 =C4=85  9%  interrupts.CPU9=
5.PMI:Performance_monitoring_interrupts
> >     685.75 =C4=85 14%     +38.0%     946.50 =C4=85  9%  interrupts.CPU9=
6.RES:Rescheduling_interrupts
> >       4630 =C4=85 11%     +18.3%       5477 =C4=85  8%  interrupts.CPU9=
7.NMI:Non-maskable_interrupts
> >       4630 =C4=85 11%     +18.3%       5477 =C4=85  8%  interrupts.CPU9=
7.PMI:Performance_monitoring_interrupts
> >       4835 =C4=85  9%     +16.3%       5622 =C4=85  9%  interrupts.CPU9=
8.NMI:Non-maskable_interrupts
> >       4835 =C4=85  9%     +16.3%       5622 =C4=85  9%  interrupts.CPU9=
8.PMI:Performance_monitoring_interrupts
> >     596.25 =C4=85 11%     +81.8%       1083 =C4=85  9%  interrupts.CPU9=
8.RES:Rescheduling_interrupts
> >     674.75 =C4=85 17%     +43.7%     969.50 =C4=85  5%  interrupts.CPU9=
9.RES:Rescheduling_interrupts
> >      78.25 =C4=85 13%     +21.4%      95.00 =C4=85 10%  interrupts.IWI:=
IRQ_work_interrupts
> >      85705 =C4=85  6%     +26.0%     107990 =C4=85  6%  interrupts.RES:=
Rescheduling_interrupts
> >
> >
> >
> > ***********************************************************************=
****************************
> > lkp-bdw-ep6: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with =
128G memory
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/sc_pid_m=
ax/tbox_group/testcase/testtime/ucode:
> >   scheduler/gcc-7/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-2=
019-11-14.cgz/4194304/lkp-bdw-ep6/stress-ng/1s/0xb000038
> >
> > commit:
> >   fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
> >   0b0695f2b3 ("sched/fair: Rework load_balance()")
> >
> > fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >     887157 =C4=85  4%     -23.1%     682080 =C4=85  3%  stress-ng.fault=
.ops
> >     887743 =C4=85  4%     -23.1%     682337 =C4=85  3%  stress-ng.fault=
.ops_per_sec
> >    9537184 =C4=85 10%     -21.2%    7518352 =C4=85 14%  stress-ng.hrtim=
ers.ops_per_sec
> >     360922 =C4=85 13%     -21.1%     284734 =C4=85  6%  stress-ng.kill.=
ops
> >     361115 =C4=85 13%     -21.1%     284810 =C4=85  6%  stress-ng.kill.=
ops_per_sec
> >   23260649           -26.9%   17006477 =C4=85 24%  stress-ng.mq.ops
> >   23255884           -26.9%   17004540 =C4=85 24%  stress-ng.mq.ops_per=
_sec
> >    3291588 =C4=85  3%     +42.5%    4690316 =C4=85  2%  stress-ng.sched=
policy.ops
> >    3327913 =C4=85  3%     +41.5%    4709770 =C4=85  2%  stress-ng.sched=
policy.ops_per_sec
> >      48.14            -2.2%      47.09        stress-ng.time.elapsed_ti=
me
> >      48.14            -2.2%      47.09        stress-ng.time.elapsed_ti=
me.max
> >       5480            +3.7%       5681        stress-ng.time.percent_of=
_cpu_this_job_got
> >       2249            +1.3%       2278        stress-ng.time.system_tim=
e
> >     902759 =C4=85  4%     -22.6%     698616 =C4=85  3%  proc-vmstat.une=
victable_pgs_culled
> >   98767954 =C4=85  7%     +16.4%   1.15e+08 =C4=85  7%  cpuidle.C1.time
> >    1181676 =C4=85 12%     -43.2%     671022 =C4=85 37%  cpuidle.C6.usag=
e
> >       2.21 =C4=85  7%      +0.4        2.62 =C4=85 10%  turbostat.C1%
> >    1176838 =C4=85 12%     -43.2%     668921 =C4=85 37%  turbostat.C6
> >    3961223 =C4=85  4%     +12.8%    4469620 =C4=85  5%  vmstat.memory.c=
ache
> >     439.50 =C4=85  3%     +14.7%     504.00 =C4=85  9%  vmstat.procs.r
> >       0.42 =C4=85  7%     -15.6%       0.35 =C4=85 13%  sched_debug.cfs=
_rq:/.nr_running.stddev
> >       0.00 =C4=85  4%     -18.1%       0.00 =C4=85 16%  sched_debug.cpu=
.next_balance.stddev
> >       0.41 =C4=85  7%     -15.1%       0.35 =C4=85 13%  sched_debug.cpu=
.nr_running.stddev
> >       9367 =C4=85  9%     -12.8%       8166 =C4=85  2%  softirqs.CPU1.S=
CHED
> >      35143 =C4=85  6%     -12.0%      30930 =C4=85  2%  softirqs.CPU22.=
TIMER
> >      31997 =C4=85  4%      -7.5%      29595 =C4=85  2%  softirqs.CPU27.=
TIMER
> >       3.64 =C4=85173%    -100.0%       0.00        iostat.sda.await.max
> >       3.64 =C4=85173%    -100.0%       0.00        iostat.sda.r_await.m=
ax
> >       3.90 =C4=85173%    -100.0%       0.00        iostat.sdc.await.max
> >       3.90 =C4=85173%    -100.0%       0.00        iostat.sdc.r_await.m=
ax
> >   12991737 =C4=85 10%     +61.5%   20979642 =C4=85  8%  numa-numastat.n=
ode0.local_node
> >   13073590 =C4=85 10%     +61.1%   21059448 =C4=85  8%  numa-numastat.n=
ode0.numa_hit
> >   20903562 =C4=85  3%     -32.2%   14164789 =C4=85  3%  numa-numastat.n=
ode1.local_node
> >   20993788 =C4=85  3%     -32.1%   14245636 =C4=85  3%  numa-numastat.n=
ode1.numa_hit
> >      90229 =C4=85  4%     -10.4%      80843 =C4=85  9%  numa-numastat.n=
ode1.other_node
> >      50.75 =C4=85 90%   +1732.0%     929.75 =C4=85147%  interrupts.CPU2=
3.IWI:IRQ_work_interrupts
> >      40391 =C4=85 59%     -57.0%      17359 =C4=85 11%  interrupts.CPU2=
4.RES:Rescheduling_interrupts
> >      65670 =C4=85 11%     -48.7%      33716 =C4=85 54%  interrupts.CPU4=
2.RES:Rescheduling_interrupts
> >      42201 =C4=85 46%     -57.1%      18121 =C4=85 35%  interrupts.CPU4=
9.RES:Rescheduling_interrupts
> >     293869 =C4=85 44%    +103.5%     598082 =C4=85 23%  interrupts.CPU5=
2.LOC:Local_timer_interrupts
> >      17367 =C4=85  8%    +120.5%      38299 =C4=85 44%  interrupts.CPU5=
5.RES:Rescheduling_interrupts
> >  1.127e+08            +3.8%   1.17e+08 =C4=85  2%  perf-stat.i.branch-m=
isses
> >      11.10            +1.2       12.26 =C4=85  6%  perf-stat.i.cache-mi=
ss-rate%
> >  4.833e+10 =C4=85  3%      +4.7%   5.06e+10        perf-stat.i.instruct=
ions
> >   15009442 =C4=85  4%     +14.3%   17150138 =C4=85  3%  perf-stat.i.nod=
e-load-misses
> >      47.12 =C4=85  5%      +3.2       50.37 =C4=85  5%  perf-stat.i.nod=
e-store-miss-rate%
> >    6016833 =C4=85  7%     +17.0%    7036803 =C4=85  3%  perf-stat.i.nod=
e-store-misses
> >  1.044e+10 =C4=85  2%      +4.0%  1.086e+10        perf-stat.ps.branch-=
instructions
> >  1.364e+10 =C4=85  3%      +4.0%  1.418e+10        perf-stat.ps.dTLB-lo=
ads
> >  4.804e+10 =C4=85  2%      +4.1%  5.003e+10        perf-stat.ps.instruc=
tions
> >   14785608 =C4=85  5%     +11.3%   16451530 =C4=85  3%  perf-stat.ps.no=
de-load-misses
> >    5968712 =C4=85  7%     +13.4%    6769847 =C4=85  3%  perf-stat.ps.no=
de-store-misses
> >      13588 =C4=85  4%     +29.4%      17585 =C4=85  9%  slabinfo.Acpi-S=
tate.active_objs
> >      13588 =C4=85  4%     +29.4%      17585 =C4=85  9%  slabinfo.Acpi-S=
tate.num_objs
> >      20859 =C4=85  3%      -8.6%      19060 =C4=85  4%  slabinfo.kmallo=
c-192.num_objs
> >     488.00 =C4=85 25%     +41.0%     688.00 =C4=85  5%  slabinfo.kmallo=
c-rcl-128.active_objs
> >     488.00 =C4=85 25%     +41.0%     688.00 =C4=85  5%  slabinfo.kmallo=
c-rcl-128.num_objs
> >      39660 =C4=85  3%     +11.8%      44348 =C4=85  2%  slabinfo.radix_=
tree_node.active_objs
> >      44284 =C4=85  3%     +12.3%      49720        slabinfo.radix_tree_=
node.num_objs
> >       5811 =C4=85 15%     +16.1%       6746 =C4=85 14%  slabinfo.sighan=
d_cache.active_objs
> >     402.00 =C4=85 15%     +17.5%     472.50 =C4=85 14%  slabinfo.sighan=
d_cache.active_slabs
> >       6035 =C4=85 15%     +17.5%       7091 =C4=85 14%  slabinfo.sighan=
d_cache.num_objs
> >     402.00 =C4=85 15%     +17.5%     472.50 =C4=85 14%  slabinfo.sighan=
d_cache.num_slabs
> >      10282 =C4=85 10%     +12.9%      11604 =C4=85  9%  slabinfo.signal=
_cache.active_objs
> >      11350 =C4=85 10%     +12.8%      12808 =C4=85  9%  slabinfo.signal=
_cache.num_objs
> >     732920 =C4=85  9%    +162.0%    1919987 =C4=85 11%  numa-meminfo.no=
de0.Active
> >     732868 =C4=85  9%    +162.0%    1919814 =C4=85 11%  numa-meminfo.no=
de0.Active(anon)
> >     545019 =C4=85  6%     +61.0%     877443 =C4=85 17%  numa-meminfo.no=
de0.AnonHugePages
> >     695015 =C4=85 10%     +46.8%    1020150 =C4=85 14%  numa-meminfo.no=
de0.AnonPages
> >     638322 =C4=85  4%    +448.2%    3499399 =C4=85  5%  numa-meminfo.no=
de0.FilePages
> >      81008 =C4=85 14%   +2443.4%    2060329 =C4=85  3%  numa-meminfo.no=
de0.Inactive
> >      80866 =C4=85 14%   +2447.4%    2060022 =C4=85  3%  numa-meminfo.no=
de0.Inactive(anon)
> >      86504 =C4=85 10%   +2287.3%    2065084 =C4=85  3%  numa-meminfo.no=
de0.Mapped
> >    2010104          +160.8%    5242366 =C4=85  5%  numa-meminfo.node0.M=
emUsed
> >      16453 =C4=85 15%    +159.2%      42640        numa-meminfo.node0.P=
ageTables
> >     112769 =C4=85 13%   +2521.1%    2955821 =C4=85  7%  numa-meminfo.no=
de0.Shmem
> >    1839527 =C4=85  4%     -60.2%     732645 =C4=85 23%  numa-meminfo.no=
de1.Active
> >    1839399 =C4=85  4%     -60.2%     732637 =C4=85 23%  numa-meminfo.no=
de1.Active(anon)
> >     982237 =C4=85  7%     -45.9%     531445 =C4=85 27%  numa-meminfo.no=
de1.AnonHugePages
> >    1149348 =C4=85  8%     -41.2%     676067 =C4=85 25%  numa-meminfo.no=
de1.AnonPages
> >    3170649 =C4=85  4%     -77.2%     723230 =C4=85  7%  numa-meminfo.no=
de1.FilePages
> >    1960718 =C4=85  4%     -91.8%     160773 =C4=85 31%  numa-meminfo.no=
de1.Inactive
> >    1960515 =C4=85  4%     -91.8%     160722 =C4=85 31%  numa-meminfo.no=
de1.Inactive(anon)
> >     118489 =C4=85 11%     -20.2%      94603 =C4=85  3%  numa-meminfo.no=
de1.KReclaimable
> >    1966065 =C4=85  4%     -91.5%     166789 =C4=85 29%  numa-meminfo.no=
de1.Mapped
> >    5034310 =C4=85  3%     -60.2%    2003121 =C4=85  9%  numa-meminfo.no=
de1.MemUsed
> >      42684 =C4=85 10%     -64.2%      15283 =C4=85 21%  numa-meminfo.no=
de1.PageTables
> >     118489 =C4=85 11%     -20.2%      94603 =C4=85  3%  numa-meminfo.no=
de1.SReclaimable
> >    2644708 =C4=85  5%     -91.9%     214268 =C4=85 24%  numa-meminfo.no=
de1.Shmem
> >     147513 =C4=85 20%    +244.2%     507737 =C4=85  7%  numa-vmstat.nod=
e0.nr_active_anon
> >     137512 =C4=85 21%    +105.8%     282999 =C4=85  3%  numa-vmstat.nod=
e0.nr_anon_pages
> >     210.25 =C4=85 33%    +124.7%     472.50 =C4=85 11%  numa-vmstat.nod=
e0.nr_anon_transparent_hugepages
> >     158008 =C4=85  4%    +454.7%     876519 =C4=85  6%  numa-vmstat.nod=
e0.nr_file_pages
> >      18416 =C4=85 27%   +2711.4%     517747 =C4=85  3%  numa-vmstat.nod=
e0.nr_inactive_anon
> >      26255 =C4=85 22%     +34.3%      35251 =C4=85 10%  numa-vmstat.nod=
e0.nr_kernel_stack
> >      19893 =C4=85 23%   +2509.5%     519129 =C4=85  3%  numa-vmstat.nod=
e0.nr_mapped
> >       3928 =C4=85 22%    +179.4%      10976 =C4=85  4%  numa-vmstat.nod=
e0.nr_page_table_pages
> >      26623 =C4=85 18%   +2681.9%     740635 =C4=85  7%  numa-vmstat.nod=
e0.nr_shmem
> >     147520 =C4=85 20%    +244.3%     507885 =C4=85  7%  numa-vmstat.nod=
e0.nr_zone_active_anon
> >      18415 =C4=85 27%   +2711.5%     517739 =C4=85  3%  numa-vmstat.nod=
e0.nr_zone_inactive_anon
> >    6937137 =C4=85  8%     +55.9%   10814957 =C4=85  7%  numa-vmstat.nod=
e0.numa_hit
> >    6860210 =C4=85  8%     +56.6%   10739902 =C4=85  7%  numa-vmstat.nod=
e0.numa_local
> >     425559 =C4=85 13%     -52.9%     200300 =C4=85 17%  numa-vmstat.nod=
e1.nr_active_anon
> >     786341 =C4=85  4%     -76.6%     183664 =C4=85  7%  numa-vmstat.nod=
e1.nr_file_pages
> >     483646 =C4=85  4%     -90.8%      44606 =C4=85 29%  numa-vmstat.nod=
e1.nr_inactive_anon
> >     485120 =C4=85  4%     -90.5%      46130 =C4=85 27%  numa-vmstat.nod=
e1.nr_mapped
> >      10471 =C4=85  6%     -61.3%       4048 =C4=85 18%  numa-vmstat.nod=
e1.nr_page_table_pages
> >     654852 =C4=85  5%     -91.4%      56439 =C4=85 25%  numa-vmstat.nod=
e1.nr_shmem
> >      29681 =C4=85 11%     -20.3%      23669 =C4=85  3%  numa-vmstat.nod=
e1.nr_slab_reclaimable
> >     425556 =C4=85 13%     -52.9%     200359 =C4=85 17%  numa-vmstat.nod=
e1.nr_zone_active_anon
> >     483649 =C4=85  4%     -90.8%      44600 =C4=85 29%  numa-vmstat.nod=
e1.nr_zone_inactive_anon
> >   10527487 =C4=85  5%     -31.3%    7233899 =C4=85  6%  numa-vmstat.nod=
e1.numa_hit
> >   10290625 =C4=85  5%     -31.9%    7006050 =C4=85  7%  numa-vmstat.nod=
e1.numa_local
> >
> >
> >
> > ***********************************************************************=
****************************
> > lkp-csl-2sp5: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with =
192G memory
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_gro=
up/testcase/testtime/ucode:
> >   interrupt/gcc-7/performance/1HDD/x86_64-fedora-25/100%/debian-x86_64-=
2019-11-14.cgz/lkp-csl-2sp5/stress-ng/1s/0x500002c
> >
> > commit:
> >   fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
> >   0b0695f2b3 ("sched/fair: Rework load_balance()")
> >
> > fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >    6684836           -33.3%    4457559 =C4=85  4%  stress-ng.schedpolic=
y.ops
> >    6684766           -33.3%    4457633 =C4=85  4%  stress-ng.schedpolic=
y.ops_per_sec
> >   19978129           -28.8%   14231813 =C4=85 16%  stress-ng.time.invol=
untary_context_switches
> >      82.49 =C4=85  2%      -5.2%      78.23        stress-ng.time.user_=
time
> >     106716 =C4=85 29%     +40.3%     149697 =C4=85  2%  meminfo.max_use=
d_kB
> >       4.07 =C4=85 22%      +1.2        5.23 =C4=85  5%  mpstat.cpu.all.=
irq%
> >    2721317 =C4=85 10%     +66.5%    4531100 =C4=85 22%  cpuidle.POLL.ti=
me
> >      71470 =C4=85 18%     +41.1%     100822 =C4=85 11%  cpuidle.POLL.us=
age
> >     841.00 =C4=85 41%     -50.4%     417.25 =C4=85 17%  numa-meminfo.no=
de0.Dirty
> >       7096 =C4=85  7%     +25.8%       8930 =C4=85  9%  numa-meminfo.no=
de1.KernelStack
> >      68752 =C4=85 90%     -45.9%      37169 =C4=85143%  sched_debug.cfs=
_rq:/.runnable_weight.stddev
> >     654.93 =C4=85 11%     +19.3%     781.09 =C4=85  2%  sched_debug.cpu=
.clock_task.stddev
> >     183.06 =C4=85 83%     -76.9%      42.20 =C4=85 17%  iostat.sda.awai=
t.max
> >     627.47 =C4=85102%     -96.7%      20.52 =C4=85 38%  iostat.sda.r_aw=
ait.max
> >     183.08 =C4=85 83%     -76.9%      42.24 =C4=85 17%  iostat.sda.w_aw=
ait.max
> >     209.00 =C4=85 41%     -50.2%     104.00 =C4=85 17%  numa-vmstat.nod=
e0.nr_dirty
> >     209.50 =C4=85 41%     -50.4%     104.00 =C4=85 17%  numa-vmstat.nod=
e0.nr_zone_write_pending
> >       6792 =C4=85  8%     +34.4%       9131 =C4=85  7%  numa-vmstat.nod=
e1.nr_kernel_stack
> >       3.57 =C4=85173%      +9.8       13.38 =C4=85 25%  perf-profile.ca=
lltrace.cycles-pp.proc_reg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe
> >       3.57 =C4=85173%      +9.8       13.38 =C4=85 25%  perf-profile.ca=
lltrace.cycles-pp.seq_read.proc_reg_read.vfs_read.ksys_read.do_syscall_64
> >       3.57 =C4=85173%      +9.8       13.39 =C4=85 25%  perf-profile.ch=
ildren.cycles-pp.proc_reg_read
> >       3.57 =C4=85173%     +12.6       16.16 =C4=85 28%  perf-profile.ch=
ildren.cycles-pp.seq_read
> >       7948 =C4=85 56%     -53.1%       3730 =C4=85  5%  softirqs.CPU25.=
RCU
> >       6701 =C4=85 33%     -46.7%       3570 =C4=85  5%  softirqs.CPU34.=
RCU
> >       8232 =C4=85 89%     -60.5%       3247        softirqs.CPU50.RCU
> >     326269 =C4=85 16%     -27.4%     236940        softirqs.RCU
> >      68066            +7.9%      73438        proc-vmstat.nr_active_ano=
n
> >      67504            +7.8%      72783        proc-vmstat.nr_anon_pages
> >       7198 =C4=85 19%     +34.2%       9658 =C4=85  2%  proc-vmstat.nr_=
page_table_pages
> >      40664 =C4=85  8%     +10.1%      44766        proc-vmstat.nr_slab_=
unreclaimable
> >      68066            +7.9%      73438        proc-vmstat.nr_zone_activ=
e_anon
> >    1980169 =C4=85  4%      -5.3%    1875307        proc-vmstat.numa_hit
> >    1960247 =C4=85  4%      -5.4%    1855033        proc-vmstat.numa_loc=
al
> >     956008 =C4=85 16%     -17.8%     786247        proc-vmstat.pgfault
> >      26598 =C4=85 76%    +301.2%     106716 =C4=85 45%  interrupts.CPU1=
.RES:Rescheduling_interrupts
> >     151212 =C4=85 39%     -67.3%      49451 =C4=85 57%  interrupts.CPU2=
6.RES:Rescheduling_interrupts
> >    1013586 =C4=85  2%     -10.9%     903528 =C4=85  7%  interrupts.CPU2=
7.LOC:Local_timer_interrupts
> >    1000980 =C4=85  2%     -11.4%     886740 =C4=85  8%  interrupts.CPU3=
1.LOC:Local_timer_interrupts
> >    1021043 =C4=85  3%      -9.9%     919686 =C4=85  6%  interrupts.CPU3=
2.LOC:Local_timer_interrupts
> >     125222 =C4=85 51%     -86.0%      17483 =C4=85106%  interrupts.CPU3=
3.RES:Rescheduling_interrupts
> >    1003735 =C4=85  2%     -11.1%     891833 =C4=85  8%  interrupts.CPU3=
4.LOC:Local_timer_interrupts
> >    1021799 =C4=85  2%     -13.2%     886665 =C4=85  8%  interrupts.CPU3=
8.LOC:Local_timer_interrupts
> >     997788 =C4=85  2%     -13.2%     866427 =C4=85 10%  interrupts.CPU4=
2.LOC:Local_timer_interrupts
> >    1001618           -11.6%     885490 =C4=85  9%  interrupts.CPU45.LOC=
:Local_timer_interrupts
> >      22321 =C4=85 58%    +550.3%     145153 =C4=85 22%  interrupts.CPU9=
.RES:Rescheduling_interrupts
> >       3151 =C4=85 53%     +67.3%       5273 =C4=85  8%  slabinfo.avc_xp=
erms_data.active_objs
> >       3151 =C4=85 53%     +67.3%       5273 =C4=85  8%  slabinfo.avc_xp=
erms_data.num_objs
> >     348.75 =C4=85 13%     +39.8%     487.50 =C4=85  5%  slabinfo.biovec=
-128.active_objs
> >     348.75 =C4=85 13%     +39.8%     487.50 =C4=85  5%  slabinfo.biovec=
-128.num_objs
> >      13422 =C4=85 97%    +121.1%      29678 =C4=85  2%  slabinfo.btrfs_=
extent_map.active_objs
> >      14638 =C4=85 98%    +117.8%      31888 =C4=85  2%  slabinfo.btrfs_=
extent_map.num_objs
> >       3835 =C4=85 18%     +40.9%       5404 =C4=85  7%  slabinfo.dmaeng=
ine-unmap-16.active_objs
> >       3924 =C4=85 18%     +39.9%       5490 =C4=85  8%  slabinfo.dmaeng=
ine-unmap-16.num_objs
> >       3482 =C4=85 96%    +119.1%       7631 =C4=85 10%  slabinfo.khugep=
aged_mm_slot.active_objs
> >       3573 =C4=85 96%    +119.4%       7839 =C4=85 10%  slabinfo.khugep=
aged_mm_slot.num_objs
> >       8629 =C4=85 52%     -49.2%       4384        slabinfo.kmalloc-rcl=
-64.active_objs
> >       8629 =C4=85 52%     -49.2%       4384        slabinfo.kmalloc-rcl=
-64.num_objs
> >       2309 =C4=85 57%     +82.1%       4206 =C4=85  5%  slabinfo.mnt_ca=
che.active_objs
> >       2336 =C4=85 57%     +80.8%       4224 =C4=85  5%  slabinfo.mnt_ca=
che.num_objs
> >       5320 =C4=85 48%     +69.1%       8999 =C4=85 23%  slabinfo.pool_w=
orkqueue.active_objs
> >     165.75 =C4=85 48%     +69.4%     280.75 =C4=85 23%  slabinfo.pool_w=
orkqueue.active_slabs
> >       5320 =C4=85 48%     +69.2%       8999 =C4=85 23%  slabinfo.pool_w=
orkqueue.num_objs
> >     165.75 =C4=85 48%     +69.4%     280.75 =C4=85 23%  slabinfo.pool_w=
orkqueue.num_slabs
> >       3306 =C4=85 15%     +27.0%       4199 =C4=85  3%  slabinfo.task_g=
roup.active_objs
> >       3333 =C4=85 16%     +30.1%       4336 =C4=85  3%  slabinfo.task_g=
roup.num_objs
> >      14.74 =C4=85  2%      +1.8       16.53 =C4=85  2%  perf-stat.i.cac=
he-miss-rate%
> >   22459727 =C4=85 20%     +46.7%   32955572 =C4=85  4%  perf-stat.i.cac=
he-misses
> >      33575 =C4=85 19%     +68.8%      56658 =C4=85 13%  perf-stat.i.cpu=
-migrations
> >       0.03 =C4=85 20%      +0.0        0.05 =C4=85  8%  perf-stat.i.dTL=
B-load-miss-rate%
> >    6351703 =C4=85 33%     +47.2%    9352532 =C4=85  9%  perf-stat.i.dTL=
B-load-misses
> >       0.45 =C4=85  3%      -3.0%       0.44        perf-stat.i.ipc
> >    4711345 =C4=85 18%     +43.9%    6780944 =C4=85  7%  perf-stat.i.nod=
e-load-misses
> >      82.51            +4.5       86.97        perf-stat.i.node-store-mi=
ss-rate%
> >    2861142 =C4=85 31%     +60.8%    4601146 =C4=85  5%  perf-stat.i.nod=
e-store-misses
> >       0.92 =C4=85  6%      -0.1        0.85 =C4=85  2%  perf-stat.overa=
ll.branch-miss-rate%
> >       0.02 =C4=85  3%      +0.0        0.02 =C4=85  4%  perf-stat.overa=
ll.dTLB-store-miss-rate%
> >     715.05 =C4=85  5%      +9.9%     785.50 =C4=85  4%  perf-stat.overa=
ll.instructions-per-iTLB-miss
> >       0.44 =C4=85  2%      -5.4%       0.42 =C4=85  2%  perf-stat.overa=
ll.ipc
> >      79.67            +2.1       81.80 =C4=85  2%  perf-stat.overall.no=
de-store-miss-rate%
> >   22237897 =C4=85 19%     +46.4%   32560557 =C4=85  5%  perf-stat.ps.ca=
che-misses
> >      32491 =C4=85 18%     +70.5%      55390 =C4=85 13%  perf-stat.ps.cp=
u-migrations
> >    6071108 =C4=85 31%     +45.0%    8804767 =C4=85  9%  perf-stat.ps.dT=
LB-load-misses
> >       1866 =C4=85 98%     -91.9%     150.48 =C4=85  2%  perf-stat.ps.ma=
jor-faults
> >    4593546 =C4=85 16%     +42.4%    6541402 =C4=85  7%  perf-stat.ps.no=
de-load-misses
> >    2757176 =C4=85 29%     +58.4%    4368169 =C4=85  5%  perf-stat.ps.no=
de-store-misses
> >  1.303e+12 =C4=85  3%      -9.8%  1.175e+12 =C4=85  3%  perf-stat.total=
.instructions
> >
> >
> >
> > ***********************************************************************=
****************************
> > lkp-bdw-ep6: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with =
128G memory
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_gro=
up/testcase/testtime/ucode:
> >   interrupt/gcc-7/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-2=
019-11-14.cgz/lkp-bdw-ep6/stress-ng/30s/0xb000038
> >
> > commit:
> >   fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
> >   0b0695f2b3 ("sched/fair: Rework load_balance()")
> >
> > fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >           1:4          -25%            :4     dmesg.WARNING:at#for_ip_i=
nterrupt_entry/0x
> >          %stddev     %change         %stddev
> >              \          |                \
> >   98245522           +42.3%  1.398e+08        stress-ng.schedpolicy.ops
> >    3274860           +42.3%    4661027        stress-ng.schedpolicy.ops=
_per_sec
> >  3.473e+08            -9.7%  3.137e+08        stress-ng.sigq.ops
> >   11576537            -9.7%   10454846        stress-ng.sigq.ops_per_se=
c
> >   38097605 =C4=85  6%     +10.3%   42011440 =C4=85  4%  stress-ng.sigrt=
.ops
> >    1269646 =C4=85  6%     +10.3%    1400024 =C4=85  4%  stress-ng.sigrt=
.ops_per_sec
> >  3.628e+08 =C4=85  4%     -21.5%  2.848e+08 =C4=85 10%  stress-ng.time.=
involuntary_context_switches
> >       7040            +2.9%       7245        stress-ng.time.percent_of=
_cpu_this_job_got
> >      15.09 =C4=85  3%     -13.4%      13.07 =C4=85  5%  iostat.cpu.idle
> >      14.82 =C4=85  3%      -2.0       12.80 =C4=85  5%  mpstat.cpu.all.=
idle%
> >  3.333e+08 =C4=85 17%     +59.9%  5.331e+08 =C4=85 22%  cpuidle.C1.time
> >    5985148 =C4=85 23%    +112.5%   12719679 =C4=85 20%  cpuidle.C1E.usa=
ge
> >      14.50 =C4=85  3%     -12.1%      12.75 =C4=85  6%  vmstat.cpu.id
> >    1113131 =C4=85  2%     -10.5%     996285 =C4=85  3%  vmstat.system.c=
s
> >       2269            +2.4%       2324        turbostat.Avg_MHz
> >       0.64 =C4=85 17%      +0.4        1.02 =C4=85 23%  turbostat.C1%
> >    5984799 =C4=85 23%    +112.5%   12719086 =C4=85 20%  turbostat.C1E
> >       4.17 =C4=85 32%     -46.0%       2.25 =C4=85 38%  turbostat.Pkg%p=
c2
> >     216.57            +2.1%     221.12        turbostat.PkgWatt
> >      13.33 =C4=85  3%      +3.9%      13.84        turbostat.RAMWatt
> >      99920           +13.6%     113486 =C4=85 15%  proc-vmstat.nr_activ=
e_anon
> >       5738            +1.2%       5806        proc-vmstat.nr_inactive_a=
non
> >      46788            +2.1%      47749        proc-vmstat.nr_slab_unrec=
laimable
> >      99920           +13.6%     113486 =C4=85 15%  proc-vmstat.nr_zone_=
active_anon
> >       5738            +1.2%       5806        proc-vmstat.nr_zone_inact=
ive_anon
> >       3150 =C4=85  2%     +35.4%       4265 =C4=85 33%  proc-vmstat.num=
a_huge_pte_updates
> >    1641223           +34.3%    2203844 =C4=85 32%  proc-vmstat.numa_pte=
_updates
> >      13575 =C4=85 18%     +62.1%      21999 =C4=85  4%  slabinfo.ext4_e=
xtent_status.active_objs
> >      13954 =C4=85 17%     +57.7%      21999 =C4=85  4%  slabinfo.ext4_e=
xtent_status.num_objs
> >       2527 =C4=85  4%      +9.8%       2774 =C4=85  2%  slabinfo.khugep=
aged_mm_slot.active_objs
> >       2527 =C4=85  4%      +9.8%       2774 =C4=85  2%  slabinfo.khugep=
aged_mm_slot.num_objs
> >      57547 =C4=85  8%     -15.3%      48743 =C4=85  9%  slabinfo.kmallo=
c-rcl-64.active_objs
> >     898.75 =C4=85  8%     -15.3%     761.00 =C4=85  9%  slabinfo.kmallo=
c-rcl-64.active_slabs
> >      57547 =C4=85  8%     -15.3%      48743 =C4=85  9%  slabinfo.kmallo=
c-rcl-64.num_objs
> >     898.75 =C4=85  8%     -15.3%     761.00 =C4=85  9%  slabinfo.kmallo=
c-rcl-64.num_slabs
> >  1.014e+10            +1.7%  1.031e+10        perf-stat.i.branch-instru=
ctions
> >      13.37 =C4=85  4%      +2.0       15.33 =C4=85  3%  perf-stat.i.cac=
he-miss-rate%
> >  1.965e+11            +2.6%  2.015e+11        perf-stat.i.cpu-cycles
> >   20057708 =C4=85  4%     +13.9%   22841468 =C4=85  4%  perf-stat.i.iTL=
B-loads
> >  4.973e+10            +1.4%  5.042e+10        perf-stat.i.instructions
> >       3272 =C4=85  2%      +2.9%       3366        perf-stat.i.minor-fa=
ults
> >    4500892 =C4=85  3%     +18.9%    5351518 =C4=85  6%  perf-stat.i.nod=
e-store-misses
> >       3.91            +1.3%       3.96        perf-stat.overall.cpi
> >      69.62            -1.5       68.11        perf-stat.overall.iTLB-lo=
ad-miss-rate%
> >  1.047e+10            +1.3%  1.061e+10        perf-stat.ps.branch-instr=
uctions
> >    1117454 =C4=85  2%     -10.6%     999467 =C4=85  3%  perf-stat.ps.co=
ntext-switches
> >  1.986e+11            +2.4%  2.033e+11        perf-stat.ps.cpu-cycles
> >   19614413 =C4=85  4%     +13.6%   22288555 =C4=85  4%  perf-stat.ps.iT=
LB-loads
> >       3493            -1.1%       3453        perf-stat.ps.minor-faults
> >    4546636 =C4=85  3%     +17.0%    5321658 =C4=85  5%  perf-stat.ps.no=
de-store-misses
> >       0.64 =C4=85  3%      -0.2        0.44 =C4=85 57%  perf-profile.ca=
lltrace.cycles-pp.common_timer_get.do_timer_gettime.__x64_sys_timer_gettime=
.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.66 =C4=85  3%      -0.1        0.58 =C4=85  7%  perf-profile.ch=
ildren.cycles-pp.common_timer_get
> >       0.44 =C4=85  4%      -0.1        0.39 =C4=85  5%  perf-profile.ch=
ildren.cycles-pp.posix_ktime_get_ts
> >       0.39 =C4=85  5%      -0.0        0.34 =C4=85  6%  perf-profile.ch=
ildren.cycles-pp.ktime_get_ts64
> >       0.07 =C4=85 17%      +0.0        0.10 =C4=85  8%  perf-profile.ch=
ildren.cycles-pp.task_tick_fair
> >       0.08 =C4=85 15%      +0.0        0.11 =C4=85  7%  perf-profile.ch=
ildren.cycles-pp.scheduler_tick
> >       0.46 =C4=85  5%      +0.1        0.54 =C4=85  6%  perf-profile.ch=
ildren.cycles-pp.__might_sleep
> >       0.69 =C4=85  8%      +0.2        0.85 =C4=85 12%  perf-profile.ch=
ildren.cycles-pp.___might_sleep
> >       0.90 =C4=85  5%      -0.2        0.73 =C4=85  9%  perf-profile.se=
lf.cycles-pp.__might_fault
> >       0.40 =C4=85  6%      -0.1        0.33 =C4=85  9%  perf-profile.se=
lf.cycles-pp.do_timer_gettime
> >       0.50 =C4=85  4%      -0.1        0.45 =C4=85  7%  perf-profile.se=
lf.cycles-pp.put_itimerspec64
> >       0.32 =C4=85  2%      -0.0        0.27 =C4=85  9%  perf-profile.se=
lf.cycles-pp.update_curr_fair
> >       0.20 =C4=85  6%      -0.0        0.18 =C4=85  2%  perf-profile.se=
lf.cycles-pp.ktime_get_ts64
> >       0.08 =C4=85 23%      +0.0        0.12 =C4=85  8%  perf-profile.se=
lf.cycles-pp._raw_spin_trylock
> >       0.42 =C4=85  5%      +0.1        0.50 =C4=85  6%  perf-profile.se=
lf.cycles-pp.__might_sleep
> >       0.66 =C4=85  9%      +0.2        0.82 =C4=85 12%  perf-profile.se=
lf.cycles-pp.___might_sleep
> >      47297 =C4=85 13%     +19.7%      56608 =C4=85  5%  softirqs.CPU13.=
SCHED
> >      47070 =C4=85  3%     +20.5%      56735 =C4=85  7%  softirqs.CPU2.S=
CHED
> >      55443 =C4=85  9%     -20.2%      44250 =C4=85  2%  softirqs.CPU28.=
SCHED
> >      56633 =C4=85  3%     -12.6%      49520 =C4=85  7%  softirqs.CPU34.=
SCHED
> >      56599 =C4=85 11%     -18.0%      46384 =C4=85  2%  softirqs.CPU36.=
SCHED
> >      56909 =C4=85  9%     -18.4%      46438 =C4=85  6%  softirqs.CPU40.=
SCHED
> >      45062 =C4=85  9%     +28.1%      57709 =C4=85  9%  softirqs.CPU45.=
SCHED
> >      43959           +28.7%      56593 =C4=85  9%  softirqs.CPU49.SCHED
> >      46235 =C4=85 10%     +22.2%      56506 =C4=85 11%  softirqs.CPU5.S=
CHED
> >      44779 =C4=85 12%     +22.5%      54859 =C4=85 11%  softirqs.CPU57.=
SCHED
> >      46739 =C4=85 10%     +21.1%      56579 =C4=85  8%  softirqs.CPU6.S=
CHED
> >      53129 =C4=85  4%     -13.1%      46149 =C4=85  8%  softirqs.CPU70.=
SCHED
> >      55822 =C4=85  7%     -20.5%      44389 =C4=85  8%  softirqs.CPU73.=
SCHED
> >      56011 =C4=85  5%     -11.4%      49610 =C4=85  7%  softirqs.CPU77.=
SCHED
> >      55263 =C4=85  9%     -13.2%      47942 =C4=85 12%  softirqs.CPU78.=
SCHED
> >      58792 =C4=85 14%     -21.3%      46291 =C4=85  9%  softirqs.CPU81.=
SCHED
> >      53341 =C4=85  7%     -13.7%      46041 =C4=85 10%  softirqs.CPU83.=
SCHED
> >      59096 =C4=85 15%     -23.9%      44998 =C4=85  6%  softirqs.CPU85.=
SCHED
> >      36647           -98.5%     543.00 =C4=85 61%  numa-meminfo.node0.A=
ctive(file)
> >     620922 =C4=85  4%     -10.4%     556566 =C4=85  5%  numa-meminfo.no=
de0.FilePages
> >      21243 =C4=85  3%     -36.2%      13543 =C4=85 41%  numa-meminfo.no=
de0.Inactive
> >      20802 =C4=85  3%     -35.3%      13455 =C4=85 42%  numa-meminfo.no=
de0.Inactive(anon)
> >      15374 =C4=85  9%     -27.2%      11193 =C4=85  8%  numa-meminfo.no=
de0.KernelStack
> >      21573           -34.7%      14084 =C4=85 14%  numa-meminfo.node0.M=
apped
> >    1136795 =C4=85  5%     -12.4%     995965 =C4=85  6%  numa-meminfo.no=
de0.MemUsed
> >      16420 =C4=85  6%     -66.0%       5580 =C4=85 18%  numa-meminfo.no=
de0.PageTables
> >     108182 =C4=85  2%     -18.5%      88150 =C4=85  3%  numa-meminfo.no=
de0.SUnreclaim
> >     166467 =C4=85  2%     -15.8%     140184 =C4=85  4%  numa-meminfo.no=
de0.Slab
> >     181705 =C4=85 36%     +63.8%     297623 =C4=85 10%  numa-meminfo.no=
de1.Active
> >     320.75 =C4=85 27%  +11187.0%      36203        numa-meminfo.node1.A=
ctive(file)
> >       2208 =C4=85 38%    +362.1%      10207 =C4=85 54%  numa-meminfo.no=
de1.Inactive
> >       2150 =C4=85 39%    +356.0%       9804 =C4=85 58%  numa-meminfo.no=
de1.Inactive(anon)
> >      41819 =C4=85 10%     +17.3%      49068 =C4=85  6%  numa-meminfo.no=
de1.KReclaimable
> >      11711 =C4=85  5%     +47.2%      17238 =C4=85 22%  numa-meminfo.no=
de1.KernelStack
> >      10642           +68.3%      17911 =C4=85 11%  numa-meminfo.node1.M=
apped
> >     952520 =C4=85  6%     +20.3%    1146337 =C4=85  3%  numa-meminfo.no=
de1.MemUsed
> >      12342 =C4=85 15%     +92.4%      23741 =C4=85  9%  numa-meminfo.no=
de1.PageTables
> >      41819 =C4=85 10%     +17.3%      49068 =C4=85  6%  numa-meminfo.no=
de1.SReclaimable
> >      80394 =C4=85  3%     +27.1%     102206 =C4=85  3%  numa-meminfo.no=
de1.SUnreclaim
> >     122214 =C4=85  3%     +23.8%     151275 =C4=85  3%  numa-meminfo.no=
de1.Slab
> >       9160           -98.5%     135.25 =C4=85 61%  numa-vmstat.node0.nr=
_active_file
> >     155223 =C4=85  4%     -10.4%     139122 =C4=85  5%  numa-vmstat.nod=
e0.nr_file_pages
> >       5202 =C4=85  3%     -35.4%       3362 =C4=85 42%  numa-vmstat.nod=
e0.nr_inactive_anon
> >     109.50 =C4=85 14%     -80.1%      21.75 =C4=85160%  numa-vmstat.nod=
e0.nr_inactive_file
> >      14757 =C4=85  3%     -34.4%       9676 =C4=85 12%  numa-vmstat.nod=
e0.nr_kernel_stack
> >       5455           -34.9%       3549 =C4=85 12%  numa-vmstat.node0.nr=
_mapped
> >       4069 =C4=85  6%     -68.3%       1289 =C4=85 24%  numa-vmstat.nod=
e0.nr_page_table_pages
> >      26943 =C4=85  2%     -19.2%      21761 =C4=85  3%  numa-vmstat.nod=
e0.nr_slab_unreclaimable
> >       2240 =C4=85  6%     -97.8%      49.00 =C4=85 69%  numa-vmstat.nod=
e0.nr_written
> >       9160           -98.5%     135.25 =C4=85 61%  numa-vmstat.node0.nr=
_zone_active_file
> >       5202 =C4=85  3%     -35.4%       3362 =C4=85 42%  numa-vmstat.nod=
e0.nr_zone_inactive_anon
> >     109.50 =C4=85 14%     -80.1%      21.75 =C4=85160%  numa-vmstat.nod=
e0.nr_zone_inactive_file
> >      79.75 =C4=85 28%  +11247.0%       9049        numa-vmstat.node1.nr=
_active_file
> >     542.25 =C4=85 41%    +352.1%       2451 =C4=85 58%  numa-vmstat.nod=
e1.nr_inactive_anon
> >      14.00 =C4=85140%    +617.9%     100.50 =C4=85 35%  numa-vmstat.nod=
e1.nr_inactive_file
> >      11182 =C4=85  4%     +28.9%      14415 =C4=85  4%  numa-vmstat.nod=
e1.nr_kernel_stack
> >       2728 =C4=85  3%     +67.7%       4576 =C4=85  9%  numa-vmstat.nod=
e1.nr_mapped
> >       3056 =C4=85 15%     +88.2%       5754 =C4=85  8%  numa-vmstat.nod=
e1.nr_page_table_pages
> >      10454 =C4=85 10%     +17.3%      12262 =C4=85  7%  numa-vmstat.nod=
e1.nr_slab_reclaimable
> >      20006 =C4=85  3%     +25.0%      25016 =C4=85  3%  numa-vmstat.nod=
e1.nr_slab_unreclaimable
> >      19.00 =C4=85 52%  +11859.2%       2272 =C4=85  2%  numa-vmstat.nod=
e1.nr_written
> >      79.75 =C4=85 28%  +11247.0%       9049        numa-vmstat.node1.nr=
_zone_active_file
> >     542.25 =C4=85 41%    +352.1%       2451 =C4=85 58%  numa-vmstat.nod=
e1.nr_zone_inactive_anon
> >      14.00 =C4=85140%    +617.9%     100.50 =C4=85 35%  numa-vmstat.nod=
e1.nr_zone_inactive_file
> >     173580 =C4=85 21%    +349.5%     780280 =C4=85  7%  sched_debug.cfs=
_rq:/.MIN_vruntime.avg
> >    6891819 =C4=85 37%    +109.1%   14412817 =C4=85  9%  sched_debug.cfs=
_rq:/.MIN_vruntime.max
> >    1031500 =C4=85 25%    +189.1%    2982452 =C4=85  8%  sched_debug.cfs=
_rq:/.MIN_vruntime.stddev
> >     149079           +13.6%     169354 =C4=85  2%  sched_debug.cfs_rq:/=
.exec_clock.min
> >       8550 =C4=85  3%     -59.7%       3442 =C4=85 32%  sched_debug.cfs=
_rq:/.exec_clock.stddev
> >       4.95 =C4=85  6%     -15.2%       4.20 =C4=85 10%  sched_debug.cfs=
_rq:/.load_avg.min
> >     173580 =C4=85 21%    +349.5%     780280 =C4=85  7%  sched_debug.cfs=
_rq:/.max_vruntime.avg
> >    6891819 =C4=85 37%    +109.1%   14412817 =C4=85  9%  sched_debug.cfs=
_rq:/.max_vruntime.max
> >    1031500 =C4=85 25%    +189.1%    2982452 =C4=85  8%  sched_debug.cfs=
_rq:/.max_vruntime.stddev
> >   16144141           +27.9%   20645199 =C4=85  6%  sched_debug.cfs_rq:/=
.min_vruntime.avg
> >   17660392           +27.7%   22546402 =C4=85  4%  sched_debug.cfs_rq:/=
.min_vruntime.max
> >   13747718           +36.8%   18802595 =C4=85  5%  sched_debug.cfs_rq:/=
.min_vruntime.min
> >       0.17 =C4=85 11%     +35.0%       0.22 =C4=85 15%  sched_debug.cfs=
_rq:/.nr_running.stddev
> >      10.64 =C4=85 14%     -26.4%       7.83 =C4=85 12%  sched_debug.cpu=
.clock.stddev
> >      10.64 =C4=85 14%     -26.4%       7.83 =C4=85 12%  sched_debug.cpu=
.clock_task.stddev
> >       7093 =C4=85 42%     -65.9%       2420 =C4=85120%  sched_debug.cpu=
.curr->pid.min
> >    2434979 =C4=85  2%     -18.6%    1981697 =C4=85  3%  sched_debug.cpu=
.nr_switches.avg
> >    3993189 =C4=85  6%     -22.2%    3104832 =C4=85  5%  sched_debug.cpu=
.nr_switches.max
> >    -145.03           -42.8%     -82.90        sched_debug.cpu.nr_uninte=
rruptible.min
> >    2097122 =C4=85  6%     +38.7%    2908923 =C4=85  6%  sched_debug.cpu=
.sched_count.min
> >     809684 =C4=85 13%     -30.5%     562929 =C4=85 17%  sched_debug.cpu=
.sched_count.stddev
> >     307565 =C4=85  4%     -15.1%     261231 =C4=85  3%  sched_debug.cpu=
.ttwu_count.min
> >     207286 =C4=85  6%     -16.4%     173387 =C4=85  3%  sched_debug.cpu=
.ttwu_local.min
> >     125963 =C4=85 23%     +53.1%     192849 =C4=85  2%  sched_debug.cpu=
.ttwu_local.stddev
> >    2527246           +10.8%    2800959 =C4=85  3%  sched_debug.cpu.yld_=
count.avg
> >    1294266 =C4=85  4%     +53.7%    1989264 =C4=85  2%  sched_debug.cpu=
.yld_count.min
> >     621332 =C4=85  9%     -38.4%     382813 =C4=85 22%  sched_debug.cpu=
.yld_count.stddev
> >     899.50 =C4=85 28%     -48.2%     465.75 =C4=85 42%  interrupts.37:I=
R-PCI-MSI.1572868-edge.eth0-TxRx-3
> >     372.50 =C4=85  7%    +169.5%       1004 =C4=85 40%  interrupts.40:I=
R-PCI-MSI.1572871-edge.eth0-TxRx-6
> >       6201 =C4=85  8%     +17.9%       7309 =C4=85  3%  interrupts.CPU0=
.CAL:Function_call_interrupts
> >     653368 =C4=85 47%    +159.4%    1695029 =C4=85 17%  interrupts.CPU0=
.RES:Rescheduling_interrupts
> >       7104 =C4=85  7%     +13.6%       8067        interrupts.CPU1.CAL:=
Function_call_interrupts
> >       2094 =C4=85 59%     +89.1%       3962 =C4=85 10%  interrupts.CPU1=
0.TLB:TLB_shootdowns
> >       7309 =C4=85  8%     +11.2%       8125        interrupts.CPU11.CAL=
:Function_call_interrupts
> >       2089 =C4=85 62%     +86.2%       3890 =C4=85 11%  interrupts.CPU1=
3.TLB:TLB_shootdowns
> >       7068 =C4=85  8%     +15.2%       8144 =C4=85  2%  interrupts.CPU1=
4.CAL:Function_call_interrupts
> >       7112 =C4=85  7%     +13.6%       8079 =C4=85  3%  interrupts.CPU1=
5.CAL:Function_call_interrupts
> >       1950 =C4=85 61%    +103.5%       3968 =C4=85 11%  interrupts.CPU1=
5.TLB:TLB_shootdowns
> >     899.50 =C4=85 28%     -48.2%     465.75 =C4=85 42%  interrupts.CPU1=
6.37:IR-PCI-MSI.1572868-edge.eth0-TxRx-3
> >       2252 =C4=85 47%     +62.6%       3664 =C4=85 15%  interrupts.CPU1=
6.TLB:TLB_shootdowns
> >       7111 =C4=85  8%     +14.8%       8167 =C4=85  3%  interrupts.CPU1=
8.CAL:Function_call_interrupts
> >       1972 =C4=85 60%     +96.3%       3872 =C4=85  9%  interrupts.CPU1=
8.TLB:TLB_shootdowns
> >     372.50 =C4=85  7%    +169.5%       1004 =C4=85 40%  interrupts.CPU1=
9.40:IR-PCI-MSI.1572871-edge.eth0-TxRx-6
> >       2942 =C4=85 12%     -57.5%       1251 =C4=85 22%  interrupts.CPU2=
2.TLB:TLB_shootdowns
> >       7819           -12.2%       6861 =C4=85  3%  interrupts.CPU23.CAL=
:Function_call_interrupts
> >       3327 =C4=85 12%     -62.7%       1241 =C4=85 29%  interrupts.CPU2=
3.TLB:TLB_shootdowns
> >       7767 =C4=85  3%     -14.0%       6683 =C4=85  5%  interrupts.CPU2=
4.CAL:Function_call_interrupts
> >       3185 =C4=85 21%     -63.8%       1154 =C4=85 14%  interrupts.CPU2=
4.TLB:TLB_shootdowns
> >       7679 =C4=85  4%     -11.3%       6812 =C4=85  2%  interrupts.CPU2=
5.CAL:Function_call_interrupts
> >       3004 =C4=85 28%     -63.4%       1100 =C4=85  7%  interrupts.CPU2=
5.TLB:TLB_shootdowns
> >       3187 =C4=85 17%     -61.3%       1232 =C4=85 35%  interrupts.CPU2=
6.TLB:TLB_shootdowns
> >       3193 =C4=85 16%     -59.3%       1299 =C4=85 34%  interrupts.CPU2=
7.TLB:TLB_shootdowns
> >       3059 =C4=85 21%     -58.0%       1285 =C4=85 32%  interrupts.CPU2=
8.TLB:TLB_shootdowns
> >       7798 =C4=85  4%     -13.8%       6719 =C4=85  7%  interrupts.CPU2=
9.CAL:Function_call_interrupts
> >       3122 =C4=85 20%     -62.3%       1178 =C4=85 37%  interrupts.CPU2=
9.TLB:TLB_shootdowns
> >       7727 =C4=85  2%     -11.6%       6827 =C4=85  5%  interrupts.CPU3=
0.CAL:Function_call_interrupts
> >       3102 =C4=85 18%     -59.4%       1259 =C4=85 33%  interrupts.CPU3=
0.TLB:TLB_shootdowns
> >       3269 =C4=85 24%     -58.1%       1371 =C4=85 48%  interrupts.CPU3=
1.TLB:TLB_shootdowns
> >       7918 =C4=85  3%     -14.5%       6771        interrupts.CPU32.CAL=
:Function_call_interrupts
> >       3324 =C4=85 18%     -70.7%     973.50 =C4=85 18%  interrupts.CPU3=
2.TLB:TLB_shootdowns
> >       2817 =C4=85 27%     -60.2%       1121 =C4=85 26%  interrupts.CPU3=
3.TLB:TLB_shootdowns
> >       7956 =C4=85  3%     -11.8%       7018 =C4=85  4%  interrupts.CPU3=
4.CAL:Function_call_interrupts
> >       3426 =C4=85 21%     -70.3%       1018 =C4=85 29%  interrupts.CPU3=
4.TLB:TLB_shootdowns
> >       3121 =C4=85 17%     -70.3%     926.75 =C4=85 22%  interrupts.CPU3=
5.TLB:TLB_shootdowns
> >       7596 =C4=85  4%     -10.6%       6793 =C4=85  3%  interrupts.CPU3=
6.CAL:Function_call_interrupts
> >       2900 =C4=85 30%     -62.3%       1094 =C4=85 34%  interrupts.CPU3=
6.TLB:TLB_shootdowns
> >       7863           -13.1%       6833 =C4=85  2%  interrupts.CPU37.CAL=
:Function_call_interrupts
> >       3259 =C4=85 15%     -65.9%       1111 =C4=85 20%  interrupts.CPU3=
7.TLB:TLB_shootdowns
> >       3230 =C4=85 26%     -64.0%       1163 =C4=85 39%  interrupts.CPU3=
8.TLB:TLB_shootdowns
> >       7728 =C4=85  5%     -13.8%       6662 =C4=85  7%  interrupts.CPU3=
9.CAL:Function_call_interrupts
> >       2950 =C4=85 29%     -61.6%       1133 =C4=85 26%  interrupts.CPU3=
9.TLB:TLB_shootdowns
> >       6864 =C4=85  3%     +18.7%       8147        interrupts.CPU4.CAL:=
Function_call_interrupts
> >       1847 =C4=85 59%    +118.7%       4039 =C4=85  7%  interrupts.CPU4=
.TLB:TLB_shootdowns
> >       7951 =C4=85  6%     -15.0%       6760 =C4=85  2%  interrupts.CPU4=
0.CAL:Function_call_interrupts
> >       3200 =C4=85 30%     -72.3%     886.50 =C4=85 39%  interrupts.CPU4=
0.TLB:TLB_shootdowns
> >       7819 =C4=85  6%     -11.3%       6933 =C4=85  2%  interrupts.CPU4=
1.CAL:Function_call_interrupts
> >       3149 =C4=85 28%     -62.9%       1169 =C4=85 24%  interrupts.CPU4=
1.TLB:TLB_shootdowns
> >       7884 =C4=85  4%     -11.0%       7019 =C4=85  2%  interrupts.CPU4=
2.CAL:Function_call_interrupts
> >       3248 =C4=85 16%     -63.4%       1190 =C4=85 23%  interrupts.CPU4=
2.TLB:TLB_shootdowns
> >       7659 =C4=85  5%     -12.7%       6690 =C4=85  3%  interrupts.CPU4=
3.CAL:Function_call_interrupts
> >     490732 =C4=85 20%    +114.5%    1052606 =C4=85 47%  interrupts.CPU4=
3.RES:Rescheduling_interrupts
> >    1432688 =C4=85 34%     -67.4%     467217 =C4=85 43%  interrupts.CPU4=
7.RES:Rescheduling_interrupts
> >       7122 =C4=85  8%     +16.0%       8259 =C4=85  3%  interrupts.CPU4=
8.CAL:Function_call_interrupts
> >       1868 =C4=85 65%    +118.4%       4079 =C4=85  8%  interrupts.CPU4=
8.TLB:TLB_shootdowns
> >       7165 =C4=85  8%     +11.3%       7977 =C4=85  5%  interrupts.CPU4=
9.CAL:Function_call_interrupts
> >       1961 =C4=85 59%     +98.4%       3891 =C4=85  4%  interrupts.CPU4=
9.TLB:TLB_shootdowns
> >     461807 =C4=85 47%    +190.8%    1342990 =C4=85 48%  interrupts.CPU5=
.RES:Rescheduling_interrupts
> >       7167 =C4=85  7%     +15.4%       8273        interrupts.CPU50.CAL=
:Function_call_interrupts
> >       2027 =C4=85 51%    +103.9%       4134 =C4=85  8%  interrupts.CPU5=
0.TLB:TLB_shootdowns
> >       7163 =C4=85  9%     +16.3%       8328        interrupts.CPU51.CAL=
:Function_call_interrupts
> >     660073 =C4=85 33%     +74.0%    1148640 =C4=85 25%  interrupts.CPU5=
1.RES:Rescheduling_interrupts
> >       2043 =C4=85 64%     +95.8%       4000 =C4=85  5%  interrupts.CPU5=
1.TLB:TLB_shootdowns
> >       7428 =C4=85  9%     +13.5%       8434 =C4=85  2%  interrupts.CPU5=
2.CAL:Function_call_interrupts
> >       2280 =C4=85 61%     +85.8%       4236 =C4=85  9%  interrupts.CPU5=
2.TLB:TLB_shootdowns
> >       7144 =C4=85 11%     +17.8%       8413        interrupts.CPU53.CAL=
:Function_call_interrupts
> >       1967 =C4=85 67%    +104.7%       4026 =C4=85  5%  interrupts.CPU5=
3.TLB:TLB_shootdowns
> >       7264 =C4=85 10%     +15.6%       8394 =C4=85  4%  interrupts.CPU5=
4.CAL:Function_call_interrupts
> >       7045 =C4=85 11%     +18.7%       8365 =C4=85  2%  interrupts.CPU5=
6.CAL:Function_call_interrupts
> >       2109 =C4=85 59%     +91.6%       4041 =C4=85 10%  interrupts.CPU5=
6.TLB:TLB_shootdowns
> >       7307 =C4=85  9%     +15.3%       8428 =C4=85  2%  interrupts.CPU5=
7.CAL:Function_call_interrupts
> >       2078 =C4=85 64%     +96.5%       4085 =C4=85  6%  interrupts.CPU5=
7.TLB:TLB_shootdowns
> >       6834 =C4=85 12%     +19.8%       8190 =C4=85  3%  interrupts.CPU5=
8.CAL:Function_call_interrupts
> >     612496 =C4=85 85%    +122.5%    1362815 =C4=85 27%  interrupts.CPU5=
8.RES:Rescheduling_interrupts
> >       1884 =C4=85 69%    +112.0%       3995 =C4=85  8%  interrupts.CPU5=
8.TLB:TLB_shootdowns
> >       7185 =C4=85  8%     +15.9%       8329        interrupts.CPU59.CAL=
:Function_call_interrupts
> >       1982 =C4=85 58%    +101.1%       3986 =C4=85  5%  interrupts.CPU5=
9.TLB:TLB_shootdowns
> >       7051 =C4=85  6%     +13.1%       7975        interrupts.CPU6.CAL:=
Function_call_interrupts
> >       1831 =C4=85 49%    +102.1%       3701 =C4=85  8%  interrupts.CPU6=
.TLB:TLB_shootdowns
> >       7356 =C4=85  8%     +16.2%       8548        interrupts.CPU60.CAL=
:Function_call_interrupts
> >       2124 =C4=85 57%     +92.8%       4096 =C4=85  5%  interrupts.CPU6=
0.TLB:TLB_shootdowns
> >       7243 =C4=85  9%     +15.1%       8334        interrupts.CPU61.CAL=
:Function_call_interrupts
> >     572423 =C4=85 71%    +110.0%    1201919 =C4=85 40%  interrupts.CPU6=
1.RES:Rescheduling_interrupts
> >       7295 =C4=85  9%     +14.7%       8369        interrupts.CPU63.CAL=
:Function_call_interrupts
> >       2139 =C4=85 57%     +85.7%       3971 =C4=85  3%  interrupts.CPU6=
3.TLB:TLB_shootdowns
> >       7964 =C4=85  2%     -15.6%       6726 =C4=85  5%  interrupts.CPU6=
6.CAL:Function_call_interrupts
> >       3198 =C4=85 21%     -65.0%       1119 =C4=85 24%  interrupts.CPU6=
6.TLB:TLB_shootdowns
> >       8103 =C4=85  2%     -17.5%       6687 =C4=85  9%  interrupts.CPU6=
7.CAL:Function_call_interrupts
> >       3357 =C4=85 18%     -62.9%       1244 =C4=85 32%  interrupts.CPU6=
7.TLB:TLB_shootdowns
> >       7772 =C4=85  2%     -14.0%       6687 =C4=85  8%  interrupts.CPU6=
8.CAL:Function_call_interrupts
> >       2983 =C4=85 17%     -59.2%       1217 =C4=85 15%  interrupts.CPU6=
8.TLB:TLB_shootdowns
> >       7986 =C4=85  4%     -13.8%       6887 =C4=85  4%  interrupts.CPU6=
9.CAL:Function_call_interrupts
> >       3192 =C4=85 24%     -65.0%       1117 =C4=85 30%  interrupts.CPU6=
9.TLB:TLB_shootdowns
> >       7070 =C4=85  6%     +14.6%       8100 =C4=85  2%  interrupts.CPU7=
.CAL:Function_call_interrupts
> >     697891 =C4=85 32%     +54.4%    1077890 =C4=85 18%  interrupts.CPU7=
.RES:Rescheduling_interrupts
> >       1998 =C4=85 55%     +97.1%       3938 =C4=85 10%  interrupts.CPU7=
.TLB:TLB_shootdowns
> >       8085           -13.4%       7002 =C4=85  3%  interrupts.CPU70.CAL=
:Function_call_interrupts
> >    1064985 =C4=85 35%     -62.5%     398986 =C4=85 29%  interrupts.CPU7=
0.RES:Rescheduling_interrupts
> >       3347 =C4=85 12%     -61.7%       1280 =C4=85 24%  interrupts.CPU7=
0.TLB:TLB_shootdowns
> >       2916 =C4=85 16%     -58.8%       1201 =C4=85 39%  interrupts.CPU7=
1.TLB:TLB_shootdowns
> >       3314 =C4=85 19%     -61.3%       1281 =C4=85 26%  interrupts.CPU7=
2.TLB:TLB_shootdowns
> >       3119 =C4=85 18%     -61.5%       1200 =C4=85 39%  interrupts.CPU7=
3.TLB:TLB_shootdowns
> >       7992 =C4=85  4%     -12.6%       6984 =C4=85  3%  interrupts.CPU7=
4.CAL:Function_call_interrupts
> >       3187 =C4=85 21%     -56.8%       1378 =C4=85 40%  interrupts.CPU7=
4.TLB:TLB_shootdowns
> >       7953 =C4=85  4%     -12.0%       6999 =C4=85  4%  interrupts.CPU7=
5.CAL:Function_call_interrupts
> >       3072 =C4=85 26%     -56.8%       1327 =C4=85 34%  interrupts.CPU7=
5.TLB:TLB_shootdowns
> >       8119 =C4=85  5%     -12.4%       7109 =C4=85  7%  interrupts.CPU7=
6.CAL:Function_call_interrupts
> >       3418 =C4=85 20%     -67.5%       1111 =C4=85 31%  interrupts.CPU7=
6.TLB:TLB_shootdowns
> >       7804 =C4=85  5%     -11.4%       6916 =C4=85  4%  interrupts.CPU7=
7.CAL:Function_call_interrupts
> >       7976 =C4=85  5%     -14.4%       6826 =C4=85  3%  interrupts.CPU7=
8.CAL:Function_call_interrupts
> >       3209 =C4=85 27%     -71.8%     904.75 =C4=85 28%  interrupts.CPU7=
8.TLB:TLB_shootdowns
> >       8187 =C4=85  4%     -14.6%       6991 =C4=85  3%  interrupts.CPU7=
9.CAL:Function_call_interrupts
> >       3458 =C4=85 20%     -67.5%       1125 =C4=85 36%  interrupts.CPU7=
9.TLB:TLB_shootdowns
> >       7122 =C4=85  7%     +14.2%       8136 =C4=85  2%  interrupts.CPU8=
.CAL:Function_call_interrupts
> >       2096 =C4=85 63%     +87.4%       3928 =C4=85  8%  interrupts.CPU8=
.TLB:TLB_shootdowns
> >       8130 =C4=85  5%     -17.2%       6728 =C4=85  5%  interrupts.CPU8=
1.CAL:Function_call_interrupts
> >       3253 =C4=85 24%     -70.6%     955.00 =C4=85 38%  interrupts.CPU8=
1.TLB:TLB_shootdowns
> >       7940 =C4=85  5%     -13.9%       6839 =C4=85  5%  interrupts.CPU8=
2.CAL:Function_call_interrupts
> >       2952 =C4=85 26%     -66.3%     996.00 =C4=85 51%  interrupts.CPU8=
2.TLB:TLB_shootdowns
> >       7900 =C4=85  6%     -13.4%       6844 =C4=85  3%  interrupts.CPU8=
3.CAL:Function_call_interrupts
> >       3012 =C4=85 34%     -68.3%     956.00 =C4=85 17%  interrupts.CPU8=
3.TLB:TLB_shootdowns
> >       7952 =C4=85  6%     -15.8%       6695 =C4=85  2%  interrupts.CPU8=
4.CAL:Function_call_interrupts
> >       3049 =C4=85 31%     -75.5%     746.50 =C4=85 27%  interrupts.CPU8=
4.TLB:TLB_shootdowns
> >       8065 =C4=85  6%     -15.7%       6798        interrupts.CPU85.CAL=
:Function_call_interrupts
> >       3222 =C4=85 23%     -69.7%     976.00 =C4=85 13%  interrupts.CPU8=
5.TLB:TLB_shootdowns
> >       8049 =C4=85  5%     -13.2%       6983 =C4=85  4%  interrupts.CPU8=
6.CAL:Function_call_interrupts
> >       3159 =C4=85 19%     -61.9%       1202 =C4=85 27%  interrupts.CPU8=
6.TLB:TLB_shootdowns
> >       8154 =C4=85  8%     -16.9%       6773 =C4=85  3%  interrupts.CPU8=
7.CAL:Function_call_interrupts
> >    1432962 =C4=85 21%     -48.5%     737989 =C4=85 30%  interrupts.CPU8=
7.RES:Rescheduling_interrupts
> >       3186 =C4=85 33%     -72.3%     881.75 =C4=85 21%  interrupts.CPU8=
7.TLB:TLB_shootdowns
> >
> >
> >
> > ***********************************************************************=
****************************
> > lkp-bdw-ep6: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with =
128G memory
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_gro=
up/testcase/testtime/ucode:
> >   interrupt/gcc-7/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-2=
019-11-14.cgz/lkp-bdw-ep6/stress-ng/1s/0xb000038
> >
> > commit:
> >   fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
> >   0b0695f2b3 ("sched/fair: Rework load_balance()")
> >
> > fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >    3345449           +35.1%    4518187 =C4=85  5%  stress-ng.schedpolic=
y.ops
> >    3347036           +35.1%    4520740 =C4=85  5%  stress-ng.schedpolic=
y.ops_per_sec
> >   11464910 =C4=85  6%     -23.3%    8796455 =C4=85 11%  stress-ng.sigq.=
ops
> >   11452565 =C4=85  6%     -23.3%    8786844 =C4=85 11%  stress-ng.sigq.=
ops_per_sec
> >     228736           +20.7%     276087 =C4=85 20%  stress-ng.sleep.ops
> >     157479           +23.0%     193722 =C4=85 21%  stress-ng.sleep.ops_=
per_sec
> >   14584704            -5.8%   13744640 =C4=85  4%  stress-ng.timerfd.op=
s
> >   14546032            -5.7%   13718862 =C4=85  4%  stress-ng.timerfd.op=
s_per_sec
> >      27.24 =C4=85105%    +283.9%     104.58 =C4=85109%  iostat.sdb.r_aw=
ait.max
> >     122324 =C4=85 35%     +63.9%     200505 =C4=85 21%  meminfo.AnonHug=
ePages
> >      47267 =C4=85 26%    +155.2%     120638 =C4=85 45%  numa-meminfo.no=
de1.AnonHugePages
> >      22880 =C4=85  6%      -9.9%      20605 =C4=85  3%  softirqs.CPU57.=
TIMER
> >     636196 =C4=85 24%     +38.5%     880847 =C4=85  7%  cpuidle.C1.usag=
e
> >   55936214 =C4=85 20%     +63.9%   91684673 =C4=85 18%  cpuidle.C1E.tim=
e
> >  1.175e+08 =C4=85 22%    +101.8%  2.372e+08 =C4=85 29%  cpuidle.C3.time
> >  4.242e+08 =C4=85  6%     -39.1%  2.584e+08 =C4=85 39%  cpuidle.C6.time
> >      59.50 =C4=85 34%     +66.0%      98.75 =C4=85 22%  proc-vmstat.nr_=
anon_transparent_hugepages
> >      25612 =C4=85 10%     +13.8%      29146 =C4=85  4%  proc-vmstat.nr_=
kernel_stack
> >    2783465 =C4=85  9%     +14.5%    3187157 =C4=85  9%  proc-vmstat.pga=
lloc_normal
> >       1743 =C4=85 28%     +43.8%       2507 =C4=85 23%  proc-vmstat.thp=
_deferred_split_page
> >       1765 =C4=85 30%     +43.2%       2529 =C4=85 22%  proc-vmstat.thp=
_fault_alloc
> >     811.00 =C4=85  3%     -13.8%     699.00 =C4=85  7%  slabinfo.kmem_c=
ache_node.active_objs
> >     864.00 =C4=85  3%     -13.0%     752.00 =C4=85  7%  slabinfo.kmem_c=
ache_node.num_objs
> >       8686 =C4=85  7%     +13.6%       9869 =C4=85  3%  slabinfo.pid.ac=
tive_objs
> >       8690 =C4=85  7%     +13.8%       9890 =C4=85  3%  slabinfo.pid.nu=
m_objs
> >       9813 =C4=85  6%     +15.7%      11352 =C4=85  3%  slabinfo.task_d=
elay_info.active_objs
> >       9813 =C4=85  6%     +15.7%      11352 =C4=85  3%  slabinfo.task_d=
elay_info.num_objs
> >      79.22 =C4=85 10%     -41.1%      46.68 =C4=85 22%  sched_debug.cfs=
_rq:/.load_avg.avg
> >     242.49 =C4=85  6%     -29.6%     170.70 =C4=85 17%  sched_debug.cfs=
_rq:/.load_avg.stddev
> >      43.14 =C4=85 29%     -67.1%      14.18 =C4=85 66%  sched_debug.cfs=
_rq:/.removed.load_avg.avg
> >     201.73 =C4=85 15%     -50.1%     100.68 =C4=85 60%  sched_debug.cfs=
_rq:/.removed.load_avg.stddev
> >       1987 =C4=85 28%     -67.3%     650.09 =C4=85 66%  sched_debug.cfs=
_rq:/.removed.runnable_sum.avg
> >       9298 =C4=85 15%     -50.3%       4616 =C4=85 60%  sched_debug.cfs=
_rq:/.removed.runnable_sum.stddev
> >      18.17 =C4=85 27%     -68.6%       5.70 =C4=85 63%  sched_debug.cfs=
_rq:/.removed.util_avg.avg
> >      87.61 =C4=85 13%     -52.6%      41.48 =C4=85 59%  sched_debug.cfs=
_rq:/.removed.util_avg.stddev
> >     633327 =C4=85 24%     +38.4%     876596 =C4=85  7%  turbostat.C1
> >       2.75 =C4=85 22%      +1.8        4.52 =C4=85 17%  turbostat.C1E%
> >       5.76 =C4=85 22%      +6.1       11.82 =C4=85 30%  turbostat.C3%
> >      20.69 =C4=85  5%      -8.1       12.63 =C4=85 38%  turbostat.C6%
> >      15.62 =C4=85  6%     +18.4%      18.50 =C4=85  8%  turbostat.CPU%c=
1
> >       1.56 =C4=85 16%    +208.5%       4.82 =C4=85 38%  turbostat.CPU%c=
3
> >      12.81 =C4=85  4%     -48.1%       6.65 =C4=85 43%  turbostat.CPU%c=
6
> >       5.02 =C4=85  8%     -34.6%       3.28 =C4=85 14%  turbostat.Pkg%p=
c2
> >       0.85 =C4=85 57%     -84.7%       0.13 =C4=85173%  turbostat.Pkg%p=
c6
> >      88.25 =C4=85 13%    +262.6%     320.00 =C4=85 71%  interrupts.CPU1=
0.TLB:TLB_shootdowns
> >     116.25 =C4=85 36%    +151.6%     292.50 =C4=85 68%  interrupts.CPU1=
9.TLB:TLB_shootdowns
> >     109.25 =C4=85  8%    +217.4%     346.75 =C4=85106%  interrupts.CPU2=
.TLB:TLB_shootdowns
> >      15180 =C4=85111%    +303.9%      61314 =C4=85 32%  interrupts.CPU2=
3.RES:Rescheduling_interrupts
> >     111.50 =C4=85 26%    +210.3%     346.00 =C4=85 79%  interrupts.CPU3=
.TLB:TLB_shootdowns
> >      86.50 =C4=85 35%    +413.0%     443.75 =C4=85 66%  interrupts.CPU3=
3.TLB:TLB_shootdowns
> >     728.00 =C4=85  8%     +29.6%     943.50 =C4=85 16%  interrupts.CPU3=
8.CAL:Function_call_interrupts
> >       1070 =C4=85 72%     +84.9%       1979 =C4=85  9%  interrupts.CPU5=
4.76:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
> >      41429 =C4=85 64%     -73.7%      10882 =C4=85 73%  interrupts.CPU5=
9.RES:Rescheduling_interrupts
> >      26330 =C4=85 85%     -73.3%       7022 =C4=85 86%  interrupts.CPU6=
2.RES:Rescheduling_interrupts
> >     103.00 =C4=85 22%    +181.3%     289.75 =C4=85 92%  interrupts.CPU6=
5.TLB:TLB_shootdowns
> >     100.00 =C4=85 40%    +365.0%     465.00 =C4=85 71%  interrupts.CPU7=
0.TLB:TLB_shootdowns
> >     110.25 =C4=85 18%    +308.4%     450.25 =C4=85 71%  interrupts.CPU8=
0.TLB:TLB_shootdowns
> >      93.50 =C4=85 42%    +355.1%     425.50 =C4=85 82%  interrupts.CPU8=
4.TLB:TLB_shootdowns
> >     104.50 =C4=85 18%    +289.7%     407.25 =C4=85 68%  interrupts.CPU8=
7.TLB:TLB_shootdowns
> >       1.76 =C4=85  3%      -0.1        1.66 =C4=85  4%  perf-stat.i.bra=
nch-miss-rate%
> >       8.08 =C4=85  6%      +2.0       10.04        perf-stat.i.cache-mi=
ss-rate%
> >   18031213 =C4=85  4%     +27.2%   22939937 =C4=85  3%  perf-stat.i.cac=
he-misses
> >  4.041e+08            -1.9%  3.965e+08        perf-stat.i.cache-referen=
ces
> >      31764 =C4=85 26%     -40.6%      18859 =C4=85 10%  perf-stat.i.cyc=
les-between-cache-misses
> >      66.18            -1.5       64.71        perf-stat.i.iTLB-load-mis=
s-rate%
> >    4503482 =C4=85  8%     +19.5%    5382698 =C4=85  5%  perf-stat.i.nod=
e-load-misses
> >    3892859 =C4=85  2%     +16.6%    4538750 =C4=85  4%  perf-stat.i.nod=
e-store-misses
> >    1526815 =C4=85 13%     +25.8%    1921178 =C4=85  9%  perf-stat.i.nod=
e-stores
> >       4.72 =C4=85  4%      +1.3        6.00 =C4=85  3%  perf-stat.overa=
ll.cache-miss-rate%
> >       9120 =C4=85  6%     -18.9%       7394 =C4=85  2%  perf-stat.overa=
ll.cycles-between-cache-misses
> >   18237318 =C4=85  4%     +25.4%   22866104 =C4=85  3%  perf-stat.ps.ca=
che-misses
> >    4392089 =C4=85  8%     +18.1%    5189251 =C4=85  5%  perf-stat.ps.no=
de-load-misses
> >    1629766 =C4=85  2%     +17.9%    1920947 =C4=85 13%  perf-stat.ps.no=
de-loads
> >    3694566 =C4=85  2%     +16.1%    4288126 =C4=85  4%  perf-stat.ps.no=
de-store-misses
> >    1536866 =C4=85 12%     +23.7%    1901141 =C4=85  7%  perf-stat.ps.no=
de-stores
> >      38.20 =C4=85 18%     -13.2       24.96 =C4=85 10%  perf-profile.ca=
lltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
> >      38.20 =C4=85 18%     -13.2       24.96 =C4=85 10%  perf-profile.ca=
lltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       7.98 =C4=85 67%      -7.2        0.73 =C4=85173%  perf-profile.ca=
lltrace.cycles-pp.smp_call_function_single.event_function_call.perf_remove_=
from_context.perf_event_release_kernel.perf_release
> >       7.98 =C4=85 67%      -7.2        0.73 =C4=85173%  perf-profile.ca=
lltrace.cycles-pp.event_function_call.perf_remove_from_context.perf_event_r=
elease_kernel.perf_release.__fput
> >       7.98 =C4=85 67%      -7.2        0.73 =C4=85173%  perf-profile.ca=
lltrace.cycles-pp.perf_remove_from_context.perf_event_release_kernel.perf_r=
elease.__fput.task_work_run
> >      11.86 =C4=85 41%      -6.8        5.07 =C4=85 62%  perf-profile.ca=
lltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe
> >      11.86 =C4=85 41%      -6.8        5.07 =C4=85 62%  perf-profile.ca=
lltrace.cycles-pp.do_signal.exit_to_usermode_loop.do_syscall_64.entry_SYSCA=
LL_64_after_hwframe
> >      11.86 =C4=85 41%      -6.8        5.07 =C4=85 62%  perf-profile.ca=
lltrace.cycles-pp.get_signal.do_signal.exit_to_usermode_loop.do_syscall_64.=
entry_SYSCALL_64_after_hwframe
> >      11.86 =C4=85 41%      -6.8        5.07 =C4=85 62%  perf-profile.ca=
lltrace.cycles-pp.do_group_exit.get_signal.do_signal.exit_to_usermode_loop.=
do_syscall_64
> >      11.86 =C4=85 41%      -6.8        5.07 =C4=85 62%  perf-profile.ca=
lltrace.cycles-pp.do_exit.do_group_exit.get_signal.do_signal.exit_to_usermo=
de_loop
> >      11.86 =C4=85 41%      -6.8        5.07 =C4=85 62%  perf-profile.ca=
lltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.do_signal
> >       4.27 =C4=85 66%      -3.5        0.73 =C4=85173%  perf-profile.ca=
lltrace.cycles-pp.read
> >       4.05 =C4=85 71%      -3.3        0.73 =C4=85173%  perf-profile.ca=
lltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
> >       4.05 =C4=85 71%      -3.3        0.73 =C4=85173%  perf-profile.ca=
lltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
> >      13.30 =C4=85 38%      -8.2        5.07 =C4=85 62%  perf-profile.ch=
ildren.cycles-pp.task_work_run
> >      12.47 =C4=85 46%      -7.4        5.07 =C4=85 62%  perf-profile.ch=
ildren.cycles-pp.exit_to_usermode_loop
> >      12.47 =C4=85 46%      -7.4        5.07 =C4=85 62%  perf-profile.ch=
ildren.cycles-pp.__fput
> >       7.98 =C4=85 67%      -7.2        0.73 =C4=85173%  perf-profile.ch=
ildren.cycles-pp.perf_remove_from_context
> >      11.86 =C4=85 41%      -6.8        5.07 =C4=85 62%  perf-profile.ch=
ildren.cycles-pp.do_signal
> >      11.86 =C4=85 41%      -6.8        5.07 =C4=85 62%  perf-profile.ch=
ildren.cycles-pp.get_signal
> >       9.43 =C4=85 21%      -4.7        4.72 =C4=85 67%  perf-profile.ch=
ildren.cycles-pp.ksys_read
> >       9.43 =C4=85 21%      -4.7        4.72 =C4=85 67%  perf-profile.ch=
ildren.cycles-pp.vfs_read
> >       4.27 =C4=85 66%      -3.5        0.73 =C4=85173%  perf-profile.ch=
ildren.cycles-pp.read
> >       3.86 =C4=85101%      -3.1        0.71 =C4=85173%  perf-profile.ch=
ildren.cycles-pp._raw_spin_lock
> >       3.86 =C4=85101%      -3.1        0.71 =C4=85173%  perf-profile.ch=
ildren.cycles-pp.native_queued_spin_lock_slowpath
> >       3.86 =C4=85101%      -3.1        0.71 =C4=85173%  perf-profile.se=
lf.cycles-pp.native_queued_spin_lock_slowpath
> >
> >
> >
> > ***********************************************************************=
****************************
> > lkp-csl-2sp5: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with =
192G memory
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_=
group/testcase/testtime/ucode:
> >   os/gcc-7/performance/1HDD/ext4/x86_64-rhel-7.6/100%/debian-x86_64-201=
9-09-23.cgz/lkp-csl-2sp5/stress-ng/1s/0x500002b
> >
> > commit:
> >   fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
> >   0b0695f2b3 ("sched/fair: Rework load_balance()")
> >
> > fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :2           50%           1:8     dmesg.WARNING:at_ip_selin=
ux_file_ioctl/0x
> >          %stddev     %change         %stddev
> >              \          |                \
> >     122451 =C4=85 11%     -19.9%      98072 =C4=85 15%  stress-ng.iopri=
o.ops
> >     116979 =C4=85 11%     -20.7%      92815 =C4=85 16%  stress-ng.iopri=
o.ops_per_sec
> >     274187 =C4=85 21%     -26.7%     201013 =C4=85 11%  stress-ng.kill.=
ops
> >     274219 =C4=85 21%     -26.7%     201040 =C4=85 11%  stress-ng.kill.=
ops_per_sec
> >    3973765           -10.1%    3570462 =C4=85  5%  stress-ng.lockf.ops
> >    3972581           -10.2%    3568935 =C4=85  5%  stress-ng.lockf.ops_=
per_sec
> >      10719 =C4=85  8%     -39.9%       6442 =C4=85 22%  stress-ng.procf=
s.ops
> >       9683 =C4=85  3%     -39.3%       5878 =C4=85 22%  stress-ng.procf=
s.ops_per_sec
> >    6562721           -35.1%    4260609 =C4=85  8%  stress-ng.schedpolic=
y.ops
> >    6564233           -35.1%    4261479 =C4=85  8%  stress-ng.schedpolic=
y.ops_per_sec
> >    1070988           +21.4%    1299977 =C4=85  7%  stress-ng.sigrt.ops
> >    1061773           +21.2%    1286618 =C4=85  7%  stress-ng.sigrt.ops_=
per_sec
> >    1155684 =C4=85  5%     -14.8%     984531 =C4=85 16%  stress-ng.symli=
nk.ops
> >     991624 =C4=85  4%     -23.8%     755147 =C4=85 41%  stress-ng.symli=
nk.ops_per_sec
> >       6925           -12.1%       6086 =C4=85 27%  stress-ng.time.perce=
nt_of_cpu_this_job_got
> >      24.68            +9.3       33.96 =C4=85 52%  mpstat.cpu.all.idle%
> >     171.00 =C4=85  2%     -55.3%      76.50 =C4=85 60%  numa-vmstat.nod=
e1.nr_inactive_file
> >     171.00 =C4=85  2%     -55.3%      76.50 =C4=85 60%  numa-vmstat.nod=
e1.nr_zone_inactive_file
> >  2.032e+11           -12.5%  1.777e+11 =C4=85 27%  perf-stat.i.cpu-cycl=
es
> >  2.025e+11           -12.0%  1.782e+11 =C4=85 27%  perf-stat.ps.cpu-cyc=
les
> >      25.00           +37.5%      34.38 =C4=85 51%  vmstat.cpu.id
> >      68.00           -13.2%      59.00 =C4=85 27%  vmstat.cpu.sy
> >      25.24           +37.0%      34.57 =C4=85 51%  iostat.cpu.idle
> >      68.21           -12.7%      59.53 =C4=85 27%  iostat.cpu.system
> >       4.31 =C4=85100%    +200.6%      12.96 =C4=85 63%  iostat.sda.r_aw=
ait.max
> >       1014 =C4=85  2%     -17.1%     841.00 =C4=85 10%  meminfo.Inactiv=
e(file)
> >      30692 =C4=85 12%     -20.9%      24280 =C4=85 30%  meminfo.Mlocked
> >     103627 =C4=85 27%     -32.7%      69720        meminfo.Percpu
> >     255.50 =C4=85  2%     -18.1%     209.25 =C4=85 10%  proc-vmstat.nr_=
inactive_file
> >     255.50 =C4=85  2%     -18.1%     209.25 =C4=85 10%  proc-vmstat.nr_=
zone_inactive_file
> >     185035 =C4=85 22%     -22.2%     143917 =C4=85 25%  proc-vmstat.pgm=
igrate_success
> >       2107           -12.3%       1848 =C4=85 27%  turbostat.Avg_MHz
> >      69.00            -7.1%      64.12 =C4=85  8%  turbostat.PkgTmp
> >      94.63            -2.2%      92.58 =C4=85  4%  turbostat.RAMWatt
> >      96048           +26.8%     121800 =C4=85  8%  softirqs.CPU10.NET_R=
X
> >      96671 =C4=85  4%     +34.2%     129776 =C4=85  6%  softirqs.CPU15.=
NET_RX
> >     171243 =C4=85  3%     -12.9%     149135 =C4=85  8%  softirqs.CPU25.=
NET_RX
> >     165317 =C4=85  4%     -11.4%     146494 =C4=85  9%  softirqs.CPU27.=
NET_RX
> >     139558           -24.5%     105430 =C4=85 14%  softirqs.CPU58.NET_R=
X
> >     147836           -15.8%     124408 =C4=85  6%  softirqs.CPU63.NET_R=
X
> >     129568           -13.8%     111624 =C4=85 10%  softirqs.CPU66.NET_R=
X
> >       1050 =C4=85  2%     +14.2%       1198 =C4=85  9%  slabinfo.biovec=
-128.active_objs
> >       1050 =C4=85  2%     +14.2%       1198 =C4=85  9%  slabinfo.biovec=
-128.num_objs
> >      23129           +19.6%      27668 =C4=85  6%  slabinfo.kmalloc-512=
.active_objs
> >     766.50           +17.4%     899.75 =C4=85  6%  slabinfo.kmalloc-512=
.active_slabs
> >      24535           +17.4%      28806 =C4=85  6%  slabinfo.kmalloc-512=
.num_objs
> >     766.50           +17.4%     899.75 =C4=85  6%  slabinfo.kmalloc-512=
.num_slabs
> >       1039 =C4=85  4%      -4.3%     994.12 =C4=85  6%  slabinfo.sock_i=
node_cache.active_slabs
> >      40527 =C4=85  4%      -4.3%      38785 =C4=85  6%  slabinfo.sock_i=
node_cache.num_objs
> >       1039 =C4=85  4%      -4.3%     994.12 =C4=85  6%  slabinfo.sock_i=
node_cache.num_slabs
> >    1549456           -43.6%     873443 =C4=85 24%  sched_debug.cfs_rq:/=
.min_vruntime.stddev
> >      73.25 =C4=85  5%     +74.8%     128.03 =C4=85 31%  sched_debug.cfs=
_rq:/.nr_spread_over.stddev
> >      18.60 =C4=85 57%     -63.8%       6.73 =C4=85 64%  sched_debug.cfs=
_rq:/.removed.load_avg.avg
> >      79.57 =C4=85 44%     -44.1%      44.52 =C4=85 55%  sched_debug.cfs=
_rq:/.removed.load_avg.stddev
> >     857.10 =C4=85 57%     -63.8%     310.09 =C4=85 64%  sched_debug.cfs=
_rq:/.removed.runnable_sum.avg
> >       3664 =C4=85 44%     -44.1%       2049 =C4=85 55%  sched_debug.cfs=
_rq:/.removed.runnable_sum.stddev
> >       4.91 =C4=85 42%     -45.3%       2.69 =C4=85 61%  sched_debug.cfs=
_rq:/.removed.util_avg.avg
> >    1549544           -43.6%     874006 =C4=85 24%  sched_debug.cfs_rq:/=
.spread0.stddev
> >     786.14 =C4=85  6%     -20.1%     628.46 =C4=85 23%  sched_debug.cfs=
_rq:/.util_avg.avg
> >       1415 =C4=85  8%     -16.7%       1178 =C4=85 18%  sched_debug.cfs=
_rq:/.util_avg.max
> >     467435 =C4=85 15%     +46.7%     685829 =C4=85 15%  sched_debug.cpu=
.avg_idle.avg
> >      17972 =C4=85  8%    +631.2%     131410 =C4=85 34%  sched_debug.cpu=
.avg_idle.min
> >       7.66 =C4=85 26%    +209.7%      23.72 =C4=85 54%  sched_debug.cpu=
.clock.stddev
> >       7.66 =C4=85 26%    +209.7%      23.72 =C4=85 54%  sched_debug.cpu=
.clock_task.stddev
> >     618063 =C4=85  5%     -17.0%     513085 =C4=85  5%  sched_debug.cpu=
.max_idle_balance_cost.max
> >      12083 =C4=85 28%     -85.4%       1768 =C4=85231%  sched_debug.cpu=
.max_idle_balance_cost.stddev
> >      12857 =C4=85 16%   +2117.7%     285128 =C4=85106%  sched_debug.cpu=
.yld_count.min
> >       0.55 =C4=85  6%      -0.2        0.37 =C4=85 51%  perf-profile.ch=
ildren.cycles-pp.fpregs_assert_state_consistent
> >       0.30 =C4=85 21%      -0.2        0.14 =C4=85105%  perf-profile.ch=
ildren.cycles-pp.yield_task_fair
> >       0.32 =C4=85  6%      -0.2        0.16 =C4=85 86%  perf-profile.ch=
ildren.cycles-pp.rmap_walk_anon
> >       0.19            -0.1        0.10 =C4=85 86%  perf-profile.childre=
n.cycles-pp.page_mapcount_is_zero
> >       0.19            -0.1        0.10 =C4=85 86%  perf-profile.childre=
n.cycles-pp.total_mapcount
> >       0.14            -0.1        0.09 =C4=85 29%  perf-profile.childre=
n.cycles-pp.start_kernel
> >       0.11 =C4=85  9%      -0.0        0.07 =C4=85 47%  perf-profile.ch=
ildren.cycles-pp.__switch_to
> >       0.10 =C4=85 14%      -0.0        0.06 =C4=85 45%  perf-profile.ch=
ildren.cycles-pp.switch_fpu_return
> >       0.08 =C4=85  6%      -0.0        0.04 =C4=85 79%  perf-profile.ch=
ildren.cycles-pp.__update_load_avg_se
> >       0.12 =C4=85 13%      -0.0        0.09 =C4=85 23%  perf-profile.ch=
ildren.cycles-pp.native_write_msr
> >       0.31 =C4=85  6%      -0.2        0.15 =C4=85 81%  perf-profile.se=
lf.cycles-pp.poll_idle
> >       0.50 =C4=85  6%      -0.2        0.35 =C4=85 50%  perf-profile.se=
lf.cycles-pp.fpregs_assert_state_consistent
> >       0.18 =C4=85  2%      -0.1        0.10 =C4=85 86%  perf-profile.se=
lf.cycles-pp.total_mapcount
> >       0.10 =C4=85 14%      -0.0        0.06 =C4=85 45%  perf-profile.se=
lf.cycles-pp.switch_fpu_return
> >       0.10 =C4=85 10%      -0.0        0.06 =C4=85 47%  perf-profile.se=
lf.cycles-pp.__switch_to
> >       0.07 =C4=85  7%      -0.0        0.03 =C4=85100%  perf-profile.se=
lf.cycles-pp.prep_new_page
> >       0.07 =C4=85  7%      -0.0        0.03 =C4=85100%  perf-profile.se=
lf.cycles-pp.llist_add_batch
> >       0.07 =C4=85 14%      -0.0        0.04 =C4=85 79%  perf-profile.se=
lf.cycles-pp.__update_load_avg_se
> >       0.12 =C4=85 13%      -0.0        0.09 =C4=85 23%  perf-profile.se=
lf.cycles-pp.native_write_msr
> >      66096 =C4=85 99%     -99.8%     148.50 =C4=85 92%  interrupts.109:=
PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
> >     543.50 =C4=85 39%     -73.3%     145.38 =C4=85 81%  interrupts.112:=
PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
> >     169.00 =C4=85 28%     -55.3%      75.50 =C4=85 83%  interrupts.116:=
PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
> >     224.00 =C4=85 14%     -57.6%      95.00 =C4=85 87%  interrupts.121:=
PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
> >     680.00 =C4=85 28%     -80.5%     132.75 =C4=85 82%  interrupts.43:P=
CI-MSI.31981576-edge.i40e-eth0-TxRx-7
> >     327.50 =C4=85 31%     -39.0%     199.62 =C4=85 60%  interrupts.60:P=
CI-MSI.31981593-edge.i40e-eth0-TxRx-24
> >     217.50 =C4=85 19%     -51.7%     105.12 =C4=85 79%  interrupts.63:P=
CI-MSI.31981596-edge.i40e-eth0-TxRx-27
> >     375.00 =C4=85 46%     -78.5%      80.50 =C4=85 82%  interrupts.70:P=
CI-MSI.31981603-edge.i40e-eth0-TxRx-34
> >     196.50 =C4=85  3%     -51.6%      95.12 =C4=85 74%  interrupts.72:P=
CI-MSI.31981605-edge.i40e-eth0-TxRx-36
> >     442.50 =C4=85 45%     -73.1%     118.88 =C4=85 90%  interrupts.79:P=
CI-MSI.31981612-edge.i40e-eth0-TxRx-43
> >     271.00 =C4=85  8%     -53.2%     126.88 =C4=85 75%  interrupts.82:P=
CI-MSI.31981615-edge.i40e-eth0-TxRx-46
> >     145448 =C4=85  4%     -41.6%      84975 =C4=85 42%  interrupts.CPU1=
.RES:Rescheduling_interrupts
> >      11773 =C4=85 19%     -38.1%       7290 =C4=85 52%  interrupts.CPU1=
3.TLB:TLB_shootdowns
> >      24177 =C4=85 15%    +356.5%     110368 =C4=85 58%  interrupts.CPU1=
6.RES:Rescheduling_interrupts
> >       3395 =C4=85  3%     +78.3%       6055 =C4=85 18%  interrupts.CPU1=
7.NMI:Non-maskable_interrupts
> >       3395 =C4=85  3%     +78.3%       6055 =C4=85 18%  interrupts.CPU1=
7.PMI:Performance_monitoring_interrupts
> >     106701 =C4=85 41%     -55.6%      47425 =C4=85 56%  interrupts.CPU1=
8.RES:Rescheduling_interrupts
> >     327.50 =C4=85 31%     -39.3%     198.88 =C4=85 60%  interrupts.CPU2=
4.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
> >     411618           +53.6%     632283 =C4=85 77%  interrupts.CPU25.LOC=
:Local_timer_interrupts
> >      16189 =C4=85 26%     -53.0%       7611 =C4=85 66%  interrupts.CPU2=
5.TLB:TLB_shootdowns
> >     407253           +54.4%     628596 =C4=85 78%  interrupts.CPU26.LOC=
:Local_timer_interrupts
> >     216.50 =C4=85 19%     -51.8%     104.25 =C4=85 80%  interrupts.CPU2=
7.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
> >       7180           -20.9%       5682 =C4=85 25%  interrupts.CPU29.NMI=
:Non-maskable_interrupts
> >       7180           -20.9%       5682 =C4=85 25%  interrupts.CPU29.PMI=
:Performance_monitoring_interrupts
> >      15186 =C4=85 12%     -45.5%       8276 =C4=85 49%  interrupts.CPU3=
.TLB:TLB_shootdowns
> >      13092 =C4=85 19%     -29.5%       9231 =C4=85 35%  interrupts.CPU3=
0.TLB:TLB_shootdowns
> >      13204 =C4=85 26%     -29.3%       9336 =C4=85 19%  interrupts.CPU3=
1.TLB:TLB_shootdowns
> >     374.50 =C4=85 46%     -78.7%      79.62 =C4=85 83%  interrupts.CPU3=
4.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
> >       7188           -25.6%       5345 =C4=85 26%  interrupts.CPU35.NMI=
:Non-maskable_interrupts
> >       7188           -25.6%       5345 =C4=85 26%  interrupts.CPU35.PMI=
:Performance_monitoring_interrupts
> >     196.00 =C4=85  4%     -52.0%      94.12 =C4=85 75%  interrupts.CPU3=
6.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
> >      12170 =C4=85 20%     -34.3%       7998 =C4=85 32%  interrupts.CPU3=
9.TLB:TLB_shootdowns
> >     442.00 =C4=85 45%     -73.3%     118.12 =C4=85 91%  interrupts.CPU4=
3.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
> >      12070 =C4=85 15%     -37.2%       7581 =C4=85 49%  interrupts.CPU4=
3.TLB:TLB_shootdowns
> >       7177           -27.6%       5195 =C4=85 26%  interrupts.CPU45.NMI=
:Non-maskable_interrupts
> >       7177           -27.6%       5195 =C4=85 26%  interrupts.CPU45.PMI=
:Performance_monitoring_interrupts
> >     271.00 =C4=85  8%     -53.4%     126.38 =C4=85 75%  interrupts.CPU4=
6.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
> >       3591           +84.0%       6607 =C4=85 12%  interrupts.CPU46.NMI=
:Non-maskable_interrupts
> >       3591           +84.0%       6607 =C4=85 12%  interrupts.CPU46.PMI=
:Performance_monitoring_interrupts
> >      57614 =C4=85 30%     -34.0%      38015 =C4=85 28%  interrupts.CPU4=
6.RES:Rescheduling_interrupts
> >     149154 =C4=85 41%     -47.2%      78808 =C4=85 51%  interrupts.CPU5=
1.RES:Rescheduling_interrupts
> >      30366 =C4=85 28%    +279.5%     115229 =C4=85 42%  interrupts.CPU5=
2.RES:Rescheduling_interrupts
> >      29690          +355.5%     135237 =C4=85 57%  interrupts.CPU54.RES=
:Rescheduling_interrupts
> >     213106 =C4=85  2%     -66.9%      70545 =C4=85 43%  interrupts.CPU5=
9.RES:Rescheduling_interrupts
> >     225753 =C4=85  7%     -72.9%      61212 =C4=85 72%  interrupts.CPU6=
0.RES:Rescheduling_interrupts
> >      12430 =C4=85 14%     -41.5%       7276 =C4=85 52%  interrupts.CPU6=
1.TLB:TLB_shootdowns
> >      44552 =C4=85 22%    +229.6%     146864 =C4=85 36%  interrupts.CPU6=
5.RES:Rescheduling_interrupts
> >     126088 =C4=85 56%     -35.3%      81516 =C4=85 73%  interrupts.CPU6=
6.RES:Rescheduling_interrupts
> >     170880 =C4=85 15%     -62.9%      63320 =C4=85 52%  interrupts.CPU6=
8.RES:Rescheduling_interrupts
> >     186033 =C4=85 10%     -39.8%     112012 =C4=85 41%  interrupts.CPU6=
9.RES:Rescheduling_interrupts
> >     679.50 =C4=85 29%     -80.5%     132.25 =C4=85 82%  interrupts.CPU7=
.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
> >     124750 =C4=85 18%     -39.4%      75553 =C4=85 43%  interrupts.CPU7=
.RES:Rescheduling_interrupts
> >     158500 =C4=85 47%     -52.1%      75915 =C4=85 67%  interrupts.CPU7=
1.RES:Rescheduling_interrupts
> >      11846 =C4=85 11%     -32.5%       8001 =C4=85 47%  interrupts.CPU7=
2.TLB:TLB_shootdowns
> >      66095 =C4=85 99%     -99.8%     147.62 =C4=85 93%  interrupts.CPU7=
3.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
> >       7221 =C4=85  2%     -31.0%       4982 =C4=85 35%  interrupts.CPU7=
3.NMI:Non-maskable_interrupts
> >       7221 =C4=85  2%     -31.0%       4982 =C4=85 35%  interrupts.CPU7=
3.PMI:Performance_monitoring_interrupts
> >      15304 =C4=85 14%     -47.9%       7972 =C4=85 31%  interrupts.CPU7=
3.TLB:TLB_shootdowns
> >      10918 =C4=85  3%     -31.9%       7436 =C4=85 36%  interrupts.CPU7=
4.TLB:TLB_shootdowns
> >     543.00 =C4=85 39%     -73.3%     144.75 =C4=85 81%  interrupts.CPU7=
6.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
> >      12214 =C4=85 14%     -40.9%       7220 =C4=85 38%  interrupts.CPU7=
9.TLB:TLB_shootdowns
> >     168.00 =C4=85 29%     -55.7%      74.50 =C4=85 85%  interrupts.CPU8=
0.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
> >      28619 =C4=85  3%    +158.4%      73939 =C4=85 44%  interrupts.CPU8=
0.RES:Rescheduling_interrupts
> >      12258           -34.3%       8056 =C4=85 29%  interrupts.CPU80.TLB=
:TLB_shootdowns
> >       7214           -19.5%       5809 =C4=85 24%  interrupts.CPU82.NMI=
:Non-maskable_interrupts
> >       7214           -19.5%       5809 =C4=85 24%  interrupts.CPU82.PMI=
:Performance_monitoring_interrupts
> >      13522 =C4=85 11%     -41.2%       7949 =C4=85 29%  interrupts.CPU8=
4.TLB:TLB_shootdowns
> >     223.50 =C4=85 14%     -57.8%      94.25 =C4=85 88%  interrupts.CPU8=
5.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
> >      11989 =C4=85  2%     -31.7%       8194 =C4=85 22%  interrupts.CPU8=
5.TLB:TLB_shootdowns
> >     121153 =C4=85 29%     -41.4%      70964 =C4=85 58%  interrupts.CPU8=
6.RES:Rescheduling_interrupts
> >      11731 =C4=85  8%     -40.7%       6957 =C4=85 36%  interrupts.CPU8=
6.TLB:TLB_shootdowns
> >      12192 =C4=85 22%     -35.8%       7824 =C4=85 43%  interrupts.CPU8=
7.TLB:TLB_shootdowns
> >      11603 =C4=85 19%     -31.8%       7915 =C4=85 41%  interrupts.CPU8=
9.TLB:TLB_shootdowns
> >      10471 =C4=85  5%     -27.0%       7641 =C4=85 31%  interrupts.CPU9=
1.TLB:TLB_shootdowns
> >       7156           -20.9%       5658 =C4=85 23%  interrupts.CPU92.NMI=
:Non-maskable_interrupts
> >       7156           -20.9%       5658 =C4=85 23%  interrupts.CPU92.PMI=
:Performance_monitoring_interrupts
> >      99802 =C4=85 20%     -43.6%      56270 =C4=85 47%  interrupts.CPU9=
2.RES:Rescheduling_interrupts
> >     109162 =C4=85 18%     -28.7%      77839 =C4=85 26%  interrupts.CPU9=
3.RES:Rescheduling_interrupts
> >      15044 =C4=85 29%     -44.4%       8359 =C4=85 30%  interrupts.CPU9=
3.TLB:TLB_shootdowns
> >     110749 =C4=85 19%     -47.3%      58345 =C4=85 48%  interrupts.CPU9=
4.RES:Rescheduling_interrupts
> >       7245           -21.4%       5697 =C4=85 25%  interrupts.CPU95.NMI=
:Non-maskable_interrupts
> >       7245           -21.4%       5697 =C4=85 25%  interrupts.CPU95.PMI=
:Performance_monitoring_interrupts
> >       1969 =C4=85  5%    +491.7%      11653 =C4=85 81%  interrupts.IWI:=
IRQ_work_interrupts
> >
> >
> >
> > ***********************************************************************=
****************************
> > lkp-bdw-ep6: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with =
128G memory
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_gro=
up/testcase/testtime/ucode:
> >   interrupt/gcc-7/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-2=
019-09-23.cgz/lkp-bdw-ep6/stress-ng/30s/0xb000038
> >
> > commit:
> >   fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
> >   0b0695f2b3 ("sched/fair: Rework load_balance()")
> >
> > fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >   98318389           +43.0%  1.406e+08        stress-ng.schedpolicy.ops
> >    3277346           +43.0%    4685146        stress-ng.schedpolicy.ops=
_per_sec
> >  3.506e+08 =C4=85  4%     -10.3%  3.146e+08 =C4=85  3%  stress-ng.sigq.=
ops
> >   11684738 =C4=85  4%     -10.3%   10485353 =C4=85  3%  stress-ng.sigq.=
ops_per_sec
> >  3.628e+08 =C4=85  6%     -19.4%  2.925e+08 =C4=85  6%  stress-ng.time.=
involuntary_context_switches
> >      29456            +2.8%      30285        stress-ng.time.system_tim=
e
> >    7636655 =C4=85  9%     +46.6%   11197377 =C4=85 27%  cpuidle.C1E.usa=
ge
> >    1111483 =C4=85  3%      -9.5%    1005829        vmstat.system.cs
> >   22638222 =C4=85  4%     +16.5%   26370816 =C4=85 11%  meminfo.Committ=
ed_AS
> >      28908 =C4=85  6%     +24.6%      36020 =C4=85 16%  meminfo.KernelS=
tack
> >    7636543 =C4=85  9%     +46.6%   11196090 =C4=85 27%  turbostat.C1E
> >       3.46 =C4=85 16%     -61.2%       1.35 =C4=85  7%  turbostat.Pkg%p=
c2
> >     217.54            +1.7%     221.33        turbostat.PkgWatt
> >      13.34 =C4=85  2%      +5.8%      14.11        turbostat.RAMWatt
> >     525.50 =C4=85  8%     -15.7%     443.00 =C4=85 12%  slabinfo.biovec=
-128.active_objs
> >     525.50 =C4=85  8%     -15.7%     443.00 =C4=85 12%  slabinfo.biovec=
-128.num_objs
> >      28089 =C4=85 12%     -33.0%      18833 =C4=85 22%  slabinfo.pool_w=
orkqueue.active_objs
> >     877.25 =C4=85 12%     -32.6%     591.00 =C4=85 21%  slabinfo.pool_w=
orkqueue.active_slabs
> >      28089 =C4=85 12%     -32.6%      18925 =C4=85 21%  slabinfo.pool_w=
orkqueue.num_objs
> >     877.25 =C4=85 12%     -32.6%     591.00 =C4=85 21%  slabinfo.pool_w=
orkqueue.num_slabs
> >     846.75 =C4=85  6%     -18.0%     694.75 =C4=85  9%  slabinfo.skbuff=
_fclone_cache.active_objs
> >     846.75 =C4=85  6%     -18.0%     694.75 =C4=85  9%  slabinfo.skbuff=
_fclone_cache.num_objs
> >      63348 =C4=85  6%     -20.7%      50261 =C4=85  4%  softirqs.CPU14.=
SCHED
> >      44394 =C4=85  4%     +21.4%      53880 =C4=85  8%  softirqs.CPU42.=
SCHED
> >      52246 =C4=85  7%     -15.1%      44352        softirqs.CPU47.SCHED
> >      58350 =C4=85  4%     -11.0%      51914 =C4=85  7%  softirqs.CPU6.S=
CHED
> >      58009 =C4=85  7%     -23.8%      44206 =C4=85  4%  softirqs.CPU63.=
SCHED
> >      49166 =C4=85  6%     +23.4%      60683 =C4=85  9%  softirqs.CPU68.=
SCHED
> >      44594 =C4=85  7%     +14.3%      50951 =C4=85  8%  softirqs.CPU78.=
SCHED
> >      46407 =C4=85  9%     +19.6%      55515 =C4=85  8%  softirqs.CPU84.=
SCHED
> >      55555 =C4=85  8%     -15.5%      46933 =C4=85  4%  softirqs.CPU9.S=
CHED
> >     198757 =C4=85 18%     +44.1%     286316 =C4=85  9%  numa-meminfo.no=
de0.Active
> >     189280 =C4=85 19%     +37.1%     259422 =C4=85  7%  numa-meminfo.no=
de0.Active(anon)
> >     110438 =C4=85 33%     +68.3%     185869 =C4=85 16%  numa-meminfo.no=
de0.AnonHugePages
> >     143458 =C4=85 28%     +67.7%     240547 =C4=85 13%  numa-meminfo.no=
de0.AnonPages
> >      12438 =C4=85 16%     +61.9%      20134 =C4=85 37%  numa-meminfo.no=
de0.KernelStack
> >    1004379 =C4=85  7%     +16.4%    1168764 =C4=85  4%  numa-meminfo.no=
de0.MemUsed
> >     357111 =C4=85 24%     -41.6%     208655 =C4=85 29%  numa-meminfo.no=
de1.Active
> >     330094 =C4=85 22%     -39.6%     199339 =C4=85 32%  numa-meminfo.no=
de1.Active(anon)
> >     265924 =C4=85 25%     -52.2%     127138 =C4=85 46%  numa-meminfo.no=
de1.AnonHugePages
> >     314059 =C4=85 22%     -49.6%     158305 =C4=85 36%  numa-meminfo.no=
de1.AnonPages
> >      15386 =C4=85 16%     -25.1%      11525 =C4=85 15%  numa-meminfo.no=
de1.KernelStack
> >    1200805 =C4=85 11%     -18.6%     977595 =C4=85  7%  numa-meminfo.no=
de1.MemUsed
> >     965.50 =C4=85 15%     -29.3%     682.25 =C4=85 43%  numa-meminfo.no=
de1.Mlocked
> >      46762 =C4=85 18%     +37.8%      64452 =C4=85  8%  numa-vmstat.nod=
e0.nr_active_anon
> >      35393 =C4=85 27%     +68.9%      59793 =C4=85 12%  numa-vmstat.nod=
e0.nr_anon_pages
> >      52.75 =C4=85 33%     +71.1%      90.25 =C4=85 15%  numa-vmstat.nod=
e0.nr_anon_transparent_hugepages
> >      15.00 =C4=85 96%    +598.3%     104.75 =C4=85 15%  numa-vmstat.nod=
e0.nr_inactive_file
> >      11555 =C4=85 22%     +68.9%      19513 =C4=85 41%  numa-vmstat.nod=
e0.nr_kernel_stack
> >     550.25 =C4=85162%    +207.5%       1691 =C4=85 48%  numa-vmstat.nod=
e0.nr_written
> >      46762 =C4=85 18%     +37.8%      64452 =C4=85  8%  numa-vmstat.nod=
e0.nr_zone_active_anon
> >      15.00 =C4=85 96%    +598.3%     104.75 =C4=85 15%  numa-vmstat.nod=
e0.nr_zone_inactive_file
> >      82094 =C4=85 22%     -39.5%      49641 =C4=85 32%  numa-vmstat.nod=
e1.nr_active_anon
> >      78146 =C4=85 23%     -49.5%      39455 =C4=85 37%  numa-vmstat.nod=
e1.nr_anon_pages
> >     129.00 =C4=85 25%     -52.3%      61.50 =C4=85 47%  numa-vmstat.nod=
e1.nr_anon_transparent_hugepages
> >     107.75 =C4=85 12%     -85.4%      15.75 =C4=85103%  numa-vmstat.nod=
e1.nr_inactive_file
> >      14322 =C4=85 11%     -21.1%      11304 =C4=85 11%  numa-vmstat.nod=
e1.nr_kernel_stack
> >     241.00 =C4=85 15%     -29.5%     170.00 =C4=85 43%  numa-vmstat.nod=
e1.nr_mlock
> >      82094 =C4=85 22%     -39.5%      49641 =C4=85 32%  numa-vmstat.nod=
e1.nr_zone_active_anon
> >     107.75 =C4=85 12%     -85.4%      15.75 =C4=85103%  numa-vmstat.nod=
e1.nr_zone_inactive_file
> >       0.81 =C4=85  5%      +0.2        0.99 =C4=85 10%  perf-profile.ca=
lltrace.cycles-pp.task_rq_lock.task_sched_runtime.cpu_clock_sample.posix_cp=
u_timer_get.do_timer_gettime
> >       0.60 =C4=85 11%      +0.2        0.83 =C4=85  9%  perf-profile.ca=
lltrace.cycles-pp.___might_sleep.__might_fault._copy_to_user.put_itimerspec=
64.__x64_sys_timer_gettime
> >       1.73 =C4=85  9%      +0.3        2.05 =C4=85  8%  perf-profile.ca=
lltrace.cycles-pp.__might_fault._copy_to_user.put_itimerspec64.__x64_sys_ti=
mer_gettime.do_syscall_64
> >       3.92 =C4=85  5%      +0.6        4.49 =C4=85  7%  perf-profile.ca=
lltrace.cycles-pp.task_sched_runtime.cpu_clock_sample.posix_cpu_timer_get.d=
o_timer_gettime.__x64_sys_timer_gettime
> >       4.17 =C4=85  4%      +0.6        4.78 =C4=85  7%  perf-profile.ca=
lltrace.cycles-pp.cpu_clock_sample.posix_cpu_timer_get.do_timer_gettime.__x=
64_sys_timer_gettime.do_syscall_64
> >       5.72 =C4=85  3%      +0.7        6.43 =C4=85  7%  perf-profile.ca=
lltrace.cycles-pp.posix_cpu_timer_get.do_timer_gettime.__x64_sys_timer_gett=
ime.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.24 =C4=85 54%      -0.2        0.07 =C4=85131%  perf-profile.ch=
ildren.cycles-pp.ext4_inode_csum_set
> >       0.45 =C4=85  3%      +0.1        0.56 =C4=85  4%  perf-profile.ch=
ildren.cycles-pp.__might_sleep
> >       0.84 =C4=85  5%      +0.2        1.03 =C4=85  9%  perf-profile.ch=
ildren.cycles-pp.task_rq_lock
> >       0.66 =C4=85  8%      +0.2        0.88 =C4=85  7%  perf-profile.ch=
ildren.cycles-pp.___might_sleep
> >       1.83 =C4=85  9%      +0.3        2.16 =C4=85  8%  perf-profile.ch=
ildren.cycles-pp.__might_fault
> >       4.04 =C4=85  5%      +0.6        4.62 =C4=85  7%  perf-profile.ch=
ildren.cycles-pp.task_sched_runtime
> >       4.24 =C4=85  4%      +0.6        4.87 =C4=85  7%  perf-profile.ch=
ildren.cycles-pp.cpu_clock_sample
> >       5.77 =C4=85  3%      +0.7        6.48 =C4=85  7%  perf-profile.ch=
ildren.cycles-pp.posix_cpu_timer_get
> >       0.22 =C4=85 11%      +0.1        0.28 =C4=85 15%  perf-profile.se=
lf.cycles-pp.cpu_clock_sample
> >       0.47 =C4=85  7%      +0.1        0.55 =C4=85  5%  perf-profile.se=
lf.cycles-pp.update_curr
> >       0.28 =C4=85  5%      +0.1        0.38 =C4=85 14%  perf-profile.se=
lf.cycles-pp.task_rq_lock
> >       0.42 =C4=85  3%      +0.1        0.53 =C4=85  4%  perf-profile.se=
lf.cycles-pp.__might_sleep
> >       0.50 =C4=85  5%      +0.1        0.61 =C4=85 11%  perf-profile.se=
lf.cycles-pp.task_sched_runtime
> >       0.63 =C4=85  9%      +0.2        0.85 =C4=85  7%  perf-profile.se=
lf.cycles-pp.___might_sleep
> >    9180611 =C4=85  5%     +40.1%   12859327 =C4=85 14%  sched_debug.cfs=
_rq:/.MIN_vruntime.max
> >    1479571 =C4=85  6%     +57.6%    2331469 =C4=85 14%  sched_debug.cfs=
_rq:/.MIN_vruntime.stddev
> >       7951 =C4=85  6%     -52.5%       3773 =C4=85 17%  sched_debug.cfs=
_rq:/.exec_clock.stddev
> >     321306 =C4=85 39%     -44.2%     179273        sched_debug.cfs_rq:/=
.load.max
> >    9180613 =C4=85  5%     +40.1%   12859327 =C4=85 14%  sched_debug.cfs=
_rq:/.max_vruntime.max
> >    1479571 =C4=85  6%     +57.6%    2331469 =C4=85 14%  sched_debug.cfs=
_rq:/.max_vruntime.stddev
> >   16622378           +20.0%   19940069 =C4=85  7%  sched_debug.cfs_rq:/=
.min_vruntime.avg
> >   18123901           +19.7%   21686545 =C4=85  6%  sched_debug.cfs_rq:/=
.min_vruntime.max
> >   14338218 =C4=85  3%     +27.4%   18267927 =C4=85  7%  sched_debug.cfs=
_rq:/.min_vruntime.min
> >       0.17 =C4=85 16%     +23.4%       0.21 =C4=85 11%  sched_debug.cfs=
_rq:/.nr_running.stddev
> >     319990 =C4=85 39%     -44.6%     177347        sched_debug.cfs_rq:/=
.runnable_weight.max
> >   -2067420           -33.5%   -1375445        sched_debug.cfs_rq:/.spre=
ad0.min
> >       1033 =C4=85  8%     -13.7%     891.85 =C4=85  3%  sched_debug.cfs=
_rq:/.util_est_enqueued.max
> >      93676 =C4=85 16%     -29.0%      66471 =C4=85 17%  sched_debug.cpu=
.avg_idle.min
> >      10391 =C4=85 52%    +118.9%      22750 =C4=85 15%  sched_debug.cpu=
.curr->pid.avg
> >      14393 =C4=85 35%    +113.2%      30689 =C4=85 17%  sched_debug.cpu=
.curr->pid.max
> >       3041 =C4=85 38%    +161.8%       7963 =C4=85 11%  sched_debug.cpu=
.curr->pid.stddev
> >       3.38 =C4=85  6%     -16.3%       2.83 =C4=85  5%  sched_debug.cpu=
.nr_running.max
> >    2412687 =C4=85  4%     -16.0%    2027251 =C4=85  3%  sched_debug.cpu=
.nr_switches.avg
> >    4038819 =C4=85  3%     -20.2%    3223112 =C4=85  5%  sched_debug.cpu=
.nr_switches.max
> >     834203 =C4=85 17%     -37.8%     518798 =C4=85 27%  sched_debug.cpu=
.nr_switches.stddev
> >      45.85 =C4=85 13%     +41.2%      64.75 =C4=85 18%  sched_debug.cpu=
.nr_uninterruptible.max
> >    1937209 =C4=85  2%     +58.5%    3070891 =C4=85  3%  sched_debug.cpu=
.sched_count.min
> >    1074023 =C4=85 13%     -57.9%     451958 =C4=85 12%  sched_debug.cpu=
.sched_count.stddev
> >    1283769 =C4=85  7%     +65.1%    2118907 =C4=85  7%  sched_debug.cpu=
.yld_count.min
> >     714244 =C4=85  5%     -51.9%     343373 =C4=85 22%  sched_debug.cpu=
.yld_count.stddev
> >      12.54 =C4=85  9%     -18.8%      10.18 =C4=85 15%  perf-stat.i.MPK=
I
> >  1.011e+10            +2.6%  1.038e+10        perf-stat.i.branch-instru=
ctions
> >      13.22 =C4=85  5%      +2.5       15.75 =C4=85  3%  perf-stat.i.cac=
he-miss-rate%
> >   21084021 =C4=85  6%     +33.9%   28231058 =C4=85  6%  perf-stat.i.cac=
he-misses
> >    1143861 =C4=85  5%     -12.1%    1005721 =C4=85  6%  perf-stat.i.con=
text-switches
> >  1.984e+11            +1.8%   2.02e+11        perf-stat.i.cpu-cycles
> >  1.525e+10            +1.3%  1.544e+10        perf-stat.i.dTLB-loads
> >      65.46            -2.7       62.76 =C4=85  3%  perf-stat.i.iTLB-loa=
d-miss-rate%
> >   20360883 =C4=85  4%     +10.5%   22500874 =C4=85  4%  perf-stat.i.iTL=
B-loads
> >  4.963e+10            +2.0%  5.062e+10        perf-stat.i.instructions
> >     181557            -2.4%     177113        perf-stat.i.msec
> >    5350122 =C4=85  8%     +26.5%    6765332 =C4=85  7%  perf-stat.i.nod=
e-load-misses
> >    4264320 =C4=85  3%     +24.8%    5321600 =C4=85  4%  perf-stat.i.nod=
e-store-misses
> >       6.12 =C4=85  5%      +1.5        7.60 =C4=85  2%  perf-stat.overa=
ll.cache-miss-rate%
> >       7646 =C4=85  6%     -17.7%       6295 =C4=85  3%  perf-stat.overa=
ll.cycles-between-cache-misses
> >      69.29            -1.1       68.22        perf-stat.overall.iTLB-lo=
ad-miss-rate%
> >      61.11 =C4=85  2%      +6.6       67.71 =C4=85  5%  perf-stat.overa=
ll.node-load-miss-rate%
> >      74.82            +1.8       76.58        perf-stat.overall.node-st=
ore-miss-rate%
> >  1.044e+10            +1.8%  1.063e+10        perf-stat.ps.branch-instr=
uctions
> >   26325951 =C4=85  6%     +22.9%   32366684 =C4=85  2%  perf-stat.ps.ca=
che-misses
> >    1115530 =C4=85  3%      -9.5%    1009780        perf-stat.ps.context=
-switches
> >  1.536e+10            +1.0%  1.552e+10        perf-stat.ps.dTLB-loads
> >   44718416 =C4=85  2%      +5.8%   47308605 =C4=85  3%  perf-stat.ps.iT=
LB-load-misses
> >   19831973 =C4=85  4%     +11.1%   22040029 =C4=85  4%  perf-stat.ps.iT=
LB-loads
> >  5.064e+10            +1.4%  5.137e+10        perf-stat.ps.instructions
> >    5454694 =C4=85  9%     +26.4%    6892365 =C4=85  6%  perf-stat.ps.no=
de-load-misses
> >    4263688 =C4=85  4%     +24.9%    5325279 =C4=85  4%  perf-stat.ps.no=
de-store-misses
> >  3.001e+13            +1.7%  3.052e+13        perf-stat.total.instructi=
ons
> >      18550           -74.9%       4650 =C4=85173%  interrupts.76:IR-PCI=
-MSI.512000-edge.ahci[0000:00:1f.2]
> >       7642 =C4=85  9%     -20.4%       6086 =C4=85  2%  interrupts.CPU0=
.CAL:Function_call_interrupts
> >       4376 =C4=85 22%     -75.4%       1077 =C4=85 41%  interrupts.CPU0=
.TLB:TLB_shootdowns
> >       8402 =C4=85  5%     -19.0%       6806        interrupts.CPU1.CAL:=
Function_call_interrupts
> >       4559 =C4=85 20%     -73.7%       1199 =C4=85 15%  interrupts.CPU1=
.TLB:TLB_shootdowns
> >       8423 =C4=85  4%     -20.2%       6725 =C4=85  2%  interrupts.CPU1=
0.CAL:Function_call_interrupts
> >       4536 =C4=85 14%     -75.0%       1135 =C4=85 20%  interrupts.CPU1=
0.TLB:TLB_shootdowns
> >       8303 =C4=85  3%     -18.2%       6795 =C4=85  2%  interrupts.CPU1=
1.CAL:Function_call_interrupts
> >       4404 =C4=85 11%     -71.6%       1250 =C4=85 35%  interrupts.CPU1=
1.TLB:TLB_shootdowns
> >       8491 =C4=85  6%     -21.3%       6683        interrupts.CPU12.CAL=
:Function_call_interrupts
> >       4723 =C4=85 20%     -77.2%       1077 =C4=85 17%  interrupts.CPU1=
2.TLB:TLB_shootdowns
> >       8403 =C4=85  5%     -20.3%       6700 =C4=85  2%  interrupts.CPU1=
3.CAL:Function_call_interrupts
> >       4557 =C4=85 19%     -74.2%       1175 =C4=85 22%  interrupts.CPU1=
3.TLB:TLB_shootdowns
> >       8459 =C4=85  4%     -18.6%       6884        interrupts.CPU14.CAL=
:Function_call_interrupts
> >       4559 =C4=85 18%     -69.8%       1376 =C4=85 13%  interrupts.CPU1=
4.TLB:TLB_shootdowns
> >       8305 =C4=85  7%     -17.7%       6833 =C4=85  2%  interrupts.CPU1=
5.CAL:Function_call_interrupts
> >       4261 =C4=85 25%     -67.6%       1382 =C4=85 24%  interrupts.CPU1=
5.TLB:TLB_shootdowns
> >       8277 =C4=85  5%     -19.1%       6696 =C4=85  3%  interrupts.CPU1=
6.CAL:Function_call_interrupts
> >       4214 =C4=85 22%     -69.6%       1282 =C4=85  8%  interrupts.CPU1=
6.TLB:TLB_shootdowns
> >       8258 =C4=85  5%     -18.9%       6694 =C4=85  3%  interrupts.CPU1=
7.CAL:Function_call_interrupts
> >       4461 =C4=85 19%     -74.1%       1155 =C4=85 21%  interrupts.CPU1=
7.TLB:TLB_shootdowns
> >       8457 =C4=85  6%     -20.6%       6717        interrupts.CPU18.CAL=
:Function_call_interrupts
> >       4889 =C4=85 34%     +60.0%       7822        interrupts.CPU18.NMI=
:Non-maskable_interrupts
> >       4889 =C4=85 34%     +60.0%       7822        interrupts.CPU18.PMI=
:Performance_monitoring_interrupts
> >       4731 =C4=85 22%     -77.2%       1078 =C4=85 10%  interrupts.CPU1=
8.TLB:TLB_shootdowns
> >       8160 =C4=85  5%     -18.1%       6684        interrupts.CPU19.CAL=
:Function_call_interrupts
> >       4311 =C4=85 20%     -74.2%       1114 =C4=85 13%  interrupts.CPU1=
9.TLB:TLB_shootdowns
> >       8464 =C4=85  2%     -18.2%       6927 =C4=85  3%  interrupts.CPU2=
.CAL:Function_call_interrupts
> >       4938 =C4=85 14%     -70.5%       1457 =C4=85 18%  interrupts.CPU2=
.TLB:TLB_shootdowns
> >       8358 =C4=85  6%     -19.7%       6715 =C4=85  3%  interrupts.CPU2=
0.CAL:Function_call_interrupts
> >       4567 =C4=85 24%     -74.6%       1160 =C4=85 35%  interrupts.CPU2=
0.TLB:TLB_shootdowns
> >       8460 =C4=85  4%     -22.3%       6577 =C4=85  2%  interrupts.CPU2=
1.CAL:Function_call_interrupts
> >       4514 =C4=85 18%     -76.0%       1084 =C4=85 22%  interrupts.CPU2=
1.TLB:TLB_shootdowns
> >       6677 =C4=85  6%     +19.6%       7988 =C4=85  9%  interrupts.CPU2=
2.CAL:Function_call_interrupts
> >       1288 =C4=85 14%    +209.1%       3983 =C4=85 35%  interrupts.CPU2=
2.TLB:TLB_shootdowns
> >       6751 =C4=85  2%     +24.0%       8370 =C4=85  9%  interrupts.CPU2=
3.CAL:Function_call_interrupts
> >       1037 =C4=85 29%    +323.0%       4388 =C4=85 36%  interrupts.CPU2=
3.TLB:TLB_shootdowns
> >       6844           +20.6%       8251 =C4=85  9%  interrupts.CPU24.CAL=
:Function_call_interrupts
> >       1205 =C4=85 17%    +229.2%       3967 =C4=85 40%  interrupts.CPU2=
4.TLB:TLB_shootdowns
> >       6880           +21.9%       8389 =C4=85  7%  interrupts.CPU25.CAL=
:Function_call_interrupts
> >       1228 =C4=85 19%    +245.2%       4240 =C4=85 35%  interrupts.CPU2=
5.TLB:TLB_shootdowns
> >       6494 =C4=85  8%     +25.1%       8123 =C4=85  9%  interrupts.CPU2=
6.CAL:Function_call_interrupts
> >       1141 =C4=85 13%    +262.5%       4139 =C4=85 32%  interrupts.CPU2=
6.TLB:TLB_shootdowns
> >       6852           +19.2%       8166 =C4=85  7%  interrupts.CPU27.CAL=
:Function_call_interrupts
> >       1298 =C4=85  8%    +197.1%       3857 =C4=85 31%  interrupts.CPU2=
7.TLB:TLB_shootdowns
> >       6563 =C4=85  6%     +25.2%       8214 =C4=85  8%  interrupts.CPU2=
8.CAL:Function_call_interrupts
> >       1176 =C4=85  8%    +237.1%       3964 =C4=85 33%  interrupts.CPU2=
8.TLB:TLB_shootdowns
> >       6842 =C4=85  2%     +21.4%       8308 =C4=85  8%  interrupts.CPU2=
9.CAL:Function_call_interrupts
> >       1271 =C4=85 11%    +223.8%       4118 =C4=85 33%  interrupts.CPU2=
9.TLB:TLB_shootdowns
> >       8418 =C4=85  3%     -21.1%       6643 =C4=85  2%  interrupts.CPU3=
.CAL:Function_call_interrupts
> >       4677 =C4=85 11%     -75.1%       1164 =C4=85 16%  interrupts.CPU3=
.TLB:TLB_shootdowns
> >       6798 =C4=85  3%     +21.8%       8284 =C4=85  7%  interrupts.CPU3=
0.CAL:Function_call_interrupts
> >       1219 =C4=85 12%    +236.3%       4102 =C4=85 30%  interrupts.CPU3=
0.TLB:TLB_shootdowns
> >       6503 =C4=85  4%     +25.9%       8186 =C4=85  6%  interrupts.CPU3=
1.CAL:Function_call_interrupts
> >       1046 =C4=85 15%    +289.1%       4072 =C4=85 32%  interrupts.CPU3=
1.TLB:TLB_shootdowns
> >       6949 =C4=85  3%     +17.2%       8141 =C4=85  8%  interrupts.CPU3=
2.CAL:Function_call_interrupts
> >       1241 =C4=85 23%    +210.6%       3854 =C4=85 34%  interrupts.CPU3=
2.TLB:TLB_shootdowns
> >       1487 =C4=85 26%    +161.6%       3889 =C4=85 46%  interrupts.CPU3=
3.TLB:TLB_shootdowns
> >       1710 =C4=85 44%    +140.1%       4105 =C4=85 36%  interrupts.CPU3=
4.TLB:TLB_shootdowns
> >       6957 =C4=85  2%     +15.2%       8012 =C4=85  9%  interrupts.CPU3=
5.CAL:Function_call_interrupts
> >       1165 =C4=85  8%    +223.1%       3765 =C4=85 38%  interrupts.CPU3=
5.TLB:TLB_shootdowns
> >       1423 =C4=85 24%    +173.4%       3892 =C4=85 33%  interrupts.CPU3=
6.TLB:TLB_shootdowns
> >       1279 =C4=85 29%    +224.2%       4148 =C4=85 39%  interrupts.CPU3=
7.TLB:TLB_shootdowns
> >       1301 =C4=85 20%    +226.1%       4244 =C4=85 35%  interrupts.CPU3=
8.TLB:TLB_shootdowns
> >       6906 =C4=85  2%     +18.5%       8181 =C4=85  8%  interrupts.CPU3=
9.CAL:Function_call_interrupts
> >     368828 =C4=85 20%     +96.2%     723710 =C4=85  7%  interrupts.CPU3=
9.RES:Rescheduling_interrupts
> >       1438 =C4=85 12%    +174.8%       3951 =C4=85 33%  interrupts.CPU3=
9.TLB:TLB_shootdowns
> >       8399 =C4=85  5%     -19.2%       6788 =C4=85  2%  interrupts.CPU4=
.CAL:Function_call_interrupts
> >       4567 =C4=85 18%     -72.7%       1245 =C4=85 28%  interrupts.CPU4=
.TLB:TLB_shootdowns
> >       6895           +22.4%       8439 =C4=85  9%  interrupts.CPU40.CAL=
:Function_call_interrupts
> >       1233 =C4=85 11%    +247.1%       4280 =C4=85 36%  interrupts.CPU4=
0.TLB:TLB_shootdowns
> >       6819 =C4=85  2%     +21.3%       8274 =C4=85  9%  interrupts.CPU4=
1.CAL:Function_call_interrupts
> >       1260 =C4=85 14%    +207.1%       3871 =C4=85 38%  interrupts.CPU4=
1.TLB:TLB_shootdowns
> >       1301 =C4=85  9%    +204.7%       3963 =C4=85 36%  interrupts.CPU4=
2.TLB:TLB_shootdowns
> >       6721 =C4=85  3%     +22.3%       8221 =C4=85  7%  interrupts.CPU4=
3.CAL:Function_call_interrupts
> >       1237 =C4=85 19%    +224.8%       4017 =C4=85 35%  interrupts.CPU4=
3.TLB:TLB_shootdowns
> >       8422 =C4=85  8%     -22.7%       6506 =C4=85  5%  interrupts.CPU4=
4.CAL:Function_call_interrupts
> >   15261375 =C4=85  7%      -7.8%   14064176        interrupts.CPU44.LOC=
:Local_timer_interrupts
> >       4376 =C4=85 25%     -75.7%       1063 =C4=85 26%  interrupts.CPU4=
4.TLB:TLB_shootdowns
> >       8451 =C4=85  5%     -23.7%       6448 =C4=85  6%  interrupts.CPU4=
5.CAL:Function_call_interrupts
> >       4351 =C4=85 18%     -74.9%       1094 =C4=85 12%  interrupts.CPU4=
5.TLB:TLB_shootdowns
> >       8705 =C4=85  6%     -21.2%       6860 =C4=85  2%  interrupts.CPU4=
6.CAL:Function_call_interrupts
> >       4787 =C4=85 20%     -69.5%       1462 =C4=85 16%  interrupts.CPU4=
6.TLB:TLB_shootdowns
> >       8334 =C4=85  3%     -18.9%       6763        interrupts.CPU47.CAL=
:Function_call_interrupts
> >       4126 =C4=85 10%     -71.3%       1186 =C4=85 18%  interrupts.CPU4=
7.TLB:TLB_shootdowns
> >       8578 =C4=85  4%     -21.7%       6713        interrupts.CPU48.CAL=
:Function_call_interrupts
> >       4520 =C4=85 15%     -74.5%       1154 =C4=85 23%  interrupts.CPU4=
8.TLB:TLB_shootdowns
> >       8450 =C4=85  8%     -18.8%       6863 =C4=85  3%  interrupts.CPU4=
9.CAL:Function_call_interrupts
> >       4494 =C4=85 24%     -66.5%       1505 =C4=85 22%  interrupts.CPU4=
9.TLB:TLB_shootdowns
> >       8307 =C4=85  4%     -18.0%       6816 =C4=85  2%  interrupts.CPU5=
.CAL:Function_call_interrupts
> >       7845           -37.4%       4908 =C4=85 34%  interrupts.CPU5.NMI:=
Non-maskable_interrupts
> >       7845           -37.4%       4908 =C4=85 34%  interrupts.CPU5.PMI:=
Performance_monitoring_interrupts
> >       4429 =C4=85 17%     -69.8%       1339 =C4=85 20%  interrupts.CPU5=
.TLB:TLB_shootdowns
> >       8444 =C4=85  4%     -21.7%       6613        interrupts.CPU50.CAL=
:Function_call_interrupts
> >       4282 =C4=85 16%     -76.0%       1029 =C4=85 17%  interrupts.CPU5=
0.TLB:TLB_shootdowns
> >       8750 =C4=85  6%     -22.2%       6803        interrupts.CPU51.CAL=
:Function_call_interrupts
> >       4755 =C4=85 20%     -73.1%       1277 =C4=85 15%  interrupts.CPU5=
1.TLB:TLB_shootdowns
> >       8478 =C4=85  6%     -20.2%       6766 =C4=85  2%  interrupts.CPU5=
2.CAL:Function_call_interrupts
> >       4337 =C4=85 20%     -72.6%       1190 =C4=85 22%  interrupts.CPU5=
2.TLB:TLB_shootdowns
> >       8604 =C4=85  7%     -21.5%       6750 =C4=85  4%  interrupts.CPU5=
3.CAL:Function_call_interrupts
> >       4649 =C4=85 17%     -74.3%       1193 =C4=85 23%  interrupts.CPU5=
3.TLB:TLB_shootdowns
> >       8317 =C4=85  9%     -19.4%       6706 =C4=85  3%  interrupts.CPU5=
4.CAL:Function_call_interrupts
> >       4372 =C4=85 12%     -75.4%       1076 =C4=85 29%  interrupts.CPU5=
4.TLB:TLB_shootdowns
> >       8439 =C4=85  3%     -18.5%       6876        interrupts.CPU55.CAL=
:Function_call_interrupts
> >       4415 =C4=85 11%     -71.6%       1254 =C4=85 17%  interrupts.CPU5=
5.TLB:TLB_shootdowns
> >       8869 =C4=85  6%     -22.6%       6864 =C4=85  2%  interrupts.CPU5=
6.CAL:Function_call_interrupts
> >     517594 =C4=85 13%    +123.3%    1155539 =C4=85 25%  interrupts.CPU5=
6.RES:Rescheduling_interrupts
> >       5085 =C4=85 22%     -74.9%       1278 =C4=85 17%  interrupts.CPU5=
6.TLB:TLB_shootdowns
> >       8682 =C4=85  4%     -21.7%       6796 =C4=85  2%  interrupts.CPU5=
7.CAL:Function_call_interrupts
> >       4808 =C4=85 19%     -74.1%       1243 =C4=85 13%  interrupts.CPU5=
7.TLB:TLB_shootdowns
> >       8626 =C4=85  7%     -21.8%       6746 =C4=85  2%  interrupts.CPU5=
8.CAL:Function_call_interrupts
> >       4816 =C4=85 20%     -79.1%       1007 =C4=85 28%  interrupts.CPU5=
8.TLB:TLB_shootdowns
> >       8759 =C4=85  8%     -20.3%       6984        interrupts.CPU59.CAL=
:Function_call_interrupts
> >       4840 =C4=85 22%     -70.6%       1423 =C4=85 14%  interrupts.CPU5=
9.TLB:TLB_shootdowns
> >       8167 =C4=85  6%     -19.0%       6615 =C4=85  2%  interrupts.CPU6=
.CAL:Function_call_interrupts
> >       4129 =C4=85 21%     -75.4%       1017 =C4=85 24%  interrupts.CPU6=
.TLB:TLB_shootdowns
> >       8910 =C4=85  4%     -23.7%       6794 =C4=85  3%  interrupts.CPU6=
0.CAL:Function_call_interrupts
> >       5017 =C4=85 12%     -77.8%       1113 =C4=85 15%  interrupts.CPU6=
0.TLB:TLB_shootdowns
> >       8689 =C4=85  5%     -21.6%       6808        interrupts.CPU61.CAL=
:Function_call_interrupts
> >       4715 =C4=85 20%     -77.6%       1055 =C4=85 19%  interrupts.CPU6=
1.TLB:TLB_shootdowns
> >       8574 =C4=85  4%     -18.9%       6953 =C4=85  2%  interrupts.CPU6=
2.CAL:Function_call_interrupts
> >       4494 =C4=85 17%     -72.3%       1244 =C4=85  7%  interrupts.CPU6=
2.TLB:TLB_shootdowns
> >       8865 =C4=85  3%     -25.4%       6614 =C4=85  7%  interrupts.CPU6=
3.CAL:Function_call_interrupts
> >       4870 =C4=85 12%     -76.8%       1130 =C4=85 12%  interrupts.CPU6=
3.TLB:TLB_shootdowns
> >       8724 =C4=85  7%     -20.2%       6958 =C4=85  3%  interrupts.CPU6=
4.CAL:Function_call_interrupts
> >       4736 =C4=85 16%     -72.6%       1295 =C4=85  7%  interrupts.CPU6=
4.TLB:TLB_shootdowns
> >       8717 =C4=85  6%     -23.7%       6653 =C4=85  4%  interrupts.CPU6=
5.CAL:Function_call_interrupts
> >       4626 =C4=85 19%     -76.5%       1087 =C4=85 21%  interrupts.CPU6=
5.TLB:TLB_shootdowns
> >       6671           +24.7%       8318 =C4=85  9%  interrupts.CPU66.CAL=
:Function_call_interrupts
> >       1091 =C4=85  8%    +249.8%       3819 =C4=85 32%  interrupts.CPU6=
6.TLB:TLB_shootdowns
> >       6795 =C4=85  2%     +26.9%       8624 =C4=85  9%  interrupts.CPU6=
7.CAL:Function_call_interrupts
> >       1098 =C4=85 24%    +299.5%       4388 =C4=85 39%  interrupts.CPU6=
7.TLB:TLB_shootdowns
> >       6704 =C4=85  5%     +25.8%       8431 =C4=85  8%  interrupts.CPU6=
8.CAL:Function_call_interrupts
> >       1214 =C4=85 15%    +236.1%       4083 =C4=85 36%  interrupts.CPU6=
8.TLB:TLB_shootdowns
> >       1049 =C4=85 15%    +326.2%       4473 =C4=85 33%  interrupts.CPU6=
9.TLB:TLB_shootdowns
> >       8554 =C4=85  6%     -19.6%       6874 =C4=85  2%  interrupts.CPU7=
.CAL:Function_call_interrupts
> >       4753 =C4=85 19%     -71.7%       1344 =C4=85 16%  interrupts.CPU7=
.TLB:TLB_shootdowns
> >       1298 =C4=85 13%    +227.4%       4249 =C4=85 38%  interrupts.CPU7=
0.TLB:TLB_shootdowns
> >       6976           +19.9%       8362 =C4=85  7%  interrupts.CPU71.CAL=
:Function_call_interrupts
> >    1232748 =C4=85 18%     -57.3%     525824 =C4=85 33%  interrupts.CPU7=
1.RES:Rescheduling_interrupts
> >       1253 =C4=85  9%    +211.8%       3909 =C4=85 31%  interrupts.CPU7=
1.TLB:TLB_shootdowns
> >       1316 =C4=85 22%    +188.7%       3800 =C4=85 33%  interrupts.CPU7=
2.TLB:TLB_shootdowns
> >       6665 =C4=85  5%     +26.5%       8429 =C4=85  8%  interrupts.CPU7=
3.CAL:Function_call_interrupts
> >       1202 =C4=85 13%    +234.1%       4017 =C4=85 37%  interrupts.CPU7=
3.TLB:TLB_shootdowns
> >       6639 =C4=85  5%     +27.0%       8434 =C4=85  8%  interrupts.CPU7=
4.CAL:Function_call_interrupts
> >       1079 =C4=85 16%    +269.4%       3986 =C4=85 36%  interrupts.CPU7=
4.TLB:TLB_shootdowns
> >       1055 =C4=85 12%    +301.2%       4235 =C4=85 34%  interrupts.CPU7=
5.TLB:TLB_shootdowns
> >       7011 =C4=85  3%     +21.6%       8522 =C4=85  8%  interrupts.CPU7=
6.CAL:Function_call_interrupts
> >       1223 =C4=85 13%    +230.7%       4047 =C4=85 35%  interrupts.CPU7=
6.TLB:TLB_shootdowns
> >       6886 =C4=85  7%     +25.6%       8652 =C4=85 10%  interrupts.CPU7=
7.CAL:Function_call_interrupts
> >       1316 =C4=85 16%    +229.8%       4339 =C4=85 36%  interrupts.CPU7=
7.TLB:TLB_shootdowns
> >       7343 =C4=85  5%     +19.1%       8743 =C4=85  9%  interrupts.CPU7=
8.CAL:Function_call_interrupts
> >       1699 =C4=85 37%    +144.4%       4152 =C4=85 31%  interrupts.CPU7=
8.TLB:TLB_shootdowns
> >       7136 =C4=85  4%     +21.4%       8666 =C4=85  9%  interrupts.CPU7=
9.CAL:Function_call_interrupts
> >       1094 =C4=85 13%    +276.2%       4118 =C4=85 34%  interrupts.CPU7=
9.TLB:TLB_shootdowns
> >       8531 =C4=85  5%     -19.5%       6869 =C4=85  2%  interrupts.CPU8=
.CAL:Function_call_interrupts
> >       4764 =C4=85 16%     -71.0%       1382 =C4=85 14%  interrupts.CPU8=
.TLB:TLB_shootdowns
> >       1387 =C4=85 29%    +181.8%       3910 =C4=85 38%  interrupts.CPU8=
0.TLB:TLB_shootdowns
> >       1114 =C4=85 30%    +259.7%       4007 =C4=85 36%  interrupts.CPU8=
1.TLB:TLB_shootdowns
> >       7012           +23.9%       8685 =C4=85  8%  interrupts.CPU82.CAL=
:Function_call_interrupts
> >       1274 =C4=85 12%    +255.4%       4530 =C4=85 27%  interrupts.CPU8=
2.TLB:TLB_shootdowns
> >       6971 =C4=85  3%     +23.8%       8628 =C4=85  9%  interrupts.CPU8=
3.CAL:Function_call_interrupts
> >       1156 =C4=85 18%    +260.1%       4162 =C4=85 34%  interrupts.CPU8=
3.TLB:TLB_shootdowns
> >       7030 =C4=85  4%     +21.0%       8504 =C4=85  8%  interrupts.CPU8=
4.CAL:Function_call_interrupts
> >       1286 =C4=85 23%    +224.0%       4166 =C4=85 31%  interrupts.CPU8=
4.TLB:TLB_shootdowns
> >       7059           +22.4%       8644 =C4=85 11%  interrupts.CPU85.CAL=
:Function_call_interrupts
> >       1421 =C4=85 22%    +208.8%       4388 =C4=85 33%  interrupts.CPU8=
5.TLB:TLB_shootdowns
> >       7018 =C4=85  2%     +22.8%       8615 =C4=85  9%  interrupts.CPU8=
6.CAL:Function_call_interrupts
> >       1258 =C4=85  8%    +231.1%       4167 =C4=85 34%  interrupts.CPU8=
6.TLB:TLB_shootdowns
> >       1338 =C4=85  3%    +217.9%       4255 =C4=85 31%  interrupts.CPU8=
7.TLB:TLB_shootdowns
> >       8376 =C4=85  4%     -19.0%       6787 =C4=85  2%  interrupts.CPU9=
.CAL:Function_call_interrupts
> >       4466 =C4=85 17%     -71.2%       1286 =C4=85 18%  interrupts.CPU9=
.TLB:TLB_shootdowns
> >
> >
> >
> >
> >
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are pr=
ovided
> > for informational purposes only. Any difference in system hardware or s=
oftware
> > design or configuration may affect actual performance.
> >
> >
> > Thanks,
> > Oliver Sang
> >
