Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BD0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4A020899
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j/XT5yyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGMWVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGMWR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:17:57 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B0CC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:57 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id b205so3203925vkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q6bh/1yGmZao7f6eku70ZfEjUaW4mF5NYpD2HrmZqeI=;
        b=j/XT5yyFl2LbkH2lZtHlwHq+F8pmbt1Tm85qFPI0z7iEFb3EPc0mzXcrqsqbTS90ZE
         m+To0qUhXZYncSMgOThqPs0W9mh1DSWxfcv8lMcNrpkhXIgav4O5Rdvp3cc2hXPZIt4/
         scL1jsPMSGprQyr2BJIXvr5HxYY7wWu9lH3s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6bh/1yGmZao7f6eku70ZfEjUaW4mF5NYpD2HrmZqeI=;
        b=tLoqvo8qvYno2FaRUrq9SaCVT2nFD4hLQRNL/+U7V/cwPiKU+NZsNsFpZTGWiOxsJq
         CauJoa3Yf1pZUTEakHNJ+zd5IBf1pBg5zugamKD85bne6FdPPmqdkF7vHgivy2BvWa7N
         uBH213hYZhzNo5x1Wi8i9kWVJ5kiUvR/r9O3saUa4rNnJwM4SRjZArsnat9xa4hvCFlo
         3RkqoGbzd665ORklDxj6BHWjQjrk30BsaZa4LABT2sJ/a+k94VRH4SNFIyE/J+Rr8X0u
         Os358qLrdR0Sq+m6HzoHmBgNW5XKP922eUbfPP9HYq6VgwX984wzwy6pgenUdKdEocac
         2pgg==
X-Gm-Message-State: AOAM531++TUu8PS30UfA3WlFxmMUiJzZOqTWYgMiA0cfRTTfvBA5TXnz
        1XKrrBB2unvrw3qk1cIXVuSz8lY8ywc=
X-Google-Smtp-Source: ABdhPJxZj42MHITjsRyZzs2YUnE01cxtTnhJyxJzhfoYc52IJQPuyZEIF2g1C8EzpW3vJxYe/dRO4g==
X-Received: by 2002:a1f:930f:: with SMTP id v15mr1627717vkd.63.1594678676074;
        Mon, 13 Jul 2020 15:17:56 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id u22sm2209810vkb.19.2020.07.13.15.17.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 15:17:55 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id k7so7505641vso.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:54 -0700 (PDT)
X-Received: by 2002:a05:6102:30b5:: with SMTP id y21mr1130601vsd.42.1594678673804;
 Mon, 13 Jul 2020 15:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <1592818308-23001-1-git-send-email-mkshah@codeaurora.org> <1592818308-23001-3-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1592818308-23001-3-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Jul 2020 15:17:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WcKB0AbcYNymAbfvDac-8c3uGgOn3B1Q-U4d3ZrvGuag@mail.gmail.com>
Message-ID: <CAD=FV=WcKB0AbcYNymAbfvDac-8c3uGgOn3B1Q-U4d3ZrvGuag@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] pinctrl: qcom: Add msmgpio irqchip flags
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

On Mon, Jun 22, 2020 at 2:32 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Add irqchip specific flags for msmgpio irqchip to mask non wakeirqs
> during suspend and mask before setting irq type.
>
> Masking before changing type should make sure any spurious interrupt
> is not detected during this operation.
>
> Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 2419023..b909ffe 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1143,6 +1143,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>         pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
>         pctrl->irq_chip.irq_set_affinity = msm_gpio_irq_set_affinity;
>         pctrl->irq_chip.irq_set_vcpu_affinity = msm_gpio_irq_set_vcpu_affinity;
> +       pctrl->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND

I haven't tested it, but with my suggestion in patch #4 to use
irq_suspend and irq_resume, I presume adding IRQCHIP_MASK_ON_SUSPEND
is no longer needed?


> +                               | IRQCHIP_SET_TYPE_MASKED;

IIUC adding "IRQCHIP_SET_TYPE_MASKED" is unrelated to the rest of this
series, right?

-Doug
