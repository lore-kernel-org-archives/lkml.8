Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC640C83004
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9149B20757
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i2TyRdk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgD3AkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726329AbgD3AkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 20:40:25 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA787C035495
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:40:24 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g35so1723481uad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49/GUq/fltLJWqVhbL7UqtJO8rowbFsOO5SNzjwHTOY=;
        b=i2TyRdk3Tqw4h5DLb1A3tKoVpg6kPPWMN84oMR/sl9QzBxxG57S94enQkwZ8kWGyDV
         tzwy8lrWGZ5glKqDug98HzSRlI/YWxPBTgkGtapyACJT9Q7CD0mJ1M+mRSABCl9EdY8i
         qce3QsW8VvVCYeQp7Cbb/dZQ7uMdN1f7TZLaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49/GUq/fltLJWqVhbL7UqtJO8rowbFsOO5SNzjwHTOY=;
        b=Kr46GsOTXIFp8xQrlInEeiZXSEZ1Y6CVTsLo8m2cn4jtPhRykKggKVaR7HvyKZzbT4
         X+otK9JeGQbz6qhaurViPa0SBMKOsgqr6C9VeU7StuPz9xoEXSJBOO++tgLVKwwM+b7y
         tSIREzY8UREkaepJlInp3V0e5MoKtrc1YH5iAr2xFO5Zg3n315LnvZuL2jm5/wz7e7Z6
         pdL4p+JEAntkTawrZONYk8M8XKaBRo22OvWj3ujhomhARIwqBPfwqSXJS4iSAdX7w6BS
         a2AJFO8ZxQvmPaaAcCapfem7JixRRDufFMG5it2FQp6sTIFxa/IS/Uf47A3XKQ60AFbW
         pE8Q==
X-Gm-Message-State: AGi0PubIvGnu30uETdDwYeS+bzRlAA7/jliT1eIN0ysXJqvYEAMbjwwt
        9V6nD+0SXrQ0uQYSfes/WVLIhmtJvKE=
X-Google-Smtp-Source: APiQypJFFzyS184s7ICepB3Yt02eO2hRo0mAgCmYiNUMaRIIeNsjY/Q+9nZGPMS9WRACcLHM1Jirwg==
X-Received: by 2002:ab0:328:: with SMTP id 37mr496236uat.112.1588207223762;
        Wed, 29 Apr 2020 17:40:23 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id x23sm399067uan.15.2020.04.29.17.40.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 17:40:22 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id u203so1239221vkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:40:22 -0700 (PDT)
X-Received: by 2002:a1f:9645:: with SMTP id y66mr643020vkd.40.1588207222154;
 Wed, 29 Apr 2020 17:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200428162227.687978-1-daniel.thompson@linaro.org>
In-Reply-To: <20200428162227.687978-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 29 Apr 2020 17:40:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VTkO5AULJe1ksyhKLLxpywqX-RLC_T4ENyDf3ONJNMKg@mail.gmail.com>
Message-ID: <CAD=FV=VTkO5AULJe1ksyhKLLxpywqX-RLC_T4ENyDf3ONJNMKg@mail.gmail.com>
Subject: Re: [PATCH] serial: earlycon: Allow earlier DT scan is acpi=off
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 28, 2020 at 9:22 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently if the kernel has support for ACPI SPCR parsing then earlycon
> without arguments is processed later than the full earlycon=...
> alternative.
>
> If ACPI has been explicitly disabled on the kernel command line then
> there is not need to defer since the ACPI code (both x86 and arm64)
> will never actually run.
>
> Or, put another way it allows lazy people to throw "acpi=off earlycon"
> onto the command line of a DT systems and be confident the console will
> start as early as possible without them having to lookup the driver
> and address needed for a specific platform.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/tty/serial/earlycon.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)

I wonder if a cleaner option is to just add a special "earlycon" value
like "earlycon=not_acpi".  This wouldn't require any special peeking
and would just be a sentinel that just says "you should autodetect the
earlycon, but don't worry about waiting for ACPI".  ...that in itself
is a bit of a hack, but at least it's more self contained in the
earlycon driver and maybe more discoverable when someone is figuring
out how to setup earlycon?

-Doug



>
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index 2ae9190b64bb..ebb648aacb47 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -215,6 +215,31 @@ int __init setup_earlycon(char *buf)
>   */
>  bool earlycon_acpi_spcr_enable __initdata;
>
> +/*
> + * This takes a sneaky peek at other boot arguments (which may not have
> + * been parsed at this point in the boot) to check whether ACPI has
> + * been explicitly disabled. If it is explicitly disabled then there is
> + * no reason to defer initialization of the early console.
> + */
> +static bool earlycon_check_for_acpi_off(void)
> +{
> +       static const char token[] = "acpi=off";
> +       const char *arg;
> +       char before, after;
> +
> +       arg = strstr(boot_command_line, token);
> +       while (arg) {
> +               before = arg == boot_command_line ? ' ' : arg[-1];
> +               after = arg[sizeof(token)-1];
> +               if (isspace(before) && (isspace(after) || after == '\0'))
> +                       return true;
> +
> +               arg = strstr(arg+1, token);
> +       }
> +
> +       return false;
> +}
> +
>  /* early_param wrapper for setup_earlycon() */
>  static int __init param_setup_earlycon(char *buf)
>  {
> @@ -222,7 +247,8 @@ static int __init param_setup_earlycon(char *buf)
>
>         /* Just 'earlycon' is a valid param for devicetree and ACPI SPCR. */
>         if (!buf || !buf[0]) {
> -               if (IS_ENABLED(CONFIG_ACPI_SPCR_TABLE)) {
> +               if (IS_ENABLED(CONFIG_ACPI_SPCR_TABLE) &&
> +                   !earlycon_check_for_acpi_off()) {
>                         earlycon_acpi_spcr_enable = true;
>                         return 0;
>                 } else if (!buf) {
> --
> 2.25.1
>
