Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75221C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424D720771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7Podd+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgGPIbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGPIbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:31:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7306C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:31:46 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id r19so6113136ljn.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBdBkCZyYrnro0mG4wNU/SXS3tLA8FxNGX+obuNgjH8=;
        b=p7Podd+vPOqWJxeSsTXewwQJ0pYEiECsXkQ0W0tTlg1WtzqovoD0lIeXALNMQTneJY
         604+6fxhst8qRgbo6s1Hc639xjJUdtyMKoUX8PB/9JIopac0hBV6FjHPtNjovabGggjt
         AJ0s2M0cDTK0UZd1ZlVIE0BGTo0u9MiP2b46VswczuwB4MpvS5ARlyQBeZ6qR7xQbDdu
         1mO9Njf1lroyNzg122nkwu11lYwHrYVuQlW/fstTtq1jzzIvlsO4FhjhybmXpfwr+Spw
         DujOXbXHRH5cxw0nStYzF9/MswhlsqF6ivYvZNDaVDiuMBZ/UYdklChcy8oaXeOa2QOS
         gHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBdBkCZyYrnro0mG4wNU/SXS3tLA8FxNGX+obuNgjH8=;
        b=HiB9ZB8Wklt0YkCPO48m62OnalJeIp7E/jbcXop4doQtA6pNvN5VVxdHXAiai86JDB
         ajJ2QIm+vUT5XUZkGUJHUq4ScHLqwGdZaOdaEOTgl0LNEKCZcIPwngisMa4MZUtI77hI
         clKPSfmmmqW/u585U9c6/OMh0cR76KlRaJOMsHYABX0LUiyS0Mkz3AqlmpfSFu1gDdGN
         a5KCAhXM+JtLTPGkxl/D12URdUq6QBMve663UDza9HRAAQ2BI+HDEkRBPjdBOO9FuZeX
         Uqfll64sHBuoLhI4grJpJwK1ywYPTfKhtC+vs5yQOz52i4pJBPFyLwKlhjfUEO0yuhti
         r8oQ==
X-Gm-Message-State: AOAM5307+82d0M06iIUKPBaqKzd9nTSREcO9otV2tAPcCiYmBakJF5jy
        20FfVEBF4YIamfHlOjFiE5AfEWpGiUEU9OzYeSAdr53eteQ=
X-Google-Smtp-Source: ABdhPJy4xVhgi7qV+wdCvfTxXW1sKMtMQ2SQtdo9WMbH1aOpTecfj5o/jZrVXV9VwVBxb/zyeN1VEJor6pJwOtfXLxk=
X-Received: by 2002:a05:651c:1291:: with SMTP id 17mr1581632ljc.286.1594888305338;
 Thu, 16 Jul 2020 01:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200701030039.2834418-1-joel@jms.id.au>
In-Reply-To: <20200701030039.2834418-1-joel@jms.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 10:31:34 +0200
Message-ID: <CACRpkdY_3HHfC1uDHVfnD529o5Wpa7msZU+YMomnpUS6qJjx4g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Improve debug output
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 5:00 AM Joel Stanley <joel@jms.id.au> wrote:

> From: Andrew Jeffery <andrew@aj.id.au>
>
> We need to iterate over each pin in a group for a function and
> disable higher priority mux configurations on the pin before finally
> muxing the relevant function's signal. With the current debug output it
> is hard to track what register output is relevant to which operation, so
> break up the actions in the debug output by providing some more context.
>
> Before:
>
>     [    5.446656] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: request pin 37 (B26) for 1e780000.gpio:341
>     [    5.447377] Want SCU414[0x00000020]=0x1, got 0x0 from 0x00000000
>     [    5.447854] Want SCU4B4[0x00000020]=0x1, got 0x0 from 0x00000000
>     [    5.448340] Want SCU4B4[0x00000020]=0x1, got 0x0 from 0x00000000
>
> After:
>
>     [    5.298053] Muxing pin 37 for GPIO
>     [    5.298294] Disabling signal NRI4 for NRI4
>     [    5.298593] Want SCU414[0x00000020]=0x1, got 0x0 from 0x00000000
>     [    5.298983] Disabling signal RGMII4RXD1 for RGMII4
>     [    5.299309] Want SCU4B4[0x00000020]=0x1, got 0x0 from 0x00000000
>     [    5.299694] Disabling signal RMII4RXD1 for RMII4
>     [    5.300014] Want SCU4B4[0x00000020]=0x1, got 0x0 from 0x00000000
>     [    5.300396] Enabling signal GPIOE5 for GPIOE5
>     [    5.300687] Muxed pin 37 as GPIOE5
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Patch applied, thanks!

Yours,
Linus Walleij
