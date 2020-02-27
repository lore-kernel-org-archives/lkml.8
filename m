Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54977C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF8124650
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgB0B3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 20:29:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727964AbgB0B3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:29:11 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 470CE14D073C94A15B54;
        Thu, 27 Feb 2020 09:29:09 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 27 Feb
 2020 09:29:06 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: show mounted time
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200226164615.170424-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ace413a8-639d-24c9-f36f-5da949be76e3@huawei.com>
Date:   Thu, 27 Feb 2020 09:29:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200226164615.170424-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/27 0:46, Jaegeuk Kim wrote:
> Let's show mounted time.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 5 +++++
>  fs/f2fs/debug.c                         | 3 +++
>  fs/f2fs/segment.c                       | 2 +-
>  fs/f2fs/segment.h                       | 2 +-
>  fs/f2fs/sysfs.c                         | 8 ++++++++
>  5 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 1a6cd5397129..ddee45e88270 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -318,3 +318,8 @@ Date:		September 2019
>  Contact:	"Hridya Valsaraju" <hridya@google.com>
>  Description:	Average number of valid blocks.
>  		Available when CONFIG_F2FS_STAT_FS=y.
> +
> +What:		/sys/fs/f2fs/<disk>/mounted_time
> +Date:		February 2020
> +Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> +Description:	Show the mounted time of this partition.

It's better to describe its unit: second, otherwise, it looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index 6b89eae5e4ca..a8cf9626f71f 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -301,6 +301,9 @@ static int stat_show(struct seq_file *s, void *v)
>  			   si->ssa_area_segs, si->main_area_segs);
>  		seq_printf(s, "(OverProv:%d Resv:%d)]\n\n",
>  			   si->overp_segs, si->rsvd_segs);
> +		seq_printf(s, "Current Time: %llu s / Mounted Time: %llu s\n\n",
> +					ktime_get_boottime_seconds(),
> +					SIT_I(si->sbi)->mounted_time);
>  		if (test_opt(si->sbi, DISCARD))
>  			seq_printf(s, "Utilization: %u%% (%u valid blocks, %u discard blocks)\n",
>  				si->utilization, si->valid_count, si->discard_blks);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index fb3e531a36d2..601d67e72c50 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4073,7 +4073,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>  	sit_i->dirty_sentries = 0;
>  	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK;
>  	sit_i->elapsed_time = le64_to_cpu(sbi->ckpt->elapsed_time);
> -	sit_i->mounted_time = ktime_get_real_seconds();
> +	sit_i->mounted_time = ktime_get_boottime_seconds();
>  	init_rwsem(&sit_i->sentry_lock);
>  	return 0;
>  }
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 459dc3901a57..7a83bd530812 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -756,7 +756,7 @@ static inline unsigned long long get_mtime(struct f2fs_sb_info *sbi,
>  						bool base_time)
>  {
>  	struct sit_info *sit_i = SIT_I(sbi);
> -	time64_t diff, now = ktime_get_real_seconds();
> +	time64_t diff, now = ktime_get_boottime_seconds();
>  
>  	if (now >= sit_i->mounted_time)
>  		return sit_i->elapsed_time + now - sit_i->mounted_time;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 4e8aae03f26c..7bfbead98c04 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -187,6 +187,12 @@ static ssize_t encoding_show(struct f2fs_attr *a,
>  	return sprintf(buf, "(none)");
>  }
>  
> +static ssize_t mounted_time_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%llu", SIT_I(sbi)->mounted_time);
> +}
> +
>  #ifdef CONFIG_F2FS_STAT_FS
>  static ssize_t moved_blocks_foreground_show(struct f2fs_attr *a,
>  				struct f2fs_sb_info *sbi, char *buf)
> @@ -546,6 +552,7 @@ F2FS_GENERAL_RO_ATTR(features);
>  F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
>  F2FS_GENERAL_RO_ATTR(unusable);
>  F2FS_GENERAL_RO_ATTR(encoding);
> +F2FS_GENERAL_RO_ATTR(mounted_time);
>  #ifdef CONFIG_F2FS_STAT_FS
>  F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
>  F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
> @@ -623,6 +630,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(reserved_blocks),
>  	ATTR_LIST(current_reserved_blocks),
>  	ATTR_LIST(encoding),
> +	ATTR_LIST(mounted_time),
>  #ifdef CONFIG_F2FS_STAT_FS
>  	ATTR_LIST(cp_foreground_calls),
>  	ATTR_LIST(cp_background_calls),
> 
