Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF69C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 08:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825D02087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580803909;
	bh=SLLYssBIp08aYMdVHWBeSqmn5t621xNAmpahvakYJwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r0sffM4ImURAQHSSgZNedtTYlSqZCuAoApnM070zKvrt5iH8KccUBlh/bAGodL7SX
	 ETRDvrMKVgDiFg4h//RcdRAnPZ0meCEF82ZlUvISu36swGTFZ5ijOQbgrLzmscVSxu
	 uM8wgo+gPYHyoFM1XmnNYDX0/wYuIa8z+HVB6VsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgBDILt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:11:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39221 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgBDILs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 03:11:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id o15so11994534ljg.6;
        Tue, 04 Feb 2020 00:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6sqvvOg/zAjFutnY8VlDzQ+LHwP3wPOLlyLeY12TqRo=;
        b=d0nXHj1AYL/cgvrqezF1eAENPZy5pqhoq8pqblU/RX/m+HKBtJPNcfUgRYFlqXvYea
         7Yo+QmOHGRtrvBngFLPl5xMLJU+WpGYOq4Je1BKmebVkPU7JdszFwZjsoZyMepyMuNNK
         du7rFV8Xet/kiKQMBw4VWYrV2FjJ4b01T6YXymwyZcyIgagbBxsHbA4nDpVZ9kmGJdKA
         OT30W6N9+jmwa3qXWpMk4jjvFrSrJ0cLjTRGq32eqRG8uN52uzoRdt9jMpACs9jlJe+e
         vZTYL2kSwdBaxhZLzsYRVGkSVs6Y60G05udx7HkQ0WUD42HZkar1wdHMALYA5WuzeeTZ
         5fOQ==
X-Gm-Message-State: APjAAAVNdDfbVzI3gYdQgraZlqZJavIFucH9t/z0P8xkJE6yc99xcNJG
        LoCQo8PH1AXhfd71551qI8604j6C
X-Google-Smtp-Source: APXvYqxLUwXw1YItqMStIvVnNVaPKbRTXtu6eTz1EIIRlzhPvMelYSxTm/BrTrOpMwUuSF3DC52aow==
X-Received: by 2002:a2e:6e19:: with SMTP id j25mr16359366ljc.95.1580803906831;
        Tue, 04 Feb 2020 00:11:46 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id a8sm11032729ljn.74.2020.02.04.00.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:11:45 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iytJL-0008Dh-3q; Tue, 04 Feb 2020 09:11:55 +0100
Date:   Tue, 4 Feb 2020 09:11:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Vladis Dronov <vdronov@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 65/90] Input: aiptek - use descriptors of current
 altsetting
Message-ID: <20200204081155.GC26725@localhost>
References: <20200203161917.612554987@linuxfoundation.org>
 <20200203161925.451117468@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203161925.451117468@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 04:20:08PM +0000, Greg Kroah-Hartman wrote:
> From: Johan Hovold <johan@kernel.org>
> 
> [ Upstream commit cfa4f6a99fb183742cace65ec551b444852b8ef6 ]
> 
> Make sure to always use the descriptors of the current alternate setting
> to avoid future issues when accessing fields that may differ between
> settings.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> Acked-by: Vladis Dronov <vdronov@redhat.com>
> Link: https://lore.kernel.org/r/20191210113737.4016-4-johan@kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/input/tablet/aiptek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
> index 06d0ffef4a171..e08b0ef078e81 100644
> --- a/drivers/input/tablet/aiptek.c
> +++ b/drivers/input/tablet/aiptek.c
> @@ -1713,7 +1713,7 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  
>  	aiptek->inputdev = inputdev;
>  	aiptek->intf = intf;
> -	aiptek->ifnum = intf->altsetting[0].desc.bInterfaceNumber;
> +	aiptek->ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
>  	aiptek->inDelay = 0;
>  	aiptek->endDelay = 0;
>  	aiptek->previousJitterable = 0;

I asked Sasha to drop this one directly when he added it, so it's
probable gone from all the stable queues by now.

But I'm still curious how this ended up being selected for stable in the
first place? There's no fixes or stable tag in the commit, and I never
received a mail from the AUTOSEL scripts.

Johan
