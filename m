Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B05C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 02:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB5CC207E8
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 02:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgF1Cff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 22:35:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6842 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbgF1Cfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 22:35:34 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9B1649CC2879B92F08CD;
        Sun, 28 Jun 2020 10:35:32 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sun, 28 Jun
 2020 10:35:27 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid readahead race condition
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200624012148.180050-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <368cf853-0411-c237-f0ad-481f78a1eef3@huawei.com>
Date:   Sun, 28 Jun 2020 10:35:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200624012148.180050-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/24 9:21, Jaegeuk Kim wrote:
> If two readahead threads having same offset enter in readpages, every read
> IOs are split and issued to the disk which giving lower bandwidth.
> 
> This patch tries to avoid redundant readahead calls.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c  | 15 +++++++++++++++
>  fs/f2fs/f2fs.h  |  1 +
>  fs/f2fs/super.c |  2 ++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index dfd3225153570..1886d83bc5f15 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2292,6 +2292,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
>  	unsigned nr_pages = rac ? readahead_count(rac) : 1;
>  	unsigned max_nr_pages = nr_pages;
>  	int ret = 0;
> +	bool drop_ra = false;
>  
>  	map.m_pblk = 0;
>  	map.m_lblk = 0;
> @@ -2302,6 +2303,17 @@ static int f2fs_mpage_readpages(struct inode *inode,
>  	map.m_seg_type = NO_CHECK_TYPE;
>  	map.m_may_create = false;
>  
> +	/*
> +	 * Two readahead threads for same address range can cause race condition
> +	 * which fragments sequential read IOs. So let's avoid each other.
> +	 */
> +	if (rac && readahead_count(rac)) {
> +		if (F2FS_I(inode)->ra_offset == readahead_index(rac))
> +			drop_ra = true;

I guess you missed to return at somewhere when drop_ra is true?

thanks,

> +		else
> +			F2FS_I(inode)->ra_offset = readahead_index(rac);
> +	}
> +
>  	for (; nr_pages; nr_pages--) {
>  		if (rac) {
>  			page = readahead_page(rac);
> @@ -2368,6 +2380,9 @@ static int f2fs_mpage_readpages(struct inode *inode,
>  	}
>  	if (bio)
>  		__submit_bio(F2FS_I_SB(inode), bio, DATA);
> +
> +	if (rac && readahead_count(rac) && !drop_ra)
> +		F2FS_I(inode)->ra_offset = -1;
>  	return ret;
>  }
>  
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7fb2a1a334388..753782426feac 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -809,6 +809,7 @@ struct f2fs_inode_info {
>  	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
>  	struct task_struct *inmem_task;	/* store inmemory task */
>  	struct mutex inmem_lock;	/* lock for inmemory pages */
> +	pgoff_t ra_offset;		/* ongoing readahead offset */
>  	struct extent_tree *extent_tree;	/* cached extent_tree entry */
>  
>  	/* avoid racing between foreground op and gc */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 7326522057378..80cb7cd358f84 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1015,6 +1015,8 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
>  	/* Will be used by directory only */
>  	fi->i_dir_level = F2FS_SB(sb)->dir_level;
>  
> +	fi->ra_offset = -1;
> +
>  	return &fi->vfs_inode;
>  }
>  
> 
