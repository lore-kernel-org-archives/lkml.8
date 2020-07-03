Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745C7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4772B20772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WVAhV7ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgGCLja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGCLj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:39:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC81EC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 04:39:28 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so29427459eje.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pGISnOur8oLWYv7+8TQITcaX7jATXPB+L5kiXZAigBU=;
        b=WVAhV7ne7BUhACGeZniNHuofHwv1e3uzACAq19G6TvyM8UzQQ3aPIFlOvX8hBANhqW
         kfujOOTPzKDBiNQevPORCLkAIvXlp2J91jU57dz8k9o80ATdgl4x2yjW9Fb2AodKgHaV
         HH8Ta+IX+dWCZqnBa1JW1YqffWlmOn/haYYTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pGISnOur8oLWYv7+8TQITcaX7jATXPB+L5kiXZAigBU=;
        b=qCpXhfbRQbhaqE09QjASNy6op67T9KkPLxE+MzKb0n5/iGCxhIv2K5rl2Q1Talh4uE
         I85JPBg4rZZFAqvp9I5suSKfUo4rRsmvLTFWxsXZDCr/7cfvE+hdQO1FOz747ic6AedE
         RAGDUwi3FuhSP9w4v1UirZOAC4McHVyAjmGlgWQN94E52V+GsQRnW/wOJ+On/J07kiKb
         fL0iLBWXNli7IWGZxFNHfZyzRvE3ZLgPiWQ16Epn8uHX4gmnXHEhy0Fw+qCABqFcQCkB
         Mo4RlaxSpiWIPlRPxxBhh5XkDmKqU53SvXXY7fnreHYFulpGQNHCQrOwFWygrSgyZtLN
         lbPQ==
X-Gm-Message-State: AOAM532JYOxSe2RSryJnZE6XRc4267xe5vJ2qk0XUkRU9w1eGqbEfx7d
        K79rRu9D8G1YV5137osKT3MeqjI6FVy/YbSizYNg2A==
X-Google-Smtp-Source: ABdhPJyNW3XMaAsmg+77KG3u0lZnz7EtGHkCDGxC54EevC5Q5fuKD2cd0qG4HzFGeIbC5k5ygQW2K3Lijlm0Dym68OY=
X-Received: by 2002:a17:906:2b12:: with SMTP id a18mr31303665ejg.186.1593776367452;
 Fri, 03 Jul 2020 04:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200702090504.36670-1-jagan@amarulasolutions.com> <f0ae5915-9cb8-9550-f05c-6cebad191a14@arm.com>
In-Reply-To: <f0ae5915-9cb8-9550-f05c-6cebad191a14@arm.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 3 Jul 2020 17:09:15 +0530
Message-ID: <CAMty3ZBBdYdNOf-nQTdKZfi-VagaML6k+4PkAh6Uz936h9auow@mail.gmail.com>
Subject: Re: [PATCH] usb: host: ohci-platform: Disable ohci for rk3288
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@collabora.com>,
        linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        William Wu <william.wu@rock-chips.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Kever Yang <kever.yang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 8:08 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-07-02 10:05, Jagan Teki wrote:
> > rk3288 has usb host0 ohci controller but doesn't actually work
> > on real hardware but it works with new revision chip rk3288w.
> >
> > So, disable ohci for rk3288.
> >
> > For rk3288w chips the compatible update code is handled by bootloader.
> >
> > Cc: William Wu <william.wu@rock-chips.com>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Note:
> > - U-Boot patch for compatible update
> > https://patchwork.ozlabs.org/project/uboot/patch/20200702084820.35942-1-jagan@amarulasolutions.com/
> >
> >   drivers/usb/host/ohci-platform.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> > index 7addfc2cbadc..24655ed6a7e0 100644
> > --- a/drivers/usb/host/ohci-platform.c
> > +++ b/drivers/usb/host/ohci-platform.c
> > @@ -96,7 +96,7 @@ static int ohci_platform_probe(struct platform_device *dev)
> >       struct ohci_hcd *ohci;
> >       int err, irq, clk = 0;
> >
> > -     if (usb_disabled())
> > +     if (usb_disabled() || of_machine_is_compatible("rockchip,rk3288"))
>
> This seems unnecessary to me - if we've even started probing a driver
> for a broken piece of hardware to the point that we need magic checks to
> bail out again, then something is already fundamentally wrong.
>
> Old boards only sold with the original SoC variant have no reason to
> enable the OHCI (since it never worked originally), thus will never
> execute this check.
>
> New boards designed around the W variant to make use of the OHCI can
> freely enable it either way.
>
> The only relative-edge-case where it might matter is older board designs
> still in production which have shipped with both SoC variants. Enabling
> OHCI can't be *necessary* given that it's still broken on a lot of
> deployed boards, so at best it must be an opportunistic nice-to-have.
> Since we're already having to rely on the bootloader to patch up the
> devicetree for other low-level differences in this case, it should be
> part of that responsibility for it to only enable the OHCI on the
> appropriate SoC variant too. Statically enabling it in the DTS for a
> board where it may well not work is just bad.

You mean enable OHCI by identifying revision W with dts status "okay"?
doesn't it complex for the bootloader to update all effecting changes?

Jagan.
