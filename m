Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D863C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0E320874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYUBx2ND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgGBMgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgGBMgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:36:49 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771E5C08C5C1;
        Thu,  2 Jul 2020 05:36:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u8so12093590pje.4;
        Thu, 02 Jul 2020 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70KIJZ33aGI+UMaCpiknKdXzvORTFf4NfJOKWe9rZQo=;
        b=aYUBx2NDjD3DbNNBJbMZAT3GU8EdHoGW4ulTq3hZWT3U5O8crdVSE9d5s9CaAik1I/
         HPakXsDnaeV85PwAwbmzb03qsHuQA4zoFE8gagv8dSwze6/HnUuqG2KEcpS6GXGIEjsx
         vnQ/vMoTRyL1rl9/WuSGz/SwnRgpoeBh1rkNuXT6t2YQZgJySXyufXpO1Bt6XL3eztgu
         IahgUaShxMUuJrZq8ReNN/kftpOVQdHqtSmUpmWQlClFaatr15hgpkJu7MlrN53xpCO6
         bVW7V1pKqkG5PsF1t5W2VyAVEHieX70QLI9tb0S6v0Z8udodKmRVjtXb2PShE/i1VUFS
         yBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70KIJZ33aGI+UMaCpiknKdXzvORTFf4NfJOKWe9rZQo=;
        b=jwEslo0qWCtwnzWIHNIlT2MkAbyflSeE0fikg1HWtOUFtuD0VArtPhPnavBUR6qUrU
         7MxuCDgyV9KHOVsIlQ1lC020u2eE58aT+yN/dj9fYqb1ub7DZO1MwAOnb+CIUzStNPZp
         Xbz9agb16X6ZABwdWgBFJT4YreiYHBMBu8FbEQQ/X4QsZBuyJKZOtK0ftw/cL2UZj0zt
         Y+XkL9eCydqzfKw/gbtP9cRq9QrfdyTSXt5KcUwTBlIBgaASPFO9fMurWCovlqNfzWEt
         358taC4hKJzjSbfJFF29alWUzBj/sTtplRvk8hBikeqbQa03nWc/CB0eJ3ZzLElo/r89
         VrXA==
X-Gm-Message-State: AOAM532fzHLXpbcMShswbhN/cDJHBjGgjNQZVjximci4OMEY1ShS24Oc
        y/stDbf7LicFFEp2LRY13/VFN5xjDmYfueC/DIrUVvZk
X-Google-Smtp-Source: ABdhPJy8HHhtSGM6T/cs0JiJcz2Vn42c32KKtBwllFR5lqyGp0yAfYakRj74vN96iGB5hiN90hGYV/BSbRX/imPhxQg=
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr28038158pjb.129.1593693408863;
 Thu, 02 Jul 2020 05:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200702121722.1121468-1-mans0n@gorani.run>
In-Reply-To: <20200702121722.1121468-1-mans0n@gorani.run>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Jul 2020 15:36:32 +0300
Message-ID: <CAHp75VdSWxcAQzWryKoMfzh8xM_2ZRF6Uk+8pveGhmt=prOAVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: add GPO driver for PCA9570
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michael Walle <michael@walle.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 3:18 PM Sungbo Eo <mans0n@gorani.run> wrote:
>
> NXP PCA9570 is 4-bit I2C GPO expander without interrupt functionality.

is a 4-bit

> Its ports are controlled only by a data byte without register address.
>
> As there is no other driver similar enough to be adapted for it, a new
> driver is introduced here.

Can we have a Datasheet: tag with URL attached to it?

...

> +static int pca9570_read(struct pca9570 *gpio, u8 *value)
> +{
> +       s32 ret;
> +
> +       ret = i2c_smbus_read_byte(gpio->client);
> +       if (ret < 0)
> +               return ret;
> +

> +       *value = (u8)ret;

I doubt casting is needed.

> +       return 0;
> +}

...

> +static const struct i2c_device_id pca9570_id_table[] = {
> +       { "pca9570", 4 },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, pca9570_id_table);
> +
> +static const struct of_device_id pca9570_of_match_table[] = {

> +       { .compatible = "nxp,pca9570" },

This driver data should also have 4.

> +       { /* sentinel */ }
> +};

...

> +       gpio->chip.ngpio = i2c_match_id(pca9570_id_table, client)->driver_data;

Oh, avoid direct access to the table like this. And you may simply use
device_get_match_data().
...

> +       /* Read the current output level */
> +       (void) pca9570_read(gpio, &gpio->out);

(void) casting is not needed. And I'm not sure hiding an error is a
good idea. But the latter is up to you.

-- 
With Best Regards,
Andy Shevchenko
