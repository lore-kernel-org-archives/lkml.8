Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20F9C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63FB206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCWBmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 21:42:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726951AbgCWBmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 21:42:31 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 188EEA22B45C05522922;
        Mon, 23 Mar 2020 09:42:21 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 23 Mar
 2020 09:42:18 +0800
Subject: Re: [f2fs-dev] [PATCH] ENOSPC returned but there still many free
 segments
To:     chenying <chen.ying153@zte.com.cn>, <jaegeuk@kernel.org>
CC:     <wang.yi59@zte.com.cn>, <xue.zhihong@zte.com.cn>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <jiang.xuexin@zte.com.cn>
References: <1584754308-39299-1-git-send-email-chen.ying153@zte.com.cn>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <26f11617-92e4-1dc5-38fd-5048e92e059e@huawei.com>
Date:   Mon, 23 Mar 2020 09:42:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1584754308-39299-1-git-send-email-chen.ying153@zte.com.cn>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/21 9:31, chenying wrote:
> I write data to a compressed file when the disk space is almost full
> and it return -ENOSPC error, but cat /sys/kernel/debug/f2fs/status
> shows that there still many free segments.

free segments include reserved segments, so its value should never be zero,
otherwise there should be a bug.

BTW, could you check result in 'stat -f <your_mountpoint>' rather than f2fs
status in debugfs?

> 
> Signed-off-by: chenying <chen.ying153@zte.com.cn>
> ---
>  fs/f2fs/compress.c | 5 ++++-
>  fs/f2fs/file.c     | 4 ++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index d8a64be..6ca058b 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -854,6 +854,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  				fio.compr_blocks++;
>  			if (__is_valid_data_blkaddr(blkaddr))
>  				f2fs_invalidate_blocks(sbi, blkaddr);
> +			else if (blkaddr != NULL_ADDR)
> +				dec_valid_block_count(sbi, dn.inode, 1);
>  			f2fs_update_data_blkaddr(&dn, COMPRESS_ADDR);
>  			goto unlock_continue;
>  		}
> @@ -865,7 +867,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  			if (__is_valid_data_blkaddr(blkaddr)) {
>  				f2fs_invalidate_blocks(sbi, blkaddr);
>  				f2fs_update_data_blkaddr(&dn, NEW_ADDR);
> -			}
> +			} else if (blkaddr != NULL_ADDR)
> +				dec_valid_block_count(sbi, dn.inode, 1);

I don't think this is correct, you could check message in git pull of 5.6:

Quoted:

"f2fs-for-5.6

In this series, we've implemented transparent compression experimentally. It
supports LZO and LZ4, but will add more later as we investigate in the field
more. At this point, the feature doesn't expose compressed space to user
directly in order to guarantee potential data updates later to the space.
Instead, the main goal is to reduce data writes to flash disk as much as
possible, resulting in extending disk life time as well as relaxing IO
congestion. Alternatively, we're also considering to add ioctl() to reclaim
compressed space and show it to user after putting the immutable bit.
"

That means we will keep reserved blocks in compressed cluster until user
release them via ioctl.

Thanks,

>  			goto unlock_continue;
>  		}
>  
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 0d4da64..f07c9e2 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -589,6 +589,10 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
>  			clear_inode_flag(dn->inode, FI_FIRST_BLOCK_WRITTEN);
>  
>  		f2fs_invalidate_blocks(sbi, blkaddr);
> +		if (compressed_cluster &&
> +			(blkaddr == NEW_ADDR || blkaddr == COMPRESS_ADDR))
> +			continue;
> +
>  		nr_free++;
>  	}
>  
> 
