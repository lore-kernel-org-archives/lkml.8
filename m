Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B074C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563AF2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596026553;
	bh=mlZ/EsaMb/ND17rYj369D7zDyCStn7kc/8QnXsr1+ks=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:List-ID:From;
	b=yHGQwLm132nyWu54oSZq/TwUFpT9oFcQE5COHXn0dfXpuv8TpvmF7wsEb01+kw6bb
	 sENv3aSRjoRkt6sFSV9Jzo1FvorQ5ExGcFfbwnM2yRpaQEuoG3Q5mMlyG163iNC6L0
	 tf1i0Qxd3eSdZW35SzWD0THQaSwAMj0mYCaWqxig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgG2Mmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgG2Mmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:42:31 -0400
Received: from [192.168.0.108] (unknown [49.65.247.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D2142083B;
        Wed, 29 Jul 2020 12:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596026551;
        bh=mlZ/EsaMb/ND17rYj369D7zDyCStn7kc/8QnXsr1+ks=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=si9k9B1A5fSTY0airfSOHiXA74mNbarCYSzoFBGKhbT3Zt1iYPV0PvKsIYd6nfZja
         xxoDG+wWK/5289wsgOpBuhPGjKRMeLE95J80+c0eZnBZiRBLB1KqwawcAV+sLtRxb0
         9gNR61RG39J1bpB63DDA7lPsipwIkQX7qEGXXoAw=
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix deadlock between quota writes and
 checkpoint
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20200729070244.584518-1-jaegeuk@kernel.org>
Cc:     Daeho Jeong <daehojeong@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <054f161c-05db-73b7-3d83-be7addcd6015@kernel.org>
Date:   Wed, 29 Jul 2020 20:42:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200729070244.584518-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-7-29 15:02, Jaegeuk Kim wrote:
> f2fs_write_data_pages(quota_mapping)
>  __f2fs_write_data_pages             f2fs_write_checkpoint
>   * blk_start_plug(&plug);
>   * add bio in write_io[DATA]
>                                       - block_operations
>                                       - skip syncing quota by
>                                                 >DEFAULT_RETRY_QUOTA_FLUSH_COUNT
>                                       - down_write(&sbi->node_write);
>   - f2fs_write_single_data_page

After commit 79963d967b49 ("f2fs: shrink node_write lock coverage"),
node_write lock was moved to f2fs_write_single_data_page() and
f2fs_write_compressed_pages().

So it needs to update the callstack.

- down_write(node_write)

Otherwise it looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>     - f2fs_do_write_data_page
>       - f2fs_outplace_write_data
>         - do_write_page
>            - f2fs_allocate_data_block
>             - down_write(node_write)
>                                       - f2fs_wait_on_all_pages(F2FS_WB_CP_DATA);
>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 8c782d3f324f0..99c8061da55b9 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1269,6 +1269,8 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
>  		if (type == F2FS_DIRTY_META)
>  			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
>  							FS_CP_META_IO);
> +		else if (type == F2FS_WB_CP_DATA)
> +			f2fs_submit_merged_write(sbi, DATA);
>  		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
>  	}
>  	finish_wait(&sbi->cp_wait, &wait);
>
