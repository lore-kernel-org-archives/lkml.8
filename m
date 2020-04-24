Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CB5C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10614206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2O+y6zN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgDXPRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbgDXPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:17:10 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAECC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:17:09 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so10328002ljn.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UzSiuWlgHjMkOm2QUjnD2KrsqUjNBNsjYveKdxY0/BI=;
        b=K2O+y6zNnvaRCG0ifsvgrzfVDwcVm+NTxDYlLHuNaey/9NM/0/yLL0VgH5n7yg8SX/
         no4CTq7f4mqWV9pADQ0x8m8bn8A0uDymWeYSuOir3vDAFDbhzDhaaaMH4GheXFaqml1S
         B+9JZPyECMxRBzU1jKbvWNgI+/492OJSt7q+9s+T6x97PDptSkOZTEGRgH56emdZrVPa
         jvdHw5aPWVhzoNcwL5n+vEcVi7sO8lal5/zUVndJup37Htj+WynlvTx0j/Y9AfxqvghQ
         QexHvnIPbhPvpNjhqIhFIMkD1uAV7blToxC0M9HBBzN9vvDEGgZbDTNNeaRKgnxRoNyA
         Z64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UzSiuWlgHjMkOm2QUjnD2KrsqUjNBNsjYveKdxY0/BI=;
        b=FBTg7OsO7cvIWNYuPeC1INqO2zP7ZtA8gLmfpzZCFWRbPSY33voBA+hemroQAYol/t
         lTEWVTKgSuWXVdcI653dSL9Bf4+88yMaJASnOSZ4DXayqRBMVOGMp0Zk3wgdgxINWRmD
         g5+tbQkbTtcw0WrSvFsKqoDqDCTaNE+D3ulPIQOAHYq9dKdbuvq/zsEEaZkk1ed3W4Dn
         yWNsgxjv53IyzJUebAJw2Whb+t2JZynahZ2c//qiA2sQzf9lMTrsmEPUKaXypwTiYEnc
         6MNyJyv6wSoDLQthGKt3JBflplIywqWouLsKaxtg8VxbrGKzuRTf0YW1r29LeuR7Maqq
         jKUg==
X-Gm-Message-State: AGi0Pub4ka33s3NLfMTs3yqsHgbcoizwUElmobEVQolkcB/I3r7/7Iyf
        Ox2/qsr23ZpbRpX/r8cGWPwom4CqAY67Paw9y4/6dw==
X-Google-Smtp-Source: APiQypJo3FNkBSS73QEYT5Xo14k9ZdCwKs2Ud7kQ8FJrRM5Zq5VQYPfoajf7AijiO0+VbpF0VqgZ++z45z8jXxdb5Qk=
X-Received: by 2002:a2e:3209:: with SMTP id y9mr5873597ljy.154.1587741427614;
 Fri, 24 Apr 2020 08:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200421004749.GC26573@shao2-debian> <74c86b02-bf93-db33-dbea-9b1934c3c9ab@linux.intel.com>
In-Reply-To: <74c86b02-bf93-db33-dbea-9b1934c3c9ab@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 24 Apr 2020 17:16:55 +0200
Message-ID: <CAKfTPtB0QdvFHC6VSyMZjy=k+9ZBA7Z4=7GjUGE2stu-5czzkw@mail.gmail.com>
Subject: Re: [LKP] Re: [sched/fair] 6c8116c914: stress-ng.mmapfork.ops_per_sec
 -38.0% regression
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Tao Zhou <ouwen210@hotmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xing,

On Fri, 24 Apr 2020 at 10:15, Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
>
> Hi Tao,
>
>     Do you have time to take a look at this? Thanks.

I have tried to reproduce the regression on my systems which are Arm
ones but I can't see such regression on small 8 cores and large 224
cores/2 numa nodes

I have only run the mmapfork test to shorten the duration of my tests

Regards,
Vincent
>
> On 4/21/2020 8:47 AM, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed a 56.4% improvement of stress-ng.fifo.ops_per_sec due t=
o commit:
> >
> >
> > commit: 6c8116c914b65be5e4d6f66d69c8142eb0648c22 ("sched/fair: Fix cond=
ition of avg_load calculation")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: stress-ng
> > on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz w=
ith 128G memory
> > with following parameters:
> >
> >       nr_threads: 100%
> >       disk: 1HDD
> >       testtime: 1s
> >       class: scheduler
> >       cpufreq_governor: performance
> >       ucode: 0xb000038
> >       sc_pid_max: 4194304
> >
> >
> > In addition to that, the commit also has significant impact on the foll=
owing tests:
> >
> > +------------------+---------------------------------------------------=
-------------------+
> > | testcase: change | stress-ng: stress-ng.mmapfork.ops_per_sec -19.2% r=
egression          |
> > | test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GH=
z with 192G memory |
> > | test parameters  | class=3Dvm                                        =
                     |
> > |                  | cpufreq_governor=3Dperformance                    =
                     |
> > |                  | disk=3D1HDD                                       =
                     |
> > |                  | fs=3Dext4                                         =
                     |
> > |                  | nr_threads=3D10%                                  =
                     |
> > |                  | testtime=3D1s                                     =
                     |
> > |                  | ucode=3D0x500002c                                 =
                     |
> > +------------------+---------------------------------------------------=
-------------------+
> >
> >
> >
> >
> > Details are as below:
> > -----------------------------------------------------------------------=
--------------------------->
> >
> >
> > To reproduce:
> >
> >          git clone https://github.com/intel/lkp-tests.git
> >          cd lkp-tests
> >          bin/lkp install job.yaml  # job file is attached in this email
> >          bin/lkp run     job.yaml
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/sc_pid_m=
ax/tbox_group/testcase/testtime/ucode:
> >    scheduler/gcc-7/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-=
20191114.cgz/4194304/lkp-bdw-ep6/stress-ng/1s/0xb000038
> >
> > commit:
> >    e94f80f6c4 ("sched/rt: cpupri_find: Trigger a full search as fallbac=
k")
> >    6c8116c914 ("sched/fair: Fix condition of avg_load calculation")
> >
> > e94f80f6c4902000 6c8116c914b65be5e4d6f66d69c
> > ---------------- ---------------------------
> >         fail:runs  %reproduction    fail:runs
> >             |             |             |
> >             :4           25%           1:4     dmesg.WARNING:at#for_ip_=
interrupt_entry/0x
> >             :4           25%           1:4     dmesg.WARNING:at_ip___pe=
rf_sw_event/0x
> >             :4           25%           1:4     dmesg.WARNING:at_ip__sla=
b_free/0x
> >           %stddev     %change         %stddev
> >               \          |                \
> >     3986602 =C2=B1 12%     +56.5%    6237290 =C2=B1 11%  stress-ng.fifo=
.ops
> >     3982065 =C2=B1 12%     +56.4%    6228889 =C2=B1 11%  stress-ng.fifo=
.ops_per_sec
> >       20066 =C2=B1  5%      -9.0%      18250 =C2=B1  5%  stress-ng.fork=
.ops
> >       20043 =C2=B1  5%      -9.0%      18239 =C2=B1  6%  stress-ng.fork=
.ops_per_sec
> >       29.08 =C2=B1  2%     -38.0%      18.01        stress-ng.mmapfork.=
ops_per_sec
> >        2200            +3.8%       2284        stress-ng.time.system_ti=
me
> >    19775571 =C2=B1 12%     +28.2%   25357609 =C2=B1  6%  numa-numastat.=
node1.local_node
> >    19843883 =C2=B1 12%     +28.1%   25427059 =C2=B1  6%  numa-numastat.=
node1.numa_hit
> >        4489 =C2=B1 15%     -21.5%       3523 =C2=B1  3%  sched_debug.cf=
s_rq:/.runnable_avg.max
> >      929.25           -12.0%     818.19 =C2=B1  7%  sched_debug.cfs_rq:=
/.runnable_avg.stddev
> >        1449 =C2=B1 26%     -25.8%       1075 =C2=B1  5%  sched_debug.cf=
s_rq:/.util_avg.max
> >       28692            +9.2%      31327 =C2=B1  5%  softirqs.CPU44.TIME=
R
> >       22999 =C2=B1  3%     +13.7%      26141 =C2=B1  6%  softirqs.CPU56=
.RCU
> >       28464 =C2=B1  4%      +9.9%      31279 =C2=B1  6%  softirqs.CPU56=
.TIMER
> >       30.25 =C2=B1  2%      -6.6%      28.25        vmstat.cpu.id
> >       60.00            +4.6%      62.75        vmstat.cpu.sy
> >     2526959 =C2=B1  3%     +69.1%    4273296 =C2=B1  2%  vmstat.memory.=
cache
> >      371.25 =C2=B1  9%     +27.1%     472.00 =C2=B1  5%  vmstat.procs.r
> >       30.16 =C2=B1  3%      -6.0%      28.35 =C2=B1  2%  iostat.cpu.idl=
e
> >       60.99            +3.6%      63.22        iostat.cpu.system
> >        8.39 =C2=B1  2%      -4.9%       7.98        iostat.cpu.user
> >        3.10 =C2=B1173%    -100.0%       0.00        iostat.sdc.await.ma=
x
> >        3.10 =C2=B1173%    -100.0%       0.00        iostat.sdc.r_await.=
max
> >        1082 =C2=B1  9%     +11.4%       1206 =C2=B1  4%  slabinfo.kmall=
oc-128.active_slabs
> >       34667 =C2=B1  9%     +11.3%      38602 =C2=B1  4%  slabinfo.kmall=
oc-128.num_objs
> >        1082 =C2=B1  9%     +11.4%       1206 =C2=B1  4%  slabinfo.kmall=
oc-128.num_slabs
> >      454.50 =C2=B1 11%     +21.0%     549.75 =C2=B1 22%  slabinfo.kmall=
oc-192.active_slabs
> >       19110 =C2=B1 10%     +20.9%      23108 =C2=B1 22%  slabinfo.kmall=
oc-192.num_objs
> >      454.50 =C2=B1 11%     +21.0%     549.75 =C2=B1 22%  slabinfo.kmall=
oc-192.num_slabs
> >      106621            -7.8%      98257 =C2=B1  5%  slabinfo.kmalloc-32=
.active_objs
> >       37329 =C2=B1  3%     +20.6%      45034        slabinfo.radix_tree=
_node.active_objs
> >      706.25 =C2=B1  3%     +24.5%     879.25        slabinfo.radix_tree=
_node.active_slabs
> >       39573 =C2=B1  3%     +24.5%      49252        slabinfo.radix_tree=
_node.num_objs
> >      706.25 =C2=B1  3%     +24.5%     879.25        slabinfo.radix_tree=
_node.num_slabs
> >     1318829 =C2=B1  8%     +49.7%    1974635 =C2=B1 10%  meminfo.Active
> >     1318549 =C2=B1  8%     +49.7%    1974352 =C2=B1 10%  meminfo.Active=
(anon)
> >      723296 =C2=B1 17%     +41.1%    1020590 =C2=B1 15%  meminfo.AnonHu=
gePages
> >      905050 =C2=B1 11%     +40.9%    1274793 =C2=B1 16%  meminfo.AnonPa=
ges
> >     2271966 =C2=B1  3%     +83.7%    4173221        meminfo.Cached
> >    62076918 =C2=B1  3%     +12.6%   69917857 =C2=B1  5%  meminfo.Commit=
ted_AS
> >      815680 =C2=B1  7%    +198.4%    2434139 =C2=B1  2%  meminfo.Inacti=
ve
> >      815324 =C2=B1  7%    +198.5%    2433786 =C2=B1  2%  meminfo.Inacti=
ve(anon)
> >      840619 =C2=B1  7%    +192.4%    2457795 =C2=B1  2%  meminfo.Mapped
> >     4535703 =C2=B1  4%     +51.0%    6849231 =C2=B1  3%  meminfo.Memuse=
d
> >       66386 =C2=B1  5%     +20.2%      79763 =C2=B1  4%  meminfo.PageTa=
bles
> >     1210719 =C2=B1  5%    +157.1%    3112278 =C2=B1  2%  meminfo.Shmem
> >      509312 =C2=B1  6%     +75.4%     893498        meminfo.max_used_kB
> >      323591 =C2=B1  5%     +48.3%     479732 =C2=B1 10%  proc-vmstat.nr=
_active_anon
> >      225088 =C2=B1  9%     +40.2%     315590 =C2=B1 14%  proc-vmstat.nr=
_anon_pages
> >      362.50 =C2=B1 16%     +35.7%     492.00 =C2=B1 14%  proc-vmstat.nr=
_anon_transparent_hugepages
> >     3164981            -1.8%    3108432        proc-vmstat.nr_dirty_bac=
kground_threshold
> >     6337701            -1.8%    6224466        proc-vmstat.nr_dirty_thr=
eshold
> >      562051 =C2=B1  3%     +82.2%    1023916 =C2=B1  2%  proc-vmstat.nr=
_file_pages
> >    31851080            -1.8%   31284538        proc-vmstat.nr_free_page=
s
> >      201936 =C2=B1  8%    +196.7%     599169 =C2=B1  3%  proc-vmstat.nr=
_inactive_anon
> >      208366 =C2=B1  8%    +190.5%     605371 =C2=B1  3%  proc-vmstat.nr=
_mapped
> >       16350 =C2=B1  3%     +24.7%      20391 =C2=B1  7%  proc-vmstat.nr=
_page_table_pages
> >      296735 =C2=B1  6%    +155.7%     758662 =C2=B1  3%  proc-vmstat.nr=
_shmem
> >      323592 =C2=B1  5%     +48.3%     479731 =C2=B1 10%  proc-vmstat.nr=
_zone_active_anon
> >      201936 =C2=B1  8%    +196.7%     599168 =C2=B1  3%  proc-vmstat.nr=
_zone_inactive_anon
> >    14509555 =C2=B1  2%      +6.5%   15449984        proc-vmstat.pgactiv=
ate
> >      565861 =C2=B1 54%     -93.7%      35832 =C2=B1 28%  numa-meminfo.n=
ode0.Inactive
> >      565602 =C2=B1 54%     -93.7%      35573 =C2=B1 28%  numa-meminfo.n=
ode0.Inactive(anon)
> >      583972 =C2=B1 52%     -91.4%      50225 =C2=B1 20%  numa-meminfo.n=
ode0.Mapped
> >      627138 =C2=B1 20%    +131.7%    1453311 =C2=B1  9%  numa-meminfo.n=
ode1.Active
> >      627070 =C2=B1 20%    +131.8%    1453285 =C2=B1  9%  numa-meminfo.n=
ode1.Active(anon)
> >      327555 =C2=B1 17%    +109.1%     684899 =C2=B1  9%  numa-meminfo.n=
ode1.AnonHugePages
> >      460420 =C2=B1 11%     +76.5%     812769 =C2=B1 16%  numa-meminfo.n=
ode1.AnonPages
> >      968393 =C2=B1 45%    +265.8%    3542629 =C2=B1  3%  numa-meminfo.n=
ode1.FilePages
> >      270293 =C2=B1115%    +784.7%    2391349 =C2=B1  3%  numa-meminfo.n=
ode1.Inactive
> >      270196 =C2=B1116%    +785.0%    2391255 =C2=B1  3%  numa-meminfo.n=
ode1.Inactive(anon)
> >       94282 =C2=B1  6%     +14.1%     107588 =C2=B1  4%  numa-meminfo.n=
ode1.KReclaimable
> >      277310 =C2=B1113%    +765.8%    2401026 =C2=B1  2%  numa-meminfo.n=
ode1.Mapped
> >     2101472 =C2=B1 20%    +143.0%    5106156 =C2=B1  3%  numa-meminfo.n=
ode1.MemUsed
> >       30839 =C2=B1 14%     +75.9%      54240 =C2=B1  5%  numa-meminfo.n=
ode1.PageTables
> >       94282 =C2=B1  6%     +14.1%     107588 =C2=B1  4%  numa-meminfo.n=
ode1.SReclaimable
> >      428801 =C2=B1102%    +603.2%    3015356 =C2=B1  3%  numa-meminfo.n=
ode1.Shmem
> >      319011 =C2=B1 32%     -53.5%     148357 =C2=B1  3%  numa-vmstat.no=
de0.nr_file_pages
> >      136650 =C2=B1 54%     -90.3%      13199 =C2=B1 47%  numa-vmstat.no=
de0.nr_inactive_anon
> >      141251 =C2=B1 52%     -88.0%      16942 =C2=B1 37%  numa-vmstat.no=
de0.nr_mapped
> >        9345 =C2=B1 15%     -29.0%       6638 =C2=B1  9%  numa-vmstat.no=
de0.nr_page_table_pages
> >      188582 =C2=B1 54%     -92.1%      14926 =C2=B1 42%  numa-vmstat.no=
de0.nr_shmem
> >      136645 =C2=B1 54%     -90.3%      13189 =C2=B1 47%  numa-vmstat.no=
de0.nr_zone_inactive_anon
> >    11178939 =C2=B1  9%     -17.1%    9271727 =C2=B1  7%  numa-vmstat.no=
de0.numa_hit
> >    10982245 =C2=B1  9%     -17.1%    9101421 =C2=B1  7%  numa-vmstat.no=
de0.numa_local
> >      158792 =C2=B1 23%    +130.0%     365220 =C2=B1 12%  numa-vmstat.no=
de1.nr_active_anon
> >      114790 =C2=B1 11%     +76.4%     202539 =C2=B1 17%  numa-vmstat.no=
de1.nr_anon_pages
> >      160.50 =C2=B1 19%    +107.3%     332.75 =C2=B1  9%  numa-vmstat.no=
de1.nr_anon_transparent_hugepages
> >      244507 =C2=B1 46%    +262.7%     886783 =C2=B1  2%  numa-vmstat.no=
de1.nr_file_pages
> >       68248 =C2=B1122%    +773.8%     596360        numa-vmstat.node1.n=
r_inactive_anon
> >       70043 =C2=B1119%    +755.1%     598917        numa-vmstat.node1.n=
r_mapped
> >        8117 =C2=B1 22%     +66.1%      13481 =C2=B1  3%  numa-vmstat.no=
de1.nr_page_table_pages
> >      109596 =C2=B1104%    +588.9%     754961 =C2=B1  3%  numa-vmstat.no=
de1.nr_shmem
> >       23655 =C2=B1  7%     +13.4%      26828 =C2=B1  4%  numa-vmstat.no=
de1.nr_slab_reclaimable
> >      158794 =C2=B1 23%    +130.0%     365223 =C2=B1 12%  numa-vmstat.no=
de1.nr_zone_active_anon
> >       68248 =C2=B1122%    +773.8%     596359        numa-vmstat.node1.n=
r_zone_inactive_anon
> >    10597757 =C2=B1  6%     +31.0%   13877833 =C2=B1  2%  numa-vmstat.no=
de1.numa_hit
> >    10518704 =C2=B1  6%     +30.8%   13763501 =C2=B1  3%  numa-vmstat.no=
de1.numa_local
> >      130.75 =C2=B1 26%     -78.4%      28.25 =C2=B1 11%  interrupts.36:=
IR-PCI-MSI.1572867-edge.eth0-TxRx-2
> >      454956 =C2=B1 13%     -45.1%     249594 =C2=B1 38%  interrupts.CPU=
14.LOC:Local_timer_interrupts
> >       17625 =C2=B1 28%     +80.2%      31751 =C2=B1 37%  interrupts.CPU=
14.RES:Rescheduling_interrupts
> >      130.75 =C2=B1 26%     -78.4%      28.25 =C2=B1 11%  interrupts.CPU=
15.36:IR-PCI-MSI.1572867-edge.eth0-TxRx-2
> >      263948 =C2=B1 23%     -25.7%     196017 =C2=B1  2%  interrupts.CPU=
15.LOC:Local_timer_interrupts
> >      425840 =C2=B1 19%     -53.7%     197051 =C2=B1  4%  interrupts.CPU=
17.LOC:Local_timer_interrupts
> >       44187 =C2=B1 27%     -53.8%      20406 =C2=B1 39%  interrupts.CPU=
18.RES:Rescheduling_interrupts
> >        2400 =C2=B1149%     -91.2%     211.50 =C2=B1143%  interrupts.CPU=
2.IWI:IRQ_work_interrupts
> >      432176 =C2=B1 16%     -51.2%     211015 =C2=B1  9%  interrupts.CPU=
2.LOC:Local_timer_interrupts
> >      444388 =C2=B1 20%     -44.4%     246924 =C2=B1 34%  interrupts.CPU=
20.LOC:Local_timer_interrupts
> >        1763 =C2=B1 11%     +31.8%       2324 =C2=B1 13%  interrupts.CPU=
25.TLB:TLB_shootdowns
> >      428063 =C2=B1  7%     -33.9%     282779 =C2=B1 33%  interrupts.CPU=
27.LOC:Local_timer_interrupts
> >       19879 =C2=B1 66%     +94.7%      38706 =C2=B1 47%  interrupts.CPU=
29.RES:Rescheduling_interrupts
> >        1459 =C2=B1 17%     +62.3%       2369 =C2=B1 22%  interrupts.CPU=
32.TLB:TLB_shootdowns
> >        1593 =C2=B1 17%     +35.2%       2154 =C2=B1 15%  interrupts.CPU=
33.TLB:TLB_shootdowns
> >        1388 =C2=B1 21%     +57.5%       2185 =C2=B1 19%  interrupts.CPU=
34.TLB:TLB_shootdowns
> >       44877 =C2=B1 50%     -52.3%      21390 =C2=B1 19%  interrupts.CPU=
36.RES:Rescheduling_interrupts
> >        6002 =C2=B1 35%     -34.7%       3920 =C2=B1  8%  interrupts.CPU=
37.CAL:Function_call_interrupts
> >      519.00 =C2=B1159%     -95.2%      24.75 =C2=B1 51%  interrupts.CPU=
4.IWI:IRQ_work_interrupts
> >      371753 =C2=B1 25%     -46.6%     198407 =C2=B1  6%  interrupts.CPU=
4.LOC:Local_timer_interrupts
> >        1490 =C2=B1 19%     +42.9%       2130 =C2=B1  7%  interrupts.CPU=
41.TLB:TLB_shootdowns
> >        6738 =C2=B1 41%     -34.0%       4449 =C2=B1 19%  interrupts.CPU=
45.CAL:Function_call_interrupts
> >        1145 =C2=B1124%     -82.6%     199.25 =C2=B1153%  interrupts.CPU=
46.IWI:IRQ_work_interrupts
> >      275.75 =C2=B1141%     -94.2%      16.00 =C2=B1 84%  interrupts.CPU=
48.IWI:IRQ_work_interrupts
> >      310.00 =C2=B1134%     -93.1%      21.25 =C2=B1103%  interrupts.CPU=
49.IWI:IRQ_work_interrupts
> >      463385 =C2=B1  3%     -57.3%     197853 =C2=B1  6%  interrupts.CPU=
49.LOC:Local_timer_interrupts
> >        7206 =C2=B1 33%     -36.7%       4558 =C2=B1 10%  interrupts.CPU=
5.CAL:Function_call_interrupts
> >      264579 =C2=B1 13%     -24.5%     199834 =C2=B1  2%  interrupts.CPU=
5.LOC:Local_timer_interrupts
> >        5463 =C2=B1 14%     -26.3%       4025 =C2=B1 11%  interrupts.CPU=
50.CAL:Function_call_interrupts
> >        7063 =C2=B1 31%     -41.3%       4147 =C2=B1 13%  interrupts.CPU=
54.CAL:Function_call_interrupts
> >      287711 =C2=B1 25%     -31.7%     196499 =C2=B1  6%  interrupts.CPU=
55.LOC:Local_timer_interrupts
> >      415854 =C2=B1  8%     -41.4%     243719 =C2=B1 33%  interrupts.CPU=
57.LOC:Local_timer_interrupts
> >      324710 =C2=B1 32%     -38.3%     200427 =C2=B1 11%  interrupts.CPU=
6.LOC:Local_timer_interrupts
> >      343106 =C2=B1 32%     -27.0%     250512 =C2=B1 35%  interrupts.CPU=
61.LOC:Local_timer_interrupts
> >      395834 =C2=B1 19%     -49.0%     201844 =C2=B1 17%  interrupts.CPU=
63.LOC:Local_timer_interrupts
> >      483611 =C2=B1 24%     -48.4%     249593 =C2=B1 31%  interrupts.CPU=
64.LOC:Local_timer_interrupts
> >        1885 =C2=B1 13%     +37.5%       2591 =C2=B1 23%  interrupts.CPU=
69.TLB:TLB_shootdowns
> >      382720 =C2=B1 33%     -38.5%     235483 =C2=B1 34%  interrupts.CPU=
7.LOC:Local_timer_interrupts
> >        1437 =C2=B1 11%     +37.1%       1970 =C2=B1 16%  interrupts.CPU=
70.TLB:TLB_shootdowns
> >        3844 =C2=B1 34%     +64.2%       6312 =C2=B1  2%  interrupts.CPU=
71.NMI:Non-maskable_interrupts
> >        3844 =C2=B1 34%     +64.2%       6312 =C2=B1  2%  interrupts.CPU=
71.PMI:Performance_monitoring_interrupts
> >       54451 =C2=B1 37%     -65.6%      18725 =C2=B1 51%  interrupts.CPU=
71.RES:Rescheduling_interrupts
> >        1710 =C2=B1  6%     +27.2%       2176 =C2=B1 10%  interrupts.CPU=
72.TLB:TLB_shootdowns
> >      350141 =C2=B1 20%     -32.6%     236073 =C2=B1 29%  interrupts.CPU=
74.LOC:Local_timer_interrupts
> >        1172 =C2=B1 18%     +80.1%       2112 =C2=B1 10%  interrupts.CPU=
76.TLB:TLB_shootdowns
> >       59169 =C2=B1 36%     -56.0%      26026 =C2=B1 56%  interrupts.CPU=
84.RES:Rescheduling_interrupts
> >      409027 =C2=B1 39%     -41.4%     239528 =C2=B1 25%  interrupts.CPU=
86.LOC:Local_timer_interrupts
> >        1543 =C2=B1 14%     +24.6%       1922 =C2=B1  9%  interrupts.CPU=
86.TLB:TLB_shootdowns
> >        8.71 =C2=B1  7%      -3.8        4.92 =C2=B1 23%  perf-profile.c=
alltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_writ=
e.ksys_write
> >        8.66 =C2=B1  7%      -3.8        4.89 =C2=B1 23%  perf-profile.c=
alltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sy=
nc_write.vfs_write
> >        8.61 =C2=B1  7%      -3.8        4.84 =C2=B1 23%  perf-profile.c=
alltrace.cycles-pp.pollwake.__wake_up_common.__wake_up_common_lock.pipe_wri=
te.new_sync_write
> >        8.60 =C2=B1  7%      -3.8        4.83 =C2=B1 23%  perf-profile.c=
alltrace.cycles-pp.try_to_wake_up.pollwake.__wake_up_common.__wake_up_commo=
n_lock.pipe_write
> >       10.58 =C2=B1  4%      -3.7        6.87 =C2=B1 17%  perf-profile.c=
alltrace.cycles-pp._raw_spin_lock_irqsave.__account_scheduler_latency.enque=
ue_entity.enqueue_task_fair.activate_task
> >       10.46 =C2=B1  5%      -3.7        6.77 =C2=B1 17%  perf-profile.c=
alltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.=
__account_scheduler_latency.enqueue_entity.enqueue_task_fair
> >       11.46 =C2=B1  4%      -3.6        7.81 =C2=B1 14%  perf-profile.c=
alltrace.cycles-pp.__account_scheduler_latency.enqueue_entity.enqueue_task_=
fair.activate_task.ttwu_do_activate
> >       11.71 =C2=B1  4%      -3.6        8.07 =C2=B1 13%  perf-profile.c=
alltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_a=
ctivate.try_to_wake_up
> >        8.92 =C2=B1  7%      -3.6        5.31 =C2=B1 22%  perf-profile.c=
alltrace.cycles-pp.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscal=
l_64
> >        9.02 =C2=B1  7%      -3.6        5.42 =C2=B1 22%  perf-profile.c=
alltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_=
SYSCALL_64_after_hwframe
> >        7.95 =C2=B1  6%      -3.6        4.36 =C2=B1 23%  perf-profile.c=
alltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.pollwake._=
_wake_up_common
> >        7.95 =C2=B1  6%      -3.6        4.36 =C2=B1 23%  perf-profile.c=
alltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.pollwake.__wake_up_commo=
n.__wake_up_common_lock
> >        7.94 =C2=B1  6%      -3.6        4.36 =C2=B1 23%  perf-profile.c=
alltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_=
wake_up.pollwake
> >       14.89 =C2=B1  4%      -3.6       11.31 =C2=B1 10%  perf-profile.c=
alltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe.__GI___libc_write
> >       14.94 =C2=B1  4%      -3.6       11.37 =C2=B1 10%  perf-profile.c=
alltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.=
__GI___libc_write
> >       15.40 =C2=B1  3%      -3.4       12.01 =C2=B1 10%  perf-profile.c=
alltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc=
_write
> >       15.42 =C2=B1  3%      -3.4       12.04 =C2=B1 10%  perf-profile.c=
alltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_write
> >       15.70 =C2=B1  3%      -3.3       12.39 =C2=B1 10%  perf-profile.c=
alltrace.cycles-pp.__GI___libc_write
> >        4.89 =C2=B1 13%      -2.0        2.94 =C2=B1 25%  perf-profile.c=
alltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fsnotify=
_add_event.fanotify_handle_event.fsnotify
> >        1.67 =C2=B1 23%      -0.6        1.11 =C2=B1 10%  perf-profile.c=
alltrace.cycles-pp._raw_spin_lock.fsnotify_add_event.fanotify_handle_event.=
fsnotify.do_sys_openat2
> >        1.98 =C2=B1  8%      -0.5        1.50 =C2=B1 10%  perf-profile.c=
alltrace.cycles-pp._raw_spin_lock.fsnotify_add_event.fanotify_handle_event.=
fsnotify.__fput
> >        2.54 =C2=B1  3%      -0.4        2.14 =C2=B1  7%  perf-profile.c=
alltrace.cycles-pp.fsnotify_add_event.fanotify_handle_event.fsnotify.__fput=
.task_work_run
> >        0.66 =C2=B1  9%      -0.4        0.27 =C2=B1100%  perf-profile.c=
alltrace.cycles-pp._raw_spin_lock.fsnotify_add_event.fanotify_handle_event.=
fsnotify.vfs_read
> >        2.84            -0.3        2.55 =C2=B1  6%  perf-profile.calltr=
ace.cycles-pp.fsnotify_add_event.fanotify_handle_event.fsnotify.do_sys_open=
at2.do_sys_open
> >        2.83 =C2=B1  2%      -0.3        2.56 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.fanotify_handle_event.fsnotify.__fput.task_work_run.exit=
_to_usermode_loop
> >        0.69 =C2=B1  5%      -0.3        0.43 =C2=B1 58%  perf-profile.c=
alltrace.cycles-pp._raw_spin_lock.fsnotify_add_event.fanotify_handle_event.=
fsnotify.vfs_write
> >        2.91 =C2=B1  2%      -0.3        2.65 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.fsnotify.__fput.task_work_run.exit_to_usermode_loop.do_s=
yscall_64
> >        7.23            -0.2        6.99        perf-profile.calltrace.c=
ycles-pp.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYS=
CALL_64_after_hwframe
> >        3.10            -0.2        2.90 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.fanotify_handle_event.fsnotify.do_sys_openat2.do_sys_open.do_=
syscall_64
> >        0.94 =C2=B1  8%      -0.1        0.80 =C2=B1  3%  perf-profile.c=
alltrace.cycles-pp.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain.unma=
p_region.__do_munmap
> >        0.95 =C2=B1  8%      -0.1        0.82 =C2=B1  3%  perf-profile.c=
alltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.unmap_region.__do_munmap=
.__vm_munmap
> >        0.77 =C2=B1 10%      -0.1        0.64 =C2=B1  5%  perf-profile.c=
alltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.=
pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain
> >        0.79 =C2=B1 10%      -0.1        0.66 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_add_drain=
_cpu.lru_add_drain.unmap_region
> >        0.95 =C2=B1  8%      -0.1        0.82 =C2=B1  3%  perf-profile.c=
alltrace.cycles-pp.lru_add_drain.unmap_region.__do_munmap.__vm_munmap.__x64=
_sys_munmap
> >        0.87 =C2=B1  3%      -0.1        0.75 =C2=B1  6%  perf-profile.c=
alltrace.cycles-pp.fsnotify_add_event.fanotify_handle_event.fsnotify.vfs_re=
ad.ksys_read
> >        0.85 =C2=B1  3%      -0.1        0.74 =C2=B1  8%  perf-profile.c=
alltrace.cycles-pp.fsnotify_add_event.fanotify_handle_event.fsnotify.vfs_wr=
ite.ksys_write
> >        1.25 =C2=B1  6%      -0.1        1.14 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap.do=
_syscall_64
> >        4.21            -0.1        4.10        perf-profile.calltrace.c=
ycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64=
_after_hwframe.__GI___libc_close
> >        4.27            -0.1        4.16        perf-profile.calltrace.c=
ycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe=
.__GI___libc_close
> >        1.35 =C2=B1  5%      -0.1        1.25 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hw=
frame.munmap
> >        1.33 =C2=B1  5%      -0.1        1.23 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.e=
ntry_SYSCALL_64_after_hwframe
> >        1.34 =C2=B1  5%      -0.1        1.24 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL=
_64_after_hwframe.munmap
> >        1.85            -0.1        1.75 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secon=
dary_startup_64
> >        0.97 =C2=B1  2%      -0.1        0.89 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.fanotify_handle_event.fsnotify.vfs_read.ksys_read.do_sys=
call_64
> >        1.02 =C2=B1  2%      -0.1        0.96 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.fsnotify.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_=
64_after_hwframe
> >        0.86 =C2=B1  8%      +0.1        0.96 =C2=B1  5%  perf-profile.c=
alltrace.cycles-pp.copy_page_range.dup_mm.copy_process._do_fork.__x64_sys_c=
lone
> >        0.85 =C2=B1  7%      +0.1        0.95 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mm.copy_process._do_f=
ork
> >        0.66 =C2=B1  5%      +0.1        0.79 =C2=B1 12%  perf-profile.c=
alltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.__alloc=
_file.alloc_empty_file.dentry_open
> >        0.69 =C2=B1  4%      +0.1        0.82 =C2=B1 11%  perf-profile.c=
alltrace.cycles-pp.security_file_alloc.__alloc_file.alloc_empty_file.dentry=
_open.fanotify_read
> >        0.67 =C2=B1  4%      +0.1        0.81 =C2=B1 13%  perf-profile.c=
alltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.ta=
sk_work_run.exit_to_usermode_loop
> >        0.68 =C2=B1  5%      +0.1        0.82 =C2=B1 12%  perf-profile.c=
alltrace.cycles-pp.security_file_free.__fput.task_work_run.exit_to_usermode=
_loop.do_syscall_64
> >        0.30 =C2=B1100%      +0.4        0.67 =C2=B1  5%  perf-profile.c=
alltrace.cycles-pp.fanotify_merge.fsnotify_add_event.fanotify_handle_event.=
fsnotify.do_sys_openat2
> >        5.06 =C2=B1  3%      +0.5        5.55 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.__GI___libc_read
> >        5.11 =C2=B1  3%      +0.5        5.60 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe._=
_GI___libc_read
> >        5.53 =C2=B1  3%      +0.7        6.22 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc=
_read
> >        5.55 =C2=B1  3%      +0.7        6.24 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_read
> >        5.87 =C2=B1  3%      +0.8        6.66 =C2=B1  3%  perf-profile.c=
alltrace.cycles-pp.__GI___libc_read
> >        2.06            +2.0        4.05 =C2=B1 71%  perf-profile.calltr=
ace.cycles-pp.page_fault
> >        2.00            +2.0        3.99 =C2=B1 72%  perf-profile.calltr=
ace.cycles-pp.do_page_fault.page_fault
> >        1.72            +2.0        3.73 =C2=B1 78%  perf-profile.calltr=
ace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_page_fault.page_fault
> >        1.77            +2.0        3.78 =C2=B1 77%  perf-profile.calltr=
ace.cycles-pp.handle_mm_fault.do_page_fault.page_fault
> >       30.85 =C2=B1  2%      -5.8       25.06 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.native_queued_spin_lock_slowpath
> >       16.38 =C2=B1  4%      -4.0       12.35 =C2=B1 10%  perf-profile.c=
hildren.cycles-pp.try_to_wake_up
> >       14.81 =C2=B1  3%      -3.9       10.96 =C2=B1 11%  perf-profile.c=
hildren.cycles-pp._raw_spin_lock_irqsave
> >        9.39 =C2=B1  6%      -3.8        5.57 =C2=B1 20%  perf-profile.c=
hildren.cycles-pp.__wake_up_common_lock
> >        8.72 =C2=B1  7%      -3.8        4.90 =C2=B1 23%  perf-profile.c=
hildren.cycles-pp.pollwake
> >       13.03 =C2=B1  4%      -3.8        9.24 =C2=B1 12%  perf-profile.c=
hildren.cycles-pp.enqueue_task_fair
> >       13.03 =C2=B1  4%      -3.8        9.26 =C2=B1 12%  perf-profile.c=
hildren.cycles-pp.ttwu_do_activate
> >       13.05 =C2=B1  4%      -3.8        9.28 =C2=B1 12%  perf-profile.c=
hildren.cycles-pp.activate_task
> >       12.34 =C2=B1  4%      -3.8        8.58 =C2=B1 13%  perf-profile.c=
hildren.cycles-pp.__account_scheduler_latency
> >       12.75 =C2=B1  4%      -3.7        9.00 =C2=B1 12%  perf-profile.c=
hildren.cycles-pp.enqueue_entity
> >       13.76 =C2=B1  4%      -3.7       10.04 =C2=B1 11%  perf-profile.c=
hildren.cycles-pp.__wake_up_common
> >        8.93 =C2=B1  7%      -3.6        5.31 =C2=B1 22%  perf-profile.c=
hildren.cycles-pp.pipe_write
> >        9.30 =C2=B1  6%      -3.6        5.72 =C2=B1 20%  perf-profile.c=
hildren.cycles-pp.new_sync_write
> >       15.09 =C2=B1  3%      -3.5       11.57 =C2=B1 10%  perf-profile.c=
hildren.cycles-pp.ksys_write
> >       15.26 =C2=B1  3%      -3.5       11.75 =C2=B1  9%  perf-profile.c=
hildren.cycles-pp.vfs_write
> >       15.80 =C2=B1  3%      -3.3       12.55 =C2=B1 10%  perf-profile.c=
hildren.cycles-pp.__GI___libc_write
> >       77.73            -3.0       74.69 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.do_syscall_64
> >       77.85            -3.0       74.83 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.entry_SYSCALL_64_after_hwframe
> >       17.37 =C2=B1  4%      -1.7       15.68 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp._raw_spin_lock
> >        6.95 =C2=B1  5%      -1.2        5.79 =C2=B1 26%  perf-profile.c=
hildren.cycles-pp.rwsem_down_write_slowpath
> >        6.87 =C2=B1  5%      -1.2        5.71 =C2=B1 26%  perf-profile.c=
hildren.cycles-pp.rwsem_optimistic_spin
> >        7.29 =C2=B1  2%      -1.0        6.33 =C2=B1  6%  perf-profile.c=
hildren.cycles-pp.fsnotify_add_event
> >        8.05            -0.6        7.42 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.fanotify_handle_event
> >        8.41            -0.6        7.84 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.fsnotify
> >        7.33            -0.3        7.08        perf-profile.children.cy=
cles-pp.__fput
> >        7.76            -0.2        7.51        perf-profile.children.cy=
cles-pp.exit_to_usermode_loop
> >        1.01 =C2=B1  7%      -0.1        0.88 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.lru_add_drain
> >        0.96 =C2=B1  7%      -0.1        0.83 =C2=B1  5%  perf-profile.c=
hildren.cycles-pp.__pagevec_release
> >        1.03 =C2=B1  7%      -0.1        0.91 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.lru_add_drain_cpu
> >        1.02 =C2=B1  7%      -0.1        0.90 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.pagevec_lru_move_fn
> >        1.46 =C2=B1  6%      -0.1        1.35 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.unmap_region
> >        1.87            -0.1        1.78 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.schedule_idle
> >        1.49 =C2=B1  5%      -0.1        1.40        perf-profile.childr=
en.cycles-pp.__x64_sys_munmap
> >        0.58 =C2=B1 11%      -0.1        0.52 =C2=B1 12%  perf-profile.c=
hildren.cycles-pp.load_balance
> >        0.60 =C2=B1  5%      -0.1        0.54 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.truncate_inode_pages_range
> >        0.11 =C2=B1  3%      -0.0        0.10 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.seq_show
> >        0.11 =C2=B1  3%      -0.0        0.10 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.seq_printf
> >        0.11            -0.0        0.10 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.seq_vprintf
> >        0.09 =C2=B1  4%      +0.0        0.11 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.__check_object_size
> >        0.09 =C2=B1  4%      +0.0        0.11 =C2=B1 11%  perf-profile.c=
hildren.cycles-pp.current_time
> >        0.25 =C2=B1  2%      +0.0        0.27 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.update_process_times
> >        0.29 =C2=B1  4%      +0.0        0.31 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.generic_file_write_iter
> >        0.31 =C2=B1  3%      +0.0        0.33        perf-profile.childr=
en.cycles-pp.new_inode_pseudo
> >        0.18 =C2=B1  5%      +0.0        0.21 =C2=B1  6%  perf-profile.c=
hildren.cycles-pp.__might_sleep
> >        0.34 =C2=B1  4%      +0.0        0.38 =C2=B1  6%  perf-profile.c=
hildren.cycles-pp.do_wp_page
> >        0.01 =C2=B1173%      +0.0        0.06 =C2=B1 16%  perf-profile.c=
hildren.cycles-pp.icmp_sk_exit
> >        0.30 =C2=B1  4%      +0.0        0.35 =C2=B1  9%  perf-profile.c=
hildren.cycles-pp.wp_page_copy
> >        0.22 =C2=B1  3%      +0.0        0.27 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.fput_many
> >        0.60 =C2=B1  5%      +0.1        0.66 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.rcu_core
> >        0.23 =C2=B1  4%      +0.1        0.28 =C2=B1  9%  perf-profile.c=
hildren.cycles-pp.__pte_alloc
> >        0.45 =C2=B1  6%      +0.1        0.51 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.pte_alloc_one
> >        0.23 =C2=B1 12%      +0.1        0.29 =C2=B1 16%  perf-profile.c=
hildren.cycles-pp.cleanup_net
> >        0.42 =C2=B1  6%      +0.1        0.48 =C2=B1  8%  perf-profile.c=
hildren.cycles-pp.prep_new_page
> >        0.39 =C2=B1  6%      +0.1        0.45 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.memset_erms
> >        0.76 =C2=B1  2%      +0.1        0.83 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.kmem_cache_alloc
> >        0.23 =C2=B1 19%      +0.1        0.31        perf-profile.childr=
en.cycles-pp.path_put
> >        0.73 =C2=B1  3%      +0.1        0.81 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.__softirqentry_text_start
> >        0.22 =C2=B1 13%      +0.1        0.32 =C2=B1 14%  perf-profile.c=
hildren.cycles-pp.put_pid
> >        0.47 =C2=B1  8%      +0.1        0.57 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.___might_sleep
> >        0.68 =C2=B1  4%      +0.1        0.79 =C2=B1  6%  perf-profile.c=
hildren.cycles-pp.get_page_from_freelist
> >        0.76 =C2=B1  4%      +0.1        0.87 =C2=B1  5%  perf-profile.c=
hildren.cycles-pp.__alloc_pages_nodemask
> >        0.35 =C2=B1  4%      +0.1        0.48 =C2=B1 11%  perf-profile.c=
hildren.cycles-pp.fanotify_alloc_event
> >        0.79 =C2=B1  4%      +0.1        0.92 =C2=B1  9%  perf-profile.c=
hildren.cycles-pp.apparmor_file_alloc_security
> >        0.86 =C2=B1  3%      +0.1        0.99 =C2=B1  9%  perf-profile.c=
hildren.cycles-pp.security_file_alloc
> >        1.30 =C2=B1  3%      +0.1        1.45 =C2=B1  7%  perf-profile.c=
hildren.cycles-pp.__alloc_file
> >        0.85 =C2=B1  6%      +0.1        1.00 =C2=B1  6%  perf-profile.c=
hildren.cycles-pp.syscall_return_via_sysret
> >        0.73 =C2=B1  4%      +0.1        0.88 =C2=B1 12%  perf-profile.c=
hildren.cycles-pp.security_file_free
> >        0.72 =C2=B1  4%      +0.2        0.87 =C2=B1 12%  perf-profile.c=
hildren.cycles-pp.apparmor_file_free_security
> >        1.32 =C2=B1  3%      +0.2        1.47 =C2=B1  7%  perf-profile.c=
hildren.cycles-pp.alloc_empty_file
> >        1.29 =C2=B1  5%      +0.2        1.45 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.copy_page_range
> >        1.26 =C2=B1  4%      +0.2        1.41 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.copy_p4d_range
> >        0.46 =C2=B1 17%      +0.2        0.64 =C2=B1  7%  perf-profile.c=
hildren.cycles-pp.fanotify_free_event
> >        1.45 =C2=B1 24%      +0.4        1.90 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.fanotify_merge
> >        5.23 =C2=B1  2%      +0.5        5.70 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.vfs_read
> >        5.24 =C2=B1  2%      +0.5        5.72 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.ksys_read
> >        5.90 =C2=B1  3%      +0.8        6.69 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.__GI___libc_read
> >        2.83 =C2=B1  2%      +2.0        4.79 =C2=B1 59%  perf-profile.c=
hildren.cycles-pp.page_fault
> >        2.69 =C2=B1  2%      +2.0        4.66 =C2=B1 61%  perf-profile.c=
hildren.cycles-pp.do_page_fault
> >       30.71            -5.8       24.94 =C2=B1  4%  perf-profile.self.c=
ycles-pp.native_queued_spin_lock_slowpath
> >        0.09            +0.0        0.11 =C2=B1 12%  perf-profile.self.c=
ycles-pp.vma_interval_tree_remove
> >        0.10            +0.0        0.12 =C2=B1 13%  perf-profile.self.c=
ycles-pp.__rb_insert_augmented
> >        0.13 =C2=B1  5%      +0.0        0.15 =C2=B1  7%  perf-profile.s=
elf.cycles-pp.entry_SYSCALL_64_after_hwframe
> >        0.15 =C2=B1  4%      +0.0        0.18 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.fput_many
> >        0.28            +0.0        0.32 =C2=B1  3%  perf-profile.self.c=
ycles-pp.kmem_cache_alloc
> >        0.14 =C2=B1  9%      +0.0        0.19 =C2=B1  5%  perf-profile.s=
elf.cycles-pp.fanotify_alloc_event
> >        0.19 =C2=B1  3%      +0.0        0.24 =C2=B1 21%  perf-profile.s=
elf.cycles-pp.anon_vma_clone
> >        0.31 =C2=B1 10%      +0.1        0.37 =C2=B1  4%  perf-profile.s=
elf.cycles-pp.fsnotify
> >        0.38 =C2=B1  7%      +0.1        0.43        perf-profile.self.c=
ycles-pp.memset_erms
> >        0.21 =C2=B1 13%      +0.1        0.30 =C2=B1 14%  perf-profile.s=
elf.cycles-pp.put_pid
> >        0.68 =C2=B1  5%      +0.1        0.78 =C2=B1  5%  perf-profile.s=
elf.cycles-pp._raw_spin_lock_irqsave
> >        0.45 =C2=B1  8%      +0.1        0.55 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.___might_sleep
> >        0.77 =C2=B1  4%      +0.1        0.89 =C2=B1 10%  perf-profile.s=
elf.cycles-pp.apparmor_file_alloc_security
> >        0.99 =C2=B1  4%      +0.1        1.12 =C2=B1  2%  perf-profile.s=
elf.cycles-pp._raw_spin_lock
> >        0.85 =C2=B1  6%      +0.1        1.00 =C2=B1  6%  perf-profile.s=
elf.cycles-pp.syscall_return_via_sysret
> >        0.71 =C2=B1  4%      +0.1        0.86 =C2=B1 11%  perf-profile.s=
elf.cycles-pp.apparmor_file_free_security
> >        1.44 =C2=B1 23%      +0.4        1.88 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.fanotify_merge
> >
> >
> >
> >                           stress-ng.mmapfork.ops_per_sec
> >
> >    36 +----------------------------------------------------------------=
------+
> >    34 |-+      +                                                       =
      |
> >       |       + :             +..           +     +                    =
      |
> >    32 |..+.. +  :            +             : :   : :    +..+..         =
      |
> >    30 |-+   +    :          +    +..  .+.. :  :  :  :  +              .=
+..   |
> >       |          :  .+..  .+        +.    +   : :   : +       +..+..+. =
   +..|
> >    28 |-+         +.    +.                     +     +                 =
      |
> >    26 |-+                                                              =
      |
> >    24 |-+                                                              =
      |
> >       |                                                                =
      |
> >    22 |-+                                                              =
      |
> >    20 |-+               O                                              =
      |
> >       |  O  O  O  O  O                    O O  O  O  O     O     O     =
      |
> >    18 |-+                  O  O  O  O  O                O     O        =
      |
> >    16 +----------------------------------------------------------------=
------+
> >
> >
> > [*] bisect-good sample
> > [O] bisect-bad  sample
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
> >    vm/gcc-7/performance/1HDD/ext4/x86_64-rhel-7.6/10%/debian-x86_64-201=
91114.cgz/lkp-csl-2sp5/stress-ng/1s/0x500002c
> >
> > commit:
> >    e94f80f6c4 ("sched/rt: cpupri_find: Trigger a full search as fallbac=
k")
> >    6c8116c914 ("sched/fair: Fix condition of avg_load calculation")
> >
> > e94f80f6c4902000 6c8116c914b65be5e4d6f66d69c
> > ---------------- ---------------------------
> >         fail:runs  %reproduction    fail:runs
> >             |             |             |
> >             :4           50%           2:4     dmesg.WARNING:at_ip_nati=
ve_sched_clock/0x
> >            1:4          -25%            :4     kmsg.Memory_failure:#:re=
covery_action_for_clean_LRU_page:Recovered
> >             :4           25%           1:4     kmsg.Memory_failure:#:re=
covery_action_for_high-order_kernel_page:Ignored
> >            1:4          -25%            :4     kmsg.Memory_failure:#:re=
covery_action_for_reserved_kernel_page:Failed
> >            1:4          -25%            :4     kmsg.Memory_failure:#:re=
served_kernel_page_still_referenced_by#users
> >            0:4           15%           1:4     perf-profile.calltrace.c=
ycles-pp.error_entry
> >            2:4           -9%           1:4     perf-profile.children.cy=
cles-pp.error_entry
> >            0:4           -2%           0:4     perf-profile.self.cycles=
-pp.error_entry
> >           %stddev     %change         %stddev
> >               \          |                \
> >        1.45 =C2=B1  4%     -19.2%       1.17        stress-ng.mmapfork.=
ops_per_sec
> >       34.69            +3.8%      36.02        stress-ng.time.elapsed_t=
ime
> >       34.69            +3.8%      36.02        stress-ng.time.elapsed_t=
ime.max
> >       25456 =C2=B1  3%     +61.0%      40992        stress-ng.time.invo=
luntary_context_switches
> >    48979390            -1.7%   48167776        stress-ng.time.minor_pag=
e_faults
> >        2216            +8.6%       2407        stress-ng.time.percent_o=
f_cpu_this_job_got
> >      678.84           +13.8%     772.64        stress-ng.time.system_ti=
me
> >       90.09 =C2=B1  2%      +5.1%      94.70        stress-ng.time.user=
_time
> >     3736135            -8.1%    3432912 =C2=B1  4%  stress-ng.vm-splice=
.ops
> >     3736645            -8.1%    3433013 =C2=B1  4%  stress-ng.vm-splice=
.ops_per_sec
> >       22.94            +2.9       25.82        mpstat.cpu.all.sys%
> >       64068           +20.9%      77445        slabinfo.radix_tree_node=
.active_objs
> >        1191           +24.5%       1483        slabinfo.radix_tree_node=
.active_slabs
> >       66763           +24.5%      83089        slabinfo.radix_tree_node=
.num_objs
> >        1191           +24.5%       1483        slabinfo.radix_tree_node=
.num_slabs
> >       13465 =C2=B1  5%      -7.5%      12458 =C2=B1  4%  softirqs.CPU54=
.RCU
> >       21991 =C2=B1  9%     -12.2%      19314 =C2=B1  2%  softirqs.CPU67=
.TIMER
> >       18381 =C2=B1  3%     +15.7%      21272 =C2=B1 11%  softirqs.CPU78=
.TIMER
> >       19718 =C2=B1  5%      -6.2%      18501 =C2=B1  6%  softirqs.CPU85=
.TIMER
> >       75.25            -4.3%      72.00        vmstat.cpu.id
> >     7158306           +55.5%   11133290        vmstat.memory.cache
> >       41.00           +21.1%      49.67        vmstat.procs.r
> >      164992            -2.7%     160484        vmstat.system.cs
> >        5119 =C2=B1 27%     +26.0%       6449        sched_debug.cfs_rq:=
/.min_vruntime.min
> >       40.68 =C2=B1 43%     -44.2%      22.70 =C2=B1 56%  sched_debug.cf=
s_rq:/.removed.load_avg.avg
> >      193.17 =C2=B1 22%     -25.4%     144.08 =C2=B1 27%  sched_debug.cf=
s_rq:/.removed.load_avg.stddev
> >       40.68 =C2=B1 43%     -44.2%      22.70 =C2=B1 56%  sched_debug.cf=
s_rq:/.removed.runnable_avg.avg
> >      193.17 =C2=B1 22%     -25.4%     144.08 =C2=B1 27%  sched_debug.cf=
s_rq:/.removed.runnable_avg.stddev
> >       75.65            -3.8%      72.79        iostat.cpu.idle
> >       21.71           +12.9%      24.51        iostat.cpu.system
> >        3.38 =C2=B1173%    -100.0%       0.00        iostat.sdb.avgqu-sz=
.max
> >       55.24 =C2=B1173%    -100.0%       0.00        iostat.sdb.await.ma=
x
> >        7.86 =C2=B1173%    -100.0%       0.00        iostat.sdb.r_await.=
max
> >        0.50 =C2=B1173%    -100.0%       0.00        iostat.sdb.svctm.ma=
x
> >       73.58 =C2=B1173%    -100.0%       0.00        iostat.sdb.w_await.=
max
> >     3441402           +37.0%    4713857 =C2=B1  2%  meminfo.Active
> >     3435631           +37.0%    4708095 =C2=B1  2%  meminfo.Active(anon=
)
> >     7080694 =C2=B1  2%     +57.1%   11123426        meminfo.Cached
> >    15441325           +16.2%   17935592        meminfo.Committed_AS
> >     4095008 =C2=B1  2%     +64.3%    6730005        meminfo.Inactive
> >     4091903 =C2=B1  2%     +64.4%    6726722        meminfo.Inactive(an=
on)
> >     3878376 =C2=B1  2%     +68.4%    6532231        meminfo.Mapped
> >     9729489           +40.4%   13657740        meminfo.Memused
> >       24152 =C2=B1  2%     +27.3%      30748        meminfo.PageTables
> >     5975926 =C2=B1  2%     +67.6%   10018605        meminfo.Shmem
> >     1449016           +34.8%    1953751        meminfo.max_used_kB
> >      858313           +36.8%    1173864 =C2=B1  2%  proc-vmstat.nr_acti=
ve_anon
> >      406781            -8.2%     373619 =C2=B1  2%  proc-vmstat.nr_anon=
_pages
> >     4645359            -2.1%    4548445        proc-vmstat.nr_dirty_bac=
kground_threshold
> >     9302077            -2.1%    9108013        proc-vmstat.nr_dirty_thr=
eshold
> >     1771956           +56.2%    2768047        proc-vmstat.nr_file_page=
s
> >    46738540            -2.1%   45771374        proc-vmstat.nr_free_page=
s
> >     1030382 =C2=B1  2%     +62.8%    1677583        proc-vmstat.nr_inac=
tive_anon
> >      975596 =C2=B1  2%     +67.0%    1628805        proc-vmstat.nr_mapp=
ed
> >       15306 =C2=B1  2%      -4.8%      14573 =C2=B1  4%  proc-vmstat.nr=
_mlock
> >        6053           +26.9%       7682        proc-vmstat.nr_page_tabl=
e_pages
> >     1495457 =C2=B1  2%     +66.6%    2491556        proc-vmstat.nr_shme=
m
> >       28335            +7.4%      30444        proc-vmstat.nr_slab_recl=
aimable
> >      858313           +36.8%    1173863 =C2=B1  2%  proc-vmstat.nr_zone=
_active_anon
> >     1030382 =C2=B1  2%     +62.8%    1677583        proc-vmstat.nr_zone=
_inactive_anon
> >       44230 =C2=B1  7%     +38.1%      61075 =C2=B1  6%  proc-vmstat.nu=
ma_pages_migrated
> >       44230 =C2=B1  7%     +38.1%      61075 =C2=B1  6%  proc-vmstat.pg=
migrate_success
> >       21392 =C2=B1  7%     +17.8%      25205 =C2=B1  3%  interrupts.CPU=
1.CAL:Function_call_interrupts
> >       29824 =C2=B1  8%     +60.3%      47813 =C2=B1 16%  interrupts.CPU=
1.TLB:TLB_shootdowns
> >       93.75 =C2=B1 22%    +298.6%     373.67 =C2=B1 34%  interrupts.CPU=
10.RES:Rescheduling_interrupts
> >       28425 =C2=B1  9%     +35.6%      38542 =C2=B1 10%  interrupts.CPU=
10.TLB:TLB_shootdowns
> >       28648 =C2=B1  9%     +21.9%      34913 =C2=B1  9%  interrupts.CPU=
11.TLB:TLB_shootdowns
> >       20812 =C2=B1 10%     +15.8%      24090 =C2=B1  3%  interrupts.CPU=
12.CAL:Function_call_interrupts
> >       28668 =C2=B1 11%     +35.8%      38941 =C2=B1 13%  interrupts.CPU=
12.TLB:TLB_shootdowns
> >       97.50 =C2=B1 18%    +205.3%     297.67 =C2=B1 43%  interrupts.CPU=
14.RES:Rescheduling_interrupts
> >      152.00 =C2=B1 77%    +627.0%       1105 =C2=B1 81%  interrupts.CPU=
15.RES:Rescheduling_interrupts
> >       30393 =C2=B1 12%     +43.5%      43611 =C2=B1 19%  interrupts.CPU=
15.TLB:TLB_shootdowns
> >       20253 =C2=B1  5%     +18.7%      24046 =C2=B1  4%  interrupts.CPU=
18.CAL:Function_call_interrupts
> >       19382 =C2=B1 14%     +26.8%      24576 =C2=B1  8%  interrupts.CPU=
19.CAL:Function_call_interrupts
> >       26649 =C2=B1 12%     +57.4%      41941 =C2=B1 18%  interrupts.CPU=
19.TLB:TLB_shootdowns
> >       30299 =C2=B1  9%     +38.1%      41829 =C2=B1 20%  interrupts.CPU=
22.TLB:TLB_shootdowns
> >       43754 =C2=B1 18%     -37.5%      27337 =C2=B1  2%  interrupts.CPU=
25.TLB:TLB_shootdowns
> >       40282 =C2=B1 31%     -27.2%      29321 =C2=B1 18%  interrupts.CPU=
26.TLB:TLB_shootdowns
> >      524.75 =C2=B1 52%     -62.3%     198.00 =C2=B1 57%  interrupts.CPU=
27.RES:Rescheduling_interrupts
> >      381.25 =C2=B1 53%     -45.1%     209.33 =C2=B1102%  interrupts.CPU=
30.RES:Rescheduling_interrupts
> >      224.00 =C2=B1 84%     -54.9%     101.00 =C2=B1 54%  interrupts.CPU=
35.RES:Rescheduling_interrupts
> >       39260 =C2=B1 29%     -33.2%      26214 =C2=B1 25%  interrupts.CPU=
36.TLB:TLB_shootdowns
> >       20901 =C2=B1 11%     +13.9%      23801 =C2=B1  4%  interrupts.CPU=
4.CAL:Function_call_interrupts
> >       29418 =C2=B1 11%     -13.1%      25571 =C2=B1  6%  interrupts.CPU=
40.TLB:TLB_shootdowns
> >       22467 =C2=B1  6%     -21.6%      17610 =C2=B1 10%  interrupts.CPU=
43.CAL:Function_call_interrupts
> >       20028 =C2=B1  9%     +20.9%      24219 =C2=B1  7%  interrupts.CPU=
47.CAL:Function_call_interrupts
> >       28186 =C2=B1 10%     +33.3%      37576 =C2=B1 21%  interrupts.CPU=
47.TLB:TLB_shootdowns
> >       20503 =C2=B1  4%     +15.4%      23664 =C2=B1  3%  interrupts.CPU=
49.CAL:Function_call_interrupts
> >       29724 =C2=B1  6%     +44.8%      43046 =C2=B1 34%  interrupts.CPU=
52.TLB:TLB_shootdowns
> >       20812 =C2=B1  6%     +23.5%      25710 =C2=B1  2%  interrupts.CPU=
53.CAL:Function_call_interrupts
> >       28228 =C2=B1  7%     +25.4%      35402 =C2=B1  3%  interrupts.CPU=
53.TLB:TLB_shootdowns
> >       30617 =C2=B1  5%     +13.0%      34602 =C2=B1  5%  interrupts.CPU=
56.TLB:TLB_shootdowns
> >       28393 =C2=B1  9%     +14.2%      32419 =C2=B1  4%  interrupts.CPU=
59.TLB:TLB_shootdowns
> >       26886 =C2=B1 14%     +33.6%      35911 =C2=B1 17%  interrupts.CPU=
6.TLB:TLB_shootdowns
> >        3607 =C2=B1 30%     -71.4%       1031 =C2=B1 40%  interrupts.CPU=
60.NMI:Non-maskable_interrupts
> >        3607 =C2=B1 30%     -71.4%       1031 =C2=B1 40%  interrupts.CPU=
60.PMI:Performance_monitoring_interrupts
> >       20497 =C2=B1  7%     +17.8%      24149 =C2=B1  6%  interrupts.CPU=
61.CAL:Function_call_interrupts
> >       28713 =C2=B1 11%     +29.1%      37066 =C2=B1 14%  interrupts.CPU=
61.TLB:TLB_shootdowns
> >       20400 =C2=B1  2%     +17.9%      24051 =C2=B1  3%  interrupts.CPU=
63.CAL:Function_call_interrupts
> >       28404 =C2=B1  2%     +36.6%      38793 =C2=B1 21%  interrupts.CPU=
63.TLB:TLB_shootdowns
> >      332.50 =C2=B1 74%     -84.0%      53.33 =C2=B1 39%  interrupts.CPU=
88.RES:Rescheduling_interrupts
> >       55727 =C2=B1 23%     -47.1%      29476 =C2=B1  9%  interrupts.CPU=
91.TLB:TLB_shootdowns
> >       41957 =C2=B1 29%     -42.7%      24035 =C2=B1  6%  interrupts.CPU=
92.TLB:TLB_shootdowns
> >      516.25 =C2=B1 57%     -83.0%      88.00 =C2=B1 65%  interrupts.CPU=
93.RES:Rescheduling_interrupts
> >       21481 =C2=B1  6%     -17.5%      17720 =C2=B1  9%  interrupts.CPU=
95.CAL:Function_call_interrupts
> >       43882 =C2=B1 33%     -45.1%      24079 =C2=B1 10%  interrupts.CPU=
95.TLB:TLB_shootdowns
> >       34.47 =C2=B1 18%      -7.4       27.02 =C2=B1  3%  perf-profile.c=
alltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu=
_startup_entry
> >       36.75 =C2=B1 16%      -7.2       29.55 =C2=B1  3%  perf-profile.c=
alltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_en=
try.start_secondary
> >       36.91 =C2=B1 15%      -7.1       29.79 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.=
secondary_startup_64
> >       37.86 =C2=B1 14%      -6.7       31.20 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_star=
tup_64
> >       37.86 =C2=B1 14%      -6.6       31.21 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
> >       37.86 =C2=B1 14%      -6.6       31.21 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.start_secondary.secondary_startup_64
> >       38.16 =C2=B1 15%      -6.5       31.62 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.secondary_startup_64
> >        0.61 =C2=B1  9%      +0.1        0.69 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.tlb_finish_mmu.zap_page_range.do_madvise.__x64_sys_madvi=
se.do_syscall_64
> >        0.84 =C2=B1  5%      +0.1        0.93 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.clear_page_erms.prep_new_page.get_page_from_freelist.__a=
lloc_pages_nodemask.alloc_pages_vma
> >        0.93 =C2=B1  4%      +0.1        1.03 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.mem_cgroup_try_charge.mem_cgroup_try_charge_delay.handle=
_pte_fault.__handle_mm_fault.handle_mm_fault
> >        1.13 =C2=B1  5%      +0.1        1.26 =C2=B1  3%  perf-profile.c=
alltrace.cycles-pp.mem_cgroup_try_charge_delay.handle_pte_fault.__handle_mm=
_fault.handle_mm_fault.do_page_fault
> >        1.17 =C2=B1  6%      +0.1        1.30 =C2=B1  3%  perf-profile.c=
alltrace.cycles-pp.prep_new_page.get_page_from_freelist.__alloc_pages_nodem=
ask.alloc_pages_vma.handle_pte_fault
> >        1.55 =C2=B1  2%      +0.1        1.70 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp._raw_spin_lock.handle_pte_fault.__handle_mm_fault.handle=
_mm_fault.do_page_fault
> >        0.92 =C2=B1 13%      +0.2        1.09 =C2=B1  5%  perf-profile.c=
alltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_in=
terrupt.cpuidle_enter_state.cpuidle_enter
> >        1.63 =C2=B1  6%      +0.2        1.83 =C2=B1  3%  perf-profile.c=
alltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.alloc_page=
s_vma.handle_pte_fault.__handle_mm_fault
> >        1.75 =C2=B1  6%      +0.2        1.96 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.__alloc_pages_nodemask.alloc_pages_vma.handle_pte_fault.=
__handle_mm_fault.handle_mm_fault
> >        1.86 =C2=B1  6%      +0.2        2.08 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.alloc_pages_vma.handle_pte_fault.__handle_mm_fault.handl=
e_mm_fault.do_page_fault
> >        2.01 =C2=B1  9%      +0.3        2.28 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.d=
o_idle.cpu_startup_entry
> >        0.28 =C2=B1100%      +0.3        0.58 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.do_brk_flags.__x64_sys_brk.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe.brk
> >        0.28 =C2=B1100%      +0.3        0.59 =C2=B1  5%  perf-profile.c=
alltrace.cycles-pp.flush_tlb_mm_range.tlb_flush_mmu.tlb_finish_mmu.zap_page=
_range.do_madvise
> >        0.81 =C2=B1  8%      +0.4        1.17 =C2=B1 16%  perf-profile.c=
alltrace.cycles-pp.release_pages.__pagevec_release.shmem_undo_range.shmem_t=
runcate_range.shmem_evict_inode
> >        0.82 =C2=B1  8%      +0.4        1.17 =C2=B1 17%  perf-profile.c=
alltrace.cycles-pp.__pagevec_release.shmem_undo_range.shmem_truncate_range.=
shmem_evict_inode.evict
> >        2.18 =C2=B1  4%      +0.4        2.57        perf-profile.calltr=
ace.cycles-pp.release_pages.tlb_flush_mmu.unmap_page_range.unmap_vmas.exit_=
mmap
> >        2.22 =C2=B1  4%      +0.4        2.62        perf-profile.calltr=
ace.cycles-pp.tlb_flush_mmu.unmap_page_range.unmap_vmas.exit_mmap.mmput
> >        2.35 =C2=B1  8%      +0.4        2.77 =C2=B1  6%  perf-profile.c=
alltrace.cycles-pp.get_signal.do_signal.exit_to_usermode_loop.prepare_exit_=
to_usermode.swapgs_restore_regs_and_return_to_usermode
> >        2.34 =C2=B1  8%      +0.4        2.76 =C2=B1  6%  perf-profile.c=
alltrace.cycles-pp.do_group_exit.get_signal.do_signal.exit_to_usermode_loop=
.prepare_exit_to_usermode
> >        2.36 =C2=B1  8%      +0.4        2.78 =C2=B1  7%  perf-profile.c=
alltrace.cycles-pp.do_signal.exit_to_usermode_loop.prepare_exit_to_usermode=
.swapgs_restore_regs_and_return_to_usermode
> >        2.36 =C2=B1  8%      +0.4        2.78 =C2=B1  6%  perf-profile.c=
alltrace.cycles-pp.exit_to_usermode_loop.prepare_exit_to_usermode.swapgs_re=
store_regs_and_return_to_usermode
> >        2.40 =C2=B1  8%      +0.4        2.83 =C2=B1  6%  perf-profile.c=
alltrace.cycles-pp.swapgs_restore_regs_and_return_to_usermode
> >        2.37 =C2=B1  8%      +0.4        2.80 =C2=B1  6%  perf-profile.c=
alltrace.cycles-pp.prepare_exit_to_usermode.swapgs_restore_regs_and_return_=
to_usermode
> >        2.76 =C2=B1  7%      +0.5        3.27        perf-profile.calltr=
ace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.do_exit
> >        2.77 =C2=B1  7%      +0.5        3.28        perf-profile.calltr=
ace.cycles-pp.unmap_vmas.exit_mmap.mmput.do_exit.do_group_exit
> >        5.51 =C2=B1  3%      +0.6        6.14 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_pa=
ge_fault.page_fault
> >        0.35 =C2=B1100%      +0.7        1.01 =C2=B1  8%  perf-profile.c=
alltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.se=
condary_startup_64
> >        6.29 =C2=B1 11%      +1.0        7.33 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.=
__x64_sys_msync.do_syscall_64
> >        7.17 =C2=B1 11%      +1.2        8.34 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__x64_sys=
_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >        7.57 =C2=B1 11%      +1.2        8.81 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.rwsem_down_read_slowpath.__x64_sys_msync.do_syscall_64.e=
ntry_SYSCALL_64_after_hwframe
> >        9.61 =C2=B1 11%      +1.3       10.93        perf-profile.calltr=
ace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down=
_write_killable.do_madvise
> >        9.17 =C2=B1 11%      +1.4       10.56 =C2=B1  3%  perf-profile.c=
alltrace.cycles-pp.__x64_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame
> >       11.68 =C2=B1 11%      +1.6       13.29 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_wri=
te_killable.do_madvise.__x64_sys_madvise
> >       12.11 =C2=B1 12%      +1.6       13.76 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.do_madvise=
.__x64_sys_madvise.do_syscall_64
> >       34.59 =C2=B1 18%      -7.4       27.14 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.intel_idle
> >       37.20 =C2=B1 16%      -7.0       30.20 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.cpuidle_enter_state
> >       37.20 =C2=B1 16%      -7.0       30.20 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.cpuidle_enter
> >       37.86 =C2=B1 14%      -6.6       31.21 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.start_secondary
> >       38.16 =C2=B1 15%      -6.5       31.62 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.secondary_startup_64
> >       38.16 =C2=B1 15%      -6.5       31.62 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.cpu_startup_entry
> >       38.17 =C2=B1 15%      -6.5       31.63 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.do_idle
> >        0.23 =C2=B1 25%      -0.1        0.17 =C2=B1 14%  perf-profile.c=
hildren.cycles-pp.irq_enter
> >        0.08 =C2=B1  5%      +0.0        0.09 =C2=B1  5%  perf-profile.c=
hildren.cycles-pp.select_task_rq_fair
> >        0.07 =C2=B1 13%      +0.0        0.08 =C2=B1  5%  perf-profile.c=
hildren.cycles-pp.security_file_alloc
> >        0.06 =C2=B1 11%      +0.0        0.08 =C2=B1 10%  perf-profile.c=
hildren.cycles-pp.__pthread_enable_asynccancel
> >        0.18 =C2=B1  2%      +0.0        0.21 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.__perf_sw_event
> >        0.04 =C2=B1 57%      +0.0        0.06 =C2=B1  7%  perf-profile.c=
hildren.cycles-pp.apparmor_file_alloc_security
> >        0.19 =C2=B1  7%      +0.0        0.22 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.page_remove_rmap
> >        0.08 =C2=B1 13%      +0.0        0.11 =C2=B1 12%  perf-profile.c=
hildren.cycles-pp.uncharge_batch
> >        0.15 =C2=B1 14%      +0.0        0.18 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.__alloc_file
> >        0.15 =C2=B1 10%      +0.0        0.18 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.alloc_empty_file
> >        0.20 =C2=B1 10%      +0.0        0.24 =C2=B1  5%  perf-profile.c=
hildren.cycles-pp.___slab_alloc
> >        0.14 =C2=B1 11%      +0.0        0.18 =C2=B1  9%  perf-profile.c=
hildren.cycles-pp.alloc_set_pte
> >        0.15 =C2=B1 14%      +0.0        0.18 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.alloc_file
> >        0.39 =C2=B1  6%      +0.0        0.44 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.___might_sleep
> >        0.01 =C2=B1173%      +0.0        0.06 =C2=B1 13%  perf-profile.c=
hildren.cycles-pp.free_pcp_prepare
> >        0.28 =C2=B1 10%      +0.0        0.33        perf-profile.childr=
en.cycles-pp.syscall_return_via_sysret
> >        0.10 =C2=B1 23%      +0.1        0.15 =C2=B1 14%  perf-profile.c=
hildren.cycles-pp.irq_work_run_list
> >        0.00            +0.1        0.05        perf-profile.children.cy=
cles-pp.call_rcu
> >        0.52 =C2=B1  6%      +0.1        0.58 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.do_brk_flags
> >        0.21 =C2=B1 14%      +0.1        0.27        perf-profile.childr=
en.cycles-pp.alloc_file_pseudo
> >        0.39 =C2=B1  9%      +0.1        0.45 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.up_write
> >        0.46 =C2=B1  4%      +0.1        0.52 =C2=B1  8%  perf-profile.c=
hildren.cycles-pp.sync_regs
> >        0.36 =C2=B1 10%      +0.1        0.43 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.on_each_cpu_cond_mask
> >        0.16 =C2=B1 33%      +0.1        0.24 =C2=B1  5%  perf-profile.c=
hildren.cycles-pp.tick_nohz_irq_exit
> >        0.23 =C2=B1 19%      +0.1        0.32 =C2=B1  6%  perf-profile.c=
hildren.cycles-pp.filemap_map_pages
> >        0.42 =C2=B1 15%      +0.1        0.52 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.osq_unlock
> >        0.61 =C2=B1 12%      +0.1        0.72 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.smp_call_function_many_cond
> >        1.28 =C2=B1  5%      +0.1        1.39 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.mem_cgroup_try_charge_delay
> >        1.31 =C2=B1  5%      +0.1        1.43 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.prep_new_page
> >        0.86 =C2=B1 13%      +0.1        1.01        perf-profile.childr=
en.cycles-pp.mmap_region
> >        2.23 =C2=B1  6%      +0.2        2.43 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.get_page_from_freelist
> >        2.44 =C2=B1  6%      +0.2        2.67 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.__alloc_pages_nodemask
> >        2.48 =C2=B1  7%      +0.2        2.73 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.alloc_pages_vma
> >        2.40 =C2=B1  8%      +0.4        2.83 =C2=B1  6%  perf-profile.c=
hildren.cycles-pp.swapgs_restore_regs_and_return_to_usermode
> >        2.38 =C2=B1  8%      +0.4        2.80 =C2=B1  6%  perf-profile.c=
hildren.cycles-pp.prepare_exit_to_usermode
> >        3.12 =C2=B1  2%      +0.4        3.55        perf-profile.childr=
en.cycles-pp.unmap_page_range
> >        3.07 =C2=B1  2%      +0.4        3.50        perf-profile.childr=
en.cycles-pp.unmap_vmas
> >        0.57 =C2=B1 25%      +0.5        1.02 =C2=B1  8%  perf-profile.c=
hildren.cycles-pp.menu_select
> >        4.06 =C2=B1  4%      +0.5        4.58        perf-profile.childr=
en.cycles-pp.tlb_flush_mmu
> >        4.83 =C2=B1  4%      +0.5        5.36        perf-profile.childr=
en.cycles-pp.release_pages
> >        6.64 =C2=B1  5%      +0.8        7.41 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.handle_pte_fault
> >        9.18 =C2=B1 11%      +1.4       10.57 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.__x64_sys_msync
> >        9.69 =C2=B1 11%      +1.5       11.19        perf-profile.childr=
en.cycles-pp.rwsem_down_read_slowpath
> >       12.15 =C2=B1 12%      +1.7       13.87 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.rwsem_down_write_slowpath
> >       17.80 =C2=B1 11%      +2.6       20.44 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.osq_lock
> >       20.98 =C2=B1 11%      +3.1       24.05 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.rwsem_optimistic_spin
> >       34.59 =C2=B1 18%      -7.4       27.14 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.intel_idle
> >        0.05 =C2=B1  8%      +0.0        0.07 =C2=B1  7%  perf-profile.s=
elf.cycles-pp.do_brk_flags
> >        0.07 =C2=B1 11%      +0.0        0.09        perf-profile.self.c=
ycles-pp.anon_vma_interval_tree_remove
> >        0.06 =C2=B1 11%      +0.0        0.08 =C2=B1 10%  perf-profile.s=
elf.cycles-pp.__pthread_enable_asynccancel
> >        0.15 =C2=B1  7%      +0.0        0.18 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.page_remove_rmap
> >        0.17 =C2=B1  6%      +0.0        0.19 =C2=B1  4%  perf-profile.s=
elf.cycles-pp.find_get_entries
> >        0.17 =C2=B1  6%      +0.0        0.19 =C2=B1  4%  perf-profile.s=
elf.cycles-pp.handle_mm_fault
> >        0.23 =C2=B1  6%      +0.0        0.26 =C2=B1  4%  perf-profile.s=
elf.cycles-pp._raw_spin_lock_irq
> >        0.37 =C2=B1  6%      +0.0        0.42 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.___might_sleep
> >        0.21 =C2=B1  8%      +0.0        0.26 =C2=B1  4%  perf-profile.s=
elf.cycles-pp.do_madvise
> >        0.28 =C2=B1 10%      +0.0        0.33        perf-profile.self.c=
ycles-pp.syscall_return_via_sysret
> >        0.39 =C2=B1  8%      +0.1        0.44 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.up_write
> >        0.13 =C2=B1 22%      +0.1        0.19 =C2=B1  6%  perf-profile.s=
elf.cycles-pp.filemap_map_pages
> >        0.45 =C2=B1  3%      +0.1        0.52 =C2=B1  8%  perf-profile.s=
elf.cycles-pp.sync_regs
> >        0.67 =C2=B1  6%      +0.1        0.75        perf-profile.self.c=
ycles-pp.get_page_from_freelist
> >        0.42 =C2=B1 16%      +0.1        0.51 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.osq_unlock
> >        0.20 =C2=B1 18%      +0.2        0.40 =C2=B1  7%  perf-profile.s=
elf.cycles-pp.cpuidle_enter_state
> >        1.94 =C2=B1  5%      +0.2        2.15        perf-profile.self.c=
ycles-pp._raw_spin_lock
> >        0.20 =C2=B1 39%      +0.4        0.56 =C2=B1  5%  perf-profile.s=
elf.cycles-pp.menu_select
> >       17.31 =C2=B1 11%      +2.6       19.86 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.osq_lock
> >
> >
> >
> > ***********************************************************************=
****************************
> > lkp-hsw-d01: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G =
memory
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
> > Rong Chen
> >
> >
> > _______________________________________________
> > LKP mailing list -- lkp@lists.01.org
> > To unsubscribe send an email to lkp-leave@lists.01.org
> >
>
> --
> Zhengjun Xing
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
