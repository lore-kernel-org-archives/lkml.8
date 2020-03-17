Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287A2C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E486D20770
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KpQZ15LC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCQNlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:41:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39954 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgCQNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:41:04 -0400
Received: by mail-io1-f67.google.com with SMTP id h18so386603ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QmR4cKXPwmLVESUYOd+uijv8fqlBuTSi+RkgFo8qNnQ=;
        b=KpQZ15LCecBCrHnAqTjcR9wBx6NDPzIUoyffTM7cGZTqPpreBbQzxuZYcLDblusABt
         aH9wWLzE6hmBuHjDsUBTYYp7z/mAmW9gyXqbqesHL6VSOGADT6gl/IJ6JpGDQKKK+SN/
         uqcqX3KnkQpXK3Nbd+iupCaKs9v0zMtVFpaJzlG7I/aYcCKSbPF0WeVC29an8CwlyErG
         +XgygVhDfAdkp1Tav8DZIyG1mm1yCVa40WkFtrsLBbbpW5eBK56Lg9x5q453utDTQvaS
         7tiBapJGu2mYm52Xjp9eZEZjz8RxDYpROcNQhwtecYaUHQG5jDooYGo/3doQCL+/HjRV
         8fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QmR4cKXPwmLVESUYOd+uijv8fqlBuTSi+RkgFo8qNnQ=;
        b=YGUXdfvjU3j6xHHo20rz8koYCOSd+FafxKHhWSpYh9Sr8dMyrXUSaBGnwSiSMojU/C
         C6f0CTbKjHCjMJXYg6XaU3uxBRAn4D3UuwyJ5MfcVDrli9FFLZFtPM5bt1DyAvcfyPQ8
         1DsJcpZp1SPP2K4ok4Ve1P94w9ySGefYgWmSc98cWPcmbhmGKWJWiFDL2yz7ZWAiDplO
         7io9i6pG4aG8rbURv7TYYZVJAKlQN/pdQYXmMg2/sAHDo71ituCdxiurhrIrfJMCbJVq
         Mnm45UInCTV/E9ZgYhtO0HgUGZHfOf/tJxXyYs3RTajUo6rhsM1ycJepDa6Q/jgF98KL
         GtmA==
X-Gm-Message-State: ANhLgQ1mWui/2jW8ZF+OtlWu0o1sv2eC2apl/nKQknIeUPiPrOrHGxVR
        j5qRcmWo8TflgrufagHY3p9ynyB+zpFK2NXpwAON9w==
X-Google-Smtp-Source: ADFU+vs1QhGAxGsXaP+7WrcEgZ1EmUiOnWtYeGoQwVTQz61qNKfynJHe/yAWoh85kCDk9Fbj5S2+ZWU+ZJ7nQUwSzZU=
X-Received: by 2002:a05:6602:cf:: with SMTP id z15mr4026478ioe.13.1584452462640;
 Tue, 17 Mar 2020 06:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200211091937.29558-1-brgl@bgdev.pl> <20200211091937.29558-6-brgl@bgdev.pl>
 <CAMuHMdUc9Vwh=B5nA2tW66DwYr3AE6g2Jvd_o0W-oShDs+QQEg@mail.gmail.com>
In-Reply-To: <CAMuHMdUc9Vwh=B5nA2tW66DwYr3AE6g2Jvd_o0W-oShDs+QQEg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 17 Mar 2020 14:40:51 +0100
Message-ID: <CAMRc=MdBagbFGU--YKAN0jCVuU4Zn19YqGTz6zfP9hpEwC0-6w@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 5/7] gpiolib: provide a dedicated function for
 setting lineinfo
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 16 mar 2020 o 17:21 Geert Uytterhoeven <geert@linux-m68k.org> napisa=
=C5=82(a):
>
> Hi Bartosz,
>
> On Tue, Feb 11, 2020 at 10:21 AM Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > We'll soon be filling out the gpioline_info structure in multiple
> > places. Add a separate function that given a gpio_desc sets all relevan=
t
> > fields.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> This is now commit d2ac25798208fb85 ("gpiolib: provide a dedicated
> function for setting lineinfo") in gpio/for-next.
>
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -1147,6 +1147,60 @@ static int lineevent_create(struct gpio_device *=
gdev, void __user *ip)
> >         return ret;
> >  }
> >
> > +static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
> > +                                 struct gpioline_info *info)
> > +{
> > +       struct gpio_chip *chip =3D desc->gdev->chip;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&gpio_lock, flags);
>
> spinlock taken
>
> > +
> > +       if (desc->name) {
> > +               strncpy(info->name, desc->name, sizeof(info->name));
> > +               info->name[sizeof(info->name) - 1] =3D '\0';
> > +       } else {
> > +               info->name[0] =3D '\0';
> > +       }
> > +
> > +       if (desc->label) {
> > +               strncpy(info->consumer, desc->label, sizeof(info->consu=
mer));
> > +               info->consumer[sizeof(info->consumer) - 1] =3D '\0';
> > +       } else {
> > +               info->consumer[0] =3D '\0';
> > +       }
> > +
> > +       /*
> > +        * Userspace only need to know that the kernel is using this GP=
IO so
> > +        * it can't use it.
> > +        */
> > +       info->flags =3D 0;
> > +       if (test_bit(FLAG_REQUESTED, &desc->flags) ||
> > +           test_bit(FLAG_IS_HOGGED, &desc->flags) ||
> > +           test_bit(FLAG_USED_AS_IRQ, &desc->flags) ||
> > +           test_bit(FLAG_EXPORT, &desc->flags) ||
> > +           test_bit(FLAG_SYSFS, &desc->flags) ||
> > +           !pinctrl_gpio_can_use_line(chip->base + info->line_offset))
>
> pinctrl_gpio_can_use_line(), and pinctrl_get_device_gpio_range() called
> from it, call mutex_lock():
>
>     BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:281
>     in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 652, name: l=
sgpio
>     CPU: 1 PID: 652 Comm: lsgpio Not tainted
> 5.6.0-rc1-koelsch-00008-gd2ac25798208fb85 #755
>     Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
>     [<c020e3f0>] (unwind_backtrace) from [<c020a5b8>] (show_stack+0x10/0x=
14)
>     [<c020a5b8>] (show_stack) from [<c07d31b4>] (dump_stack+0x88/0xa8)
>     [<c07d31b4>] (dump_stack) from [<c0241318>] (___might_sleep+0xf8/0x16=
8)
>     [<c0241318>] (___might_sleep) from [<c07ec13c>] (mutex_lock+0x24/0x7c=
)
>     [<c07ec13c>] (mutex_lock) from [<c046f47c>]
> (pinctrl_get_device_gpio_range+0x1c/0xb4)
>     [<c046f47c>] (pinctrl_get_device_gpio_range) from [<c046f5e8>]
> (pinctrl_gpio_can_use_line+0x24/0x88)
>     [<c046f5e8>] (pinctrl_gpio_can_use_line) from [<c0478bd0>]
> (gpio_ioctl+0x270/0x584)
>     [<c0478bd0>] (gpio_ioctl) from [<c03194c0>] (vfs_ioctl+0x20/0x38)
>
> Reproducer is "lsgpio" with CONFIG_DEBUG_ATOMIC_SLEEP=3Dy.
>

Hi Geert,

thanks for the report. I added the locking around this code because it
seemed wrong to me that this part wasn't protected in any way before.
Now the question is how do we deal with this.

Linus: do you think it's safe to move the call to
pinctrl_gpio_can_use_line() before the spinlock is taken? I'd say yes
but I'm not sure if I'm not missing some inter-framework intricacies.

Best regards,
Bartosz Golaszewski
