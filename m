Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699B2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491B7204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgHSN6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:58:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41283 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgHSN54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:57:56 -0400
Received: by mail-oi1-f193.google.com with SMTP id b22so21048880oic.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=al08jUEqFwt9M7OkbrnS0G74Qrog69pfPQf3Hwue8+Y=;
        b=jnYxyDqPONPhXqQQhl8Eaf01jr0/iK3gQE9lJST9OENzpvWHcGH70ndcKsC7iGK1+R
         tUybkVvVsKVexQJZHEKg8Er39VFYrEMvhW5XAQ6l34lvedElQwVl6jSQI8oCPGDrTXPU
         r3Y3Il1PzUzNU+Bm9WSB5r1LYVYxHLgntrfU3H5TK+FFXpdMhuzwcrhv47gz0QVpxyop
         ImR8dDJkFGjd6IItGHLJUvxSK0pdrqm6HKbZQEWYr0T9QwNGyAPvU7y8lhV4z9+coksD
         JQeqQw3NeqOuld1nD4wi9OY/QIE62OFnmL4oGX0/2s7TFIArju3Xiy4M1l9EPfr8sAvL
         d8zw==
X-Gm-Message-State: AOAM531VRaj6RKWwri4Jh8acvaMY/qqn4abVXfTUbnzsAl/Xdy1qAClK
        MIQaS19UHwnBOC9vN5TVaiHAScJTVM/1ePyFYQw=
X-Google-Smtp-Source: ABdhPJyxR3WKbqrzw4/BjnttVQj5Kr25SVKjW3H5Y5lxL/WbotgrpXKrwLa7txGeZxI+MWOi6hGMj4jUdkqVMjU90mI=
X-Received: by 2002:aca:4b54:: with SMTP id y81mr3280379oia.54.1597845476368;
 Wed, 19 Aug 2020 06:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200817163152.13468-1-liambeguin@gmail.com>
In-Reply-To: <20200817163152.13468-1-liambeguin@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Aug 2020 15:57:34 +0200
Message-ID: <CAMuHMdUGu+pqZs5YoiBnZ2j7Yx86VDU9oKr4C15c1Jc9GjQuNA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] phy: tusb1210: use bitmasks to set VENDOR_SPECIFIC2
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, Vinod <vkoul@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,


On Mon, Aug 17, 2020 at 7:38 PM Liam Beguin <liambeguin@gmail.com> wrote:
> From: Liam Beguin <lvb@xiphos.com>
>
> Start by reading the content of the VENDOR_SPECIFIC2 register and update
> each bit field based on device properties when defined.
>
> The use of bit masks prevents fields from overriding each other and
> enables users to clear bits which are set by default, like datapolarity
> in this instance.
>
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
> Changes since v1:
> - use set_mask_bits
>
> Changes since v2:
> - fix missing bit shift dropped in v2
> - rebase on 5.9-rc1
>
>  drivers/phy/ti/phy-tusb1210.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
> index d8d0cc11d187..358842b5790f 100644
> --- a/drivers/phy/ti/phy-tusb1210.c
> +++ b/drivers/phy/ti/phy-tusb1210.c
> @@ -14,8 +14,11 @@
>
>  #define TUSB1210_VENDOR_SPECIFIC2              0x80
>  #define TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT  0
> +#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK   GENMASK(3, 0)
>  #define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT 4
> +#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK  GENMASK(5, 4)
>  #define TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT     6
> +#define TUSB1210_VENDOR_SPECIFIC2_DP_MASK      BIT(6)
>
>  struct tusb1210 {
>         struct ulpi *ulpi;
> @@ -118,23 +121,27 @@ static int tusb1210_probe(struct ulpi *ulpi)
>          * diagram optimization and DP/DM swap.
>          */
>
> +       reg = ulpi_read(ulpi, TUSB1210_VENDOR_SPECIFIC2);
> +
>         /* High speed output drive strength configuration */
> -       device_property_read_u8(&ulpi->dev, "ihstx", &val);
> -       reg = val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT;
> +       if (!device_property_read_u8(&ulpi->dev, "ihstx", &val))
> +               reg = set_mask_bits(&reg, TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK,
> +                                   val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT);

Triggered by your patches to add support for cmpxchg on u8 pointers to
various architectures (which is a valuable goal in itself ;-), I decided
to have a look at the underlying problem you were facing.

IMHO, using set_mask_bits() is overkill here.  That helper is meant to
update individual bits in a variable that may be accessed concurrently,
hence its use of cmpxchg().

In this driver, you just want to modify a local variable, by clearing a
field, and setting some bits. No concurrency is involved.
Perhaps using FIELD_PREP() from include/linux/bitfield.h is more
appropriate?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
