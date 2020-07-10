Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B01C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C570820674
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594351578;
	bh=7gmNfMi/rLNIENPbSZx/x5H/MTRJkr2euZEuEvVPgUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2kBCvH5Yq9gRCj4aC23nFuwXlSWDH7xr6YtX+t5sun+W1YLxYu/W4qPKlX2YSlIZk
	 T+eioKAjA4v10I8dewJR+K4KW6bMJSkKKukCB+NwDEVXJsFx4CBH4Quedvn6v7wrPK
	 zH9o23yePqNV9XPD8hlYQmfVkD2TRmsGvXULGdoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgGJD0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgGJD0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:26:17 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BADC62065C;
        Fri, 10 Jul 2020 03:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594351576;
        bh=7gmNfMi/rLNIENPbSZx/x5H/MTRJkr2euZEuEvVPgUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9CaNGGMcFwZccyYv5fh7EOp8Y1iQNgL/U5aRlkn/hkKwXR6hDo5OEPj2dUz8ncyL
         O+yY0glchFxS3hl8voOv6GiuHIQt4DKSyDS5R3GBod4TnXRwZb954mpzTTR3E+Qf69
         V/qcV/+xeB2c3x7DypQ5D+xqTPX5ktJDR3L5+ypE=
Date:   Thu, 9 Jul 2020 20:26:16 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't skip writeback of quota data
Message-ID: <20200710032616.GC545837@google.com>
References: <20200709053027.351974-1-jaegeuk@kernel.org>
 <2f4207db-57d1-5b66-f1ee-3532feba5d1f@huawei.com>
 <20200709190545.GA3001066@google.com>
 <ae1a3e8a-6209-8d4b-7235-5c8897076501@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1a3e8a-6209-8d4b-7235-5c8897076501@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, Chao Yu wrote:
> On 2020/7/10 3:05, Jaegeuk Kim wrote:
> > On 07/09, Chao Yu wrote:
> >> On 2020/7/9 13:30, Jaegeuk Kim wrote:
> >>> It doesn't need to bypass flushing quota data in background.
> >>
> >> The condition is used to flush quota data in batch to avoid random
> >> small-sized udpate, did you hit any problem here?
> > 
> > I suspect this causes fault injection test being stuck by waiting for inode
> > writeback completion. With this patch, it has been running w/o any issue so far.
> > I keep an eye on this.
> 
> Hmmm.. so that this patch may not fix the root cause, and it may hiding the
> issue deeper.
> 
> How about just keeping this patch in our private branch to let fault injection
> test not be stuck? until we find the root cause in upstream codes.

Well, I don't think this hides something. When the issue happens, I saw inodes
being stuck due to writeback while only quota has some dirty data. At that time,
there was no dirty data page from other inodes.

More specifically, I suspect __writeback_inodes_sb_nr() gives WB_SYNC_NONE and
waits for wb_wait_for_completion().

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>> ---
> >>>  fs/f2fs/data.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>> index 44645f4f914b6..72e8b50e588c1 100644
> >>> --- a/fs/f2fs/data.c
> >>> +++ b/fs/f2fs/data.c
> >>> @@ -3148,7 +3148,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
> >>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> >>>  		goto skip_write;
> >>>  
> >>> -	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
> >>> +	if (S_ISDIR(inode->i_mode) &&
> >>>  			wbc->sync_mode == WB_SYNC_NONE &&
> >>>  			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
> >>>  			f2fs_available_free_memory(sbi, DIRTY_DENTS))
> >>>
> > .
> > 
