Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D959FC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A99AD206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588689839;
	bh=aVUty+xGKseAmsxbQ7di/4P2HYVjqVdFBr76G8ddcO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fdKWX/z31DOCF+HgRx0dd6ezWfh2SFxRWz1+vm+uWPdSx/+mV7xJRKkEWsek7JOn+
	 En4VhoGnQ2a0RuygcHYSXTa5ka2t9KsBntXjwgC1zpK/wxHuKbZ9rnE0jyJ6g6ldw3
	 VK1hWK/XNZo9SSBFg/A8K2CxG9uE/l4p429G5X8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgEEOn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729183AbgEEOn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:43:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D01D20663;
        Tue,  5 May 2020 14:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588689838;
        bh=aVUty+xGKseAmsxbQ7di/4P2HYVjqVdFBr76G8ddcO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xa5SqWSLZ2cdsz6sIL9vQqLBdEnwAmoTTVSKmpig+QWaggaLG7hyCZt8I0Ztm98Rz
         o3WG6kHjnvpYmqu9485kp9KKMj+2w7BoPn2ZBJm/yQeq7hT90QuUBCkVt9cG9YtH60
         tgNmVR6UPLpMkWzGmTHbbKdU9f5pjgAFMD2LoRpU=
Date:   Tue, 5 May 2020 16:43:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     richard.gong@linux.intel.com, atull@kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/4 v2] firmware: stratix10-svc: Unmap some previously
 memremap'ed memory
Message-ID: <20200505144355.GC838641@kroah.com>
References: <cover.1588142343.git.christophe.jaillet@wanadoo.fr>
 <43505dc3a4b405d1c7d4a0fa74c67eda3e8bdb75.1588142343.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43505dc3a4b405d1c7d4a0fa74c67eda3e8bdb75.1588142343.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 08:52:43AM +0200, Christophe JAILLET wrote:
> In 'svc_create_memory_pool()' we memremap some memory. This has to be
> undone in case of error and if the driver is removed.
> 
> The easiest way to do it is to use 'devm_memremap()'.
> 
> Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/firmware/stratix10-svc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index 3a176e62754a..de5870f76c5e 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -631,7 +631,7 @@ svc_create_memory_pool(struct platform_device *pdev,
>  	end = rounddown(sh_memory->addr + sh_memory->size, PAGE_SIZE);
>  	paddr = begin;
>  	size = end - begin;
> -	va = memremap(paddr, size, MEMREMAP_WC);
> +	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
>  	if (!va) {
>  		dev_err(dev, "fail to remap shared memory\n");
>  		return ERR_PTR(-EINVAL);

And there was no previous unmap happening when the pool was torn down
that now needs to be removed?

thanks,

greg k-h
