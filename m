Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C75C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF34F2187F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgCBNkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:40:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:38945 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbgCBNkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:40:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 05:40:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="gz'50?scan'50,208,50";a="438280870"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Mar 2020 05:40:51 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j8lJS-000Exb-Cw; Mon, 02 Mar 2020 21:40:50 +0800
Date:   Mon, 2 Mar 2020 21:40:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     kbuild-all@lists.01.org,
        "linux-block@vger.kernel.org, Jens Axboe" <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 2/3] block/diskstats: accumulate all per-cpu counters in
 one pass
Message-ID: <202003022157.3gLqgQjJ%lkp@intel.com>
References: <158314549980.1788.322398190605021664.stgit@buzz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <158314549980.1788.322398190605021664.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Konstantin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on block/for-next]
[also build test ERROR on linux/master linus/master v5.6-rc4 next-20200228]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Konstantin-Khlebnikov/block-diskstats-more-accurate-approximation-of-io_ticks-for-slow-disks/20200302-192211
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: init/do_mounts.o: in function `part_stat_read_all':
>> do_mounts.c:(.text+0x4ef): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: arch/um/kernel/mem.o: in function `part_stat_read_all':
   mem.c:(.text+0x0): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: arch/um/kernel/process.o: in function `part_stat_read_all':
   process.c:(.text+0x25f): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: arch/um/kernel/ptrace.o: in function `part_stat_read_all':
   ptrace.c:(.text+0x14c): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: arch/um/drivers/ubd_kern.o: in function `part_stat_read_all':
   ubd_kern.c:(.text+0x1f41): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/fork.o: in function `part_stat_read_all':
   fork.c:(.text+0xbb2): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/cpu.o: in function `part_stat_read_all':
   cpu.c:(.text+0x6a7): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/exit.o: in function `part_stat_read_all':
   exit.c:(.text+0x5b4): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sysctl.o: in function `part_stat_read_all':
   sysctl.c:(.text+0x18b5): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/signal.o: in function `part_stat_read_all':
   signal.c:(.text+0xcd6): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sys.o: in function `part_stat_read_all':
   sys.c:(.text+0xc36): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/umh.o: in function `part_stat_read_all':
   umh.c:(.text+0xa25): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/task_work.o: in function `part_stat_read_all':
   task_work.c:(.text+0x0): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/reboot.o: in function `part_stat_read_all':
   reboot.c:(.text+0x243): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/kmod.o: in function `part_stat_read_all':
   kmod.c:(.text+0x479): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/core.o: in function `part_stat_read_all':
   core.c:(.text+0xa8e): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/loadavg.o: in function `part_stat_read_all':
   loadavg.c:(.text+0x0): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/clock.o: in function `part_stat_read_all':
   clock.c:(.text+0x24): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/cputime.o: in function `part_stat_read_all':
   cputime.c:(.text+0x4f): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/idle.o: in function `part_stat_read_all':
   idle.c:(.text+0x141): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/fair.o: in function `part_stat_read_all':
   fair.c:(.text+0x125a): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/rt.o: in function `part_stat_read_all':
   rt.c:(.text+0xc24): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/deadline.o: in function `part_stat_read_all':
   deadline.c:(.text+0x11cf): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/wait.o: in function `part_stat_read_all':
   wait.c:(.text+0x7f3): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/wait_bit.o: in function `part_stat_read_all':
   wait_bit.c:(.text+0x215): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/swait.o: in function `part_stat_read_all':
   swait.c:(.text+0x329): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/completion.o: in function `part_stat_read_all':
   completion.c:(.text+0x13a): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/debug.o: in function `part_stat_read_all':
   debug.c:(.text+0xd6e): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/cpuacct.o: in function `part_stat_read_all':
   cpuacct.c:(.text+0x400): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/sched/membarrier.o: in function `part_stat_read_all':
   membarrier.c:(.text+0x8a): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/power/process.o: in function `part_stat_read_all':
   process.c:(.text+0x2cf): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/freezer.o: in function `part_stat_read_all':
   freezer.c:(.text+0x1de): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/time/timer.o: in function `part_stat_read_all':
   timer.c:(.text+0xd7e): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/acct.o: in function `part_stat_read_all':
   acct.c:(.text+0x5e2): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/cgroup/cgroup.o: in function `part_stat_read_all':
   cgroup.c:(.text+0x25e6): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: kernel/seccomp.o: in function `part_stat_read_all':
   seccomp.c:(.text+0x1193): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/filemap.o: in function `part_stat_read_all':
   filemap.c:(.text+0x2826): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/mempool.o: in function `part_stat_read_all':
   mempool.c:(.text+0x741): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/oom_kill.o: in function `part_stat_read_all':
   oom_kill.c:(.text+0x211): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/fadvise.o: in function `part_stat_read_all':
   fadvise.c:(.text+0x27c): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/page-writeback.o: in function `part_stat_read_all':
   page-writeback.c:(.text+0x1cb2): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/readahead.o: in function `part_stat_read_all':
   readahead.c:(.text+0x3c8): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/swap.o: in function `part_stat_read_all':
   swap.c:(.text+0x10de): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/truncate.o: in function `part_stat_read_all':
   truncate.c:(.text+0x6f6): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/vmscan.o: in function `part_stat_read_all':
   vmscan.c:(.text+0x99b): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/shmem.o: in function `part_stat_read_all':
   shmem.c:(.text+0x33ec): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/util.o: in function `part_stat_read_all':
   util.c:(.text+0x8fd): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/vmstat.o: in function `part_stat_read_all':
   vmstat.c:(.text+0x988): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/backing-dev.o: in function `part_stat_read_all':
   backing-dev.c:(.text+0x755): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/slab_common.o: in function `part_stat_read_all':
   slab_common.c:(.text+0x6ff): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here
   ld: mm/compaction.o: in function `part_stat_read_all':
   compaction.c:(.text+0x0): multiple definition of `part_stat_read_all'; init/main.o:main.c:(.text+0x1d5): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--gBBFr7Ir9EOA20Yy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/m7avPk/8NuXchaDAAA=

--gBBFr7Ir9EOA20Yy--
