Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BCDC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 01:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDE52075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 01:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403811AbgDNBiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 21:38:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:32757 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbgDNBiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 21:38:52 -0400
IronPort-SDR: X49EmwBSXnrBq/Tpoh3DNYwG399q7ZQT4c2sW5W81s/PhkYFhnl+28LpmmqDcKr3293DkRSCa9
 uoGw5cuQKw5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 18:38:51 -0700
IronPort-SDR: RtgrjbRtraNTJIo+okYLapG087iI+EHbT5aFYMZcT1o/QxOywQgceQmYAxkoGIQoXXaIlp7wEd
 wxJUCwPmR2Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="256351353"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.105])
  by orsmga006.jf.intel.com with ESMTP; 13 Apr 2020 18:38:49 -0700
Date:   Tue, 14 Apr 2020 09:38:49 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [LKP] [f2fs] fe1897eaa6: aim7.jobs-per-min -60.9% regression
Message-ID: <20200414013849.GB49945@shbuild999.sh.intel.com>
References: <20191208154145.GM32275@shao2-debian>
 <20200413105124.GA49945@shbuild999.sh.intel.com>
 <1c5007a1-26fe-650b-0a34-5b12f749b384@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c5007a1-26fe-650b-0a34-5b12f749b384@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 07:03:57PM +0800, Chao Yu wrote:
> On 2020/4/13 18:51, Feng Tang wrote:
> > On Sun, Dec 08, 2019 at 11:41:46PM +0800, kernel test robot wrote:
> >> Greeting,
> >>
> >> FYI, we noticed a -60.9% regression of aim7.jobs-per-min due to commit:
> >>
> >>
> >> commit: fe1897eaa6646f5a64a4cee0e6473ed9887d324b ("f2fs: fix to update time in lazytime mode")
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >>
> >> in testcase: aim7
> >> on test machine: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 64G memory
> >> with following parameters:
> >>
> >> 	disk: 4BRD_12G
> >> 	md: RAID1
> >> 	fs: f2fs
> >> 	test: sync_disk_rw
> >> 	load: 200
> >> 	cpufreq_governor: performance
> >> 	ucode: 0x42e
> >>
> >> test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
> >> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
> >>
> >>
> >>
> >> If you fix the issue, kindly add following tag
> >> Reported-by: kernel test robot <rong.a.chen@intel.com>
> >>
> >>
> >> Details are as below:
> >> -------------------------------------------------------------------------------------------------->
> >>
> >>
> >> To reproduce:
> >>
> >>         git clone https://github.com/intel/lkp-tests.git
> >>         cd lkp-tests
> >>         bin/lkp install job.yaml  # job file is attached in this email
> >>         bin/lkp run     job.yaml
> >>
> >> =========================================================================================
> >> compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
> >>   gcc-7/performance/4BRD_12G/f2fs/x86_64-rhel-7.6/200/RAID1/debian-x86_64-2019-11-14.cgz/lkp-ivb-2ep1/sync_disk_rw/aim7/0x42e
> >>
> >> commit: 
> >>   b145b0eb20 (" ARM and x86 bugfixes of all kinds.  The most visible one is that migrating")
> >>   fe1897eaa6 ("f2fs: fix to update time in lazytime mode")
> >>
> >> b145b0eb2031a620 fe1897eaa6646f5a64a4cee0e64 
> >> ---------------- --------------------------- 
> >>        fail:runs  %reproduction    fail:runs
> >>            |             |             |    
> >>           1:4          -25%            :4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
> >>          %stddev     %change         %stddev
> >>              \          |                \  
> >>       1208           -60.9%     473.12        aim7.jobs-per-min
> > 
> > Hi Chao Yu,
> > 
> > Any thoughts on this? 
> > 
> > IIUC, this commit is a fix, and if you think it is necessary, we will
> > stop tracking this regresion.
> 
> Hi Feng Tang,
> 
> Sorry, I missed to reply this thread.
> 
> Anyway, we need this fix patch to avoid losing atime issue in some cases,
> let's stop tracking this regression please.
 
Got it, thanks for confirming!

- Feng

> Thanks for noticing/reporting this regression. :)
> 
> Thanks,
