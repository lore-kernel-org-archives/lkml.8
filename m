Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47133C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C4620848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFBjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:39:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbgCFBjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:39:07 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0297F88034623412B26A;
        Fri,  6 Mar 2020 09:39:06 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 6 Mar 2020
 09:39:04 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong check on F2FS_IOC_FSSETXATTR
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     Daniel Rosenberg <drosen@google.com>
References: <20200305234822.178708-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1e8389fb-2416-d191-cdb3-cd4714ed7756@huawei.com>
Date:   Fri, 6 Mar 2020 09:39:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200305234822.178708-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/6 7:48, Jaegeuk Kim wrote:
> This fixes the incorrect failure when enabling project quota on casefold-enabled
> file.
> 
> Cc: Daniel Rosenberg <drosen@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index fb070816a8a5..8a41afac0346 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1789,12 +1789,15 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
>  static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  {
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
> +	u32 masked_flags = fi->i_flags & mask;
> +
> +	f2fs_bug_on(F2FS_I_SB(inode), (iflags & ~mask));
>  
>  	/* Is it quota file? Do not allow user to mess with it */
>  	if (IS_NOQUOTA(inode))
>  		return -EPERM;
>  
> -	if ((iflags ^ fi->i_flags) & F2FS_CASEFOLD_FL) {
> +	if ((iflags ^ masked_flags) & F2FS_CASEFOLD_FL) {
>  		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
>  			return -EOPNOTSUPP;
>  		if (!f2fs_empty_dir(inode))
> @@ -1808,9 +1811,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  			return -EINVAL;
>  	}
>  
> -	if ((iflags ^ fi->i_flags) & F2FS_COMPR_FL) {
> +	if ((iflags ^ masked_flags) & F2FS_COMPR_FL) {
>  		if (S_ISREG(inode->i_mode) &&
> -			(fi->i_flags & F2FS_COMPR_FL || i_size_read(inode) ||
> +			(masked_flags & F2FS_COMPR_FL || i_size_read(inode) ||
>  						F2FS_HAS_BLOCKS(inode)))
>  			return -EINVAL;
>  		if (iflags & F2FS_NOCOMP_FL)
> @@ -1827,16 +1830,16 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  			set_compress_context(inode);
>  		}
>  	}
> -	if ((iflags ^ fi->i_flags) & F2FS_NOCOMP_FL) {
> -		if (fi->i_flags & F2FS_COMPR_FL)
> +	if ((iflags ^ masked_flags) & F2FS_NOCOMP_FL) {
> +		if (masked_flags & F2FS_COMPR_FL)
>  			return -EINVAL;
>  	}
>  
>  	fi->i_flags = iflags | (fi->i_flags & ~mask);
> -	f2fs_bug_on(F2FS_I_SB(inode), (fi->i_flags & F2FS_COMPR_FL) &&
> -					(fi->i_flags & F2FS_NOCOMP_FL));
> +	f2fs_bug_on(F2FS_I_SB(inode), (masked_flags & F2FS_COMPR_FL) &&
> +					(masked_flags & F2FS_NOCOMP_FL));

We don't need to change here due to we should check final status in fi->i_flags
rather than checking previous status in masked_flags?

>  
> -	if (fi->i_flags & F2FS_PROJINHERIT_FL)
> +	if (masked_flags & F2FS_PROJINHERIT_FL)

Ditto.

Thanks,

>  		set_inode_flag(inode, FI_PROJ_INHERIT);
>  	else
>  		clear_inode_flag(inode, FI_PROJ_INHERIT);
> 
