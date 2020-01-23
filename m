Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4451DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107942253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579802222;
	bh=UX5aAj3i0cMnShTuwFcZJbc1mI9/uhZDN210Dt+lKhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UgRBPNcduRCblFDXDoBA8qjyo9zILAWggTRFN5qpJ6v332DlWBAr5OXHUGM8wB0qq
	 stZA9EPYQtTfYCFTiGfY2IW/sYjJL9CbH+nBZCO24ZqnitZaiuPsTS0OfmkYwiYhYz
	 XdlPDsf2+/BPc2Q/G09lEw+b9FEbOQAlwCzRen8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAWR5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:57:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbgAWR5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:57:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45E6322464;
        Thu, 23 Jan 2020 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579802220;
        bh=UX5aAj3i0cMnShTuwFcZJbc1mI9/uhZDN210Dt+lKhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opki2cQV9oHqEY81fAkgOf0GQ1xUqFx0BLN94x3wm4zVRCCgxy4ViPrYJNR1hcSO7
         wy9eQil7hONEEMJjSscTJ7AFRtuxSZxaeelM0qG59flAu8XtQB1WgK4ZxZXE9dHCgi
         wuM2xk7vZ6eydOVCJJxbjwPyPhVV2zVs6A+/12EE=
Date:   Thu, 23 Jan 2020 18:56:58 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
Cc:     "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "info@metux.net" <info@metux.net>,
        "ztuowen@gmail.com" <ztuowen@gmail.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] lib: devres: Export devm_ioremap_resource_wc
Message-ID: <20200123175658.GB1796501@kroah.com>
References: <20200123154706.5831-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123154706.5831-1-daniel.baluta@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 03:47:21PM +0000, Daniel Baluta (OSS) wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> So that modules can also use it.
> 
> Fixes: b873af620e58863b ("lib: devres: provide devm_ioremap_resource_wc()")
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  lib/devres.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/devres.c b/lib/devres.c
> index 6ef51f159c54..7fe2bd75dfa3 100644
> --- a/lib/devres.c
> +++ b/lib/devres.c
> @@ -182,6 +182,7 @@ void __iomem *devm_ioremap_resource_wc(struct device *dev,
>  {
>  	return __devm_ioremap_resource(dev, res, DEVM_IOREMAP_WC);
>  }
> +EXPORT_SYMBOL(devm_ioremap_resource_wc);

EXPORT_SYMBOL_GPL() perhaps?

What in-tree driver needs this?

thanks,

greg k-h
