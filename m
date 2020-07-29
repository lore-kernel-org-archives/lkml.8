Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915DEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61916207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596039707;
	bh=kU7UT3i0MXW7gqzbaCFlt/VbDV/ZBUwOIl76CXUqX2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x2FUVIqRcczQAUhK1kWLAS1WWG0U4Ngd/08V7epOID3v7Q3SOx9VstfI01SWDWgP0
	 POzgAs4Zaf+N8e3zujDqw9AqKuZjUUAJHWA7eBKRm/aZMe689t+5vgIUyfuEGKqWq8
	 X2ShhKPl9RKjeR3Q3ejtZoTniC63jtiNU4d/UscM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgG2QVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2QVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 12:21:46 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FA8F2075D;
        Wed, 29 Jul 2020 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596039705;
        bh=kU7UT3i0MXW7gqzbaCFlt/VbDV/ZBUwOIl76CXUqX2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Byo40t5PhbmfTgovNn4pTryjQyJPinICU2cOtioUZM9MofRtpmqMkeY+Cri6Gb+R9
         uKjxjiG4JQdUMbNG1WjF+crg9tQ8vQvJ0hDGyKOcWMtTP/Vy6nk9OYz2qE8gy+vo6Q
         z5/2p7KaXf1M0R8ovcuf5rS/UWswH3NSXXsA9NKI=
Date:   Wed, 29 Jul 2020 09:21:44 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix deadlock between quota writes and
 checkpoint
Message-ID: <20200729162144.GA1460954@google.com>
References: <20200729070244.584518-1-jaegeuk@kernel.org>
 <054f161c-05db-73b7-3d83-be7addcd6015@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <054f161c-05db-73b7-3d83-be7addcd6015@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29, Chao Yu wrote:
> On 2020-7-29 15:02, Jaegeuk Kim wrote:
> > f2fs_write_data_pages(quota_mapping)
> >  __f2fs_write_data_pages             f2fs_write_checkpoint
> >   * blk_start_plug(&plug);
> >   * add bio in write_io[DATA]
> >                                       - block_operations
> >                                       - skip syncing quota by
> >                                                 >DEFAULT_RETRY_QUOTA_FLUSH_COUNT
> >                                       - down_write(&sbi->node_write);
> >   - f2fs_write_single_data_page
> 
> After commit 79963d967b49 ("f2fs: shrink node_write lock coverage"),
> node_write lock was moved to f2fs_write_single_data_page() and
> f2fs_write_compressed_pages().
> 
> So it needs to update the callstack.
> 
> - down_write(node_write)

Yeah, applied. :)

> 
> Otherwise it looks good to me.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> >     - f2fs_do_write_data_page
> >       - f2fs_outplace_write_data
> >         - do_write_page
> >            - f2fs_allocate_data_block
> >             - down_write(node_write)
> >                                       - f2fs_wait_on_all_pages(F2FS_WB_CP_DATA);
> > 
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/checkpoint.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 8c782d3f324f0..99c8061da55b9 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1269,6 +1269,8 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
> >  		if (type == F2FS_DIRTY_META)
> >  			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
> >  							FS_CP_META_IO);
> > +		else if (type == F2FS_WB_CP_DATA)
> > +			f2fs_submit_merged_write(sbi, DATA);
> >  		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
> >  	}
> >  	finish_wait(&sbi->cp_wait, &wait);
> > 
