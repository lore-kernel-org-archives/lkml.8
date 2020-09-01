Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E23EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D322206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX5xMjeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgIAO0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgIAOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:24:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0F9C061244;
        Tue,  1 Sep 2020 07:23:59 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id u3so1068605qkd.9;
        Tue, 01 Sep 2020 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAQ4YiMSkHC9RzkUDkgTyPkvwAB2mW+MR+9dX9vsWvs=;
        b=nX5xMjeR7fuJaVhzMu0ybBwRyMmOR90Ffpu+OY34EefsR3hD5SrIc4kuOsS3kjpPML
         WtNPP+VaeJKCNk6CKBV1NbVo8GXHg2aSfTYdXRA9oB9D7aT3YZGitRmyTvaBV3ok0+UO
         EE+VJH/krpQlpguKNTHBsEk0hdrHSoPfhcYSKsDt1NyZFPxQA2/gJhV1yCqhocQbuRvF
         5OErjiME2W2XWRL27qqXRirtNgAlrAy5dGcF6jVrbRdYoGyG1mlVv6S0+iFWxf8xR0MH
         PDzkvazyZFKe2p8WYVNcwQ+TcphjTwKHrgzVJCrnBgaXvJ+02FbVgK3e3TATiX1QyYdP
         4jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAQ4YiMSkHC9RzkUDkgTyPkvwAB2mW+MR+9dX9vsWvs=;
        b=Gm+iuSwr6USoehKfWKG1jfCTR0NksOgyzCLYAqSPd9uPkuxS+1t+jusEqufJf5aUso
         CEt/lNBu5zopqHdFhM0Ekfo+w9cO8JGFh9RmGb6qwTsrGJ3FhkKH/oYbeBr1wNQmSQgu
         2fjpwtKzP5j2Dk59fbPNU6vqmYbXjBmK7sIaMJ9JOa0BoPRZgW+U7ow871wRP1Q+ixW/
         Hs/3vqkw1Zu6i/CV0Rod1OkXIhR+JqUJIG/ueMi9JtAxmMHWGTgX3IZaBAQ0bm1fNO86
         o52bmNHuTLWWwCKP6YYPU19zh4Mhn2ReoPpT37u8gShA2aLbgZA9BTGJaYNvlpsNFnm8
         JSzQ==
X-Gm-Message-State: AOAM5317ibOILoZ+43D6U+dhXXd5h3vMOco3VQMjgsjqyBRVRAMPZI68
        SoCUeLFu5t7NoQI3FiA/JMTmIrvxjnuzVC3FO1c=
X-Google-Smtp-Source: ABdhPJxNumRl7TCxA04yWhHg7sjmw+z5WNRoIcI3DHpiarpEYsgQbTJTSlCDR+32ZYkMta4x4H/r482184QKai6zc8w=
X-Received: by 2002:a37:a311:: with SMTP id m17mr2161284qke.442.1598970238512;
 Tue, 01 Sep 2020 07:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200901050022.3319-1-william.sung@advantech.com.tw> <20200901050022.3319-2-william.sung@advantech.com.tw>
In-Reply-To: <20200901050022.3319-2-william.sung@advantech.com.tw>
From:   Daniele Palmas <dnlplm@gmail.com>
Date:   Tue, 1 Sep 2020 16:23:46 +0200
Message-ID: <CAGRyCJFw05fB-KDcd8PKEg35rjwDh41=1O4XhjS2BQA61VPeng@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: serial: usb_wwan: Fix lackage for Quectel EG95
 LTE modem support
To:     William Sung <william.sung@advantech.com.tw>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Campion Kang <campion.kang@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

Il giorno mar 1 set 2020 alle ore 07:14 William Sung
<william.sung@advantech.com.tw> ha scritto:
>
> As required by the USB protocol, add zero packet support for Quectel
> EG95 LTE modem module.
>
> Fixes: f815dd5cf48b ("net: usb: qmi_wwan: add support for Quectel EG95
> LTE modem"

If I'm not wrong, that commit is just related to qmi_wwan.

>
> Signed-off-by: William Sung <william.sung@advantech.com.tw>
> ---
>  drivers/usb/serial/usb_wwan.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
> index 4b9845807bee..75495c939ac6 100644
> --- a/drivers/usb/serial/usb_wwan.c
> +++ b/drivers/usb/serial/usb_wwan.c
> @@ -467,6 +467,7 @@ static struct urb *usb_wwan_setup_urb(struct usb_serial_port *port,
>         struct usb_serial *serial = port->serial;
>         struct usb_wwan_intf_private *intfdata = usb_get_serial_data(serial);
>         struct urb *urb;
> +       struct usb_device_descriptor *desc = &serial->dev->descriptor;
>
>         urb = usb_alloc_urb(0, GFP_KERNEL);     /* No ISO */
>         if (!urb)
> @@ -476,8 +477,15 @@ static struct urb *usb_wwan_setup_urb(struct usb_serial_port *port,
>                           usb_sndbulkpipe(serial->dev, endpoint) | dir,
>                           buf, len, callback, ctx);
>
> -       if (intfdata->use_zlp && dir == USB_DIR_OUT)
> -               urb->transfer_flags |= URB_ZERO_PACKET;
> +       if (dir == USB_DIR_OUT) {
> +               if (intfdata->use_zlp)
> +                       urb->transfer_flags |= URB_ZERO_PACKET;
> +
> +               /* Add zero packet support for Quectel EG95 */
> +               if (desc->idVendor == cpu_to_le16(0x2C7C) &&
> +                       desc->idProduct == cpu_to_le16(0x0195))
> +                       urb->transfer_flags |= URB_ZERO_PACKET;
> +       }

Why not simply add the ZLP flag in option for that device?

Regards,
Daniele

>
>         return urb;
>  }
> --
> 2.17.1
>
