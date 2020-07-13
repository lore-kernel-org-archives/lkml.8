Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896EAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6912075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594663169;
	bh=jYff8NftICD3TBpoWFUnqs9+MS1Oho2rTMQfEqKOJ8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o+h+iDYzX0X4jzRqM0YehYZi3LY7NMqSKeLNEbEJGGywu6Yy+XZZmZ2wdBPE0Dl92
	 26LfYl/lIO5HYhivWbd/8xDs52/po0rMwJgZ9O+JcTlV9BvsT0qtAjIz+9CBmcrIUR
	 4Y6cl6NCkNGjR1VpJRr3FopaxZXG2BHvzBSPC8UY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgGMR71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729681AbgGMR71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:59:27 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A4C420738;
        Mon, 13 Jul 2020 17:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594663166;
        bh=jYff8NftICD3TBpoWFUnqs9+MS1Oho2rTMQfEqKOJ8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIZNK5mmN8vEWKA88hxyoMZpVtT4UFsTYK0r1q22uV0aM1FrAlGCnT/d9wEgP/mLY
         3CE/NkGm7320FBz+6osN5ZG7ELPh3aKr0vlEmsMldsLUE6EqWWYdayiqbdjGOfd/I/
         cgVXGTgETLPxNChoGnytb50IAmGnPr6bzYGrFKxU=
Date:   Mon, 13 Jul 2020 10:59:26 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't skip writeback of quota data
Message-ID: <20200713175926.GB2910046@google.com>
References: <20200709053027.351974-1-jaegeuk@kernel.org>
 <2f4207db-57d1-5b66-f1ee-3532feba5d1f@huawei.com>
 <20200709190545.GA3001066@google.com>
 <ae1a3e8a-6209-8d4b-7235-5c8897076501@huawei.com>
 <20200710032616.GC545837@google.com>
 <01d0db54-eee1-f6cd-76c3-ebe59a7abae4@huawei.com>
 <20200710035053.GH545837@google.com>
 <77041117-f615-e6e6-591c-b02bf99e58c2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77041117-f615-e6e6-591c-b02bf99e58c2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, Chao Yu wrote:
> On 2020/7/10 11:50, Jaegeuk Kim wrote:
> > On 07/10, Chao Yu wrote:
> >> On 2020/7/10 11:26, Jaegeuk Kim wrote:
> >>> On 07/10, Chao Yu wrote:
> >>>> On 2020/7/10 3:05, Jaegeuk Kim wrote:
> >>>>> On 07/09, Chao Yu wrote:
> >>>>>> On 2020/7/9 13:30, Jaegeuk Kim wrote:
> >>>>>>> It doesn't need to bypass flushing quota data in background.
> >>>>>>
> >>>>>> The condition is used to flush quota data in batch to avoid random
> >>>>>> small-sized udpate, did you hit any problem here?
> >>>>>
> >>>>> I suspect this causes fault injection test being stuck by waiting for inode
> >>>>> writeback completion. With this patch, it has been running w/o any issue so far.
> >>>>> I keep an eye on this.
> >>>>
> >>>> Hmmm.. so that this patch may not fix the root cause, and it may hiding the
> >>>> issue deeper.
> >>>>
> >>>> How about just keeping this patch in our private branch to let fault injection
> >>>> test not be stuck? until we find the root cause in upstream codes.
> >>>
> >>> Well, I don't think this hides something. When the issue happens, I saw inodes
> >>> being stuck due to writeback while only quota has some dirty data. At that time,
> >>> there was no dirty data page from other inodes.
> >>
> >> Okay,
> >>
> >>>
> >>> More specifically, I suspect __writeback_inodes_sb_nr() gives WB_SYNC_NONE and
> >>> waits for wb_wait_for_completion().
> >>
> >> Did you record any callstack after the issue happened?
> > 
> > I found this.
> > 
> > [213389.297642]  __schedule+0x2dd/0x780^M
> > [213389.299224]  schedule+0x55/0xc0^M
> > [213389.300745]  wb_wait_for_completion+0x56/0x90^M
> > [213389.302469]  ? wait_woken+0x80/0x80^M
> > [213389.303997]  __writeback_inodes_sb_nr+0xa8/0xd0^M
> > [213389.305760]  writeback_inodes_sb+0x4b/0x60^M
> > [213389.307439]  sync_filesystem+0x2e/0xa0^M
> > [213389.308999]  generic_shutdown_super+0x27/0x110^M
> > [213389.310738]  kill_block_super+0x27/0x50^M
> > [213389.312327]  kill_f2fs_super+0x76/0xe0 [f2fs]^M
> > [213389.314014]  deactivate_locked_super+0x3b/0x80^M
> > [213389.315692]  deactivate_super+0x3e/0x50^M
> > [213389.317226]  cleanup_mnt+0x109/0x160^M
> > [213389.318718]  __cleanup_mnt+0x12/0x20^M
> > [213389.320177]  task_work_run+0x70/0xb0^M
> > [213389.321609]  exit_to_usermode_loop+0x131/0x160^M
> > [213389.323306]  do_syscall_64+0x170/0x1b0^M
> > [213389.324762]  entry_SYSCALL_64_after_hwframe+0x44/0xa9^M
> > [213389.326477] RIP: 0033:0x7fc4b5e6a35b^M
> 
> Does this only happen during umount? If so, will below change help?
> 
> 	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
> +			!is_sbi_flag_set(sbi, SBI_IS_CLOSE) &&
> 			wbc->sync_mode == WB_SYNC_NONE &&
> 			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
> 			f2fs_available_free_memory(sbi, DIRTY_DENTS))
> 		goto skip_write;

Hmm, this doesn't work. The writeback was called before put_super?
I'll try the original patch one more time.

> 
> > 
> >>
> >> Still I'm confused that why directory's data written could be skipped, but
> >> quota's data couldn't, what's the difference?
> > 
> > I suspect different blocking timing from cp_error between quota and dentry.
> > e.g., we block dir operations right after cp_error, while quota can make
> 
> No guarantee that there is no dirty dentry being created after
> cp_error, right?
> 
> e.g.
> 
> Thread A				Thread B
> - f2fs_create
> - bypass f2fs_cp_error
> 					- set cp_error
> - create dirty dentry
> 
> BTW, do you know what __writeback_inodes_sb_nr is waiting for?
> 
> > dirty pages in more fine granularity.
> > 
> >>
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>>
> >>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>>>>> ---
> >>>>>>>  fs/f2fs/data.c | 2 +-
> >>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>>>>> index 44645f4f914b6..72e8b50e588c1 100644
> >>>>>>> --- a/fs/f2fs/data.c
> >>>>>>> +++ b/fs/f2fs/data.c
> >>>>>>> @@ -3148,7 +3148,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
> >>>>>>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> >>>>>>>  		goto skip_write;
> >>>>>>>  
> >>>>>>> -	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
> >>>>>>> +	if (S_ISDIR(inode->i_mode) &&
> >>>>>>>  			wbc->sync_mode == WB_SYNC_NONE &&
> >>>>>>>  			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
> >>>>>>>  			f2fs_available_free_memory(sbi, DIRTY_DENTS))
> >>>>>>>
> >>>>> .
> >>>>>
> >>> .
> >>>
> > .
> > 
