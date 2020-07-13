Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B98BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A5E20C56
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j5dRr0Sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgGMWUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGMWR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:17:27 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1DCC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:27 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id d198so7500131vsc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LFCA43BGkxjqrYbBGY+idjvRsLf5O6PPbK27q7D0Bw=;
        b=j5dRr0SnqpA2dV+P7/JOdcquxtibjP73/WoGMAUQ6ir6wX9NsomAfNw8Cp/IweTjcr
         k7ddPDpour2+rZA3/zGoLTfyDEB+kLj1pLDMU2vXS08vsdr8rr8wKFKvlwgf42ki3KaP
         Bj0xMElNbV/1LB37z0Bm+sogFPP5R7uwghD0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LFCA43BGkxjqrYbBGY+idjvRsLf5O6PPbK27q7D0Bw=;
        b=TzRQpvI2/GtRdtfAg4SQ0kKBvdU4x9S/06HsG+KuGkKkG5ARzWTgqk2dc/e/8dXmZ/
         FaHC0XKUizPAKo3x1NLBqJzdggU1WKibSUx0GB1n6fB/WmuwSp7qphNLhcYILLwJOFqX
         KV42O4FgAEUqYocurzldWQ6mktRjw2iF5B93KRHIbC0TUFGBqIUHyaDPDmhIItnQAS09
         JmOgH5NlkQ/dbaOQDsM0LbpNCNt5MQD47QJXQlFAB8gDXgpORp754c17I1Vhop0KuxK9
         0bBm2u+eq7CH88S8NJSaz+JOjjmy7Y9LEOVcRKttsrlNiNw80l467jFzvBpKbY2bklSS
         M5Zw==
X-Gm-Message-State: AOAM530uotCVI4GS1ahVeKLJrlDKkslmlB0ZOeuUTkVsDlHvNbiGWxzq
        jW3oah/7tUjBpvJXifBzT1WT/1XjdKM=
X-Google-Smtp-Source: ABdhPJwu6ZhoGQ3mfQuiSpPlm1/7KLy4Cyen/teBh0/rjI8HU/7aHxbIUyPjL5KirgMFB6bSfKocZg==
X-Received: by 2002:a67:f9cf:: with SMTP id c15mr1175605vsq.185.1594678645896;
        Mon, 13 Jul 2020 15:17:25 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id d3sm2300581vko.51.2020.07.13.15.17.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 15:17:25 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id u6so4749112uau.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:23 -0700 (PDT)
X-Received: by 2002:ab0:150c:: with SMTP id o12mr1419016uae.90.1594678643349;
 Mon, 13 Jul 2020 15:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <1592818308-23001-1-git-send-email-mkshah@codeaurora.org> <1592818308-23001-6-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1592818308-23001-6-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Jul 2020 15:17:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=0yqDMeWSUAM4D6o_6JsOU4hm8Q2XFbOSEVQcRzRN6A@mail.gmail.com>
Message-ID: <CAD=FV=X=0yqDMeWSUAM4D6o_6JsOU4hm8Q2XFbOSEVQcRzRN6A@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] irqchip: qcom-pdc: Reset all pdc interrupts during init
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        LinusW <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 22, 2020 at 2:33 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Clear previous kernel's configuration during init by resetting
> all interrupts in enable bank to zero.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/irqchip/qcom-pdc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> index 8beb6f7..11a9d3a 100644
> --- a/drivers/irqchip/qcom-pdc.c
> +++ b/drivers/irqchip/qcom-pdc.c
> @@ -19,6 +19,7 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>
> +#define PDC_MAX_IRQS_PER_REG   32
>  #define PDC_MAX_IRQS           168
>  #define PDC_MAX_GPIO_IRQS      256
>
> @@ -339,6 +340,7 @@ static const struct irq_domain_ops qcom_pdc_gpio_ops = {
>  static int pdc_setup_pin_mapping(struct device_node *np)
>  {
>         int ret, n;
> +       u32 reg, max_regs, max_pins = 0;
>
>         n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
>         if (n <= 0 || n % 3)
> @@ -367,8 +369,19 @@ static int pdc_setup_pin_mapping(struct device_node *np)
>                                                  &pdc_region[n].cnt);
>                 if (ret)
>                         return ret;
> +               max_pins += pdc_region[n].cnt;
>         }
>
> +       if (max_pins > PDC_MAX_IRQS)
> +               return -EINVAL;
> +
> +       max_regs = max_pins / PDC_MAX_IRQS_PER_REG;
> +       if (max_pins % PDC_MAX_IRQS_PER_REG)
> +               max_regs++;

nit: max_regs = DIV_ROUND_UP(max_pins, PDC_MAX_IRQS_PER_REG)


> +       for (reg = 0; reg < max_regs; reg++)
> +               pdc_reg_write(IRQ_ENABLE_BANK, reg, 0);

This doesn't feel correct to me, but maybe I'm misunderstanding the
hardware (I don't think I have access to a reference manual).  Looking
at the example in the bindings, I see:

qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;

In that example we have mappings for PDC ports:
0 - 93 (count = 94)
94 - 108 (count = 15)
115 - 121 (count = 7)

Notice the slight discontinuity there.  I presume that discontinuity
is normal / allowed?  If so, if there is enough of it then I think
your math could be wrong, though with the example you get lucky and it
works out OK.  It's easy to see the problem with a slightly different
example:  Imagine that you had this:

0 - 33 (count = 34)
94 - 108 (count = 15)
115 - 121 (count = 7)

...now max_pins = 56 and max_regs = 2.  So you'll init reg 0 and 1.
...but (IIUC) you actually should be initting 0, 1, 2, and 3.

I have no idea what might be in those discontinuous ranges and if it's
always OK to clear, but (assuming it is) one fix is to put your
clearing loop _inside_ the other "for" loop in this function, AKA:

for (reg = pdc_region[n].pin_base / PDC_MAX_IRQS_PER_REG;
     reg < DIV_ROUND_UP(pdc_region[n].pin_base + pdc_region[n].cnt),
                        PDC_MAX_IRQS_PER_REG)
     reg++)

...or another option is to keep track of the max "pin_base + cnt" and
loop from 0 to there?  I just don't know your hardware well enough to
tell which would be right.
