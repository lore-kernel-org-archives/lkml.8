Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05975C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CABD820780
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587671395;
	bh=NdIcmjR1rpCMGh8Dhza7SRrZXqT4odEC+7YzykSaSFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EQdoHxAOddBMj0epjq2Y28lNBUPKpHNazGrAShVbXO8zAKr5BYUPc608LVKpAEW8F
	 UHnodt43a1cqett4Mu65Ur+52rCADsw1tyn8Ah2E86ve4P6UrxF0cWcJWwpTfB619R
	 n6EfqMLTpzc9uUvd2rilsGovzInDgEPaL2qMOhXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgDWTtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgDWTtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:49:53 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 464002076C;
        Thu, 23 Apr 2020 19:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587671393;
        bh=NdIcmjR1rpCMGh8Dhza7SRrZXqT4odEC+7YzykSaSFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnakBwVgRpRxEczGalqm5FmpNfotCzFm5qxdCkh6YSxtIKNFyvkpgqlFhvkGWuu81
         0Ttxk9coS5iU0AM59Mtz+scJ2GegLCIdJQAnVwKOqSK/jZevHdBqd/ZEZdi022cLQ+
         TImpW8U28qDWoUCqD020ADRwNlyCpg3+Urcj0sfY=
Date:   Thu, 23 Apr 2020 12:49:52 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix quota_sync failure due to
 f2fs_lock_op
Message-ID: <20200423194952.GA99191@google.com>
References: <20200409173056.229855-1-jaegeuk@kernel.org>
 <77e9f2e6-f3f3-8ca9-e6b5-3d57c4d2acc5@huawei.com>
 <20200416213946.GA196168@google.com>
 <fd8b116a-7830-809c-70a4-a3a12da1eb14@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd8b116a-7830-809c-70a4-a3a12da1eb14@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23, Chao Yu wrote:
> On 2020/4/17 5:39, Jaegeuk Kim wrote:
> > f2fs_quota_sync() uses f2fs_lock_op() before flushing dirty pages, but
> > f2fs_write_data_page() returns EAGAIN.
> > Likewise dentry blocks, we can just bypass getting the lock, since quota
> > blocks are also maintained by checkpoint.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > v2:
> >  - fix multipage write case
> > 
> >  fs/f2fs/compress.c | 2 +-
> >  fs/f2fs/data.c     | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index df7b2d15eacde..faaa358289010 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -985,7 +985,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
> >  	loff_t psize;
> >  	int i, err;
> >  
> > -	if (!f2fs_trylock_op(sbi))
> > +	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
> >  		return -EAGAIN;
> 
> I encounter deadlock..
> 
> Should call f2fs_unlock_op() for non-quota compressed inode later.

Could you elaborate a bit?

> 
> Thanks,
> 
> >  
> >  	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index accd28728642a..5c8d3823d7593 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -2656,8 +2656,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
> >  			f2fs_available_free_memory(sbi, BASE_CHECK))))
> >  		goto redirty_out;
> >  
> > -	/* Dentry blocks are controlled by checkpoint */
> > -	if (S_ISDIR(inode->i_mode)) {
> > +	/* Dentry/quota blocks are controlled by checkpoint */
> > +	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
> >  		fio.need_lock = LOCK_DONE;
> >  		err = f2fs_do_write_data_page(&fio);
> >  		goto done;
> > 
