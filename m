Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A7AC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621EF2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er757pB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgEDLBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEDLBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:01:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1044BC061A0E;
        Mon,  4 May 2020 04:01:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so15255200wra.7;
        Mon, 04 May 2020 04:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8gYfSI9LTcswBBqFfe7141haPYxExZ3uMFkC1/HLr8o=;
        b=Er757pB4csDycjVcXCmOh++3Va7lgE/d3hS1HwCih97sW3prXSMjWizDZgcytRdk2r
         cgapq+RDFM+tDupAohhSg8ByjenyW/Q8Yws4pugfIcFlefT+6Q6R9EE+E3rh13EpzY/3
         P9y278S5lJGhcqYVZ2Rhc9+/RtR2avv6UH8d7mMtlJ9vTSumQRNNIq32eJdJV/CSLTa7
         4zQdDdXqyYMte+9YaWiE3+o0kzV7xQ/mDLO+6+B/kyZFUY3Uvb/zsy9VuGafoWwvHFjd
         iBmCjFCKvfe/8/gFjPRDDFJZkZ0EQJoyw6jlKn4KPWkr9Ky5yIEriacriuQ89w37U+hw
         WpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8gYfSI9LTcswBBqFfe7141haPYxExZ3uMFkC1/HLr8o=;
        b=HLg8W5LPD0yJTEpb1U/edBIejliCKIsNnJcqKrGETgpxTuDAOxsd89xps6Uf4ha+aW
         /VitwshK+s14orjm560mysjnZZl+1SMHW29RwBIfgNJXjv4fDh14A4KWpQb21RYsrBKz
         ydsT4xSqh+7i8P2CYsO/JOIsOduvYFzoPVqcm3l/CaWzge1xYzyml9reLfVOpLLbgR9n
         b1Q0+EQ85QIlM9PmJGeJhmMS8lm6J/Z6R2OY+qQvRB4QhQcTgOQVuMiGIMYwtIJ1zPF/
         19cQtewSsMdOtnZNTHLMFyXgqSaSqMIYt8vHbqVER82k7BXH0vZBab88eImAJByQxW+H
         bftw==
X-Gm-Message-State: AGi0PuZ1P0F+sehGoV+Wu6QBYA+Evs9SDL47QjGl0bqPY3VAz8WfSdjP
        jfsOUsc9AXkb+vYZt7iNsD21tkGz3uLTQwEn41l6jub1EXI=
X-Google-Smtp-Source: APiQypJbvlr1zD1X04CH2mq6hBepmWIB7EJ18lS67KkLbsAn42ZYeKKB8H4UVnOmZIuoTF5rZku2E4lnkGqfkgB+hCc=
X-Received: by 2002:adf:f641:: with SMTP id x1mr18421592wrp.151.1588590080839;
 Mon, 04 May 2020 04:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com> <20200502114752.1048500-7-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200502114752.1048500-7-martin.blumenstingl@googlemail.com>
From:   hex dump <hexdump0815@gmail.com>
Date:   Mon, 4 May 2020 13:01:06 +0200
Message-ID: <CAKTihDXu2ZC3p-5w41-jZQ0x9kbcPnVyuwB5zgE3sDA6n3SiaQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] phy: amlogic: meson8b-usb2: Add a compatible string
 for Meson8m2
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 1:48 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> The 3.10 vendor kernel sets the ACA_ENABLE bit on Meson8b, Meson8m2 and
> GXBB, but not on Meson8. Add a compatible string for Meson8m2 which also
> sets that bit.
> While here, also update the Kconfig text and MODULE_DESCRIPTION.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Tested-by: hexdump <hexdump0815@googlemail.com>

> ---
>  drivers/phy/amlogic/Kconfig            | 2 +-
>  drivers/phy/amlogic/phy-meson8b-usb2.c | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 3495b23af797..5ec53874d1ea 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -3,7 +3,7 @@
>  # Phy drivers for Amlogic platforms
>  #
>  config PHY_MESON8B_USB2
> -       tristate "Meson8, Meson8b and GXBB USB2 PHY driver"
> +       tristate "Meson8, Meson8b, Meson8m2 and GXBB USB2 PHY driver"
>         default ARCH_MESON
>         depends on OF && (ARCH_MESON || COMPILE_TEST)
>         depends on USB_SUPPORT
> diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
> index 436dfa1a8a04..03c061dd5f0d 100644
> --- a/drivers/phy/amlogic/phy-meson8b-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
> @@ -302,6 +302,10 @@ static const struct of_device_id phy_meson8b_usb2_of_match[] = {
>                 .compatible = "amlogic,meson8b-usb2-phy",
>                 .data = &phy_meson8b_usb2_match_data
>         },
> +       {
> +               .compatible = "amlogic,meson8m2-usb2-phy",
> +               .data = &phy_meson8b_usb2_match_data
> +       },
>         {
>                 .compatible = "amlogic,meson-gxbb-usb2-phy",
>                 .data = &phy_meson8b_usb2_match_data
> @@ -320,5 +324,5 @@ static struct platform_driver phy_meson8b_usb2_driver = {
>  module_platform_driver(phy_meson8b_usb2_driver);
>
>  MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
> -MODULE_DESCRIPTION("Meson8, Meson8b and GXBB USB2 PHY driver");
> +MODULE_DESCRIPTION("Meson8, Meson8b, Meson8m2 and GXBB USB2 PHY driver");
>  MODULE_LICENSE("GPL");
> --
> 2.26.2
>
