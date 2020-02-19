Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1002C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741672465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tqwyRN7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgBSQXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:23:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42817 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBSQXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:23:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so976041ljl.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 08:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+koYLn7ZJhaqj25+W9188jeUQ5uNdHzeqMm7FamtmY=;
        b=tqwyRN7XCiE959aKxjtEOi7/UiVPLzQgbupb84ZCRLoTrnACUhp19awz+tzxddbR1X
         9Yly0tVxiHyjnEOptVx9h+2uf8YOzE5dvLYJkwDqI+81p+8XHhPg9iGCPm0HJtE2JlIN
         T1qaWa2iiTxPvshRd+3CGCmfMnZq80U/hWBatQRYUYlUClXPIgDK7pRWOri0lpuyWzu3
         NBibHPKrpoVeYevXQaFye8xcnO1QgQuIk+je/kzXoFM4qtTR3f7899B7sEiilbXCfUA3
         KPTriTwoL/s9tqAiZvdW9zYCz5Kmt8FriQ8IIGF8dXC08E0ZDt4nlf8pJZJPKLZc9jTr
         0rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+koYLn7ZJhaqj25+W9188jeUQ5uNdHzeqMm7FamtmY=;
        b=bkxlAwqy/V6zWb95+80xg2xwlxHcrZTivacAoOynQPOrIq7jL/gWCLJHGVMrbfx3gT
         RmUZP78la7dULa18+KB4Eu92UbgYZ9rQ8DIr6INkzxTLF1txne/rDZlVRcS1fh5CxXSy
         g7g6ZYkjf1lHD7gdJOj0gArcd6RttkH/vOxPrLYcNIeW3HUbnaQ0Iey3J/iSxQJFx4jX
         AxRJAcCKCdLu3GvP+na5bUiuFqS9xIi+NR59WxnusNISyOO8lwGYkveYBdvJOKSjfzdf
         V3mvI3KSNDo/YQQwGJU19TTuxLIjLmWC10n6TaTIELTXhJXraIbyeG9AoWkfKl2mUguf
         b/2A==
X-Gm-Message-State: APjAAAWAZy2A9789NqgIZxWOmIkt6WCUAwQwzZk83dFxT0RtEhLt3LiL
        +rrEsxtOcXpWWCFLpaeO4DRSq20vwDxzR0Ec3dh1rg==
X-Google-Smtp-Source: APXvYqxJ7AMu2+7ZjAhkwR9hwSCjvmhllaXVwoznlwbfYWEU+J3T+FCENxb+Oo9gQMBsOOU7sXyzFQ8kRLk7wptkHE4=
X-Received: by 2002:a2e:9013:: with SMTP id h19mr16811174ljg.223.1582129430832;
 Wed, 19 Feb 2020 08:23:50 -0800 (PST)
MIME-Version: 1.0
References: <CAJZgTGF2ihuu_bSzQ93iBTf1YQ4_NM29S4iBFM8Fhd_RUaw2vQ@mail.gmail.com>
In-Reply-To: <CAJZgTGF2ihuu_bSzQ93iBTf1YQ4_NM29S4iBFM8Fhd_RUaw2vQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Feb 2020 17:23:39 +0100
Message-ID: <CACRpkdYXw0D9BJSBd6tvnKM3tkMir6ptcpg0nZxpbWQdAHYooA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson-gxl: fix GPIOX sdio pins
To:     Nicolas Belin <nbelin@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

thanks for your patch!

I can't apply it for some reason, something is weird with it...

On Wed, Feb 5, 2020 at 12:22 PM Nicolas Belin <nbelin@baylibre.com> wrote:

> @@ -147,8 +147,8 @@ static const unsigned int sdio_d0_pins[]    = { GPIOX_0 };
>  static const unsigned int sdio_d1_pins[]       = { GPIOX_1 };
>  static const unsigned int sdio_d2_pins[]       = { GPIOX_2 };
>  static const unsigned int sdio_d3_pins[]       = { GPIOX_3 };
> -static const unsigned int sdio_cmd_pins[]      = { GPIOX_4 };
> -static const unsigned int sdio_clk_pins[]      = { GPIOX_5 };
> +static const unsigned int sdio_clk_pins[]      = { GPIOX_4 };
> +static const unsigned int sdio_cmd_pins[]      = { GPIOX_5 };
>  static const unsigned int sdio_irq_pins[]      = { GPIOX_7 };
>
>  static const unsigned int nand_ce0_pins[]      = { BOOT_8 };
> --

For example the patch just ends here with -- two dashes.

Please collect Jerome's ACK and resend using git-send-email if possible.

Yours,
Linus Walleij
