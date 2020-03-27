Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE6AC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793B120737
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585337054;
	bh=qt6SbvEQShuKIl/6a/6slI+vmFBgRwo48MnklEokrOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vJC9HkS91XNdW181BYAP/JmynwFiufttN/TGEdZREcHJkci3bwJ8YNAkC6uo3X9eP
	 +mFBjki7zGmK66zrZytNrZDqAr2ya3fG8cToCS0Z1Cl4wcCSOHMMgy7TrxaU0ihtvI
	 3Akokz9YlHtAmzPRry8TH0/bnW8XH9uJscs2S5Z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgC0TYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgC0TYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 15:24:13 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A713206E6;
        Fri, 27 Mar 2020 19:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585337052;
        bh=qt6SbvEQShuKIl/6a/6slI+vmFBgRwo48MnklEokrOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wxARzqqdtgKfS3KjIlCaVHSzxYdqXgoeK01ef4pGrKZHx7IBEWmP6//vU0itLS1ZA
         /3s2iEbTmyJe1ek/xLn0FpWvYOyLvO8Obm3GNc+HhIJVHUYCCezTpT/nVdQG7C/asF
         J/pDGPCYUWB0WCHDi1+29HrTPxs9kR/XaxyFIaGQ=
Date:   Fri, 27 Mar 2020 12:24:12 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: prevent meta updates while checkpoint is in
 progress
Message-ID: <20200327192412.GA186975@google.com>
References: <1585219019-24831-1-git-send-email-stummala@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585219019-24831-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahitya,

On 03/26, Sahitya Tummala wrote:
> allocate_segment_for_resize() can cause metapage updates if
> it requires to change the current node/data segments for resizing.
> Stop these meta updates when there is a checkpoint already
> in progress to prevent inconsistent CP data.

Doesn't freeze|thaw_bdev(sbi->sb->s_bdev); work for you?

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/gc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 5bca560..6122bad 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1399,8 +1399,10 @@ static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
>  	int err = 0;
>  
>  	/* Move out cursegs from the target range */
> +	f2fs_lock_op(sbi);
>  	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++)
>  		allocate_segment_for_resize(sbi, type, start, end);
> +	f2fs_unlock_op(sbi);
>  
>  	/* do GC to move out valid blocks in the range */
>  	for (segno = start; segno <= end; segno += sbi->segs_per_sec) {
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
