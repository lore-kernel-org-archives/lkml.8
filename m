Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC55C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A7821D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583857121;
	bh=S1BKfDbjA1iRAn3ZZqZEqHXcCp/sA+icgC/rWITTyl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pm8DirwaXXnd4MzNGtLt7/Ds122QTTMGveLkNxmne3wloje/PenvJQ7bmHet0OBry
	 QtfW2dQJmXsMTby5NssGYEMXHgyCGkahCwFx0uDcBCHJnyOHlc4wSFLVaVBt1rcDaZ
	 RKpupd5tnidzRPLg4k0bFjFcGvkDB9EB9pup6VaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgCJQSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgCJQSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:18:40 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 287A420873;
        Tue, 10 Mar 2020 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583857119;
        bh=S1BKfDbjA1iRAn3ZZqZEqHXcCp/sA+icgC/rWITTyl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbmLKWbKqzpbhhIUi6xrKsdd4lokgJa/FCeZ1/1F11RdP+MMJbdWChWhw15lfVUZn
         GKP+FFET/eK75dVo8jugvBoGpquwYT3h9ZtuRKMhrOyvLFw6eLKOuwXlXyvnrr3/Qj
         bYJlaEEzuqw5Bsg7pUK2MmY9hblNNDwqtMnVc5jk=
Date:   Tue, 10 Mar 2020 09:18:38 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to check i_compr_blocks correctly
Message-ID: <20200310161838.GB240315@google.com>
References: <20200225102646.43367-1-yuchao0@huawei.com>
 <3525f924-7d65-c005-a7e6-d315cf14aab2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3525f924-7d65-c005-a7e6-d315cf14aab2@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2020-2-25 18:26, Chao Yu wrote:
> > inode.i_blocks counts based on 512byte sector, we need to convert
> > to 4kb sized block count before comparing to i_compr_blocks.
> > 
> > In addition, add to print message when sanity check on inode
> > compression configs failed.
> > 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> >  fs/f2fs/inode.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 156cc5ef3044..299611562f7e 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -291,13 +291,30 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
> >  			fi->i_flags & F2FS_COMPR_FL &&
> >  			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
> >  						i_log_cluster_size)) {
> > -		if (ri->i_compress_algorithm >= COMPRESS_MAX)
> > +		if (ri->i_compress_algorithm >= COMPRESS_MAX) {
> > +			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
> > +				"compress algorithm: %u, run fsck to fix",
> > +				  __func__, inode->i_ino,
> > +				  ri->i_compress_algorithm);
> >  			return false;
> > -		if (le64_to_cpu(ri->i_compr_blocks) > inode->i_blocks)
> > +		}
> > +		if (le64_to_cpu(ri->i_compr_blocks) >
> > +				SECTOR_TO_BLOCK(inode->i_blocks)) {
> > +			f2fs_warn(sbi, "%s: inode (ino=%lx) hash inconsistent "
> 
> This is a typo: hash -> has
> 
> Could you please manually fix this in your tree?

Done.

> 
> Thanks
> 
> > +				"i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
> > +				  __func__, inode->i_ino,
> > +				  le64_to_cpu(ri->i_compr_blocks),
> > +				  SECTOR_TO_BLOCK(inode->i_blocks));
> >  			return false;
> > +		}
> >  		if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> > -			ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE)
> > +			ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
> > +			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
> > +				"log cluster size: %u, run fsck to fix",
> > +				  __func__, inode->i_ino,
> > +				  ri->i_log_cluster_size);
> >  			return false;
> > +		}
> >  	}
> > 
> >  	return true;
> > 
