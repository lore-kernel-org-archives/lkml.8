Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F13C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165BF2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgCYObG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:31:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:34700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbgCYObF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:31:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6FEC1AD0F;
        Wed, 25 Mar 2020 14:31:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 87AE71E10FB; Wed, 25 Mar 2020 15:31:02 +0100 (CET)
Date:   Wed, 25 Mar 2020 15:31:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Rong Chen <rong.a.chen@intel.com>, Jan Kara <jack@suse.cz>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [LKP] Re: [ext4] b1b4705d54: filebench.sum_bytes_mb/s -20.2%
 regression
Message-ID: <20200325143102.GJ28951@quack2.suse.cz>
References: <20191224005915.GW2760@shao2-debian>
 <20200107134106.GD25547@quack2.suse.cz>
 <20200107165708.GA3619@mit.edu>
 <20200107172824.GK25547@quack2.suse.cz>
 <fde1ad11-c9b0-4393-a123-3f7625c819fa@intel.com>
 <7ec6b078-7b09-fb87-8ad2-a328e96c5bf9@linux.intel.com>
 <49a59199-53af-206f-d07c-5c8c45f498b3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49a59199-53af-206f-d07c-5c8c45f498b3@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-03-20 13:50:09, Xing Zhengjun wrote:
> ping...
> The issue still exists in v5.6-rc7.

So I have tried again to reproduce this so that I can look into the
regression. When observing what is actually happening in the system I have
to say that this workfile (or actually its implementation in filebench) is
pretty dubious. The problem is that filebench first creates the files by
writing them through ordinary write(2). Then it immediately starts reading
the files with direct IO read. So what happens is that by the time direct
IO read is running, the system is still writing back the create files and
depending on how read vs writes get scheduled, you get different results.
Also direct IO read will first flush the range it is going to read from the
page cache so to some extent this is actually parallel small ranged
fsync(2) benchmark. Finally differences in how we achieve integrity of
direct IO reads with dirty page cache are going to impact this benchmark.

So overall can now see why this commit makes a difference but the workload
is IMHO largely irrelevant. What would make sense is to run filebench once,
then unmount & mount the fs to force files to disk and clear page cache and
then run it again. Filebench will reuse the files in this case and then
parallel direct IO readers without page cache are a sensible workload. But
I didn't see any difference in that (even with rotating disk) on my
machines.

								Honza
> 
> On 3/4/2020 4:15 PM, Xing Zhengjun wrote:
> > Hi Matthew,
> > 
> >   We test it in v5.6-rc4, the issue still exist, do you have time to
> > take a look at this? Thanks.
> > 
> > On 1/8/2020 10:31 AM, Rong Chen wrote:
> > > 
> > > 
> > > On 1/8/20 1:28 AM, Jan Kara wrote:
> > > > On Tue 07-01-20 11:57:08, Theodore Y. Ts'o wrote:
> > > > > On Tue, Jan 07, 2020 at 02:41:06PM +0100, Jan Kara wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > On Tue 24-12-19 08:59:15, kernel test robot wrote:
> > > > > > > FYI, we noticed a -20.2% regression of
> > > > > > > filebench.sum_bytes_mb/s due to commit:
> > > > > > > 
> > > > > > > 
> > > > > > > commit: b1b4705d54abedfd69dcdf42779c521aa1e0fbd3
> > > > > > > ("ext4: introduce direct I/O read using iomap
> > > > > > > infrastructure")
> > > > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
> > > > > > > master
> > > > > > > 
> > > > > > > in testcase: filebench
> > > > > > > on test machine: 8 threads Intel(R) Core(TM) i7-4770
> > > > > > > CPU @ 3.40GHz with 8G memory
> > > > > > > with following parameters:
> > > > > > > 
> > > > > > >     disk: 1HDD
> > > > > > >     fs: ext4
> > > > > > >     test: fivestreamreaddirect.f
> > > > > > >     cpufreq_governor: performance
> > > > > > >     ucode: 0x27
> > > > > > I was trying to reproduce this but I failed with my test
> > > > > > VM. I had SATA SSD
> > > > > > as a backing store though so maybe that's what makes a
> > > > > > difference. Maybe
> > > > > > the new code results in somewhat more seeks because the
> > > > > > five threads which
> > > > > > compete in submitting sequential IO end up being more interleaved?
> > > > > A "-20.2% regression" should be read as a "20.2% performance
> > > > > improvement" is zero-day kernel speak.
> > > > Are you sure? I can see:
> > > > 
> > > >       58.30 ±  2%     -20.2%      46.53        filebench.sum_bytes_mb/s
> > > > 
> > > > which implies to me previously the throughput was 58 MB/s and after the
> > > > commit it was 46 MB/s?
> > > > 
> > > > Anyway, in my testing that commit made no difference in that benchmark
> > > > whasoever (getting around 97 MB/s for each thread before and after the
> > > > commit).
> > > >                                 Honza
> > > 
> > > We're sorry for the misunderstanding, "-20.2%" means the change of
> > > filebench.sum_bytes_mb/s,
> > > "regression" means the explanation of this change from LKP.
> > > 
> > > Best Regards,
> > > Rong Chen
> > > _______________________________________________
> > > LKP mailing list -- lkp@lists.01.org
> > > To unsubscribe send an email to lkp-leave@lists.01.org
> > 
> 
> -- 
> Zhengjun Xing
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
