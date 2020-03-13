Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4401C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B197B206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oh6f583y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgCMIoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:44:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33030 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgCMIoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:44:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id f13so9606710ljp.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Gtujv07eK1xPWT0ctk5J1c+5ubp4y3UohmoTfjBA/A=;
        b=Oh6f583ydpJn4KbX5BnqFb6BPbutb94kUnuNVDdNdLMCoIGqlJfgGP2P/b9E/bTw7n
         lL3WrvwTzVVGYfi+CwtKKhcy19mPCXerKAmuxXySa8ZeACzJypMpQXTopIFfJgJZ+/YU
         ykc5cKDy3bCh7hrS4Ts2YJAnhnEV0luUxZLkDK9mhXSCfUkNKGaIaD06Hg9LYbflZjX1
         RmenR0SFmErufoCzDkGhZ19SyW/0Fw+abmRZAqKLaQQ2XVjfX8PBqn5SNsuxmjjlTDzQ
         K/Swve8tkLSQnc/U0ehKn/FnWugVFp3nlV7J2eE0Nk+a2tsF47Z9HWUWXS4/8NHv6pww
         pAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Gtujv07eK1xPWT0ctk5J1c+5ubp4y3UohmoTfjBA/A=;
        b=UrgVl8ZdPi+2GQlHMrkQXXaU6bjTQAUznDulZKPvMza91tK7RTm3JSkaLsSiqO1M52
         UE4RFPuMDNJTaykJvtUAJouOTBQaAwgvkEHOB1z8TjMxFpvzC1ZTPG+a1deiB0D2uJQb
         gz1D89xWm9kY07EMN1fsK1Du+B0RXCWl0i8GpfzrGJg6v2gK8x+0+oRVS61HrhzEh2GB
         y4It+gf7PeViJlmpuoJa8fnfc6DmJfYkLHxeuQXTuYpf9dzyRCxEkao6g0F7U8hL68zQ
         MQkdsbTYxoNh+uO2xRjLM3jzqqE55LsN98X+s6oRKNRQMX8o2kr2ye4w45a47d+kqZqS
         MTmQ==
X-Gm-Message-State: ANhLgQ1cywgEw8p5qPRblN6pBYRieNuF+Jp/zzhzxQjnwdk/CY7uhuMR
        ZXOZfB38wNGkLbvkGrwNiuFYvkcraMHbpqS63kxQSw==
X-Google-Smtp-Source: ADFU+vvR+eABso3F/lvmpJ7bgUIi6EUkupQtt2VCMAZjjYQ4QkricyNwLL7DbzIR/CnIXtHAyGza0jK3twBBPBu149U=
X-Received: by 2002:a2e:8ecf:: with SMTP id e15mr5543047ljl.223.1584089048137;
 Fri, 13 Mar 2020 01:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200224094158.28761-1-brgl@bgdev.pl> <20200224094158.28761-3-brgl@bgdev.pl>
 <CAMRc=MdbvwQ3Exa2gmY-J0p8UeB-_dKrgqHEBo=S08yU4Uth=A@mail.gmail.com>
 <CACRpkdbBCihyayQ=hPVLY8z4G=n5cxLnUmaPpHRuKedDQPVUyQ@mail.gmail.com> <CAMpxmJX_Jqz97bp-nKtJp7_CgJ=72ZxWkEPN4Y-dpNpqEwa_Mg@mail.gmail.com>
In-Reply-To: <CAMpxmJX_Jqz97bp-nKtJp7_CgJ=72ZxWkEPN4Y-dpNpqEwa_Mg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Mar 2020 09:43:56 +0100
Message-ID: <CACRpkdYpers8Zzh9A3T0mFSyZYDcrjfn9iaQn92RkVHWE+GinQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpiolib: use kref in gpio_desc
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Khouloud Touil <ktouil@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 7:25 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:

> I believe this is not correct. The resources managed by devres are
> released when the device is detached from a driver, not when the
> device's reference count goes to 0. When the latter happens, the
> device's specific (or its device_type's) release callback is called -
> for gpiolib this is gpiodevice_release().

Yeah you're right, I even point that out in my second letter :/

It's a bit of confusion for everyone (or it's just me).

> The kref inside struct device will not go down to zero until you call
> device_del() (if you previously called device_add() that is which
> increases the reference count by a couple points). But what I'm
> thinking about is making the call to device_del() depend not on the
> call to gpiochip_remove() but on the kref on the gpio device going
> down to zero. As for the protection against module removal - this
> should be handled by module_get/put().

Right. At the end of gpiochip_remove():

   cdev_device_del(&gdev->chrdev, &gdev->dev);
   put_device(&gdev->dev);

That last put_device() should in best case bring the refcount
to zero.

So the actual way we lifecycle GPIO chips is managed
resources using only devm_* but the reference count does work
too: reference count should normally land at zero since the
gpiochip_remove() call is ended with a call to
put_device() and that should (ideally) bring it to zero.

It's just that this doesn't really trigger anything.

I think there is no way out of the fact that we have to
forcefully remove the gpio_chip when devm_* destructors
kicks in: the driver is indeed getting removed at that
point.

In gpiochip_remove() we "numb" the chip so that any
gpio_desc:s currently in use will just fail silently and not crash,
since they are not backed by a driver any more. The descs
stay around until the consumer releases them, but if we probe the
same GPIO device again they will certainly not re-attach or
something.

Arguably it is a bit of policy. Would it make more sense to
have rmmod fail if the kref inside gdev->dev->kobj->kref
is != 1? I suppose that is what things like storage
drivers pretty much have to do.

The problem with that is that as soon as you have a consumer
that is compiled into the kernel it makes it impossible to
remove the gpio driver with rmmod.

I really needed to refresh this a bit, so the above is maybe
a bit therapeutic.

I don't really see how we could do things differently without
creating some other problem though.

Yours,
Linus Walleij
