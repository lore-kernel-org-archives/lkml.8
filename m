Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4290C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949FE20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kEdFbISx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgE0NUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgE0NUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:20:33 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41116C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:20:32 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id z9so11065232qvi.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KV6zG4cB1TmvCG+onKER+oAfw/b83fhJrAY9mKJ4IX4=;
        b=kEdFbISxbLAlPlOnpWxFL041LUl3yybQwYa8/qJu8zfW/RMBvv95nieJdalNvuqmtB
         K4B0VQ2ac6lOYqbG4+P6tmbToSbSkL7l9znId/SY95HKrXBqJpgDPugxuBh8pe+/wQS7
         pCn3ui+rJ6v+DN2mtdfnKC+nAF4JwecNz+rs8jn+99lAOp7IolN0Uhqq4iwJI3jo+Hq/
         70lMSRPSD1jkjdpOj1cGufOdYPb/aHCnki+YR9qxBO25C1wxrxx/s9OvzSCss6CDtXpC
         p1vgiPDXuzT3T5ZwbeFR/u93j1s7Ltjc8VV1IN2eJe4weXd26qlRF06/2OsXIRFMh8oq
         V2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KV6zG4cB1TmvCG+onKER+oAfw/b83fhJrAY9mKJ4IX4=;
        b=JR1btOUq8cjAPpg9OBrExVqN1XPVbpjF69mu9Qt9FF5X1NscUOuZhY7iez+nBQuUH/
         op401dlhLJ5UXeJMttUsEpo8zMM+yHGSNfK6TTJ20jMmOnLO5IIhVQHmtXSvJUB+sbp/
         57kx6JGeCce1Vac73dJKA128ZD0lUHXcUlzndjy6xRRgiOMOBtuhjjYXHHrWVAXAZmWt
         q8OqyFf0wnh4FNGPexnStTzJNBUF02nIgneKtWt/b8Ve69PPYkA9T9+ody0wPK7+aXMD
         tNsyCqtDNSRxiSgBnNZq8lhtlG4PEiSSInZpvgIx3TfaSrvWnWLp/kdghxccOT37w2KT
         CPdg==
X-Gm-Message-State: AOAM531DdLU7JHtBrQuK0eJUiz5mq9xcpVP8/Z7pwns9DJ/PVKlg9lxP
        Fxz8gB1kF1LeDwuYdWNsAFT5rzNqI5eTinVbZvn2zw==
X-Google-Smtp-Source: ABdhPJwzRARN9Q565WylyoA/xCwjE11ERR6pKR3YXwMYcP6ODWIn8ti89n4ijMHzSLO3YJHosprJQlXHqGPNYlMg6IE=
X-Received: by 2002:a05:6214:1506:: with SMTP id e6mr25590948qvy.61.1590585631524;
 Wed, 27 May 2020 06:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200525160741.21729-1-michael@walle.cc>
In-Reply-To: <20200525160741.21729-1-michael@walle.cc>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 27 May 2020 15:20:20 +0200
Message-ID: <CAMpxmJUMqYxodT8Y_VOkizZ5bTjkQT2i8o9yw9p=BYn-8j0R=g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] gpio: generic regmap implementation
To:     Michael Walle <michael@walle.cc>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 25 maj 2020 o 18:07 Michael Walle <michael@walle.cc> napisa=C5=82(a):
>
> This series is a split off of the sl28cpld series:
> https://lore.kernel.org/linux-gpio/20200423174543.17161-1-michael@walle.c=
c/
>
> I wasn't sure if I should also include the gpiochip_irqchip_add_domain()
> patch here. So feel free to skip it. OTOH if you use interrupts with
> gpio-regmap it is quite handy.
>
> For an actual user see the patch 11/16 ("gpio: add support for the sl28cp=
ld
> GPIO controller") of the series above.
>
> Changes since v3:
>  - set reg_dat_base, that was actually broken
>  - fix typo
>  - fix swapped reg_in_dir/reg_out_dir documentation
>  - use "goto err" in error path in gpio_regmap_register()
>
> Changes since v2:
>  See changelog in the former patch series.
>
> Michael Walle (2):
>   gpiolib: Introduce gpiochip_irqchip_add_domain()
>   gpio: add a reusable generic gpio_chip using regmap
>
>  drivers/gpio/Kconfig        |   4 +
>  drivers/gpio/Makefile       |   1 +
>  drivers/gpio/gpio-regmap.c  | 343 ++++++++++++++++++++++++++++++++++++
>  drivers/gpio/gpiolib.c      |  20 +++
>  include/linux/gpio-regmap.h |  69 ++++++++
>  include/linux/gpio/driver.h |   3 +
>  6 files changed, 440 insertions(+)
>  create mode 100644 drivers/gpio/gpio-regmap.c
>  create mode 100644 include/linux/gpio-regmap.h
>
> --
> 2.20.1
>

Both patches look good to me. I'd say we should apply them now and
then fix any potential problems during the v5.8 release cycle. It's
not like it's a user-space facing, stable interface, we don't have to
be super careful when merging this kind of stuff.

Bart
