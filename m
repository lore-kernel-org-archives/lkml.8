Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D490C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D7A20884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGBHMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:12:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:25979 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgGBHMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:12:35 -0400
IronPort-SDR: uOlt4NnuEV1ycjKc1j0wcWzRQwO/QpDPc4YAKk52SwIgy7h4TaKs1fyzCOcfKQFuwo8geHDnDT
 HrNnnEyJUNpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="231693632"
X-IronPort-AV: E=Sophos;i="5.75,303,1589266800"; 
   d="scan'208";a="231693632"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 00:12:35 -0700
IronPort-SDR: lMqQeMColxw2J+sR5/Vq/+4pg3pKriqOV1EUYi3Y7o2PRberNtjtn1GmThc1HQgdX/WFIBspyY
 fLti3MPRtdOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,303,1589266800"; 
   d="scan'208";a="314036934"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by fmsmga002.fm.intel.com with ESMTP; 02 Jul 2020 00:12:31 -0700
Date:   Thu, 2 Jul 2020 15:12:30 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200702071230.GA17007@shbuild999.sh.intel.com>
References: <1592725000-73486-4-git-send-email-feng.tang@intel.com>
 <20200702063201.GG3874@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702063201.GG3874@shao2-debian>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 02, 2020 at 02:32:01PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 4e2c82a40911c19419349918e675aa202b113b4d ("[PATCH v5 3/3] mm: adjust vm_committed_as_batch according to vm overcommit policy")
> url: https://github.com/0day-ci/linux/commits/Feng-Tang/make-vm_committed_as_batch-aware-of-vm-overcommit-policy/20200621-153906
> 
> 
> in testcase: ltp
> with following parameters:
> 
> 	disk: 1HDD
> 	test: mm-01
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> 
> <<<test_start>>>
> tag=overcommit_memory01 stime=1593425044
> cmdline="overcommit_memory"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> overcommit_memory.c:116: INFO: MemTotal is 16394252 kB
> overcommit_memory.c:118: INFO: SwapTotal is 268435452 kB
> overcommit_memory.c:122: INFO: CommitLimit is 276632576 kB
> mem.c:817: INFO: set overcommit_ratio to 50
> mem.c:817: INFO: set overcommit_memory to 2
> overcommit_memory.c:187: INFO: malloc 551061440 kB failed
> overcommit_memory.c:208: PASS: alloc failed as expected
> overcommit_memory.c:183: INFO: malloc 276632576 kB successfully
> overcommit_memory.c:210: FAIL: alloc passed, expected to fail

Thanks for the report!

I took a rough look, and it all happens after changing the
overcommit policy from a looser one to OVERCOMMIT_NEVER. I suspect 
it is due to the same cause as the previous warning message reported
by Qian Cai https://lore.kernel.org/lkml/20200526181459.GD991@lca.pw/ 

Will further check it.

Thanks,
Feng

> overcommit_memory.c:183: INFO: malloc 137765294 kB successfully
> overcommit_memory.c:202: PASS: alloc passed as expected
> mem.c:817: INFO: set overcommit_memory to 0
> overcommit_memory.c:183: INFO: malloc 140770308 kB successfully
> overcommit_memory.c:202: PASS: alloc passed as expected
> overcommit_memory.c:187: INFO: malloc 569659408 kB failed
> overcommit_memory.c:208: PASS: alloc failed as expected
> mem.c:817: INFO: set overcommit_memory to 1
> overcommit_memory.c:183: INFO: malloc 142414852 kB successfully
> overcommit_memory.c:202: PASS: alloc passed as expected
> overcommit_memory.c:183: INFO: malloc 284829704 kB successfully
> overcommit_memory.c:202: PASS: alloc passed as expected
> overcommit_memory.c:183: INFO: malloc 569659408 kB successfully
> overcommit_memory.c:202: PASS: alloc passed as expected
> mem.c:817: INFO: set overcommit_memory to 0
> mem.c:817: INFO: set overcommit_ratio to 50
> 
> Summary:
> passed   7
> failed   1
> skipped  0
> warnings 0
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=0 cstime=1
> <<<test_end>>>
> <<<test_start>>>
> tag=overcommit_memory02 stime=1593425044
> cmdline="overcommit_memory -R 0"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> overcommit_memory.c:116: INFO: MemTotal is 16394252 kB
> overcommit_memory.c:118: INFO: SwapTotal is 268435452 kB
> overcommit_memory.c:122: INFO: CommitLimit is 276632576 kB
> mem.c:817: INFO: set overcommit_ratio to 0
> mem.c:817: INFO: set overcommit_memory to 2
> overcommit_memory.c:187: INFO: malloc 534667184 kB failed
> overcommit_memory.c:208: PASS: alloc failed as expected
> overcommit_memory.c:183: INFO: malloc 268435452 kB successfully
> overcommit_memory.c:210: FAIL: alloc passed, expected to fail
> overcommit_memory.c:183: INFO: malloc 133666730 kB successfully
> overcommit_memory.c:202: PASS: alloc passed as expected
> mem.c:817: INFO: set overcommit_memory to 0
> overcommit_memory.c:183: INFO: malloc 140770304 kB successfully
> overcommit_memory.c:202: PASS: alloc passed as expected
> overcommit_memory.c:187: INFO: malloc 569659408 kB failed
> overcommit_memory.c:208: PASS: alloc failed as expected
> mem.c:817: INFO: set overcommit_memory to 1
> overcommit_memory.c:183: INFO: malloc 142414852 kB successfully
> overcommit_memory.c:202: PASS: alloc passed as expected
> overcommit_memory.c:183: INFO: malloc 284829704 kB successfully
> overcommit_memory.c:202: PASS: alloc passed as expected
> overcommit_memory.c:183: INFO: malloc 569659408 kB successfully
> overcommit_memory.c:202: PASS: alloc passed as expected
> mem.c:817: INFO: set overcommit_memory to 0
> mem.c:817: INFO: set overcommit_ratio to 50
> 
