Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB977C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF19A2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596513282;
	bh=1wIRTKIibHj2cuI0fbbKzQxUIbvtAf6aPbLlnn72kQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OHT7Ix08s3xRmsxqhj9kEuXkS/U1J2Dsh+Lq5+qA07bP5QQ/39lp/nTs/bacjPp4r
	 67wkfX8/aWAklpsWPKDKYVglYmKfvxzP4bgD31vVGE9o0nsa93tkYZTSEszErxiaG6
	 TAtzmU2Y0OHCZ39V2Ce53oQ3gTsqXX+mV+scIOEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgHDDyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 23:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728867AbgHDDyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 23:54:40 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9DD206F6;
        Tue,  4 Aug 2020 03:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596513280;
        bh=1wIRTKIibHj2cuI0fbbKzQxUIbvtAf6aPbLlnn72kQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEbXUgW3AcpI2xod1XByY6z3bwg8Y/HzIsjplM1wVG4q6mFuvd1L2OpV6Lnza4GpY
         +1tgSWn0K6UAVPxO0/NMjLZRxD38usgw0MvkfHrpzeDM+qTH/uEchteYXOu4xotkSv
         GuCwsksVXLhfcmLfkXVamKL3a/P4sHSVUaddoUmQ=
Date:   Mon, 3 Aug 2020 20:54:39 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix deadlock between quota writes and
 checkpoint
Message-ID: <20200804035439.GA903802@google.com>
References: <20200729070244.584518-1-jaegeuk@kernel.org>
 <670f35e1-872b-6602-320c-dd73bcb62510@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670f35e1-872b-6602-320c-dd73bcb62510@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04, Chao Yu wrote:
> On 2020/7/29 15:02, Jaegeuk Kim wrote:
> > f2fs_write_data_pages(quota_mapping)
> >   __f2fs_write_data_pages             f2fs_write_checkpoint
> >    * blk_start_plug(&plug);
> >    * add bio in write_io[DATA]
> >                                        - block_operations
> >                                        - skip syncing quota by
> >                                                  >DEFAULT_RETRY_QUOTA_FLUSH_COUNT
> >                                        - down_write(&sbi->node_write);
> 
> f2fs_flush_merged_writes() will be called after block_operations(), why this doesn't
> help?

Well, I think bio can be added after f2fs_flush_merged_writes() as well.

> 
> >    - f2fs_write_single_data_page
> >      - f2fs_do_write_data_page
> >        - f2fs_outplace_write_data
> >          - do_write_page
> >             - f2fs_allocate_data_block
> >              - down_write(node_write)
> >                                        - f2fs_wait_on_all_pages(F2FS_WB_CP_DATA);
> > 
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/checkpoint.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 8c782d3f324f0..99c8061da55b9 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1269,6 +1269,8 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
> >   		if (type == F2FS_DIRTY_META)
> >   			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
> >   							FS_CP_META_IO);
> > +		else if (type == F2FS_WB_CP_DATA)
> > +			f2fs_submit_merged_write(sbi, DATA);
> >   		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
> >   	}
> >   	finish_wait(&sbi->cp_wait, &wait);
> > 
