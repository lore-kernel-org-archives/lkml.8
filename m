Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79230C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB102078A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894775AbgDOIkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:40:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:38172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894750AbgDOIj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:39:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EC966ADBE;
        Wed, 15 Apr 2020 08:39:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A34E01E0E47; Wed, 15 Apr 2020 10:39:54 +0200 (CEST)
Date:   Wed, 15 Apr 2020 10:39:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Jan Kara <jack@suse.cz>, Rong Chen <rong.a.chen@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [LKP] Re: [ext4] b1b4705d54: filebench.sum_bytes_mb/s -20.2%
 regression
Message-ID: <20200415083954.GD501@quack2.suse.cz>
References: <20191224005915.GW2760@shao2-debian>
 <20200107134106.GD25547@quack2.suse.cz>
 <20200107165708.GA3619@mit.edu>
 <20200107172824.GK25547@quack2.suse.cz>
 <fde1ad11-c9b0-4393-a123-3f7625c819fa@intel.com>
 <7ec6b078-7b09-fb87-8ad2-a328e96c5bf9@linux.intel.com>
 <49a59199-53af-206f-d07c-5c8c45f498b3@linux.intel.com>
 <20200325143102.GJ28951@quack2.suse.cz>
 <309baa89-9f69-0545-946e-4b3624f83e60@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <309baa89-9f69-0545-946e-4b3624f83e60@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-04-20 15:55:09, Xing Zhengjun wrote:
> 
> 
> On 3/25/2020 10:31 PM, Jan Kara wrote:
> > On Wed 25-03-20 13:50:09, Xing Zhengjun wrote:
> > > ping...
> > > The issue still exists in v5.6-rc7.
> > 
> > So I have tried again to reproduce this so that I can look into the
> > regression. When observing what is actually happening in the system I have
> > to say that this workfile (or actually its implementation in filebench) is
> > pretty dubious. The problem is that filebench first creates the files by
> > writing them through ordinary write(2). Then it immediately starts reading
> > the files with direct IO read. So what happens is that by the time direct
> > IO read is running, the system is still writing back the create files and
> > depending on how read vs writes get scheduled, you get different results.
> > Also direct IO read will first flush the range it is going to read from the
> > page cache so to some extent this is actually parallel small ranged
> > fsync(2) benchmark. Finally differences in how we achieve integrity of
> > direct IO reads with dirty page cache are going to impact this benchmark.
> > 
> 
> Sounds reasonable!  Thanks for the clarification!
> 
> > So overall can now see why this commit makes a difference but the workload
> > is IMHO largely irrelevant. What would make sense is to run filebench once,
> > then unmount & mount the fs to force files to disk and clear page cache and
> > then run it again. Filebench will reuse the files in this case and then
> > parallel direct IO readers without page cache are a sensible workload. But
> > I didn't see any difference in that (even with rotating disk) on my
> > machines.
> > 
> We do a test per your suggestion, run "filebench" once during setup stage,
> then do a "sync",  after that run "filebench" again, from the attached test
> result "compare", "filebench.sum_bytes_mb/s" regression is disappeared.

Cool. Thanks for improving the testcase! I'd just note that if you only do
sync(2) between the setup and benchmark phase, you'll still have files
cached in the page cache and so direct IO will go through the slow path
when it has to evict pages from the page cache. The standard (and optimized
for) situation for direct IO is that there is no page cache for the files
direct IO is performed to. That's why I suggested remounting the
filesystem, not just calling sync(2)...

								Honza

> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/debug-setup/disk/fs/test/cpufreq_governor/ucode:
>   lkp-hsw-d01/filebench/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/test2/1HDD/ext4/fivestreamreaddirect.f/performance/0x27
> 
> commit: 
>   b1b4705d54abedfd69dcdf42779c521aa1e0fbd3
>   09edf4d381957b144440bac18a4769c53063b943
>   v5.5
>   v5.7-rc1
> 
> b1b4705d54abedfd 09edf4d381957b144440bac18a4                        v5.5                    v5.7-rc1 
> ---------------- --------------------------- --------------------------- --------------------------- 
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \  
>      59.40            +0.0%      59.40            -0.8%      58.93            -1.0%      58.80        filebench.sum_bytes_mb/s
>       3570            +0.0%       3570            -0.8%       3541            -1.0%       3533        filebench.sum_operations
>      59.50            +0.0%      59.50            -0.8%      59.02            -1.0%      58.89        filebench.sum_operations/s
>      59.33            +0.0%      59.33            +0.0%      59.33            -0.6%      59.00        filebench.sum_reads/s
>      83.98            -1.5%      82.75            +0.8%      84.62            +1.0%      84.84        filebench.sum_time_ms/op

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
