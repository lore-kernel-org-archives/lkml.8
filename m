Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC124C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C58920708
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9WB+FMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgGFQIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbgGFQIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:08:37 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1415C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 09:08:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v6so26252102iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+WVm/HjSi2jf8uZdSi4EI9UGoOb7MLDK//YEI66B4Y=;
        b=V9WB+FMBApfWRAOK3ml3pRuHNo4W/Z3hfk6o39TVjedoqTDQo5Hs3G11HXHnwGRDYr
         besReQP6I6GKnr+UFpJYqJSbbHVb5Ngb9rBqslXn+ZsqgdHHYh6fTiscyFt/hT6BOaO3
         JTmyLT/I4f6npN92Yg4myQXZAZFN9CUw+fjsA672/KRW4eZvB9Aw5Idi9ppV0eSLQreO
         CVlE0fezsNFbIxk/Jg1AymJxx1uU5TlDMu9CJLFQ4zOzERx8L5fhnwI77KLChOn5gbvZ
         XjcgNcEqu2xiuFY2vZTZRxLZT0SKD5xfjaqR6pFKeQJRXGHbMjnV28U7yh/sKX+4A+lL
         HR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+WVm/HjSi2jf8uZdSi4EI9UGoOb7MLDK//YEI66B4Y=;
        b=b/y/zkKfEy6mr3f6Od/UjBr4WZlUANcjRPQaVLQOJnibxMX7ZMcyEwY7OB2uAP3lc2
         URJv0VIvvGAJY7JHzEjxu5Lk994zPLKXkRs9B8utlxX+OWD6NtDMUdDLRC7vnDn6KJsk
         yPTHRXnuoIm8b5dGHLD1XcwvWMfCNAiH0cgFGSPOertBEFZLEzxJ+s6zn4dwLLyxoM0B
         o/KDcvUARB+WRl90ZvfvBslI6Pg0113042dFfxHEw4Wc33z2TSIkBck6Y1NCGJdBX5rh
         /y9tNIEpY5htw2UtIWymMUY2lZIv2t1Yq+Fu54GzLNpQ0k4KqM0KPXnmebcqm6UkZFqY
         y6Sw==
X-Gm-Message-State: AOAM530c3KZLN0ncQtbg4qZtkUcfDGaLs07qT0Eh+SoVTgsxi7/7Ln0L
        EoFVkv5PwxlKGvae39s/cN36iu/HoVpHGSC+ba0wlg==
X-Google-Smtp-Source: ABdhPJybFzSqqaU5Dc2CsDZhwwoSEtr9jFUO9cVopxHMAk/QFatZ7LOnS0l7obE1sXh+k1EtywMHmnAmF5m4W3EWjcw=
X-Received: by 2002:a02:a19c:: with SMTP id n28mr54037974jah.13.1594051716242;
 Mon, 06 Jul 2020 09:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200706133341.476881-1-lee.jones@linaro.org> <20200706133341.476881-24-lee.jones@linaro.org>
In-Reply-To: <20200706133341.476881-24-lee.jones@linaro.org>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Mon, 6 Jul 2020 11:08:25 -0500
Message-ID: <CAJe_ZheZY-Vc+bZGGHKM7YkBxoOyf3CPBHY0=+cTw5Pp69FqEg@mail.gmail.com>
Subject: Re: [PATCH 23/32] usb: gadget: udc: max3420_udc: Remove set, but
 never checked variable 'addr'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB list <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 at 08:34, Lee Jones <lee.jones@linaro.org> wrote:

> diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
> index 23f33946d80c4..52884bae4af11 100644
> --- a/drivers/usb/gadget/udc/max3420_udc.c
> +++ b/drivers/usb/gadget/udc/max3420_udc.c
> @@ -623,7 +623,6 @@ static void max3420_set_clear_feature(struct max3420_udc *udc)
>  static void max3420_handle_setup(struct max3420_udc *udc)
>  {
>         struct usb_ctrlrequest setup;
> -       u8 addr;
>
>         spi_rd_buf(udc, MAX3420_REG_SUDFIFO, (void *)&setup, 8);
>
> @@ -647,7 +646,7 @@ static void max3420_handle_setup(struct max3420_udc *udc)
>                                 USB_TYPE_STANDARD | USB_RECIP_DEVICE)) {
>                         break;
>                 }
> -               addr = spi_rd8_ack(udc, MAX3420_REG_FNADDR, 1);
> +               spi_rd8_ack(udc, MAX3420_REG_FNADDR, 1);
>                 dev_dbg(udc->dev, "Assigned Address=%d\n", udc->setup.wValue);
>                 return;
>         case USB_REQ_CLEAR_FEATURE:

Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
