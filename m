Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8750FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67620206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qKICfYS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgGHHWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbgGHHWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:22:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D771C08C5E2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:22:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so52980261ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FmCJ3eglFvN3eT4dZ92ESwtil9DSI68INw+lfLda+f0=;
        b=qKICfYS87wXGDK2raBiEPSdqxxy/mrxVg8JsloXiJmUkD4BjyHRWRE4wcTUfMBQmJs
         hpmvYepXlAJbEtD/LWIgAhWW0U8MrNXFU58I0H5xfvZ6as0cPKmDvxfeaSmSOgdTpJGW
         3xbFMQDGPsZxoKvxkZvrKL7O1bhMa8JKOD+6Q0UYZU/qpREdNDldt82AtA7EQcgTwquo
         hz9dWTGi9zb4aJga/xTyztV6y02ajJ7qyliC8BxFGVtJABzgjQ3dgxKfD3jsDlOhyEPZ
         v6WkFjQ3BdVy8nsneqRcusS6PHaZ7ln5hjHT+u/p1zL6HzJhfmcZU7/a9Jq6UfwfYIoN
         a3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FmCJ3eglFvN3eT4dZ92ESwtil9DSI68INw+lfLda+f0=;
        b=eldoRNWgzVnnuBmP6Rxt1He2w44HkuZjXcLaeePHgRWjn1b46M1ooHeNDAm82+XSon
         W9Z4zcF3Q1xQ0KzPzLteVGym5F2S1v8gMrIg9GP3YTpeBWpLRO6mz0auespkngeeyRcw
         k0+UGVOqqzGpjZCajcyuwDvIjzzbnUA4xpbegtQhbc7GTLwwD9Fv2y7msY336J70QL2n
         9yqt/EozwVIugYd5701BLeie/RLUcrt3aiqVKKnaF8fEKDxG/mRw7kuas9jlMBxjy8p9
         vTmTJFNvV46ndkVf0BCav71PMpypH+wrQwDhgHdoHtteGZNFGGY0i9S328ZgRTVvPSFq
         g1Lg==
X-Gm-Message-State: AOAM533UlBXQMo8dn005OWdXdvGm8up3cb2oce8mAVc0+SIsiwzramt6
        EuCqGTnRvwKEeTts+dn0gebDnke54ln09/EYc2JYPvSgHUU=
X-Google-Smtp-Source: ABdhPJxVSZk9OJ8mzvBdSpccIOkiBmKRMTgwEzL7Qe5kGuMosrbh6GYSkWDU//vCaRe7LEQh541MQ2A2jqXKACTTlqA=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr26819272ljg.144.1594192950588;
 Wed, 08 Jul 2020 00:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133345.2232932-1-lee.jones@linaro.org> <20200630133345.2232932-10-lee.jones@linaro.org>
In-Reply-To: <20200630133345.2232932-10-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Jul 2020 09:22:19 +0200
Message-ID: <CACRpkdZY0dP6oRdbWYUkPNicyZsVOKA-smEtkLt1h_-p7NSM7w@mail.gmail.com>
Subject: Re: [PATCH 09/10] gpio: gpio-mlxbf2: Tell the compiler that ACPI
 functions may not be use
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Asmaa Mnebhi <Asmaa@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:33 PM Lee Jones <lee.jones@linaro.org> wrote:

> ... as is the case when !CONFIG_ACPI.
>
> Fixes the following W=3D1 kernel build warning:
>
>  drivers/gpio/gpio-mlxbf2.c:312:36: warning: =E2=80=98mlxbf2_gpio_acpi_ma=
tch=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  312 | static const struct acpi_device_id mlxbf2_gpio_acpi_match[] =3D {
>  | ^~~~~~~~~~~~~~~~~~~~~~
>
> Cc: Asmaa Mnebhi <Asmaa@mellanox.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied!

Yours,
Linus Walleij
