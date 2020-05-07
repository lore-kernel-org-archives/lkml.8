Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3352CC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B76020870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG9JPxSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEGKl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbgEGKl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:41:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FE5C061A10;
        Thu,  7 May 2020 03:41:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t9so2489641pjw.0;
        Thu, 07 May 2020 03:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Kys6xR/y3HlGpmyn8tfctWY6mMEvfogLBDOY++2Egk=;
        b=UG9JPxSwDPC4ExTcSv4dkgpCkQtSVpcuVp98P/8swZIJPT5PwjekODVGjR6W5VGHeG
         FMqJird6yUefjXLIgStPiXTFjL3wk5LNY261y8WuVslOGwYpSG3n0Ddg3BfZm/1Pyuze
         Wr+0fsXoiUNsp+uhxClV21ewiIpYNBHS9kB547Caplboj1t0AGCQQ/992rC3U78Ygj9t
         2DBoQ5QmfVR2vjr0v4TnOJvtMgzUXXrMEztdstousaFWPbHqh4Nd3ZplHXjwvru2ro83
         QhsHCqyd67epPUj+XBUQVLgFWKb2hKo9EVPPWBgWSAC6HGN3ci3wR45yHRUXl9B02LJy
         LLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Kys6xR/y3HlGpmyn8tfctWY6mMEvfogLBDOY++2Egk=;
        b=Qawyl39t5GBXF0sd0KycFx7kYcJ9jxf1VunDPGpagfqpPh0QUJ8xKudNIRkNYjZ4we
         VF8UfiGYL+stWSq7f2fup/yugu3Dj+esFZpMlrBWkDOtyuzDSF+O+W+SFqXmsFmqxRmV
         jaG+WJwrKloyEv81VhZtMm5mmWAujXcu1kzJD83YDUVa/ePcWoDJ/Sm6I1s3g9SVHOwV
         4+cHzqjf3943k7QVR/M+Q2T3rJLtAyTEdmuX0nudRuNcORkDSQjb77dL36wOB5tVzAS5
         zDWw8+2Fm4yGZi5sBVe7OiJZzm3mjaHxyGtfqzyuvsD22LMXUsc68Iy8Pr4sz6bya635
         Eujw==
X-Gm-Message-State: AGi0PuaAAT3+XRKIH2CM6dWGTYmVGHa3UqaXFQRUE743s1ymyuGsY96R
        Ds7Ph8pSf+WNPuO7kx/9Joc1lcRZLgYagtJIrFo=
X-Google-Smtp-Source: APiQypJxRpfEbBrj93EqmyeQMoRPMp2tmt6l8dn90mSWmCePb2zn2N/T1r2XsYWjau4MJ8wPjiDewCHvTAYJtsTJA6Q=
X-Received: by 2002:a17:90a:340c:: with SMTP id o12mr14144430pjb.22.1588848114587;
 Thu, 07 May 2020 03:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200507094242.7523-1-koba.ko@canonical.com>
In-Reply-To: <20200507094242.7523-1-koba.ko@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 May 2020 13:41:42 +0300
Message-ID: <CAHp75VeDFpjwZoNWj6SwvnHE70o4x+U9GnK-tbrFpK6fkBN7MA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
To:     koba.ko@canonical.com,
        Mario Limonciello <mario.limonciello@dell.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Mario

On Thu, May 7, 2020 at 12:42 PM <koba.ko@canonical.com> wrote:
>
> From: Koba Ko <koba.ko@canonical.com>
>
> Error messge is issued,
> "platform::micmute: Setting an LED's brightness failed (-19)",
> Even the device isn't presented.
>
> Get the related tokens of SMBIOS, GLOBAL_MIC_MUTE_DISABLE/ENABLE.
> If one of two tokens doesn't exist, don't register platform::micmute.
>

What the exact platform you are experiencing that on?

> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
>  drivers/platform/x86/dell-laptop.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> index 1e46022fb2c5..afc1ded83e56 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -2208,10 +2208,13 @@ static int __init dell_init(void)
>
>         dell_laptop_register_notifier(&dell_laptop_notifier);
>
> -       micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> -       ret = led_classdev_register(&platform_device->dev, &micmute_led_cdev);
> -       if (ret < 0)
> -               goto fail_led;
> +       if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
> +           dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
> +               micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> +               ret = led_classdev_register(&platform_device->dev, &micmute_led_cdev);
> +               if (ret < 0)
> +                       goto fail_led;
> +       }
>
>         if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
>                 return 0;
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
