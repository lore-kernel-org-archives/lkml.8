Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FECC2D0E9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3AF2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="bPCMV1KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgC3IlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:41:14 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:15742 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729390AbgC3IlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:41:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585557672; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=GGGEL/LuAMxI6PsctPscsFZoLhU3QNYhVoPX6IYX7nQ=; b=bPCMV1KOZg6QZm4NxIj2+wQjh+rCAqR4zx7zx7qJ0bDgB70iIQORO6A83duOLIdFlXW6lGsn
 nK9jZTWuBjxCXlJDVQmRGVltoR6JDVjtkN7EDrXx/11SCgzGDtN+VAbziZ3Xvo8eL75Sj8lM
 13f8gcvYg4gSTJfxHdPfFMxa4Uw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e81b089.7f8cbd7ffdf8-smtp-out-n01;
 Mon, 30 Mar 2020 08:40:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EFFA1C43636; Mon, 30 Mar 2020 08:40:40 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BD12C433D2;
        Mon, 30 Mar 2020 08:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BD12C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Mon, 30 Mar 2020 14:10:33 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH] f2fs: prevent meta updates while checkpoint is in
 progress
Message-ID: <20200330084033.GU20234@codeaurora.org>
References: <1585219019-24831-1-git-send-email-stummala@codeaurora.org>
 <20200327192412.GA186975@google.com>
 <397da8a6-fdb4-9637-c6ea-803492c408a2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397da8a6-fdb4-9637-c6ea-803492c408a2@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 04:38:00PM +0800, Chao Yu wrote:
> Hi all,
> 
> On 2020/3/28 3:24, Jaegeuk Kim wrote:
> > Hi Sahitya,
> > 
> > On 03/26, Sahitya Tummala wrote:
> >> allocate_segment_for_resize() can cause metapage updates if
> >> it requires to change the current node/data segments for resizing.
> >> Stop these meta updates when there is a checkpoint already
> >> in progress to prevent inconsistent CP data.
> > 
> > Doesn't freeze|thaw_bdev(sbi->sb->s_bdev); work for you?
> 
> That can avoid foreground ops racing? rather than background ops like
> balance_fs() from kworker?
> 

Yes, that can only prevent foreground ops but not the background ops
invoked in the context of kworker thread.

> BTW, I found that {freeze,thaw}_bdev is not enough to freeze all
> foreground fs ops, it needs to use {freeze,thaw}_super instead.
> 

Yes, I agree.

Thanks,

> ---
>  fs/f2fs/gc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 26248c8936db..acdc8b99b543 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1538,7 +1538,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  		return -EINVAL;
>  	}
> 
> -	freeze_bdev(sbi->sb->s_bdev);
> +	freeze_super(sbi->sb);
> 
>  	shrunk_blocks = old_block_count - block_count;
>  	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
> @@ -1551,7 +1551,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  		sbi->user_block_count -= shrunk_blocks;
>  	spin_unlock(&sbi->stat_lock);
>  	if (err) {
> -		thaw_bdev(sbi->sb->s_bdev, sbi->sb);
> +		thaw_super(sbi->sb);
>  		return err;
>  	}
> 
> @@ -1613,6 +1613,6 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  	}
>  	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
>  	mutex_unlock(&sbi->resize_mutex);
> -	thaw_bdev(sbi->sb->s_bdev, sbi->sb);
> +	thaw_super(sbi->sb);
>  	return err;
>  }
> -- 
> 2.18.0.rc1
> 
> > 
> >>
> >> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >> ---
> >>  fs/f2fs/gc.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >> index 5bca560..6122bad 100644
> >> --- a/fs/f2fs/gc.c
> >> +++ b/fs/f2fs/gc.c
> >> @@ -1399,8 +1399,10 @@ static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
> >>  	int err = 0;
> >>  
> >>  	/* Move out cursegs from the target range */
> >> +	f2fs_lock_op(sbi);
> >>  	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++)
> >>  		allocate_segment_for_resize(sbi, type, start, end);
> >> +	f2fs_unlock_op(sbi);
> >>  
> >>  	/* do GC to move out valid blocks in the range */
> >>  	for (segno = start; segno <= end; segno += sbi->segs_per_sec) {
> >> -- 
> >> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> >> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> > .
> > 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
