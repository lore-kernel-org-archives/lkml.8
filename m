Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7C4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7582080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgH0JQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:16:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:55164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgH0JQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:16:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D81C8AFE6;
        Thu, 27 Aug 2020 09:17:16 +0000 (UTC)
Subject: Re: [drm/mgag200] 913ec479bb: vm-scalability.throughput 26.2%
 improvement
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     John Donnelly <John.p.donnelly@oracle.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
References: <20200826085847.GL4299@shao2-debian>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <76926ade-15fb-75a3-17aa-a2b5a68471c8@suse.de>
Date:   Thu, 27 Aug 2020 11:16:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826085847.GL4299@shao2-debian>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Q1HK9UHpCEhmB9G2AYR5owvMyHY1SftBV"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q1HK9UHpCEhmB9G2AYR5owvMyHY1SftBV
Content-Type: multipart/mixed; boundary="fqtBhxDz1cq5hv96PYkym8Vn52yglc55j";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kernel test robot <rong.a.chen@intel.com>
Cc: John Donnelly <John.p.donnelly@oracle.com>,
 Emil Velikov <emil.velikov@collabora.com>,
 LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org, lkp@intel.com,
 ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Message-ID: <76926ade-15fb-75a3-17aa-a2b5a68471c8@suse.de>
Subject: Re: [drm/mgag200] 913ec479bb: vm-scalability.throughput 26.2%
 improvement
References: <20200826085847.GL4299@shao2-debian>
In-Reply-To: <20200826085847.GL4299@shao2-debian>

--fqtBhxDz1cq5hv96PYkym8Vn52yglc55j
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 26.08.20 um 10:58 schrieb kernel test robot:
> Greeting,
>=20
> FYI, we noticed a 26.2% improvement of vm-scalability.throughput due to=
 commit:

I guess this resolves the once-measured performance penalty of similar
magnitude. But do we really understand these tests? When I sent out
patches to resolve the problem, nothing changed. And suddenly the
performance is back to normal.

Best regards
Thomas

>=20
>=20
> commit: 913ec479bb5cc27f99f24d5fd111b3ef29a4deb9 ("drm/mgag200: Replace=
 VRAM helpers with SHMEM helpers")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
>=20
> in testcase: vm-scalability
> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz w=
ith 80G memory
> with following parameters:
>=20
> 	runtime: 300s
> 	size: 8T
> 	test: anon-cow-seq-hugetlb
> 	cpufreq_governor: performance
> 	ucode: 0x11
>=20
> test-description: The motivation behind this suite is to exercise funct=
ions and regions of the mm/ of the Linux kernel which are of interest to =
us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalabili=
ty.git/
>=20
>=20
>=20
>=20
>=20
> Details are as below:
> -----------------------------------------------------------------------=
--------------------------->
>=20
>=20
> To reproduce:
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/t=
estcase/ucode:
>   gcc-7/performance/x86_64-rhel-7.6/debian-x86_64-20191114.cgz/300s/8T/=
lkp-knm01/anon-cow-seq-hugetlb/vm-scalability/0x11
>=20
> commit:=20
>   88fabb75ea ("drm/mgag200: Convert to simple KMS helper")
>   913ec479bb ("drm/mgag200: Replace VRAM helpers with SHMEM helpers")
>=20
> 88fabb75ea9edf4a 913ec479bb5cc27f99f24d5fd11=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \ =20
>      26138 =B1  3%     +26.8%      33155        vm-scalability.median
>      19.34 =B1 18%     -14.7        4.68 =B1 10%  vm-scalability.median=
_stddev%
>      19.51 =B1 19%     -14.2        5.28 =B1 10%  vm-scalability.stddev=
%
>    8319528 =B1  4%     +26.2%   10501934        vm-scalability.throughp=
ut
>     120228           +10.5%     132891        vm-scalability.time.invol=
untary_context_switches
>    1361617 =B1  5%     +29.6%    1765048        vm-scalability.time.min=
or_page_faults
>      10722            +8.2%      11596        vm-scalability.time.perce=
nt_of_cpu_this_job_got
>      23798            +3.0%      24511        vm-scalability.time.syste=
m_time
>       9152 =B1  2%     +19.1%      10902        vm-scalability.time.use=
r_time
>     907111 =B1  4%     +22.1%    1107928        vm-scalability.time.vol=
untary_context_switches
>  1.972e+09 =B1  5%     +29.8%  2.561e+09        vm-scalability.workload=

>      11.43 =B1  3%      +2.2       13.66        mpstat.cpu.all.usr%
>    2186600 =B1  2%     +17.9%    2578950        numa-numastat.node0.loc=
al_node
>    2186561 =B1  2%     +17.9%    2578936        numa-numastat.node0.num=
a_hit
>      58.75            -5.1%      55.75        vmstat.cpu.id
>      10.75 =B1  4%     +20.9%      13.00        vmstat.cpu.us
>      10814 =B1  3%     +13.7%      12296        vmstat.system.cs
>     726.00 =B1  9%     -20.8%     575.00 =B1  8%  slabinfo.UDP.active_o=
bjs
>     726.00 =B1  9%     -20.8%     575.00 =B1  8%  slabinfo.UDP.num_objs=

>     135282           +13.8%     153971        slabinfo.anon_vma.active_=
objs
>       2940           +13.8%       3347        slabinfo.anon_vma.active_=
slabs
>     135282           +13.8%     153974        slabinfo.anon_vma.num_obj=
s
>       2940           +13.8%       3347        slabinfo.anon_vma.num_sla=
bs
>       1276 =B1  4%     +19.7%       1528        slabinfo.hugetlbfs_inod=
e_cache.active_objs
>       1276 =B1  4%     +19.7%       1528        slabinfo.hugetlbfs_inod=
e_cache.num_objs
>      37346           -12.4%      32714        slabinfo.vmap_area.active=
_objs
>      37802           -11.7%      33381        slabinfo.vmap_area.num_ob=
js
>     864832 =B1  5%     +29.8%    1122765        proc-vmstat.htlb_buddy_=
alloc_success
>     209.50 =B1  2%      +8.1%     226.50        proc-vmstat.nr_dirtied
>      17601            +6.4%      18734 =B1  2%  proc-vmstat.nr_inactive=
_anon
>     396.00            +2.7%     406.75        proc-vmstat.nr_inactive_f=
ile
>       2873            +4.1%       2991 =B1  4%  proc-vmstat.nr_page_tab=
le_pages
>      26710 =B1  2%      +4.4%      27891        proc-vmstat.nr_shmem
>     100611            +1.6%     102242        proc-vmstat.nr_slab_unrec=
laimable
>      17601            +6.4%      18734 =B1  2%  proc-vmstat.nr_zone_ina=
ctive_anon
>     396.00            +2.7%     406.75        proc-vmstat.nr_zone_inact=
ive_file
>    2209041 =B1  2%     +17.8%    2601215        proc-vmstat.numa_hit
>    2209039 =B1  2%     +17.8%    2601213        proc-vmstat.numa_local
>  4.443e+08 =B1  5%     +29.8%  5.765e+08        proc-vmstat.pgalloc_nor=
mal
>    2188741 =B1  3%     +18.4%    2591635        proc-vmstat.pgfault
>  4.443e+08 =B1  5%     +29.8%  5.766e+08        proc-vmstat.pgfree
>       9260 =B1 15%     -30.3%       6456        softirqs.CPU113.RCU
>       9814 =B1  8%     -22.3%       7626 =B1 10%  softirqs.CPU16.RCU
>       8961 =B1 17%     -31.8%       6108        softirqs.CPU167.RCU
>       9410 =B1 24%     -34.7%       6142 =B1  2%  softirqs.CPU185.RCU
>       8572 =B1 10%     -29.0%       6084 =B1  2%  softirqs.CPU192.RCU
>       9877 =B1  4%     -20.5%       7856 =B1 10%  softirqs.CPU2.RCU
>       8615 =B1 14%     -29.4%       6085        softirqs.CPU218.RCU
>       9547 =B1  8%     -24.8%       7182 =B1  2%  softirqs.CPU22.RCU
>       8630 =B1 13%     -31.3%       5926 =B1  2%  softirqs.CPU251.RCU
>       8352 =B1 14%     -24.7%       6292 =B1 10%  softirqs.CPU253.RCU
>      10579 =B1 19%     -32.7%       7117        softirqs.CPU28.RCU
>      10533 =B1 21%     -30.9%       7276 =B1  3%  softirqs.CPU30.RCU
>       9505 =B1  6%     -25.9%       7039 =B1  3%  softirqs.CPU34.RCU
>       9683 =B1 12%     -22.8%       7474 =B1  7%  softirqs.CPU35.RCU
>       9921 =B1  5%     -23.5%       7593 =B1  2%  softirqs.CPU4.RCU
>       9143 =B1  7%     -24.3%       6919        softirqs.CPU40.RCU
>       9846 =B1 16%     -27.5%       7137 =B1  7%  softirqs.CPU43.RCU
>     125651 =B1  5%      -7.6%     116136        softirqs.CPU43.TIMER
>       9740 =B1  5%     -19.6%       7830 =B1  8%  softirqs.CPU5.RCU
>       9796 =B1 17%     -30.8%       6782        softirqs.CPU64.RCU
>     125735 =B1  5%      -7.8%     115896        softirqs.CPU64.TIMER
>      10505 =B1 16%     -29.1%       7451        softirqs.CPU7.RCU
>       9281 =B1 17%     -29.3%       6559 =B1  4%  softirqs.CPU72.RCU
>       9254 =B1  9%     -28.5%       6620        softirqs.CPU76.RCU
>       8966 =B1  8%     -26.4%       6602        softirqs.CPU80.RCU
>    2440341           -23.2%    1874298        softirqs.RCU
>      47786 =B1 16%     +19.7%      57184 =B1 10%  sched_debug.cfs_rq:/.=
exec_clock.avg
>      55043 =B1 15%     +37.4%      75652 =B1 16%  sched_debug.cfs_rq:/.=
exec_clock.max
>       2301 =B1 15%     +39.5%       3209 =B1 14%  sched_debug.cfs_rq:/.=
exec_clock.stddev
>     682444 =B1  6%     +32.4%     903612 =B1  3%  sched_debug.cfs_rq:/.=
load.max
>      51939 =B1  6%     +26.2%      65553 =B1  4%  sched_debug.cfs_rq:/.=
load.stddev
>     707.93 =B1 12%     +24.8%     883.35 =B1  2%  sched_debug.cfs_rq:/.=
load_avg.max
>    7053330 =B1 15%     +25.8%    8873751 =B1 10%  sched_debug.cfs_rq:/.=
min_vruntime.avg
>    7953721 =B1 14%     +26.2%   10040724 =B1 10%  sched_debug.cfs_rq:/.=
min_vruntime.max
>     322922 =B1 12%     +36.3%     440070 =B1 10%  sched_debug.cfs_rq:/.=
min_vruntime.stddev
>    1464090 =B1 26%     +64.9%    2414900 =B1  8%  sched_debug.cfs_rq:/.=
spread0.avg
>    2354621 =B1 21%     +52.2%    3584671 =B1 10%  sched_debug.cfs_rq:/.=
spread0.max
>     325700 =B1 12%     +35.7%     442066 =B1 10%  sched_debug.cfs_rq:/.=
spread0.stddev
>     234.31 =B1  4%     +12.3%     263.24 =B1  3%  sched_debug.cfs_rq:/.=
util_est_enqueued.stddev
>    4421799 =B1  7%     -35.6%    2848695 =B1  2%  sched_debug.cpu.avg_i=
dle.avg
>   11041245 =B1  7%     -39.3%    6701506 =B1 32%  sched_debug.cpu.avg_i=
dle.max
>    1237620 =B1  5%     -50.0%     618574 =B1 15%  sched_debug.cpu.avg_i=
dle.stddev
>      12335 =B1 10%     +19.7%      14763 =B1  7%  sched_debug.cpu.curr-=
>pid.max
>       4421 =B1  3%     +26.3%       5584 =B1  5%  sched_debug.cpu.curr-=
>pid.stddev
>    2275100 =B1  7%     -35.6%    1466283 =B1  2%  sched_debug.cpu.max_i=
dle_balance_cost.avg
>    1281746 =B1  8%     -29.4%     905511 =B1  5%  sched_debug.cpu.max_i=
dle_balance_cost.min
>     619199 =B1  5%     -48.7%     317754 =B1 26%  sched_debug.cpu.max_i=
dle_balance_cost.stddev
>       7348 =B1 10%     +16.3%       8547 =B1  7%  sched_debug.cpu.nr_sw=
itches.avg
>       4247 =B1 15%     +23.8%       5258 =B1  8%  sched_debug.cpu.nr_sw=
itches.min
>       1954 =B1 16%     +26.4%       2470 =B1 18%  sched_debug.cpu.nr_sw=
itches.stddev
>      35.14 =B1  7%     +17.2%      41.19 =B1  5%  sched_debug.cpu.nr_un=
interruptible.stddev
>       4555 =B1 17%     +26.4%       5759 =B1 11%  sched_debug.cpu.sched=
_count.avg
>      15348 =B1 19%     +50.8%      23137 =B1 24%  sched_debug.cpu.sched=
_count.max
>       3317 =B1 17%     +21.5%       4031 =B1  8%  sched_debug.cpu.sched=
_count.min
>       1475 =B1 22%     +40.4%       2070 =B1 21%  sched_debug.cpu.sched=
_count.stddev
>       2024 =B1 17%     +26.8%       2567 =B1 11%  sched_debug.cpu.sched=
_goidle.avg
>       7428 =B1 19%     +51.2%      11230 =B1 25%  sched_debug.cpu.sched=
_goidle.max
>     728.91 =B1 22%     +39.9%       1019 =B1 21%  sched_debug.cpu.sched=
_goidle.stddev
>       2279 =B1 17%     +26.5%       2883 =B1 11%  sched_debug.cpu.ttwu_=
count.avg
>       1037 =B1 19%     +33.5%       1384 =B1 16%  sched_debug.cpu.ttwu_=
count.stddev
>     398.73 =B1 17%     +16.9%     466.07 =B1 10%  sched_debug.cpu.ttwu_=
local.avg
>     123.45 =B1 12%     +40.1%     172.95 =B1  6%  sched_debug.cpu.ttwu_=
local.stddev
>       8.88 =B1  2%      +9.4%       9.72        perf-stat.i.MPKI
>  1.257e+10 =B1  2%     +14.4%  1.438e+10        perf-stat.i.branch-inst=
ructions
>  1.972e+08 =B1  6%     +20.9%  2.384e+08        perf-stat.i.branch-miss=
es
>      13.19 =B1  2%      -1.0       12.19        perf-stat.i.cache-miss-=
rate%
>   55435779 =B1  6%     +13.0%   62648038        perf-stat.i.cache-misse=
s
>  4.227e+08 =B1  4%     +21.6%  5.138e+08        perf-stat.i.cache-refer=
ences
>      11013 =B1  3%     +12.7%      12415        perf-stat.i.context-swi=
tches
>       4.11 =B1  3%      -5.8%       3.87        perf-stat.i.cpi
>   1.99e+11 =B1  3%      +5.3%  2.097e+11        perf-stat.i.cpu-cycles
>       1019            +8.4%       1104        perf-stat.i.cpu-migration=
s
>       3581 =B1  2%      -7.2%       3324        perf-stat.i.cycles-betw=
een-cache-misses
>  4.913e+10 =B1  2%     +10.7%  5.441e+10        perf-stat.i.iTLB-loads
>   4.91e+10 =B1  2%     +10.7%  5.433e+10        perf-stat.i.instruction=
s
>       0.25 =B1  3%      +5.7%       0.26        perf-stat.i.ipc
>       0.68 =B1  2%      +5.2%       0.71        perf-stat.i.metric.GHz
>       0.09 =B1  2%     +15.9%       0.11        perf-stat.i.metric.K/se=
c
>     211.98 =B1  2%     +11.5%     236.42        perf-stat.i.metric.M/se=
c
>       7299 =B1  3%     +18.8%       8671        perf-stat.i.minor-fault=
s
>       7300 =B1  3%     +18.8%       8676        perf-stat.i.page-faults=

>       8.56 =B1  3%     +10.3%       9.45        perf-stat.overall.MPKI
>       1.55 =B1  4%      +0.1        1.65        perf-stat.overall.branc=
h-miss-rate%
>      13.26 =B1  2%      -1.0       12.26        perf-stat.overall.cache=
-miss-rate%
>       4.08 =B1  2%      -5.3%       3.87        perf-stat.overall.cpi
>       3599 =B1  3%      -7.3%       3335        perf-stat.overall.cycle=
s-between-cache-misses
>       0.25 =B1  2%      +5.5%       0.26        perf-stat.overall.ipc
>       7415 =B1  2%     -14.2%       6361        perf-stat.overall.path-=
length
>  1.215e+10 =B1  2%     +16.2%  1.412e+10        perf-stat.ps.branch-ins=
tructions
>  1.889e+08 =B1  6%     +23.3%   2.33e+08        perf-stat.ps.branch-mis=
ses
>   54049850 =B1  5%     +14.4%   61817571        perf-stat.ps.cache-miss=
es
>  4.076e+08 =B1  4%     +23.7%  5.041e+08        perf-stat.ps.cache-refe=
rences
>      10730 =B1  3%     +14.1%      12239        perf-stat.ps.context-sw=
itches
>  1.942e+11 =B1  2%      +6.2%  2.062e+11        perf-stat.ps.cpu-cycles=

>     974.83            +8.9%       1061        perf-stat.ps.cpu-migratio=
ns
>  4.761e+10 =B1  2%     +12.2%  5.343e+10        perf-stat.ps.iTLB-loads=

>  4.757e+10 =B1  2%     +12.1%  5.335e+10        perf-stat.ps.instructio=
ns
>       7000 =B1  3%     +19.3%       8351        perf-stat.ps.minor-faul=
ts
>       7001 =B1  3%     +19.3%       8352        perf-stat.ps.page-fault=
s
>  1.461e+13 =B1  2%     +11.5%  1.629e+13        perf-stat.total.instruc=
tions
>      36.28 =B1  5%      -3.1       33.23 =B1  4%  perf-profile.calltrac=
e.cycles-pp.osq_lock.__mutex_lock.hugetlb_fault.handle_mm_fault.do_page_f=
ault
>      47.28 =B1  2%      -2.9       44.42 =B1  4%  perf-profile.calltrac=
e.cycles-pp.__mutex_lock.hugetlb_fault.handle_mm_fault.do_page_fault.page=
_fault
>       0.78 =B1 29%      +0.4        1.17 =B1 13%  perf-profile.calltrac=
e.cycles-pp.apic_timer_interrupt.do_access
>       0.51 =B1 62%      +0.5        1.04 =B1 14%  perf-profile.calltrac=
e.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.do_access
>       0.14 =B1173%      +0.6        0.71 =B1 18%  perf-profile.calltrac=
e.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interru=
pt.apic_timer_interrupt.do_access
>       0.17 =B1173%      +0.7        0.85 =B1 16%  perf-profile.calltrac=
e.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interru=
pt.do_access
>       0.61 =B1  9%      +0.7        1.33 =B1 18%  perf-profile.calltrac=
e.cycles-pp.apic_timer_interrupt.mutex_spin_on_owner.__mutex_lock.hugetlb=
_fault.handle_mm_fault
>       0.00            +0.8        0.76 =B1 12%  perf-profile.calltrace.=
cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt=
=2Eapic_timer_interrupt.mutex_spin_on_owner
>       0.42 =B1 57%      +0.8        1.26 =B1 18%  perf-profile.calltrac=
e.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.mutex_spin_on_o=
wner.__mutex_lock.hugetlb_fault
>       0.12 =B1173%      +0.9        1.06 =B1 17%  perf-profile.calltrac=
e.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interru=
pt.mutex_spin_on_owner.__mutex_lock
>       1.67 =B1 19%      +1.0        2.65 =B1  6%  perf-profile.calltrac=
e.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interru=
pt.apic_timer_interrupt.osq_lock
>       0.14 =B1173%      +1.1        1.22 =B1 21%  perf-profile.calltrac=
e.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interru=
pt.apic_timer_interrupt.do_rw_once
>       0.27 =B1100%      +1.1        1.38 =B1 16%  perf-profile.calltrac=
e.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interru=
pt.copy_page.copy_subpage
>       0.00            +1.1        1.14 =B1 16%  perf-profile.calltrace.=
cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt=
=2Eapic_timer_interrupt.copy_page
>       2.20 =B1 14%      +1.2        3.35 =B1  3%  perf-profile.calltrac=
e.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interru=
pt.osq_lock.__mutex_lock
>       0.30 =B1102%      +1.2        1.47 =B1 18%  perf-profile.calltrac=
e.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interru=
pt.do_rw_once
>       0.82 =B1 27%      +1.2        1.99 =B1 16%  perf-profile.calltrac=
e.cycles-pp.apic_timer_interrupt.do_rw_once
>       0.60 =B1  8%      +1.2        1.80 =B1  8%  perf-profile.calltrac=
e.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.copy_page.copy_=
subpage.copy_user_huge_page
>       0.86 =B1 14%      +1.2        2.06 =B1  9%  perf-profile.calltrac=
e.cycles-pp.apic_timer_interrupt.copy_page.copy_subpage.copy_user_huge_pa=
ge.hugetlb_cow
>       3.02 =B1 16%      +1.2        4.22 =B1  4%  perf-profile.calltrac=
e.cycles-pp.apic_timer_interrupt.osq_lock.__mutex_lock.hugetlb_fault.hand=
le_mm_fault
>       0.53 =B1 61%      +1.3        1.79 =B1 17%  perf-profile.calltrac=
e.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.do_rw_once
>       2.62 =B1 16%      +1.4        3.98 =B1  3%  perf-profile.calltrac=
e.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.osq_lock.__mute=
x_lock.hugetlb_fault
>       2.80 =B1 14%      +2.5        5.31 =B1 17%  perf-profile.calltrac=
e.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrt=
imer_run_queues.hrtimer_interrupt
>       3.04 =B1 14%      +2.6        5.61 =B1 17%  perf-profile.calltrac=
e.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtim=
er_interrupt.smp_apic_timer_interrupt
>       3.41 =B1 17%      +2.7        6.15 =B1 17%  perf-profile.calltrac=
e.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_a=
pic_timer_interrupt.apic_timer_interrupt
>       9.16 =B1 22%      +3.9       13.04 =B1 18%  perf-profile.calltrac=
e.cycles-pp.do_rw_once
>      36.60 =B1  5%      -3.2       33.42 =B1  4%  perf-profile.children=
=2Ecycles-pp.osq_lock
>      47.28 =B1  2%      -2.9       44.42 =B1  4%  perf-profile.children=
=2Ecycles-pp.__mutex_lock
>       0.58 =B1  6%      -0.5        0.03 =B1102%  perf-profile.children=
=2Ecycles-pp.memcpy_erms
>       1.47 =B1  5%      -0.3        1.21 =B1  6%  perf-profile.children=
=2Ecycles-pp.entry_SYSCALL_64_after_hwframe
>       1.47 =B1  5%      -0.3        1.21 =B1  6%  perf-profile.children=
=2Ecycles-pp.do_syscall_64
>       0.26 =B1 11%      -0.1        0.18 =B1  8%  perf-profile.children=
=2Ecycles-pp.update_ts_time_stats
>       0.09 =B1 12%      -0.0        0.06 =B1  7%  perf-profile.children=
=2Ecycles-pp.wake_up_q
>       0.08 =B1 17%      -0.0        0.05 =B1  8%  perf-profile.children=
=2Ecycles-pp.pipe_write
>       0.17 =B1  4%      -0.0        0.14 =B1 10%  perf-profile.children=
=2Ecycles-pp.write
>       0.08 =B1  5%      +0.0        0.11 =B1  4%  perf-profile.children=
=2Ecycles-pp.raise_softirq
>       0.11 =B1  6%      +0.0        0.15 =B1 22%  perf-profile.children=
=2Ecycles-pp.__update_load_avg_se
>       0.15 =B1 10%      +0.0        0.20 =B1  7%  perf-profile.children=
=2Ecycles-pp.x86_pmu_disable
>       0.17 =B1 25%      +0.1        0.23 =B1  4%  perf-profile.children=
=2Ecycles-pp.native_irq_return_iret
>       0.07 =B1 58%      +0.1        0.12 =B1 13%  perf-profile.children=
=2Ecycles-pp.hrtimer_run_queues
>       0.33 =B1  2%      +0.1        0.39 =B1 10%  perf-profile.children=
=2Ecycles-pp.timerqueue_add
>       0.21 =B1 11%      +0.1        0.27 =B1  8%  perf-profile.children=
=2Ecycles-pp.tick_program_event
>       0.37 =B1  3%      +0.1        0.43 =B1  9%  perf-profile.children=
=2Ecycles-pp.enqueue_hrtimer
>       0.24 =B1 19%      +0.1        0.30 =B1  4%  perf-profile.children=
=2Ecycles-pp._raw_spin_unlock_irqrestore
>       0.18 =B1  9%      +0.1        0.25 =B1 19%  perf-profile.children=
=2Ecycles-pp.__update_load_avg_cfs_rq
>       0.28 =B1 15%      +0.1        0.35 =B1  3%  perf-profile.children=
=2Ecycles-pp.read_tsc
>       0.03 =B1100%      +0.1        0.11 =B1 30%  perf-profile.children=
=2Ecycles-pp.cpuacct_account_field
>       0.08 =B1  5%      +0.1        0.18 =B1 13%  perf-profile.children=
=2Ecycles-pp.cpuacct_charge
>       0.41 =B1 13%      +0.1        0.52 =B1  9%  perf-profile.children=
=2Ecycles-pp.ktime_get_update_offsets_now
>       0.05 =B1 62%      +0.1        0.18 =B1 30%  perf-profile.children=
=2Ecycles-pp.account_user_time
>       0.13 =B1 22%      +0.1        0.28 =B1 24%  perf-profile.children=
=2Ecycles-pp.account_system_index_time
>       0.49 =B1 19%      +0.2        0.68 =B1  6%  perf-profile.children=
=2Ecycles-pp.rcu_irq_enter
>       0.50 =B1 12%      +0.2        0.69 =B1  6%  perf-profile.children=
=2Ecycles-pp._raw_spin_lock_irqsave
>       1.05 =B1 10%      +0.2        1.24 =B1  9%  perf-profile.children=
=2Ecycles-pp.perf_mux_hrtimer_handler
>       0.85 =B1 11%      +0.2        1.04 =B1  9%  perf-profile.children=
=2Ecycles-pp.interrupt_entry
>       0.11 =B1 18%      +0.2        0.32 =B1 27%  perf-profile.children=
=2Ecycles-pp.__acct_update_integrals
>       0.29 =B1 38%      +0.4        0.65 =B1 18%  perf-profile.children=
=2Ecycles-pp.run_local_timers
>       0.40 =B1  9%      +0.5        0.86 =B1 20%  perf-profile.children=
=2Ecycles-pp.update_curr
>       0.00            +0.5        0.54 =B1 23%  perf-profile.children.c=
ycles-pp.memcpy_toio
>       0.00            +0.5        0.54 =B1 24%  perf-profile.children.c=
ycles-pp.drm_atomic_helper_commit
>       0.00            +0.5        0.54 =B1 24%  perf-profile.children.c=
ycles-pp.commit_tail
>       0.00            +0.5        0.54 =B1 24%  perf-profile.children.c=
ycles-pp.drm_atomic_helper_commit_tail
>       0.00            +0.5        0.54 =B1 24%  perf-profile.children.c=
ycles-pp.drm_atomic_helper_commit_planes
>       0.00            +0.5        0.54 =B1 24%  perf-profile.children.c=
ycles-pp.mgag200_simple_display_pipe_update
>       0.00            +0.5        0.54 =B1 24%  perf-profile.children.c=
ycles-pp.mgag200_handle_damage
>       0.00            +0.5        0.54 =B1 24%  perf-profile.children.c=
ycles-pp.drm_fb_memcpy_dstclip
>       0.00            +0.5        0.55 =B1 23%  perf-profile.children.c=
ycles-pp.drm_atomic_helper_dirtyfb
>       0.98 =B1 12%      +0.9        1.86 =B1 26%  perf-profile.children=
=2Ecycles-pp.task_tick_fair
>       2.50 =B1  7%      +1.3        3.76 =B1 22%  perf-profile.children=
=2Ecycles-pp.scheduler_tick
>       4.46 =B1  7%      +2.3        6.73 =B1 14%  perf-profile.children=
=2Ecycles-pp.update_process_times
>       4.75 =B1  8%      +2.3        7.06 =B1 14%  perf-profile.children=
=2Ecycles-pp.tick_sched_handle
>       5.24 =B1 10%      +2.5        7.70 =B1 14%  perf-profile.children=
=2Ecycles-pp.tick_sched_timer
>       9.34 =B1  7%      +3.7       13.00 =B1  8%  perf-profile.children=
=2Ecycles-pp.__hrtimer_run_queues
>      11.80 =B1  9%      +4.4       16.23 =B1  7%  perf-profile.children=
=2Ecycles-pp.hrtimer_interrupt
>      19.20 =B1 11%      +4.8       23.96 =B1  5%  perf-profile.children=
=2Ecycles-pp.apic_timer_interrupt
>      16.55 =B1 10%      +5.3       21.88 =B1  6%  perf-profile.children=
=2Ecycles-pp.smp_apic_timer_interrupt
>      33.71 =B1  4%      -4.6       29.11 =B1  4%  perf-profile.self.cyc=
les-pp.osq_lock
>       0.14 =B1 11%      -0.0        0.10 =B1 12%  perf-profile.self.cyc=
les-pp.update_ts_time_stats
>       0.07 =B1 16%      +0.0        0.09 =B1  5%  perf-profile.self.cyc=
les-pp.update_process_times
>       0.08 =B1  5%      +0.0        0.11 =B1  4%  perf-profile.self.cyc=
les-pp.raise_softirq
>       0.15 =B1 10%      +0.0        0.20 =B1  7%  perf-profile.self.cyc=
les-pp.x86_pmu_disable
>       0.17 =B1 25%      +0.1        0.23 =B1  4%  perf-profile.self.cyc=
les-pp.native_irq_return_iret
>       0.27            +0.1        0.32 =B1 12%  perf-profile.self.cycle=
s-pp.timerqueue_add
>       0.07 =B1 58%      +0.1        0.12 =B1 13%  perf-profile.self.cyc=
les-pp.hrtimer_run_queues
>       0.22 =B1 19%      +0.1        0.28 =B1  5%  perf-profile.self.cyc=
les-pp._raw_spin_unlock_irqrestore
>       0.21 =B1 11%      +0.1        0.27 =B1  8%  perf-profile.self.cyc=
les-pp.tick_program_event
>       0.27 =B1 15%      +0.1        0.33 =B1  3%  perf-profile.self.cyc=
les-pp.read_tsc
>       0.16 =B1 11%      +0.1        0.23 =B1 13%  perf-profile.self.cyc=
les-pp.scheduler_tick
>       0.17 =B1  9%      +0.1        0.24 =B1 18%  perf-profile.self.cyc=
les-pp.__update_load_avg_cfs_rq
>       0.03 =B1100%      +0.1        0.11 =B1 30%  perf-profile.self.cyc=
les-pp.cpuacct_account_field
>       0.08 =B1  5%      +0.1        0.18 =B1 13%  perf-profile.self.cyc=
les-pp.cpuacct_charge
>       0.23 =B1 16%      +0.1        0.34 =B1  8%  perf-profile.self.cyc=
les-pp.apic_timer_interrupt
>       0.03 =B1102%      +0.1        0.14 =B1 25%  perf-profile.self.cyc=
les-pp.account_user_time
>       0.58 =B1  7%      +0.1        0.70 =B1  7%  perf-profile.self.cyc=
les-pp.perf_mux_hrtimer_handler
>       0.11 =B1 19%      +0.1        0.22 =B1 24%  perf-profile.self.cyc=
les-pp.account_system_index_time
>       0.16 =B1 13%      +0.1        0.29 =B1 14%  perf-profile.self.cyc=
les-pp.irq_enter
>       0.40 =B1 22%      +0.1        0.54 =B1  8%  perf-profile.self.cyc=
les-pp._raw_spin_lock_irqsave
>       0.48 =B1  3%      +0.2        0.64        perf-profile.self.cycle=
s-pp._raw_spin_lock
>       0.39 =B1 20%      +0.2        0.55 =B1  8%  perf-profile.self.cyc=
les-pp.rcu_irq_enter
>       0.84 =B1 10%      +0.2        1.02 =B1  9%  perf-profile.self.cyc=
les-pp.interrupt_entry
>       0.11 =B1 18%      +0.2        0.32 =B1 27%  perf-profile.self.cyc=
les-pp.__acct_update_integrals
>       0.28 =B1 15%      +0.3        0.54 =B1 32%  perf-profile.self.cyc=
les-pp.task_tick_fair
>       0.23 =B1 37%      +0.3        0.53 =B1 20%  perf-profile.self.cyc=
les-pp.run_local_timers
>       0.28 =B1 14%      +0.4        0.63 =B1 21%  perf-profile.self.cyc=
les-pp.update_curr
>       1.03 =B1 16%      +0.5        1.50 =B1  6%  perf-profile.self.cyc=
les-pp.smp_apic_timer_interrupt
>       0.00            +0.5        0.49 =B1 24%  perf-profile.self.cycle=
s-pp.memcpy_toio
>       1.08 =B1 14%      +0.6        1.69 =B1  9%  perf-profile.self.cyc=
les-pp.hrtimer_interrupt
>       1.31 =B1 13%      +0.6        1.94 =B1  7%  perf-profile.self.cyc=
les-pp.__hrtimer_run_queues
>       3.00 =B1 20%      +0.8        3.84 =B1 18%  perf-profile.self.cyc=
les-pp.do_access
>     379372           +16.8%     443167 =B1 13%  interrupts.CAL:Function=
_call_interrupts
>     820.75 =B1 32%     +92.6%       1581 =B1 46%  interrupts.CPU1.RES:R=
escheduling_interrupts
>     292.75 =B1 10%     +23.7%     362.00 =B1  7%  interrupts.CPU100.TLB=
:TLB_shootdowns
>     249.00 =B1  5%     +40.4%     349.50 =B1 15%  interrupts.CPU101.TLB=
:TLB_shootdowns
>     240.75 =B1 15%     +36.1%     327.75 =B1 10%  interrupts.CPU105.TLB=
:TLB_shootdowns
>     251.75 =B1  6%     +27.4%     320.75 =B1  6%  interrupts.CPU108.TLB=
:TLB_shootdowns
>     257.50 =B1 18%     +25.1%     322.25 =B1 12%  interrupts.CPU109.TLB=
:TLB_shootdowns
>     960.50 =B1 44%     -35.6%     618.75 =B1 11%  interrupts.CPU11.RES:=
Rescheduling_interrupts
>     624.50 =B1 27%     -25.7%     464.00 =B1 27%  interrupts.CPU110.RES=
:Rescheduling_interrupts
>     243.50 =B1 12%     +29.7%     315.75 =B1  6%  interrupts.CPU111.TLB=
:TLB_shootdowns
>       2912 =B1 27%     -38.2%       1799 =B1  3%  interrupts.CPU113.NMI=
:Non-maskable_interrupts
>       2912 =B1 27%     -38.2%       1799 =B1  3%  interrupts.CPU113.PMI=
:Performance_monitoring_interrupts
>     257.25 =B1  2%     +26.8%     326.25 =B1  5%  interrupts.CPU113.TLB=
:TLB_shootdowns
>       2105 =B1 33%     -26.1%       1555 =B1  8%  interrupts.CPU115.NMI=
:Non-maskable_interrupts
>       2105 =B1 33%     -26.1%       1555 =B1  8%  interrupts.CPU115.PMI=
:Performance_monitoring_interrupts
>     250.00 =B1  9%     +38.2%     345.50 =B1 11%  interrupts.CPU115.TLB=
:TLB_shootdowns
>     241.75 =B1 13%     +59.4%     385.25 =B1 11%  interrupts.CPU116.TLB=
:TLB_shootdowns
>       1698 =B1 30%     +53.6%       2607 =B1 35%  interrupts.CPU12.NMI:=
Non-maskable_interrupts
>       1698 =B1 30%     +53.6%       2607 =B1 35%  interrupts.CPU12.PMI:=
Performance_monitoring_interrupts
>     266.25 =B1 10%     +30.6%     347.75 =B1  6%  interrupts.CPU120.TLB=
:TLB_shootdowns
>     254.25 =B1 23%     +34.7%     342.50 =B1 10%  interrupts.CPU122.TLB=
:TLB_shootdowns
>       1572 =B1  7%     +76.8%       2779 =B1 23%  interrupts.CPU123.NMI=
:Non-maskable_interrupts
>       1572 =B1  7%     +76.8%       2779 =B1 23%  interrupts.CPU123.PMI=
:Performance_monitoring_interrupts
>     233.75 =B1 13%     +40.7%     329.00 =B1 14%  interrupts.CPU123.TLB=
:TLB_shootdowns
>       1836 =B1 38%     +45.9%       2679 =B1 26%  interrupts.CPU124.NMI=
:Non-maskable_interrupts
>       1836 =B1 38%     +45.9%       2679 =B1 26%  interrupts.CPU124.PMI=
:Performance_monitoring_interrupts
>     276.50 =B1 14%     +23.1%     340.50 =B1  7%  interrupts.CPU124.TLB=
:TLB_shootdowns
>     256.00 =B1 18%     +44.8%     370.75 =B1 13%  interrupts.CPU125.TLB=
:TLB_shootdowns
>     249.00 =B1 15%     +38.4%     344.50 =B1  5%  interrupts.CPU127.TLB=
:TLB_shootdowns
>     253.75 =B1 22%     +70.8%     433.50 =B1 47%  interrupts.CPU129.TLB=
:TLB_shootdowns
>       1443 =B1 14%     +71.9%       2481 =B1 20%  interrupts.CPU130.NMI=
:Non-maskable_interrupts
>       1443 =B1 14%     +71.9%       2481 =B1 20%  interrupts.CPU130.PMI=
:Performance_monitoring_interrupts
>       1550 =B1  5%     +35.2%       2096 =B1 21%  interrupts.CPU133.NMI=
:Non-maskable_interrupts
>       1550 =B1  5%     +35.2%       2096 =B1 21%  interrupts.CPU133.PMI=
:Performance_monitoring_interrupts
>     243.25 =B1 20%     +61.6%     393.00 =B1  5%  interrupts.CPU134.TLB=
:TLB_shootdowns
>       2056 =B1 23%     -21.7%       1609 =B1 18%  interrupts.CPU135.NMI=
:Non-maskable_interrupts
>       2056 =B1 23%     -21.7%       1609 =B1 18%  interrupts.CPU135.PMI=
:Performance_monitoring_interrupts
>     258.75 =B1  6%     +35.7%     351.25 =B1 14%  interrupts.CPU135.TLB=
:TLB_shootdowns
>       2346 =B1 32%     +43.1%       3357 =B1  5%  interrupts.CPU139.NMI=
:Non-maskable_interrupts
>       2346 =B1 32%     +43.1%       3357 =B1  5%  interrupts.CPU139.PMI=
:Performance_monitoring_interrupts
>     507.00 =B1 11%     -15.0%     431.00 =B1  7%  interrupts.CPU142.RES=
:Rescheduling_interrupts
>     265.25 =B1 13%     +40.0%     371.25 =B1  6%  interrupts.CPU142.TLB=
:TLB_shootdowns
>       1453 =B1  9%     +54.0%       2238 =B1 18%  interrupts.CPU143.NMI=
:Non-maskable_interrupts
>       1453 =B1  9%     +54.0%       2238 =B1 18%  interrupts.CPU143.PMI=
:Performance_monitoring_interrupts
>       1572 =B1 12%     +57.7%       2479 =B1 16%  interrupts.CPU147.NMI=
:Non-maskable_interrupts
>       1572 =B1 12%     +57.7%       2479 =B1 16%  interrupts.CPU147.PMI=
:Performance_monitoring_interrupts
>     201.25 =B1 13%     +53.5%     309.00 =B1  8%  interrupts.CPU147.TLB=
:TLB_shootdowns
>     229.75 =B1  7%     +31.8%     302.75 =B1 15%  interrupts.CPU149.TLB=
:TLB_shootdowns
>     238.50 =B1  3%     +24.7%     297.50 =B1  3%  interrupts.CPU150.TLB=
:TLB_shootdowns
>     221.00 =B1 14%     +23.4%     272.75 =B1  9%  interrupts.CPU151.TLB=
:TLB_shootdowns
>     262.50 =B1 13%     +34.9%     354.00 =B1 17%  interrupts.CPU152.TLB=
:TLB_shootdowns
>     223.50 =B1 17%     +43.1%     319.75 =B1 23%  interrupts.CPU153.TLB=
:TLB_shootdowns
>       1408 =B1  5%     +85.5%       2612 =B1 42%  interrupts.CPU154.NMI=
:Non-maskable_interrupts
>       1408 =B1  5%     +85.5%       2612 =B1 42%  interrupts.CPU154.PMI=
:Performance_monitoring_interrupts
>     218.50 =B1 20%     +41.5%     309.25 =B1  8%  interrupts.CPU154.TLB=
:TLB_shootdowns
>       1788 =B1 32%     +38.7%       2480 =B1 27%  interrupts.CPU155.NMI=
:Non-maskable_interrupts
>       1788 =B1 32%     +38.7%       2480 =B1 27%  interrupts.CPU155.PMI=
:Performance_monitoring_interrupts
>     226.00 =B1  8%     +55.5%     351.50 =B1  9%  interrupts.CPU155.TLB=
:TLB_shootdowns
>     226.75 =B1 15%     +28.7%     291.75 =B1  9%  interrupts.CPU160.TLB=
:TLB_shootdowns
>     428.25 =B1 15%     +40.7%     602.50 =B1 31%  interrupts.CPU162.RES=
:Rescheduling_interrupts
>     214.75 =B1  5%     +36.0%     292.00 =B1 15%  interrupts.CPU163.TLB=
:TLB_shootdowns
>     233.75 =B1 20%     +38.8%     324.50 =B1  6%  interrupts.CPU164.TLB=
:TLB_shootdowns
>     223.75 =B1 13%     +36.0%     304.25 =B1 13%  interrupts.CPU168.TLB=
:TLB_shootdowns
>       1319           +17.4%       1548 =B1 13%  interrupts.CPU17.CAL:Fu=
nction_call_interrupts
>       1515 =B1  6%     +40.0%       2121 =B1 35%  interrupts.CPU170.NMI=
:Non-maskable_interrupts
>       1515 =B1  6%     +40.0%       2121 =B1 35%  interrupts.CPU170.PMI=
:Performance_monitoring_interrupts
>     405.00 =B1 11%     +26.9%     513.75 =B1 13%  interrupts.CPU170.RES=
:Rescheduling_interrupts
>     251.00 =B1 18%     +21.5%     305.00 =B1  8%  interrupts.CPU170.TLB=
:TLB_shootdowns
>     219.50 =B1 12%     +73.7%     381.25 =B1 45%  interrupts.CPU172.TLB=
:TLB_shootdowns
>     225.25 =B1  7%     +51.6%     341.50 =B1  9%  interrupts.CPU175.TLB=
:TLB_shootdowns
>     229.50 =B1 12%     +34.5%     308.75 =B1  7%  interrupts.CPU177.TLB=
:TLB_shootdowns
>     210.25 =B1 10%     +32.0%     277.50 =B1  8%  interrupts.CPU179.TLB=
:TLB_shootdowns
>     227.75 =B1  7%     +29.3%     294.50 =B1  8%  interrupts.CPU184.TLB=
:TLB_shootdowns
>     204.25 =B1 11%     +50.9%     308.25 =B1 18%  interrupts.CPU188.TLB=
:TLB_shootdowns
>     219.50 =B1 17%     +55.7%     341.75 =B1 10%  interrupts.CPU189.TLB=
:TLB_shootdowns
>     230.50 =B1 17%     +42.0%     327.25 =B1  9%  interrupts.CPU192.TLB=
:TLB_shootdowns
>     248.50 =B1 11%     +24.6%     309.75 =B1 13%  interrupts.CPU193.TLB=
:TLB_shootdowns
>     193.00 =B1 15%     +42.9%     275.75 =B1 18%  interrupts.CPU194.TLB=
:TLB_shootdowns
>     218.25 =B1 13%     +46.8%     320.50 =B1  7%  interrupts.CPU196.TLB=
:TLB_shootdowns
>     446.00 =B1  5%     -14.0%     383.50 =B1  7%  interrupts.CPU197.RES=
:Rescheduling_interrupts
>     215.00 =B1  8%     +52.7%     328.25 =B1  7%  interrupts.CPU197.TLB=
:TLB_shootdowns
>     252.25 =B1  8%     +28.9%     325.25 =B1  2%  interrupts.CPU200.TLB=
:TLB_shootdowns
>     234.75 =B1  5%     +28.2%     301.00 =B1  4%  interrupts.CPU202.TLB=
:TLB_shootdowns
>     222.25 =B1  5%     +25.8%     279.50 =B1 12%  interrupts.CPU203.TLB=
:TLB_shootdowns
>     196.25 =B1 12%     +51.1%     296.50 =B1  7%  interrupts.CPU208.TLB=
:TLB_shootdowns
>     248.50 =B1 12%     +44.7%     359.50 =B1 13%  interrupts.CPU210.TLB=
:TLB_shootdowns
>     234.50 =B1 12%     +41.6%     332.00 =B1 13%  interrupts.CPU211.TLB=
:TLB_shootdowns
>     251.00 =B1 16%     +36.3%     342.00 =B1  6%  interrupts.CPU212.TLB=
:TLB_shootdowns
>       1546 =B1  3%     +16.4%       1801 =B1  5%  interrupts.CPU213.NMI=
:Non-maskable_interrupts
>       1546 =B1  3%     +16.4%       1801 =B1  5%  interrupts.CPU213.PMI=
:Performance_monitoring_interrupts
>     242.00 =B1 16%     +35.0%     326.75 =B1 15%  interrupts.CPU214.TLB=
:TLB_shootdowns
>     241.00 =B1  5%     +14.0%     274.75 =B1  7%  interrupts.CPU216.TLB=
:TLB_shootdowns
>       1606 =B1  8%     +59.7%       2565 =B1 29%  interrupts.CPU218.NMI=
:Non-maskable_interrupts
>       1606 =B1  8%     +59.7%       2565 =B1 29%  interrupts.CPU218.PMI=
:Performance_monitoring_interrupts
>     207.25 =B1 17%     +42.6%     295.50 =B1 13%  interrupts.CPU218.TLB=
:TLB_shootdowns
>       2282 =B1 27%     +59.4%       3638 =B1  2%  interrupts.CPU221.NMI=
:Non-maskable_interrupts
>       2282 =B1 27%     +59.4%       3638 =B1  2%  interrupts.CPU221.PMI=
:Performance_monitoring_interrupts
>     245.00 =B1 11%     +23.3%     302.00 =B1 14%  interrupts.CPU222.TLB=
:TLB_shootdowns
>     387.00 =B1 12%     +39.6%     540.25 =B1 20%  interrupts.CPU225.RES=
:Rescheduling_interrupts
>     224.50 =B1 17%     +42.0%     318.75 =B1 17%  interrupts.CPU226.TLB=
:TLB_shootdowns
>     234.25 =B1 14%     +19.4%     279.75 =B1  6%  interrupts.CPU228.TLB=
:TLB_shootdowns
>     410.75 =B1  6%     +17.1%     481.00 =B1  4%  interrupts.CPU23.TLB:=
TLB_shootdowns
>     233.25 =B1  7%     +27.1%     296.50 =B1 17%  interrupts.CPU231.TLB=
:TLB_shootdowns
>     205.00 =B1  4%     +40.7%     288.50 =B1 13%  interrupts.CPU232.TLB=
:TLB_shootdowns
>       1716 =B1 32%     +30.2%       2234 =B1 22%  interrupts.CPU233.NMI=
:Non-maskable_interrupts
>       1716 =B1 32%     +30.2%       2234 =B1 22%  interrupts.CPU233.PMI=
:Performance_monitoring_interrupts
>     233.50 =B1 13%     +27.2%     297.00 =B1  8%  interrupts.CPU233.TLB=
:TLB_shootdowns
>     230.00 =B1 10%     +23.5%     284.00 =B1  6%  interrupts.CPU236.TLB=
:TLB_shootdowns
>     220.25 =B1 12%     +27.4%     280.50 =B1 12%  interrupts.CPU237.TLB=
:TLB_shootdowns
>     526.75 =B1  6%     +19.4%     628.75 =B1  8%  interrupts.CPU24.RES:=
Rescheduling_interrupts
>     245.25 =B1 10%     +28.8%     316.00 =B1  9%  interrupts.CPU241.TLB=
:TLB_shootdowns
>       1666 =B1  7%     +44.9%       2414 =B1 27%  interrupts.CPU246.NMI=
:Non-maskable_interrupts
>       1666 =B1  7%     +44.9%       2414 =B1 27%  interrupts.CPU246.PMI=
:Performance_monitoring_interrupts
>     243.75 =B1  7%     +31.6%     320.75 =B1 16%  interrupts.CPU246.TLB=
:TLB_shootdowns
>     225.50 =B1  4%     +42.0%     320.25 =B1  4%  interrupts.CPU247.TLB=
:TLB_shootdowns
>     190.50 =B1 26%     +49.6%     285.00 =B1  6%  interrupts.CPU248.TLB=
:TLB_shootdowns
>     210.75 =B1 12%     +31.8%     277.75 =B1 10%  interrupts.CPU249.TLB=
:TLB_shootdowns
>     357.50 =B1 17%     +29.7%     463.50 =B1  5%  interrupts.CPU250.RES=
:Rescheduling_interrupts
>     220.50 =B1 12%     +40.8%     310.50 =B1 13%  interrupts.CPU251.TLB=
:TLB_shootdowns
>     235.25 =B1 18%     +35.4%     318.50 =B1  8%  interrupts.CPU252.TLB=
:TLB_shootdowns
>     234.75 =B1 15%     +35.1%     317.25 =B1  7%  interrupts.CPU253.TLB=
:TLB_shootdowns
>       1603 =B1 10%     +53.1%       2455 =B1 34%  interrupts.CPU254.NMI=
:Non-maskable_interrupts
>       1603 =B1 10%     +53.1%       2455 =B1 34%  interrupts.CPU254.PMI=
:Performance_monitoring_interrupts
>     198.50 =B1 16%     +39.2%     276.25 =B1  6%  interrupts.CPU254.TLB=
:TLB_shootdowns
>     211.50 =B1 10%     +52.5%     322.50 =B1 14%  interrupts.CPU255.TLB=
:TLB_shootdowns
>     370.25 =B1 12%     +24.2%     459.75 =B1  9%  interrupts.CPU256.RES=
:Rescheduling_interrupts
>     222.25 =B1  8%     +42.6%     317.00 =B1 10%  interrupts.CPU256.TLB=
:TLB_shootdowns
>     239.75 =B1  9%     +31.7%     315.75 =B1 14%  interrupts.CPU257.TLB=
:TLB_shootdowns
>       1767 =B1 36%     +36.5%       2412 =B1 27%  interrupts.CPU26.NMI:=
Non-maskable_interrupts
>       1767 =B1 36%     +36.5%       2412 =B1 27%  interrupts.CPU26.PMI:=
Performance_monitoring_interrupts
>     238.00 =B1 18%     +25.7%     299.25 =B1 11%  interrupts.CPU260.TLB=
:TLB_shootdowns
>     233.50 =B1  7%     +34.4%     313.75 =B1  6%  interrupts.CPU261.TLB=
:TLB_shootdowns
>     220.75 =B1 12%     +19.9%     264.75 =B1  9%  interrupts.CPU262.TLB=
:TLB_shootdowns
>     345.00 =B1 16%     +35.0%     465.75 =B1 15%  interrupts.CPU264.RES=
:Rescheduling_interrupts
>     213.00 =B1 14%     +35.9%     289.50 =B1 17%  interrupts.CPU266.TLB=
:TLB_shootdowns
>     244.00 =B1 12%     +27.6%     311.25 =B1 11%  interrupts.CPU267.TLB=
:TLB_shootdowns
>     209.00 =B1 19%     +52.0%     317.75 =B1 11%  interrupts.CPU268.TLB=
:TLB_shootdowns
>     214.00 =B1 16%     +46.0%     312.50 =B1  9%  interrupts.CPU269.TLB=
:TLB_shootdowns
>       1509 =B1  8%     +56.1%       2356 =B1 27%  interrupts.CPU27.NMI:=
Non-maskable_interrupts
>       1509 =B1  8%     +56.1%       2356 =B1 27%  interrupts.CPU27.PMI:=
Performance_monitoring_interrupts
>     465.75 =B1 11%     +20.7%     562.00 =B1  6%  interrupts.CPU27.TLB:=
TLB_shootdowns
>     226.50 =B1 11%     +28.7%     291.50 =B1  9%  interrupts.CPU273.TLB=
:TLB_shootdowns
>     219.50 =B1 16%     +31.0%     287.50 =B1 14%  interrupts.CPU274.TLB=
:TLB_shootdowns
>     385.25 =B1 17%    +149.0%     959.25 =B1 69%  interrupts.CPU275.RES=
:Rescheduling_interrupts
>     234.00 =B1 12%     +32.8%     310.75 =B1  3%  interrupts.CPU277.TLB=
:TLB_shootdowns
>     223.00 =B1 19%     +34.8%     300.50 =B1  5%  interrupts.CPU279.TLB=
:TLB_shootdowns
>       1321           +17.4%       1551 =B1 12%  interrupts.CPU28.CAL:Fu=
nction_call_interrupts
>     235.75 =B1 16%     +37.3%     323.75 =B1  8%  interrupts.CPU280.TLB=
:TLB_shootdowns
>       1648 =B1  5%      -9.3%       1494 =B1  5%  interrupts.CPU282.NMI=
:Non-maskable_interrupts
>       1648 =B1  5%      -9.3%       1494 =B1  5%  interrupts.CPU282.PMI=
:Performance_monitoring_interrupts
>     230.00 =B1  8%     +48.7%     342.00 =B1 16%  interrupts.CPU282.TLB=
:TLB_shootdowns
>       2575 =B1 34%     -26.0%       1906 =B1 42%  interrupts.CPU283.NMI=
:Non-maskable_interrupts
>       2575 =B1 34%     -26.0%       1906 =B1 42%  interrupts.CPU283.PMI=
:Performance_monitoring_interrupts
>     234.75 =B1 10%     +25.8%     295.25 =B1 12%  interrupts.CPU283.TLB=
:TLB_shootdowns
>       1731 =B1 55%     +87.9%       3253 =B1 24%  interrupts.CPU284.NMI=
:Non-maskable_interrupts
>       1731 =B1 55%     +87.9%       3253 =B1 24%  interrupts.CPU284.PMI=
:Performance_monitoring_interrupts
>       1937 =B1 37%     +48.0%       2867 =B1 28%  interrupts.CPU30.NMI:=
Non-maskable_interrupts
>       1937 =B1 37%     +48.0%       2867 =B1 28%  interrupts.CPU30.PMI:=
Performance_monitoring_interrupts
>       1316           +17.7%       1549 =B1 13%  interrupts.CPU31.CAL:Fu=
nction_call_interrupts
>     396.00 =B1  4%     +29.9%     514.50 =B1 17%  interrupts.CPU31.TLB:=
TLB_shootdowns
>     443.75 =B1  4%     +28.0%     568.00 =B1  7%  interrupts.CPU32.TLB:=
TLB_shootdowns
>     468.75 =B1  4%     +29.2%     605.50 =B1 10%  interrupts.CPU34.TLB:=
TLB_shootdowns
>       1507 =B1 16%     +52.9%       2303 =B1 37%  interrupts.CPU35.NMI:=
Non-maskable_interrupts
>       1507 =B1 16%     +52.9%       2303 =B1 37%  interrupts.CPU35.PMI:=
Performance_monitoring_interrupts
>     439.75 =B1  2%     +26.4%     556.00 =B1 13%  interrupts.CPU37.TLB:=
TLB_shootdowns
>     497.25 =B1 12%     +24.7%     620.00 =B1  5%  interrupts.CPU38.TLB:=
TLB_shootdowns
>       1470 =B1 12%    +111.5%       3110 =B1 24%  interrupts.CPU4.NMI:N=
on-maskable_interrupts
>       1470 =B1 12%    +111.5%       3110 =B1 24%  interrupts.CPU4.PMI:P=
erformance_monitoring_interrupts
>       1322           +17.4%       1552 =B1 12%  interrupts.CPU42.CAL:Fu=
nction_call_interrupts
>     525.75 =B1  9%     +17.0%     615.00 =B1  8%  interrupts.CPU44.TLB:=
TLB_shootdowns
>     496.50 =B1  8%     +19.4%     593.00 =B1  5%  interrupts.CPU48.TLB:=
TLB_shootdowns
>     452.75 =B1  8%     +20.6%     546.00 =B1  3%  interrupts.CPU50.TLB:=
TLB_shootdowns
>     461.00 =B1  3%     +38.2%     637.25 =B1  3%  interrupts.CPU52.TLB:=
TLB_shootdowns
>     472.50 =B1  5%     +22.8%     580.00 =B1 10%  interrupts.CPU56.TLB:=
TLB_shootdowns
>     727.50 =B1 28%     -38.7%     446.25 =B1 11%  interrupts.CPU57.RES:=
Rescheduling_interrupts
>     412.00 =B1  8%     +20.1%     495.00 =B1  8%  interrupts.CPU59.TLB:=
TLB_shootdowns
>     456.75 =B1  6%     +19.5%     546.00 =B1  9%  interrupts.CPU6.TLB:T=
LB_shootdowns
>     461.25 =B1  8%     +24.0%     572.00 =B1  8%  interrupts.CPU61.TLB:=
TLB_shootdowns
>     722.25 =B1 12%     -19.8%     579.50 =B1 17%  interrupts.CPU64.RES:=
Rescheduling_interrupts
>     851.00 =B1 32%     -43.3%     482.25 =B1  8%  interrupts.CPU65.RES:=
Rescheduling_interrupts
>     496.75 =B1 10%     +22.6%     609.25 =B1  6%  interrupts.CPU66.TLB:=
TLB_shootdowns
>       1426 =B1 14%     +53.2%       2184 =B1 31%  interrupts.CPU69.NMI:=
Non-maskable_interrupts
>       1426 =B1 14%     +53.2%       2184 =B1 31%  interrupts.CPU69.PMI:=
Performance_monitoring_interrupts
>     754.00 =B1 13%     -23.5%     576.75 =B1 20%  interrupts.CPU71.RES:=
Rescheduling_interrupts
>       1538 =B1 10%    +112.0%       3260 =B1 21%  interrupts.CPU76.NMI:=
Non-maskable_interrupts
>       1538 =B1 10%    +112.0%       3260 =B1 21%  interrupts.CPU76.PMI:=
Performance_monitoring_interrupts
>     230.00 =B1 12%     +38.5%     318.50 =B1 16%  interrupts.CPU76.TLB:=
TLB_shootdowns
>     635.00 =B1 18%     -25.6%     472.75 =B1 10%  interrupts.CPU78.RES:=
Rescheduling_interrupts
>       1414 =B1  7%    +114.8%       3037 =B1 31%  interrupts.CPU83.NMI:=
Non-maskable_interrupts
>       1414 =B1  7%    +114.8%       3037 =B1 31%  interrupts.CPU83.PMI:=
Performance_monitoring_interrupts
>     250.50 =B1 14%     +26.0%     315.75 =B1  6%  interrupts.CPU84.TLB:=
TLB_shootdowns
>       1691 =B1 23%     +72.8%       2922 =B1 30%  interrupts.CPU89.NMI:=
Non-maskable_interrupts
>       1691 =B1 23%     +72.8%       2922 =B1 30%  interrupts.CPU89.PMI:=
Performance_monitoring_interrupts
>     476.75 =B1  4%     +45.5%     693.50 =B1 33%  interrupts.CPU9.TLB:T=
LB_shootdowns
>     410.50 =B1 11%     +68.9%     693.50 =B1 36%  interrupts.CPU94.RES:=
Rescheduling_interrupts
>     264.50 =B1 19%     +26.2%     333.75 =B1  9%  interrupts.CPU94.TLB:=
TLB_shootdowns
>     255.00 =B1  6%     +37.3%     350.00 =B1  8%  interrupts.CPU95.TLB:=
TLB_shootdowns
>     309.50 =B1  2%     +17.0%     362.25 =B1  7%  interrupts.CPU96.TLB:=
TLB_shootdowns
>       1431 =B1 11%     +73.4%       2481 =B1 31%  interrupts.CPU98.NMI:=
Non-maskable_interrupts
>       1431 =B1 11%     +73.4%       2481 =B1 31%  interrupts.CPU98.PMI:=
Performance_monitoring_interrupts
>     424.75 =B1 11%     +36.1%     578.25 =B1 10%  interrupts.CPU98.RES:=
Rescheduling_interrupts
>     267.50 =B1 10%     +27.4%     340.75 =B1 12%  interrupts.CPU98.TLB:=
TLB_shootdowns
>      87577 =B1  3%     +19.4%     104533        interrupts.TLB:TLB_shoo=
tdowns
>=20
>=20
>                                                                        =
        =20
>                                vm-scalability.throughput               =
        =20
>                                                                        =
        =20
>    1.2e+07 +-----------------------------------------------------------=
-----+  =20
>            | O    O   O   O    O                                       =
     |  =20
>   1.15e+07 |-+ O        O                                              =
     |  =20
>    1.1e+07 |-+      O       O    O            O                        =
     |  =20
>            |                       O     O        O        O           =
     |  =20
>   1.05e+07 |-+                       O O    O   O   O O  O             =
     |  =20
>      1e+07 |-+                                                         =
     |  =20
>            |                                                           =
     |  =20
>    9.5e+06 |-+         .+                            .+         .+     =
     |  =20
>      9e+06 |.+        +  +                          +  +    .+.+  +    =
     |  =20
>            |  :       :   +.+..        +    +   +. +    + .+       +..+=
     |  =20
>    8.5e+06 |-+:      :                + + .. + +  +      +             =
+    |  =20
>      8e+06 |-+ +..+. :         +.+.+.+   +    +                        =
 +.+.|  =20
>            |        +                                                  =
     |  =20
>    7.5e+06 +-----------------------------------------------------------=
-----+  =20
>                                                                        =
        =20
>                                                                        =
        =20
> [*] bisect-good sample
> [O] bisect-bad  sample
>=20
>=20
>=20
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are pr=
ovided
> for informational purposes only. Any difference in system hardware or s=
oftware
> design or configuration may affect actual performance.
>=20
>=20
> Thanks,
> Rong Chen
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=FCrnberg, Germany
(HRB 36809, AG N=FCrnberg)
Gesch=E4ftsf=FChrer: Felix Imend=F6rffer


--fqtBhxDz1cq5hv96PYkym8Vn52yglc55j--

--Q1HK9UHpCEhmB9G2AYR5owvMyHY1SftBV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl9HefkUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiMSDgf/eATdrtycVMcJXItFJ9cKLVgF0dxJ
txJTVtZUBX5yhiJHMy6MwTRUw3NnXkRfAyCuSWolW4V0PDUnzYy5s6BrpFopE/+q
z3S7QWHqBHv2wtCWAmnqT043fLLVAAMTkTnD7NDlHomEFOsqFcVWYqc/l1lxevey
XfEfYtF5xmLAmt6tbPbO8mwLWDX8y7RoOKbTcHptPJG4ZMWmFk6P8FehKpiZtDPC
Ue0VxbDDHlyAU4Hk0yuu28bzYFa+D/wHQXca+7J7s9yNXw0TGPLdlw52hTAumq26
agps+QDqUeqcSbQres7TqoYElFgl1qJcSkGqVksNBJ8sUsxXo+813QXXnQ==
=EOUQ
-----END PGP SIGNATURE-----

--Q1HK9UHpCEhmB9G2AYR5owvMyHY1SftBV--
