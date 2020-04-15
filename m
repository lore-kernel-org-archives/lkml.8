Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705BDC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5A220768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bPsgUpYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896927AbgDOLYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896920AbgDOLX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:23:56 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F030C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 04:23:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x66so16692636qkd.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GbGdUHCJ4bUoinaanEHZGPM2IWEohSovSXtISnti05A=;
        b=bPsgUpYoL9M6N2VPErmUCcpzn5u1MHE4amLphyBztAlEDYEc2BUT5APnZolsOpqgQo
         UElW/h+9W6/OQYq78v+wkrwkTScU3VFsegxOrjrBSro+NUqEKIL9G+6pWDHSz8WSnPnE
         obvD/n2FGftlzjcsOuPEV8TTSJVUDp3JG5nvbPN/zHFL8oQiNIhug82+p5i0veVBTiIv
         52CYBawo5jbUJ8flFm+S6jB67a+hbEkBGGVG4hHAXYz0iGiKxtS+DkXCSSfFS2jSW37G
         DFojNU+UxX7TUk7szfPJBPAo6ijrC8QtQ0Z4PVPTkamQE2hqyBCYfxdWDSePkTzzJ7xh
         pzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GbGdUHCJ4bUoinaanEHZGPM2IWEohSovSXtISnti05A=;
        b=sgEesx7stljAKt4OESViOGSCboNcqgy+pr9sIMvcgzeVulEfYVCaDkrmfpJjeK2x+i
         U+lq9jA74z+0o9iT4rm+LbujXzgtI0RwndQajZNUkzw2G9WzWsmVXqxZrGwkL7AcLzYJ
         qQcXH6K93BzA5ap48EwxgqJtRD8XIfkKqA5BshxcqV6TiTzlWQ9vCMN5n6CZzTj60krS
         4zrNffDl8I/evmSlEOr250VTZrcwzXyL+vpH1IQyrpFZq3T+zvZmRf4fThAvkbqrYbN3
         1G58CXtGWpADMGlz/oDlkN7oHF5kgDGOGGM0xpuTICLI5TdfxTZOVSm9oyrDEEGGaF6g
         8i4A==
X-Gm-Message-State: AGi0PuapqBukgu//pQe3RzbpQQc61/sF0/8vpNwfFReGPwll3jX02IrZ
        sm2omXqPFl40E8ObqEQXF0Cpodoj5YTWijZLvZ0nuQ==
X-Google-Smtp-Source: APiQypLIFkjl085Wr9baIYHsdqw7js/p+GpQ1kscrhJsG4kwCOMANeuE99y+0cw3i4iiaeT6xcHhsaHD6J6lJhvwp+E=
X-Received: by 2002:a05:620a:1289:: with SMTP id w9mr10377990qki.263.1586949826538;
 Wed, 15 Apr 2020 04:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200412013352.674506-1-aford173@gmail.com>
In-Reply-To: <20200412013352.674506-1-aford173@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 15 Apr 2020 13:23:35 +0200
Message-ID: <CAMpxmJUA=-AfSGLtVzhBe16q73P6kHJeX6W_kYuG6W3AQ=3A+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpiolib: of: Improve gpiolib-of support pull up/down
 on expanders
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>, aford@beaconembedded.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 12 kwi 2020 o 03:34 Adam Ford <aford173@gmail.com> napisa=C5=82(a):
>
> When using GPIO expanders attached to I2C ports, their set_config functio=
n
> needs to be passed a config setting which contains options to enable pull
> up or pull down bias feature.  In order to set this config properly,
> the gpio parser needs to handle GPIO_PULL_UP and GPIO_PULL_DOWN.
>
> This patch enables the flags corresponding to GPIO_PULL_UP and
> GPIO_PULL_DOWN.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index c6d30f73df07..bf17afb1f66d 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -344,6 +344,12 @@ struct gpio_desc *gpiod_get_from_of_node(struct devi=
ce_node *node,
>         if (transitory)
>                 lflags |=3D GPIO_TRANSITORY;
>
> +       if (flags & OF_GPIO_PULL_UP)
> +               lflags |=3D GPIO_PULL_UP;
> +
> +       if (flags & OF_GPIO_PULL_DOWN)
> +               lflags |=3D GPIO_PULL_DOWN;
> +
>         ret =3D gpiod_configure_flags(desc, propname, lflags, dflags);
>         if (ret < 0) {
>                 gpiod_put(desc);
> @@ -585,6 +591,10 @@ static struct gpio_desc *of_parse_own_gpio(struct de=
vice_node *np,
>                 *lflags |=3D GPIO_ACTIVE_LOW;
>         if (xlate_flags & OF_GPIO_TRANSITORY)
>                 *lflags |=3D GPIO_TRANSITORY;
> +       if (xlate_flags & OF_GPIO_PULL_UP)
> +               *lflags |=3D GPIO_PULL_UP;
> +       if (xlate_flags & OF_GPIO_PULL_DOWN)
> +               *lflags |=3D GPIO_PULL_DOWN;
>
>         if (of_property_read_bool(np, "input"))
>                 *dflags |=3D GPIOD_IN;
> --
> 2.25.1
>

Patch applied, thanks!

Bart
