Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6374BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2533B20758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589547732;
	bh=i8wsw3aOGDrE/4FbnVOmz9EVmC1KPujyU3DOv8Mpcok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hAXiSaM6JduPOXd8q5WeeNx6hUyOZkk/7A9DFTGS/5rc42AN70Ok/6Jhf5TqC55IL
	 rQkAdI1KY08K/MBQDpln56O+lbaSLQ+wffPUcVeSui/TUIqKTpSlxftMR5UMCnscJo
	 HPyLyDi7V2H7xakr3erRgx8oNGbH23WIuWtI9VqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgEONCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgEONCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:02:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B3F2074D;
        Fri, 15 May 2020 13:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589547730;
        bh=i8wsw3aOGDrE/4FbnVOmz9EVmC1KPujyU3DOv8Mpcok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oNgdFZ/mimNw+axqGQgmV3DgtOHMVVaJQCsrwpk4RHJDZb/HM+vcVQh6ZZfTBq1A8
         NWIN/CPn2wIircB0IHroyaqvaf70jiUfeSPdCbeUuTX2niflMwnS70h9IvOuvv4KmZ
         mn/lpoSO61GrXJQGYSjHC8iZXD2256Md1NXWpDus=
Date:   Fri, 15 May 2020 15:02:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: Re: [PATCH v6 1/8] usb: Add MA-USB Host kernel module
Message-ID: <20200515130208.GB1937631@kroah.com>
References: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-2-vladimir.stankovic@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515123502.12099-2-vladimir.stankovic@displaylink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:34:55PM +0200, Vladimir Stankovic wrote:
> Added utility macros, kernel device creation and cleanup, functions for
> handling log formatting and a placeholder module for MA-USB Host device
> driver.
> 
> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> ---
>  MAINTAINERS                         |  7 +++++
>  drivers/usb/Kconfig                 |  2 ++
>  drivers/usb/Makefile                |  1 +
>  drivers/usb/host/mausb/Kconfig      | 15 +++++++++
>  drivers/usb/host/mausb/Makefile     | 10 ++++++
>  drivers/usb/host/mausb/mausb_core.c | 24 +++++++++++++++
>  drivers/usb/host/mausb/utils.c      | 47 +++++++++++++++++++++++++++++
>  drivers/usb/host/mausb/utils.h      | 15 +++++++++
>  8 files changed, 121 insertions(+)
>  create mode 100644 drivers/usb/host/mausb/Kconfig
>  create mode 100644 drivers/usb/host/mausb/Makefile
>  create mode 100644 drivers/usb/host/mausb/mausb_core.c
>  create mode 100644 drivers/usb/host/mausb/utils.c
>  create mode 100644 drivers/usb/host/mausb/utils.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 091ec22c1a23..9b7b79215f47 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10343,6 +10343,13 @@ W:	https://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/media/radio/radio-maxiradio*
>  
> +MEDIA AGNOSTIC (MA) USB HOST DRIVER
> +M:	Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> +L:	mausb-host-devel@displaylink.com

Please just do this on the linux-usb mailing list, why have a whole new
list for just a single small driver?

thanks,

greg k-h
