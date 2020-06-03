Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57823C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F37920679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgFCHN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:13:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35642 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCHNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:13:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id z9so949470oid.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGa3GimJqdMyo7pt1z+CDB71yVCtxvTqp+1pkYHQ9gg=;
        b=VO9KqzKQrlPWhc0Zjb4SQzO7Ofm16pAca6zeX8OTzuEe8ClCkPnOJZbqW5Es+JmUKJ
         PCa4kSwUR7RXpNPsC1pJsH5EX+d9ehCtnX7Szmc2Czv5p2Qu+jjcJpx8c+AXDSa8ATuk
         kG9xhI+V/QvxlhKAY6TuUi0J8gQt1KI9X/PK2ZK/RRksAXw7rvh9GhHi1OpMh68T9Syq
         DTyspX3EaqkNeq1AHF0pLInTRiIdepAHKcimYJgTdFL8cevpY+hW8ZuxuyZB3fv7h3yU
         IfxAiMzOsGfGkx4ZoYcrN4nzQzh5YoqAJmXcQGrrDWPHqjYIpkS4XIRFf/I933HPHR7N
         8Hyg==
X-Gm-Message-State: AOAM533CqtDPOyzw0kwIudUdt+iaKoiQ2cKCnm/Zyw35EjYhZPmmDAgy
        4lo2/LQ37jZg4jvlez3LfAhon0OqpdPMGWwmg5s=
X-Google-Smtp-Source: ABdhPJyl1ufW647ao1P8Oi1gVdgZ2EmdYk3LQkIa+sE8qaOJTN+lUUu7CzL2al802ksJm1JKQofI+rkp2gfKc/yI4+A=
X-Received: by 2002:aca:644:: with SMTP id 65mr5146855oig.148.1591168403696;
 Wed, 03 Jun 2020 00:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200603064509.32736-1-hpeter+linux_kernel@gmail.com>
In-Reply-To: <20200603064509.32736-1-hpeter+linux_kernel@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Jun 2020 09:13:12 +0200
Message-ID: <CAMuHMdV3sNojXqaxLmVjK3ziGugd3cWEKfLXikDwvaOmocTCzQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] driver core: Fix unbalance probe_count in really_probe()
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, peter_hong@fintek.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ji-Ze,

On Wed, Jun 3, 2020 at 8:45 AM Ji-Ze Hong (Peter Hong) <hpeter@gmail.com> wrote:
> In previous patch, using return -EBUSY in really_probe() instead WARN_ON()
> only. The following is the partial code.
>
>         ...
>         atomic_inc(&probe_count);
>         pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
>                  drv->bus->name, __func__, drv->name, dev_name(dev));
>         if (!list_empty(&dev->devres_head)) {
>                 dev_crit(dev, "Resources present before probing\n");
>                 return -EBUSY;
>         }
>         ...
>
> When the devres_head is not empty, this code will return -EBUSY to prevent
> resource conflict, but it forgot to balance probe_count. We can move the
> increasement code below the resource checking.
>
>         ...
>         pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
>                  drv->bus->name, __func__, drv->name, dev_name(dev));
>         if (!list_empty(&dev->devres_head)) {
>                 dev_crit(dev, "Resources present before probing\n");
>                 return -EBUSY;
>         }
>         atomic_inc(&probe_count);

If devres_head is not empty, you have a serious problem on your system,
as those resources may be in an unknown state (e.g. freed but still in
use).  While I had missed the probe_count imbalance when implementing
the original change, it may actually be safer to not decrease
probe_count, to prevent further probes from happening.  But I guess it
doesn't matter: if you get here, your system is in a bad state anyway.

> The original code will cause lots motherboard freeze in reboot/shutdown
> with systemd message "Reached target Reboot" or "Reached target Shutdown"
> with serial8250 platform driver. e.g. AOPEN DE6200. The conflict boot
> dmesg below:
>
>         Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
>         00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 921600) is a 16550A
>         00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 921600) is a 16550A
>         00:05: ttyS2 at I/O 0x3e8 (irq = 5, base_baud = 921600) is a 16550A
>         serial8250: ttyS3 at I/O 0x2e8 (irq = 3, base_baud = 921600) is a 16550A
>
> Reboot/Shutdown will freeze in wait_for_device_probe(), message as
> following:
>         INFQ: task systemd-shutdown: 1 blocked for more than 120 seconds.

Now, how did you get to this state, i.e. which driver triggered the
"Resources present before probing" message? Because that is the root
issue that must be fixed, and the probe_count imbalance is IMHO just a
red herring.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
