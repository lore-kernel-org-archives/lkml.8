Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F04C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A0024655
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rq8pZaCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAWMc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:32:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44163 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAWMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:32:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so1304640pgl.11;
        Thu, 23 Jan 2020 04:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/11L1E5QyjlzkgnXDD/v6OgaG1EmfkWKUNXz4u6w/m0=;
        b=Rq8pZaCc0JgMhRJ+7o+ps3seQ83uNrt0lwoiJ0V0rmnWZn3CjHcVKoem0P8aKk+MUg
         y9xIiCj9c40gkaRkeYwdgRrt4afvtZWFumXaxBZ1mK6Jl7kEfHSM0Ui8enW6BBvbztZy
         wywL50iaFfB7dc11926Ix8pDq36H50XiV7RoU2IUdjUr1+LIFKU+Na5wf9OEbirGsqKZ
         3lg+M9Vuc8kgdSzbcQTFFIowD1HtUueIwa4vnQxBrBDitWPwQDOnBIYGJsLlXZM9LRCa
         sQFPyHZIjfBSlqwZmXr6WpTdLVvcHY7tb4K2CjCa7ETNpv4BUsg+U9fq3plWCwyIcXEG
         wBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/11L1E5QyjlzkgnXDD/v6OgaG1EmfkWKUNXz4u6w/m0=;
        b=gLHHQPbgtux7Y/czrhvuv+IwrSmKaDw0PGKWYPWsTSySDb8qj70MpmczX4+Zpzz5A4
         N1lRx5hw4E+KstKLcLbImfyeZbe8cWazMZriAGsHOo1JZh8tQF6YmU+/HboryRGiLy8Z
         g0ac3xpD6EI1Pq77DeVU5arhPYmoKHZEfTBgy9VzYkDfsynX9R9dsk8EpfRy5JoBCEP3
         JcSDtE0QsYuVIkI8UbDpJqxaRFrS8rsCQNH4EQStyU4H323s2g8QwX9+g1KyAcC+6PLY
         ETKmfPECu0M6hv9LgBRE2FX2lK7jMkokOce6smRcbZxH42Fk1ueQSBmGGHR6KJhpLcCY
         0YfA==
X-Gm-Message-State: APjAAAVwkFT/Yo1SiylB24D2KE3FDd+sl8g2H7b0FjA71QtbWszZj98b
        MfZB0nlbltogMu+QZ32XExBH4lEA7Y/Slrg+wpY=
X-Google-Smtp-Source: APXvYqz3HMTDhYos5s0HqKfsUkanfyrk6xYXMbYRlcb2DUIHOlRxFcSvx8wLPxVSnV9SHonzsBYwtDRhuQvZY0La8Bo=
X-Received: by 2002:a62:1a09:: with SMTP id a9mr7253617pfa.64.1579782775414;
 Thu, 23 Jan 2020 04:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20200113223927.102509-1-paul@crapouillou.net>
In-Reply-To: <20200113223927.102509-1-paul@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jan 2020 14:32:47 +0200
Message-ID: <CAHp75VdYL-CXaQYmpdJad5nd3uzBd8A9k3pyHgjdcASMHCAtqg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-nb-wmi: Support left round button on N56VB
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:39 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
> The N56VB laptop has a round button located on the left side above the
> keyboard. Map it to F13 since it does not have any predeterminated
> purpose.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/platform/x86/asus-nb-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index b361c73636a4..6f12747a359a 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -471,6 +471,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>         { KE_KEY, 0x67, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV */
>         { KE_KEY, 0x6B, { KEY_TOUCHPAD_TOGGLE } },
>         { KE_IGNORE, 0x6E, },  /* Low Battery notification */
> +       { KE_KEY, 0x71, { KEY_F13 } }, /* General-purpose button */
>         { KE_KEY, 0x7a, { KEY_ALS_TOGGLE } }, /* Ambient Light Sensor Toggle */
>         { KE_KEY, 0x7c, { KEY_MICMUTE } },
>         { KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
> --
> 2.24.1
>


-- 
With Best Regards,
Andy Shevchenko
