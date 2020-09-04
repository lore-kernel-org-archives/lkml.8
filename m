Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71C0C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B08F204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599227607;
	bh=936VthRBiEB4km52buOWNR2V7woJnLVTpg2eVa8/G2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zyYcU70zkxQc1vw/JHRqYtvtom5K8mp33bDtCw9qqr6HykfEsKGFGqGogb4yq6Pz3
	 +8YGcVQc33VFoG2IIZnQ7PkRm1/dvJDyzlTV3EzRH1T9jcmFC9bqFKJkPDiTV7Zt11
	 exPS3AK1BphhWrLLSPfuXLcSteg3kEF6tFKHPmTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbgIDNxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbgIDNu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:50:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14905204FD;
        Fri,  4 Sep 2020 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599227428;
        bh=936VthRBiEB4km52buOWNR2V7woJnLVTpg2eVa8/G2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5ymyTrwKNf9E/c7D0/1k80/zY25RgIG1FMihrBWz6Nr6ZfiaF77ACOyBDMK21DHQ
         GzK1Lqe3FO/B5hbxQnMqGD5OtFm03U7dT22Wy/8yekJsB0Z7A0gx5fxVDrhrpIPlSG
         B8NVSTDMkW60Hk1Ot+lRKBP4d2+IPYbWcubdJBKs=
Date:   Fri, 4 Sep 2020 15:50:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Penghao <penghao@uniontech.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, hdegoede@redhat.com, dlaz@chromium.org,
        stern@rowland.harvard.edu, kerneldev@karsmulder.nl,
        jonathan@jdcox.net, tomasz@meresinski.eu
Subject: Re: [PATCH v3] HID: quirks: Add USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk
 for BYD zhaoxin notebook
Message-ID: <20200904135049.GA3181902@kroah.com>
References: <20200904091322.30426-1-penghao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904091322.30426-1-penghao@uniontech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 05:13:22PM +0800, Penghao wrote:
> Add a USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk for the BYD zhaoxin notebook.
> This notebook come with usb touchpad. And we would like to disable touchpad
> wakeup on this notebook by default.
> 
> Signed-off-by: Penghao <penghao@uniontech.com>
> ---
> 
> Changes since v2:
>  - Add changes
> 
> Changes since v1:
>  - Add the entries sorted by vendor ID and product ID.
> 
>  drivers/usb/core/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 7c1198f80c23..fffe1f7f1098 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -393,6 +393,10 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	/* Generic RTL8153 based ethernet adapters */
>  	{ USB_DEVICE(0x0bda, 0x8153), .driver_info = USB_QUIRK_NO_LPM },
>  
> +	/* SONiX USB DEVICE Touchpad */
> +	{ USB_DEVICE(0x0c45, 0x7056), .driver_info =
> +			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
> +

Why is the subject line "HID:"?  This is a USB core quirk, not a
hid-specific one.

thanks,

greg k-h
