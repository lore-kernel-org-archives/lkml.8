Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24FEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 05:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59362073E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 05:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgHJFOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 01:14:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:41545 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgHJFOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 01:14:34 -0400
IronPort-SDR: NG9Fd2BfK4zGjd/CSg8zTC+Ec2spCqMbwbOT1FWloztj3IndJ1oV4BpX+lu8/1njZnFFjOh6tr
 tNO1pkydQgxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="214998104"
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; 
   d="scan'208";a="214998104"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2020 22:14:31 -0700
IronPort-SDR: 9bu6d56Tx3a3K5dMHtEzPfv9zztmrQhTEULluIiVUi1xKhKT7xsSA+UT755oT7sxGZ0kBA1HFg
 HcBzNHr/g3Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; 
   d="scan'208";a="494674687"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2020 22:14:30 -0700
Subject: Re: [kbuild-all] Re: drivers/md/dm-mpath.c:524
 multipath_clone_and_map() error: double unlocked 'm->lock' (orig line 516)
To:     Mike Snitzer <snitzer@redhat.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202008082059.puvi6HNx%lkp@intel.com>
 <20200808143526.GA6950@redhat.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <9896b2fc-d44a-39a4-1df8-a79f0594a62c@intel.com>
Date:   Mon, 10 Aug 2020 13:13:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200808143526.GA6950@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/20 10:35 PM, Mike Snitzer wrote:
> On Sat, Aug 08 2020 at  8:10am -0400,
> kernel test robot <lkp@intel.com> wrote:
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   449dc8c97089a6e09fb2dac4d92b1b7ac0eb7c1e
>> commit: 374117ad4736c5a4f8012cfe59fc07d9d58191d5 dm mpath: use double checked locking in fast path
>> date:   4 weeks ago
>> config: arm-randconfig-m031-20200808 (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
> All 3 recent reports about smatch showing "double unlocked 'm->lock'"
> appear to be bogus.  Think smatch is generating false positives (and
> given "Old smatch warnings" it seems it has been doing so for some
> time).
>
> In addition, does lkp@intel.com no longer test linux-next?  The dm-mpath
> locking changes that were just merged into mainline have been in
> linux-next since July 13.  Why were these tests only done against
> mainline?
Hi Mike,

kernel test robot still test linux-next, but the bisection worked on 
linus/master and didn't check the fix in linux-next,
we'll optimize the bisection to avoid reporting this kind of problem.

Best Regards,
Rong Chen

>
> Mike
>
>
>
>> New smatch warnings:
>> drivers/md/dm-mpath.c:524 multipath_clone_and_map() error: double unlocked 'm->lock' (orig line 516)
>>
>> Old smatch warnings:
>> drivers/md/dm-mpath.c:446 choose_pgpath() error: double unlocked 'm->lock' (orig line 416)
>> drivers/md/dm-mpath.c:457 choose_pgpath() error: double unlocked 'm->lock' (orig line 403)
>> drivers/md/dm-mpath.c:525 multipath_clone_and_map() error: double unlocked 'm->lock' (orig line 516)
>> drivers/md/dm-mpath.c:526 multipath_clone_and_map() error: double unlocked 'm->lock' (orig line 524)
>> drivers/md/dm-mpath.c:626 __map_bio() error: double unlocked 'm->lock' (orig line 615)
>> drivers/md/dm-mpath.c:627 __map_bio() error: double unlocked 'm->lock' (orig line 615)
>> drivers/md/dm-mpath.c:628 __map_bio() error: double unlocked 'm->lock' (orig line 626)
>> drivers/md/dm-mpath.c:629 __map_bio() error: double unlocked 'm->lock' (orig line 628)
>> drivers/md/dm-mpath.c:1607 pg_init_done() error: double unlocked 'm->lock' (orig line 1560)
>> drivers/md/dm-mpath.c:1707 multipath_end_io_bio() error: double unlocked 'm->lock' (orig line 1704)
>> drivers/md/dm-mpath.c:1988 multipath_prepare_ioctl() error: double unlocked 'm->lock' (orig line 1984)
>> drivers/md/dm-mpath.c:2012 multipath_prepare_ioctl() error: double unlocked 'm->lock' (orig line 2001)
>>
>> vim +524 drivers/md/dm-mpath.c
>>
>>     498	
>>     499	/*
>>     500	 * Map cloned requests (request-based multipath)
>>     501	 */
>>     502	static int multipath_clone_and_map(struct dm_target *ti, struct request *rq,
>>     503					   union map_info *map_context,
>>     504					   struct request **__clone)
>>     505	{
>>     506		struct multipath *m = ti->private;
>>     507		size_t nr_bytes = blk_rq_bytes(rq);
>>     508		struct pgpath *pgpath;
>>     509		struct block_device *bdev;
>>     510		struct dm_mpath_io *mpio = get_mpio(map_context);
>>     511		struct request_queue *q;
>>     512		struct request *clone;
>>     513	
>>     514		/* Do we need to select a new pgpath? */
>>     515		pgpath = READ_ONCE(m->current_pgpath);
>>   > 516		if (!pgpath || !mpath_double_check_test_bit(MPATHF_QUEUE_IO, m))
>>     517			pgpath = choose_pgpath(m, nr_bytes);
>>     518	
>>     519		if (!pgpath) {
>>     520			if (must_push_back_rq(m))
>>     521				return DM_MAPIO_DELAY_REQUEUE;
>>     522			dm_report_EIO(m);	/* Failed */
>>     523			return DM_MAPIO_KILL;
>>   > 524		} else if (mpath_double_check_test_bit(MPATHF_QUEUE_IO, m) ||
>>     525			   mpath_double_check_test_bit(MPATHF_PG_INIT_REQUIRED, m)) {
>>     526			pg_init_all_paths(m);
>>     527			return DM_MAPIO_DELAY_REQUEUE;
>>     528		}
>>     529	
>>     530		mpio->pgpath = pgpath;
>>     531		mpio->nr_bytes = nr_bytes;
>>     532	
>>     533		bdev = pgpath->path.dev->bdev;
>>     534		q = bdev_get_queue(bdev);
>>     535		clone = blk_get_request(q, rq->cmd_flags | REQ_NOMERGE,
>>     536				BLK_MQ_REQ_NOWAIT);
>>     537		if (IS_ERR(clone)) {
>>     538			/* EBUSY, ENODEV or EWOULDBLOCK: requeue */
>>     539			if (blk_queue_dying(q)) {
>>     540				atomic_inc(&m->pg_init_in_progress);
>>     541				activate_or_offline_path(pgpath);
>>     542				return DM_MAPIO_DELAY_REQUEUE;
>>     543			}
>>     544	
>>     545			/*
>>     546			 * blk-mq's SCHED_RESTART can cover this requeue, so we
>>     547			 * needn't deal with it by DELAY_REQUEUE. More importantly,
>>     548			 * we have to return DM_MAPIO_REQUEUE so that blk-mq can
>>     549			 * get the queue busy feedback (via BLK_STS_RESOURCE),
>>     550			 * otherwise I/O merging can suffer.
>>     551			 */
>>     552			return DM_MAPIO_REQUEUE;
>>     553		}
>>     554		clone->bio = clone->biotail = NULL;
>>     555		clone->rq_disk = bdev->bd_disk;
>>     556		clone->cmd_flags |= REQ_FAILFAST_TRANSPORT;
>>     557		*__clone = clone;
>>     558	
>>     559		if (pgpath->pg->ps.type->start_io)
>>     560			pgpath->pg->ps.type->start_io(&pgpath->pg->ps,
>>     561						      &pgpath->path,
>>     562						      nr_bytes);
>>     563		return DM_MAPIO_REMAPPED;
>>     564	}
>>     565	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

