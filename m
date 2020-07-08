Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A40C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E48FA206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtthwG7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgGHHOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgGHHOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:14:34 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DEFC061755
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:14:34 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c11so26242743lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WH0DgEX1doSuthU1GvsRAiz7iRNbEa0pRy0hawnmsIc=;
        b=rtthwG7wiWOR1Qi7ORtIU4jnvQ9yZ/d0DFpgkczw4QvEK5Xp/6i53GrgMjbQEdtYCI
         K7Pr1Pimeo6eSz6SW3DJaeH3ePjBx4U80ixTw9EqJ5XuqIFUzVeeV2/7sLQsXJ+VvKWP
         ziJ6gxcP28rd2cYp8gnub8dNDiQDnbK/Zs6ekIPHApcWZTe9PUyIavwm58V0+kgpk2oO
         vvTIMDZXIN7AtmE9tHL+IwFOKA6oMmKgD66dzM/NxmbX3U8LPGddFi67S49XX9wv7GD4
         /SbeGYrAKigrSr1552XWfmZtwao5xB7hOctQftzX/855W/Dpwt01jTPBM7/MnS13ZP09
         RKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WH0DgEX1doSuthU1GvsRAiz7iRNbEa0pRy0hawnmsIc=;
        b=a65LgT0Zomu1idgDJ1RZ4Y2X+otebvEfDcog407/Ig2HFcf378npx1COjmYx+8ltF8
         xmRRsEy8FsT3A2pdcZZxNlZRO4BuVTTPXhftptWjn8jiwULAEqRnps/1d3LG88SjjUWw
         RUKVvxNTkJbKT3Mf3nU5N9dKqHSvkx5VpIaNJV8lluiJPv2gX+WESJ02Cno1XBMTUK47
         QM6ph+i09Hgr6iwerAXpouMQ7BfjvqREsI+cl/kMI/ILFD2dAUEAaJW9UNx9XzFuvHKH
         y3ModBb88ix+eRkq461FTim4LzQn16hO1dbtyqhh7JZwsmbuwTKAG0ZKTl78kgxvj2Dw
         BDow==
X-Gm-Message-State: AOAM5326xFvNsYt1ArHmq7I3EpjvV7QE1nVprU+cO0j3KA1/i6oV+wl5
        9GLoZlK8fdQNVQG2tOGi19ydUBBUkicECkxJYyBTt7Ygg3E=
X-Google-Smtp-Source: ABdhPJz+d2lLiVidW9bwPJZrRoLJK8yPDoBv0mfcvl03OB73UAC4v6nNwx4Fd9mVZhiUhmBKQzXOkXBIf7C4LV6QIRs=
X-Received: by 2002:a19:745:: with SMTP id 66mr35488731lfh.77.1594192472496;
 Wed, 08 Jul 2020 00:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133345.2232932-1-lee.jones@linaro.org> <20200630133345.2232932-2-lee.jones@linaro.org>
In-Reply-To: <20200630133345.2232932-2-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Jul 2020 09:14:21 +0200
Message-ID: <CACRpkdapTEkYSD_xY3JKHLDTFQ3qPFNMwntiTNWsQPD2ESGgCA@mail.gmail.com>
Subject: Re: [PATCH 01/10] gpio: gpiolib-of: Provide documentation for of_gpio_spi_cs_get_count()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:33 PM Lee Jones <lee.jones@linaro.org> wrote:

> Descriptions for of_gpio_spi_cs_get_count()'s 2 arguments are
> missing.  Document both 'dev' and 'con_id'.
>
> Fixes the following W=1 kernel build warnings:
>
>  drivers/gpio/gpiolib-of.c:36: warning: Function parameter or member 'dev' not described in 'of_gpio_spi_cs_get_count'
>  drivers/gpio/gpiolib-of.c:36: warning: Function parameter or member 'con_id' not described in 'of_gpio_spi_cs_get_count'
>
> Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied!

Yours,
Linus Walleij
