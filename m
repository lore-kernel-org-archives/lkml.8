Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286A3C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0491D206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1UfbGhRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgEEQTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgEEQTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:19:09 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40131C061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:19:09 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g16so2402703qtp.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A/Wm3UHNM4qlX8DljPnma9j6lm5XESNuL8D71GdjV38=;
        b=1UfbGhRxXGz3GBtcxR9UNxM68oHkaj/WYVq1O0d/Pzl/wG0nhFdC8YkkSQk7lAfdvH
         5Ak4p4yujEG9sGUn6s8vbQyWJjfBr+jTiWZjH3JkLVJOPH/X0sby/bdWoNE24sm7Ct4u
         FWKT/jmiSIkJO/Tpqt2U+UXw5gSxKbmkry5EDE6mxveyCwgCeSprywvT2XvZob4BTVa/
         e04gJRelogulBVELpi7p7SvrDBnpA/8MZPhnhM+bIV42lT15R3Gjgt1c013K60Yne6VP
         yUpOU4KuQeRRl4T2kKhdlnbD9rTCeGeHobk3zfQ7ulhjY3A0zHfntGGHxEsIfXdU2wvt
         2qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A/Wm3UHNM4qlX8DljPnma9j6lm5XESNuL8D71GdjV38=;
        b=HBgSJfYg8Jaahi8FOp7gj7MH1fdTBRHH2D84tBgDSy3stlg3M5bM9cGze9/gMt07Mn
         PbgMOoO/xrUJUOXzf2zqYRpSKCS2V8onWXEB9dZnBDG4mwKVRKCqyaZMmTNVkQEdY8X6
         l3yDZuBbxoSkT0dSdrL2u9sQwmv3bwEjtsus2E3Y3bmEOaUbI2K7AcUMhOU1A9RS+rPq
         q4ZbOwEylgzvXrQWXjDKpUfaIqP2ZN2NBpqzddJgcdgbmN1fAhBrFOh8eLaJqE5y0c1t
         6s+PMstsxL9OhWp75zkO4MzdSaCZrRKLQWhgpVpVHysJ5332eD4FzqaGVjUwQk1P9Lfk
         remg==
X-Gm-Message-State: AGi0PubA5t+htZDWYweeP83xRhlhLCScSSil0Zybulzw9jeftuAO0PKL
        FntjLYwVh9/pcSyj52PWL6JMtwYtON0nCIY1spOa6w==
X-Google-Smtp-Source: APiQypLAizKoTqwFtOBKN/f1gzlwNVdkvxN9mo2b50TEgRtyqk55O3/9/e15NFeEPw0uW3ZQMHmqeBZnpb7i4CROJ3I=
X-Received: by 2002:ac8:346f:: with SMTP id v44mr3419058qtb.27.1588695548443;
 Tue, 05 May 2020 09:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200505084501.13170-1-ykaukab@suse.de>
In-Reply-To: <20200505084501.13170-1-ykaukab@suse.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 5 May 2020 18:18:57 +0200
Message-ID: <CAMpxmJXp9uZp=Q5Sm==_d720mg=aYSC1K1=V-P5Tz10gnLYuUQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: tegra186: export MODULE_DEVICE_TABLE
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 5 maj 2020 o 10:45 Mian Yousaf Kaukab <ykaukab@suse.de> napisa=C5=82(a=
):
>
> Export MODULE_DEVICE_TABLE since the driver can be built as a module.
>
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---
>  drivers/gpio/gpio-tegra186.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
> index 79b553dc39a3..178e9128ded0 100644
> --- a/drivers/gpio/gpio-tegra186.c
> +++ b/drivers/gpio/gpio-tegra186.c
> @@ -894,6 +894,7 @@ static const struct of_device_id tegra186_gpio_of_mat=
ch[] =3D {
>                 /* sentinel */
>         }
>  };
> +MODULE_DEVICE_TABLE(of, tegra186_gpio_of_match);
>
>  static struct platform_driver tegra186_gpio_driver =3D {
>         .driver =3D {
> --
> 2.25.0
>

Patch applied, thanks!

Bart
