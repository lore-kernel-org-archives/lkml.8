Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8C3C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 06:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05EA9206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 06:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bj+UISFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgAKG2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 01:28:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46850 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgAKG2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 01:28:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id m26so4368844ljc.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 22:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8iu5ym5sr3AOgcd1wcHEoi/idPhE3U2NroKtHu8vm/g=;
        b=Bj+UISFu5njRYCt1RyXQyZmlWNkNCjDiuwYAQlgwfZu18jQagW3WmpqVsOHJdXAEZY
         KRmfUmm7fj4Hb7TJtBdsQIbazZz+KstWG32EwRw4ro3e3Ej8NXdvz27rYmz9kyD5Hdgz
         Dzan+zz3mHW6k/opp7CpPbGEUbjfON7KAmJiTNq14QR64ERPn806T8OqdoaBTF4FWGL0
         7rRACcr8nbbvhWbVb9zRedrImZqt8bdR8WEPleBadXdNNjK9NZdVmFXupefqehL1v8EC
         4WQ15ka23Dt3G5lGca5fKo2Sk/E90urqtJ5fHElZbmJ5cTRFbX/r+XGFc5iprk1+EdwI
         kDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8iu5ym5sr3AOgcd1wcHEoi/idPhE3U2NroKtHu8vm/g=;
        b=FmbZhGJaArEFIG/5yATDjJ+C2ZQHgmaMIRdDUml6QDk50fmyXz4EpR0MP+S80H1F5y
         X8NmSDf45Xwtn0pYN8NuktWBPZZ1WMYtBkKEDEr24/LYToiNHpaGXLVnO54onab8nfdw
         rGahSH4EVgg5nJcoCMNRV7mEehX/i+8dkeVfw7pNLFLVpz1ic5Mu4P/W9qrN6AAHJqwF
         t9P5G5Xv6onHfC+h00lRs5yG3rXz/tR3dHr5BFNzHQBawM/mHBAd8Fsi+znGwDlmOnZ8
         YSp7NFCnE8o05NJLqSV2o9OcjrOqAiH6v0PYCO9ZH2blwlrulHJTKnlGhqt7oOaZNHlG
         yUzw==
X-Gm-Message-State: APjAAAVEaB+zcjcpvloOUoXAiDu/ElaIeQfoey0568Q/2H70WySo8OOK
        YNDQiceK4atamK3IdpyzpGF0CDKkJz9ruApcU96csQ==
X-Google-Smtp-Source: APXvYqwnzVhFzOxc2Xax5HKLnQAPb6f7KI8aJHzuxybDifjnyToU9z+4jMk2cz2QtnzOyUVfchd6w00e5aAA7C0cafY=
X-Received: by 2002:a2e:3504:: with SMTP id z4mr2722195ljz.273.1578724113269;
 Fri, 10 Jan 2020 22:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20200106203700.21009-1-tony@atomide.com>
In-Reply-To: <20200106203700.21009-1-tony@atomide.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 11 Jan 2020 11:58:22 +0530
Message-ID: <CA+G9fYvRNiFK54oiGt9hYP=RTfazf2E7rmnnkwP+ELMUYtJ7bQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource: timer-ti-dm: Fix regression
To:     Tony Lindgren <tony@atomide.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 at 02:07, Tony Lindgren <tony@atomide.com> wrote:
>
> Clean-up commit 8c82723414d5 ("clocksource/drivers/timer-ti-dm: Switch to
> platform_get_irq") caused a regression where we now try to access
> uninitialized data for timer:
>
> drivers/clocksource/timer-ti-dm.c: In function 'omap_dm_timer_probe':
> drivers/clocksource/timer-ti-dm.c:798:13: warning: 'timer' may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>
> On boot we now get:
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000004
> ...
> (omap_dm_timer_probe) from [<c061ac7c>] (platform_drv_probe+0x48/0x98)
> (platform_drv_probe) from [<c0618c04>] (really_probe+0x1dc/0x348)
> (really_probe) from [<c0618ef4>] (driver_probe_device+0x5c/0x160)
>
> Let's fix the issue by moving platform_get_irq to happen after timer has
> been allocated.
>
> Fixes: 8c82723414d5 ("clocksource/drivers/timer-ti-dm: Switch to platform_get_irq")

Thanks for fixing this issue.
I have noticed arm BeagleBoard-X15 boot failed on linux next tree
(5.5.0-rc5-next-20200110).

[    6.157822] 8<--- cut here ---
[    6.160911] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
[    6.169120] pgd = 25d83e32
[    6.171903] [00000004] *pgd=80000080204003, *pmd=00000000
[    6.177358] Internal error: Oops: a06 [#1] SMP ARM
[    6.182179] Modules linked in:
[    6.185260] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.5.0-rc5-next-20200110 #1
[    6.192694] Hardware name: Generic DRA74X (Flattened Device Tree)
[    6.198832] PC is at omap_dm_timer_probe+0x48/0x310

- Naresh
