Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9EBC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D511222B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgGTM2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:28:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7797 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727989AbgGTM2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:28:38 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 365FC1BA019343E1DE06;
        Mon, 20 Jul 2020 20:28:37 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 20 Jul
 2020 20:28:35 +0800
Subject: Re: [PATCH] f2fs: compress: fix to avoid memory leak on cc->cpages
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200720085250.47279-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a24a282f-895f-39b1-181b-1208d6f1803c@huawei.com>
Date:   Mon, 20 Jul 2020 20:28:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200720085250.47279-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/20 16:52, Chao Yu wrote:
> Memory allocated for storing compressed pages' poitner should be
> released after f2fs_write_compressed_pages(), otherwise it will
> cause memory leak issue.

Jaegeuk,

Please help to add below tag when merging, thanks.

Fixes: 4c8ff7095bef ("f2fs: support data compression")

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>   fs/f2fs/compress.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 3a847bc36748..a20c9f3272af 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1385,6 +1385,8 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
>   		err = f2fs_write_compressed_pages(cc, submitted,
>   							wbc, io_type);
>   		cops->destroy_compress_ctx(cc);
> +		kfree(cc->cpages);
> +		cc->cpages = NULL;
>   		if (!err)
>   			return 0;
>   		f2fs_bug_on(F2FS_I_SB(cc->inode), err != -EAGAIN);
> 
