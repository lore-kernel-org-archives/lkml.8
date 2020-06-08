Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F002BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58AD20774
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgFHCSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 22:18:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5795 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726662AbgFHCSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 22:18:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5F375318CDED32071987;
        Mon,  8 Jun 2020 10:18:14 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 8 Jun 2020
 10:18:11 +0800
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add node_io_flag for bio flags
 likewise data_io_flag
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200604235023.1954-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <49764227-d3f0-8e05-60d8-4b8ebb56941c@huawei.com>
Date:   Mon, 8 Jun 2020 10:18:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200604235023.1954-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/5 7:50, Jaegeuk Kim wrote:
> This patch adds another way to attach bio flags to node writes.
> 
> Description:   Give a way to attach REQ_META|FUA to node writes
>                given temperature-based bits. Now the bits indicate:
>                *      REQ_META     |      REQ_FUA      |
>                *    5 |    4 |   3 |    2 |    1 |   0 |
>                * Cold | Warm | Hot | Cold | Warm | Hot |
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  9 ++++++
>  fs/f2fs/data.c                          | 39 ++++++++++++++++++-------
>  fs/f2fs/f2fs.h                          |  1 +
>  fs/f2fs/sysfs.c                         |  2 ++
>  4 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 427f5b45c67f1..4bb93a06d8abc 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -333,6 +333,15 @@ Description:	Give a way to attach REQ_META|FUA to data writes
>  		*    5 |    4 |   3 |    2 |    1 |   0 |
>  		* Cold | Warm | Hot | Cold | Warm | Hot |
>  
> +What:		/sys/fs/f2fs/<disk>/node_io_flag
> +Date:		June 2020
> +Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> +Description:	Give a way to attach REQ_META|FUA to node writes
> +		given temperature-based bits. Now the bits indicate:
> +		*      REQ_META     |      REQ_FUA      |
> +		*    5 |    4 |   3 |    2 |    1 |   0 |
> +		* Cold | Warm | Hot | Cold | Warm | Hot |
> +
>  What:		/sys/fs/f2fs/<disk>/iostat_period_ms
>  Date:		April 2020
>  Contact:	"Daeho Jeong" <daehojeong@google.com>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a65bfc07ddb97..2f5293eb5e52a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -514,26 +514,43 @@ void f2fs_submit_bio(struct f2fs_sb_info *sbi,
>  	__submit_bio(sbi, bio, type);
>  }
>  
> -static void __attach_data_io_flag(struct f2fs_io_info *fio)
> +static void __attach_io_flag(struct f2fs_io_info *fio)
>  {
>  	struct f2fs_sb_info *sbi = fio->sbi;
>  	unsigned int temp_mask = (1 << NR_TEMP_TYPE) - 1;

Could we avoid duplicated codes as much as possible?

unsigned int flag = fio->type == DATA ? sbi->data_io_flag : sbi->node_io_flag;
unsigned int fua_flag = flag & temp_mask;
unsigned int meta_flag = (flag >> NR_TEMP_TYPE) & temp_mask;

Thanks,

> -	unsigned int fua_flag = sbi->data_io_flag & temp_mask;
> -	unsigned int meta_flag = (sbi->data_io_flag >> NR_TEMP_TYPE) &
> -								temp_mask;
> +
>  	/*
>  	 * data io flag bits per temp:
>  	 *      REQ_META     |      REQ_FUA      |
>  	 *    5 |    4 |   3 |    2 |    1 |   0 |
>  	 * Cold | Warm | Hot | Cold | Warm | Hot |
>  	 */
> -	if (fio->type != DATA)
> -		return;
> +	if (fio->type == DATA) {
> +		unsigned int fua_flag = sbi->data_io_flag & temp_mask;
> +		unsigned int meta_flag = (sbi->data_io_flag >> NR_TEMP_TYPE) &
> +								temp_mask;
>  
> -	if ((1 << fio->temp) & meta_flag)
> -		fio->op_flags |= REQ_META;
> -	if ((1 << fio->temp) & fua_flag)
> -		fio->op_flags |= REQ_FUA;
> +		if ((1 << fio->temp) & meta_flag)
> +			fio->op_flags |= REQ_META;
> +		if ((1 << fio->temp) & fua_flag)
> +			fio->op_flags |= REQ_FUA;
> +	}
> +	/*
> +	 * node io flag bits per temp:
> +	 *      REQ_META     |      REQ_FUA      |
> +	 *    5 |    4 |   3 |    2 |    1 |   0 |
> +	 * Cold | Warm | Hot | Cold | Warm | Hot |
> +	 */
> +	if (fio->type == NODE) {
> +		unsigned int fua_flag = sbi->node_io_flag & temp_mask;
> +		unsigned int meta_flag = (sbi->node_io_flag >> NR_TEMP_TYPE) &
> +								temp_mask;
> +
> +		if ((1 << fio->temp) & meta_flag)
> +			fio->op_flags |= REQ_META;
> +		if ((1 << fio->temp) & fua_flag)
> +			fio->op_flags |= REQ_FUA;
> +	}
>  }
>  
>  static void __submit_merged_bio(struct f2fs_bio_info *io)
> @@ -543,7 +560,7 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
>  	if (!io->bio)
>  		return;
>  
> -	__attach_data_io_flag(fio);
> +	__attach_io_flag(fio);
>  	bio_set_op_attrs(io->bio, fio->op, fio->op_flags);
>  
>  	if (is_read_io(fio->op))
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index fb180020e175c..50e6cdf20b733 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1568,6 +1568,7 @@ struct f2fs_sb_info {
>  
>  	/* to attach REQ_META|REQ_FUA flags */
>  	unsigned int data_io_flag;
> +	unsigned int node_io_flag;
>  
>  	/* For sysfs suppport */
>  	struct kobject s_kobj;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index a117ae1f9d5f1..fc4a46b689040 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -554,6 +554,7 @@ F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
>  F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
>  #endif
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, data_io_flag, data_io_flag);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
>  F2FS_GENERAL_RO_ATTR(dirty_segments);
>  F2FS_GENERAL_RO_ATTR(free_segments);
>  F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
> @@ -635,6 +636,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(inject_type),
>  #endif
>  	ATTR_LIST(data_io_flag),
> +	ATTR_LIST(node_io_flag),
>  	ATTR_LIST(dirty_segments),
>  	ATTR_LIST(free_segments),
>  	ATTR_LIST(unusable),
> 
