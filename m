Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8161DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAC5204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592469637;
	bh=hFJYYoOy8ZgZSe7kwebjbwvT/qbmAaFVTlJYwv2eTuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UgPiAPyOEMRPdpmCSJeYU+ZFV5MPFz9cUuvWX+2HSs6C2qgGzI65GeGqxS3ztp9G5
	 WhdQyH/fmbgONN/n+S/O+FrKhlZyvTjadDmTz3CAk6idx64NvesHyqW3esRsB1ZqXY
	 9P065RsD20LOTNbO6JANjeS6HbwdQ7Yh+D3c9hVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgFRIkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbgFRIkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:40:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06C3C2089D;
        Thu, 18 Jun 2020 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592469633;
        bh=hFJYYoOy8ZgZSe7kwebjbwvT/qbmAaFVTlJYwv2eTuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jS27CLq/ErVC7tBrwumIeEogglJYOluouLk5sKA8q/xozqXRfgJ1zHGjRInSf/P3Y
         2+5bRkBM4uFbm/YA1KWXfIcmA96NgFIqfzGWZbraBDx+cZCX8PxxaEM/BzWyUxanLQ
         ONtyeHAjcurQQ/D+lTk+tweznwTawo4iks6+/hIw=
Date:   Thu, 18 Jun 2020 10:40:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-usb@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] usb: xhci: fix spelling mistake in Kconfig
 "firwmare" -> "firmware"
Message-ID: <20200618084026.GA1073692@kroah.com>
References: <20200603121152.16550-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603121152.16550-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 01:11:52PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are two spelling mistakes in the Kconfig text. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 62c348062e48..5f4b6c71392c 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -44,10 +44,10 @@ config USB_XHCI_PCI
>  	default y
>  
>  config USB_XHCI_PCI_RENESAS
> -	tristate "Support for additional Renesas xHCI controller with firwmare"
> +	tristate "Support for additional Renesas xHCI controller with firmware"
>  	---help---
>  	  Say 'Y' to enable the support for the Renesas xHCI controller with
> -	  firwmare. Make sure you have the firwmare for the device and
> +	  firmware. Make sure you have the firwmare for the device and
>  	  installed on your system for this device to work.
>  	  If unsure, say 'N'.
>  
> -- 
> 2.25.1
> 

Does not apply to my tree :(
