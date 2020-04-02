Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79E2C2BA18
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B386120719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585863195;
	bh=sEbEJDY3uNsFFQnIzWiH4TyvsZPJRza9p71kK+FQIQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nLJVfjdToIzm7PZyfYWneBAuWtAglSVi9TvWiqJYm4YnK2Lb5KZkAtP6JDSJqGSvg
	 Q62WiU3e+1iy2Iz70A0y1Es+2hMOhcSBPvilg2ColE9DKf2RNL4yxs/JG8vos4OaRB
	 4lGbMIKBczOVZu5sxtTslwwMx+1eDhXXuH+Ak4Qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbgDBVdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 17:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgDBVdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:33:14 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 818A0208E0;
        Thu,  2 Apr 2020 21:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585863193;
        bh=sEbEJDY3uNsFFQnIzWiH4TyvsZPJRza9p71kK+FQIQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=auTMkc/6TL7cwsVXVtygaZtVE/9AzLt81Z/XNW07UPnrdMbVjTiL7U0M76RnFoOvX
         wzlk5B3vIBkru25w47rgFhHhba5hb5bfo3PFYA4NlbbpkxF3/XKI7wACPLPYTIeYzB
         nCf1vrK6BtDg4hGPROfuKSOBxnAeUFnPPqE/7NrE=
Received: by mail-io1-f49.google.com with SMTP id y14so5239456iol.12;
        Thu, 02 Apr 2020 14:33:13 -0700 (PDT)
X-Gm-Message-State: AGi0PuZlKhqO5UdIbjK7owat12387u3j0MSr8lVGFf47tuQiG8pMLugB
        ZToCUMT3jaNigg3tkk2UzPQ5qaSoWRxJbRrIHBM=
X-Google-Smtp-Source: APiQypLHI870DXnGi+SPCNcNnoFCTVHDyToeM11A/grJamJ4IqpuKrPjOk9kN49V1aXouUC4oxxy05Hry8/NW4pm25o=
X-Received: by 2002:a02:a785:: with SMTP id e5mr5232296jaj.97.1585863192871;
 Thu, 02 Apr 2020 14:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com> <1585128694-13881-4-git-send-email-hanks.chen@mediatek.com>
In-Reply-To: <1585128694-13881-4-git-send-email-hanks.chen@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 2 Apr 2020 14:33:01 -0700
X-Gmail-Original-Message-ID: <CAGp9LzpaC5opt9=BDUbR6tdr75F8cUxZc9nydJmNwoyq15x7hg@mail.gmail.com>
Message-ID: <CAGp9LzpaC5opt9=BDUbR6tdr75F8cUxZc9nydJmNwoyq15x7hg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] pinctrl: mediatek: avoid virtual gpio trying to
 set reg
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Teng <andy.teng@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, Mars Cheng <mars.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hanks,

On Wed, Mar 25, 2020 at 2:31 AM Hanks Chen <hanks.chen@mediatek.com> wrote:
>
> for virtual gpios, they should not do reg setting and
> should behave as expected for eint function.
>
> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |   28 ++++++++++++++++++++++
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h |    1 +
>  drivers/pinctrl/mediatek/pinctrl-paris.c         |    7 ++++++
>  3 files changed, 36 insertions(+)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> index 20e1c89..087d233 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -226,6 +226,31 @@ static int mtk_xt_find_eint_num(struct mtk_pinctrl *hw, unsigned long eint_n)
>         return EINT_NA;
>  }
>
> +/*
> + * Virtual GPIO only used inside SOC and not being exported to outside SOC.
> + * Some modules use virtual GPIO as eint (e.g. pmif or usb).
> + * In MTK platform, external interrupt (EINT) and GPIO is 1-1 mapping
> + * and we can set GPIO as eint.
> + * But some modules use specific eint which doesn't have real GPIO pin.
> + * So we use virtual GPIO to map it.
> + */
> +
> +bool mtk_is_virt_gpio(struct mtk_pinctrl *hw, unsigned int gpio_n)
> +{
> +       const struct mtk_pin_desc *desc;
> +       bool virt_gpio = false;
> +
> +       if (gpio_n >= hw->soc->npins)
> +               return virt_gpio;

gpio_n should always be less than hw-> soc-> npins, right? If so, we
can delete the condition from here.

> +
> +       desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio_n];
> +
> +       if (desc->funcs && !desc->funcs[desc->eint.eint_m].name)
> +               virt_gpio = true;
> +
> +       return virt_gpio;
> +}
> +
>  static int mtk_xt_get_gpio_n(void *data, unsigned long eint_n,
>                              unsigned int *gpio_n,
>                              struct gpio_chip **gpio_chip)
> @@ -278,6 +303,9 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
>         if (err)
>                 return err;
>
> +       if (mtk_is_virt_gpio(hw, gpio_n))
> +               return 0;
> +
>         desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio_n];
>
>         err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_MODE,
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> index 1b7da42..cda1c7a0 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> @@ -299,4 +299,5 @@ int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
>  int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
>                               const struct mtk_pin_desc *desc, u32 *val);
>
> +bool mtk_is_virt_gpio(struct mtk_pinctrl *hw, unsigned int gpio_n);
>  #endif /* __PINCTRL_MTK_COMMON_V2_H */
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index 923264d..7fba76d 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -693,6 +693,13 @@ static int mtk_gpio_get_direction(struct gpio_chip *chip, unsigned int gpio)
>         const struct mtk_pin_desc *desc;
>         int value, err;
>
> +       /*
> +        * "Virtual" GPIOs are always and only used for interrupts
> +        * Since they are only used for interrupts, they are always inputs
> +        */
> +       if (mtk_is_virt_gpio(hw, gpio))
> +               return 1;
> +
>         desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio];
>
>         err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &value);
> --
> 1.7.9.5
