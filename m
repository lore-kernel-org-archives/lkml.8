Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0216C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF332070E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595656126;
	bh=DpwtEy6sOMsNxwTeeKHQRNVX06XPQPg+rvgHwtaGcYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bIsnPWBqD16EMH84qoMhCv6ex4OXS2jNDrhIrYVu3kAxg6WzCKDTGcNCRHuKkP51z
	 6DDtCw8Hg5oTdHsDLVgHB4U+RXtroBXNuI/oyUhYFLAD2hJmWbyYWk876JLIBpN6LB
	 iw1clslZ91ip5iUiJGOj77YhFCi/CRJBHoGmOyOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgGYFso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgGYFso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:48:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0F432065F;
        Sat, 25 Jul 2020 05:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595656124;
        bh=DpwtEy6sOMsNxwTeeKHQRNVX06XPQPg+rvgHwtaGcYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GX6NrcPZmMyqL+AUc//69uSY/N8aM4DXZDsz/B1blMZAd5HSHuXrbeg2rBMizdCNF
         p3vM5dnRQrcZ0Wh9Tq4FFA8nqiYWxH5jqkZtR6f7mgStB69s7MnS2w8APx9Ne6ZkZm
         muJ8te/2zG6qkbNvkz3LOlzromIPIb6RPSUpj7zY=
Date:   Sat, 25 Jul 2020 07:48:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     penghao <penghao@uniontech.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, phz0008@163.com,
        "penghao@deepin.com" <penghao@deepin.com>
Subject: Re: [PATCH 14216/14216] ALSA: usb-audio: This patch for prevent auto
 wakeup from s3 trig by usb disconnect signal from Lenovo Thinkcentre
 TI024Gen3  USB-audio.
Message-ID: <20200725054844.GA1045868@kroah.com>
References: <20200725040155.27648-1-penghao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725040155.27648-1-penghao@uniontech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 12:01:55PM +0800, penghao wrote:
> From: "penghao@deepin.com" <penghao@deepin.com>
> 
>  TI024Gen3 USB-audio is controlled by TI024Gen3,when TI024Gens
>  enter sleep mode, USB-audio will disconnect from USB bus port,
>  so disabled the /sys/bus/usb/*/power/wakeup Fixesimmediately
>  wakup form s3 state

Why the indentation?

> 
> Signed-off-by: penghao@uniontech.com <penghao@uniontech.com>
> Signed-off-by: penghao@deepin.com <penghao@deepin.com>

We need a name, not just an email address.

And where are the 14215 other patches in this patch series?


> ---
>  sound/usb/card.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 2644a5ae2b75..969c3809e051 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -640,6 +640,12 @@ static int usb_audio_probe(struct usb_interface *intf,
>  		}
>  	}
>  	dev_set_drvdata(&dev->dev, chip);
> +	/*
> +	 * ALSA: usb-audio: Add prevent wakeup from s3 state trig by lenovo
> +	 * ThinkCentre TI024Gen3 USB-audio
> +	 */
> +	if ((usb_id->idVendor == 0x17ef) && (usb_id->idProduct == 0xa012))
> +		device_set_wakeup_enable(&dev->dev, 0);

Shouldn't there be a quirk for this type of device that can be used
instead?

thanks,

greg k-h
