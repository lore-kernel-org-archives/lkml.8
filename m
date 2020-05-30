Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A66FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 15:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64DE2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590851913;
	bh=GuykneO4xF7E2ZbE2PUonWUpUelDYrhMz+9mZESaYos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nNBGmhahLY9n8op+fFLknAMqyYGYH98tZ3U/Pa3LQ946dIbZj70aMaq1Cy5LS/fmv
	 X/03GxmyHFoiVTjEmFjt5LoZEtvyioLHx8IQlDC+5SGIlXqFKZvxZ4G1fjovyZyiW2
	 D7S3qreP6h73nPncj1duJujEr4bpcZl8GJWQ2XBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgE3PSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 11:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbgE3PSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 11:18:32 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A6320715;
        Sat, 30 May 2020 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590851911;
        bh=GuykneO4xF7E2ZbE2PUonWUpUelDYrhMz+9mZESaYos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRKTXQ5rDaU9SXV9ZhQuBJk1mt00L5xTlldVKnIYuemR7auiWuFd5AcecJJCqSN6c
         N3KE6R+kD0ruC/ckFHsN6jH4xCL4AgMdY6sIzPEAgznS8JMpGnzJS4VdM0C3dqJy7B
         85PUSCMRs4J306DSF/qJBF6K5oP5OYCl5YsMjHP0=
Date:   Sat, 30 May 2020 08:18:31 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] Revert "f2fs: fix quota_sync failure due to f2fs_lock_op"
Message-ID: <20200530151831.GB184700@google.com>
References: <20200529092947.7890-1-yuchao0@huawei.com>
 <20200529223426.GA249109@google.com>
 <96ba756e-a354-1ee8-689e-211f63c294e6@huawei.com>
 <20200530014926.GA39950@google.com>
 <dcd3564c-16c3-4e4c-a21f-7fec46cec181@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcd3564c-16c3-4e4c-a21f-7fec46cec181@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30, Chao Yu wrote:
> On 2020/5/30 9:49, Jaegeuk Kim wrote:
> > On 05/30, Chao Yu wrote:
> >> On 2020/5/30 6:34, Jaegeuk Kim wrote:
> >>> On 05/29, Chao Yu wrote:
> >>>> Under heavy fsstress, we may triggle panic while issuing discard,
> >>>> because __check_sit_bitmap() detects that discard command may earse
> >>>> valid data blocks, the root cause is as below race stack described,
> >>>> since we removed lock when flushing quota data, quota data writeback
> >>>> may race with write_checkpoint(), so that it causes inconsistency in
> >>>> between cached discard entry and segment bitmap.
> >>>>
> >>>> - f2fs_write_checkpoint
> >>>>  - block_operations
> >>>>   - set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH)
> >>>>  - f2fs_flush_sit_entries
> >>>>   - add_discard_addrs
> >>>>    - __set_bit_le(i, (void *)de->discard_map);
> >>>> 						- f2fs_write_data_pages
> >>>> 						 - f2fs_write_single_data_page
> >>>> 						   : inode is quota one, cp_rwsem won't be locked
> >>>> 						  - f2fs_do_write_data_page
> >>>> 						   - f2fs_allocate_data_block
> >>>> 						    - f2fs_wait_discard_bio
> >>>> 						      : discard entry has not been added yet.
> >>>> 						    - update_sit_entry
> >>>>  - f2fs_clear_prefree_segments
> >>>>   - f2fs_issue_discard
> >>>>   : add discard entry
> >>>>
> >>>> This patch fixes this issue by reverting 435cbab95e39 ("f2fs: fix quota_sync
> >>>> failure due to f2fs_lock_op").
> >>>>
> >>>> Fixes: 435cbab95e39 ("f2fs: fix quota_sync failure due to f2fs_lock_op")
> >>>
> >>> The previous patch fixes quota_sync gets EAGAIN all the time.
> >>> How about this? It seems this works for fsstress test.
> >>>
> > 
> > Then this?
> > 
> > ---
> >  fs/f2fs/segment.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index ebbadde6cbced..ed11dcf2d69ed 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -3107,6 +3107,14 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
> >  		type = CURSEG_COLD_DATA;
> >  	}
> >  
> > +	/*
> > +	 * We need to wait for node_write to avoid block allocation during
> > +	 * checkpoint. This can only happen to quota writes which can cause
> > +	 * the below discard race condition.
> > +	 */
> > +	if (IS_DATASEG(type))
> > +		down_write(&sbi->node_write);
> > +
> >  	down_read(&SM_I(sbi)->curseg_lock);
> >  
> >  	mutex_lock(&curseg->curseg_mutex);
> > @@ -3174,6 +3182,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
> 
> Minor thing: unlock order.
> 
> if (IS_DATASEG(type))
> 	up_write(&sbi->node_write);
> 
> Could you merge the diff into this patch?

Pushed in dev branch. Thanks.

> 
> >  
> >  	if (put_pin_sem)
> >  		up_read(&sbi->pin_sem);
> > +
> > +	if (IS_DATASEG(type))
> > +		up_write(&sbi->node_write);
> >  }
> >  
> >  static void update_device_state(struct f2fs_io_info *fio)
> > 
