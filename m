Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F09EC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A5E208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585651334;
	bh=qXYGan3lC779UiSGNbkx/irqz1ZRbNY3U4gPt+oVvNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZuGAtib6IE4aGdFPcw62IZhE5ff0AGE+Gy0u4Ok5X9aHb/AL7VIlIjcCTn3cPtkz1
	 3ZN4VIL4s3+La3mq3F8n8OMTvoIMRbOj0WlDGeN8tMF2R6XUqDrhZ2mTxNJiKiiU1T
	 FgYXS7mcbZ+nHEjggIB6slKBy5AH0dpvAArk2hvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgCaKmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbgCaKmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:42:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B671208E0;
        Tue, 31 Mar 2020 10:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585651329;
        bh=qXYGan3lC779UiSGNbkx/irqz1ZRbNY3U4gPt+oVvNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsPfFunQ02BmTHKKFtir9ut35F9P9YjKaPlHLZW9hFH9J/xnm+jUJq5Mgs8bZQLtM
         WUSwDyTNB+Re535zwl1y9zC6ChhQW98qrQhHuxvSQ0SQ3U/v7f0kqXtA4HBZRlHKXy
         sWIj8NjtWv48J2xvfQtItUUZjY0dfuLRM03uOYz0=
Date:   Tue, 31 Mar 2020 12:05:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangle6@huawei.com, zhangweimin12@huawei.com, yebin10@huawei.com,
        houtao1@huawei.com
Subject: Re: [PATCH v4] mtd: clear cache_state to avoid writing to bad blocks
 repeatedly
Message-ID: <20200331100526.GC1204199@kroah.com>
References: <1585618319-119741-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585618319-119741-1-git-send-email-nixiaoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:31:59AM +0800, Xiaoming Ni wrote:
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
>  drivers/mtd/mtdblock.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

$ ./scripts/get_maintainer.pl --file drivers/mtd/mtdblock.c
Miquel Raynal <miquel.raynal@bootlin.com> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
Richard Weinberger <richard@nod.at> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
Vignesh Raghavendra <vigneshr@ti.com> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
linux-mtd@lists.infradead.org (open list:MEMORY TECHNOLOGY DEVICES (MTD))
linux-kernel@vger.kernel.org (open list)


No where on there is my name/email, so why am I getting these?

confused,

greg k-h
