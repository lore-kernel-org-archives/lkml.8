Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18B7C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976D4205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NS8QyZzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgCPK2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:28:19 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:39289 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgCPK2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:28:19 -0400
Received: by mail-il1-f196.google.com with SMTP id w15so8590618ilq.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 03:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TxPRfk6sibY6hpJglSupQUWB4+HiT17NTnwoa76dgxM=;
        b=NS8QyZzH0cEZAFqfqWtUf3zJCYnpsnhJjKa5s3AUlVWCrMS2r7XYcDufh6I1YFVumW
         m7Zp0uUr+kFRhuKC2BDSDlFXQK/chRvliVzCKQ+nvCDYDyL/fcgNfgPuyroJRHceRZHw
         mQgHMR+kpAaA2GSHPEiI6IFtgIWPYuZq0SEIPhAu8vFNcWoJEIwQt2tibUWQ8+73SHuA
         GU5Mrzd4DvirYUXKFM3Pay0gwYbTUwOvECoWWYu94azUBXk+a/jkbhyWUMGOFOilyA9k
         TqbbBbQzW8N1ot7huNmMyKI5GF9YGRYXmT93bXOsnNcV6d9WPmjmpoBmR63a+MP32Scr
         Y7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TxPRfk6sibY6hpJglSupQUWB4+HiT17NTnwoa76dgxM=;
        b=qQYKrOUaAq02+NTYd0xlLvC7HLpukJrDnea3bK9NMO1njXKcuyiu8sXGdXJDpkeubD
         KLfxEWunE2n1N5fpf3SOYVEn234xDZsqqfDoRZIQoFzuqVJKrcf9rX+P5Nee1xPzmlwE
         nu70XBYdjgC9tfsydeQHyRsAw9Z9bzW6YNRkrVEWzLhsQB4weMWrLrPc0JzVmgoGoXQi
         piNZr8aX5PKvDCKm+TUIGaZJHXQym0T2lctPEaDw9VroouVDGeQ+FbyDjtU5Rnjs5CKx
         0XqLU9+2KvLrabf3KAL3tD0s4WYjh8QO570rvgLxL+KC2JxsZ9l7sQeJ74pv8l6TNnS8
         YKkw==
X-Gm-Message-State: ANhLgQ0YBZApp5Y4kurDbMofiELsYb4earoHKJpiu7iDSeEFUX2YFe70
        IN2a5hJw+IG8h6dDhXbu4roWJUJASv+nmliHsVrjfw==
X-Google-Smtp-Source: ADFU+vsGVHx5bpn0+ubycNUe48ocy51bgN7prtIEKTgKxls3K76EhhgDAeT/EfgqdKb2LN6no63jMXRb45trrW4Gu/Y=
X-Received: by 2002:a92:8c42:: with SMTP id o63mr25215708ild.189.1584354496594;
 Mon, 16 Mar 2020 03:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <64270a8cc4bfca77ef4e280e5ab4623f4525ff39.1584290011.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <64270a8cc4bfca77ef4e280e5ab4623f4525ff39.1584290011.git.mirq-linux@rere.qmqm.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Mar 2020 11:28:05 +0100
Message-ID: <CAMRc=Me8ceOfP2cH-35qTsVSQq0tTKgW8+kW0u7WOhwWs4sAfQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: gpio_name_to_desc: factor out !name check
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 15 mar 2020 o 17:34 Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm=
.pl>
napisa=C5=82(a):
>
> Since name =3D=3D NULL can't ever match, move the check out of
> IRQ-disabled region.
>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/gpio/gpiolib.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 175c6363cf61..20fbeffbdd91 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -301,6 +301,9 @@ static struct gpio_desc *gpio_name_to_desc(const char=
 * const name)
>         struct gpio_device *gdev;
>         unsigned long flags;
>
> +       if (!name)
> +               return NULL;
> +
>         spin_lock_irqsave(&gpio_lock, flags);
>
>         list_for_each_entry(gdev, &gpio_devices, list) {
> @@ -309,7 +312,7 @@ static struct gpio_desc *gpio_name_to_desc(const char=
 * const name)
>                 for (i =3D 0; i !=3D gdev->ngpio; ++i) {
>                         struct gpio_desc *desc =3D &gdev->descs[i];
>
> -                       if (!desc->name || !name)
> +                       if (!desc->name)
>                                 continue;
>
>                         if (!strcmp(desc->name, name)) {
> --
> 2.20.1
>

Patch applied, thanks!

Bartosz
