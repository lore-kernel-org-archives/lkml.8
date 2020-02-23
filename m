Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D7BC35666
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 14:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D0020637
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 14:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgBWOME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 09:12:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:25585 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWOMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 09:12:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 06:11:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,476,1574150400"; 
   d="log'?scan'208";a="260096374"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by fmsmga004.fm.intel.com with ESMTP; 23 Feb 2020 06:11:48 -0800
Date:   Sun, 23 Feb 2020 22:11:47 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, ying.huang@intel.com
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Message-ID: <20200223141147.GA53531@shbuild999.sh.intel.com>
References: <20200205123216.GO12867@shao2-debian>
 <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com>
 <20200221132048.GE652992@krava>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20200221132048.GE652992@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jiri,

On Fri, Feb 21, 2020 at 02:20:48PM +0100, Jiri Olsa wrote:

> > We are also curious that the commit seems to be completely not
> > relative to this scalability test of signal, which starts a task
> > for each online CPU, and keeps calling raise(), and calculating
> > the run numbers.
> > 
> > One experiment we did is checking which part of the commit
> > really affects the test, and it turned out to be the change of
> > "struct pmu". Effectively, applying this patch upon 5.0-rc6 
> > which triggers the same regression.
> > So likely, this commit changes the layout of the kernel text
> > and data, which may trigger some cacheline level change. From
> > the system map of the 2 kernels, a big trunk of symbol's address
> > changes which follow the global "pmu",
> 
> nice, I wonder we could see that in perf c2c output ;-)
> I'll try to run and check

Thanks for the "perf c2c" suggestion. 

I tried to use perf-c2c on one platform (not the one that show
the 5.5% regression), and found the main "hitm" points to the
"root_user" global data, as there is a task for each CPU doing
the signal stress test, and both __sigqueue_alloc() and
__sigqueue_free() will call get_user() and free_uid() to inc/dec
this root_user's refcount.

Then I added some alignement inside struct "user_struct" (for
"root_user"), then the -5.5% is gone, with a +2.6% instead.

One c2c report log is attached.

One thing I don't understand is, this -5.5% only happens in
one 2 sockets, 96C/192T Cascadelake platform, as we've run
the same test on several different platforms. In therory,
the false sharing may also take effect? 

Thanks,
Feng

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="c2c_wis_sig_32T.log"

=================================================
            Trace Event Information              
=================================================
  Total records                     :    1820616
  Locked Load/Store Operations      :     129694
  Load Operations                   :     809800
  Loads - uncacheable               :          0
  Loads - IO                        :          0
  Loads - Miss                      :       7092
  Loads - no mapping                :        489
  Load Fill Buffer Hit              :      34481
  Load L1D hit                      :     740035
  Load L2D hit                      :      23288
  Load LLC hit                      :       4413
  Load Local HITM                   :        785
  Load Remote HITM                  :          0
  Load Remote HIT                   :          0
  Load Local DRAM                   :          2
  Load Remote DRAM                  :          0
  Load MESI State Exclusive         :          2
  Load MESI State Shared            :          0
  Load LLC Misses                   :          2
  LLC Misses to Local DRAM          :      100.0%
  LLC Misses to Remote DRAM         :        0.0%
  LLC Misses to Remote cache (HIT)  :        0.0%
  LLC Misses to Remote cache (HITM) :        0.0%
  Store Operations                  :    1010816
  Store - uncacheable               :          0
  Store - no mapping                :        528
  Store L1D Hit                     :    1003665
  Store L1D Miss                    :       6623
  No Page Map Rejects               :      30462
  Unable to parse data source       :          0

=================================================
    Global Shared Cache Line Event Information   
=================================================
  Total Shared Cache Lines          :         18
  Load HITs on shared lines         :      88581
  Fill Buffer Hits on shared lines  :       6413
  L1D hits on shared lines          :      74179
  L2D hits on shared lines          :       4870
  LLC hits on shared lines          :       1083
  Locked Access on shared lines     :      82039
  Store HITs on shared lines        :      12874
  Store L1D hits on shared lines    :      12870
  Total Merged records              :      13659

=================================================
                 c2c details                     
=================================================
  Events                            : cpu/mem-loads,ldlat=30/P
                                    : cpu/mem-stores/P
  Cachelines sort on                : Total HITMs
  Cacheline data grouping           : offset,pid,iaddr

=================================================
           Shared Data Cache Line Table          
=================================================
#
#        ----------- Cacheline ----------    Total      Tot  ----- LLC Load Hitm -----  ---- Store Reference ----  --- Load Dram ----      LLC    Total  ----- Core Load Hit -----  -- LLC Load Hit --
# Index             Address  Node  PA cnt  records     Hitm    Total      Lcl      Rmt    Total    L1Hit   L1Miss       Lcl       Rmt  Ld Miss    Loads       FB       L1       L2       Llc       Rmt
# .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  ........  ........  .......  .......  .......  .......  .......  ........  ........
#
      0  0xffffffffb7879600     1   39376    77455   81.27%      638      638        0    10177    10173        4         0         0        0    67278     6400    55146     4864       230         0
      1  0xffff8dd0b3048e80     1       1    21921   16.69%      131      131        0     2697     2697        0         0         0        0    19224        0    19025        0        68         0
      2  0xffff8dc0b59fc4c0     0       1        1    0.13%        1        1        0        0        0        0         0         0        0        1        0        0        0         0         0
      3  0xffff8dc601172a00     1       1        1    0.13%        1        1        0        0        0        0         0         0        0        1        0        0        0         0         0
      4  0xffff8dd0b49fc4c0     1       2        2    0.13%        1        1        0        0        0        0         0         0        0        2        0        1        0         0         0
      5  0xffff8dd0b59fce00     1       2        2    0.13%        1        1        0        0        0        0         0         0        0        2        0        0        1         0         0
      6  0xffff8dd0b59fce80     1       2        2    0.13%        1        1        0        0        0        0         0         0        0        2        1        0        0         0         0
      7      0x7f524f675440     1       1        1    0.13%        1        1        0        0        0        0         0         0        0        1        0        0        0         0         0
      8      0x7f524f78a900     0       1        1    0.13%        1        1        0        0        0        0         0         0        0        1        0        0        0         0         0
      9      0x7f524f7da8c0     0       1        1    0.13%        1        1        0        0        0        0         0         0        0        1        0        0        0         0         0
     10      0x7f524f994340     0       1        1    0.13%        1        1        0        0        0        0         0         0        0        1        0        0        0         0         0
     11      0x7f524f9eb6c0     0       1        1    0.13%        1        1        0        0        0        0         0         0        0        1        0        0        0         0         0
     12      0x7f524fc380c0     1       1        1    0.13%        1        1        0        0        0        0         0         0        0        1        0        0        0         0         0
     13      0x7f524fd86240     1       1        1    0.13%        1        1        0        0        0        0         0         0        0        1        0        0        0         0         0
     14      0x7f524fde2080     1       1        1    0.13%        1        1        0        0        0        0         0         0        0        1        0        0        0         0         0
     15      0x7f525012acc0     0       1        1    0.13%        1        1        0        0        0        0         0         0        0        1        0        0        0         0         0
     16      0x7f5253a404c0     0       1        1    0.13%        1        1        0        0        0        0         0         0        0        1        0        0        0         0         0
     17      0x7f5250013400   0-1      29       25    0.13%        1        1        0        0        0        0         0         0        0       25       12        7        5         0         0

=================================================
      Shared Cache Line Distribution Pareto      
=================================================
#
#        ----- HITM -----  -- Store Refs --  --------- Data address ---------                               ---------- cycles ----------    Total       cpu                                          Shared                                  
#   Num      Rmt      Lcl   L1 Hit  L1 Miss              Offset  Node  PA cnt      Pid        Code address  rmt hitm  lcl hitm      load  records       cnt                       Symbol             Object                 Source:Line  Node{cpu list}
# .....  .......  .......  .......  .......  ..................  ....  ......  .......  ..................  ........  ........  ........  .......  ........  ...........................  .................  ..........................  ....
#
  -------------------------------------------------------------
      0        0      638    10173        4  0xffffffffb7879600
  -------------------------------------------------------------
           0.00%    2.82%    1.62%    0.00%                 0x0     1       1    69311  0xffffffffb65a7fc3         0      3549      3545      928         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      1{8}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    2.82%    1.57%    0.00%                 0x0     1       1    69306  0xffffffffb65a7fc3         0      4520      3679      948         2  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{0}  1{24}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    2.19%    1.74%    0.00%                 0x0     1       1    69308  0xffffffffb65a7fc3         0      2858      3588      698         3  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{0}  1{9-10}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    2.19%    1.35%    0.00%                 0x0     1       1    69304  0xffffffffb65a7fc3         0      2254      3524      938         2  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      1{14,30}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    2.04%    1.59%    0.00%                 0x0     1       1    69322  0xffffffffb65a7fc3         0      2639      3814      968         2  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      1{10,26}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    2.04%    1.59%    0.00%                 0x0     1       1    69305  0xffffffffb65a7fc3         0      2380      3312      878         4  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{0}  1{10-11,15}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.88%    1.62%    0.00%                 0x0     1       1    69328  0xffffffffb65a7fc3         0      4668      3169      641         4  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{0,3}  1{15,31}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.88%    1.56%    0.00%                 0x0     1       1    69313  0xffffffffb65a7fc3         0      3608      3139      721         3  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{5}  1{13,31}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.88%    1.43%    0.00%                 0x0     1       1    69312  0xffffffffb65a7fc3         0      2151      2564      811         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      1{27}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.72%    1.59%    0.00%                 0x0     1       1    69330  0xffffffffb65a7fc3         0      2059      3368      930         3  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{4}  1{14,30}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.57%    1.62%    0.00%                 0x0     1       1    69332  0xffffffffb65a7fc3         0      2342      3242      943         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      1{28}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.57%    1.44%    0.00%                 0x0     1       1    69324  0xffffffffb65a7fc3         0      4454      2668      611         6  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{0-1}  1{10-11,13,26}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.57%    1.63%    0.00%                 0x0     1       1    69320  0xffffffffb65a7fc3         0      2668      3324      723         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      1{29}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.25%    0.26%    0.00%                 0x0     1       1    69304  0xffffffffb614db47         0      2712      2062      428         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          1{14,30}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.10%    0.35%    0.00%                 0x0     1       1    69330  0xffffffffb614db47         0      4019      2059      444         3  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{4}  1{14,30}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.10%    1.64%    0.00%                 0x0     1       1    69329  0xffffffffb65a7fc3         0      2220      2869      665         4  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{0,2}  1{12-13}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.10%    1.71%    0.00%                 0x0     1       1    69314  0xffffffffb65a7fc3         0      2639      3383      558         2  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{0}  1{9}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.10%    1.51%    0.00%                 0x0     1       1    69309  0xffffffffb65a7fc3         0      3718      2242      589         4  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{0,4}  1{12,24}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.97%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.94%    0.41%    0.00%                 0x0     1       1    69305  0xffffffffb614db47         0      1513      1986      396         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{0}  1{10-11,15}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.78%    0.00%    0.00%                 0x0     1       1    69332  0xffffffffb65a7fb0         0      1840      1587      348         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       1{28}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.78%    1.81%    0.00%                 0x0     1       1    69326  0xffffffffb65a7fc3         0      2865      3833      617         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      1{25}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.78%    1.48%    0.00%                 0x0     1       1    69323  0xffffffffb65a7fc3         0      2595      2472      549         2  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{3}  1{15}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --1.37%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.78%    0.24%    0.00%                 0x0     1       1    69306  0xffffffffb614db47         0      2155      1956      479         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          1{24}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.00%    0.00%                 0x0     1       1    69328  0xffffffffb65a7fb0         0       184      1498      236         4  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       0{0,3}  1{15,31}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.00%    0.00%                 0x0     1       1    69326  0xffffffffb65a7fb0         0      2268      1577      191         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       1{25}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    1.54%    0.00%                 0x0     1       1    69316  0xffffffffb65a7fc3         0      3768      2040      478         3  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{1-2}  1{13}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --1.27%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.63%    1.56%    0.00%                 0x0     1       1    69315  0xffffffffb65a7fc3         0      3110      2424      534         4  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{0-1}  1{11-12}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --1.17%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.63%    0.00%    0.00%                 0x0     1       1    69313  0xffffffffb65a7fb0         0       139      1604      311         4  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       0{0,5}  1{13,31}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.23%    0.00%                 0x0     1       1    69311  0xffffffffb614db47         0      2244      2165      472         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          1{8}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.26%    0.00%                 0x0     1       1    69308  0xffffffffb614db47         0      2112      1863      348         3  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{0}  1{9-10}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.00%    0.00%                 0x0     1       1    69304  0xffffffffb65a7fb0         0       652      1569      373         2  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       1{14,30}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.29%    0.00%                 0x0     1       1    69302  0xffffffffb614db47         0      1705      1356      462         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{22}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.47%    0.32%    0.00%                 0x0     1       1    69331  0xffffffffb614db47         0       718      1274      439         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{20}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.47%    1.72%    0.00%                 0x0     1       1    69331  0xffffffffb65a7fc3         0       272      1358      473         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{20}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.47%    0.00%    0.00%                 0x0     1       1    69330  0xffffffffb65a7fb0         0       257      1709      356         3  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       0{4}  1{14,30}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.47%    1.40%    0.00%                 0x0     1       1    69321  0xffffffffb65a7fc3         0      1588      1430      484         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{6}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.47%    0.29%    0.00%                 0x0     1       1    69317  0xffffffffb614db47         0       579      1392      344         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{16}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.47%    0.00%    0.00%                 0x0     1       1    69310  0xffffffffb65a7fb0         0       362      1458      312         5  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       0{0,4}  1{11-12,14}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.47%    1.44%    0.00%                 0x0     1       1    69310  0xffffffffb65a7fc3         0      8668      2515      742         5  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{0,4}  1{11-12,14}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.31%    0.29%    0.00%                 0x0     1       1    69328  0xffffffffb614db47         0      4094      1794      333         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{0,3}  1{15,31}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.31%    0.22%    0.00%                 0x0     1       1    69326  0xffffffffb614db47         0      2729      1882      243         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          1{25}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.31%    0.31%    0.00%                 0x0     1       1    69325  0xffffffffb614db47         0      1256      1315      438         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{21}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.31%    0.23%    0.00%                 0x0     1       1    69320  0xffffffffb614db47         0      3924      2127      359         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          1{29}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.31%    0.23%    0.00%                 0x0     1       1    69319  0xffffffffb614db47         0      2155      1405      326         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{18}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.31%    1.64%    0.00%                 0x0     1       1    69319  0xffffffffb65a7fc3         0       258      1435      356         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{18}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.31%    0.37%    0.00%                 0x0     1       1    69316  0xffffffffb614db47         0       353      1601      314         3  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{1-2}  1{13}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.32%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.31%    0.00%    0.00%                 0x0     1       1    69315  0xffffffffb65a7fb0         0       189      1406      235         4  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       0{0-1}  1{11-12}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.00%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.31%    0.29%    0.00%                 0x0     1       1    69313  0xffffffffb614db47         0      2494      1875      357         3  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{5}  1{13,31}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.31%    0.26%    0.00%                 0x0     1       1    69312  0xffffffffb614db47         0      2268      1916      439         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          1{27}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.31%    0.00%    0.00%                 0x0     1       1    69308  0xffffffffb65a7fb0         0       512      1574      254         3  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       0{0}  1{9-10}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.31%    1.44%    0.00%                 0x0     1       1    69307  0xffffffffb65a7fc3         0       257      1363      460         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{19}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.31%    0.00%    0.00%                 0x0     1       1    69306  0xffffffffb65a7fb0         0       227      1756      395         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       1{24}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.00%    0.00%                 0x0     1       1    69333  0xffffffffb65a7fb0         0       155      1323      316         2  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       0{5}  1{31}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.00%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.16%    1.51%   25.00%                 0x0     1       1    69333  0xffffffffb65a7fc3         0      3359      2357      599         2  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{5}  1{31}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --1.27%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.16%    0.45%    0.00%                 0x0     1       1    69332  0xffffffffb614db47         0       568      2146      431         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          1{28}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.17%    0.00%                 0x0     1       1    69329  0xffffffffb614db47         0      2155      1735      331         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{0,2}  1{12-13}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    1.47%    0.00%                 0x0     1       1    69325  0xffffffffb65a7fc3         0       587      1306      443         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{21}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.16%    0.36%    0.00%                 0x0     1       1    69324  0xffffffffb614db47         0      1046      1727      401         6  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{0-1}  1{10-11,13,26}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.27%    0.00%                 0x0     1       1    69323  0xffffffffb614db47         0      1305      1433      400         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{3}  1{15}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.27%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.16%    0.00%    0.00%                 0x0     1       1    69323  0xffffffffb65a7fb0         0      1478      1368      233         2  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       0{3}  1{15}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.00%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.16%    0.00%    0.00%                 0x0     1       1    69321  0xffffffffb65a7fb0         0       155      1207      364         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       0{6}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.16%    0.00%    0.00%                 0x0     1       1    69320  0xffffffffb65a7fb0         0       268      1564      259         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       1{29}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.00%    0.00%                 0x0     1       1    69320  0xffffffffb65a7fc7         0      4865         0        1         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+23      1{29}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    1.50%    0.00%                 0x0     1       1    69318  0xffffffffb65a7fc3         0       481      1498      376         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{17}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.16%    0.24%    0.00%                 0x0     1       1    69314  0xffffffffb614db47         0       539      1955      240         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{0}  1{9}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.00%    0.00%                 0x0     1       1    69314  0xffffffffb65a7fb0         0       397      1629      175         2  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       0{0}  1{9}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.00%    0.00%                 0x0     1       1    69312  0xffffffffb65a7fb0         0       106      1492      325         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       1{27}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.00%    0.00%                 0x0     1       1    69311  0xffffffffb65a7fb0         0       524      1696      377         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       1{8}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.25%    0.00%                 0x0     1       1    69310  0xffffffffb614db47         0       530      1922      432         5  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{0,4}  1{11-12,14}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.00%    0.00%                 0x0     1       1    69309  0xffffffffb65a7fb0         0       135      1359      339         4  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       0{0,4}  1{12,24}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.00%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.16%    0.00%    0.00%                 0x0     1       1    69305  0xffffffffb65a7fb0         0       828      1626      335         4  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+0       0{0}  1{10-11,15}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    1.56%    0.00%                 0x0     1       1    69302  0xffffffffb65a7fc3         0      5166      1538      441         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{22}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    0.25%    0.00%                 0x0     1       1    69333  0xffffffffb614db47         0         0      1542      447         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{5}  1{31}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.21%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.00%    0.01%    0.00%                 0x0     1       1    69330  0xffffffffb65a7fc7         0         0         0        1         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+23      1{14}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.00%    0.24%    0.00%                 0x0     1       1    69327  0xffffffffb614db47         0         0      1272      228         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{23}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.59%   25.00%                 0x0     1       1    69327  0xffffffffb65a7fc3         0         0      1383      327         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{23}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    0.27%    0.00%                 0x0     1       1    69322  0xffffffffb614db47         0         0      2049      360         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          1{10,26}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.00%    0.29%    0.00%                 0x0     1       1    69321  0xffffffffb614db47         0         0      1463      477         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{6}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    0.29%    0.00%                 0x0     1       1    69318  0xffffffffb614db47         0         0      1322      333         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{17}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.53%    0.00%                 0x0     1       1    69317  0xffffffffb65a7fc3         0         0      1425      370         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{16}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    0.36%   25.00%                 0x0     1       1    69315  0xffffffffb614db47         0         0      1716      420         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{0-1}  1{11-12}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.26%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.00%    0.25%    0.00%                 0x0     1       1    69309  0xffffffffb614db47         0         0      1505      444         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{0,4}  1{12,24}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.19%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.00%    0.24%    0.00%                 0x0     1       1    69307  0xffffffffb614db47         0         0      1327      464         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{19}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    0.27%    0.00%                 0x0     1       1    69303  0xffffffffb614db47         0         0      1255      245         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+71          0{7}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.32%    0.00%                 0x0     1       1    69303  0xffffffffb65a7fc3         0         0      1527      269         1  [k] refcount_dec_not_one     [kernel.kallsyms]  refcount_dec_not_one+19      0{7}
            |
            ---refcount_dec_not_one
               refcount_dec_and_lock_irqsave
               free_uid
               __sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    2.04%    0.13%    0.00%                 0x8     1       1    69332  0xffffffffb614db50         0      3339      3175      383         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          1{28}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.88%    0.10%    0.00%                 0x8     1       1    69306  0xffffffffb614db50         0      3299      3317      418         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{0}  1{24}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.72%    0.11%    0.00%                 0x8     1       1    69326  0xffffffffb614db50         0      5224      3304      196         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          1{25}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.41%    0.00%    0.00%                 0x8     1       1    69312  0xffffffffb614db79         0       833      1784      382         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         1{27}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.41%    1.13%    0.00%                 0x8     1       1    69311  0xffffffffb614dd6d         0      2073      2162      496         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   1{8}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.25%    0.00%    0.00%                 0x8     1       1    69311  0xffffffffb614db79         0      1411      1947      382         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         1{8}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.10%    0.00%    0.00%                 0x8     1       1    69332  0xffffffffb614db79         0       165      1885      378         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         1{28}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.10%    1.10%    0.00%                 0x8     1       1    69332  0xffffffffb614dd6d         0      1284      2043      510         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   1{28}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.10%    0.11%    0.00%                 0x8     1       1    69312  0xffffffffb614db50         0      1733      3024      400         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          1{27}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.10%    0.14%    0.00%                 0x8     1       1    69311  0xffffffffb614db50         0      5429      3503      395         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          1{8}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.10%    0.24%    0.00%                 0x8     1       1    69304  0xffffffffb614db50         0      3006      3424      438         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          1{14,30}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.94%    0.00%    0.00%                 0x8     1       1    69333  0xffffffffb614db79         0       927      1578      342         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{5}  1{31}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.00%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.94%    0.13%    0.00%                 0x8     1       1    69323  0xffffffffb614db50         0      2559      1784      370         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{3}  1{15}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.11%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.94%    1.15%    0.00%                 0x8     1       1    69322  0xffffffffb614dd6d         0      2101      2377      471         2  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   1{10,26}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.94%    0.14%    0.00%                 0x8     1       1    69320  0xffffffffb614db50         0      3379      3467      291         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          1{29}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.94%    0.23%    0.00%                 0x8     1       1    69315  0xffffffffb614db50         0      2694      2292      363         3  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{1}  1{11-12}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.13%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.94%    0.15%    0.00%                 0x8     1       1    69314  0xffffffffb614db50         0      4668      3664      207         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{0}  1{9}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.94%    0.00%    0.00%                 0x8     1       1    69310  0xffffffffb614db79         0      1052      1649      357         5  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{0,4}  1{11-12,14}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.94%    1.21%    0.00%                 0x8     1       1    69305  0xffffffffb614dd6d         0      3762      2192      505         4  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{0}  1{10-11,15}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.78%    0.13%    0.00%                 0x8     1       1    69330  0xffffffffb614db50         0      4796      3261      394         3  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{4}  1{14,30}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.78%    0.13%    0.00%                 0x8     1       1    69329  0xffffffffb614db50         0      4933      2661      362         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{0,2}  1{12-13}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.78%    0.21%    0.00%                 0x8     1       1    69328  0xffffffffb614db50         0      2024      2709      355         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{0,3}  1{15,31}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.78%    0.00%    0.00%                 0x8     1       1    69327  0xffffffffb614db79         0       713      1491      171         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{23}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.78%    1.07%    0.00%                 0x8     1       1    69324  0xffffffffb614dd6d         0      1167      1735      470         6  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{0-1}  1{10-11,13,26}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.78%    0.00%    0.00%                 0x8     1       1    69315  0xffffffffb614db79         0       905      1662      304         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{0-1}  1{11-12}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.00%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.78%    0.17%    0.00%                 0x8     1       1    69310  0xffffffffb614db50         0      3966      2485      455         5  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{0,4}  1{11-12,14}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.78%    0.00%    0.00%                 0x8     1       1    69306  0xffffffffb614db79         0       319      1920      400         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{0}  1{24}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.78%    1.25%    0.00%                 0x8     1       1    69304  0xffffffffb614dd6d         0      2821      2119      504         2  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   1{14,30}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    1.11%   25.00%                 0x8     1       1    69328  0xffffffffb614dd6d         0      6127      1867      433         4  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{0,3}  1{15,31}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.11%    0.00%                 0x8     1       1    69324  0xffffffffb614db50         0      2528      2503      338         6  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{0-1}  1{10-11,13,26}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.00%    0.00%                 0x8     1       1    69324  0xffffffffb614db79         0      1524      1614      288         6  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{0-1}  1{10-11,13,26}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.19%    0.00%                 0x8     1       1    69322  0xffffffffb614db50         0      2274      3267      350         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          1{10,26}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.23%    0.00%                 0x8     1       1    69317  0xffffffffb614db50         0      1428      1507      328         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{16}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.63%    0.00%    0.00%                 0x8     1       1    69314  0xffffffffb614db79         0      2186      1900      190         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{0}  1{9}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.08%    0.00%                 0x8     1       1    69308  0xffffffffb614db50         0      1196      2647      349         3  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{0}  1{9-10}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.95%    0.00%                 0x8     1       1    69308  0xffffffffb614dd6d         0      4316      1967      434         3  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{0}  1{9-10}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.21%    0.00%                 0x8     1       1    69305  0xffffffffb614db50         0      2395      3113      403         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{0}  1{10-11,15}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.00%    0.00%                 0x8     1       1    69305  0xffffffffb614db79         0       111      1851      339         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{0}  1{10-11,15}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.63%    0.00%    0.00%                 0x8     1       1    69304  0xffffffffb614db79         0      1844      1737      369         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         1{14,30}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.47%    0.12%    0.00%                 0x8     1       1    69333  0xffffffffb614db50         0      1989      2049      424         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{5}  1{31}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.10%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.47%    0.00%    0.00%                 0x8     1       1    69331  0xffffffffb614db79         0       769      1560      341         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{20}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.47%    0.00%    0.00%                 0x8     1       1    69329  0xffffffffb614db79         0       707      1714      332         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{0,2}  1{12-13}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.47%    0.00%    0.00%                 0x8     1       1    69326  0xffffffffb614db79         0       287      1957      196         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         1{25}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.47%    1.11%    0.00%                 0x8     1       1    69320  0xffffffffb614dd6d         0      4290      2169      435         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   1{29}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.47%    0.10%    0.00%                 0x8     1       1    69309  0xffffffffb614db50         0      3947      2072      425         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{0,4}  1{12,24}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.10%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.47%    1.05%    0.00%                 0x8     1       1    69306  0xffffffffb614dd6d         0       888      2073      545         2  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{0}  1{24}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.31%    0.12%    0.00%                 0x8     1       1    69331  0xffffffffb614db50         0      1148      1421      429         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{20}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.31%    0.00%    0.00%                 0x8     1       1    69330  0xffffffffb614db79         0       774      1699      369         3  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{4}  1{14,30}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.31%    1.15%    0.00%                 0x8     1       1    69330  0xffffffffb614dd6d         0      4734      1953      557         3  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{4}  1{14,30}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.31%    0.11%    0.00%                 0x8     1       1    69327  0xffffffffb614db50         0      2212      1619      189         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{23}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.31%    0.00%    0.00%                 0x8     1       1    69325  0xffffffffb614db79         0      4768      1514      327         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{21}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.31%    0.00%    0.00%                 0x8     1       1    69323  0xffffffffb614db79         0       180      1579      309         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{3}  1{15}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.00%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.31%    0.12%    0.00%                 0x8     1       1    69319  0xffffffffb614db50         0       516      1693      314         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{18}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.31%    0.25%    0.00%                 0x8     1       1    69318  0xffffffffb614db50         0       967      1602      312         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{17}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.31%    0.00%    0.00%                 0x8     1       1    69318  0xffffffffb614db79         0       312      1415      272         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{17}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.31%    0.17%    0.00%                 0x8     1       1    69316  0xffffffffb614db50         0       514      2005      303         3  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{1-2}  1{13}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.14%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.31%    1.02%    0.00%                 0x8     1       1    69316  0xffffffffb614dd6d         0      3670      1733      437         3  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{1-2}  1{13}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.84%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.31%    1.20%    0.00%                 0x8     1       1    69314  0xffffffffb614dd6d         0      1511      2096      352         2  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{0}  1{9}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.31%    1.02%    0.00%                 0x8     1       1    69312  0xffffffffb614dd6d         0      1366      1977      507         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   1{27}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.31%    0.00%    0.00%                 0x8     1       1    69309  0xffffffffb614db79         0       474      1759      350         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{0,4}  1{12,24}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.00%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.31%    1.19%    0.00%                 0x8     1       1    69309  0xffffffffb614dd6d         0      2850      1582      525         4  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{0,4}  1{12,24}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.89%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.31%    0.00%    0.00%                 0x8     1       1    69307  0xffffffffb614db79         0       110      1365      327         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{19}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.31%    0.00%    0.00%                 0x8     1       1    69303  0xffffffffb614db79         0       351      1335      170         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{7}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.31%    0.14%    0.00%                 0x8     1       1    69302  0xffffffffb614db50         0       650      1476      477         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{22}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.16%    1.25%    0.00%                 0x8     1       1    69333  0xffffffffb614dd6d         0       467      1630      533         2  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{5}  1{31}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --1.10%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.16%    0.00%    0.00%                 0x8     1       1    69328  0xffffffffb614db79         0       150      1767      259         4  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{0,3}  1{15,31}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.98%    0.00%                 0x8     1       1    69326  0xffffffffb614dd6d         0       300      2207      283         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   1{25}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.00%    0.00%                 0x8     1       1    69322  0xffffffffb614db79         0       739      1786      344         2  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         1{10,26}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.12%    0.00%                 0x8     1       1    69321  0xffffffffb614db50         0      1239      1479      466         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{6}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.16%    0.00%    0.00%                 0x8     1       1    69321  0xffffffffb614db79         0       135      1473      366         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{6}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.16%    0.00%    0.00%                 0x8     1       1    69320  0xffffffffb614db79         0       541      1862      291         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         1{29}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.00%    0.00%                 0x8     1       1    69317  0xffffffffb614db79         0      1012      1423      256         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{16}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.16%    1.20%    0.00%                 0x8     1       1    69317  0xffffffffb614dd6d         0       639      1233      426         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{16}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.16%    0.00%    0.00%                 0x8     1       1    69316  0xffffffffb614db79         0       126      1357      274         3  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{1-2}  1{13}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.00%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.16%    0.15%    0.00%                 0x8     1       1    69313  0xffffffffb614db50         0      1076      2863      343         3  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{5}  1{13,31}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    1.45%    0.00%                 0x8     1       1    69313  0xffffffffb614dd6d         0      2495      1924      466         3  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{5}  1{13,31}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    1.33%    0.00%                 0x8     1       1    69310  0xffffffffb614dd6d         0      5298      1912      547         5  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{0,4}  1{11-12,14}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.16%    0.11%    0.00%                 0x8     1       1    69307  0xffffffffb614db50         0      4484      1436      461         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{19}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.16%    0.00%    0.00%                 0x8     1       1    69302  0xffffffffb614db79         0       958      1427      374         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+121         0{22}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.21%    0.00%                 0x8     1       1    69331  0xffffffffb614dd6d         0         0      1307      508         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{20}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.09%    0.00%                 0x8     1       1    69329  0xffffffffb614dd6d         0         0      1840      479         4  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{0,2}  1{12-13}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.00%    0.85%    0.00%                 0x8     1       1    69327  0xffffffffb614dd6d         0         0      1509      288         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{23}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    0.16%    0.00%                 0x8     1       1    69325  0xffffffffb614db50         0         0      1460      430         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{21}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.28%    0.00%                 0x8     1       1    69325  0xffffffffb614dd6d         0         0      1368      512         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{21}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.17%    0.00%                 0x8     1       1    69323  0xffffffffb614dd6d         0         0      1661      487         2  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{3}  1{15}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --1.08%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.00%    1.15%    0.00%                 0x8     1       1    69321  0xffffffffb614dd6d         0         0      1450      572         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{6}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.28%    0.00%                 0x8     1       1    69319  0xffffffffb614dd6d         0         0      1383      414         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{18}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    0.93%    0.00%                 0x8     1       1    69318  0xffffffffb614dd6d         0         0      1394      393         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{17}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.15%    0.00%                 0x8     1       1    69315  0xffffffffb614dd6d         0         0      1777      432         4  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{0-1}  1{11-12}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.85%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.00%    1.08%    0.00%                 0x8     1       1    69307  0xffffffffb614dd6d         0         0      1379      516         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{19}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    0.15%    0.00%                 0x8     1       1    69303  0xffffffffb614db50         0         0      1587      232         1  [k] __sigqueue_alloc         [kernel.kallsyms]  __sigqueue_alloc+80          0{7}
            |
            ---__sigqueue_alloc
               __send_signal
               do_send_sig_info
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.16%    0.00%                 0x8     1       1    69303  0xffffffffb614dd6d         0         0      1410      325         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{7}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.27%    0.00%                 0x8     1       1    69302  0xffffffffb614dd6d         0         0      1389      541         1  [k] __sigqueue_free.part.23  [kernel.kallsyms]  __sigqueue_free.part.23+13   0{22}
            |
            ---__sigqueue_free.part.23
               __dequeue_signal
               dequeue_signal
               get_signal
               do_signal
               exit_to_usermode_loop
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d


  -------------------------------------------------------------
      1        0      131     2697        0  0xffff8dd0b3048e80
  -------------------------------------------------------------
           0.00%    4.58%    1.37%    0.00%                0x30     1       1    69332  0xffffffffb651e4bc         0      2044      1012      421         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     1{28}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    4.58%    0.93%    0.00%                0x30     1       1    69311  0xffffffffb651e4bc         0      2600      1118      434         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     1{8}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    4.58%    2.08%    0.00%                0x30     1       1    69304  0xffffffffb652dd38         0      1982       902      371         2  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   1{14,30}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    3.82%    2.45%    0.00%                0x30     1       1    69332  0xffffffffb652dd38         0      2012       842      395         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   1{28}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    3.82%    0.93%    0.00%                0x30     1       1    69310  0xffffffffb651e4bc         0      1878       828      445         5  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{0,4}  1{11-12,14}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    3.05%    1.59%    0.00%                0x30     1       1    69330  0xffffffffb652dd38         0      3707       851      361         3  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{4}  1{14,30}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    3.05%    2.60%    0.00%                0x30     1       1    69329  0xffffffffb652dd38         0      3352       745      348         4  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{0,2}  1{12-13}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    3.05%    2.41%    0.00%                0x30     1       1    69324  0xffffffffb652dd38         0      1050       700      318         6  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{0-1}  1{10-11,13,26}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    3.05%    1.04%    0.00%                0x30     1       1    69321  0xffffffffb651e4bc         0       986       619      435         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{6}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    3.05%    1.30%    0.00%                0x30     1       1    69313  0xffffffffb651e4bc         0      1748       848      373         3  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{5}  1{13,31}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    3.05%    1.85%    0.00%                0x30     1       1    69312  0xffffffffb652dd38         0      1504       907      369         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   1{27}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    3.05%    2.37%    0.00%                0x30     1       1    69309  0xffffffffb652dd38         0       729       798      350         4  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{0,4}  1{12,24}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --1.18%--__libc_start_main
                          0x495641000028bb3d

           0.00%    3.05%    2.56%    0.00%                0x30     1       1    69307  0xffffffffb652dd38         0      1349       607      369         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{19}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    3.05%    1.93%    0.00%                0x30     1       1    69306  0xffffffffb652dd38         0      1863       879      371         2  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{0}  1{24}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    3.05%    1.11%    0.00%                0x30     1       1    69304  0xffffffffb651e4bc         0      2368      1010      483         2  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     1{14,30}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    2.29%    1.04%    0.00%                0x30     1       1    69331  0xffffffffb651e4bc         0      1025       672      442         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{20}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    2.29%    0.85%    0.00%                0x30     1       1    69322  0xffffffffb651e4bc         0      2129      1084      385         2  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     1{10,26}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    2.29%    1.15%    0.00%                0x30     1       1    69320  0xffffffffb651e4bc         0      2085       857      342         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     1{29}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    2.29%    0.85%    0.00%                0x30     1       1    69307  0xffffffffb651e4bc         0      2170       719      392         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{19}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    2.29%    1.56%    0.00%                0x30     1       1    69305  0xffffffffb652dd38         0      1109       865      339         4  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{0}  1{10-11,15}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    2.29%    1.26%    0.00%                0x30     1       1    69302  0xffffffffb651e4bc         0      1099       699      485         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{22}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    1.53%    1.33%    0.00%                0x30     1       1    69333  0xffffffffb652dd38         0      1270       579      359         2  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{5}  1{31}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --1.11%--__libc_start_main
                          0x495641000028bb3d

           0.00%    1.53%    2.41%    0.00%                0x30     1       1    69331  0xffffffffb652dd38         0       357       667      352         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{20}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    1.53%    0.74%    0.00%                0x30     1       1    69326  0xffffffffb651e4bc         0      2392      1212      187         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     1{25}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.53%    1.41%    0.00%                0x30     1       1    69325  0xffffffffb652dd38         0      4136       528      348         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{21}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    1.53%    2.26%    0.00%                0x30     1       1    69320  0xffffffffb652dd38         0      2262       942      306         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   1{29}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.53%    1.08%    0.00%                0x30     1       1    69319  0xffffffffb651e4bc         0       920       695      308         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{18}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    1.53%    0.56%    0.00%                0x30     1       1    69315  0xffffffffb651e4bc         0      1002       933      302         4  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{0-1}  1{11-12}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.38%--__libc_start_main
                          0x495641000028bb3d

           0.00%    1.53%    1.45%    0.00%                0x30     1       1    69313  0xffffffffb652dd38         0      4010       839      354         3  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{5}  1{13,31}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.53%    1.89%    0.00%                0x30     1       1    69311  0xffffffffb652dd38         0      1188       893      352         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   1{8}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.53%    2.22%    0.00%                0x30     1       1    69310  0xffffffffb652dd38         0      2246       710      353         5  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{0,4}  1{11-12,14}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.53%    1.08%    0.00%                0x30     1       1    69309  0xffffffffb651e4bc         0      1501       782      413         4  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{0,4}  1{12,24}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.83%--__libc_start_main
                          0x495641000028bb3d

           0.00%    1.53%    1.37%    0.00%                0x30     1       1    69308  0xffffffffb651e4bc         0      1138       805      351         3  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{0}  1{9-10}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.53%    0.78%    0.00%                0x30     1       1    69305  0xffffffffb651e4bc         0      1060      1109      377         4  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{0}  1{10-11,15}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    1.53%    1.11%    0.00%                0x30     1       1    69303  0xffffffffb651e4bc         0       480       632      194         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{7}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    1.53%    2.56%    0.00%                0x30     1       1    69302  0xffffffffb652dd38         0      1978       623      370         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{22}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.76%    0.70%    0.00%                0x30     1       1    69333  0xffffffffb651e4bc         0       863       854      418         2  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{5}  1{31}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.72%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.76%    1.63%    0.00%                0x30     1       1    69329  0xffffffffb651e4bc         0       358       837      344         4  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{0,2}  1{12-13}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.76%    1.30%    0.00%                0x30     1       1    69328  0xffffffffb651e4bc         0       447      1007      336         4  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{0,3}  1{15,31}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.76%    1.41%    0.00%                0x30     1       1    69328  0xffffffffb652dd38         0      2170       974      289         4  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{0,3}  1{15,31}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.76%    1.89%    0.00%                0x30     1       1    69326  0xffffffffb652dd38         0       508      1004      215         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   1{25}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.76%    0.82%    0.00%                0x30     1       1    69324  0xffffffffb651e4bc         0       700       895      357         6  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{0-1}  1{10-11,13,26}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.76%    1.19%    0.00%                0x30     1       1    69323  0xffffffffb651e4bc         0      3029       802      400         2  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{3}  1{15}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --1.04%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.76%    1.78%    0.00%                0x30     1       1    69323  0xffffffffb652dd38         0       901       795      310         2  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{3}  1{15}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --1.80%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.76%    2.41%    0.00%                0x30     1       1    69322  0xffffffffb652dd38         0      1907       925      388         2  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   1{10,26}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.76%    2.26%    0.00%                0x30     1       1    69321  0xffffffffb652dd38         0       431       613      348         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{6}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.76%    2.34%    0.00%                0x30     1       1    69319  0xffffffffb652dd38         0       166       655      273         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{18}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.76%    2.60%    0.00%                0x30     1       1    69317  0xffffffffb652dd38         0       927       574      300         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{16}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.76%    1.04%    0.00%                0x30     1       1    69316  0xffffffffb651e4bc         0       450       716      325         3  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{1-2}  1{13}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --0.95%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.76%    0.93%    0.00%                0x30     1       1    69312  0xffffffffb651e4bc         0       623       966      405         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     1{27}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.76%    2.52%    0.00%                0x30     1       1    69308  0xffffffffb652dd38         0      1523       835      325         3  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{0}  1{9-10}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.00%    1.00%    0.00%                0x30     1       1    69330  0xffffffffb651e4bc         0         0      1017      398         3  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{4}  1{14,30}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.00%    1.19%    0.00%                0x30     1       1    69327  0xffffffffb651e4bc         0         0       589      207         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{23}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.41%    0.00%                0x30     1       1    69327  0xffffffffb652dd38         0         0       626      145         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{23}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    0.96%    0.00%                0x30     1       1    69325  0xffffffffb651e4bc         0         0       658      425         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{21}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.08%    0.00%                0x30     1       1    69318  0xffffffffb651e4bc         0         0       655      282         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{17}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    2.30%    0.00%                0x30     1       1    69318  0xffffffffb652dd38         0         0       748      257         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{17}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    1.22%    0.00%                0x30     1       1    69317  0xffffffffb651e4bc         0         0       663      283         1  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{16}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d

           0.00%    0.00%    2.86%    0.00%                0x30     1       1    69316  0xffffffffb652dd38         0         0       649      324         3  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{1-2}  1{13}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --2.11%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.00%    2.26%    0.00%                0x30     1       1    69315  0xffffffffb652dd38         0         0       732      339         4  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{0-1}  1{11-12}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               |          
                --1.85%--__libc_start_main
                          0x495641000028bb3d

           0.00%    0.00%    1.15%    0.00%                0x30     1       1    69314  0xffffffffb651e4bc         0         0      1157      226         2  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{0}  1{9}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.00%    1.82%    0.00%                0x30     1       1    69314  0xffffffffb652dd38         0         0       810      242         2  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{0}  1{9}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.00%    0.85%    0.00%                0x30     1       1    69306  0xffffffffb651e4bc         0         0      1098      431         2  [k] aa_get_task_label   [kernel.kallsyms]  aa_get_task_label+76     0{0}  1{24}
            |
            ---aa_get_task_label
               apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main

           0.00%    0.00%    1.63%    0.00%                0x30     1       1    69303  0xffffffffb652dd38         0         0       659      172         1  [k] apparmor_task_kill  [kernel.kallsyms]  apparmor_task_kill+424   0{7}
            |
            ---apparmor_task_kill
               security_task_kill
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main
               __libc_start_main
               0x495641000028bb3d


  -------------------------------------------------------------
      2        0        1        0        0  0xffff8dc0b59fc4c0
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x1c     0       1    69333  0xffffffffb6182a75         0       180         0        1         1  [k] update_sd_lb_stats  [kernel.kallsyms]  update_sd_lb_stats+501   0{5}
            |
            ---update_sd_lb_stats
               find_busiest_group
               load_balance
               rebalance_domains
               __softirqentry_text_start
               irq_exit
               smp_apic_timer_interrupt
               apic_timer_interrupt
               _raw_spin_unlock_irq
               __x64_sys_rt_sigreturn
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               __restore_rt
               main
               __libc_start_main
               0x495641000028bb3d


  -------------------------------------------------------------
      3        0        1        0        0  0xffff8dc601172a00
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x28     1       1    69548  0xffffffffb6142915         0       122         0        1         1  [k] wait_consider_task  [kernel.kallsyms]  wait_consider_task+181   1{10}
            |
            ---wait_consider_task
               do_wait
               kernel_wait4
               __do_sys_wait4
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               __GI___wait4
               0x558c61717ca0


  -------------------------------------------------------------
      4        0        1        0        0  0xffff8dd0b49fc4c0
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x1c     1       1    69311  0xffffffffb6182a75         0       138         0        1         1  [k] update_sd_lb_stats   [kernel.kallsyms]  update_sd_lb_stats+501   1{8}
            |
            ---update_sd_lb_stats
               find_busiest_group
               load_balance
               rebalance_domains
               __softirqentry_text_start
               irq_exit
               smp_apic_timer_interrupt
               apic_timer_interrupt
               lock_acquire
               audit_signal_info
               check_kill_permission
               do_send_specific
               do_tkill
               __x64_sys_tgkill
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               raise
               main


  -------------------------------------------------------------
      5        0        1        0        0  0xffff8dd0b59fce00
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x38     1       1    69536  0xffffffffb6174bb9         0       115         0        1         1  [k] available_idle_cpu  [kernel.kallsyms]  available_idle_cpu+25   1{12}
            |
            ---available_idle_cpu
               select_idle_sibling
               select_task_rq_fair
               try_to_wake_up
               pollwake
               __wake_up_common
               __wake_up_common_lock
               sock_def_wakeup
               unix_release_sock
               unix_release
               __sock_release
               sock_close
               __fput
               task_work_run
               do_exit
               do_group_exit
               __x64_sys_exit_group
               do_syscall_64
               entry_SYSCALL_64_after_hwframe


  -------------------------------------------------------------
      6        0        1        0        0  0xffff8dd0b59fce80
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x38     1       1    69311  0xffffffffb6182ad2         0       149         0        1         1  [k] update_sd_lb_stats  [kernel.kallsyms]  update_sd_lb_stats+594   1{8}
            |
            ---update_sd_lb_stats
               find_busiest_group
               load_balance
               rebalance_domains
               __softirqentry_text_start
               irq_exit
               smp_apic_timer_interrupt
               apic_timer_interrupt
               restore_sigcontext
               __x64_sys_rt_sigreturn
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               __restore_rt
               main


  -------------------------------------------------------------
      7        0        1        0        0      0x7f524f675440
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x18     1       1    69475  0xffffffffb6c16d0c         0       118         0        1         1  [k] copy_user_generic_string  [kernel.kallsyms]  copy_user_generic_string+44   1{31}
            |
            ---copy_user_generic_string
               copyin
               iov_iter_copy_from_user_atomic
               generic_perform_write
               __generic_file_write_iter
               generic_file_write_iter
               new_sync_write
               vfs_write
               ksys_write
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               __write_nocancel
               record__pushfn
               perf_mmap__push
               record__mmap_read_evlist.constprop.33
               cmd_record
               perf_c2c__record
               run_builtin
               main
               __libc_start_main
               0x591e258d4c544155


  -------------------------------------------------------------
      8        0        1        0        0      0x7f524f78a900
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                 0x0     0       1    69475  0xffffffffb6c16d0c         0        79         0        1         1  [k] copy_user_generic_string  [kernel.kallsyms]  copy_user_generic_string+44   0{4}
            |
            ---copy_user_generic_string
               copyin
               iov_iter_copy_from_user_atomic
               generic_perform_write
               __generic_file_write_iter
               generic_file_write_iter
               new_sync_write
               vfs_write
               ksys_write
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               __write_nocancel
               record__pushfn
               perf_mmap__push
               record__mmap_read_evlist.constprop.33
               cmd_record
               perf_c2c__record
               run_builtin
               main
               __libc_start_main
               0x591e258d4c544155


  -------------------------------------------------------------
      9        0        1        0        0      0x7f524f7da8c0
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                 0x8     0       1    69475  0xffffffffb6c16d0c         0       156         0        1         1  [k] copy_user_generic_string  [kernel.kallsyms]  copy_user_generic_string+44   0{4}
            |
            ---copy_user_generic_string
               copyin
               iov_iter_copy_from_user_atomic
               generic_perform_write
               __generic_file_write_iter
               generic_file_write_iter
               new_sync_write
               vfs_write
               ksys_write
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               __write_nocancel
               record__pushfn
               perf_mmap__push
               record__mmap_read_evlist.constprop.33
               cmd_record
               perf_c2c__record
               run_builtin
               main
               __libc_start_main
               0x591e258d4c544155


  -------------------------------------------------------------
     10        0        1        0        0      0x7f524f994340
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                 0x8     0       1    69475  0xffffffffb6c16d0c         0       109         0        1         1  [k] copy_user_generic_string  [kernel.kallsyms]  copy_user_generic_string+44   0{19}
            |
            ---copy_user_generic_string
               copyin
               iov_iter_copy_from_user_atomic
               generic_perform_write
               __generic_file_write_iter
               generic_file_write_iter
               new_sync_write
               vfs_write
               ksys_write
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               __write_nocancel
               record__pushfn
               perf_mmap__push
               record__mmap_read_evlist.constprop.33
               cmd_record
               perf_c2c__record
               run_builtin
               main
               __libc_start_main
               0x591e258d4c544155


  -------------------------------------------------------------
     11        0        1        0        0      0x7f524f9eb6c0
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                 0x8     0       1    69475  0xffffffffb6c16d0c         0       110         0        1         1  [k] copy_user_generic_string  [kernel.kallsyms]  copy_user_generic_string+44   0{6}
            |
            ---copy_user_generic_string
               copyin
               iov_iter_copy_from_user_atomic
               generic_perform_write
               __generic_file_write_iter
               generic_file_write_iter
               new_sync_write
               vfs_write
               ksys_write
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               __write_nocancel
               record__pushfn
               perf_mmap__push
               record__mmap_read_evlist.constprop.33
               cmd_record
               perf_c2c__record
               run_builtin
               main
               __libc_start_main
               0x591e258d4c544155


  -------------------------------------------------------------
     12        0        1        0        0      0x7f524fc380c0
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x28     1       1    69475  0xffffffffb6c16d0c         0       109         0        1         1  [k] copy_user_generic_string  [kernel.kallsyms]  copy_user_generic_string+44   1{30}
            |
            ---copy_user_generic_string
               copyin
               iov_iter_copy_from_user_atomic
               generic_perform_write
               __generic_file_write_iter
               generic_file_write_iter
               new_sync_write
               vfs_write
               ksys_write
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               __write_nocancel
               record__pushfn
               perf_mmap__push
               record__mmap_read_evlist.constprop.33
               cmd_record
               perf_c2c__record
               run_builtin
               main
               __libc_start_main
               0x591e258d4c544155


  -------------------------------------------------------------
     13        0        1        0        0      0x7f524fd86240
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x30     1       1    69475  0xffffffffb65a4552         0       119         0        1         1  [k] iov_iter_fault_in_readable  [kernel.kallsyms]  iov_iter_fault_in_readable+82   1{13}
            |
            ---iov_iter_fault_in_readable
               generic_perform_write
               __generic_file_write_iter
               generic_file_write_iter
               new_sync_write
               vfs_write
               ksys_write
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               __write_nocancel
               record__pushfn
               perf_mmap__push
               record__mmap_read_evlist.constprop.33
               cmd_record
               perf_c2c__record
               run_builtin
               main
               __libc_start_main
               0x591e258d4c544155


  -------------------------------------------------------------
     14        0        1        0        0      0x7f524fde2080
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                 0x8     1       1    69475  0xffffffffb6c16d0c         0       240         0        1         1  [k] copy_user_generic_string  [kernel.kallsyms]  copy_user_generic_string+44   1{25}
            |
            ---copy_user_generic_string
               copyin
               iov_iter_copy_from_user_atomic
               generic_perform_write
               __generic_file_write_iter
               generic_file_write_iter
               new_sync_write
               vfs_write
               ksys_write
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               __write_nocancel
               record__pushfn
               perf_mmap__push
               record__mmap_read_evlist.constprop.33
               cmd_record
               perf_c2c__record
               run_builtin
               main
               __libc_start_main
               0x591e258d4c544155


  -------------------------------------------------------------
     15        0        1        0        0      0x7f525012acc0
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                0x10     0       1    69475  0xffffffffb6c16d0c         0       111         0        1         1  [k] copy_user_generic_string  [kernel.kallsyms]  copy_user_generic_string+44   0{4}
            |
            ---copy_user_generic_string
               copyin
               iov_iter_copy_from_user_atomic
               generic_perform_write
               __generic_file_write_iter
               generic_file_write_iter
               new_sync_write
               vfs_write
               ksys_write
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               __write_nocancel
               record__pushfn
               perf_mmap__push
               record__mmap_read_evlist.constprop.33
               cmd_record
               perf_c2c__record
               run_builtin
               main
               __libc_start_main
               0x591e258d4c544155


  -------------------------------------------------------------
     16        0        1        0        0      0x7f5253a404c0
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                 0x0     0       1    69475  0xffffffffb6c16d0c         0       101         0        1         1  [k] copy_user_generic_string  [kernel.kallsyms]  copy_user_generic_string+44   0{22}
            |
            ---copy_user_generic_string
               copyin
               iov_iter_copy_from_user_atomic
               generic_perform_write
               __generic_file_write_iter
               generic_file_write_iter
               new_sync_write
               vfs_write
               ksys_write
               do_syscall_64
               entry_SYSCALL_64_after_hwframe
               __write_nocancel
               record__pushfn
               perf_mmap__push
               record__mmap_read_evlist.constprop.33
               cmd_record
               perf_c2c__record
               run_builtin
               main
               __libc_start_main
               0x591e258d4c544155


  -------------------------------------------------------------
     17        0        1        0        0      0x7f5250013400
  -------------------------------------------------------------
           0.00%  100.00%    0.00%    0.00%                 0x0   0-1      18    69475            0x4ce063         0       201       262       14        14  [.] perf_mmap__push         perf  compiler.h:111   0{2-3,18,20,22}  1{8-9,13-14,25,27,29-31}
            |
            ---perf_mmap__push
               record__mmap_read_evlist.constprop.33
               cmd_record
               perf_c2c__record
               run_builtin
               main
               __libc_start_main
               0x591e258d4c544155


--vtzGhvizbBRQ85DL--
