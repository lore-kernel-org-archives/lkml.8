Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DC8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343BD2064C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S5E47DOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgGFSf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbgGFSf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:35:57 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC28C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 11:35:57 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id c11so3728503vkn.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ij6ynVLooZvFUU1WdE13blPhJSL1lkPuycUflF9mzkk=;
        b=S5E47DOPwDbYX9qAauzXw9PRmHeP+yPvDc6wa5lKnIARuccDh4qsjGVklgl9MMkude
         M7VvzR6wUEffCmaFNnfMs9T0CK2uI24oyJ9/a7dICYFwuhGoC/TfskyWpbxmXLwPpVCW
         Rmg+uA6dnC+5jpsYDsj8xGGD1Ho0cKYrMAI2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ij6ynVLooZvFUU1WdE13blPhJSL1lkPuycUflF9mzkk=;
        b=NjNRw3aYZrRK9XKkUa5bGacAH2WGsfc6eiF96tl888TgojjslxyYs9t01mrK/qnIKg
         gMAFwv53QUplnUXatD0pHYomkGRE9CX4vZQdasndvAf9z0G/6KVkxaS0tKTLaFshBHe9
         E7poyWQ7qyyME7zLrn+na81stzttGPAR/1C5bX8EWJFbv7hupBTKF0NOqG6zxXHgf9Nl
         Q73FKplz/xvNIqmAjuU7jwL6OdeHN4s9irILmq9BRgKqZKDOztBLultRlP3WcFRgNttE
         CtuXMegHZqOWdN5jkjZQeesw5bK5i+zgipnUBBHXCDiA9G4w4PDoPVGXbJwXAWpNFgMc
         NbFw==
X-Gm-Message-State: AOAM533mZ7wtqfhYhxW6zyC+uJyGXpKZ/3VhodJjAzlYdXGh1K7k8wpA
        8VeGwKw61jkL/5M0NjSWgI0eSMxZLSg=
X-Google-Smtp-Source: ABdhPJypq35oh1H6RKzBSmH0H3q2UJAZWxZLQEFS87U+S4lhqDu0ufiSql3VtEsPdl4Qe884/2Cnuw==
X-Received: by 2002:a1f:ab96:: with SMTP id u144mr34165625vke.76.1594060556156;
        Mon, 06 Jul 2020 11:35:56 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id n17sm5193988uao.14.2020.07.06.11.35.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 11:35:55 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id a17so10249663vsq.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 11:35:55 -0700 (PDT)
X-Received: by 2002:a67:1702:: with SMTP id 2mr5791561vsx.153.1594060554613;
 Mon, 06 Jul 2020 11:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <7d2c980f071487cecfd1534adb7561b33d922af3.1593968925.git.mail@maciej.szmigiero.name>
In-Reply-To: <7d2c980f071487cecfd1534adb7561b33d922af3.1593968925.git.mail@maciej.szmigiero.name>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Mon, 6 Jul 2020 11:35:43 -0700
X-Gmail-Original-Message-ID: <CA+jURcvL4B7xDObma5PZgTq4eaBbj6AGgBwDCSyf_mb7oRf+Lw@mail.gmail.com>
Message-ID: <CA+jURcvL4B7xDObma5PZgTq4eaBbj6AGgBwDCSyf_mb7oRf+Lw@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: avoid repeated "multiplier = " log messages
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jul 2020 at 10:09, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> These messages appear each time the mouse wakes from sleep, in my case
> (Logitech M705), every minute or so.
> Let's downgrade them to the "debug" level so they don't fill the kernel log
> by default.
>
> While we are at it, let's make clear that this is a wheel multiplier (and
> not, for example, XY movement multiplier).

Looks good to me, thanks!

Reviewed-by: Harry Cutts <hcutts@chromium.org>

Harry Cutts
Chrome OS Touch/Input team

>
> Fixes: 4435ff2f09a2 ("HID: logitech: Enable high-resolution scrolling on Logitech mice")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 1e1cf8eae649..b8b53dc95e86 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -3146,7 +3146,7 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
>                 multiplier = 1;
>
>         hidpp->vertical_wheel_counter.wheel_multiplier = multiplier;
> -       hid_info(hidpp->hid_dev, "multiplier = %d\n", multiplier);
> +       hid_dbg(hidpp->hid_dev, "wheel multiplier = %d\n", multiplier);
>         return 0;
>  }
>
