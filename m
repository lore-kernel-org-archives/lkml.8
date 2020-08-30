Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5B2C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 03:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D72E620656
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 03:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598757845;
	bh=T/YuBD9FNEDuwJiC7R7sKn8AsKAtuYVwKij2Pn0fWTM=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:List-ID:From;
	b=W3hl7C4omAkHXVJrESivSWdgix5AHpFTtIB5t2fXNwcqhsUyFcGYVy1ooffnbF1wO
	 0a9esTECAWdcwbRONtiVL1ts00J0Rk9nz3En8yOIfTot/pGbi2UKzHiPtEflWGhsry
	 qd/XkESf1wVFWvILQGxoZ1BZD2+eZn8/u+5XlJiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgH3DYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 23:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbgH3DYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 23:24:03 -0400
Received: from [192.168.0.108] (unknown [49.65.245.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A338204FD;
        Sun, 30 Aug 2020 03:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598757843;
        bh=T/YuBD9FNEDuwJiC7R7sKn8AsKAtuYVwKij2Pn0fWTM=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=p/mC+Ogx3eCpOFDT4IT3ER5zJKpGtqdpOu7fPod1/pNAXFHPkl4Vdc3fO+ZkBqDQX
         +ebz0UReH3rWnk18Y2DUvX7IXM8J23BO+lnm3B07NUlhyS+tuX24uaiGA5zR3e4WZ2
         0OxxsqwJ7ONdWzykp/KbMARI/f3/Lxx9aCBjJRyU=
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent compressed file from being
 disabled after releasing cblocks
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20200828054629.583577-1-daeho43@gmail.com>
Cc:     Daeho Jeong <daehojeong@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <61996dcd-6db1-13fc-8239-7e684f3ec49e@kernel.org>
Date:   Sun, 30 Aug 2020 11:23:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200828054629.583577-1-daeho43@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-8-28 13:46, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
>
> After releasing cblocks, the compressed file can be accidentally
> disabled in compression mode, since it has zero cblocks. As we are
> using IMMUTABLE flag to present released cblocks state, we can add
> IMMUTABLE state check when considering the compressed file disabling.
>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/f2fs.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 02811ce15059..14d30740ba03 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3936,6 +3936,8 @@ static inline u64 f2fs_disable_compressed_file(struct inode *inode)
>  	if (!f2fs_compressed_file(inode))
>  		return 0;
>  	if (S_ISREG(inode->i_mode)) {
> +		if (IS_IMMUTABLE(inode))
> +			return 1;

It looks most of callers are from ioctl, should we add immutable check in f2fs 
ioctl interfaces if necessary? or I missed existed check.

Thanks,

>  		if (get_dirty_pages(inode))
>  			return 1;
>  		if (fi->i_compr_blocks)
>
