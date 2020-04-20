Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5593C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAB520782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uq1UtX4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgDTWdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgDTWdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:33:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76CC061A0C;
        Mon, 20 Apr 2020 15:33:37 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r4so5807610pgg.4;
        Mon, 20 Apr 2020 15:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQEM9DWcyVuGSR7yq/Z954i7krAGNWwBbn5c8AlgXpE=;
        b=uq1UtX4QuL5/kWF8QYjdfFO8Ui/Bpd1N/OQYaosFtl+eERSaDHbqouW0owYi+peb/E
         NxHI0u8TlYQeWzQN/J9XOliKLN4jl9X4FYIpWrw9sybbKqU+iKbVlQJXlxYUSU3YkYUr
         y2+B/HADZ4llIIMviTBzk+7Nv3uNDfGPWIDogukqV+wt1LvXtdiTQH0fX/+AkvQfCJaJ
         31/n1bW7Nrnq//6K15IwQZ3LW5tQJqu4E4duwtzU8XzBgK32lyPZavyzB6MxBqz824sa
         vQtKx46bCPrA6WsPzRdq9wTVJX6NGY1jZ6e5am8pN7yPB8p3Qa5fA3m5F/+4VKTsMOZQ
         VrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQEM9DWcyVuGSR7yq/Z954i7krAGNWwBbn5c8AlgXpE=;
        b=EEviEubb9t++YeW7i6hdbzJzwBFNrDBvt80/EkgSqD96ED51zh+YKtrhL3losMqfjO
         lJxVh/rqSrP1iGvUaOgiP/nn2uBA48WyZSseumVyBslg/6WxKfXoqbLTiv//adp3H9Pa
         LTgiMHOVywbMdGWgazpodUZVCS3HMYNESOU7WpbWhhcU16w9wcohDwE4PyLhMuPJMSi2
         tG6q9cKa12n0WShKuA37LPW6u/9qEfPuIn+aUCMeV3XOPRs0b/ayBaS8e6eE8W9xvLoL
         o04NQEYMIP572NaqGooTtdCrB4G0SpbWjcCOdpgBWFkFvdNAb/S+eNF1z1j4Y0QnPX8m
         NR4w==
X-Gm-Message-State: AGi0PuYBCwhRa5rqDXV6ZfKNYt3h85woEeqp45ZopMDM4REGmShHa5kr
        HFOHm4+3tBEHSknRW72mhTKAHxuBZxwGjVlk7XWGURAYLcDdTg==
X-Google-Smtp-Source: APiQypI6CwvEBvAfBXjMuiwiFJLQbo3/oNzWqVmgFdLUkN+AngNn81WtbZw7udc4CqufrnIUYILSwnvOS+1SDzcemtk=
X-Received: by 2002:aa7:9097:: with SMTP id i23mr18460117pfa.170.1587422016694;
 Mon, 20 Apr 2020 15:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200420220421.171298-1-hdegoede@redhat.com>
In-Reply-To: <20200420220421.171298-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Apr 2020 01:33:24 +0300
Message-ID: <CAHp75VfC7-saRXnGDpee1dxAqDSDcveHMoC872WN9-SL4sDH4Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: surface3_power: i2c_acpi_new_device()
 returns a PTR_ERR
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 1:04 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> i2c_acpi_new_device() never returns NULL, it either returns an i2c_client
> or a PTR_ERR. Adjust the mshw0011_probe() error handling to take this
> into account.
>
> Note the goto out_err will cause i2c_unregister_device() to get called
> even though the i2c_acpi_new_device() fails, this is ok as it accepts
> a NULL pointer argument (and treats it as a no-op).
>

Thanks, I guess it repeats [1].

[1]: http://git.infradead.org/linux-platform-drivers-x86.git/commitdiff/4dbccb873f2b35ad1b26419ff88c80509e2d4cbb

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/surface3_power.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/surface3_power.c b/drivers/platform/x86/surface3_power.c
> index 946ac2dc08ae..32e6e86e27dd 100644
> --- a/drivers/platform/x86/surface3_power.c
> +++ b/drivers/platform/x86/surface3_power.c
> @@ -522,8 +522,10 @@ static int mshw0011_probe(struct i2c_client *client)
>         strlcpy(board_info.type, "MSHW0011-bat0", I2C_NAME_SIZE);
>
>         bat0 = i2c_acpi_new_device(dev, 1, &board_info);
> -       if (!bat0)
> -               return -ENOMEM;
> +       if (IS_ERR(bat0)) {
> +               error = PTR_ERR(bat0);
> +               goto out_err;
> +       }
>
>         data->bat0 = bat0;
>         i2c_set_clientdata(bat0, data);
> --
> 2.26.0
>


-- 
With Best Regards,
Andy Shevchenko
