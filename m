Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C71AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CED12086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596509002;
	bh=xvp8Mu9DSxtz7EcA0qcPLMCcKWlAwAL0ped/i8d3z0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uaqrqWezq1XYJEHj2g3kukuez6Lox0g4XDgdW/eCE8zy1KKTRz4bu3DPycAWmD7Uj
	 hg+MTQLdewzgl+PbEcmNIsOjnOE6N8nL1oAkuLjzcnMfBU4kYwNf/wBHOSdgS966J8
	 Q23L+J7biUJj4f2FOI9uTREIZQSUD1I+Syy4T6pQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgHDCnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 22:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729831AbgHDCnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:43:19 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D962245C;
        Tue,  4 Aug 2020 02:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596508998;
        bh=xvp8Mu9DSxtz7EcA0qcPLMCcKWlAwAL0ped/i8d3z0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qe+D8xuxKX3floL30KQsdG+t6t05RZrl8QeD73oUQnYMCc89DMTlYJxQ570qfD4KP
         wPCZGAW8+gmm8WfmHxx4ZLfCJe996dyeA311HlNn58/GCC3gfKJQtsBm6lbL9OExgo
         N5tcuR4LMjIutPI6F7WkzLrMZm3DDjnVybF5w8TY=
Date:   Mon, 3 Aug 2020 19:43:17 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove a waiter for checkpoint
 completion
Message-ID: <20200804024317.GA884736@google.com>
References: <20200803172825.4077289-1-jaegeuk@kernel.org>
 <9638d2c5-cfd0-359f-187a-8e23bc6d822d@huawei.com>
 <20200804010412.GA866340@google.com>
 <98ac9355-bb6c-5109-da73-4ab7cdbbf8d5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98ac9355-bb6c-5109-da73-4ab7cdbbf8d5@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04, Chao Yu wrote:
> On 2020/8/4 9:04, Jaegeuk Kim wrote:
> > On 08/04, Chao Yu wrote:
> > > On 2020/8/4 1:28, Jaegeuk Kim wrote:
> > > > It doesn't need to wait for checkpoint being completed triggered by end_io.
> > > > 
> > > > [   20.157753] ------------[ cut here ]------------
> > > > [   20.158393] do not call blocking ops when !TASK_RUNNING; state=2 set at [<0000000096354225>] prepare_to_wait+0xcd/0x430
> > > > [   20.159858] WARNING: CPU: 1 PID: 1152 at kernel/sched/core.c:7142 __might_sleep+0x149/0x1a0
> > > > ...
> > > > [   20.176110]  __submit_merged_write_cond+0x191/0x310
> > > > [   20.176739]  f2fs_submit_merged_write+0x18/0x20
> > > > [   20.177323]  f2fs_wait_on_all_pages+0x269/0x2d0
> > > > [   20.177899]  ? block_operations+0x980/0x980
> > > > [   20.178441]  ? __kasan_check_read+0x11/0x20
> > > > [   20.178975]  ? finish_wait+0x260/0x260
> > > > [   20.179488]  ? percpu_counter_set+0x147/0x230
> > > > [   20.180049]  do_checkpoint+0x1757/0x2a50
> > > > [   20.180558]  f2fs_write_checkpoint+0x840/0xaf0
> > > > [   20.181126]  f2fs_sync_fs+0x287/0x4a0
> > > > 
> > > > Reported-by: Eric Biggers <ebiggers@kernel.org>
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > ---
> > > >    fs/f2fs/checkpoint.c | 6 +-----
> > > >    fs/f2fs/data.c       | 4 ----
> > > >    fs/f2fs/f2fs.h       | 1 -
> > > >    fs/f2fs/super.c      | 1 -
> > > >    4 files changed, 1 insertion(+), 11 deletions(-)
> > > > 
> > > > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > > > index 99c8061da55b9..2bdddc725e677 100644
> > > > --- a/fs/f2fs/checkpoint.c
> > > > +++ b/fs/f2fs/checkpoint.c
> > > > @@ -1255,11 +1255,7 @@ static void unblock_operations(struct f2fs_sb_info *sbi)
> > > >    void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
> > > >    {
> > > > -	DEFINE_WAIT(wait);
> > > > -
> > > >    	for (;;) {
> > > > -		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
> > > 
> > > Wouldn't that case high cpu usage before io end?
> > 
> > This is a critical path to wait for IO completion in checkpoint, which would be
> > better to wait for it to avoid long latency to continue filesystem operations.
> 
> Yup, in previous implementation, last end_io wakes up checkpoint() waiter, we
> didn't waste any time there.
> 
> > Moreover, I expect io_schedule_timeout() can mitigate such the CPU overhead and
> > actually we don't need to make there-in context switches as well.
> 
> Then io_schedule_timeout() in this loop may give CPU time slice to other thread
> until scheduler reselect checkpoint(), that would cause longer latency?

Hmm, how about this then?

From 4956afa1cedc019cabf6e8bff7bc48d3bcf7a3f5 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 3 Aug 2020 19:37:12 -0700
Subject: [PATCH] f2fs: prepare a waiter before entering io_schedule

This is to avoid sleep() in the waiter thread.

[   20.157753] ------------[ cut here ]------------
[   20.158393] do not call blocking ops when !TASK_RUNNING; state=2 set at [<0000000096354225>] prepare_to_wait+0xcd/0x430
[   20.159858] WARNING: CPU: 1 PID: 1152 at kernel/sched/core.c:7142 __might_sleep+0x149/0x1a0
...
[   20.176110]  __submit_merged_write_cond+0x191/0x310
[   20.176739]  f2fs_submit_merged_write+0x18/0x20
[   20.177323]  f2fs_wait_on_all_pages+0x269/0x2d0
[   20.177899]  ? block_operations+0x980/0x980
[   20.178441]  ? __kasan_check_read+0x11/0x20
[   20.178975]  ? finish_wait+0x260/0x260
[   20.179488]  ? percpu_counter_set+0x147/0x230
[   20.180049]  do_checkpoint+0x1757/0x2a50
[   20.180558]  f2fs_write_checkpoint+0x840/0xaf0
[   20.181126]  f2fs_sync_fs+0x287/0x4a0

Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 99c8061da55b9..ff807e14c8911 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1258,8 +1258,6 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 	DEFINE_WAIT(wait);
 
 	for (;;) {
-		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
-
 		if (!get_pages(sbi, type))
 			break;
 
@@ -1271,6 +1269,8 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 							FS_CP_META_IO);
 		else if (type == F2FS_WB_CP_DATA)
 			f2fs_submit_merged_write(sbi, DATA);
+
+		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
 		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 	}
 	finish_wait(&sbi->cp_wait, &wait);
-- 
2.28.0.163.g6104cc2f0b6-goog

