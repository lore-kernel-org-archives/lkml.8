Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98871C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBEB2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoIWGxD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGJUhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgGJUhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:37:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED57C08C5DC;
        Fri, 10 Jul 2020 13:37:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cv18so4892629pjb.1;
        Fri, 10 Jul 2020 13:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pp8U3BgI+jWql7d/n8fxlb3gtQyg9fLbhRIKfV7YFLQ=;
        b=GoIWGxD0pijLe+SZRdOB7V/PkwWTkI8AZ7PrKYG/Cg9cpFe4C7GVOhfFPp126gFBys
         k7+BRpkyXaAOD/1hBEww51+mfHma5Hi9t4NdL9N4WjSW77gF1Zx/LEP72nV3npkIYCAq
         fuQbiuZqfaQ5iJWzX0l705vf/cswyb0Y6OS1nAGMhUgkUMzC+RgQuolQBRissWgpVgXE
         POQk7oh2mqNiNViaEW18Meuu7tBV7GsWjnZsKz4zQ/Ic8eyj4NRoSe7n2YmLT91sIGlW
         re5I0142qcFrkST31NqqgAcLH8pQ4q3Pv/LqAzf1aCDkdmJ3N0U7up1h0IhKMwOrFUrT
         S6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pp8U3BgI+jWql7d/n8fxlb3gtQyg9fLbhRIKfV7YFLQ=;
        b=ISCVzVvjYZTHxN9K2JOLPQ8VrASmzs0QBOl9cISxdJ3mR27RKBsuB45wuPP+u/jQaV
         TWFphkdIMMW3zdRmVssRGdfBgstN6sB8DIkkyhSpWlqprY8L51UjWtHmaC9+kQHytISh
         SgVYqLl6LhRmybz4mMC8JQASu4BI2q12Ids17qRbr8M0Nu7/KACkg4iiMWirHkyg5rac
         MGcUpNKNbOugj3sGNsivi4+O5Kfv5hst6ScukBj6/XCSUqT1PTK3KyH33ZuKCJhwEnM/
         9Ffv99pEhUegozhkOVVAnJRlfD9py7sQZ2/fd+15P3A3N3S5GGQWoBKLO1TRtGZ+2f0t
         Tcpg==
X-Gm-Message-State: AOAM531XmRWOfopogJ+xmnv31uVAd/xXmkwZ89mE4nFmsU3U/fTerX5F
        JJkUPaWGUvU+7fGE6bk4eUoaR2jo7h3XEJzzOXY=
X-Google-Smtp-Source: ABdhPJz3trftZS49aoD0wB3AUdVZ1ftB0oXcOSkRyxrDvXnyYBK3Sk77rMqU6Mxzi8O3uFZmS7K/t80fEcmnWHRgPU8=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr7732607pjp.228.1594413430487;
 Fri, 10 Jul 2020 13:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200630175559.23966-1-rublag-ns@yandex.ru>
In-Reply-To: <20200630175559.23966-1-rublag-ns@yandex.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jul 2020 23:36:54 +0300
Message-ID: <CAHp75VctrxoL7d_JPAOv8_t1T=vMx-GiLyfrjZ6839N8C1UrnA@mail.gmail.com>
Subject: Re:
To:     Vasiliy Kupriakov <rublag-ns@yandex.ru>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS" 
        <acpi4asus-user@lists.sourceforge.net>,
        "open list:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 8:57 PM Vasiliy Kupriakov <rublag-ns@yandex.ru> wrote:
>
> Subject: [PATCH] platform/x86: asus-wmi: allow BAT1 battery name
>
> The battery on my laptop ASUS TUF Gaming FX706II is named BAT1.
> This patch allows battery extension to load.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Vasiliy Kupriakov <rublag-ns@yandex.ru>
> ---
>  drivers/platform/x86/asus-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 877aade19497..8f4acdc06b13 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -441,6 +441,7 @@ static int asus_wmi_battery_add(struct power_supply *battery)
>          * battery is named BATT.
>          */
>         if (strcmp(battery->desc->name, "BAT0") != 0 &&
> +           strcmp(battery->desc->name, "BAT1") != 0 &&
>             strcmp(battery->desc->name, "BATT") != 0)
>                 return -ENODEV;
>
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
