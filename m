Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA225C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 15:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22C52074D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 15:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBkiPWIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgE3PuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 11:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3PuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 11:50:21 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D7AC03E969;
        Sat, 30 May 2020 08:50:21 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y17so656010plb.8;
        Sat, 30 May 2020 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDCsTQpWPitvdwJnXQIV8RJ+VsnpUj4hyJpR9vLy1Ss=;
        b=DBkiPWIkEDXKBJ+3ZXm8gYEx/7FraY+6qNFbUAFoT6MTZMOVHreJQjQ9EtTMCcjkQK
         O0rH8Q0qbkzH+MY6Er1JAT7PVbasSfVD68kNd6Bgsq/kHjO9oUUUpR2xvqEpROe0cy/G
         kTsGx83EJeBYrg9CZ8woiCo9qNDpvGmhS86pZZ38IiWjA6DlnvPVjwJPT1VBmj/e5gwP
         hTzQkk5yYUO5f+iEv0nlEXPhd+R4CWxztedrp59SPlj+yAJ1RUuylX8z6gLOC4q6ot9q
         UB+MHRwwyxcU+2CM9YKXSC6vo/ZNbkOtxIp3Jj0AoFlzeCrZa/trINS/erQGoCLhsDPF
         02kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDCsTQpWPitvdwJnXQIV8RJ+VsnpUj4hyJpR9vLy1Ss=;
        b=O5RDETACxIBtWwghOpxbysbl9rOLF8w4n0hhRjphulykxL6kTpLJ4Sg8Irsi78/nIy
         63UOEhL3ybANhVN/ThH4mgjxWk1BC4uAqkCKiWKlBBdFq7c6JTZghwY8Ihkjl7836skM
         NNSMpLLBbZOGzNvwC19PhCcUrEoY/8wyn5HYxEu4FNoi8Qqwsvz0FEK7XJ4s/jETYOZi
         Cj//FEgZjJ0tVZ7+sLOHslRs64Rzv7jfrROrCIiNpUR/P9EhTqdYoFwnff6LWv8cj/8t
         wEAldsYWpjA6vVPAypWJOhCk71Ti0yVgvhIlEkph+34pDTm1QE344X+JoXsYn0zx4Upt
         NLiQ==
X-Gm-Message-State: AOAM531y/gXc5Ek7PloU+x0GAh15zZNYnfNooN1xskW3Pas82aGXDzR3
        wN0tjhzK1fQTE52sgUIBqqYI8wUjT8tcUFnStXpzodSHwcc=
X-Google-Smtp-Source: ABdhPJyqSvsxh/IPYE/gaWy5DzfcJqpY6eGMFUFy/ystb+c0RQB48eBHuuES6Kd1i1lFnVL8vbqzQcOrDBqAO9qGIA0=
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr13781238plt.18.1590853821065;
 Sat, 30 May 2020 08:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200509130707.219463-1-hdegoede@redhat.com>
In-Reply-To: <20200509130707.219463-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 May 2020 18:50:09 +0300
Message-ID: <CAHp75Veq65-xV1k3OODjQamLYJsztHT1fyCSDgm9JMGu7Qha9A@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Add new intel_atomisp2_led driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 4:07 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Many Bay Trail and Cherry Trail devices come with a camera attached to
> Intel's Image Signal Processor. Linux currently does not have a driver for
> these, so they do not work as a camera.
>
> Some of these camera's have a status LED which is controlled through a GPIO
> in some cases, e.g. on the Asus T100TA and Asus T200TA, there is a firmware
> issue where the LED gets turned on at boot.
>
> This commit adds a Linux LED driver for the camera LED on these devices.
> This driver will turn the LED off at boot and also allows controlling the
> LED (so the user can repurpose it) through the sysfs LED interface.
>
> Which GPIO is attached to the LED is usually not described in the ACPI
> tables, so this driver contains per-system info about the GPIO inside the
> driver. This means that this driver only works on systems the driver knows
> about.

> +static int __init atomisp2_led_init(void)
> +{
> +       const struct dmi_system_id *system;
> +
> +       system = dmi_first_match(atomisp2_led_systems);
> +       if (!system)
> +               return -ENODEV;
> +
> +       gpio_lookup = system->driver_data;
> +       gpiod_add_lookup_table(gpio_lookup);
> +
> +       pdev = platform_device_register_resndata(NULL,
> +                                                DEV_NAME, PLATFORM_DEVID_NONE,
> +                                                NULL, 0, &atomisp2_leds_pdata,
> +                                                sizeof(atomisp2_leds_pdata));
> +       if (IS_ERR(pdev)) {
> +               gpiod_remove_lookup_table(gpio_lookup);

> +               return PTR_ERR(pdev);
> +       }
> +
> +       return 0;

return PTR_ERR_OR_ZERO(...);

> +}

-- 
With Best Regards,
Andy Shevchenko
