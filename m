Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A157C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494D2207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgEGHxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:53:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3834 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbgEGHxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:53:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1481E6579506A334BFF2;
        Thu,  7 May 2020 15:53:44 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 15:53:38 +0800
Subject: ping; [PATCH v4] mtd: clear cache_state to avoid writing to bad
 blocks repeatedly
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangle6@huawei.com>, <zhangweimin12@huawei.com>,
        <yebin10@huawei.com>, <houtao1@huawei.com>
References: <1585618319-119741-1-git-send-email-nixiaoming@huawei.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <528b61f3-bddb-d508-8f18-37cebec9e5eb@huawei.com>
Date:   Thu, 7 May 2020 15:53:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1585618319-119741-1-git-send-email-nixiaoming@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 2020/3/31 9:31, Xiaoming Ni wrote:
> The function call process is as follows:
> 	mtd_blktrans_work()
> 	  while (1)
> 	    do_blktrans_request()
> 	      mtdblock_writesect()
> 	        do_cached_write()
> 	          write_cached_data() /*if cache_state is STATE_DIRTY*/
> 	            erase_write()
> 
> write_cached_data() returns failure without modifying cache_state
> and cache_offset. So when do_cached_write() is called again,
> write_cached_data() will be called again to perform erase_write()
> on the same cache_offset.
> 
> But if this cache_offset points to a bad block, erase_write() will
> always return -EIO. Writing to this mtdblk is equivalent to losing
> the current data, and repeatedly writing to the bad block.
> 
> Repeatedly writing a bad block has no real benefits,
> but brings some negative effects:
> 1 Lost subsequent data
> 2 Loss of flash device life
> 3 erase_write() bad blocks are very time-consuming. For example:
> 	the function do_erase_oneblock() in chips/cfi_cmdset_0020.c or
> 	chips/cfi_cmdset_0002.c may take more than 20 seconds to return
> 
> Therefore, when erase_write() returns -EIO in write_cached_data(),
> clear cache_state to avoid writing to bad blocks repeatedly.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   drivers/mtd/mtdblock.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
> index 078e0f6..32e52d8 100644
> --- a/drivers/mtd/mtdblock.c
> +++ b/drivers/mtd/mtdblock.c
> @@ -89,8 +89,6 @@ static int write_cached_data (struct mtdblk_dev *mtdblk)
>   
>   	ret = erase_write (mtd, mtdblk->cache_offset,
>   			   mtdblk->cache_size, mtdblk->cache_data);
> -	if (ret)
> -		return ret;
>   
>   	/*
>   	 * Here we could arguably set the cache state to STATE_CLEAN.
> @@ -98,9 +96,14 @@ static int write_cached_data (struct mtdblk_dev *mtdblk)
>   	 * be notified if this content is altered on the flash by other
>   	 * means.  Let's declare it empty and leave buffering tasks to
>   	 * the buffer cache instead.
> +	 *
> +	 * If this cache_offset points to a bad block, data cannot be
> +	 * written to the device. Clear cache_state to avoid writing to
> +	 * bad blocks repeatedly.
>   	 */
> -	mtdblk->cache_state = STATE_EMPTY;
> -	return 0;
> +	if (ret == 0 || ret == -EIO)
> +		mtdblk->cache_state = STATE_EMPTY;
> +	return ret;
>   }
>   
>   
> 


