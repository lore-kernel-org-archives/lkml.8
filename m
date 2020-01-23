Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3832DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0CF21569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579803950;
	bh=//Gx7TpRR9XJE4SitAtv6bFOO1oNBBqtuf9aoscDo6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uinpLSD5emkNh5ofAHqsbFdznBa/aMOAO4YVC0qg2Vq6WX8N7aa0STw4WUgTyGS+E
	 c1PQcHUnk314w9BQSchq9EN16ZNtXL7h3Ijtc6UahhYD1VVmY6AXIhGKR3L9kFPUrs
	 z8eJIb5DXhK+xpTlsKIh9kEXKe1hDpJ4xkBo+MBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAWSZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:25:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbgAWSZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:25:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF9462077C;
        Thu, 23 Jan 2020 18:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579803948;
        bh=//Gx7TpRR9XJE4SitAtv6bFOO1oNBBqtuf9aoscDo6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GD7H1bVYa9bikI7RV+4cY6E4eQZ1G0GKSNpUZS3jSY39neata6PAyGeiPm+5Rp04l
         OzAj+T3u9o7SJv+LrYPbVDTwTt2yLKAHKTm399caH9wSWGvdEtR0FndfEgEC4a94qq
         7efA7P/zX19EtOMiNR+Z/tqiklYAq419vY282FHc=
Date:   Thu, 23 Jan 2020 19:25:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: hpet: Use flexible-array member
Message-ID: <20200123182545.GA1954152@kroah.com>
References: <20200120235326.GA29231@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120235326.GA29231@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 05:53:26PM -0600, Gustavo A. R. Silva wrote:
> Old code in the kernel uses 1-byte and 0-byte arrays to indicate the
> presence of a "variable length array":
> 
> struct something {
>     int length;
>     u8 data[1];
> };
> 
> struct something *instance;
> 
> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length = size;
> memcpy(instance->data, source, size);
> 
> There is also 0-byte arrays. Both cases pose confusion for things like
> sizeof(), CONFIG_FORTIFY_SOURCE, etc.[1] Instead, the preferred mechanism
> to declare variable-length types such as the one above is a flexible array
> member[2] which need to be the last member of a structure and empty-sized:
> 
> struct something {
>         int stuff;
>         u8 data[];
> };
> 
> Also, by making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> unadvertenly introduced[3] to the codebase from now on.
> 
> [1] https://github.com/KSPP/linux/issues/21
> [2] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/char/hpet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index 9ac6671bb514..aed2c45f7968 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -110,7 +110,7 @@ struct hpets {
>  	unsigned long hp_delta;
>  	unsigned int hp_ntimer;
>  	unsigned int hp_which;
> -	struct hpet_dev hp_dev[1];
> +	struct hpet_dev hp_dev[];

Are you sure the allocation size is the same again?  Much like the
n_hdlc patch was, I think you need to adjust the variable size here.
Maybe, it's a bit of a pain to figure out at a quick glance, I just want
to make sure you at least do look at that :)

thanks,

greg k-h
