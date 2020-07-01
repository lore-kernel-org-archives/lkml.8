Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024C2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C162D2080D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593620370;
	bh=2zNupGrsJWVvIy1EGdDug2tvMr8j7918+kyHDf++ejA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JaEGeuCluQGCgWABfneBXINzfkcmBrFMONu62gn9EMcQ0GAxEra6pkkhutwkxEmdx
	 AgQxh6HojZwuJGwAocGHznf+RsjlR1wJt5Z9kFSy4k4NVhxI3W4FlS0jDceWk7SQrc
	 tfdHKOT0KbzQyRmULJPF+KSByaNocUbf5UdUiqiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbgGAQT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgGAQT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:19:28 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAC7207BB;
        Wed,  1 Jul 2020 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593620368;
        bh=2zNupGrsJWVvIy1EGdDug2tvMr8j7918+kyHDf++ejA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHDPOc0FLDP3WLnhF3VbexIDJ4vOZBhmmYCWfOGkeAvEzeZAlnQFI9ozskQG1IBio
         c0UByb07z0wVjS5DmK3dTO14yPvWnf5hFOz7qdeQMQcOBfWfPFvNEXweF6F3J5pImm
         /jMBf9Kpd7HLKQKcvg4J3TLlnnZg7dOBAbWdCRVo=
Date:   Wed, 1 Jul 2020 09:19:27 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH RFC 2/5] f2fs: record average update time of segment
Message-ID: <20200701161927.GD1724572@google.com>
References: <20200630100428.19105-1-yuchao0@huawei.com>
 <20200630100428.19105-2-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630100428.19105-2-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30, Chao Yu wrote:
> Previously, once we update one block in segment, we will update mtime of
> segment to last time, making aged segment becoming freshest, result in
> that GC with cost benefit algorithm missing such segment, So this patch
> changes to record mtime as average block updating time instead of last
> updating time.
> 
> It's not needed to reset mtime for prefree segment, as se->valid_blocks
> is zero, then old se->mtime won't take any weight with below calculation:
> 
> 	se->mtime = (se->mtime * se->valid_blocks + mtime) /
> 				(se->valid_blocks + 1);
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/segment.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 863ec6f1fb87..906c313835ad 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2150,6 +2150,22 @@ static void __set_sit_entry_type(struct f2fs_sb_info *sbi, int type,
>  		__mark_sit_entry_dirty(sbi, segno);
>  }
>  
> +static void update_segment_mtime(struct f2fs_sb_info *sbi, block_t blkaddr)
> +{
> +	unsigned int segno = GET_SEGNO(sbi, blkaddr);
> +	struct seg_entry *se = get_seg_entry(sbi, segno);
> +	unsigned long long mtime = get_mtime(sbi, false);
> +
> +	if (!se->mtime) {

Don't need {}.

> +		se->mtime = mtime;
> +	} else {
> +		se->mtime = (se->mtime * se->valid_blocks + mtime) /
> +						(se->valid_blocks + 1);
> +	}
> +	if (mtime > SIT_I(sbi)->max_mtime)
> +		SIT_I(sbi)->max_mtime = mtime;
> +}
> +
>  static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>  {
>  	struct seg_entry *se;
> @@ -2169,10 +2185,9 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>  	f2fs_bug_on(sbi, (new_vblocks >> (sizeof(unsigned short) << 3) ||
>  				(new_vblocks > sbi->blocks_per_seg)));
>  
> +	update_segment_mtime(sbi, blkaddr);
> +
>  	se->valid_blocks = new_vblocks;
> -	se->mtime = get_mtime(sbi, false);
> -	if (se->mtime > SIT_I(sbi)->max_mtime)
> -		SIT_I(sbi)->max_mtime = se->mtime;
>  
>  	/* Update valid block bitmap */
>  	if (del > 0) {
> -- 
> 2.26.2
