Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9736C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8162320734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592301957;
	bh=ZcJv80BBphhL9dsiZLQAxcJsEcYvxcWwY/2tPUIeg9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wIaKp6Lp5Ic3EAzxAzsj5fpVknJ5DveOnZIiI5f+emypSvmm1Mmkq+THHw6CUz2PX
	 /49E5rNVYxZFSqsBiNcsWnP3W34/oefZCSrs/JzlwxmtIWSf6EbzshxwGX7P38NZRF
	 zwvG9cZ1IvUiTtwovWaVYArp6uZqYn4b+sKqxoDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgFPKF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgFPKFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:05:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 510AB20786;
        Tue, 16 Jun 2020 10:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592301952;
        bh=ZcJv80BBphhL9dsiZLQAxcJsEcYvxcWwY/2tPUIeg9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVloEpjfOnhzioZ4fF/B0l2qj2Rwsuyw0OyA0ryXZvRyiQ+0WHpTn8esgX5cv72Fl
         n4UUmv3JWN0gRVPbPiMulJJ/XoE5rm5TFSHqmUdT839HYDAclFSmjTv3qXafO+oEOZ
         wUwjnij5VmeJCx1jT+5rKg+htgGR0s+kivmzGGok=
Date:   Tue, 16 Jun 2020 12:05:47 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Gao, Nian" <nian.gao@siemens.com>
Cc:     "Johan@kernel.org" <Johan@kernel.org>,
        "linux-sub@vger.kernel.org" <linux-sub@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [PATCH] USB: Serial: option: add a Longcheer device id
Message-ID: <20200616100547.GC2614426@kroah.com>
References: <838b462ac2da46dc832e841ec5850d45@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <838b462ac2da46dc832e841ec5850d45@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 07:55:10AM +0000, Gao, Nian wrote:
> >From 9220e0828f70a34c968e32d34e13281a4ff54b08 Mon Sep 17 00:00:00 2001
> From: Gao Nian <nian.gao@siemens.com>
> Date: Tue, 16 Jun 2020 15:13:48 +0800
> Subject: [PATCH] USB: Serial: option: add a Longcheer device id
> 
> Add a Longcheer device-id entry which specifically enables
> U9300C TD-LTE module.
> 
> Signed-off-by: Gao Nian <nian.gao@siemens.com>
> ---
> drivers/usb/serial/option.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 254a8bbeea67..6fd92431d2c9 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -394,6 +394,9 @@ static void option_instat_callback(struct urb *urb);
> /* iBall 3.5G connect wireless modem */
> #define IBALL_3_5G_CONNECT                                  0x9605
> +/* LONGSUNG U9300C TD-LTE wireless modem */
> +#define LONGSUNG_U9300C                         0x9b3c
> +
> /* Zoom */
> #define ZOOM_PRODUCT_4597                                  0x9607
> @@ -1845,6 +1848,7 @@ static const struct usb_device_id option_ids[] = {
>              .driver_info = RSVD(4) },
>            { USB_DEVICE(LONGCHEER_VENDOR_ID, ZOOM_PRODUCT_4597) },
>            { USB_DEVICE(LONGCHEER_VENDOR_ID, IBALL_3_5G_CONNECT) },
> +          { USB_DEVICE(LONGCHEER_VENDOR_ID, LONGSUNG_U9300C) },
>            { USB_DEVICE(HAIER_VENDOR_ID, HAIER_PRODUCT_CE100) },
>            { USB_DEVICE_AND_INTERFACE_INFO(HAIER_VENDOR_ID, HAIER_PRODUCT_CE81B, 0xff, 0xff, 0xff) },
>            /* Pirelli  */
> --
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
