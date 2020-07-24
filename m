Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D096DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC002074B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqQUMF93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgGXLDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXLDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:03:38 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EDFC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:03:38 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id b77so4665761vsd.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Au+P5vWjHDbv2hxe1yqJB3itx6Q+Wz+7J06/YCbynv8=;
        b=WqQUMF93oq+ORbGoMLGuQXJo6Z7V14YaJsc1MX/Sm4QTqFgZb2D0K9IjKMG52+s4aM
         /ETTHJUoJ1dnsYuROuREuoRArmE1P8NnoHxIvPAF+ZDNariee0QTYXRcpfrMS1ZU+nqn
         HrsV+/LFHGO3TtkFv/XeEht6DQshkrhXwTfKeAslfV6BN8Q0UkfaaYdMy4Lnl8sxDpqx
         8xj4VPQcR46A3sL40roYmeT3gbxjOtMiwRc7KOTBc1ChgLcibQ9iOGkbiH+aHKUcsnLz
         SX01kXDloQ6o6XdJ36pJCiyMwu0HVvrg8ygjOavAdsCQ6N2TGfhyCGvEz1k4PmsnBL/o
         5BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Au+P5vWjHDbv2hxe1yqJB3itx6Q+Wz+7J06/YCbynv8=;
        b=ru4sq/pyGZrrNnjsTTYoN72cv4Ek2A0ZLXJUucDb9enIoLW4DIdaZOYLmEK+VvCxjI
         HkIymCyQT72ZZ+tE8R1lRL/pDW9o3MSWYBPHIP6Q1XI8tXzK8T8kyhoeVLM0f1ytkC9S
         GzjZ7kMkj+8gLywqVsm3gzbvhu6QdtCzVlSr8n8P1jBvP0q3v/E/vahtYBRqwEwZB9SX
         PWXTNFuF5r1cUaQR0a2n65GKCMKP5p3/PzQAcZsJKqVTsqrSf4CMOTqSOW/uU4su383N
         fouhTczQWU/OQcVEVC4YS0Actl365OC8+82IesrsyXjSgksiWdCdEE77PEZ0NCzUGpwy
         0goA==
X-Gm-Message-State: AOAM530n2002sBteLP0yX8LbtZm+Fv0gEslhkECnL/RdpN8lo9CbV1Yf
        q9xaVYO7HkiWSaFJgi/lX/vXi6/M0ZRFHcsfFMoYGQ==
X-Google-Smtp-Source: ABdhPJxZzs8uHqe97g1kqm30T/L1pYN517M1cmKHs2FOCBtJF2WMNTqKdeq7OD5G/Id27zykJURIYUPF57zP0HXbFHE=
X-Received: by 2002:a67:f888:: with SMTP id h8mr7066235vso.165.1595588617341;
 Fri, 24 Jul 2020 04:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200721191718.29414-1-alcooperx@gmail.com>
In-Reply-To: <20200721191718.29414-1-alcooperx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jul 2020 13:03:00 +0200
Message-ID: <CAPDyKFqLX8TvZHZ+0Ytu9BO_56vuPQ+9cvFQCez+mEG-AJWkqQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: Some Micron eMMC devices cause reboot to hang
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bradley Bolen <bradleybolen@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 at 21:18, Al Cooper <alcooperx@gmail.com> wrote:
>
> When using eMMC as the boot device, some Micron eMMC devices will
> cause reboot to hang. This is a result of the eMMC device not going
> into boot mode after the hardware sends CMD0 to reset the eMMC
> device. This only happens if the kernel driver sends CMD5 (SLEEP_WAKE),
> to put the device into sleep state, before restarting the system.

What do you mean by "boot mode"?

When the kernel sends the CMD0 to wake up the eMMC from sleep, at
system resume for example, it all works fine, I guess. What is the
difference?

> The fix is to add a quirk that avoids sending the SLEEP command
> and to use MMC_FIXUP to set the quirk for these Micron devices.

I am not sure this is Micron device specific, but rather some it's a
driver/platform bug. Maybe on the kernel side or in the bootloader
code.

But, let's see where the discussion leads us.

Kind regards
Uffe

>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/mmc/core/mmc.c    | 3 ++-
>  drivers/mmc/core/quirks.h | 8 ++++++++
>  include/linux/mmc/card.h  | 1 +
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4203303f946a..4d69e8f8fe59 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1895,7 +1895,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>
>  static int mmc_can_sleep(struct mmc_card *card)
>  {
> -       return (card && card->ext_csd.rev >= 3);
> +       return card && card->ext_csd.rev >= 3 &&
> +               ((card->quirks & MMC_QUIRK_BROKEN_SLEEP) == 0);
>  }
>
>  static int mmc_sleep(struct mmc_host *host)
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 472fa2fdcf13..7263187b6323 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -99,6 +99,14 @@ static const struct mmc_fixup mmc_blk_fixups[] = {
>         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> +       /*
> +        * Some Micron eMMC devices will not go into boot mode on
> +        * CMD0 arg: 0XF0F0F0F0 after going into SLEEP state.
> +        * This will hang a reboot.
> +        */
> +       MMC_FIXUP(CID_NAME_ANY, CID_MANFID_NUMONYX, 0x014e, add_quirk_mmc,
> +                 MMC_QUIRK_BROKEN_SLEEP),
> +
>         END_FIXUP
>  };
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 7d46411ffaa2..0cdddcb5e17d 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -270,6 +270,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_IRQ_POLLING   (1<<11) /* Polling SDIO_CCCR_INTx could create a fake interrupt */
>  #define MMC_QUIRK_TRIM_BROKEN  (1<<12)         /* Skip trim */
>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
> +#define MMC_QUIRK_BROKEN_SLEEP (1<<14)         /* Broken sleep mode */
>
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>
> --
> 2.17.1
>
