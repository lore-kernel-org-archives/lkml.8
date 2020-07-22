Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DB3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE5220771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgGVGRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:17:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:50353 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVGRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:17:40 -0400
IronPort-SDR: r8ptN+x2WNp7xYWbjOIbq0jSxO57LgJdi/CqJOb/6FQMdgiypCCDu/OvfLH6bpfvJHsDBXyEES
 1xGjwz7enXuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="211820481"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="211820481"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 23:17:08 -0700
IronPort-SDR: 6UfQmf91WNZV1W5heRufj1VqWEbSEbiET43MflV3zaHFJKxugjy2BfU/uQd046x0WpaVe21UG5
 y1xzX37AnYvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="318575905"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.4.18]) ([10.238.4.18])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2020 23:17:06 -0700
Subject: Re: [ext4] d3b6f23f71: stress-ng.fiemap.ops_per_sec -60.5% regression
To:     Ritesh Harjani <riteshh@linux.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, kbuild test robot <lkp@intel.com>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200407080036.GA8179@shao2-debian>
 <20200715110437.7D0A3AE051@d06av26.portsmouth.uk.ibm.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <705b788f-aac3-f622-a286-ecd99deb5ca9@linux.intel.com>
Date:   Wed, 22 Jul 2020 14:17:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715110437.7D0A3AE051@d06av26.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/2020 7:04 PM, Ritesh Harjani wrote:
> Hello Xing,
> 
> On 4/7/20 1:30 PM, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a -60.5% regression of stress-ng.fiemap.ops_per_sec 
>> due to commit:
>>
>>
>> commit: d3b6f23f71670007817a5d59f3fbafab2b794e8c ("ext4: move 
>> ext4_fiemap to use iomap framework")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: stress-ng
>> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz 
>> with 192G memory
>> with following parameters:
>>
>>     nr_threads: 10%
>>     disk: 1HDD
>>     testtime: 1s
>>     class: os
>>     cpufreq_governor: performance
>>     ucode: 0x500002c
>>     fs: ext4
> 
> I started looking into this issue. But with my unit testing, I didn't
> find any perf issue with fiemap ioctl call. I haven't yet explored about
> how stress-ng take fiemap performance numbers, it could be doing
> something differently. But in my testing I just made sure to create a
> file with large number of extents and used xfs_io -c "fiemap -v" cmd
> to check how much time it takes to read all the entries in 1st
> and subsequent iterations.
> 
> 
> Setup comprised of qemu machine on x86_64 with latest linux branch.
> 
> 1. created a file of 10G using fallocate. (this allocated unwritten
> extents for this file).
> 
> 2. Then I punched hole on every alternate block of file. This step took
> a long time. And after sufficiently long time, I had to cancel it.
> for i in $(seq 1 2 xxxxx); do echo $i; fallocate -p -o $(($i*4096)) -l 
> 4096; done
> 
> 3. Then issued fiemap call via xfs_io and took the time measurement.
> time xfs_io -c "fiemap -v" bigfile > /dev/null
> 
> 
> Perf numbers on latest default kernel build for above cmd.
> 
> 1st iteration
> ==============
> real    0m31.684s
> user    0m1.593s
> sys     0m24.174s
> 
> 2nd and subsequent iteration
> ============================
> real    0m3.379s
> user    0m1.300s
> sys     0m2.080s
> 
> 
> 4. Then I reverted all the iomap_fiemap patches and re-tested this.
> With this the older ext4_fiemap implementation will be tested:-
> 
> 
> 1st iteration
> ==============
> real    0m31.591s
> user    0m1.400s
> sys     0m24.243s
> 
> 
> 2nd and subsequent iteration (had to cancel it since it was taking more 
> time then 15m)
> ============================
> ^C^C
> real    15m49.884s
> user    0m0.032s
> sys     15m49.722s
> 
> I guess the reason why 2nd iteration with older implementation is taking
> too much time is since with previous implementation we never cached
> extent entries in extent_status tree. And also in 1st iteration the page
> cache may get filled with lot of buffer_head entries. So maybe page
> reclaims are taking more time.
> 
> While with the latest implementation using iomap_fiemap(), the call to 
> query extent blocks is done using ext4_map_blocks(). ext4_map_blocks()
> by default will also cache the extent entries into extent_status tree.
> Hence during 2nd iteration, we will directly read the entries from 
> extent_status tree and will not do any disk I/O.
> 
> -ritesh

Could you try stress-ng( https://kernel.ubuntu.com/~cking/stress-ng/) 
test cases?  The tarballs can be get from 
https://kernel.ubuntu.com/~cking/tarballs/stress-ng/.
The command for this case you can try "stress-ng --timeout 1 --times 
--verify --metrics-brief --sequential 9 --class os --minimize --exclude 
spawn,exec,swap"
I re-test it on the v5.8-rc6, the regression still existed.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/debug-setup/nr_threads/disk/testtime/fs/class/cpufreq_governor/ucode:
 
lkp-csl-2sp5/stress-ng/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/test/10%/1HDD/1s/ext4/os/performance/0x5002f01

commit:
   b2c5764262edded1b1cfff5a6ca82c3d61bb4a4a
   d3b6f23f71670007817a5d59f3fbafab2b794e8c
   v5.8-rc6

b2c5764262edded1 d3b6f23f71670007817a5d59f3f                    v5.8-rc6
---------------- --------------------------- ---------------------------
          %stddev     %change         %stddev     %change         %stddev
              \          |                \          |                \
      20419 ±  3%      -4.9%      19423 ±  4%     +27.1%      25959 
   stress-ng.af-alg.ops
      19655 ±  3%      -5.7%      18537 ±  4%     +27.8%      25111 
   stress-ng.af-alg.ops_per_sec
      64.67 ±  5%     -17.0%      53.67 ± 38%     +22.2%      79.00 ± 
9%  stress-ng.chdir.ops
      55.34 ±  3%     -13.3%      47.99 ± 38%     +26.4%      69.96 ± 
10%  stress-ng.chdir.ops_per_sec
      64652 ±  7%     -14.1%      55545 ± 11%     -13.6%      55842 ± 
6%  stress-ng.chown.ops
      64683 ±  7%     -14.1%      55565 ± 11%     -13.6%      55858 ± 
6%  stress-ng.chown.ops_per_sec
       2805 ±  2%      +0.6%       2820 ±  2%    +130.0%       6452 
   stress-ng.clone.ops
       2802 ±  2%      +0.6%       2818 ±  2%    +129.9%       6443 
   stress-ng.clone.ops_per_sec
      34.67            +1.9%      35.33 ±  3%      -9.6%      31.33 ± 
3%  stress-ng.copy-file.ops
      22297 ± 23%     +26.7%      28258 ±  2%     +38.1%      30783 ± 
14%  stress-ng.dir.ops_per_sec
       4743 ±  7%     -12.6%       4147 ±  4%     -19.9%       3801 ± 
14%  stress-ng.dirdeep.ops_per_sec
      24499 ±  8%      -9.3%      22223 ±  3%     -19.8%      19647 ± 
2%  stress-ng.enosys.ops
      24494 ±  8%      -9.3%      22207 ±  3%     -19.8%      19637 ± 
2%  stress-ng.enosys.ops_per_sec
      76618           -63.8%      27756 ±  5%     -55.5%      34092 ± 
2%  stress-ng.fiemap.ops
      76042           -63.8%      27492 ±  5%     -55.4%      33899 ± 
2%  stress-ng.fiemap.ops_per_sec
    3816791            -6.2%    3581880 ±  2%     -10.7%    3409584 ± 
3%  stress-ng.file-ioctl.ops
    3817421            -6.2%    3582248 ±  2%     -10.7%    3409544 ± 
3%  stress-ng.file-ioctl.ops_per_sec
      27332 ± 17%     +30.2%      35574           +37.2%      37506 ± 
6%  stress-ng.filename.ops
      26222 ± 16%     +28.6%      33722           +35.6%      35567 ± 
6%  stress-ng.filename.ops_per_sec
      23431 ±  2%      +0.5%      23559           +22.5%      28711 ± 
4%  stress-ng.fork.ops
      23433 ±  2%      +0.5%      23558           +22.5%      28709 ± 
4%  stress-ng.fork.ops_per_sec
      48074 ± 15%      -0.6%      47786 ±  9%     -42.5%      27623 
   stress-ng.get.ops
      48088 ± 15%      -0.6%      47793 ±  9%     -42.6%      27624 
   stress-ng.get.ops_per_sec
     111379            -1.4%     109815 ±  2%      -7.8%     102662 ± 
4%  stress-ng.getdent.ops
     111398            -1.4%     109818 ±  2%      -7.9%     102651 ± 
4%  stress-ng.getdent.ops_per_sec
     226.67 ±  2%      -1.0%     224.33           -15.1%     192.33 ± 
6%  stress-ng.inotify.ops
     226.39 ±  2%      -1.3%     223.53           -15.3%     191.82 ± 
6%  stress-ng.inotify.ops_per_sec
      18.00            +9.3%      19.67 ±  2%      +3.7%      18.67 ± 
2%  stress-ng.iomix.ops
       4846 ± 10%      +2.9%       4984 ±  7%     -36.8%       3062 ± 
7%  stress-ng.kill.ops
       4846 ± 10%      +2.8%       4982 ±  7%     -36.9%       3058 ± 
7%  stress-ng.kill.ops_per_sec
     851324 ±  3%      -9.9%     766988 ±  2%      +2.3%     870703 
   stress-ng.lease.ops
     850238 ±  3%      -9.9%     766255 ±  2%      +2.3%     870047 
   stress-ng.lease.ops_per_sec
     134492 ± 14%      -7.0%     125085 ± 16%     -19.9%     107736 ± 
3%  stress-ng.mlock.ops_per_sec
       1.38            +2.9%       1.42 ±  5%     -20.2%       1.10 ± 
12%  stress-ng.mmapfork.ops_per_sec
    1117721 ±  5%      -9.2%    1015321 ± 20%     -36.2%     713598 
   stress-ng.mq.ops
    1117186 ±  5%      -9.2%    1014593 ± 20%     -36.2%     712387 
   stress-ng.mq.ops_per_sec
    4584592 ±  2%      -2.7%    4460470 ±  7%     -12.0%    4036627 ± 
8%  stress-ng.msg.ops_per_sec
       8179 ± 10%      +7.3%       8772 ±  9%     +24.0%      10144 
   stress-ng.opcode.ops
       8177 ± 10%      +7.2%       8770 ±  9%     +24.0%      10141 
   stress-ng.opcode.ops_per_sec
       5218 ±  3%      +3.6%       5408 ±  2%     +27.3%       6642 
   stress-ng.reboot.ops
       5217 ±  3%      +3.6%       5407 ±  2%     +27.3%       6640 
   stress-ng.reboot.ops_per_sec
       1724 ± 21%     +27.9%       2205 ± 18%     +54.3%       2660 ± 
19%  stress-ng.resources.ops
    1217728           -31.4%     835808 ± 14%     -18.7%     989423 ± 
10%  stress-ng.revio.ops
    1217899           -31.4%     835846 ± 14%     -18.8%     989313 ± 
10%  stress-ng.revio.ops_per_sec
     752664 ±  9%      -7.6%     695116 ± 10%      -0.6%     748117 ± 
6%  stress-ng.seal.ops
     752957 ±  9%      -7.7%     695278 ± 10%      -0.6%     748068 ± 
6%  stress-ng.seal.ops_per_sec
     628.00 ± 83%     -20.1%     502.00 ±  8%    +176.2%       1734 
   stress-ng.seccomp.ops
     628.22 ± 83%     -20.1%     502.08 ±  8%    +176.1%       1734 
   stress-ng.seccomp.ops_per_sec
    1361741 ±  7%      +4.0%    1416628 ±  8%     +17.2%    1596549 ± 
9%  stress-ng.seek.ops
    1361799 ±  7%      +4.0%    1416578 ±  8%     +17.2%    1596376 ± 
9%  stress-ng.seek.ops_per_sec
    1537496            +1.2%    1556468            -9.9%    1385679 
   stress-ng.sigrt.ops
    1532297            +1.3%    1551993            -9.9%    1381175 
   stress-ng.sigrt.ops_per_sec
    1324589 ± 12%     -26.6%     972626 ±  9%     -14.8%    1128923 ± 
4%  stress-ng.sigsuspend.ops
    1323957 ± 12%     -26.6%     972084 ±  9%     -14.8%    1128174 ± 
4%  stress-ng.sigsuspend.ops_per_sec
     806.67 ± 13%     +11.2%     896.67 ± 10%     +31.3%       1059 ± 
4%  stress-ng.sockabuse.ops
     806.73 ± 13%     +11.1%     896.44 ± 10%     +31.3%       1059 ± 
4%  stress-ng.sockabuse.ops_per_sec
    6224635 ±  2%      +0.8%    6274521 ±  2%     -12.8%    5427883 ± 
2%  stress-ng.sockpair.ops
    5383397            -1.9%    5279526 ±  2%     -14.9%    4579084 ± 
4%  stress-ng.sockpair.ops_per_sec
      22409 ±  6%      -2.8%      21784 ±  5%     -41.2%      13172 ± 
9%  stress-ng.sysbadaddr.ops
      22414 ±  6%      -2.8%      21784 ±  5%     -41.3%      13167 ± 
9%  stress-ng.sysbadaddr.ops_per_sec
     525.33 ± 13%      +2.6%     539.00 ± 15%     -42.1%     304.33 ± 
25%  stress-ng.sysfs.ops
     524.98 ± 13%      +2.6%     538.58 ± 15%     -42.1%     303.79 ± 
25%  stress-ng.sysfs.ops_per_sec
       3077 ± 12%     +19.9%       3689 ±  4%     +23.0%       3786 ± 
4%  stress-ng.sysinfo.ops
       3009 ± 11%     +22.6%       3688 ±  4%     +25.7%       3783 ± 
4%  stress-ng.sysinfo.ops_per_sec
    3001932            +1.2%    3038017           +15.7%    3474274 
   stress-ng.udp.ops
    3002618            +1.2%    3037939           +15.7%    3473606 
   stress-ng.udp.ops_per_sec
     184634 ± 12%      -6.9%     171823           +24.5%     229788 ± 
4%  stress-ng.utime.ops
     184678 ± 12%      -7.0%     171836           +24.4%     229784 ± 
4%  stress-ng.utime.ops_per_sec
       1835 ±  5%      +2.2%       1875 ±  4%      +8.2%       1986 ± 
3%  stress-ng.vforkmany.ops
       1829 ±  5%      +1.9%       1863 ±  4%      +8.1%       1978 ± 
3%  stress-ng.vforkmany.ops_per_sec
      14829            -1.0%      14682 ±  2%     -20.1%      11848 ± 
3%  stress-ng.vm-segv.ops
      14830            -1.0%      14682 ±  2%     -29.7%      10433 ± 
13%  stress-ng.vm-segv.ops_per_sec
    3527835 ±  3%      +1.9%    3596613 ±  5%    +495.6%   21010377 
   stress-ng.vm-splice.ops
    3528845 ±  3%      +1.9%    3597219 ±  5%    +495.4%   21011045 
   stress-ng.vm-splice.ops_per_sec





-- 
Zhengjun Xing
