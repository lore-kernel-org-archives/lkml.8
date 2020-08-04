Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BFAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE4720738
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgHDDBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 23:01:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbgHDDBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 23:01:18 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5090750F53C9FB1E9DF8;
        Tue,  4 Aug 2020 11:01:17 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 4 Aug 2020
 11:01:10 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix deadlock between quota writes and
 checkpoint
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20200729070244.584518-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <670f35e1-872b-6602-320c-dd73bcb62510@huawei.com>
Date:   Tue, 4 Aug 2020 11:01:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200729070244.584518-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/29 15:02, Jaegeuk Kim wrote:
> f2fs_write_data_pages(quota_mapping)
>   __f2fs_write_data_pages             f2fs_write_checkpoint
>    * blk_start_plug(&plug);
>    * add bio in write_io[DATA]
>                                        - block_operations
>                                        - skip syncing quota by
>                                                  >DEFAULT_RETRY_QUOTA_FLUSH_COUNT
>                                        - down_write(&sbi->node_write);

f2fs_flush_merged_writes() will be called after block_operations(), why this doesn't
help?

>    - f2fs_write_single_data_page
>      - f2fs_do_write_data_page
>        - f2fs_outplace_write_data
>          - do_write_page
>             - f2fs_allocate_data_block
>              - down_write(node_write)
>                                        - f2fs_wait_on_all_pages(F2FS_WB_CP_DATA);
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/checkpoint.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 8c782d3f324f0..99c8061da55b9 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1269,6 +1269,8 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
>   		if (type == F2FS_DIRTY_META)
>   			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
>   							FS_CP_META_IO);
> +		else if (type == F2FS_WB_CP_DATA)
> +			f2fs_submit_merged_write(sbi, DATA);
>   		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
>   	}
>   	finish_wait(&sbi->cp_wait, &wait);
> 
