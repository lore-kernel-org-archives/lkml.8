Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF1FC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A6020786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgICP3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:29:46 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46509 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728337AbgICP3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:29:39 -0400
Received: (qmail 662975 invoked by uid 1000); 3 Sep 2020 11:29:37 -0400
Date:   Thu, 3 Sep 2020 11:29:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Penghao <penghao@uniontech.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org, hdegoede@redhat.com,
        dlaz@chromium.org, kerneldev@karsmulder.nl, jonathan@jdcox.net,
        tomasz@meresinski.eu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: Add USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk
 for BYD zhaoxin notebook
Message-ID: <20200903152937.GA662845@rowland.harvard.edu>
References: <20200903100326.5327-1-penghao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903100326.5327-1-penghao@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 06:03:26PM +0800, Penghao wrote:
> Add a USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk for the BYD zhaoxin notebook.
> This notebook come with usb touchpad. And we would like to disable touchpad
> wakeup on this notebook by default.
> 
> Signed-off-by: Penghao <penghao@uniontech.com>
> ---
>  drivers/usb/core/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 7c1198f80c23..5fa3f2416967 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -387,6 +387,10 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	{ USB_DEVICE(0x0b05, 0x17e0), .driver_info =
>  			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
>  
> +	/* SONiX USB DEVICE Touchpad */
> +	{ USB_DEVICE(0x0c45, 0x7056), .driver_info =
> +			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
> +
>  	/* Realtek hub in Dell WD19 (Type-C) */
>  	{ USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },

Please follow the instructions at the start of the file about keeping 
the entries sorted by vendor ID and product ID.

Alan Stern
