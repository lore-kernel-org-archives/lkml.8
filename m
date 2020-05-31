Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175E8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 06:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4682207C4
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 06:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590907284;
	bh=k1N+mnthcbbLppMjxHBQJlcZ9DGmkyfyxSyBO/8RG4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cw13X8eW6zxuPXIvW2/Z68QTf6Kb/5zQclRA2hFI2AYdDARUkfnPFVVqlnbAgJq5w
	 1yx4cRj6WWzga33DfzHUiW8ieLwBTkOtr8rjZu9tpLmoPHS6vIDrlpmaAGmgNRCmvU
	 hAZ4kq+taApiwj2ELKKlD1NCKijH1zlJHTh4+LZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgEaGlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 02:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgEaGlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 02:41:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 842FF20723;
        Sun, 31 May 2020 06:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590907283;
        bh=k1N+mnthcbbLppMjxHBQJlcZ9DGmkyfyxSyBO/8RG4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUrc1QHldahQn2yUnPo2eDYmw5Mq5MvBVLk2Umc6y0NKvTgYwZLOF0XrGO/T6ApVp
         S0IIcikjogmiQt7ol1HT/jRXXh2cwMhrEfDtPr471cHHuYjeoMsxKyA63Eex4RLdv+
         J0NonFFoYH40Fqjd5E2XomirbpfRSu7KszV6sXlg=
Date:   Sun, 31 May 2020 08:41:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lokesh Chebrolu <lokeshch007@gmail.com>
Cc:     hadess@hadess.net, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: usb: core: driver: fixed 80 line character
 length issue
Message-ID: <20200531064119.GD1082896@kroah.com>
References: <1590889806-13539-1-git-send-email-lokeshch007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590889806-13539-1-git-send-email-lokeshch007@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 07:20:06AM +0530, Lokesh Chebrolu wrote:
> From: lokeshch007 <lokeshch007@gmail.com>

This has to match the s-o-b line

> 
> Fixed a coding style issue

What issue?


> 
> Signed-off-by: Lokesh Chebrolu <lokeshch007@gmail.com>
> ---
>  drivers/usb/core/driver.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index f81606c..83c3287 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1796,7 +1796,9 @@ int usb_autopm_get_interface_async(struct usb_interface *intf)
>  EXPORT_SYMBOL_GPL(usb_autopm_get_interface_async);
>  
>  /**
> - * usb_autopm_get_interface_no_resume - increment a USB interface's PM-usage counter
> + * usb_autopm_get_interface_no_resume -
> + * increment a USB interface's PM-usage counter
> + *

Nope, the original is correct, sorry, kerneldoc wants this to be a long
single line.

When starting out in kernel development, please stick to
drivers/staging/ which has lots of places to clean up and patches like
this are welcomed much more so than other parts of the kernel.

thanks,

greg k-h
