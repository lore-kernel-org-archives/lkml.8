Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6AAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206E0208B8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593761578;
	bh=YLzvaa1bLydJ+dj5X1a+vb6tk/OO1AZ6fTqSIeEFiRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=THODmA7NYH/k+sVss7TUavUTJGRI+yfnNZVGEteNo8h6UBWvTtKh9RwiCqDO8eabU
	 luCEnURZKHtc/4QTFWm8AUNbgVy467OarxReBiJKoS7sW0lE95+cPz3dok5lc9ksFa
	 iTCjcGrsSTH4bJX5NLqHMfQPMW3gzFggrr/eAkls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgGCHc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgGCHc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:32:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EF2320890;
        Fri,  3 Jul 2020 07:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593761575;
        bh=YLzvaa1bLydJ+dj5X1a+vb6tk/OO1AZ6fTqSIeEFiRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1e8LJIpiz+8KVyLRfSjDXioQMMpKWYIuR5wNf/uzr0CYSI1UKVVV3G5by0usGGe7S
         HwY+dBk5yCP8VJ5DJFZtj3b53OfjXKCmimssiC58i6fXHkK0VlIIXpfxIlRawYJJ02
         BXzU7Xm0ye8DvrUyPvPA6dpx6cqHVZuKM1UlUeNM=
Date:   Fri, 3 Jul 2020 09:32:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 27/30] usb: class: cdc-wdm: Provide description for
 usb_cdc_wdm_register()'s manage_power arg
Message-ID: <20200703073259.GA2335445@kroah.com>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
 <20200702144625.2533530-28-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702144625.2533530-28-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:46:22PM +0100, Lee Jones wrote:
> A good attempt was made to document everything else.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/usb/class/cdc-wdm.c:961: warning: Function parameter or member 'manage_power' not described in 'usb_cdc_wdm_register'
> 
> Cc: Oliver Neukum <oneukum@suse.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/class/cdc-wdm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
> index e3db6fbeadef8..4dceaeca46e73 100644
> --- a/drivers/usb/class/cdc-wdm.c
> +++ b/drivers/usb/class/cdc-wdm.c
> @@ -940,7 +940,8 @@ static int wdm_probe(struct usb_interface *intf, const struct usb_device_id *id)
>   * @intf: usb interface the subdriver will associate with
>   * @ep: interrupt endpoint to monitor for notifications
>   * @bufsize: maximum message size to support for read/write
> - *
> + * @manage_power: call-back invoked during open and release to
> + *                manage the device's power 
>   * Create WDM usb class character device and associate it with intf
>   * without binding, allowing another driver to manage the interface.
>   *

You just added a coding style warning :(

Hint, set your editor to flag trailing whitespace with a BIG RED COLOR
so that you don't do that.  If you use vim, that can be done with:
	highlight WhitespaceEOL ctermbg=red guibg=red
	match WhitespaceEOL /\s\+$/
in your .vimrc

For other sane editors, I'm sure there are ways to do it as well.

Please fix this patch up and send it in a new series, I've dropped it
from this one.

thanks,

greg k-h
