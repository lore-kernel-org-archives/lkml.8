Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C56C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5452071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587687390;
	bh=OdoPiLVtyTKEI0DuaHYOuft8FO03Y+aJmEEYHn2bTyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uTW7dpHwZ61Qg91bUusOlP2EZkUyzDf31LqS3FZIEpwjH0mvibazpb1P7iQ7fC4W3
	 e/31xzKnmvl60Yj5OLMDYQxkNnbNWYB3A/DCe8JGL8cpSzuYuaqqRyMIe9V8SLrO4c
	 Rt7n2i3d49zHgjgdysI2DkApcrItMa+aiTZE3eIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgDXAQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgDXAQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 20:16:20 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A21CC20CC7;
        Fri, 24 Apr 2020 00:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587687379;
        bh=OdoPiLVtyTKEI0DuaHYOuft8FO03Y+aJmEEYHn2bTyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYF725AwD7DGwMZo/fuDIwPQ7x4nFOxEvpuA8iC+U/+4jJu0ce5FhHgLfUjjUvNXV
         iht7mfch5R3y+2mN/H/kJe4VPyA6VKaobvvTmdQI0l2a6PaBw7DHqR+9cgUnMNkUnt
         4M3+H3+QQqfEoQFQ9rufRlQ4HXp2N1NjbIuS9lDA=
Date:   Thu, 23 Apr 2020 17:16:19 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: Avoid double lock for cp_rwsem
Message-ID: <20200424001619.GA109617@google.com>
References: <1587636832-17939-1-git-send-email-sayalil@codeaurora.org>
 <20200423201922.GB99191@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423201922.GB99191@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23, Jaegeuk Kim wrote:
> On 04/23, Sayali Lokhande wrote:
> > Call stack :
> > f2fs_write_checkpoint()
> > -> block_operations(sbi)
> >     f2fs_lock_all(sbi);
> >      down_write(&sbi->cp_rwsem); => write lock held
> > <>
> > -> f2fs_sync_node_pages()
> >     if (is_inline_node(page))
> >      flush_inline_data()
> > 	page = f2fs_pagecache_get_page()
> >          if (!page)
> >            goto iput_out;
> > 	iput_out:
> > 	 iput(inode);
> >           -> f2fs_evict_inode()
> > 	      f2fs_truncate_blocks()
> > 	       f2fs_lock_op()
> > 	        down_read(&sbi->cp_rwsem); => read lock fail
> 
> How about this, since we don't actually need to flush inline_data?

Hmm, nvm. This causes no space panic regressed during xfstests.

> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 4da0d8713df5c..9af8d5319fdd3 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1871,7 +1871,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>                         }
> 
>                         /* flush inline_data */
> -                       if (is_inline_node(page)) {
> +                       if (is_inline_node(page) && io_type != FS_CP_NODE_IO) {
>                                 clear_inline_node(page);
>                                 unlock_page(page);
>                                 flush_inline_data(sbi, ino_of_node(page));
> 
> > 
> > Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> > ---
> >  fs/f2fs/checkpoint.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 5ba649e..5c504cf 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1219,21 +1219,19 @@ static int block_operations(struct f2fs_sb_info *sbi)
> >  		goto retry_flush_quotas;
> >  	}
> >  
> > -retry_flush_nodes:
> >  	down_write(&sbi->node_write);
> >  
> >  	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
> >  		up_write(&sbi->node_write);
> > +		f2fs_unlock_all(sbi);
> >  		atomic_inc(&sbi->wb_sync_req[NODE]);
> >  		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
> >  		atomic_dec(&sbi->wb_sync_req[NODE]);
> > -		if (err) {
> > -			up_write(&sbi->node_change);
> > -			f2fs_unlock_all(sbi);
> > +		up_write(&sbi->node_change);
> > +		if (err)
> >  			goto out;
> > -		}
> >  		cond_resched();
> > -		goto retry_flush_nodes;
> > +		goto retry_flush_quotas;
> >  	}
> >  
> >  	/*
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
