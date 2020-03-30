Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3937C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8872073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgC3Hxq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:53:46 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:43793 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgC3Hxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:53:46 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E473F200009;
        Mon, 30 Mar 2020 07:53:42 +0000 (UTC)
Date:   Mon, 30 Mar 2020 09:53:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangle6@huawei.com>, <zhangweimin12@huawei.com>,
        <yebin10@huawei.com>, <houtao1@huawei.com>
Subject: Re: [PATCH] mtd:clear cache_state to avoid writing to bad clocks
 repeatedly
Message-ID: <20200330095341.284048c3@xps13>
In-Reply-To: <1585400477-65705-1-git-send-email-nixiaoming@huawei.com>
References: <1585400477-65705-1-git-send-email-nixiaoming@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaoming,

Xiaoming Ni <nixiaoming@huawei.com> wrote on Sat, 28 Mar 2020 21:01:17
+0800:

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
> and cache_offset. so when do_cached_write() is called again,
> write_cached_data() will be called again to perform erase_write()
> on the same cache_offset.
> 
> but if this cache_offset points to a bad block, erase_write() will
> always return -EIO. Writing to this mtdblk is equivalent to losing
> the current data, and repeatedly writing to the bad block.
> 
> Repeatedly writing a bad block has no real benefits,
> but brings some negative effects:
> 1 Lost subsequent data
> 2 Loss of flash device life
> 3 erase_write() bad blocks are very time-consuming. for example:
> 	the function do_erase_oneblock() in chips/cfi_cmdset_0020.c or
> 	chips/cfi_cmdset_0002.c may take more than 20 seconds to return
> 
> Therefore, when erase_write() returns -EIO in write_cached_data(),
> clear cache_state to avoid writing to bad clocks repeatedly.

                                            blocks

> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>  drivers/mtd/mtdblock.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
> index 078e0f6..98c25d6 100644
> --- a/drivers/mtd/mtdblock.c
> +++ b/drivers/mtd/mtdblock.c
> @@ -89,8 +89,6 @@ static int write_cached_data (struct mtdblk_dev *mtdblk)
>  
>  	ret = erase_write (mtd, mtdblk->cache_offset,
>  			   mtdblk->cache_size, mtdblk->cache_data);
> -	if (ret)
> -		return ret;
>  
>  	/*
>  	 * Here we could arguably set the cache state to STATE_CLEAN.
> @@ -98,9 +96,14 @@ static int write_cached_data (struct mtdblk_dev *mtdblk)
>  	 * be notified if this content is altered on the flash by other
>  	 * means.  Let's declare it empty and leave buffering tasks to
>  	 * the buffer cache instead.
> +	 *
> +	 * if this cache_offset points to a bad block

Can you start your sentences with a capital letter please?

	 * If

> +	 * data cannot be written to the device.
> +	 * clear cache_state to avoid writing to bad clocks repeatedly

	 * Clear

And also please break your lines à 80, not 70.

>  	 */
> -	mtdblk->cache_state = STATE_EMPTY;
> -	return 0;
> +	if (ret == 0 || ret == -EIO)
> +		mtdblk->cache_state = STATE_EMPTY;
> +	return ret;
>  }
>  
>  

Otherwise looks good to me.

With the above addressed:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
