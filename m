Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C33C433ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4005206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595490080;
	bh=6fcTs/2LDWfmI70/tl+N49wQ3Vgw3XenmCWJWsRmc54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J1l6chJwvEcSlwKhNg4P9l/k2lrJzCRRV/DOWPkKynsEV5Lvofgw9SqmK1zZmaXAB
	 AeDbTgYNb15EPDKajp5bpSRJSCQ853U+T/00roa9rsTeCvM9L8yYDl0mQoDRTPyRtx
	 6PW0UsICVpwAFiAiF+RReEuLLaXb2goM86IP5qJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgGWHlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgGWHlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:41:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D02B206F5;
        Thu, 23 Jul 2020 07:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595490071;
        bh=6fcTs/2LDWfmI70/tl+N49wQ3Vgw3XenmCWJWsRmc54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQpDiLqBA7pJ5dP4+8jDGE9eg0Sh7IGyVsX9UzyQgj574e3SGBtGCB7OrFir1bUrc
         RsZQ3lWQk9IZEQrNtvltiju9Kh5lHPAxUpbxe2RFQzxkiI79ElrxTZZ3mJjhJGPO0W
         jF1AtqngFsVY7T++bYC6ElhcKCRsj4ndUAiyCwp4=
Date:   Thu, 23 Jul 2020 09:41:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Rodolfo Giometti <giometti@enneenne.com>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/1] misc: c2port: core: Make copying name from userspace
 more secure
Message-ID: <20200723074115.GA1289884@kroah.com>
References: <20200714083259.1313267-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714083259.1313267-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 09:32:59AM +0100, Lee Jones wrote:
> Currently the 'c2dev' device data is not zeroed when its allocated.
> Coupled with the fact strncpy() *may not* provide a NUL terminator
> means that a 1-byte leak would be possible *if* this was ever copied
> to userspace.

c2dev is a kernel internal structure, it is never copied to userspace,
so why even mention such a thing?

> To prevent such a failing, let's first ensure the 'c2dev' device data
> area is fully zeroed out and ensure the buffer will always be NUL
> terminated by using the kernel's strscpy() which a) uses the
> destination (instead of the source) size as the bytes to copy and b)
> is *always* NUL terminated.
> 
> Cc: Rodolfo Giometti <giometti@enneenne.com>
> Cc: "Eurotech S.p.A" <info@eurotech.it>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/c2port/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
> index 80d87e8a0bea9..0de538a1cc1c6 100644
> --- a/drivers/misc/c2port/core.c
> +++ b/drivers/misc/c2port/core.c
> @@ -899,7 +899,7 @@ struct c2port_device *c2port_device_register(char *name,
>  		unlikely(!ops->c2d_get) || unlikely(!ops->c2d_set))
>  		return ERR_PTR(-EINVAL);
>  
> -	c2dev = kmalloc(sizeof(struct c2port_device), GFP_KERNEL);
> +	c2dev = kzalloc(sizeof(struct c2port_device), GFP_KERNEL);

All fields seem to be properly initialized so this really isn't needed
from what I can tell.

>  	if (unlikely(!c2dev))
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
>  	}
>  	dev_set_drvdata(c2dev->dev, c2dev);
>  
> -	strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
> +	strscpy(c2dev->name, name, sizeof(c2dev->name));

Given there is only 1 user of this function, and it passes in "uc", this
isn't a big deal :)

But, I can take this as a separate patch, if you want to redo this, just
to be safe in the future.

thanks,

greg k-h
