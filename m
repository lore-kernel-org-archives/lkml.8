Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF68EC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E20920721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgAJPka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:40:30 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:42618 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728355AbgAJPka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:40:30 -0500
Received: (qmail 3120 invoked by uid 2102); 10 Jan 2020 10:40:29 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jan 2020 10:40:29 -0500
Date:   Fri, 10 Jan 2020 10:40:29 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     mathias.nyman@intel.com, <gregkh@linuxfoundation.org>,
        <acelan.kao@canonical.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] USB: Disable LPM on WD19's Realtek Hub
In-Reply-To: <20200110080211.22626-1-kai.heng.feng@canonical.com>
Message-ID: <Pine.LNX.4.44L0.2001101038390.1467-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020, Kai-Heng Feng wrote:

> Realtek Hub (0bda:0x0487) used in Dell Dock WD19 sometimes drops off the
> bus when bringing underlying ports from U3 to U0.
> 
> Disabling LPM on the hub during setting link state is not enough, so
> let's disable LPM completely for this hub.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/usb/core/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 6b6413073584..2fb7c1602280 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -371,6 +371,9 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	{ USB_DEVICE(0x0b05, 0x17e0), .driver_info =
>  			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
>  
> +	/* Realtek hub in Dell WD19 (Type-C) */
> +	{ USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },
> +
>  	/* Action Semiconductor flash disk */
>  	{ USB_DEVICE(0x10d6, 0x2200), .driver_info =
>  			USB_QUIRK_STRING_FETCH_255 },
> 

This is a very partial patch.  There were four hunks in the original 
version but there's only one hunk in V2.

Alan Stern

