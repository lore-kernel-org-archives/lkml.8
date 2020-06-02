Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA4EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D279E206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFBIBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:01:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38335 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFBIBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:01:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id c194so6489217oig.5;
        Tue, 02 Jun 2020 01:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IfSJUGMUIJAtGs8xJoJu4pTdTbFJQFKUBexygvbCqHg=;
        b=XWHzmLV+RSiXPsD5jIFOXAGesdvU8woN5K6/qPDKtPlgFS9FWAMkM642GXU/Vji0d2
         sa8FDxB7kqSzUOdpGQHhyqoKRDWQNWfdKpsbHAqozbCpPrMD8M1nAMKHF2DLgCc2Oj2/
         sb0e3NRj6O3g8tAOEDY7pc4rRKdZpQgtR2IuzBFudUYb4/cKtRNClYRv7r5IbmohqQRL
         RmzjHvu5zCNUj9YeZHqa6RVK3NcSxw6H54JzKNver+svnBQKXQoD1sV7+k5MQFFMOtjE
         X7s5DRGIEStGmpYD3kBE11KFC5y6oJgApwrIktbJiJzIKx8oTXDf6TCEJKmbPkIICgMl
         bu7Q==
X-Gm-Message-State: AOAM5338k2mFdJAgJOtmLw+cE9Al9Z8dIHeRAG/qyFUBYqDXNLPcuHUs
        UYEYKfN6Q3Sa7kLz5bU4etlhpeb9EyrUWk+rjYc=
X-Google-Smtp-Source: ABdhPJwb8BmTldt5m5AYubbdo+hXPl3C08b2x1LMrx0PEc+//VCAdNVfqghwFbA59666yoA0DLKW3xFc5Rq/3ZSezD8=
X-Received: by 2002:aca:210a:: with SMTP id 10mr2050315oiz.153.1591084912412;
 Tue, 02 Jun 2020 01:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200331052850.5419-1-yuechao.zhao@advantech.com.cn>
In-Reply-To: <20200331052850.5419-1-yuechao.zhao@advantech.com.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Jun 2020 10:01:41 +0200
Message-ID: <CAMuHMdUesEMsWH55Tfe+eru8iVpgWbKPnL-wgRakG9BEpP4Y1g@mail.gmail.com>
Subject: Re: [v4,1/1] hwmon: (nct7904) Add watchdog function
To:     yuechao.zhao@advantech.com.cn
Cc:     345351830@qq.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amy.shih@advantech.com.tw, oakley.ding@advantech.com.tw,
        jia.sui@advantech.com.cn, shengkui.leng@advantech.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuechao,

On Tue, Mar 31, 2020 at 7:30 AM <yuechao.zhao@advantech.com.cn> wrote:
> From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
>
> implement watchdong functionality into the "hwmon/nct7904.c"
>
> Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>

Thanks for your patch, which is now commit 77849a552d142ef5 ("hwmon:
(nct7904) Add watchdog function").

> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1340,10 +1340,12 @@ config SENSORS_NCT7802
>
>  config SENSORS_NCT7904
>         tristate "Nuvoton NCT7904"
> -       depends on I2C
> +       depends on I2C && WATCHDOG
> +       select WATCHDOG_CORE

This makes the driver unselectable if WATCHDOG is not set.

Is there a use case for using this driver without watchdog functionality?
If yes, it might make sense to make the watchdog support optional,
protected by #ifdef CONFIG_WATCHDOG, and change the above to

    depends on I2C
    select WATCHDOG_CORE if WATCHDOG

If no, please ignore my email.

>         help
>           If you say yes here you get support for the Nuvoton NCT7904
> -         hardware monitoring chip, including manual fan speed control.
> +         hardware monitoring chip, including manual fan speed control
> +         and support for the integrated watchdog.
>
>           This driver can also be built as a module. If so, the module
>           will be called nct7904.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
