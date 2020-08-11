Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2852C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFB820756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gjXSyPyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHKUEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKUEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:04:39 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B47C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:04:38 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a1so6654581vsp.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vF7UMROFE+dAJKvt4jRLzJ1y/Thu+BCzQUX/As3ZgXM=;
        b=gjXSyPyXZoPTlyrC5XR/K9JyfeE+I1aFx5WTng1nCFxKNi2DXwnibyuUdLyRZ/bzRz
         yNxYdmLEWKclEDlwLKm+mxedlq9DiWpV4FxLYj19eUGHv9Z7PWwO+cbkPuMA8qjPxdYp
         uZSF/mQuyDOMl+8Wy70Tl5CxdDML5f8yRR3GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vF7UMROFE+dAJKvt4jRLzJ1y/Thu+BCzQUX/As3ZgXM=;
        b=LVvgU6tOanrW6NmJI7/NpBLLzS+eQnH4qjIIJQeT95QpynctfNHGyMruT6b4God65D
         ezguf75hUXlVyR0IS4cvyCwYy4jHPRRMq5fWL2E115zB0QXxgkMTVQxwwO0Y0YYpTHpL
         4+atFH0OLEMSp7aIMvXshJDtlTDSFyLZqu5JCTHgHT7xuHRcInamoLONUB5HAwgJf2II
         /cSmSl2JYNJFFNY8t1WJP/i0Sbm4vpo0lY0VxGCEdUIJfH0O4RQ2VFczoyK1A94KPRFS
         qKnQoi6qJyx76VwF/+39OZqLIG0pP0tyROcj5Fw+IV9OZcFDk1eFWqnbsANvBIksHGCj
         WEPg==
X-Gm-Message-State: AOAM531MYSgDrrnVOLTOCRSVf2fuFiEpTyHJ9ZgQhU8VXcjdCMJBdV0T
        45HXGt41p8y1j3OBGgV7eKHba0bN5f0=
X-Google-Smtp-Source: ABdhPJzigjIqfGRIytLrDYvVLkQL2xvPAqVgs7TMLjXlxZrrbc/h0hjF4zgZcKeMN+FrPogyA8lEPQ==
X-Received: by 2002:a67:f893:: with SMTP id h19mr24923632vso.158.1597176276381;
        Tue, 11 Aug 2020 13:04:36 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id d9sm4391vko.15.2020.08.11.13.04.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 13:04:35 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id s81so10906vkb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:04:34 -0700 (PDT)
X-Received: by 2002:a1f:2fc1:: with SMTP id v184mr26376890vkv.42.1597176274522;
 Tue, 11 Aug 2020 13:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <1597058460-16211-1-git-send-email-mkshah@codeaurora.org> <1597058460-16211-2-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1597058460-16211-2-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 11 Aug 2020 13:04:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U4YVAqQXoJ47KY78kEsdoK33ic0P0rADkFWe=yU1x1nQ@mail.gmail.com>
Message-ID: <CAD=FV=U4YVAqQXoJ47KY78kEsdoK33ic0P0rADkFWe=yU1x1nQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] pinctrl: qcom: Add msmgpio irqchip flags
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

On Mon, Aug 10, 2020 at 4:21 AM Maulik Shah <mkshah@codeaurora.org> wrote:
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
> index a2567e7..90edf61 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1243,6 +1243,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>         pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
>         pctrl->irq_chip.irq_set_affinity = msm_gpio_irq_set_affinity;
>         pctrl->irq_chip.irq_set_vcpu_affinity = msm_gpio_irq_set_vcpu_affinity;
> +       pctrl->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND
> +                               | IRQCHIP_SET_TYPE_MASKED;
>
>         np = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
>         if (np) {

After taking Stephen's suggestion of improving the subject:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
