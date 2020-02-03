Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772B7C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 11:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4414220658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 11:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WpgPJuW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgBCLFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:05:11 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46677 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgBCLFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 06:05:11 -0500
Received: by mail-qv1-f66.google.com with SMTP id y2so6537408qvu.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OEJ+A4YOxXmg2doai7LuIU0V5wHQ//U/Mj3H+TVAh7c=;
        b=WpgPJuW5nI3+4Rfo01VjSKn6FJqckk1o757wWJDFicvI916HMhqZyF7IBM881Jn9r3
         ZlVLnmX3QUdGQxJWOE5TUldYoB4vfnvXnFbcdZ+cy1KhVd2mKDeSWluSRjHSmvoHjgoi
         wIvQRbDI0reAW4dvZqzgw3TmFKeH/9nqnUkiu3kyP0Mzyah0qLxEkDV1rl2kjAq6pzu3
         kFKOtL2ipKcSGe5AF7JCzJ8VklLxPsMpgAs/PchKxc3yAWhY1k/KWeZgDJWWJMVal572
         mWzqhEYgl15mncWY7lzOzzTmVCnJ6Q4ZYSKp64Jvns8ygRzFqq86NzQ4BVvsidxR/tnp
         EZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OEJ+A4YOxXmg2doai7LuIU0V5wHQ//U/Mj3H+TVAh7c=;
        b=Bpg/qtEUJ9Pm5uQe0Nek3SgA/tkkm2VKR614uBv8kvb/csEinNG7vp3DqSUs2v/hFI
         dXqIqbzLEOq3hErrS/9SsRWPEf2DmVh28RZM/n6qWzyMsfuuqJehAkNdCOsNGNRJ2Miz
         jbIJpr7U5f69UiYhtQjoFgsvxMNAYojQ9um435jndK1OPGBK2+RsEkm3DFafQuMvttXS
         yimpvB/en5RiRpABLpJkIW/DlS4PVtMJYcXD0LjRauiJzV+sBG+U9525lMT3+rYz5UZ4
         Yy3R/qVAO0ttngat1ZkJ0kYuubcO5IXvv5IzMURTWYZxZQfCSWheEplZvJvtWbzI5W5G
         LVxQ==
X-Gm-Message-State: APjAAAWduJTxikL+CUba3g5vtmXZuVk2QwttDcUk/4JMdtK5b1jJ3KPt
        vEwPq6Ldr6rbvFE6UjgAjoQYV5MLAsepEbEfun58CQ==
X-Google-Smtp-Source: APXvYqy6eCOVQtmeClQ9s6Ork9hSmBPuNbq/dE8XHtgI6t13zQY19ElP+2IDJ5qdx3sh2GvUzHF40upVwXeHyLkdQJU=
X-Received: by 2002:a0c:f28f:: with SMTP id k15mr5153632qvl.76.1580727908949;
 Mon, 03 Feb 2020 03:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20191224120709.18247-1-brgl@bgdev.pl> <20191224120709.18247-3-brgl@bgdev.pl>
 <20200201195232.GA17364@roeck-us.net>
In-Reply-To: <20200201195232.GA17364@roeck-us.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 3 Feb 2020 12:04:57 +0100
Message-ID: <CAMpxmJU=wvONwure-MS9vb=0fuRgnf+wVshBQn2N=uwcZUG3Bw@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] gpiolib: have a single place of calling set_config()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 1 lut 2020 o 20:52 Guenter Roeck <linux@roeck-us.net> napisa=C5=82(a)=
:
>
> On Tue, Dec 24, 2019 at 01:06:58PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Instead of calling the gpiochip's set_config() callback directly and
> > checking its existence every time - just add a new routine that perform=
s
> > this check internally. Call it in gpio_set_config() and
> > gpiod_set_transitory(). Also call it in gpiod_set_debounce() and drop
> > the check for chip->set() as it's irrelevant to this config option.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> This patch made it into mainline, even though a regression was reported
> against it by Geert. Please note that it is not just a theoretic problem
> but _does_ indeed cause regressions.
>
> Guenter
>

Hi Guenter,

I'm sorry for this, I was still largely unavailable for the past two
weeks. I'll address it today, this time for real.

Best regards,
Bartosz Golaszewski
