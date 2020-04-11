Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C84C2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7342166E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="mp/DOoPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgDKXLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:11:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36948 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbgDKXLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:11:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id w2so613333edx.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 16:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hM2xNoRDEOsCQMc/8ffTH/ZtgmObtgZL7f9RJCSssp8=;
        b=mp/DOoPQsfzm3B0+5t9StX5Kkk2y5KlqsKysolBoZDoYSBzOEC4TJOKuasReGBbIaz
         4zXqJYGie8jGh1yvbaKdzJ2Fn7pj24ghTcW3cv9RYgl1K64lwn+TESkQBZDMc6lLTQ/O
         WIpQHW5HmVTC4jMKFMXjxfReNhnG7BwT4IYe3tRv2yFa99oRRbOzOWaOVJbPb3PNvtuH
         /t3BxBpCpzESLw8UiEcuT6ufBsM5CwHzV1h+hpO0wUmlPLgwgDkp8sfjMIUE99KjthN2
         Jg31cAf7fG1boxi/Pah5y6dc8maleWaTl6ifq326DuWTQ17S/MkS6srMLP5yr6y2nLW9
         rJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hM2xNoRDEOsCQMc/8ffTH/ZtgmObtgZL7f9RJCSssp8=;
        b=UxxNEK02m67wWr/g/S4YiAyoq9pi0aJ0RaNHQ3Qj1onDos/YMaDvueyWYC0nGb9aqJ
         EV/wac0T4TKmNGkLaB0PDi+xeERBa7d2HZbWrw3shYSDS4jxB+VEkkP78sSPZKgxWKYo
         J3cC1nLRrl7G6kxRtZkzIXwpKY9coo6+dGvww/CEoMZSg9EU6VLg5bD2HKqOJYxYjcsl
         Ti8WIJq3rOeeSE/RWFGjWwjpf6I+fltIUN/WqmAzQocfuTUrFT3NN348GAnlyZ99nxQb
         m8oV+xlXTY19Wv8BcZXYsVl/QdG2+yfX6o5m2hQL9XlwIZCGZsGexNrtq4okZTVPK2vo
         en9w==
X-Gm-Message-State: AGi0PuZ0fWzk+DUzA7TI53rmT4wy7D1lNlKkR6zORi6B/SjjXPus3hzf
        u6fNv4QQmtTUtqrv54+krGnXPizK022/NGp8jeH7Nw==
X-Google-Smtp-Source: APiQypJQE2qPgi1xoI94y8AB90tOMDYjsDYUMuc9MPy0tLvmBy917MrKoq5KDglXColsDfnLnEhRWmNu1NxR4UTerNo=
X-Received: by 2002:a17:906:7f10:: with SMTP id d16mr10139135ejr.318.1586646672949;
 Sat, 11 Apr 2020 16:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200410135014.26396-1-colin.king@canonical.com>
In-Reply-To: <20200410135014.26396-1-colin.king@canonical.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 11 Apr 2020 20:11:01 -0300
Message-ID: <CAAEAJfA2PQOUWbKu=CLPaA-bx2T3MWGpsviq7DBaJ9DxOqCTbg@mail.gmail.com>
Subject: Re: [PATCH] media: pwc-ctl: remove redundant assignment to variable ret
To:     Colin King <colin.king@canonical.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 at 10:50, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable ret is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

> ---
>  drivers/media/usb/pwc/pwc-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/pwc/pwc-ctrl.c b/drivers/media/usb/pwc/pwc-ctrl.c
> index 315c55927f5c..cff64d872058 100644
> --- a/drivers/media/usb/pwc/pwc-ctrl.c
> +++ b/drivers/media/usb/pwc/pwc-ctrl.c
> @@ -523,7 +523,7 @@ int pwc_set_leds(struct pwc_device *pdev, int on_value, int off_value)
>  #ifdef CONFIG_USB_PWC_DEBUG
>  int pwc_get_cmos_sensor(struct pwc_device *pdev, int *sensor)
>  {
> -       int ret = -1, request;
> +       int ret, request;
>
>         if (pdev->type < 675)
>                 request = SENSOR_TYPE_FORMATTER1;
> --
> 2.25.1
>
