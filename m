Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6881C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 14:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8167620747
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 14:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIJaQbX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHHOfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 10:35:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54464 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgHHOfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 10:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596897340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+f4z4GLJoXebjP9ayyv/XeddASIJXM2rQwkijn/wmY=;
        b=RIJaQbX3SG42KBjiEf7E1mH5q9pH488L0kk3fnBF3F4FMC5wDVcUJTG91eiHMH72iBHwO2
        jvzlmKSxgZ+ITcNrhyk1yym96xaMSuBO8s9qazfiANXnhjY9qk9UtofmygRbbNWIgO23wC
        YPzUghHpAywHC/5va1siV+vdGUHyz0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-QIk1NoQXOW-nKdcRvGiLoA-1; Sat, 08 Aug 2020 10:35:28 -0400
X-MC-Unique: QIk1NoQXOW-nKdcRvGiLoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54FBC8005B0;
        Sat,  8 Aug 2020 14:35:27 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 225B45F1EA;
        Sat,  8 Aug 2020 14:35:26 +0000 (UTC)
Date:   Sat, 8 Aug 2020 10:35:26 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/md/dm-mpath.c:524 multipath_clone_and_map() error:
 double unlocked 'm->lock' (orig line 516)
Message-ID: <20200808143526.GA6950@redhat.com>
References: <202008082059.puvi6HNx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008082059.puvi6HNx%lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 08 2020 at  8:10am -0400,
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   449dc8c97089a6e09fb2dac4d92b1b7ac0eb7c1e
> commit: 374117ad4736c5a4f8012cfe59fc07d9d58191d5 dm mpath: use double checked locking in fast path
> date:   4 weeks ago
> config: arm-randconfig-m031-20200808 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

All 3 recent reports about smatch showing "double unlocked 'm->lock'"
appear to be bogus.  Think smatch is generating false positives (and
given "Old smatch warnings" it seems it has been doing so for some
time).

In addition, does lkp@intel.com no longer test linux-next?  The dm-mpath
locking changes that were just merged into mainline have been in
linux-next since July 13.  Why were these tests only done against
mainline?

Mike



> New smatch warnings:
> drivers/md/dm-mpath.c:524 multipath_clone_and_map() error: double unlocked 'm->lock' (orig line 516)
> 
> Old smatch warnings:
> drivers/md/dm-mpath.c:446 choose_pgpath() error: double unlocked 'm->lock' (orig line 416)
> drivers/md/dm-mpath.c:457 choose_pgpath() error: double unlocked 'm->lock' (orig line 403)
> drivers/md/dm-mpath.c:525 multipath_clone_and_map() error: double unlocked 'm->lock' (orig line 516)
> drivers/md/dm-mpath.c:526 multipath_clone_and_map() error: double unlocked 'm->lock' (orig line 524)
> drivers/md/dm-mpath.c:626 __map_bio() error: double unlocked 'm->lock' (orig line 615)
> drivers/md/dm-mpath.c:627 __map_bio() error: double unlocked 'm->lock' (orig line 615)
> drivers/md/dm-mpath.c:628 __map_bio() error: double unlocked 'm->lock' (orig line 626)
> drivers/md/dm-mpath.c:629 __map_bio() error: double unlocked 'm->lock' (orig line 628)
> drivers/md/dm-mpath.c:1607 pg_init_done() error: double unlocked 'm->lock' (orig line 1560)
> drivers/md/dm-mpath.c:1707 multipath_end_io_bio() error: double unlocked 'm->lock' (orig line 1704)
> drivers/md/dm-mpath.c:1988 multipath_prepare_ioctl() error: double unlocked 'm->lock' (orig line 1984)
> drivers/md/dm-mpath.c:2012 multipath_prepare_ioctl() error: double unlocked 'm->lock' (orig line 2001)
> 
> vim +524 drivers/md/dm-mpath.c
> 
>    498	
>    499	/*
>    500	 * Map cloned requests (request-based multipath)
>    501	 */
>    502	static int multipath_clone_and_map(struct dm_target *ti, struct request *rq,
>    503					   union map_info *map_context,
>    504					   struct request **__clone)
>    505	{
>    506		struct multipath *m = ti->private;
>    507		size_t nr_bytes = blk_rq_bytes(rq);
>    508		struct pgpath *pgpath;
>    509		struct block_device *bdev;
>    510		struct dm_mpath_io *mpio = get_mpio(map_context);
>    511		struct request_queue *q;
>    512		struct request *clone;
>    513	
>    514		/* Do we need to select a new pgpath? */
>    515		pgpath = READ_ONCE(m->current_pgpath);
>  > 516		if (!pgpath || !mpath_double_check_test_bit(MPATHF_QUEUE_IO, m))
>    517			pgpath = choose_pgpath(m, nr_bytes);
>    518	
>    519		if (!pgpath) {
>    520			if (must_push_back_rq(m))
>    521				return DM_MAPIO_DELAY_REQUEUE;
>    522			dm_report_EIO(m);	/* Failed */
>    523			return DM_MAPIO_KILL;
>  > 524		} else if (mpath_double_check_test_bit(MPATHF_QUEUE_IO, m) ||
>    525			   mpath_double_check_test_bit(MPATHF_PG_INIT_REQUIRED, m)) {
>    526			pg_init_all_paths(m);
>    527			return DM_MAPIO_DELAY_REQUEUE;
>    528		}
>    529	
>    530		mpio->pgpath = pgpath;
>    531		mpio->nr_bytes = nr_bytes;
>    532	
>    533		bdev = pgpath->path.dev->bdev;
>    534		q = bdev_get_queue(bdev);
>    535		clone = blk_get_request(q, rq->cmd_flags | REQ_NOMERGE,
>    536				BLK_MQ_REQ_NOWAIT);
>    537		if (IS_ERR(clone)) {
>    538			/* EBUSY, ENODEV or EWOULDBLOCK: requeue */
>    539			if (blk_queue_dying(q)) {
>    540				atomic_inc(&m->pg_init_in_progress);
>    541				activate_or_offline_path(pgpath);
>    542				return DM_MAPIO_DELAY_REQUEUE;
>    543			}
>    544	
>    545			/*
>    546			 * blk-mq's SCHED_RESTART can cover this requeue, so we
>    547			 * needn't deal with it by DELAY_REQUEUE. More importantly,
>    548			 * we have to return DM_MAPIO_REQUEUE so that blk-mq can
>    549			 * get the queue busy feedback (via BLK_STS_RESOURCE),
>    550			 * otherwise I/O merging can suffer.
>    551			 */
>    552			return DM_MAPIO_REQUEUE;
>    553		}
>    554		clone->bio = clone->biotail = NULL;
>    555		clone->rq_disk = bdev->bd_disk;
>    556		clone->cmd_flags |= REQ_FAILFAST_TRANSPORT;
>    557		*__clone = clone;
>    558	
>    559		if (pgpath->pg->ps.type->start_io)
>    560			pgpath->pg->ps.type->start_io(&pgpath->pg->ps,
>    561						      &pgpath->path,
>    562						      nr_bytes);
>    563		return DM_MAPIO_REMAPPED;
>    564	}
>    565	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


