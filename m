Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E710C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5AB20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T1IpLJ34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389713AbgF2UoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731547AbgF2TOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:00 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD76AC02E2F1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:26:55 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so15350626qkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9h6iUTLSlaM8ZKedUbrDjAeuBkCXn2xjNjPFH6ekn4=;
        b=T1IpLJ344rgGaAa+SleIJFka/PpqQpfHOmwwxhlqA4Suwr5L752jeOu5N30x6rcKz8
         KF20wG2FJZQGA4AztiZaX4TzOwDhVPTEKfW0sOaPHxxZXhHWKs5AlLiSCTAg8sFusRgp
         PeZguF1j71pS4edUg3CM/8vlS2RLY3+JL23breZejkSX4dCEFuIuecM+9Zp34UrFAdZY
         GWzcWmJsDujFB78JLRZS4i3yxZ8gc8y9UibuKmXikPPbfHYvTNqIpHPz2Vvto1L1wdFI
         4Ri5cK36BuL8D113uj2oCGfqYuOBE5J0COAuRf5g6TIXA+LImkTnIQvPIvdfMRToNHqS
         ivpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9h6iUTLSlaM8ZKedUbrDjAeuBkCXn2xjNjPFH6ekn4=;
        b=Zm6cBiMtLukqlfBz+W4ASGk/HwQhei84uJ3Ekrcg+sNXcvekwftMcHXAN8vAsLmH4N
         qAKvIWd9kuigXIhG+JWCZJFttOJUXgR4aqIH5M+GeTie4VqvTPNiZMwv4TaCqytR5baz
         PswOPAPMCKMXImBFxX2fFJhUMhR2NZfRJw+3ommyiC8f6CtoM4RvpB8ruFMvWhgAi7Ip
         /G/sf7YIG4FGkXJwsmkVaX82f3WhWy95AuVM4gtapyAHC3ylRMRW2VoY/nXePLKM/9Fr
         XH5kiKHQkPHBJhMjS6DsGVwV2R+SzB6fJH4MztGKQx6UzZXy0XGnLWAwnJc4uuTnOXFy
         A/Gg==
X-Gm-Message-State: AOAM5309Nbexwm5FIOjD0VqOYcVaOal8Px3f5aqQT+fENL9IpDyHpLfR
        kNLx3YCXTiQIF751oPHiFFkqEBTLIHwdDCsjZTtxewavkB8=
X-Google-Smtp-Source: ABdhPJzADHgjRYun7EFvcNevrS1w88lT8h+z8+W9iN0INfkGcrVrm59SoEI2bpu5gUwfXvpzn98HJaI1jOgo7YMD9Lc=
X-Received: by 2002:a37:9c81:: with SMTP id f123mr14194552qke.21.1593440814965;
 Mon, 29 Jun 2020 07:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200623040107.22270-1-warthog618@gmail.com> <20200623040107.22270-16-warthog618@gmail.com>
In-Reply-To: <20200623040107.22270-16-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 29 Jun 2020 16:26:44 +0200
Message-ID: <CAMpxmJWoXWk4t08gM8ieMrMSgYPNODjt6Jx3k_L+a9X00891sQ@mail.gmail.com>
Subject: Re: [PATCH 15/22] gpiolib: add build option for CDEV V1 ABI
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 6:03 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Add a build option to allow the removal of the CDEV v1 ABI.
>
> Suggested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>
> ---
>
> This patch is before the V2 implementation, and is non-functional until
> that patch, as some parts of that patch would be written slightly
> differently if removing V1 was not considered.
> Adding this patch after that would necessitate revisiting the V2 changes,
> so this ordering results in two simpler patches.
>
>  drivers/gpio/Kconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index affc1524bc2c..b966a7dc1c9a 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -81,6 +81,18 @@ config GPIO_CDEV
>
>           If unsure, say Y.
>
> +config GPIO_CDEV_V1
> +       bool "Support GPIO ABI Version 1"
> +       default y
> +       depends on GPIO_CDEV
> +       help
> +         Say Y here to support version 1 of the GPIO CDEV ABI.
> +
> +         This ABI version is deprecated and will be removed in the future.
> +         Please use the latest ABI for new developments.
> +
> +         If unsure, say Y.
> +
>  config GPIO_GENERIC
>         depends on HAS_IOMEM # Only for IOMEM drivers
>         tristate
> --
> 2.27.0
>

As long as the series remains bisectable:

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
